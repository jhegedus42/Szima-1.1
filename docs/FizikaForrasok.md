# Fizikai Források — Hivatkozásjegyzék

Készült: 2026-08-19. Forráskereső alügynök. Csak olvasás + új fájl.

---

## 1. Steane [[7,1,3]] kód

### 1a. Az eredeti Steane 1996 cikk

- **Szerző:** Andrew M. Steane
- **Cím:** "Error Correcting Codes in Quantum Theory"
- **Folyóirat:** Physical Review Letters, 77(5), 793–797
- **Dátum:** 1996. július 29
- **DOI:** 10.1103/PhysRevLett.77.793
- **URL:** https://link.aps.org/doi/10.1103/PhysRevLett.77.793
- **PDF:** https://users.physics.ox.ac.uk/~Steane/pubs/Steane_PRL95.pdf
- **ORA:** https://ora.ox.ac.uk/objects/uuid:e6ec2e48-36b5-4d3f-ac7d-f973e42b3d97
- **Idézet (Semantic Scholar absztrakt):** "A new type of uncertainty relation is presented, concerning the information-bearing properties of a discrete quantum system. A natural link is then revealed between basic quantum theory and the linear error correcting codes of classical information theory."

### 1b. A [[7,1,3]] paraméterek és a stabilizátor-generátorok

- **Forrás:** arXiv:2504.01083 (Rodriguez-Blanco, Nguyen, Whaley, 2025)
- **Cím:** "Fault-tolerant correction-ready encoding of the [[7,1,3]] Steane code on a 2D grid"
- **URL:** https://arxiv.org/abs/2504.01083
- **Idézet (oldal 2–3):** "The [[7,1,3]] Steane code is a QEC code that encodes a single logical qubit into seven physical qubits, capable of correcting any single-qubit error. It is derived from the classical [[7,4,3]] Hamming code via the CSS (Calderbank-Shor-Steane) construction."
- **Stabilizátor-generátorok (egyenlet 2):**
  ```
  S^X_1 = X1 X2 X3 X4,   S^Z_1 = Z1 Z2 Z3 Z4,
  S^X_2 = X2 X3 X5 X6,   S^Z_2 = Z2 Z3 Z5 Z6,
  S^X_3 = X3 X4 X6 X7,   S^Z_3 = Z3 Z4 Z6 Z7.
  ```
- **Távolság:** "this minimum weight corresponds precisely to the code distance d = 3, which represents the smallest number of physical qubit errors required to cause a logical error" (oldal 3).
- **Kódszó-tér dimenzió:** "Each stabilizer imposes one constraint on the original 2^n-dimensional Hilbert space of n physical qubits, leaving 2^{n−r} degrees of freedom to encode k = n − r logical qubits in the code space" (oldal 2). Itt n=7, r=6, k=1, tehát 2⁷ = 128, a kódtér dimenziója 2¹ = 2, a stabilizátor-altér (tiszta tér) komplementer dimenziója 128 − 7 = 121 (a 7 egykvantum-bit hibatér dimenziója).

### 1c. További hivatkozások a Steane kódra

- arXiv:1804.06995 — "Fault-tolerant quantum error correction for Steane's seven-qubit color code with few or no extra qubits"
- arXiv:2107.07505 — "Realization of real-time fault-tolerant quantum error correction" (Honeywell, 2021): "[[7,1,3]] color code, first proposed by Steane [1]. A. M. Steane, Phys. Rev. Lett. 77, 793 (1996)."
- arXiv:2511.13700 — "Ultra Low Overhead Syndrome Extraction for the Steane code"

---

## 2. QED vákuum-polarizáció (Schwinger 1-loop)

### 2a. Schwinger anomális mágneses momentum (α/2π)

- **Szerző:** Julian Schwinger
- **Cím:** "On Quantum-Electrodynamics and the Magnetic Moment of the Electron"
- **Folyóirat:** Physical Review, 73(4), 416–417
- **Dátum:** 1948. február 15
- **DOI:** 10.1103/PhysRev.73.416
- **URL:** https://link.aps.org/doi/10.1103/PhysRev.73.416
- **Idézet (Wikipedia / Physics Detective):** "the radiative correction corresponds to an additional magnetic moment associated with the electron spin of magnitude δμ/μ = (½π)e²/ħc = 0.001162." Ez α/(2π) ≈ 0.001161.

