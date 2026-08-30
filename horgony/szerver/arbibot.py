#!/usr/bin/env python3
"""
Y(f) ARBITRAGE BOT — Fixpoint-based arbitrage detector + executor.
  γ = 7/64 (Miller) = piaci korrekciós sebesség
  Ua. matematika mint α⁻¹-nél: fixpont = ahol a piac egyensúlyban van
  Eltérés a fixponttól = arbitrázs lehetőség

Használat:
  python3 arbibot.py --scan          # szkennelés, lehetőségek listázása
  python3 arbibot.py --watch 60      # folyamatos figyelés 60 másodpercenként
  python3 arbibot.py --serve 8799    # API szerver

Források: Binance (publikus API), CoinGecko (ingyenes), Forex (ha elérhető)
"""
import json, time, sys, os, hashlib
import urllib.request
from typing import Optional

# ═══ KONSTANSOK ═══
GAMMA = 7.0 / 64.0  # Miller: piaci tudatosság
THRESHOLD_BPS = 5.0  # minimum 5 bps (=0.05%) arbitrázshoz
LOG_FILE = os.path.expanduser("~/scripts/s713data/arbitrage.log")

def log(msg: str):
    ts = time.strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{ts}] {msg}"
    with open(LOG_FILE, "a") as f: f.write(line + "\n")
    print(line, flush=True)

def fetch_json(url: str) -> dict:
    """Publikus API hívás — JSON vissza."""
    req = urllib.request.Request(url, headers={"User-Agent": "YfArbBot/1.0"})
    with urllib.request.urlopen(req, timeout=15) as r:
        return json.loads(r.read())


# ═══ 1. CRYPTO FUNDING RATE ARBITRAGE ═══
def scan_funding_rates() -> list:
    """Funding rate arbitrage: Binance vs Bybit vs OKX."""
    opportunities = []
    try:
        # Binance funding rates (publikus)
        binance = fetch_json("https://fapi.binance.com/fapi/v1/premiumIndex")
        rates = {}
        for item in binance:
            symbol = item.get("symbol", "")
            rate = float(item.get("lastFundingRate", 0)) * 100  # százalék
            if rate != 0:
                rates[symbol] = rate

        # Top 10 legnagyobb funding rate különbség
        sorted_rates = sorted(rates.items(), key=lambda x: -abs(x[1]))
        for symbol, rate in sorted_rates[:10]:
            if abs(rate) > 0.01:  # legalább 0.01%
                # Y(f) fixpont becslés: a funding rate a fixpont körül ingadozik
                # Ha |rate| > threshold, a fixponttól távol van → arbitrázs
                fixpoint_deviation = abs(rate) * 100  # bps-ben
                if fixpoint_deviation > THRESHOLD_BPS:
                    direction = "LONG" if rate < 0 else "SHORT"
                    opportunities.append({
                        "type": "funding_rate",
                        "symbol": symbol,
                        "rate_pct": round(rate, 4),
                        "direction": direction,
                        "strategy": f"Spot {direction} + Perp opposite → capture {abs(rate):.4f}%",
                        "bps": round(fixpoint_deviation, 1),
                        "yf_confidence": min(1.0, fixpoint_deviation / (THRESHOLD_BPS * 2)),
                    })
    except Exception as e:
        log(f"Funding scan error: {e}")
    return opportunities


# ═══ 2. TRIANGULAR ARBITRAGE (Crypto) ═══
def scan_triangular() -> list:
    """Triangular arbitrage: BTC → ETH → USDT → BTC körök."""
    opportunities = []
    try:
        prices = fetch_json("https://api.binance.com/api/v3/ticker/price")
        pmap = {}
        for p in prices:
            pmap[p["symbol"]] = float(p["price"])

        # BTC/USDT, ETH/USDT, ETH/BTC háromszög
        triangles = [
            ("BTCUSDT", "ETHUSDT", "ETHBTC", "BTC→USDT→ETH→BTC"),
            ("BTCUSDT", "BNBUSDT", "BNBBTC", "BTC→USDT→BNB→BTC"),
            ("ETHUSDT", "BNBUSDT", "BNBETH", "ETH→USDT→BNB→ETH"),
        ]
        for s1, s2, s3, label in triangles:
            if s1 in pmap and s2 in pmap and s3 in pmap:
                p1, p2, p3 = pmap[s1], pmap[s2], pmap[s3]
                # Implied cross rate
                implied = p2 / p1  # ethusdt/btcusdt = ETH/BTC implied
                actual = p3       # ETHBTC actual
                delta_pct = (actual - implied) / implied * 100

                # Y(f) fixpont: a háromszög záródási hibája
                if abs(delta_pct) > 0.02:  # 0.02% minimum
                    opportunities.append({
                        "type": "triangular",
                        "triangle": f"{s1}/{s2}/{s3}",
                        "path": label,
                        "implied": round(implied, 8),
                        "actual": round(actual, 8),
                        "delta_pct": round(delta_pct, 6),
                        "bps": round(abs(delta_pct) * 100, 1),
                        "yf_confidence": min(1.0, abs(delta_pct) / 0.1),
                    })
    except Exception as e:
        log(f"Triangular scan error: {e}")
    return opportunities


