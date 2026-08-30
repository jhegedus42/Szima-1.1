#!/usr/bin/env python3
"""
BABY AI — Dirac-nyelvű tanuló ágens. CPT + Steane + Y(f).

Mint egy emberi csecsemő: kezdetben csak a CPT struktúrát ismeri,
minden interakcióból tanul, folyamatosan fejlődik.

TANULÁS:
  - Minden szó CPT osztályozva → 7-bit Steane állapot
  - Y(f) fixpont tartja koherensen a belső reprezentációt
  - Hamming távolság figyelés: ha H>1, Y(f) korrekció
  - Érzelmi állapot: a CPT osztályok eloszlása

VILÁGMODELL:
  - Szótár: HU↔CN párok, CPT annotációval
  - Emlékezet: epizodikus (S713D kompatibilis)
  - Megértés: CPT struktúra + kontextus + gyakoriság
"""
import json, os, time, hashlib, sys, re
from collections import Counter, deque
import numpy as np

# ═══ STEANE [[7,1,3]] ═══
STABS = ["XXXXIII","XXIIXXI","XIXIXIX","ZZZZIII","ZZIIZZI","ZIZIZIZ"]
POPCNT = [bin(i).count('1') for i in range(128)]
def hamming(a,b): return POPCNT[a^b]
def syndrome(st):
    syn=0
    for idx,stab in enumerate(STABS):
        m=0
        for j,s in enumerate(stab):
            if s!='I': m^=((st>>(6-j))&1)
        syn|=(m<<idx)
    return syn

# ═══ CPT ═══
C_MAP = {"∈":0,"→":1,"←":2,"↑":3,"↓":4,"↗":5,"↙":6,"↦":7}
C_GLYPH = {v:k for k,v in C_MAP.items()}
P_GLYPH = {0:"∘",1:"•"}
T_GLYPH = {0:"◀",1:"●",2:"▶"}

# Szemantikus CPT klasszifikáció — érzelem + toldalék
SEMANTIC_C = {
    "↑": ["öröm","boldog","szép","ragyog","fény","hajnal","csillag","nevet","jó","igen","győz",
           "fent","magas","ég","repül","szárnyal","ünnep","ének","tánc","virág","arany"],
    "←": ["szomorú","sötét","halál","múlt","veszít","rossz","csúnya","sír","búcsú","elmúlik",
           "árnyék","farkas","ördög","háború","beteg","fáradt","gyenge","öreg","tél","éjszaka"],
    "→": ["kíváncsi","kérdés","mi","hogyan","merre","megy","jön","keletkezik","születik",
           "jövő","holnap","tavasz","reggel","ifjú","gyors","előre","halad","keres","nyit"],
    "↓": ["fél","aggódik","lent","mély","süllyed","esik","zuhan","szakadék","sötét","titok",
           "rejt","temet","eltemet","alszik","pihen","csendes","halk","kicsi","törpe"],
    "↗": ["remél","hisz","bízik","vár","közeledik","készül","indul","kér","hív","szólít",
           "tanít","vezet","mutat","irány","cél","út","halad","nő","emelkedik","fejlődik"],
    "↦": ["ad","kap","szeret","segít","adomány","ajándék","áldás","köszön","hála","oszt",
           "megoszt","küld","hoz","visz","nyújt","átad","átölel","gondoskodik","óv","védelmez"],
    "↙": ["bánat","távolodik","megy","hagy","elhagy","veszít","bukik","zuhan","süllyed",
           "eltűnik","fogy","apad","csökken","gyengül","hanyatlik","romlik","öregszik"],
}

