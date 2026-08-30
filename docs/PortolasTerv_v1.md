# Terv — Modulok portolása a Szimába (15 modul, 4 fázis)

**Dátum:** 2026-08-27
**Cél (felhasználó, szó szerint):** *"ok, tegyuk akkor ezeket bele, csinalj tervet"*
**Szabályok:** §13 (soha ne írj felül — új fájl `_v2` vagy `_Szima` suffix-szel), §24 (kód duplikáció tilos — import, nem újraírás), §25 (ékezetes magyar), §N8 (Python tilos — csak Idris), §N11 (olvass mielőtt írsz)

---

## Fázisok

A modulokat **függőségi sorrend** szerint portoljuk: először a függetleneket (nincs külső import), aztán a közvetett függőségűeket, végül a nehézeket (sok függőség).

### FÁZIS 1 — Független modulok (9 modul, azonnal portolható)

Ezek csak `Data.Nat` vagy `Decidable.Equality` moduloktól függenek — a Szima már ezeket tartalmazza (Prelude).

| # | Modul | Honnan | Import | Port neve | Sorok | Refl bizonyítás |
|---|-------|--------|--------|-----------|-------|-----------------|
| 1 | EntropyTimeGoldstone.idr | Szima01 | Data.Nat | `GoldstoneModus_v1_Szima.idr` | 535 | CPT maszk=37, 3⁷=2187 |
| 2 | Kant7x7.idr | Szima01 | Data.Nat | `Kant49Tudat_v1_Szima.idr` | 398 | 49=7×7, 162=64+49+49 |
| 3 | Lexicon64.idr | Szima01 | Data.Nat | `Lexikon64Stabilizator_v1_Szima.idr` | 505 | 64=2⁶, Pauli X/Z |
| 4 | Abduction7.idr | Szima01 | Data.Nat | `Abdukció7_v1_Szima.idr` | 128 | 7. bit = abdukció |
| 5 | CategoryTheory64.idr | Szima01 | Data.Nat | `Kategoriaelmélet64_v1_Szima.idr` | 650 | 34 duál involúció, Steane |
| 6 | JelentesTer.idr | idris-mag | Decidable.Equality | `JelentésTérDisCoCat_v1_Szima.idr` | 234 | összefonódás, súly |
| 7 | Novelty.idr | idris-mag | Decidable.Equality | `ÚjdonságDetektor_v1_Szima.idr` | 152 | hamis riasztás = típushiba |
| 8 | KoltoiEszkoz.idr | idris-mag | Decidable.Equality | `KöltőiEszköz_v1_Szima.idr` | 262 | hasonlat = funktor |
| 9 | PermutaciosForditas.idr | idris-mag | (nincs) | `PermutációsFordítás_v1_Szima.idr` | 161 | invariáns = multiset |

**Művelet:** minden modult másoljunk a `szima_ter/modul/` könyvtárba, **§25 szerint ékezetes magyar azonosítókkal**, és ellenőrizzük, hogy lefordul-e (`idris2 -c`). A Refl-bizonyítások maradjanak meg.

### FÁZIS 2 — Közvetett függőségű modulok (3 modul)

Ezek egy másik modult importálnak, amit először portolni kell.

| # | Modul | Honnan | Függőség | Port neve | Megjegyzés |
|---|-------|--------|----------|-----------|------------|
| 10 | MorphicWord.idr | kcode | Hungarian | `MorfikusSzó_v1_Szima.idr` | Először a Hungarian.idr-t portolni (vagy a Szima `MagyarNyelvtan_v4.idr`-jét importálni) |
| 11 | Chemistry.idr | kcode | NatBits | `Kémia_v1_Szima.idr` | Először a NatBits.idr-t portolni (vagy Idris Prelude `Data.Nat`+bitműveletek) |
| 12 | Solomonoff.idr | kcode | Real, Complex, NatBits, SUSY, Fixpoint, PhysicalConstants (6) | `SolomonoffIndukció_v1_Szima.idr` | A 6 függőséget vagy portolni, vagy a Szima meglévő moduljaiból importálni (pl. `FazisKubit.idr` a Complex helyett) |