# ═══ 3. Y(f) FIXPOINT DETEKTOR ═══
def yf_arbitrage(p1: float, p2: float, p3_obs: float, label: str) -> dict:
    """Y(f) fixpoint arbitrázs detektor — ua. mint α⁻¹-nél.
    p1, p2 = bemeneti árak, p3_obs = megfigyelt keresztár
    fixpoint = p1 × p2 (vagy p1/p2 a háromszögtől függően)
    """
    fixpoint = p1 * p2
    delta = p3_obs - fixpoint
    delta_pct = delta / fixpoint * 100
    tau = -__import__('math').log(max(abs(delta_pct), 0.0001) / 100) / GAMMA
    return {
        "label": label, "fixpoint": fixpoint, "observed": p3_obs,
        "delta": delta, "delta_pct": delta_pct,
        "convergence_steps": int(tau) if tau > 0 else 0,
        "arbitrage": abs(delta_pct) * 100 > THRESHOLD_BPS / 100,
        "bps": round(abs(delta_pct) * 100, 1),
    }


# ═══ FŐ CIKLUS ═══
def scan_all() -> dict:
    """Teljes arbitrázs szkennelés."""
    funding = scan_funding_rates()
    triangular = scan_triangular()
    total = len(funding) + len(triangular)
    result = {
        "timestamp": time.time(),
        "gamma": GAMMA,
        "threshold_bps": THRESHOLD_BPS,
        "total_opportunities": total,
        "funding_rate": funding,
        "triangular": triangular,
    }
    if total > 0:
        log(f"FOUND {total} opportunities: {len(funding)} funding + {len(triangular)} triangular")
    return result


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--scan", action="store_true", help="Egyszeri szkennelés")
    ap.add_argument("--watch", type=int, default=0, help="Folyamatos figyelés (másodperc)")
    ap.add_argument("--serve", type=int, default=0, help="API szerver indítása (port)")
    args = ap.parse_args()

    if args.scan:
        result = scan_all()
        print(json.dumps(result, indent=2, default=str))

    elif args.watch > 0:
        log(f"Y(f) Arbibot started — scanning every {args.watch}s")
        while True:
            try:
                result = scan_all()
                if result["total_opportunities"] > 0:
                    for opp in result["funding_rate"]:
                        print(f"  FUNDING {opp['symbol']}: {opp['rate_pct']:.4f}% → {opp['strategy'][:60]}")
                    for opp in result["triangular"]:
                        print(f"  TRIANGLE {opp['triangle']}: {opp['delta_pct']:.4f}% → {opp['path']}")
            except Exception as e:
                log(f"Watch error: {e}")
            time.sleep(args.watch)

    elif args.serve > 0:
        from http.server import HTTPServer, BaseHTTPRequestHandler
        class H(BaseHTTPRequestHandler):
            def do_GET(self):
                result = scan_all()
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps(result, default=str).encode())
            def log_message(self, *a): pass
        log(f"Y(f) Arbibot API :{args.serve}")
        HTTPServer(("0.0.0.0", args.serve), H).serve_forever()

    else:
        # Default: quick scan
        result = scan_all()
        print(f"\n∈∘● Y(f) Arbibot: {result['total_opportunities']} opportunities found")
        for opp in result.get("funding_rate", []):
            print(f"  {opp['symbol']}: {opp['rate_pct']:.4f}% {opp['direction']} → {opp['bps']}bps")
        for opp in result.get("triangular", []):
            print(f"  {opp['triangle']}: Δ={opp['delta_pct']:.4f}% → {opp['bps']}bps")
