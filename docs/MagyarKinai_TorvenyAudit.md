# Törvény-audit — őszinte leltár (2026-08-19)

**Kérdés:** "minden kategóriaelméleti törvény be van bizonyítva? vagy csak haluhalmaz van?"
**Válasz:** részben. A független review (`docs/Review_20260819_Fuggetlen.md`)
és ez az audit együtt adja a pontos képet.

---

## 1. Fordítási státusz (idris2 --check, 0.8.0)

| Modul | Státusz |
|---|---|
| KomplexByte, Paragrafus, PiroskaSztar, PiroskaSztarTeljes, HolografikusKod49_v2_MantraModul | ✅ fordul |
| PauliAlgebra_v2 | ✅ fordul (23 bizonyítás) |
| MagyarKinaiPar_v2, MagyarKinaiInverz_v2, MagyarKinaiAltInverz_v2, MagyarKinaiFazisBayes_v2, MagyarKinaiParkettazas_v2, MagyarKinaiFolding_v2, MagyarKinaiGenKod_v2 | ✅ fordul |
| **MagyarKinaiTorvenyek_v3** (új, ebben a körben) | ✅ fordul — mind NEM-tautologikus |
| SzimaDashboard (új) | ✅ fut, 5 grafikon + JSON |
| BetuE8_v2, E8Fa_v2, MagyarNyelvtan_v2, MagyarCarnotE9_v2, MagyarCarnotE9_v2_2_CodatAlpha, HaromKategoria_v2, KetoldaliE8Fa_v2, KetoldaliKategoria_v2, HolografikusKod49 (v1), PiroskaHolografikusKod49_v2_Teljes | ❌ NEM fordul (előző session-ről maradt hibák: Neg Nat, "Missing telescope", Refl-ütközések) |

**Fontos:** a korábbi sessionben "késznek" jelzett modulok egy része NEM
fordul. Ez az audit lényege: csak a forduló modulokat tekintjük igazoltnak.

---

## 2. Bizonyítás-besorolás (a független review alapján)

Összesen 67 `biz*`/`teszt*`: **41 valódi, 20 tautológia, 6 gyenge/üres**.

**Tautológiák (nulla információ — javítandó):** `4 = 4` (Folding),
`(7,1,3) = (7,1,3)` (GenKod — a Steane-távolság CSAK deklarálva),
`3 = 3`, `20 = 20`, a δ = 8.23e-7 Refl (a definíció önmagával), stb.

**Valódi Refl-ek (a kernel ténylegesen számol):** 64 = 4³ két úton,
degeneráltság 64/20 = 3.2, a forgatás inverz-párja, a 4 információs
veszteség konkrét pontjai, a retrakciók.

**Ellentmondás, amit a review talált:** az AltInverz `AltInverzMegtalalhato`
deklarációját a modul SAJÁT Refl-jei cáfolják (Mult → Jelen, 4. tónus →
1. tónus bővítve is). A δ = 0.0 (Folding) ütközik a δ = 8.23e-7-tel.

---

## 3. Mit BIZONYÍT a MagyarKinaiTorvenyek_v3 (új, mind valódi)

| Tétel | Tartalom | Típus |
|---|---|---|
| bizCarnotHatekonyFel | η = 1 − 300/600 = 0.5 (a kernel számol) | valódi |
| bizBayesKetszer | a Bayes-frissítés kétszer = evidencia +2 | valódi |
| bizBovitProjekcioMagyar | ∀m: projekcio(bovit(m)) = m (retrakció) | valódi, univerzális |
| bizTonalitasRetrakcio | ∀t: a tonalitás oda-vissza | valódi, univerzális |
| bizAspektusMegmarad | ∀m: az aspektus túléli a körutat | valódi, univerzális |
| bizTuleloRetrakcio | F∘G = id a túlélő alkategórián (dependent) | valódi |
| bizZaiNemTulelo | **NEGATÍV:** F(G(Zai)) ≠ Zai (`Refl impossible`) | valódi |
| bizMultNemMaradMeg | **NEGATÍV:** a Múlt nem marad meg | valódi |
| bizKodonKetUt | enumeráció = 4·4·4 (két út, egy híd) | valódi |

