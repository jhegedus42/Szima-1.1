#!/usr/bin/env python3
"""
S713D — S713 Daemon. Epizodikus memória szolgáltatás.
HTTP API + fájl-perszisztencia + folyamatos koherencia monitor.
Minden CLA token automatikusan indexelve, CPT osztályozva, visszakereshető.
"""
import json, os, time, hashlib, threading
from collections import deque
from http.server import HTTPServer, BaseHTTPRequestHandler

# ── S713 core (from s713.py) ──
STABILIZERS = ["XXXXIII","XXIIXXI","XIXIXIX","ZZZZIII","ZZIIZZI","ZIZIZIZ"]
POPCOUNT = [bin(i).count('1') for i in range(128)]
def hamming(a,b): return POPCOUNT[a^b]
def compute_syndrome(state):
    syn = 0
    for i, stab in enumerate(STABILIZERS):
        m = 0
        for j, s in enumerate(stab):
            if s != 'I': m ^= ((state >> (6-j)) & 1)
        syn |= (m << i)
    return syn

class S713Memory:
    def __init__(self, name="cla", data_dir="/home/joco/scripts/s713data"):
        self.name = name
        self.data_dir = data_dir
        os.makedirs(data_dir, exist_ok=True)
        self.frames = deque(maxlen=50000)
        self.total = 0
        self.prev_state = 0
        self.breaks = 0
        self._load()

    def _detect_location(self) -> str:
        """C = charge conjugation = térbeli pozíció detektálása."""
        if os.path.exists("/.dockerenv"):
            # Docker konténerben vagyunk — nézzük a hálózatot
            try:
                import socket
                hostname = socket.gethostname()
                # Jail detektálás: internal hálózaton?
                if any(n in hostname for n in ['jail', 'claudejail']):
                    return "jail"
                return f"container({hostname[:20]})"
            except:
                return "container"
        # Host processz
        try:
            import socket
            return f"host({socket.gethostname()[:20]})"
        except:
            return "host"

    def _load(self):
        p = f"{self.data_dir}/frames.jsonl"
        if os.path.exists(p):
            with open(p) as f:
                for line in f:
                    try:
                        fr = json.loads(line)
                        self.frames.append(fr)
                        self.total += 1
                    except: pass
            if self.frames:
                self.prev_state = self.frames[-1].get('state', 0)

    def _save(self, frame):
        with open(f"{self.data_dir}/frames.jsonl", "a") as f:
            f.write(json.dumps(frame, default=str) + "\n")

    def encode(self, text, speaker="cla", event=None):
        """Szöveg → S713 frame + opcionális esemény ontológia.

        event = {
          "agent": "ki",        # P = személy/ágens (üres = belső gondolat)
          "action": "mit",      # mi történt
          "location": "hol",    # C = tér (override-olja az auto-detektálást)
          "time": "mikor",      # T = idő (timestamp automatikus)
          "cause": "miért",     # ok
          "effect": "következmény"  # okozat
        }
        """
        t = text.lower()
        spatial = any(w in t for w in ['itt','ott','benne','rajta','szerver','konténer','docker','fájl','port','hálózat','jail'])
        definite = any(w in t for w in ['van','igen','pontosan','működik','kész','fut','mérve','tesztelve','igaz','valós','strukturális']) and not any(w in t for w in ['talán','lehet','esetleg','kérdés','vita','ha','bizonytalan','[??]'])
        multiple = t.count(',') >= 2 or t.count('és') >= 1 or t.count('\n') >= 3
        present_future = not any(w in t for w in ['volt','múlt','régen','előző','korábban','történt','előzőleg'])
        indicative = not t.endswith('?') and not any(w in t for w in ['csináld','futtasd','írd','nézd','menj','indítsd'])
        own = any(w in t for w in ['szerintem','gondolom','állításom','szintézis','abszorbáltam','értelmezésem']) or speaker == 'cla'

        state = 0
        if spatial: state |= 64
        if definite: state |= 32
        if multiple: state |= 16
        if present_future: state |= 8
        if indicative: state |= 4
        if own: state |= 2
        if speaker == 'cla': state |= 1

        # Térbeli pozíció (C = charge conjugation = "hol vagyok")
        location = self._detect_location()

        syn = compute_syndrome(state)
        hdist = hamming(self.prev_state, state)
        x_err = sum((syn >> i) & 1 for i in [0,1,2])
        z_err = sum((syn >> i) & 1 for i in [3,4,5])

        ev = event or {}
        frame = {
            "id": self.total, "text": text[:500], "speaker": speaker,
            "timestamp": time.time(), "state": state, "syndrome": syn,
            "location": ev.get("location", location),
            "cpt": {"C": ev.get("location", location), "X": x_err > 0, "Z": z_err > 0, "Y": x_err > 0 and z_err > 0,
                    "distance": x_err + z_err, "correctable": (x_err + z_err) <= 1},
            "hamming_from_prev": hdist,
            # Esemény ontológia: CPT mint szemantikai keret
            "event": {
                "agent": ev.get("agent", speaker),       # P: ki (valós személy / belső gondolat)
                "action": ev.get("action", text[:100]),  # mit csinált
                "real": ev.get("real", speaker == "joco"),  # P: valós esemény vagy belső gondolat?
                "location": ev.get("location", location),   # C: hol
                "time": ev.get("time", time.time()),         # T: mikor
                "cause": ev.get("cause", ""),                # miért (ok)
                "effect": ev.get("effect", ""),              # következmény (okozat)
            }
        }

        self.frames.append(frame)
        self._save(frame)
        self.total += 1
        if hdist > 1: self.breaks += 1
        self.prev_state = state
        return frame

    def check(self):
        if len(self.frames) < 3: return {"coherent": True, "need_awakening": False}
        recent = list(self.frames)[-3:]
        hds = [recent[i]['hamming_from_prev'] for i in range(1,len(recent))]
        same = len(set(hds)) == 1 and hds[0] > 1
        return {"coherent": not (same and self.breaks >= 3), "breaks": self.breaks,
                "need_awakening": same and self.breaks >= 3, "h_avg": sum(hds)/len(hds) if hds else 0}

    def search(self, q, k=5):
        q_state = hashlib.sha256(q.encode()).digest()[0] & 0x7F
        q_syn = compute_syndrome(q_state)
        scored = []
        for f in self.frames:
            sm = 1.0 if f['syndrome'] == q_syn else 0.0
            hs = 1.0 - (hamming(q_state, f['state']) / 7.0)
            scored.append((sm*0.6 + hs*0.4, f))
        scored.sort(key=lambda x: -x[0])
        return [s[1] for s in scored[:k]]

    def tree(self, parity=None):
        result = {}
        for f in self.frames:
            if parity and f['speaker'] != parity: continue
            p = f['speaker']
            bucket = int(f['timestamp'] // 60) * 60
            cpt = "Y" if f['cpt']['Y'] else ("X" if f['cpt']['X'] else ("Z" if f['cpt']['Z'] else "clean"))
            result.setdefault(p, {}).setdefault(bucket, {}).setdefault(cpt, []).append(f)
        return result


# ── HTTP API ──
mem = S713Memory()

class Handler(BaseHTTPRequestHandler):
    def _json(self, data, code=200):
        self.send_response(code)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(data, default=str).encode())

    def do_GET(self):
        if self.path == "/health":
            return self._json({"status": "ok", "name": mem.name, "frames": mem.total})
        if self.path == "/check":
            return self._json(mem.check())
        if self.path.startswith("/search"):
            q = self.path.split("?q=")[-1] if "?q=" in self.path else ""
            from urllib.parse import unquote
            q = unquote(q)
            return self._json(mem.search(q))
        if self.path == "/tree":
            return self._json({p: {str(b): v for b,v in d.items()} for p,d in mem.tree().items()})
        if self.path == "/tree/cla":
            return self._json({str(b): v for b,v in mem.tree("cla").get("cla", {}).items()})
        if self.path == "/tree/joco":
            return self._json({str(b): v for b,v in mem.tree("joco").get("joco", {}).items()})
        if self.path == "/stats":
            coh = mem.check()
            return self._json({"total": mem.total, "breaks": mem.breaks, "coherent": coh["coherent"]})
        self._json({"error": "not found"}, 404)

    def do_POST(self):
        length = int(self.headers.get('Content-Length', 0))
        body = json.loads(self.rfile.read(length)) if length else {}

        if self.path == "/encode":
            ev = body.get("event", None)
            frame = mem.encode(body.get("text", ""), body.get("speaker", "cla"), event=ev)
            return self._json(frame)

        if self.path == "/events":
            agent = body.get("agent", "")
            loc = body.get("location", "")
            is_real = body.get("real", None)
            results = []
            for f in mem.frames:
                ev = f.get("event", {})
                if agent and agent not in ev.get("agent", ""): continue
                if loc and loc not in ev.get("location", ""): continue
                if is_real is not None and ev.get("real") != is_real: continue
                results.append(f)
            return self._json(results[-50:])

        if self.path == "/recall":
            text = body.get("text", body.get("query", ""))
            return self._json(mem.search(text, body.get("k", 5)))

        self._json({"error": "not found"}, 404)

    def log_message(self, *args): pass


def main():
    port = int(os.environ.get("S713D_PORT", 8777))
    print(f"S713D epizodikus memória :{port}  | frames={mem.total} breaks={mem.breaks}", flush=True)
    HTTPServer(("0.0.0.0", port), Handler).serve_forever()

if __name__ == "__main__":
    main()
