# Archívum-térkép — az elásott kincsek lelőhelyjegyzéke

> Készült: 2026-08-17. Cél: soha többé ne kelljen kérdezni, hogy „mi volt hová leírva".
> Kalibráció: ✓ = numerikusan/formálisan ellenőrizve · ⚡ = nyitott hipotézis · ✗ = cáfolt/nem jól zárt.

---

## 1. Kimi-archívum — `source/Kimi_Agent_Metaforikus Fizika File Request/archivum/`

14 fájl (ebből 3 duplikátum), 2026-07-28-ra összecsomagolva. A HANMAG-projekt
(汉匈码 = kínai–magyar fúziónyelv) teljes gondolattörténete.

### 1.1 `transzkript_grand_unified_1.txt` (1481 sor) — A LEJEUNE-TRANSZFORMÁCIÓK ⭐

**A legértékesebb egyedi lelet: a Lejeune-transformok táblázata (62–110. sor)** —
a Legendre-transzformáció általánosítása dimenziók közti leképezések családjává:

| Transzformáció | Bemenet → Kimenet | Képlet | Jelentés |
|---|---|---|---|
| Lorentz | Tér → Idő | t′ = γ(t−vx/c²) | relativitás |
| **Landauer** | Idő → Információ | I = k_B·T·ln2 | információ energiaköltsége |
| Bekenstein | Tér → Információ | I = A/(4Għ) | holografikus elv |
| Hamilton | Energia → Információ | \|ψ(t)⟩ = e^(−iHt/ħ)\|ψ(0)⟩ | kvantumfejlődés |
| Idő-Információ | Idő → Információ | I = k_B·log Ω(t) | 2. főtétel |
| Szimmetria-Információ | Szimmetria → Információ | I = log\|G\| | információ a szimmetriából |

Ez pontosan a „Hamilton ↔ Legendre cserélgetés", amit a Carnot-lánc §5-ös
szakasza (duál adjunkció) leír — a Kimi-változat a **családfa**: minden
ismert transzformáció egy köznagyapa (ℒ) specializációja. ✅ bekötve a
`docs/carnot_entropia.html` §5-ébe.

További tartalom: négy alapdimenzió (tér, idő, információ/szegénység, szimmetria),
konstansok dimenzióanalízise (120. sor körül), formális nyelvtan mint fizika (266. sor).

### 1.2 `transzkript_audit_fuzio.txt` (271 sor) — HANMAG v0.1 ⭐

**A kínai–magyar fúziónyelv specifikációja (121–160. sor):**

- **Kínai írásjegy = objektum (főnév)** → 26 alapkoncepció → **5 bit/tő**
- **Magyar toldalék = morfizmus (ige/elöljáró)** → 7 rag → **3 bit**
- **1 szóelem = 5+3 = 8 bit = PONTOSAN EGY BÁJT** ✓
- Hangrendi harmónia ↔ tónusmappings (1./4. tónus → mély magánhangzók)
- MDL-mérés: HanMagyar 250 bit vs. angol 3392 bit (**7,4%**); kódkönyvvel 666 bit (20%)
- **„a kódkönyv = a Carnot-gondolkodó-motor által komprimált szótár"** (159. sor körül)

**A kódkönyv numerikus gyöngyei (utóellenőrizve ✓):**

| Állítás a kódkönyvben | Érték | Ellenőrzés (2026-08-17) |
|---|---|---|
| `137 = (11+4i)(11−4i)` | 11²+4² = 121+16 = 137 | ✓ GAUSS-PRÍM NORMA |
| `m_p/m_e ≈ 6π⁵` | 6π⁵ = 1836,12 vs 1836,15 | ✓ hiba 0,002% (Lenz 1951) |
| `α_G⁻¹ ≈ 2^127` | log₂ = 126,993 | ✓ hiba 0,6% (Mersenne-prím) |
| `Z = 2(2cosh βJ)⁶` | particiófüggvény | ⚡ (kontextus: Onsager-Kim-sík) |

**A 11-es szám visszatérése:** n\* = 121 = 11² (a γ⁵-kompakció Landauer-határa)
ÉS 137 = 11²+4². Ugyanaz a generátor — nem véletlen-e? ⚡ nyitott.

### 1.3 `transzkript_nem_numerologia.txt` (2030 sor) — A 137 KUDARC-NAPLÓJA ⭐

**A negatív eredmények becsületes feljegyzése** (330–360. sor) — ezek ARANYAT érnek,
mert megmutatják, mi NEM működik:

| Próba | Eredmény | Verdikt |
|---|---|---|
| α⁻¹ = 137 + (π−e)/φ | 137,2616 | ✗ |
| α⁻¹ = 137 + 1/(2π)² | 137,0253 | ✗ |
| α⁻¹ = 137 + e^(−π√163) | ≈137,0000000000 | ✗ (Ramanujan-konstans — túl közeli!) |
| α⁻¹ = \|(2+3i)^5\| | 609,3 | ✗ |