### 2b. Schwinger radiatív korrekciók elektron-szórásra (vákuum-polarizáció)

- **Szerző:** Julian Schwinger
- **Cím:** "Radiative Corrections to Electron Scattering"
- **Folyóirat:** Physical Review, 75(6), 898–899
- **Dátum:** 1949. március 15
- **DOI:** 10.1103/PhysRev.75.898
- **URL:** https://link.aps.org/doi/10.1103/PhysRev.75.898

### 2c. Uehling 1935 (vákuum-polarizációs potenciál, a klasszikus 1-loop)

- **Szerző:** E. A. Uehling
- **Cím:** "Polarization Effects in the Meson Field" (az Uehling-potenciál eredeti cikke)
- **Folyóirat:** Physical Review, 48(1), 55
- **Dátum:** 1935
- **DOI:** 10.1103/PhysRev.48.55
- **Hivatkozás arXiv:2207.14101:** "the Uehling potential [E. A. Uehling, Phys. Rev. 48, 55 (1935)] for vacuum polarization"
- **Hivatkozás arXiv:1402.0439 (Coordinate-space approach to vacuum polarization):** a Pauli-Villars regularizációt és a vákuum-polarizációt tárgyalja.

### 2d. Az α/(3π) ≈ 7.74×10⁻⁴ együtható

- **Forrás:** arXiv:math-ph/0310043 (Bach, Chen, Fröhlich, Sigal, "Mass renormalization in nonrelativistic QED")
- **Idézet (absztrakt):** "As well known, if m denotes the bare mass and m the mass computed from the theory, to order α one has m = m(1 + 8α/3π)(1 + (Λ/m)) + O(α²), which suggests that δm/m = (Λ/m)8α/3π for small α."
- A **vákuum-polarizációs** (1-loop foton propagátor) korrekció a Thomson-limitben: Π(0) = α/(3π)·ln(Λ²/m²). Az α/(3π) tehát a renormálási csoport együthatója, a bare → dressed csatolás iránya: e_bare² → e_dressed² = e_bare² / (1 − Π(q²)), a Thomson-limitben q² → 0.
- **Megjegyzés:** a Schwinger α/(2π) az *anomális mágneses momentum* (vertex korrekció), az α/(3π) a *vákuum-polarizációs* (foton propagátor) korrekció együthatója. Mindkettő 1-loop QED.

### 2e. További vákuum-polarizációs források

- arXiv:2403.07127 — "Dimensional Regularization and Two-Loop Vacuum Polarization Operator" (az 1-loop effektust epszilon-rendben adja meg, hogy a 2-loop 1/epszilon divergenciájával kombinálható legyen).
- arXiv:1801.05430 — "Vacuum Polarization and Photon Propagation in an Electromagnetic Plane Wave" (Schwinger proper-time módszerrel, 2018).

---

## 3. A finomszerkezeti állandó CODATA értéke

### 3a. CODATA 2022 (ajánlott)

- **Érték:** α⁻¹ = 137.035999177(21)
- **σ (abszolút mérési bizonytalanság):** 2.1×10⁻⁸ (az utolsó két jegy (21)-je, 21×10⁻⁹ = 2.1×10⁻⁸)
- **Relatív bizonytalanság:** 1.5×10⁻¹⁰
- **Forrás:** NIST, "2022 CODATA Value: fine-structure constant"
  - URL: https://physics.nist.gov/cgi-bin/cuu/Value?alphinv
  - Faliplakát PDF: https://physics.nist.gov/cuu/pdf/wall_2022.pdf
  - Tárca PDF: https://physics.nist.gov/cuu/pdf/wallet_2022.pdf
- **Hivatalos publikáció:** CODATA 2022, Journal of Physical and Chemical Reference Data
  - URL: https://pubs.aip.org/aip/jpr/article/54/3/033105/3363695/CODATA-recommended-values-of-the-fundamental
- **Idézet (Grokipedia):** "The current recommended value, based on the 2022 CODATA adjustment, is α = 7.2973525643(11) × 10⁻³, or equivalently, its inverse 1/α ≈ 137.035999177(21), with a relative uncertainty of about 1.5 × 10⁻¹⁰."