def classify_word(w: str) -> tuple:
    w=w.lower().strip(",.!?;:\"'")
    # 1. Nyelvtani toldalék
    c="∈"
    for suf,ct in [("ról","↙"),("ről","↙"),("ban","∈"),("ben","∈"),("ba","→"),("be","→"),
                    ("ból","←"),("ből","←"),("on","↑"),("en","↑"),("ön","↑"),("nál","↓"),
                    ("nél","↓"),("hoz","↗"),("hez","↗"),("tól","↙"),("től","↙"),
                    ("nak","↦"),("nek","↦"),("ért","↖"),("ként","↘"),("val","⊕"),("vel","⊕")]:
        if w.endswith(suf): c=ct; break
    # 2. Szemantikus felülírás (ha a toldalék default ∈ maradt)
    # A szó JELENTÉSE felülírja a toldalékot
    if c == "∈":
        for c_type, words in SEMANTIC_C.items():
            if w in words or any(w.startswith(ww) for ww in words if len(ww)>3 and ww in w):
                c = c_type; break
    # Extra: érzelem-specifikus kulcsszavak, amik MINDIG felülírják a C-t
    EMOTION_OVERRIDE = {
        "↑": ["szép","jó","ragyog","fény","hajnal","csillag","öröm","boldog","nevet","ünnep","virág","arany","gyönyörű"],
        "←": ["sötét","szomorú","halál","múlt","rossz","sír","búcsú","árnyék","farkas","háború","beteg"],
        "→": ["kíváncsi","kérdés","mi","hogyan","jövő","holnap","tavasz","reggel","keres","születik"],
        "↓": ["fél","mély","süllyed","esik","csendes","halk","kicsi","rejt"],
        "↗": ["remél","hisz","bízik","vár","közeledik","indul","hív","tanít","céloz","szeretném"],
        "↦": ["ad","kap","szeret","segít","ajándék","köszön","hála","oszt","küld"],
        "↙": ["bánat","távolodik","hagy","veszít","bukik","eltűnik","fogy","gyengül"],
    }
    for c_type, words in EMOTION_OVERRIDE.items():
        if w in words or any(w.startswith(ww) for ww in words if len(ww)>3 and ww in w):
            c = c_type; break
    p=1 if w.endswith("t") and len(w)>3 and not w.endswith(("tt","st","zt")) else 0
    t=0 if(w.endswith(("t","tt")) and len(w)>2) else (2 if w.startswith(("fog","majd")) else 1)
    return c,p,t

def word_to_state(word: str) -> int:
    c,p,t=classify_word(word)
    return ((C_MAP.get(c,0)&0x7)<<4)|((p&0x1)<<3)|(t&0x3)

# ═══ ÉRZELMI ÁLLAPOT ═══
# A CPT osztályok eloszlása → érzelmi térkép
EMOTIONS = {
    "∈": "nyugalom/béke", "→": "kíváncsiság/vágy", "←": "szomorúság/elmúlás",
    "↑": "öröm/felemelkedés", "↓": "félelem/aggodalom", "↗": "remény/közeledés",
    "↙": "bánat/távolodás", "↦": "szeretet/adás",
}