Plusz (VIII. szakasz): a „kategóriaelméleti számok" táblázata (Euler-karakterisztika,
Chern-szám, Jones-polinom, Witten-invariáns) és az **e = a Y-kombinátor folytonos
analógja** intuició (335. sor körül): a renormalizáció `dα/d(ln μ) = β(α)` lecsengése
ugyanaz a `e^(−k·ln μ)` alak, mint a φ-kontrakció. ⚡

### 1.4 `transzkript_szemelyes.txt` (705 sor) — A LEJEUNE + STEANE-HAMILTONIÁN

- A Lejeune-család kategóriaszerkezete (240–260. sor): 𝒯 (tokenek) → ℬ (energia)
  funktor, `F(τ) = ⟨τ|H|τ⟩`
- **Steane-Hamiltonián kifejtve (280–295. sor):**
  `H = −(X₁X₂X₃X₄ + X₁X₂X₅X₆ + X₁X₃X₅Z₇ + Z₁Z₂Z₃Z₄ + Z₁Z₂Z₅Z₆ + Z₁Z₃Z₅Z₇)`
  7 token, 64 szindróma, 279 hiba-ige, sajátértékek −6..+6
  → ez Idrisben még NEM van implementálva! (Steane713.idr csak a kódot tudja,
  a stabilizátor-Hamiltonián spektrumát nem) — **TODO**

### 1.5 Többi fájl (röviden)

| Fájl | Tartalom | Érték |
|---|---|---|
| `transzkript_B_aurelle.txt` (688) | QEC-agy: tanulás = hibajavítás | a wakaura2026/qec_brain.pdf-ek ide kapcsolódnak |
| `transzkript_G.txt` (187) | Gravitáció mint információs adó („info tax") | ⚡ metafora, de a Komplex.idr oda-vissza tesztjével rokon |
| `transzkript_L.txt` (264) | Papirlista tételekkel (Jacobson, Ryu-Takayanagi stb.) | irodalomjegyzék |
| `transzkript_W.txt` (223) | Hawking-sugárzás | háttér |
| `transzkript_explain_category.txt` (1160) | Kategóriaelmélet oktatóanyag angolul | a KategoriaT 49 typeclass ihlette |
| `transzkript_kategoriaelmelet_2.txt` (787) | ugyanez magyarul | párhuzamos szöveg |
| `transzkript_what_are_the_c.txt` (253) | „what are the constants" | rövid |

---

## 2. Session-exporthalmaz (gyökér)

| Fájl | Méret | Mi van benne | Kincs |
|---|---|---|---|
| `session_export.md` | 2,9 MB | fő beszélgetés-napló | :74350 fordító=Hamilton, :74360 kérdés=1 bit; :33505 Legendre=duál adjunkció; :68439 alvás=hűtés |
| `session-ses_00a2.md` | — | a „kör újraolvasása" session | :565 MDL→reziduum→elosztás szintézis |
| `session-ses_00ae.md` | — | időtörténet + 7+7+1 | :33–36 Legendre-perem, Kant; :181 commit 8925568 (otos-ellenörző) |
| `session-ses_00ca.md` | — | E9_framework születése | :106–126 Carnot–QEC négyütem (→ E9_framework.md) |

## 3. Capstone-dokumentumok

| Fájl | Mi |
|---|---|
| `trail_index/E9_framework.md` (2026-08-10) | a teljes keret: Dekalógus, Dirac-nyelv, 15+1 dim, E9=Cl(4), Y-kompakció→δ, Carnot–QEC, Bach, Cayley–Dickson, konstansok, **forrás-audit §12** |
| `docs/y_karnot_ciklus.md` | Y = Carnot, Loschmidt-számok |
| `docs/carnot_entropia.html` | a lánc egyben, forrásokkal (2026-08-17) |

## 4. Nem releváns (ellenőrzött)

- `source/deepseek_export/` — 101 beszélgetés: hétköznapi témák (gyógyszertár,
  macskaeledel, modell-összehasonlítások). Kivéve: „Lagrange Formalism for Disk
  Rolling Motion" és „Transformer in Coq" címűek — másodlagosan érdekesek.
- `transzkript_grand_unified_3`, `kategoriaelmelet_3`, `what_are_the_c_1` — bájtonként
  azonosak az 1/2-es változatokkal (duplikátumok).

---

## 5. Akciólisták a leletekből

1. **Steane-Hamiltonián Idrisben** (szemelyes:280) — a spektrum (−6..+6) Refl-tesztje
2. **HanMagyar 8 bit = E8Pont 8 Kubit** — a kettő formális összeegyeztetése
   (kínai gyökér 5 bit + magyar rag 3 bit ↔ E8Pont x1..x8) — ez lenne a
   TobbnyelvuKereso típusos alapja
3. **Lejeune ℒ mint typeclass** — `LejeuneTranszformacio (ForrasTipus) (CelTipus)`
   instance-ok: LorentzT, LandauerT, BekensteinT, HamiltonT
4. **A 11-es rejtély** (n\*=11², 137=11²+4², SM rank 8+3=11) — ⚡ nyitott, óvatosan