### FÁZIS 3 — Scala → Idris port (3 modul)

Ezek Scala-ban vannak, Idris-be kell portolni.

| # | Modul | Honnan | Port neve | Megjegyzés |
|---|-------|--------|-----------|------------|
| 13 | LangMathKB.scala | agi_jul25_scala | `NyelvMatematikaTudásbázis_v1_Szima.idr` | 17 nyelv↔kategóriaelmélet leképezés Idris typeclass-okként |
| 14 | SAT.scala | agi_jul25_scala | `SATCDCL_v1_Szima.idr` | CDCL, rezolúció, villa — Idris Data/Vect + Bool |
| 15 | RGFlow.scala | agi_jul25_scala | `RGÁramlás_v1_Szima.idr` | 64→101→137→137, andThen kompozíció |

### FÁZIS 4 — BabyAGI (nehéz, 8 függőség)

| # | Modul | Honnan | Függőségek | Megjegyzés |
|---|-------|--------|------------|------------|
| 16 | BabyAGI.idr | kcode | MorphicWord, Hungarian, Dirac3D, EpisodicMemory, Chinese2D, HungarianLexicon, CategoryTheory, PrimeLogic | Csak FÁZIS 1-3 után, mert 8 függőséget kell először portolni. A BabyAGI a 15 szintű AGI hierarchia — ez a "minden egybe" modul. |

---

## A portolás protokollja (minden modulnál)

1. **Olvass** (§N11): olvasd el a forrásfájlt teljes összefüggésben
2. **Grep** (§24): ellenőrizd, nincs-e már a Szimában ugyanez a függvény/típus
3. **Másolj** az új fájlba a `szima_ter/modul/` könyvtárba, `_v1_Szima` suffix-szel
4. **Ékezetesíts** (§25): minden magyar azonosítót ékezetessé tegyél (Idő, nem Ido; Szótár, nem Szotar)
5. **Rövidítés-tilalom** (§0): a konstruktor-név a VALÓSÁG neve (nincs Mk, nincs Cpt)
6. **Fordíts** (§1.0): `idris2 -c <fájl>` — ha nem fordul, javítsd
7. **Futtass** (§1.0): ha van `main`, futtasd (`idris2 --exec main`)
8. **Refl-ellenőrzés** (§18): a bizonyítások VALÓDIAK-e (két különböző konstrukció, egy híd)?
9. **Dokumentálj** (§16): a modulhoz tartozó dokumentáció a `docs/`-ba kerül

---

## Az 1. fázis konkrét lépései (9 modul, most kezdhető)

### Lépés 1.1 — GoldstoneModus_v1_Szima.idr
- Forrás: `Szima01/EntropyTimeGoldstone.idr` (535 sor)
- Import: `Data.Nat` (már van a Szimában)
- Tartalom: CPT maszk=37 (g1⊕g4⊕g6), 3⁷=2187 (unit kvaternion tér), idő-megfordítás involúció, AlgebraOp (Add/Mul/Exp), Goldstone módus = ige→főnév SSB, 4D→3D redukció
- Refl: CPT maszk 37⊕37=0, 3⁷=2187, dimenzió különbség 4-3=1, 162=2×81, 49=28+21
- **Miért:** az idő-dimenzió teremtésének magyarázata (Goldstone = ige→főnév)

### Lépés 1.2 — Kant49Tudat_v1_Szima.idr
- Forrás: `Szima01/Kant7x7.idr` (398 sor)
- Import: `Data.Nat`
- Tartalom: 7×7=49 = szabad kategória = tudat, 21 incident + 28 non-incident, 162=64+49+49, ArrowDir (Forward/Reverse = CPT), FanoPoint (7 szintaktikai pozíció), FanoLine (7 eset-hármas)
- Refl: 7×7=49, 7×3=21, 49-21=28, 64+49+49=162, 2×81=162
- **Miért:** a tudat fixpontja (49 = Y-kombinátor előfeltétele)