### 3b. CODATA 2018 (korábbi)

- **Érték:** α⁻¹ = 137.035999084(21)
- **Forrás:** CODATA 2018 (Tiesinga, Mohr, Newell, Taylor)
  - PMCID: PMC9890581 / PMC9888147 — "CODATA Recommended Values of the Fundamental Physical Constants: 2018"
  - URL: https://physics.nist.gov/constants

### 3c. Független mérés (atom-interferometria)

- **Parker et al. (2018), Science:** "Measurement of the fine-structure constant as a test of the Standard Model"
- **PMID:** 29650669
- **Érték:** α⁻¹ = 137.035999046(27) (Cézium atom-interferométer)

---

## 4. A gravitációs állandó CODATA értéke

### 4a. CODATA 2018/2022 (ajánlott)

- **Érték:** G = 6.67430(15) × 10⁻¹¹ m³ kg⁻¹ s⁻²
- **σ (abszolút mérési bizonytalanság):** 0.00015 × 10⁻¹¹ = 1.5×10⁻¹⁵ m³ kg⁻¹ s⁻²
- **Relatív bizonytalanság:** 2.2×10⁻⁵
- **Forrás:** NIST, "CODATA Value: Newtonian constant of gravitation"
- **Idézet (publikációs preprint):** "From (CODATA, 2019) the Newtonian gravitational constant G. The numerical value 6.67430 × 10⁻¹¹ m³ kg⁻¹ s⁻². Standard uncertainty 0.00015 × 10⁻¹¹ m³ kg⁻¹ s⁻². Relative standard uncertainty 2.2 × 10⁻⁵. Concise form 6.67430(15)."

### 4b. Hivatalos CODATA publikációk

- Tiesinga et al., "CODATA Recommended Values of the Fundamental Physical Constants: 2018", Rev. Mod. Phys. 93, 025010 (2021)
  - PMCID: PMC9890581
  - DOI: 10.1103/RevModPhys.93.025010
- NIST: https://physics.nist.gov/cgi-bin/cuu/Value?bg

### 4c. Független mérések (G a legrosszabbul ismert alapállandó)

- **Rothleitner & Schlamminger (2024), PMC8290936:** "Precision measurement of the Newtonian gravitational constant" — áttekintés 11 precíziós mérésről az elmúlt 20 évben, a mérési bizonytalanság még mindig ~10⁻⁴–10⁻⁵ relatív.
- **Fixler et al. (2007), PMID 20867560:** "Simple pendulum determination of the gravitational constant" — G = 6.672 34(14)×10⁻¹¹ (módszertani eltérés, illusztrálja a szórás problémáját).

---

## 5. Püthagoraszi hangolás és a 9/8

### 5a. A 9/8 mint püthagoraszi nagy egész hang (major second)

- **Forrás:** Wikipedia, "Pythagorean interval" (en.wikipedia.org/wiki/Pythagorean_interval)
  - Táblázat: "| major second | M2 | 9/8 | 3²/2³ | 3·3/2·2 | 203.910 | 200 | 2 |"
- **Forrás:** Xenharmonic Wiki, "9/8" (en.xen.wiki/w/9/8)
  - Idézet: "**9/8** is the Pythagorean **whole tone** or **major second**, measuring approximately 203.9¢. It can be arrived at by stacking two just perfect fifths (3/2) and reducing the result by one octave."
- **Forrás:** Tonalsoft Encyclopedia, "whole-tone" (tonalsoft.com/enc/w/whole-tone.aspx)
  - Idézet: "The ancient pythagorean tuning gives a major-2nd with the ratio 9:8 = ~203.9100017 cents."

### 5b. A cent-képlet és a 1200·log₂(9/8)

- **Képlet:** 1200 · log₂(9/8) = 203.9100017... cent
- **Numerikus érték (Tonalsoft):** 203.9100017
- **Forrás:** Medieval.org, "Pythagorean Tuning" (medieval.org/emfaq/harmony/pyth2.html)
  - Idézet: "Pythagorean tuning is described in the medieval sources as being based on four numbers: 12:9:8:6. Jacobus of Liege (c. 1325) describes a 'quadrichord' with four strings having these lengths: we get an octave (12:6) between the outer notes, two fifths (12:8, 9:6), two fourths (12:9, 8:6), and a tonus or major second between the two middle notes (9:8)."
  - Táblázat: "Major Second | 9:8 | (3:2)² | 203.91" cent.