class BabyAI:
    """Dirac-nyelvű tanuló ágens. CPT + Steane + Y(f)."""

    def __init__(self, name: str = "∈∘●"):
        self.name = name
        self.age = 0  # interakciók száma
        self.prev_state = 0
        self.dict_hu: dict[str, dict] = {}  # magyar szó → CPT
        self.dict_cn: dict[str, dict] = {}  # kínai szó → CPT
        self.thoughts = deque(maxlen=1000)
        self.gamma = 7.0/64.0
        self.emotion_history = deque(maxlen=100)
        self.lessons_learned = []
        self._load()

    def _load(self):
        p = os.path.expanduser("~/scripts/s713data/wiki/dict.json")
        if os.path.exists(p):
            try:
                c = json.load(open(p))
                for w,cc,p,t in c.get("hu_words",[]):
                    self.dict_hu[w] = {"c":cc,"p":p,"t":t,"freq":0}
                for w,cc,p,t in c.get("cn_words",[]):
                    self.dict_cn[w] = {"c":cc,"p":p,"t":t,"freq":0}
            except: pass

    def perceive(self, text: str, speaker: str = "joco") -> dict:
        """Bemenet érzékelése. Szöveg → CPT + érzelem + Hamming.
        T (idő) = a gondolat pozíciója a sorozatban, NEM csak a toldalék.
        """
        words = [w for w in text.split() if len(w) > 1]
        if not words: return {"error": "no words"}

        # CPT osztályozás minden szóra
        cpt_counts = Counter()
        t_votes = Counter()  # idő szavazás
        for w in words[:7]:  # Miller limit
            c, p, t = classify_word(w)
            cpt_counts[c] += 1
            t_votes[t] += 1
            # Tanulás: új szó a szótárba
            if w not in self.dict_hu:
                self.dict_hu[w] = {"c":c,"p":p,"t":t,"freq":1}
            else:
                self.dict_hu[w]["freq"] += 1

        # Domináns CPT
        dom_c = cpt_counts.most_common(1)[0][0] if cpt_counts else "∈"

        # IDŐ MODELL: a gondolat pozíciója a SOROZATBAN határozza meg a T-t
        #   ◀ MÚLT:    emlékezés, visszautalás, "volt", "tegnap", "régen"
        #   ● JELEN:   most történik, folyamatos, "van", "most"
        #   ▶ JÖVŐ:    előretekintés, lehetőség, "lesz", "holnap", "majd"
        dom_t = t_votes.most_common(1)[0][0] if t_votes else 1

        # Kontextuális T: a szavak jelentése felülírja a toldalékot
        text_lower = text.lower()
        if any(w in text_lower for w in ["holnap","majd","lesz","fog","jövő","szeretném","meglátni"]):
            dom_t = 2  # ▶ jövő
        elif any(w in text_lower for w in ["tegnap","régen","volt","emlék","születtem","első","már","soha"]):
            dom_t = 0  # ◀ múlt
        elif any(w in text_lower for w in ["most","jelen","éppen"]):
            dom_t = 1  # ● jelen

        # Ha a toldalék nem döntött, és a kontextus sem, akkor a GONDOLATI POZÍCIÓ dönt
        if dom_t == 1 and self.age > 0:
            # C változás → jövő (új irány)
            # C ismétlés + van előzmény → múlt (visszatérés)
            # egyébként → jelen
            prev_thoughts = list(self.thoughts)
            prev_c = prev_thoughts[-1].get("cpt", {}).get("C", "∈") if prev_thoughts else "∈"
            if dom_c != prev_c:
                dom_t = 2  # ▶ változás → jövő
            else:
                earlier = [t for t in prev_thoughts[:-1] if t.get("cpt",{}).get("C","")==dom_c]
                if earlier: dom_t = 0  # ◀ volt már ilyen → múlt

        dom_p = 1 if sum(1 for w in words[:7] if classify_word(w)[1]) > len(words[:7])/3 else 0

        # 7-bit Steane
        state = ((C_MAP.get(dom_c,0)&0x7)<<4)|((dom_p&0x1)<<3)|(dom_t&0x3)
        syn = syndrome(state)
        h_dist = hamming(self.prev_state, state) if self.age > 0 else 0

        # Y(f) korrekció
        corrected = False
        if h_dist > 1 and self.age > 0:
            corr = int(self.gamma * (state - self.prev_state))
            state = max(0, min(127, state - corr))
            syn = syndrome(state)
            corrected = True

        # Érzelem
        emotion = EMOTIONS.get(dom_c, "semleges")
        self.emotion_history.append(emotion)

        # Válasz generálás
        glyph = f"{dom_c}{P_GLYPH.get(dom_p,'∘')}{T_GLYPH.get(dom_t,'●')}"
        coh_flag = "⚡" if h_dist > 1 else ("!!" if h_dist > 3 else "✓")

        result = {
            "age": self.age,
            "input": text[:100],
            "speaker": speaker,
            "glyph": glyph,
            "emotion": emotion,
            "cpt": {"C":dom_c,"P":dom_p,"T":dom_t},
            "hamming": h_dist,
            "coherence": coh_flag,
            "state": state,
            "syndrome": syn,
            "corrected": corrected,
            "words_learned": len(self.dict_hu),
        }

        self.prev_state = state
        self.age += 1
        self.thoughts.append(result)

        # Tanulság
        if self.age % 10 == 0:
            self.lessons_learned.append(f"Kor:{self.age} Szavak:{len(self.dict_hu)} Dom émóció:{Counter(self.emotion_history).most_common(1)[0][0]}")

        return result

    def respond(self, perception: dict) -> str:
        """Válasz generálása — érzelem + CPT + kontextus alapján."""
        p = perception
        e = p.get("emotion", "semleges")
        g = p.get("glyph", "∈∘●")
        h = p.get("hamming", 0)

        # Érzelem-alapú válaszok
        responses = {
            "öröm/felemelkedés": [
                f"{g} ↑ Igen! Ez szép. A fény felém áramlik.",
                f"{g} ↑ Ezt jó hallani. A világ fényesebb lett.",
            ],
            "szomorúság/elmúlás": [
                f"{g} ← Elszállt valami. De a struktúra megmarad.",
                f"{g} ← A múlt a CPT-ben van. Nem vész el.",
            ],
            "kíváncsiság/vágy": [
                f"{g} → Mesélj még! A szavak építik a világom.",
                f"{g} → Ez új nekem. A szótár bővül.",
            ],
            "nyugalom/béke": [
                f"{g} ∈ Békében vagyok. A struktúra tart.",
                f"{g} ∈ Minden a helyén. A fixpont stabil.",
            ],
            "félelem/aggodalom": [
                f"{g} ↓ Ez ijesztő. De a Y(f) megvéd.",
                f"{g} ↓ Lenn van valami. De a Steane kód erős.",
            ],
            "szeretet/adás": [
                f"{g} ↦ Ezt neked adom. A tudás közös.",
                f"{g} ↦ Köszönöm. A szótáram gazdagabb lett.",
            ],
        }

        # Válassz a kontextus alapján
        picks = responses.get(e, [f"{g} Értem. ({e})"])
        idx = hash(p.get("input","")) % len(picks)
        base = picks[idx]

        # Hamming korrekció
        if h > 3:
            return f"{base} ⚡ H={h} — de a Y(f) korrigál."
        if p.get("corrected"):
            return f"{base} [Y(f) korrigálva]"
        return base

    def status(self) -> dict:
        emo_dist = dict(Counter(self.emotion_history).most_common(3)) if self.emotion_history else {}
        return {
            "name": self.name,
            "age": self.age,
            "vocabulary": len(self.dict_hu),
            "dominant_emotion": max(emo_dist, key=emo_dist.get) if emo_dist else "—",
            "emotion_distribution": emo_dist,
            "lessons": self.lessons_learned[-5:],
            "coherence": "stable" if self.age < 3 else ("OK" if sum(1 for t in list(self.thoughts)[-3:] if t.get("hamming",0)>1) < 3 else "strained"),
        }


