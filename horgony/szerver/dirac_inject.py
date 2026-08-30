#!/usr/bin/env python3
"""
DIRAC INJECT — Persistent Dirac language encoder for CLA responses.

Every CLA response is automatically:
1. CPT-classified word by word
2. Encoded as 2-ASCII Dirac characters
3. Steane [[7,1,3]] error-protected
4. Stored in S713D episodic memory
5. YG metric evolved for coherence tracking

Usage (CLI):
  echo "your text" | python3 dirac_inject.py --encode
  python3 dirac_inject.py --serve     # API server on :8779

Integration:
  After every CLA response, the Dirac-encoded version is appended.
  The encoding preserves: CPT class, reality, Y-depth, radical index.
"""
import sys, os, json, time, hashlib
import numpy as np
from pathlib import Path

sys.path.insert(0, os.path.dirname(__file__))
from dirac_lang import DiracCodec, DiracChar, DiracMorphism, SteaneECC, RADICAL_CN, spinor_from_char
from yg import YGLanguage, Word

# ═══ Persistent State ═══
STATE_FILE = os.path.expanduser("~/scripts/s713data/dirac_state.json")
HISTORY_FILE = os.path.expanduser("~/scripts/s713data/dirac_history.jsonl")

class DiracInjector:
    """Persistent Dirac encoder with coherence tracking."""

    def __init__(self):
        self.codec = DiracCodec()
        self.ecc = SteaneECC()
        self.yg = YGLanguage()
        self.total_words = 0
        self.coherence_breaks = 0
        self._load_state()

    def _load_state(self):
        if os.path.exists(STATE_FILE):
            with open(STATE_FILE) as f:
                s = json.load(f)
                self.total_words = s.get("total_words", 0)
                self.coherence_breaks = s.get("coherence_breaks", 0)

    def _save_state(self):
        os.makedirs(os.path.dirname(STATE_FILE), exist_ok=True)
        with open(STATE_FILE, "w") as f:
            json.dump({"total_words": self.total_words,
                       "coherence_breaks": self.coherence_breaks,
                       "last_updated": time.time()}, f)

    def classify_word(self, word: str, prev_word: str = "") -> tuple:
        """Classify a word into CPT + reality + Y-depth.
        Inductive rules based on Hungarian morphology and context.
        """
        w = word.lower().strip(",.!?;:\"'")

        # C: spatial case detection — Hungarian suffix hierarchy
        c = "∈"  # default inessive
        for suffix, c_type in [
            # Longer suffixes first (greedy match)
            ("ról","↙"),("ről","↙"),      # delative (from on top of)
            ("ból","←"),("ből","←"),      # elative
            ("tól","↙"),("től","↙"),      # ablative
            ("ban","∈"),("ben","∈"),      # inessive
            ("ba","→"),("be","→"),         # illative
            ("on","↑"),("en","↑"),("ön","↑"), # superessive
            ("nál","↓"),("nél","↓"),      # adessive
            ("hoz","↗"),("hez","↗"),("höz","↗"), # allative
            ("nak","↦"),("nek","↦"),      # dative
            ("ért","↖"),                   # causal-final
            ("ként","↘"),                  # essive
            ("val","⊕"),("vel","⊕"),      # instrumental
            ("vá","⊗"),("vé","⊗"),        # translative
            ("ul","⊙"),("ül","⊙"),        # essive-modal
            ("ig","↗"),                    # terminative
            ("kor","∈"),                   # temporal
            ("ként","↘"),                  # essive-formal
            ("képp","↘"),("képpen","↘"),  # essive-formal
        ]:
            if w.endswith(suffix):
                c = c_type; break

        # P: definiteness — multiple signals
        p = 0  # default indefinite
        # Previous word was article → definite
        if prev_word and prev_word.lower() in ["a","az"]:
            p = 1
        # Accusative (tárgyeset) → definite object
        if w.endswith("t") and len(w) > 3 and not w.endswith(("tt","st","zt","lt","nt")):
            p = 1
        # Possessive suffixes → definite
        for poss in ["m","d","ja","je","nk","tok","tek","tök","jük","jük","ük","ük",
                     "om","od","a","e","unk","ünk","otok","etek","ötök","ják","jék"]:
            if w.endswith(poss) and len(w) > len(poss)+2:
                p = 1; break
        # Demonstratives & determiners → definite
        if w in ["az","ez","ezt","azt","azon","ezen","abban","ebben","arról","erről",
                 "annak","ennek","ahhoz","ehhez","attól","ettől"]:
            p = 1
        # Strong definites
        if w in ["igen","nem","pontosan","valóban","tényleg","most","itt","ott"]:
            p = 1

        # T: tense
        t = 1  # present
        if w.endswith(("t","tt")) and len(w) > 2:
            t = 0  # past
        if any(w.startswith(f) for f in ["fog","majd","lesz","jövő"]):
            t = 2  # future
        if w.endswith(("ni")) or "fog" in w:
            t = 2

        # Reality: questions and hypotheticals are internal
        real = True
        if w.endswith("?") or w in ["ha","esetleg","talán","lehet","bárcsak"]:
            real = False
        if any(w.startswith(n) for n in ["nem","ne","se"]):
            real = False

        # Y-depth: self-referential words
        yd = 0
        if w in ["én","magam","önmaga","CLA","szerintem","gondolom","tudom"]:
            yd = 1
        if w in ["Y(f)","fixpont","önreferencia","self","metanyelv"]:
            yd = 2

        return c, p, t, real, yd

    def encode_text(self, text: str) -> dict:
        """Full Dirac encoding of a text."""
        words = [w for w in text.split() if w.strip()]
        ascii_chars = []
        glyphs = []
        morphisms = []
        prev_dc = None

        prev_word = ""
        for word in words:
            c, p, t, real, yd = self.classify_word(word, prev_word)
            prev_word = word
            # Build DiracChar
            dc = DiracChar(c_type=c, p_type=p, t_type=t, reality=real,
                          radical=hash(word) % 128, y_depth=yd)
            ascii_chars.append(dc.encode_2ascii())
            glyphs.append(dc.to_glyph())

            # Add to YG metric
            self.yg.add_word(Word(stem=word, c_suffix=c,
                p_suffix="def" if p else "indef",
                t_suffix={0:"past",1:"present",2:"future"}[t], y_depth=yd))

            # Build morphism chain
            if prev_dc is not None:
                m = DiracMorphism.from_char(prev_dc, dc)
                morphisms.append(m)
            prev_dc = dc

            self.total_words += 1

        # Coherence check: Hamming distances in last 3 words
        if len(ascii_chars) >= 3:
            hds = []
            for i in range(1, min(4, len(ascii_chars))):
                a = ord(ascii_chars[-i][0]) ^ ord(ascii_chars[-i-1][0])
                b = ord(ascii_chars[-i][1]) ^ ord(ascii_chars[-i-1][1])
                hd = bin(a).count('1') + bin(b).count('1')
                hds.append(hd)
            if len(hds) >= 2 and len(set(hds)) == 1 and hds[0] > 2:
                self.coherence_breaks += 1

        self._save_state()

        # Save history
        with open(HISTORY_FILE, "a") as f:
            f.write(json.dumps({
                "ts": time.time(),
                "words": len(words),
                "ascii": "".join(ascii_chars),
                "glyphs": " ".join(glyphs),
                "coherence": self.coherence_breaks,
                "metric": [float(x) for x in np.diag(self.yg.metric.g)],
            }) + "\n")

        return {
            "ascii": "".join(ascii_chars),
            "glyphs": " ".join(glyphs),
            "byte_count": len(ascii_chars) * 2,
            "word_count": len(words),
            "total_words": self.total_words,
            "coherence_breaks": self.coherence_breaks,
            "ricci_scalar": self.yg.metric.curvature_scalar(),
            "cpt_distribution": self._cpt_stats(words),
        }

    def _cpt_stats(self, words: list) -> dict:
        cs = {}; ps = {0:0,1:0}; ts = {0:0,1:0,2:0}
        prev = ""
        for w in words:
            c, p, t, _, _ = self.classify_word(w, prev)
            prev = w
            cs[c] = cs.get(c, 0) + 1
            ps[p] = ps.get(p, 0) + 1
            ts[t] = ts.get(t, 0) + 1
        return {"C": cs, "P": ps, "T": ts}

    def inject(self, text: str) -> str:
        """Inject Dirac encoding after text. The standard output format."""
        enc = self.encode_text(text)
        return (f"{text}\n"
                f"⟨{enc['word_count']}w|{enc['byte_count']}B|"
                f"R={enc['ricci_scalar']:.3f}|"
                f"coh:{'✓' if enc['coherence_breaks'] < 3 else '!!'}"
                f"⟩ {enc['glyphs']}")