---

## 4. MI HIÁNYZIK még (a Mac Lane / Awodey kivonatok szerint)

A `docs/KonyvKivonat_MacLane.md` 47 törvénye közül a projektre relevánsak:

| Törvény | Állapot |
|---|---|
| Funktor-azonosság F(id) = id | ❌ nincs (nincs is definiálva kategória-szerkezet a nyelveken) |
| Funktor-kompozíció F(g∘f) = F(g)∘F(f) | ❌ nincs |
| Természetességi négyzet | ❌ nincs |
| **Csere-törvény** (β'•α')∘(β•α) = (β'∘β)•(α'∘α) | ❌ nincs |
| Vertikális/horizontális kompozíció asszociativitása | ❌ nincs |
| Adjunkció háromszög-azonosságai | ❌ nincs (a forditF/forditG NEM adjunkció — ezt a v3 negatív tételei bizonyítják) |
| Bayes-tétel tényleges alakja | ⚠️ csak számláló; a valódi P(A|B)∝P(B|A)P(A) nincs formalizálva |
| Carnot-η levezetése | ⚠️ konkrét értékek Refl-lel bizonyítva, a Clausius-egyenlőtlenség nincs |
| Steane-távolság 3 → 1 hibát javít | ❌ csak deklarálva (7,1,3) |
| Yoneda | ❌ nincs |

**Következtetés:** a funktor-törvények bizonyításához előbb a nyelveken
belüli kategória-szerkezetet kell definiálni (objektumok + morfizmusok).
A forditF/forditG ma függvények, nem funktorok — ezt a review is kimondta.

---

## 5. Numerikus tesztek + dashboard (új)

- **SzimaDashboard.idr** (Idris számol): 64 kodon, 20 aminosav, 3.2
  degeneráltság, Carnot η(300/600) = 0.5, η(273/373) = 0.2680965…,
  δ = 8.229999934883381e-7, 2⁷ = 128.
- **Idris GENERÁLJA a rajzol.py-t**, a Python csak rajzol (5 PNG a
  `docs/dashboard/`-ban): cat_letra, bizonyitas_statisztika,
  genetikai_kod, carnot_ciklus, delta.
- Futtatás: `cd szima_ter/modul && idris2 --exec main SzimaDashboard.idr`
  majd `cd ../../docs/dashboard && python3 rajzol.py`.

---

## 6. Coq / Lean

- A gépen NINCS lean, coqc — nem telepítettek.
- Referencia: a RCL-cikk (arXiv:2506.12859) **Lean 4-ben** verifikált
  (179 fájl, 0 sorry) — bizonyítja, hogy a módszer (diszkrét szerkezet +
  gépi verifikáció) Leanben is működik.
- A projekt szabálya (AGENTS.md) az Idris. Az audit szerint a gond NEM a
  nyelv, hanem a bizonyítások minősége (tautológiák). Ha a felhasználó
  kéri, a kulcstételeket (retrakció, negatív tételek, csere-törvény) Lean
  4-ben is tükrözhetjük — de előbb a hiányzó kategória-szerkezetet kell
  definiálni.

---

## 7. Könyv-kivonatok (alügynökök olvasták — AGENTS §11)

| Fájl | Tartalom |
|---|---|
| docs/KonyvKivonat_Idris.md | 14 bizonyítás-technika, 6 hibafajta, 10 aranyszabály |
| docs/KonyvKivonat_MacLane.md | 47 törvény sorhivatkozással (2-kategória, csere-törvény, adjunkció, Yoneda) |
| docs/KonyvKivonat_Awodey.md | 25 törvény + nyelvi analógiák |
| docs/KonyvKivonat_Alkalmazott.md | monoidal, Clifford/Pauli, E8 (240 = 112+128), entrópia |

---

**Összegzés:** a "haluhalmaz" vád részben jogos volt (20 tautológia), de a
magja valódi (41 bizonyítás + a v3 új tételei). A következő lépés a
kategória-szerkezet definiálása a nyelveken, majd a funktor-törvények és a
csere-törvény tényleges bizonyítása. **Státusz:** audit kész, dashboard fut.
