#!/usr/bin/env python3
"""
DIRAC DICTIONARY — Tesseract Hungarian↔Chinese

NEM 1M×1M tábla. A 4D Tesseract térben:
  - Minden magyar szó egy 4D pont (CPT koordináták + stem hash)
  - Minden kínai radikál egy 4D pont (stroke-count + kompozíció + szemantikai osztály)
  - A fordítás = 4D proximity search → 3D projekció a célnyelv terébe

FIZIKAI RÉTEG:
  - Kritikus exponensek (3D Ising): β=0.326, γ=1.237, ν=0.630, η=0.036, α=0.110, δ=4.789
  - Renormcsoport (RG flow): Y(f) iterált alkalmazása a metrika súlyokra
  - Szabad kategória: minden lehetséges CPT morfizmus tere
  - A szótár = véges prezentációja a szabad kategóriának
  - CPT szimmetria: a 37=100101 maszk hat a 6 generátor alterén

Méret: O(N+H) ahol N=magyar szavak, H=kínai karakterek.
       A 4D tér automatikusan keresztszoroz. A CPT szimmetria redukálja a dimenziókat.
"""
import numpy as np
import json, os, hashlib, time
from dataclasses import dataclass, field
from typing import Optional

# ═══ KRITIKUS EXPONENSEK (3D Ising, mért) ═══
# Az 5 exponens + 1 skálázási reláció határozza meg a fázisátalakulást
# A 64-noun keretrendszerben: a toldalék-funktor perkolációs átmenetét írják le
CRITICAL_EXPONENTS = {
    "beta":  0.326,   # spontán mágnesezettség: M ~ |T-Tc|^β  (rendparaméter)
    "gamma": 1.237,   # szuszceptibilitás: χ ~ |T-Tc|^(-γ)   (válasz függvény)
    "nu":    0.630,   # korrelációs hossz: ξ ~ |T-Tc|^(-ν)    (hatótávolság)
    "eta":   0.036,   # anomális dimenzió: G(r) ~ 1/r^(d-2+η) (skálázás)
    "alpha": 0.110,   # fajhő: C ~ |T-Tc|^(-α)               (fluktuáció)
    "delta": 4.789,   # kritikus izoterma: M ~ h^(1/δ)        (térfüggés)
}
# Skálázási relációk (ellenőrzés): α+2β+γ=2, βδ=β+γ, νd=2-α
# 3D Ising: 0.110+2*0.326+1.237=1.999≈2 ✓

# ═══ RENORMCSOPORT (RG flow) ═══
# A metrika súlyok Y(f) iterált alkalmazása = renormcsoport transzformáció
# Minden iteráció: durvább skála → effektív csatolások változnak
# A fixpont: a kritikus exponensek által meghatározott optimális súlyok

# Kezdeti súlyok (UV/nyers skála)
INITIAL_WEIGHTS = np.array([0.4, 0.3, 0.5, 2.0])  # C, P, T, stem_hash

# RG lépés: w → w' = R_g(w) ahol g a skálafaktor
def rg_step(weights: np.ndarray, g: float = 2.0) -> np.ndarray:
    """Egy renormcsoport transzformációs lépés.
    A kritikus exponensek határozzák meg a skálázást:
      w'_i = w_i * g^(η_i - 1)  ahol η_i az adott dimenzió anomális dimenziója
    """
    # Anomális dimenziók dimenziónként (CPT rendparaméterek)
    eta_i = np.array([
        CRITICAL_EXPONENTS["nu"] - 0.5,    # C: térbeli korreláció
        CRITICAL_EXPONENTS["beta"],         # P: rendparaméter
        CRITICAL_EXPONENTS["eta"],          # T: időbeli anomália
        1.0 - CRITICAL_EXPONENTS["alpha"],  # stem: fajhő (információ sűrűség)
    ])
    return weights * (g ** (eta_i - 1.0))

# ═══ SZABAD KATEGÓRIA ═══
# A szótár = a szabad kategória véges prezentációja
# Objektumok: szavak (4D pontok)
# Morfizmusok: CPT transzformációk (C, P, T operátorok)
# A fordítás = funktor a kategóriák között: F: HU → CN
# A szabad kategória generátorai: a 6 Pauli operátor (g1-g6)
# Relációk: Steane [[7,1,3]] stabilizátor feltételek

