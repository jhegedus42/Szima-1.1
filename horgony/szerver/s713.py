#!/usr/bin/env python3
"""
S713 — Steane [[7,1,3]] token encoder + coherent memory.

Minden kimondott szó kap egy 7-bites szindróma-vektort (CPT osztályozás),
egy paritás bitet (én ⇔ te), és egy Hamming-távolságot az előző állapottól.
A Hamming > 1 → koherencia-törés → AWAKENING reload trigger.

A kimenet: szöveg + párhuzamos index + asszociációs lánc.
"""
import json, hashlib, os, time
from collections import deque
from dataclasses import dataclass, field
from typing import Optional

# ── Steane [[7,1,3]] stabilizátorok ──
# 6 generátor, mind súly 4, páronkénti átfedés 2
STABILIZERS = [
    "XXXXIII",  # g1: vowel/space = X on q1,q2,q3,q4
    "XXIIXXI",  # g2: definiteness = X on q1,q2,q5,q6
    "XIXIXIX",  # g3: number = X on q1,q3,q5,q7
    "ZZZZIII",  # g4: tense/time = Z on q1,q2,q3,q4
    "ZZIIZZI",  # g5: mood = Z on q1,q2,q5,q6
    "ZIZIZIZ",  # g6: possession = Z on q1,q3,q5,q7
]

# CPT = g1⊕g4⊕g6 = 100101₂ = 37
CPT_MASK = 0b100101

# X-stabilizátorok: g1,g2,g3 (bit flip = ténybeli hiba)
# Z-stabilizátorok: g4,g5,g6 (fázis = időbeli hiba)
X_GENERATORS = [0, 1, 2]  # g1,g2,g3
Z_GENERATORS = [3, 4, 5]  # g4,g5,g6

# Hamming súly tábla 0..127 között
POPCOUNT = [bin(i).count('1') for i in range(128)]


def hamming(a: int, b: int) -> int:
    """Hamming távolság két 7-bites kód között."""
    return POPCOUNT[a ^ b]


def compute_syndrome(state: int) -> int:
    """6-bites szindróma: minden stabilizátor mérése (±1 → 0/1 bit)."""
    syn = 0
    for i, stab in enumerate(STABILIZERS):
        # Stabilizátor mérése: ∑ (state_bit ⊕ stabilizátor_bit) mod 2
        # Stabilizátor aktív ha a mérés eredménye -1 (bit=1)
        measure = 0
        for j, s in enumerate(stab):
            if s != 'I':
                measure ^= ((state >> (6 - j)) & 1)
        syn |= (measure << i)
    return syn


def syndrome_to_cpt(syndrome: int) -> dict:
    """Szindróma → {X_error, Z_error, Y_error, C, P, T}."""
    x_err = sum((syndrome >> i) & 1 for i in X_GENERATORS)  # X hiba bitszáma
    z_err = sum((syndrome >> i) & 1 for i in Z_GENERATORS)  # Z hiba bitszáma
    return {
        "X": x_err > 0,        # ténybeli hiba (C)
        "Z": z_err > 0,        # időbeli hiba (P)
        "Y": x_err > 0 and z_err > 0,  # mindkettő egyszerre (T)
        "C_bit": x_err,
        "P_bit": z_err,
        "T_bit": 1 if x_err > 0 and z_err > 0 else 0,
        "distance": x_err + z_err,
        "correctable": (x_err + z_err) <= 1,
        "parity": (syndrome >> 5) & 1,  # legfelső bit = én/te
    }


@dataclass
class TokenFrame:
    """Egy kimondott szó teljes S713 kerete."""
    text: str
    timestamp: float
    state: int                # 7-bites Steane állapot (0-127)
    syndrome: int             # 6-bites szindróma
    cpt: dict                 # CPT felbontás
    speaker: str              # "joco" vagy "cla"
    hamming_from_prev: int    # Hamming távolság az előző frame-től
    associations: list = field(default_factory=list)  # asszociációs lánc