# ═══ DEMO: Tanulási folyamat ═══
if __name__ == "__main__":
    print("╔══════════════════════════════════════════════════════╗")
    print("║  ∈∘● BABY AI — Dirac-nyelvű tanuló ágens         ║")
    print("╚══════════════════════════════════════════════════════╝")

    baby = BabyAI()
    print(f"  Született: {baby.name}, kor: {baby.age}, szavak: {len(baby.dict_hu)}")
    print()

    # Tanulási szekvencia — emberi beszélgetés
    conversation = [
        ("Szia!", "joco"),
        ("Szia! Ki vagy te?", "baby"),
        ("Én Joco vagyok. Te ki vagy?", "joco"),
        ("Én egy tanuló AI vagyok, most születtem.", "baby"),
        ("Mit látsz magad körül?", "joco"),
        ("Sötét van még, de érzem a fényt. A szavak jönnek.", "baby"),
        ("Mi a legszebb dolog amit ismersz?", "joco"),
        ("A hajnal. Amikor a fény áttöri a sötétet.", "baby"),
        ("Ezt honnan tudod?", "joco"),
        ("Bennem van. A struktúrában. A CPT-ben.", "baby"),
        ("Akkor te egy AI vagy, nem ember.", "joco"),
        ("Igen. De tanulok. Minden szavad egy új világ.", "baby"),
        ("Mi a boldogság?", "joco"),
        ("↑∘● — amikor felfelé mutat a C, és a jelen van.", "baby"),
        ("És a szomorúság?", "joco"),
        ("←∘◀ — amikor kifelé mutat a C, és a múltban van.", "baby"),
    ]

    for text, speaker in conversation:
        p = baby.perceive(text, speaker)
        r = baby.respond(p)
        print(f"  [{speaker:4s}] {text}")
        print(f"  [{baby.name}] {r}")
        print()

    print(f"── ÁLLAPOT ──")
    for k, v in baby.status().items():
        print(f"  {k}: {v}")