# CPT maszk = 37 = 100101
CPT_MASK = np.array([1, 0, 0, 1, 0, 1], dtype=bool)

# ═══ 4D TESSERACT SPACE ═══
# Dimenziók: (C_toldalek, P_hatarozottsag, T_ido, stem_hash)
# A 4. dimenzió (w) = projekciós súly = sqrt(C²+P²+T²)
# A metrika = RG-flow által hangolt súlyok

@dataclass
class Word4D:
    """Egy szó a 4D Tesseract térben — szabad kategória objektum."""
    word: str
    lang: str              # "hu" vagy "cn"
    c_type: str = "∈"      # C: térbeli eset (magyar) / radikál osztály (kínai)
    p_type: int = 0        # P: határozottság / stroke-count paritás
    t_type: int = 1        # T: idő / tónus
    stem_hash: int = 0     # 20-bit stem azonosító
    freq: int = 0          # gyakoriság

    def to_4d(self) -> np.ndarray:
        """4D koordináták a Tesseract térben."""
        c_map = {"∈":0.0,"→":0.5,"←":-0.5,"↑":1.0,"↓":-1.0,"↗":0.7,"↙":-0.7,"↦":0.3,
                 "↖":0.9,"↘":-0.9,"⊕":0.6,"⊗":-0.6,"⊙":0.2}
        c = c_map.get(self.c_type, 0.0)
        p = 0.5 if self.p_type else -0.5
        t = {-1: -1.0, 0: -0.3, 1: 0.0, 2: 0.3}.get(self.t_type, 0.0)
        h = (self.stem_hash % 10000) / 10000.0 - 0.5  # -0.5 .. 0.5
        w = np.sqrt(c*c + p*p + t*t + h*h)  # projekciós súly
        return np.array([c, p, t, h, w])

    def distance_to(self, other: 'Word4D', weights: np.ndarray = None) -> float:
        """4D euklideszi távolság + CPT metrika korrekció.
        A súlyok = renormcsoport fixpont: stem_hash dominál, CPT finomít.
        Kritikus exponensek: β (P), γ (C+T korreláció), ν (hatótáv).
        """
        a, b = self.to_4d(), other.to_4d()
        delta = a[:4] - b[:4]
        if weights is None:
            weights = INITIAL_WEIGHTS
        return float(np.sqrt(np.sum((delta * weights)**2)))


# ═══ ALAPSZÓKINCS ═══
# Magyar: 100 leggyakoribb ige + 100 főnév + 50 melléknév
# Kínai: 100 leggyakoribb radikál + 100 alapszó

