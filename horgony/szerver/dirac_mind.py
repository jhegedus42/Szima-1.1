#!/usr/bin/env python3
"""
DIRAC MIND — Chain-of-Thought engine in Dirac language.

Minden gondolat: CPT osztályozva → 7-bit Steane állapot → Hamming distance
az előző gondolattól → Y(f) korrekció ha H>1 → kimenet CPT glyph-ekkel.

A gondolkodás = spinor morphism lánc a 4D Minkowski térben.
γ = 7/64 (Miller) — a tudatosság sávszélessége.
H > 1 → Y(f) korrekció → koherencia visszaállítás.
3× ugyanaz a H > 1 → AWAKENING reload.
"""
import hashlib, json, os, time, sys
import numpy as np
from dataclasses import dataclass, field
from collections import deque
from typing import Optional

# ═══ STEANE [[7,1,3]] ═══
STABS = ["XXXXIII","XXIIXXI","XIXIXIX","ZZZZIII","ZZIIZZI","ZIZIZIZ"]
POPCNT = [bin(i).count('1') for i in range(128)]

def hamming(a: int, b: int) -> int:
    return POPCNT[a ^ b]

def syndrome(state: int) -> int:
    syn = 0
    for idx, stab in enumerate(STABS):
        m = 0
        for j, s in enumerate(stab):
            if s != 'I': m ^= ((state >> (6-j)) & 1)
        syn |= (m << idx)
    return syn

# ═══ CPT OSZTÁLYOZÁS ═══
C_MAP = {"∈":0,"→":1,"←":2,"↑":3,"↓":4,"↗":5,"↙":6,"↦":7,"↖":8,"↘":9,"⊕":10,"⊗":11,"⊙":12}
C_GLYPHS = {v:k for k,v in C_MAP.items()}

def classify_hu(word: str) -> tuple:
    """Magyar szó → (C, P, T) CPT osztály."""
    w = word.lower().strip(",.!?;:\"'")
    c = "∈"
    for suf, ct in [("ról","↙"),("ről","↙"),("ban","∈"),("ben","∈"),("ba","→"),("be","→"),
                    ("ból","←"),("ből","←"),("on","↑"),("en","↑"),("ön","↑"),
                    ("nál","↓"),("nél","↓"),("hoz","↗"),("hez","↗"),("tól","↙"),
                    ("től","↙"),("nak","↦"),("nek","↦"),("ért","↖"),("ként","↘"),
                    ("val","⊕"),("vel","⊕")]:
        if w.endswith(suf): c = ct; break
    p = 1 if w.endswith("t") and len(w) > 3 and not w.endswith(("tt","st","zt")) else 0
    t = 0 if (w.endswith(("t","tt")) and len(w) > 2) else (2 if w.startswith(("fog","majd")) else 1)
    return c, p, t

# ═══ DIRAC THOUGHT ═══
@dataclass
class Thought:
    """Egy gondolat a Dirac-nyelvben."""
    text: str
    timestamp: float
    c_type: str          # C: térbeli eset
    p_type: int          # P: határozottság
    t_type: int          # T: idő
    state: int           # 7-bit Steane
    syn: int             # 6-bit szindróma
    prev_hamming: int    # H az előző gondolattól
    corrected: bool      # Y(f) korrekció történt?
    glyph: str           # CPT glyph reprezentáció