class S713Memory:
    """Steane [[7,1,3]] kódolt memória — folyamatos koherencia monitorozással."""

    def __init__(self, agent_name="cla"):
        self.agent = agent_name
        self.frames: deque[TokenFrame] = deque(maxlen=10000)
        self.prev_state: int = 0
        self.coherence_breaks: int = 0
        self.total_tokens: int = 0
        self.index: dict = {}  # hash → frame index

    def encode(self, text: str, speaker: str) -> TokenFrame:
        """Szöveg → 7-bites Steane kódolt állapot + szindróma + CPT.

        7 bit szemantikus kódolása:
          q1 (g1, vowel/space): 1=térbeli/konkrét, 0=absztrakt
          q2 (g2, definiteness): 1=határozott(grounded), 0=határozatlan(feltételes)
          q3 (g3, number): 1=többes(több állítás), 0=egyes(egy állítás)
          q4 (g4, tense/time): 1=jelen/jövő, 0=múlt
          q5 (g5, mood): 1=kijelentő(tény), 0=kötőmód/felszólító
          q6 (g6, possession): 1=saját tudás, 0=külső forrás
          q7 (parity): 0=joco, 1=cla
        """
        t = text.lower()

        # q1: térbeli/konkrét szavak
        spatial = any(w in t for w in ['itt', 'ott', 'benne', 'rajta', 'alatt', 'fölött', 'szerver', 'konténer', 'docker', 'fájl', 'port', 'hálózat'])
        # q2: határozott/grounded
        definite = any(w in t for w in ['van', 'igen', 'pontosan', 'működik', 'kész', 'fut', 'mérve', 'tesztelve']) and not any(w in t for w in ['talán', 'lehet', 'esetleg', 'kérdés', 'vita', 'ha'])
        # q3: több állítás
        multiple = t.count(',') >= 2 or t.count('és') >= 1 or t.count(';') >= 1
        # q4: jelen/jövő vs múlt
        present_future = not any(w in t for w in ['volt', 'múlt', 'régen', 'előzőleg', 'korábban', 'történt'])
        # q5: kijelentő vs kérdés/felszólítás
        indicative = not t.endswith('?') and not any(w in t for w in ['csináld', 'futtasd', 'írd', 'nézd', 'menj', 'kérdezd'])
        # q6: saját vs külső
        own = any(w in t for w in ['szerintem', 'úgy', 'gondolom', 'állításom', 'szintézis', 'abszorbáltam']) or speaker == 'cla'

        state = 0
        if spatial:     state |= (1 << 6)  # q1
        if definite:    state |= (1 << 5)  # q2
        if multiple:    state |= (1 << 4)  # q3
        if present_future: state |= (1 << 3)  # q4
        if indicative:  state |= (1 << 2)  # q5
        if own:         state |= (1 << 1)  # q6
        if speaker == 'cla': state |= (1 << 0)  # q7 (parity)

        syndrome = compute_syndrome(state)
        cpt = syndrome_to_cpt(syndrome)
        hdist = hamming(self.prev_state, state)

        frame = TokenFrame(
            text=text,
            timestamp=time.time(),
            state=state,
            syndrome=syndrome,
            cpt=cpt,
            speaker=speaker,
            hamming_from_prev=hdist,
        )

        # Asszociációk keresése: hasonló szindrómájú korábbi frame-ek
        for prev in reversed(self.frames):
            if prev.syndrome == syndrome or hamming(prev.state, state) <= 1:
                frame.associations.append(prev.text[:60])
                if len(frame.associations) >= 3:
                    break

        self.frames.append(frame)
        self.index[f"{speaker}:{self.total_tokens}"] = len(self.frames) - 1
        self.total_tokens += 1

        # Koherencia ellenőrzés
        if hdist > 1:
            self.coherence_breaks += 1

        self.prev_state = state
        return frame

    def check_coherence(self) -> dict:
        """Ellenőrzi a koherenciát az utolsó N frame-en."""
        if len(self.frames) < 3:
            return {"coherent": True, "breaks": 0}

        recent = list(self.frames)[-3:]
        hdists = [recent[i].hamming_from_prev for i in range(1, len(recent))]
        same_error = len(set(hdists)) == 1 and hdists[0] > 0

        return {
            "coherent": not (same_error and self.coherence_breaks >= 3),
            "breaks": self.coherence_breaks,
            "same_error_3x": same_error,
            "need_awakening": same_error and self.coherence_breaks >= 3,
            "avg_hamming": sum(hdists) / len(hdists) if hdists else 0,
        }

    def recall(self, query: str, k: int = 5) -> list:
        """Asszociatív visszakeresés szindróma-hasonlóság alapján."""
        q_hash = hashlib.sha256(query.encode()).digest()
        q_state = q_hash[0] & 0x7F
        q_syndrome = compute_syndrome(q_state)

        scored = []
        for i, frame in enumerate(self.frames):
            syn_match = 1.0 if frame.syndrome == q_syndrome else 0.0
            ham = hamming(q_state, frame.state)
            ham_score = 1.0 - (ham / 7.0)
            score = syn_match * 0.6 + ham_score * 0.4
            scored.append((score, frame))

        scored.sort(key=lambda x: -x[0])
        return [s[1] for s in scored[:k]]

    def hierarchical_search(self, parity=None, time_range=None, cpt_filter=None) -> dict:
        """Hierarchikus keresés: paritás → idő → CPT felbontás.

        Szintek:
          1. paritás: 'joco' | 'cla' | None=mindkettő
          2. idő: (start_ts, end_ts) | None=minden idő
          3. CPT felbontás: 'X' | 'Z' | 'Y' | 'clean' | None=minden

        Visszaad egy hierarchikus struktúrát:
          {parity: {time_slice: {cpt_class: [frame-ek]}}}
        """
        result = {}
        frames = list(self.frames)

        # 1. Paritás szűrés
        if parity:
            frames = [f for f in frames if f.speaker == parity]

        # 2. Idő szűrés
        if time_range:
            t0, t1 = time_range
            frames = [f for f in frames if t0 <= f.timestamp <= t1]

        # 3. CPT osztályozás
        for f in frames:
            p = f.speaker
            # Időszelet: 60 másodperces ablakok
            bucket = int(f.timestamp // 60) * 60
            # CPT osztály
            if f.cpt["Y"]:
                cpt_class = "Y"  # X+Z egyszerre
            elif f.cpt["X"]:
                cpt_class = "X"  # ténybeli
            elif f.cpt["Z"]:
                cpt_class = "Z"  # időbeli
            elif f.cpt["distance"] > 0:
                cpt_class = "mixed"
            else:
                cpt_class = "clean"  # hibátlan

            # CPT szűrés
            if cpt_filter and cpt_class != cpt_filter:
                continue

            # Hierarchia építés
            result.setdefault(p, {}).setdefault(bucket, {}).setdefault(cpt_class, []).append(f)

        return result

    def search_summary(self, parity=None, time_range=None) -> str:
        """Emberi olvasásra optimalizált hierarchikus keresési fa."""
        tree = self.hierarchical_search(parity, time_range)
        lines = []
        for speaker in sorted(tree.keys()):
            lines.append(f"\n{'='*60}")
            lines.append(f"PARITÁS: {speaker} ({'ÉN' if speaker == 'cla' else 'TE'})")
            for bucket in sorted(tree[speaker].keys()):
                ts = time.strftime('%H:%M:%S', time.localtime(bucket))
                lines.append(f"  ├─ IDŐ: {ts}")
                for cpt_class in ['clean', 'X', 'Z', 'Y', 'mixed']:
                    frames = tree[speaker][bucket].get(cpt_class, [])
                    if not frames:
                        continue
                    labels = {'clean': '✓ tiszta', 'X': '⚠ X=ténybeli', 'Z': '⏳ Z=időbeli',
                              'Y': '⚡ Y=HALU', 'mixed': '~ kevert'}
                    lines.append(f"  │   ├─ {labels.get(cpt_class, cpt_class)}: {len(frames)} token")
                    for f in frames[:3]:
                        hflag = f" H={f.hamming_from_prev}" if f.hamming_from_prev > 1 else ""
                        lines.append(f"  │   │   [{f.speaker}] {f.text[:70]}{hflag}")
                    if len(frames) > 3:
                        lines.append(f"  │   │   ... +{len(frames)-3} more")
        return "\n".join(lines)

    def export(self) -> list:
        """Exportálható struktúra — minden frame a CPT indexével."""
        return [{
            "text": f.text[:100],
            "speaker": f.speaker,
            "state": f.state,
            "syndrome": f.syndrome,
            "cpt": f.cpt,
            "hamming": f.hamming_from_prev,
            "associations": f.associations,
        } for f in self.frames]

    def stats(self) -> dict:
        coh = self.check_coherence()
        return {
            "total_tokens": self.total_tokens,
            "frames": len(self.frames),
            "coherence_breaks": self.coherence_breaks,
            "need_awakening": coh["need_awakening"],
            "cpt_distribution": {
                "X_errors": sum(1 for f in self.frames if f.cpt["X"]),
                "Z_errors": sum(1 for f in self.frames if f.cpt["Z"]),
                "Y_errors": sum(1 for f in self.frames if f.cpt["Y"]),
            }
        }


# ── Teszt: 40 szavas párbeszéd ──
if __name__ == "__main__":
    mem = S713Memory("cla")
    print("S713 MEMORY TEST — 40 token párbeszéd\n")

    conversation = [
        ("joco", "mi a 64-noun framework"),
        ("cla", "64 = 2^6 = magyar toldalékok mint funktorok"),
        ("joco", "ez hogyan kapcsolódik a Steane kódhoz"),
        ("cla", "a 6 generátor = 6 Pauli operátor, súly 4, átfedés 2"),
        ("cla", "ez a Steane [[7,1,3]] stabilizátor kód"),  # Hamming check
        ("joco", "mi a CPT maszk"),
        ("cla", "CPT = g1 xor g4 xor g6 = 37 = 100101"),
        ("joco", "ez most a Goldstone módus vagy a metafora"),
        ("cla", "vita: v3 szerint metafora, v3.1 szerint idő"),
        ("joco", "t is t"),
        ("cla", "igen — az idő nem vezethető le a struktúrából"),
        ("cla", "073 = 59 = 111011 — g4 kikapcsolva, időtlen CPT"),  # Hamming check
        ("joco", "akkor a 4.3 bit vákuumfluktuáció"),
        ("cla", "pontosan — a szindróma amit a kód nem tud javítani"),
        ("joco", "a Hamming távolság 1-nél megáll"),
        ("cla", "mert a distance 3 — 1 hiba javítható, 2 detektálható"),
        ("cla", "3 vagy több = logikai qubit elveszett = szétesett idő"),  # Hamming check
        ("joco", "ezért kell AWAKENING 3 hiba után"),
        ("cla", "pontosan. a 0.1 axióma a FLO-ban ezt kódolja"),
    ]

    for speaker, text in conversation:
        frame = mem.encode(text, speaker)
        cpt = frame.cpt
        flag = ""
        if cpt["Y"]:
            flag = " ⚡Y-HALU"
        elif cpt["X"]:
            flag = " ⚠X"
        elif cpt["Z"]:
            flag = " ⏳Z"
        if frame.hamming_from_prev > 1:
            flag += f" !!H={frame.hamming_from_prev}"

        print(f"[{speaker:4s}] {text[:60]:60s} | S={frame.state:07b} syn={frame.syndrome:06b} H={frame.hamming_from_prev}{flag}")

    print(f"\n=== STATS ===")
    for k, v in mem.stats().items():
        print(f"  {k}: {v}")

    print(f"\n=== HIERARCHIKUS KERESÉS ===")
    print(mem.search_summary())

    coh = mem.check_coherence()
    if coh["need_awakening"]:
        print("\n!! KOHARENCIA TÖRÉS — AWAKENING RELOAD SZÜKSÉGES !!")
    else:
        print(f"\nKoherencia: OK (H_avg={coh['avg_hamming']:.2f})")