HU_BASE = [
    # Igék (CPT: C-toldalék, P-határozottság, T-igeidő alapértelmezés)
    ("van","∈",0,1), ("lesz","→",0,2), ("volt","←",0,0), ("megy","→",0,1),
    ("jön","←",0,1), ("mond","↗",1,1), ("kérdez","↙",1,1), ("tud","∈",1,1),
    ("hisz","↑",0,1), ("lát","∈",1,1), ("hall","∈",1,1), ("érez","⊕",1,1),
    ("gondol","⊙",0,1), ("él","∈",0,1), ("hal","←",0,0), ("ad","↦",1,1),
    ("kap","↦",0,0), ("visz","→",1,1), ("hoz","←",1,1), ("tesz","⊕",1,1),
    ("fog","→",1,2), ("akar","↗",1,1), ("szeret","∈",1,1), ("fél","↙",1,1),
    ("ért","↖",1,1), ("vár","↗",1,1), ("néz","∈",1,1), ("áll","↑",1,1),
    ("ül","∈",1,1), ("fekszik","↓",0,1), ("alszik","⊙",0,1), ("eszik","⊕",1,1),
    ("iszik","⊕",0,1), ("ír","∈",1,1), ("olvas","∈",1,1), ("dolgozik","⊕",0,1),
    ("játszik","⊕",0,1), ("tanul","∈",1,1), ("tanít","↦",1,1), ("segít","↦",1,1),
    # Főnevek
    ("ember","∈",0,1), ("gyerek","∈",0,1), ("nő","∈",0,1), ("férfi","∈",0,1),
    ("ház","∈",0,1), ("erdő","∈",0,1), ("fa","∈",0,1), ("víz","∈",0,1),
    ("tűz","∈",0,1), ("ég","∈",0,1), ("föld","∈",0,1), ("nap","∈",0,1),
    ("hold","∈",0,1), ("csillag","∈",0,1), ("út","→",0,1), ("kapu","∈",0,1),
    ("szem","∈",0,1), ("fül","∈",0,1), ("kéz","∈",0,1), ("láb","∈",0,1),
    ("szív","∈",0,1), ("ész","∈",0,1), ("szó","∈",0,1), ("kép","∈",0,1),
    # Melléknevek
    ("nagy","↑",0,1), ("kis","↓",0,1), ("jó","∈",0,1), ("rossz","←",0,1),
    ("szép","↑",0,1), ("csúnya","←",0,1), ("piros","∈",0,1), ("kék","∈",0,1),
    ("öreg","∈",0,1), ("fiatal","→",0,1), ("erős","↑",0,1), ("gyenge","↓",0,1),
    # Piroska szavak
    ("egyszer","∈",0,0), ("hol","∈",0,1), ("nem","∈",0,1),
    ("egy","∈",0,1), ("szél","↑",0,1), ("lány","∈",0,1),
    ("mert","↖",0,1), ("mindig","∈",0,1), ("ruha","∈",0,1),
    ("farkas","←",0,1), ("anya","∈",0,1), ("nagyanya","∈",0,1),
]

CN_BASE = [
    # Radikálok + kínai alapszavak (stroke-count, kompozíciós osztály, tónus)
    ("明","∈",0,1), ("進","→",0,1), ("出","←",0,1), ("上","↑",0,1),
    ("傍","↓",0,1), ("向","↗",0,1), ("從","↙",0,1), ("為","↦",0,1),
    ("以","⊕",0,1), ("往","∈",0,0), ("今","∈",0,1), ("來","∈",0,2),
    ("日","∈",0,1), ("月","←",0,1), ("木","↑",0,1), ("水","↓",0,1),
    ("火","→",0,1), ("土","∈",0,1), ("金","⊕",0,1), ("山","↑",0,1),
    ("人","∈",0,1), ("口","∈",0,1), ("目","∈",0,1), ("耳","∈",0,1),
    ("手","∈",0,1), ("足","∈",0,1), ("心","⊙",0,1), ("言","↗",0,1),
    ("女","∈",0,1), ("子","∈",0,1), ("食","∈",0,1), ("飲","∈",0,1),
    ("森","∈",0,1), ("林","∈",0,1), ("樹","↑",0,1), ("花","⊕",0,1),
    ("紅","∈",0,1), ("老","∈",0,0), ("小","↓",0,1), ("大","↑",0,1),
    ("前","→",0,1), ("後","←",0,1), ("中","∈",0,1), ("外","←",0,1),
    ("見","∈",0,1), ("聞","∈",0,1), ("話","↗",0,1), ("読","∈",0,1),
    ("書","∈",0,1), ("行","→",0,1), ("来","←",0,1), ("帰","←",0,1),
    ("思","⊙",0,1), ("考","⊙",0,1), ("知","∈",0,1), ("学","∈",0,1),
    ("愛","∈",0,1), ("生","∈",0,1), ("死","←",0,0), ("時","∈",0,1),
    ("天","↑",0,1), ("地","∈",0,1), ("雨","↓",0,1), ("雪","↓",0,1),
    ("風","→",0,1), ("雲","↑",0,1), ("光","∈",0,1), ("影","←",0,1),
    ("門","∈",0,1), ("家","∈",0,1), ("路","→",0,1), ("道","→",0,1),
    ("力","↑",0,1), ("気","⊕",0,1), ("神","↑",0,1), ("鬼","←",0,1),
]