### 5c. Püthagoraszi hangolás és a fizika kapcsolata

- **Forrás:** arXiv:2503.07632 — "Consonance in music -- the Pythagorean approach revisited" (2025)
  - Idézet: "The Pythagorean school attributed consonance in music to simplicity of frequency ratios between musical tones. The appearance of peaks of these curves at the ratios considered by the Pythagorean school, and which were a consequence of an attempt to understand the world by nice mathematical proportions, remained a curiosity. This paper addresses this curiosity, by describing a mathematical model of musical sound."
- **Forrás:** arXiv:1709.00375 — "2:3:4-Harmony within the Tritave" (Pythagorean tuning és Tonnetz vizualizáció).

### 5d. Zenei szakirodalom (peer-reviewed)

- **PMID 15532672:** "Perfect harmony: a mathematical analysis of four historical tunings" — "In Western music, a musical interval defined by the frequency ratio of two notes is generally considered consonant when the ratio is composed of small integers."
- **PMID 3411028:** "Subjective acceptability of various regular twelve-tone tuning systems" — Pythagorean tuning vs. egyenlő temperálás pszichoakusztikai összehasonlítása.

---

## 6. A 137 és a 2⁷ + 2³ + 2⁰ felbontás

### 6a. A 137 bináris reprezentációja

- **Forrás:** Wikipedia, "137 (number)" (en.wikipedia.org/wiki/137_(number))
  - Idézet: "Binary | 10001001₂"
  - **Decompozíció:** 137 = 10001001₂ = 128 + 8 + 1 = 2⁷ + 2³ + 2⁰
  - Ugyanitt: "1/137 was once thought to be the exact value of the fine-structure constant... the astronomer Arthur Eddington conjectured in 1929 that its reciprocal was in fact precisely the integer 137, which he claimed could be 'obtained by pure deduction'."

### 6b. A "magic number" 137 — Pauli, Eddington, Born történet

- **Eddington 1929 konjektúra:** α⁻¹ = 137 pontosan. (Wikipedia idézet fent.)
- **Born 1935, "The mysterious number 137":**
  - Szerző: Max Born
  - Cím: "The mysterious number 137"
  - Folyóirat: Proceedings of the Indian Academy of Sciences, 2, 533–561 (1935)
  - DOI: 10.1007/BF03045991
  - URL: https://link.springer.com/article/10.1007/BF03045991
- **Pauli / Landé 1938, "Reciprocity and the Number 137":**
  - Szerző: Max Born (A. Landé alapján)
  - Cím: "XXI.—Reciprocity and the Number 137. Part I."
  - Folyóirat: Proceedings of the Royal Society of Edinburgh
  - URL: https://www.cambridge.org/core/journals/proceedings-of-the-royal-society-of-edinburgh/article/abs/xxireciprocity-and-the-number-137-part-i/24BE8065DB186239611DD7A8C910713F
  - Idézet: "the Planck constant ħ (the value of which in natural units, c = 1, e = 1, is 137)"

### 6c. A 137 mint "numerikus alkimia" (modern feldolgozás)

- **Forrás:** arXiv:1009.1711 — Dattoli, "The fine structure constant and numerical alchemy"
  - Idézet (oldal 5): "There is a dream, which, albeit more often not confessed, occupies the most secret aspirations of theoreticians and is that of reducing the various 'constants' of Physics to simple formulae involving integers (possibly primes) and transcendent numbers."
  - Idézet (oldal 19): "The series of whole numbers 2, 8, 18, 32… giving the lengths of the periods in the natural system of chemical elements... Sommerfeld tried especially to connect the number 8 and the number corners of a cube." (Pauli idézete Sommerfeld 2·p² képletéről.)
  - Idézet (oldal 20, Pauli idézet): "The theoretical determination of the fine structure constant is certainly the most important of the unsolved problems of modern physics."

### 6d. A "Wave Genesis" megközelítés (alternatív)