### Lépés 1.3 — Lexikon64Stabilizator_v1_Szima.idr
- Forrás: `Szima01/Lexicon64.idr` (505 sor)
- Import: `Data.Nat`
- Tartalom: 64 magyar szó = 2⁶ = Steane stabilizátor, 6 morfológiai bit (g1-g6), Pauli-operátorok (X=tér, Z=idő), flipBit, morphToPauli
- Refl: 2×2×2×2×2×2=64
- **Miért:** a magyar↔kvantum híd (nyelvtan = kvantumhibajavító kód)

### Lépés 1.4 — Abdukció7_v1_Szima.idr
- Forrás: `Szima01/Abduction7.idr` (128 sor)
- Import: `Data.Nat`
- Tartalom: LogicType (Deduction/Induction/Abduction), Level (L0-L7), up/down (meta/object), totalStateSpace=127, 2⁷=128
- Refl: 1+2+4+8+16+32+64=127, 2⁷=128
- **Miért:** a 7. bit = abdukció = a tudat ugrása (6→7)

### Lépés 1.5 — Kategoriaelmélet64_v1_Szima.idr
- Forrás: `Szima01/CategoryTheory64.idr` (650 sor)
- Import: `Data.Nat`
- Tartalom: 34 kategóriaelméleti fogalom, 9 duál-pár, dualInvolution (34 Refl), Free⊣Cofree adjunction, triangle identitások, monad-törvények, snake equations, Steane [[7,1,3]] (k=1, Hamming 2·29=58≤128), PSL(2,7)=168, E8=240
- Refl: 34 duál involúció, nounsAre64, verbsAre279, steaneKIs1, hammingTotal, e8Factorization, monad/comonad törvények
- **Miért:** a 34 duál involúció Refl-bizonyítása (a Szima `Alap/KategoriaT.idr`-jének kiegészítése)

### Lépés 1.6 — JelentésTérDisCoCat_v1_Szima.idr
- Forrás: `idris-mag/src/JelentesTer.idr` (234 sor)
- Import: `Decidable.Equality`
- Tartalom: Szó (tömeg), Asszociáció (élek), Haló (gráf), Evidencia, Posterior, súly (W=m·g), vonzás (diszkrét gravitáció), útHossz (BFS geodézika), összefonódás (ER=EPR)
- Refl: üresEvidenciaSemmi, súlytalanMező, egySzóNincsÖsszefonódás, bizVonzásAlmaPiros, bizÖsszefonódásAlmaPiros, bizSúlyNő
- **Miért:** a 7 rétegű jelentéselmélet 1. rétege (DisCoCat: jelentés = gravitáció)

### Lépés 1.7 — ÚjdonságDetektor_v1_Szima.idr
- Forrás: `idris-mag/src/Novelty.idr` (152 sor)
- Import: `Decidable.Equality`
- Tartalom: Tagja/NemTagja (tagsági reláció), Snapshot (portok/konténerek/unitok), Ujdonság (dependens típus, bizonyíték-mezős — hamis riasztás = típushiba), diff (csak nem-tagsági bizonyítékkal)
- Refl: (a Tagja/NemTagja Dec típusokon)
- **Miért:** a szívdobbanás GAN-diszkriminátor (a rendszer csak valódi újdonságra reagál)

### Lépés 1.8 — KöltőiEszköz_v1_Szima.idr
- Forrás: `idris-mag/src/KoltoiEszkoz.idr` (262 sor)
- Import: `Decidable.Equality`
- Tartalom: Fogalom, Reláció (6 típus: ok-okozat, tulajdonság, rész-egész, hasonlóság, sorrend, ellenét), Domén (mini-kategória), Hasonlat (EXPLICIT funktor), Bukfenc (Arisztotelészi hibák = típushibák), hallucinacioDetektor, RendszerMetafora (kommutáló diagram)
- Refl: bizNapAtomErős (LYUKAS — ?bizNapAtomLyuk), bizAlomSzovesErős (LYUKAS)
- **Miért:** a 7 rétegű jelentéselmélet 2. rétege (funktor: hasonlat = funktor, hallucináció = típushiba)