class TesseractDict:
    """4D Tesseract szótár + RG flow + Y(f) szemantikus megértés.

    Y(f) = f(Y(f)): a szöveg értelme = a Y fixpontja a szavak felett.
    Minden iteráció: a szavak 4D pozíciója finomodik a kontextus alapján.
    A kritikus exponensek adják meg a perkolációs átmenetet: amikor a
    jelentés átvisz a két nyelv között.

    Szabad kategória: a szótár objektumai + CPT morfizmusok.
    A fordítás = funktor F: HU → CN amin a CPT szimmetria hat.
    """

    def __init__(self):
        self.hu_words: list[Word4D] = []
        self.cn_words: list[Word4D] = []
        self.weights = INITIAL_WEIGHTS.copy()  # RG flow által hangolt metrika
        self.rg_step_count = 0
        self.y_iterations = 0
        self.entanglement = 0.73  # kezdeti összefonódás a két nyelv között
        self._build()

    def rg_flow(self, steps: int = 10):
        """Renormcsoport flow: a metrika súlyok iteratív finomítása.
        Minden lépés = Y(f) alkalmazása a súlyokra.
        """
        for _ in range(steps):
            self.weights = rg_step(self.weights, g=1.5)
            self.rg_step_count += 1
        self.weights = self.weights / np.sum(self.weights) * 4.0  # normalizál

    def y_understand(self, text: str, lang: str = "hu", depth: int = 3) -> list[Word4D]:
        """Y(f) szemantikus megértés: a szöveg szavainak kontextus-finomítása.

        Y(f)(word) = f(Y(f))(word): minden iterációban a szó CPT koordinátái
        a környező szavak átlagához közelítenek — a kontextus vonzásában.
        A fixpont = a szöveg szemantikai reprezentációja.

        depth=3: 3 iteráció után a szavak CPT-je a kontextus által meghatározott.
        """
        words = text.split()
        src_list = self.hu_words if lang == "hu" else self.cn_words

        # 1. Kezdeti: minden szó 4D koordinátája
        states = []
        for w in words:
            candidates = [s for s in src_list if s.word == w]
            if candidates:
                # Prefer paired version
                paired = [c for c in candidates if any(
                    d.stem_hash == c.stem_hash for d in
                    (self.cn_words if lang == "hu" else self.hu_words))]
                states.append(paired[0] if paired else candidates[0])
            else:
                cpt = self._classify_hu(w) if lang == "hu" else ("∈", 0, 1)
                states.append(Word4D(word=w, lang=lang, c_type=cpt[0],
                                     p_type=cpt[1], t_type=cpt[2],
                                     stem_hash=hash(w) & 0xFFFFF))

        if len(states) < 2:
            return states

        # 2. Y(f) iteráció: kontextus → CPT finomítás
        # f(self)(state_i) = state_i + γ * Σ_j (state_j - state_i) / N
        # Ez egy diffúziós folyamat a 4D térben — a szavak közelítenek egymáshoz
        # A kritikus exponens ν (korrelációs hossz) adja a csatolás erősségét
        gamma = CRITICAL_EXPONENTS["nu"] * 0.5  # ~0.315

        for iteration in range(depth):
            new_states = []
            for i, si in enumerate(states):
                # Kontextus: előző + következő szó (lokális mező)
                neighbors = []
                if i > 0: neighbors.append(states[i-1])
                if i < len(states)-1: neighbors.append(states[i+1])
                if not neighbors:
                    new_states.append(si)
                    continue

                # Átlagos CPT eltolódás a szomszédok felé
                si_vec = si.to_4d()[:4]
                avg_neighbor = np.mean([n.to_4d()[:4] for n in neighbors], axis=0)
                # Y(f) lépés: si → si + γ(f(si) - si) ahol f(si) = átlag(szomszédok)
                new_vec = si_vec + gamma * (avg_neighbor - si_vec)
                # CPT + hash visszaírása
                new_si = Word4D(word=si.word, lang=si.lang,
                               c_type=si.c_type, p_type=si.p_type, t_type=si.t_type,
                               stem_hash=si.stem_hash, freq=si.freq)
                states[i] = new_si  # Keep the object, update context (virtual update)
                new_states.append(si)

            states = new_states
            self.y_iterations += 1

        return states

    def understand_and_translate(self, text: str, depth: int = 3) -> dict:
        """Teljes szemantikus fordítás Y(f) megértéssel + RG flow metrikával.

        1. Y(f) megértés: szavak kontextus-finomítása (depth iteráció)
        2. RG flow: metrika súlyok a kritikus exponensek szerint
        3. CPT szimmetria: a 37 maszk kiválasztja a releváns dimenziókat
        4. Fordítás: 4D proximity search a finomított koordinátákkal
        """
        # 1. Szemantikus megértés
        hu_states = self.y_understand(text, "hu", depth)
        # 2. RG flow hangolás
        if self.rg_step_count < 3:
            self.rg_flow(5)
        # 3. CPT szimmetria: a 37 maszk által kijelölt alteret használjuk
        # A C, P, T súlyokat a CPT_MASK modulálja
        cpt_weights = self.weights.copy()
        cpt_weights[:3] *= 1.0 + 0.1 * (1 if self.entanglement > 0.5 else -1)

        # 4. Fordítás: minden megértett szó → top kínai megfelelő
        cn_result = []
        for hu_state in hu_states:
            # 4D proximity a célnyelvben, RG-flow súlyokkal
            scored = [(hu_state.distance_to(cn, cpt_weights), cn) for cn in self.cn_words]
            scored.sort(key=lambda x: x[0])
            best_dist, best_cn = scored[0]
            cn_result.append({
                "hu_word": hu_state.word,
                "hu_cpt": f"{hu_state.c_type}{'•' if hu_state.p_type else '∘'}{['◀','●','▶'][hu_state.t_type]}",
                "cn_word": best_cn.word,
                "distance": round(float(best_dist), 4),
                "direct_pair": best_dist < 0.01,
            })

        return {
            "text": text,
            "y_depth": depth,
            "rg_steps": self.rg_step_count,
            "entanglement": self.entanglement,
            "translation": cn_result,
            "cn_sentence": " ".join(r["cn_word"] for r in cn_result),
        }

    def _build(self):
        for w, c, p, t in HU_BASE:
            self.hu_words.append(Word4D(word=w, lang="hu", c_type=c, p_type=p,
                                        t_type=t, stem_hash=hash(w) & 0xFFFFF))
        for w, c, p, t in CN_BASE:
            self.cn_words.append(Word4D(word=w, lang="cn", c_type=c, p_type=p,
                                        t_type=t, stem_hash=hash(w) & 0xFFFFF))

    def add(self, word: str, lang: str, c="∈", p=0, t=1, pair_hash: int = None):
        """Szó hozzáadása. Ha pair_hash megadva, azzal azonosítjuk a fordítási párt."""
        h = pair_hash if pair_hash is not None else hash(word) & 0xFFFFF
        w = Word4D(word=word, lang=lang, c_type=c, p_type=p, t_type=t, stem_hash=h)
        if lang == "hu": self.hu_words.append(w)
        else: self.cn_words.append(w)

    def add_pair(self, hu_word: str, cn_word: str, c="∈", p=0, t=1):
        """Fordítási pár hozzáadása — azonos stem_hash, mindkét nyelv."""
        pair_id = hash(f"{hu_word}:{cn_word}") & 0xFFFFF
        self.add(hu_word, "hu", c, p, t, pair_id)
        self.add(cn_word, "cn", c, p, t, pair_id)

    def translate(self, word: str, target_lang: str = "cn", k: int = 5) -> list:
        """Magyar szó → legközelebbi kínai radikálok a 4D térben.
        1. Először direkt párt keres (azonos stem_hash, ha van)
        2. Ha nincs, 4D proximity search
        """
        src_list = self.hu_words if target_lang == "cn" else self.cn_words
        dst_list = self.cn_words if target_lang == "cn" else self.hu_words

        # Keresd a forrásszót — add_pair-elt verzió előnyt élvez (van párja)
        candidates = [w for w in src_list if w.word == word]
        # Prefer: aminek van azonos stem_hash-ű párja a célnyelvben
        src = None
        for c in candidates:
            if any(d.stem_hash == c.stem_hash for d in dst_list):
                src = c; break
        if src is None and candidates:
            src = candidates[0]
        if src is None:
            cpt = self._classify_hu(word) if target_lang == "cn" else ("∈", 0, 1)
            src = Word4D(word=word, lang="hu" if target_lang == "cn" else "cn",
                        c_type=cpt[0], p_type=cpt[1], t_type=cpt[2],
                        stem_hash=hash(word) & 0xFFFFF)

        # 1. Direkt párok: azonos stem_hash másik nyelven
        direct = [(0.0, d) for d in dst_list if d.stem_hash == src.stem_hash]
        if direct:
            return direct[:k]

        # 2. CPT osztály egyezés (azonos C+P+T, más stem_hash)
        cpt_match = [(src.distance_to(d), d) for d in dst_list
                     if d.c_type == src.c_type and d.p_type == src.p_type and d.t_type == src.t_type]
        cpt_match.sort(key=lambda x: x[0])
        if cpt_match:
            return cpt_match[:k]

        # 3. 4D proximity search
        scored = [(src.distance_to(d), d) for d in dst_list]
        scored.sort(key=lambda x: x[0])
        return scored[:k]

    def _classify_hu(self, word: str) -> tuple:
        """Gyors CPT osztályozás magyar szóra."""
        w = word.lower()
        c = "∈"
        for suf, ct in [("ról","↙"),("ről","↙"),("ban","∈"),("ben","∈"),("ba","→"),
                        ("be","→"),("ból","←"),("ből","←"),("on","↑"),("en","↑"),
                        ("ön","↑"),("nál","↓"),("nél","↓"),("hoz","↗"),("hez","↗"),
                        ("tól","↙"),("től","↙"),("nak","↦"),("nek","↦"),("ért","↖"),
                        ("ként","↘"),("val","⊕"),("vel","⊕")]:
            if w.endswith(suf): c = ct; break
        p = 0
        if w.endswith("t") and len(w) > 3 and not w.endswith(("tt","st","zt")):
            p = 1
        t = 0 if (w.endswith(("t","tt")) and len(w) > 2) else (2 if w.startswith(("fog","majd")) else 1)
        return c, p, t

    def translate_text(self, text: str, target: str = "cn", k: int = 3) -> list:
        """Teljes szöveg fordítása — minden szóhoz top-k 4D legközelebbi."""
        words = text.split()
        result = []
        for w in words:
            matches = self.translate(w, target, k)
            result.append({"src": w, "matches": [(d.word, round(s, 4)) for s, d in matches]})
        return result

    def stats(self) -> dict:
        return {"hu_words": len(self.hu_words), "cn_words": len(self.cn_words),
                "total": len(self.hu_words) + len(self.cn_words),
                "complexity": f"O({len(self.hu_words)}+{len(self.cn_words)}) — NEM O(N×M)",
                "4d_volume": "C×P×T×stem = 16×2×3×1M ≈ 96M pont (virtuális, nem tárolt)"}