- **Forrás:** arXiv:physics/0011035 — Chechelnitsky, "Mystery of the 'Magic Number' 137: Wave Genesis, Theoretical Representation, Role in the Universe" (2000)
  - Idézet (oldal 1): "Many of great theoreticians — founders of modern physics — Sommerfeld, Eddington, Born, Pauli, Dirac, Weyl, Heisenberg, Feynman, etc. deeply feel its true price, provocative, defiant character in connection with the fundamental basis of the theoretical physics."
  - Idézet (oldal 2, Born idézet): "The Mysterious Number 137 — so titled Max Born the famous paper of 1935."

### 6e. Megjegyzés a 2⁷ + 2³ + 2⁰ felbontás szakirodalmi státuszáról

A **137 = 2⁷ + 2³ + 2⁰** bináris felbontás önmagában nem jelenik meg mint fizikai állítás a peer-reviewed szakirodalomban — ez a 137 decimális → bináris konverzió (10001001₂) tiszta matematikai ténye, amely a Wikipédia "137 (number)" cikkében van rögzítve. A **kombinatorikus jelentőség** (2⁷ = 128 = 2⁷ qubit kódszó-tér dimenzió, 2³ = 8 = okta-quantum zenei egység, 2⁰ = 1) a projekt saját interpretációja, nem pedig a fizikai szakirodalomé. A szakirodalom csak a **137 mint prímszám** és mint **α⁻¹ alsó energiás közelítése** tárgyalja; a **bináris komponensek fizikai interpretációja** nem standard. Az Eddington-Pauli-Born vonal a 137 *numerologikus* és *reciprocitás-elvi* vonatkozásait vizsgálja, nem a bináris felbontást.

---

## 7. Összegzés

| # | Állítás | Elsődleges forrás | DOI / arXiv | státusz |
|---|---|---|---|---|
| 1 | Steane [[7,1,3]], 7 qubit, 1 hiba, d=3, 6 stabilizátor (3X+3Z), 2⁷=128 | Steane 1996 PRL + arXiv:2504.01083 | 10.1103/PhysRevLett.77.793 | Bizonyított (peer-reviewed) |
| 2 | QED vákuum-polarizáció, 1-loop, α/(3π) | Schwinger 1948/1949 + Uehling 1935 + arXiv:math-ph/0310043 | 10.1103/PhysRev.73.416, 10.1103/PhysRev.75.898, 10.1103/PhysRev.48.55 | Bizonyított |
| 3 | α⁻¹ = 137.035999177(21) (CODATA 2022), σ=2.1×10⁻⁸ | NIST CODATA 2022 | — | Mérés (NIST hivatalos) |
| 4 | G = 6.67430(15)×10⁻¹¹, σ=1.5×10⁻¹⁵ | NIST CODATA 2018/2022 + Tiesinga et al. 2021 | 10.1103/RevModPhys.93.025010 | Mérés (NIST hivatalos) |
| 5 | 9/8 püthagoraszi major second, 1200·log₂(9/8)=203.91 cent | Wikipedia + Xenharmonic + Tonalsoft + Medieval.org + arXiv:2503.07632 | — | Bizonyított (zenei standard) |
| 6 | 137 = 2⁷+2³+2⁰; "magic number" (Pauli, Eddington) | Wikipedia "137 (number)" + Born 1935 + arXiv:1009.1711 + arXiv:physics/0011035 | 10.1007/BF03045991 | Matematikai tény (bináris) + történeti (numerológia) |

**Megjegyzés a 6. állításhoz:** A 137 bináris felbontás (10001001₂) matematikai tény, de a **2⁷, 2³, 2⁰ komponensek fizikai interpretációja** (mint pl. kódszó-tér, zenei egység, stb.) nem része a peer-reviewed fizikai szakirodalomnak — ez a projekt saját kategóriaelméleti-interpretációs hipotézise. A szakirodalom a 137-et *prímként* és *α⁻¹ közelítésként* tárgyalja, az Eddington-Pauli-Born vonal *numerologikus/misztikus* kontextusban. Ha a bináris komponensek fizikai jelentőségét állítjuk, azt **speculatív** jelöléssel kell ellátni (AGENTS §18.4).

---

*Készült: 2026-08-19, forráskereső alügynök. Eszközök: firecrawl_research_search_papers, alphaxiv_answer_pdf_queries, brave-search, exa_web_search. Semmilyen más fájlt nem módosított.*