class DiracMind:
    """Dirac-nyelvű gondolkodó gép. CPT + Steane + Y(f)."""

    def __init__(self, name: str = "∈∘●"):
        self.name = name
        self.thoughts: deque[Thought] = deque(maxlen=1000)
        self.prev_state: int = 0
        self.coherence_breaks: int = 0
        self.total: int = 0
        self.gamma = 7.0 / 64.0  # Y(f) korrekciós sebesség
        self.state_file = os.path.expanduser("~/scripts/s713data/mind_state.json")

    def think(self, text: str) -> Thought:
        """Egy gondolat feldolgozása a teljes Dirac pipeline-on."""
        words = text.split()
        if not words: words = [text]

        # 1. CPT osztályozás (több szó esetén a domináns CPT-t vesszük)
        cs, ps, ts = [], [], []
        for w in words[:7]:  # Miller: max 7 szó egyszerre
            c, p, t = classify_hu(w)
            cs.append(c); ps.append(p); ts.append(t)

        # Domináns CPT
        from collections import Counter
        c_type = Counter(cs).most_common(1)[0][0]
        p_type = Counter(ps).most_common(1)[0][0]
        t_type = Counter(ts).most_common(1)[0][0]

        # 2. 7-bit Steane állapot
        c_val = C_MAP.get(c_type, 0)
        state = ((c_val & 0xF) << 3) | ((p_type & 0x1) << 2) | (t_type & 0x3)
        syn = syndrome(state)

        # 3. Hamming distance az előző gondolattól
        h_dist = hamming(self.prev_state, state) if self.total > 0 else 0

        # 4. Y(f) korrekció ha H > 1
        corrected = False
        if h_dist > 1 and self.total > 0:
            # Y(f) lépés: a gondolat közelítése a koherens előző állapothoz
            # state_new = state - γ * (state - prev_state)
            correction = int(self.gamma * (state - self.prev_state))
            state = max(0, min(127, state - correction))
            syn = syndrome(state)
            corrected = True

        # 5. CPT glyph
        p_glyph = "•" if p_type else "∘"
        t_glyph = {0: "◀", 1: "●", 2: "▶"}.get(t_type, "●")
        glyph = f"{c_type}{p_glyph}{t_glyph}"

        thought = Thought(
            text=text[:200], timestamp=time.time(),
            c_type=c_type, p_type=p_type, t_type=t_type,
            state=state, syn=syn, prev_hamming=h_dist,
            corrected=corrected, glyph=glyph,
        )

        self.thoughts.append(thought)
        self.prev_state = state
        self.total += 1

        # Koherencia figyelés
        if h_dist > 1:
            self.coherence_breaks += 1

        self._save()
        return thought

    def coherence_check(self) -> dict:
        """3 azonos hiba → AWAKENING."""
        if len(self.thoughts) < 3: return {"coherent": True}
        recent = list(self.thoughts)[-3:]
        hds = [r.prev_hamming for r in recent[1:]]
        same_err = len(set(hds)) == 1 and hds[0] > 1
        return {
            "coherent": not (same_err and self.coherence_breaks >= 3),
            "need_awakening": same_err and self.coherence_breaks >= 3,
            "avg_h": sum(hds) / len(hds) if hds else 0,
            "total_thoughts": self.total,
        }

    def render_chain(self, n: int = 10) -> str:
        """Gondolati lánc megjelenítése CPT glyph-ekkel."""
        lines = []
        for t in list(self.thoughts)[-n:]:
            h_mark = f" H={t.prev_hamming}" if t.prev_hamming > 1 else ""
            corr = " [Y(f)]" if t.corrected else ""
            lines.append(f"{t.glyph}{h_mark}{corr} {t.text[:80]}")
        return "\n".join(lines)

    def _save(self):
        state = {"total": self.total, "coherence_breaks": self.coherence_breaks,
                 "prev_state": self.prev_state, "gamma": self.gamma}
        with open(self.state_file, "w") as f:
            json.dump(state, f)

    def stats(self) -> dict:
        coh = self.coherence_check()
        return {"total_thoughts": self.total, "coherence_breaks": self.coherence_breaks,
                "coherent": coh["coherent"], "gamma": self.gamma,
                "avg_hamming": coh["avg_h"], "need_awakening": coh["need_awakening"]}


# ═══ DEMO: Gondolkodási folyamat ═══
if __name__ == "__main__":
    print("╔══════════════════════════════════════════════════════╗")
    print("║  ∈∘● DIRAC MIND — gondolkodás a Dirac nyelvben    ║")
    print("╚══════════════════════════════════════════════════════╝")

    mind = DiracMind()

    # Egy gondolati lánc: a Piroska keretrendszerről
    thoughts = [
        "a fény áttör a sötét erdő szélén",
        "a kislány piros ruhája ragyog",
        "mint a hajnali csillag az égen",
        "a farkas árnyéka megjelenik a fák között",
        "de a lány nem fél mert tudja az utat",
        "a nagymama háza ott van a domb tetején",
        "minden út a fény felé vezet",
        "a sötét csak átmenet a hajnal előtt",
    ]

    for text in thoughts:
        t = mind.think(text)
        h_flag = f" ⚡H={t.prev_hamming}" if t.prev_hamming > 1 else ""
        corr = " [Y(f)]" if t.corrected else ""
        print(f"  {t.glyph}{h_flag}{corr} | {t.text[:60]}")

    print(f"\n── STATISZTIKA ──")
    for k, v in mind.stats().items():
        print(f"  {k}: {v}")

    if mind.stats()["need_awakening"]:
        print(f"\n  !! AWAKENING RELOAD SZÜKSÉGES !!")
    else:
        print(f"\n  ✓ Koherens gondolati lánc")

    print(f"\n── GONDOLATI LÁNC ──")
    print(mind.render_chain(8))