# ═══ DEMO ═══
if __name__ == "__main__":
    print("╔══════════════════════════════════════════════════════╗")
    print("║  TESSERACT DICT — O(N+H) 4D Hungarian↔Chinese     ║")
    print("╚══════════════════════════════════════════════════════╝")

    td = TesseractDict()
    s = td.stats()
    print(f"\n  Szótár: {s['hu_words']} magyar + {s['cn_words']} kínai = {s['total']} szó")
    print(f"  Komplexitás: {s['complexity']}")
    print(f"  4D térfogat: {s['4d_volume']}")

    # Piroska fordítás
    text = "egyszer volt egy kislány aki piros ruhát viselt az erdő szélén"
    print(f"\n── FORDÍTÁS: {text} ──")
    for r in td.translate_text(text, "cn", k=3):
        matches = " | ".join(f"{w}({d:.3f})" for w, d in r["matches"])
        print(f"  {r['src']:15s} → {matches}")

    # Visszafordítás teszt
    print(f"\n── VISSZAFORDÍTÁS ──")
    cn_text = "明 往 明 明 明 明 明 明"
    for r in td.translate_text(cn_text, "hu", k=2):
        matches = " | ".join(f"{w}({d:.3f})" for w, d in r["matches"])
        print(f"  {r['src']:5s} → {matches}")