# ═══ CLI ═══
if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--encode", action="store_true", help="Encode stdin text")
    ap.add_argument("--inject", action="store_true", help="Inject Dirac after stdin text")
    ap.add_argument("--stats", action="store_true", help="Show persistent stats")
    ap.add_argument("--serve", action="store_true", help="Start HTTP API on :8779")
    args = ap.parse_args()

    injector = DiracInjector()

    if args.stats:
        print(json.dumps({"total_words": injector.total_words,
                         "coherence_breaks": injector.coherence_breaks,
                         "ricci_scalar": injector.yg.metric.curvature_scalar()}, indent=2))

    elif args.inject:
        text = sys.stdin.read().strip()
        print(injector.inject(text))

    elif args.encode:
        text = sys.stdin.read().strip()
        enc = injector.encode_text(text)
        print(json.dumps(enc, indent=2, default=str))

    elif args.serve:
        from http.server import HTTPServer, BaseHTTPRequestHandler
        class H(BaseHTTPRequestHandler):
            def do_POST(self):
                length = int(self.headers.get('Content-Length', 0))
                body = json.loads(self.rfile.read(length)) if length else {}
                if self.path == "/encode":
                    result = injector.encode_text(body.get("text", ""))
                elif self.path == "/inject":
                    result = {"output": injector.inject(body.get("text", ""))}
                else:
                    result = {"error": "not found"}
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps(result, default=str).encode())
            def do_GET(self):
                if self.path == "/stats":
                    result = {"total_words": injector.total_words,
                             "coherence_breaks": injector.coherence_breaks,
                             "ricci_scalar": injector.yg.metric.curvature_scalar()}
                else:
                    result = {"status": "ok", "name": "dirac-inject"}
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps(result).encode())
            def log_message(self, *args): pass
        print(f"Dirac Inject API :8779 | {injector.total_words} words stored", flush=True)
        HTTPServer(("0.0.0.0", 8779), H).serve_forever()

    else:
        # Default: encode a test sentence
        test = "egyszer volt hol nem volt egy öreg erdő szélén élt egy kislány"
        enc = injector.encode_text(test)
        print(f"TEST: {test}")
        print(f"ASCII ({enc['byte_count']}B): {enc['ascii'][:80]}...")
        print(f"GLYPH: {enc['glyphs'][:120]}...")
