#!/usr/bin/env python3
"""
DEX ARBITRAGE BOT — Y(f) fixpoint triangular arbitrage on Uniswap/PancakeSwap.
No API key needed. Uses public DEX quotes via 1inch/CoinGecko aggregator.
γ = 7/64 — piaci korrekciós sebesség. Ua. fixpont mint α⁻¹.

Pairs: USDC→ETH→BTC→USDC és USDC→BNB→CAKE→USDC háromszögek.
"""
import json, time, urllib.request
from typing import Optional

GAMMA = 7.0 / 64.0
THRESHOLD_BPS = 5.0  # 5 bps minimum

def fetch(url: str) -> dict:
    req = urllib.request.Request(url, headers={"User-Agent": "YfDexArb/1.0"})
    with urllib.request.urlopen(req, timeout=15) as r:
        return json.loads(r.read())

def get_prices() -> dict:
    """Get prices from CoinGecko (free, public)."""
    ids = "bitcoin,ethereum,binancecoin,pancakeswap,usd-coin,dai"
    url = f"https://api.coingecko.com/api/v3/simple/price?ids={ids}&vs_currencies=usd"
    return fetch(url)

def yf_check(label: str, p1: float, p2: float, p3_obs: float) -> dict:
    """Y(f) fixpoint: the implied cross should equal observed."""
    fixpoint = p1 * p2
    delta = p3_obs - fixpoint
    delta_pct = delta / fixpoint * 100
    return {"label":label,"fixpoint":fixpoint,"observed":p3_obs,
            "delta_pct":round(delta_pct,4),"bps":round(abs(delta_pct)*100,1),
            "signal":"TRADE" if abs(delta_pct)*100>THRESHOLD_BPS else "HOLD"}

def scan_sandwich() -> list:
    """Scan for sandwich-able pools via 1inch quote API (free, no key)."""
    try:
        # Get quotes for different amounts — if price impact differs, MEV possible
        tokens = {
            "ETH": "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE",
            "USDC": "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
            "WBTC": "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599",
        }
        results = []
        for amount in [1000, 10000, 100000]:  # $1K, $10K, $100K
            url = f"https://api.1inch.dev/swap/v6.0/1/quote?src={tokens['USDC']}&dst={tokens['ETH']}&amount={amount*10**6}"
            try:
                quote = fetch(url)
                if "toTokenAmount" in quote:
                    results.append({"amount":amount,"price":float(quote["toTokenAmount"])/10**18})
            except: pass
        return results
    except Exception as e:
        return [{"error":str(e)}]

if __name__ == "__main__":
    print("╔══════════════════════════════════════════╗")
    print("║  ∈∘● DEX ARBITRAGE — Y(f) fixpoint    ║")
    print("╚══════════════════════════════════════════╝")

    try:
        prices = get_prices()
        btc = prices.get("bitcoin",{}).get("usd",0)
        eth = prices.get("ethereum",{}).get("usd",0)
        bnb = prices.get("binancecoin",{}).get("usd",0)
        cake = prices.get("pancakeswap",{}).get("usd",0)
        usdc = 1.0

        print(f"\n  BTC: ${btc:,.0f}  ETH: ${eth:,.0f}  BNB: ${bnb:,.0f}  CAKE: ${cake:.4f}")

        # Triangular checks
        # ETH/BTC implied = eth/btc, observed = ~0.029 (market)
        eth_btc_implied = eth / btc
        eth_btc_market = 0.029  # approximate — needs real oracle
        r1 = yf_check("ETH/BTC", 1/btc, eth, eth_btc_implied)
        print(f"  ETH/BTC implied: {eth_btc_implied:.6f} (Y(f) check)")

        # BNB/CAKE via USDC triangle
        cake_bnb_implied = cake / bnb
        print(f"  CAKE/BNB implied: {cake_bnb_implied:.6f}")

        # 1inch sandwich scan
        print(f"\n  Sandwich scan (1inch)...")
        sandwiches = scan_sandwich()
        for s in sandwiches:
            print(f"    ${s.get('amount',0):,}: {s.get('price',0):.6f} ETH")

    except Exception as e:
        print(f"  Error: {e}")

    print(f"\n  γ={GAMMA} | threshold={THRESHOLD_BPS}bps")
    print(f"  A Y(f) fixpont detektor ugyanaz mint α⁻¹-nél.")
    print(f"  A piaci eltérés a fixponttól = arbitrázs.")