### Lépés 1.9 — PermutációsFordítás_v1_Szima.idr
- Forrás: `idris-mag/src/PermutaciosForditas.idr` (161 sor)
- Import: (nincs)
- Tartalom: Szó (List Nat), rendez (beszúrásos rendezés), azonosInvariáns (multiset), inverziók (Kendall-tau), Fordítás (költség)
- Refl: bizRendezTörpe, bizRendezettNulla, bizInverziókTörpe, bizKevertAzonos, bizMintaHelyes
- **Miért:** a 7 rétegű jelentéselmélet 6. rétege (permutációs: jelentés = permutáció-invariáns)

---

## Időbecslés

| Fázis | Modulok | Becsült idő | Függőség |
|-------|---------|-------------|----------|
| 1 | 9 | ~2 óra (mind független) | nincs |
| 2 | 3 | ~3 óra (függőségek portolása) | NatBits, Hungarian |
| 3 | 3 | ~4 óra (Scala → Idris port) | Scala értelmezés |
| 4 | 1 | ~2 óra (8 függőség már megvan) | Fázis 1-3 kész |
| **Összesen** | **16** | **~11 óra** | |

---

## Ellenőrzési szempontok (minden modulnál)

1. **Lefordul?** (`idris2 -c <fájl>`)
2. **A Refl-bizonyítások VALÓDIAK?** (§18 — két különböző konstrukció, egy híd, nem X=X)
3. **Ékezetes magyar?** (§25 — Idő, nem Ido; Szótár, nem Szotar)
4. **Rövidítés-tilalom?** (§0 — nincs Mk, nincs Cpt)
5. **Kód-duplikáció?** (§24 — grep a Szimára, nincs-e már meg ugyanez)
6. **Python-tilalom?** (§N8 — csak Idris, semmi Python)
7. **Dokumentáció?** (§16 — a modulhoz tartozó MD a docs/-ba)

---

**中文：** 计划完成：16 个模块从其他仓库移植到 Szima，分 4 个阶段。第 1 阶段（9 个无依赖模块，立即可移植）：Goldstone、Kant7x7、Lexicon64、Abduction7、CategoryTheory64、JelentesTer、Novelty、KoltoiEszkoz、PermutaciosForditas。第 2 阶段（3 个间接依赖）：MorphicWord、Chemistry、Solomonoff。第 3 阶段（3 个 Scala→Idris 移植）：LangMathKB、SAT、RGFlow。第 4 阶段（1 个困难）：BabyAGI（8 个依赖）。总计约 11 小时。所有模块带变音符号（§25）、禁止缩写（§0）、禁止代码重复（§24）、禁止 Python（§N8）。

**Deutsch:** Plan fertig: 16 Module aus anderen Repos in Szima portiert, in 4 Phasen. Phase 1 (9 unabhängige Module, sofort portierbar): Goldstone, Kant7x7, Lexicon64, Abduction7, CategoryTheory64, JelentesTer, Novelty, KoltoiEszkoz, PermutaciosForditas. Phase 2 (3 indirekte Abhängigkeiten): MorphicWord, Chemistry, Solomonoff. Phase 3 (3 Scala→Idris-Ports): LangMathKB, SAT, RGFlow. Phase 4 (1 schwer): BabyAGI (8 Abhängigkeiten). Gesamt ca. 11 Stunden. Alle Module mit Diakritika (§25), ohne Abkürzungen (§0), ohne Codeduplikation (§24), ohne Python (§N8).

**עברית: תכנית מוכנה: 16 מודולים ממאגרים אחרים ל־Szima, ב־4 שלבים. שלב 1 (9 מודולים ללא תלות, מיידי): Goldstone, Kant7x7, Lexicon64, Abduction7, CategoryTheory64, JelentesTer, Novelty, KoltoiEszkoz, PermutaciosForditas. שלב 2 (3 תלות עקיפה): MorphicWord, Chemistry, Solomonoff. שלב 3 (3 Scala→Idris): LangMathKB, SAT, RGFlow. שלב 4 (1 קשה): BabyAGI. סה״כ ~11 שעות. כל המודולים עם דיאקריטיקה (§25), ללא קיצורים (§0), ללא שכפול קוד (§24), ללא Python (§N8).}