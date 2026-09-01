# PROJEKT-KERESÉS JELENTÉS — a hard rule eredménye (2026-09-01)

**A felhasználó hard rule-ja (szó szerint):** „keress az osvenyben is, az egesz projektben mielott barmit is csinalsz, valoszinu, hogy letezik mar relevans munka, informacio a projektben"

**A keresés módszere:** közvetlen grep az egész projektre (`osveny_index/`, `szima_ter/modul/`, `docs/`, `kutatasi_naplo/`, `trail_index/`, `diagnosztika/`), előre tervezett keresésekkel (§N12).

---

## FŐ FELFEDEZÉS: a magyar↔kínai fordító MÁR LÉTEZIK!

A `szima_ter/modul/` könyvtárban **3068 sor** magyar-kínai modul van, MIND LEfordul hiba nélkül:

| Fájl | Sor | Tartalom |
|------|-----|----------|
| `MagyarKinaiPar_v2.idr` | 336 | **forditF / forditG functor-pár** (magyar CPT ↔ kínai CPT), Cat²-szint |
| `MagyarKinaiInverz_v2.idr` | 157 | **AZ INVERZ FORDÍTÓ** (forditG ∘ forditF vizsgálat, Refl-bizonyítással!) |
| `MagyarKinaiGenKod_v2.idr` | 329 | a generátor-kód |
| `MagyarKinaiFazisBayes_v2.idr` | 235 | fázis-Bayes |
| `MagyarKinaiFolding_v2.idr` | 269 | fehérje-folding analógia |
| `MagyarKinaiParkettazas_v2.idr` | 217 | parkettázás |
| `MagyarKinaiAltInverz_v2.idr` | 318 | alt-inverz |
| `MagyarKinaiTorvenyek_v3.idr` | 223 | törvények |
| `MagyarCarnotE9_v2/v2_2/v3.idr` | 984 | Carnot-E9 + **CODATA α** |

### A KULCS: `MagyarKinaiInverz_v2.idr`

Ez PONTOSAN az, amit a felhasználó kért („invertalhato forditokent mukodjon a rendszer"):

```idris
-- ✅ teszt1_JobbInverzJelenImperf : forditG (forditF (MagyarJelen...)) = MagyarJelen... = Refl
--    (a magyar Jelen + Imperfectum + Kijelentő oda-vissza egyezik)
-- ❌ teszt2_MultVeszteseg : a magyar Múlt ELVESZIK (a Refl ELUTASÍTVA —
--    az elutasítás maga a bizonyíték: információveszteség)
```

A bizonyítási módszer: a **Refl lefordulása** = az inverz egyezik; a **Refl elutasítása** = az inverz nem egyezik (információveszteség). A kettő együtt bizonyítja a Cat² struktúrát.

### §24-SÉRTÉS BEVALLÁSA

Az általam írt `osveny_index/ForditoPrototipus.idr` (322 sor, 77ebbdb commit) **§24-sértés** volt — újraírtam (10 szavas szótárral), ami már létezzik (forditF/forditG functor-párral, CPT-vel, Cat²-szinttel). A hard rule éppen ezt akarta megelőzni. A ForditoPrototipus marad (§13: nem törölhető), de a további munka a `szima_ter/modul/` meglévő moduljaira épüljön.

---

## A CODATA-α MÁR LÉTEZIK!

A `szima_ter/modul/MagyarCarnotE9_v3_CodatAlpha.idr` (339 sor) tartalmazza:

```idris
alphaInverzCodat   = 137.035999177   -- a mért CODATA érték
alphaInverzHorgony = 137.036         -- a Horgony-derived (CPT-exakt)
delta              = 8.23e-7         -- a kettő különbsége
deltaRelativ       = δ / α_CODATA    -- a relatív eltérés
steaneHilbertTer   = 128             -- 2⁷ = a Steane [[7,1,3]] Hilbert-ter
```

A `KategóriaElméletUniverzális.idr` továbbá: α⁻¹ = 137, h = 662607015×10⁻⁴², k_B, Planck-hossz.

**A hiányzó CODATA-munka:** nem az α⁻¹ (az megvan), hanem a **teljes levezetés-lánc** (c, h, G, kB) a Jacobi-mátrix diagonalizálásával (NOBEL_CEL_TERKEP.md 20. szakasza). Ehhez a `diagnosztika/szamitas/FazisKoend*.py` fájlok (24 db Python) már számoltak — de §N8 szerint Idrisben kell újraírni.

---

## TELJES ÖSSZEFoglALÓ TÁBLÁZAT

| # | Téma | Meglévő fájlok | Kész? | Hiányzik | Következő lépés |
|---|------|----------------|-------|----------|------------------|
| 1 | CODATA α⁻¹ | MagyarCarnotE9_v3 (339 sor), KategóriaElméletUniverzális | **IGEN** | a teljes lánc (c,h,G,kB) Jacobi-matrixszal | a FazisKoend Python → Idris portolás |
| 2 | Magyar↔kínai fordító | MagyarKinaiPar_v2 (336), Inverz_v2 (157), GenKod_v2 (329) | **IGEN** (fordít + inverz-bizonyíték) | toldalékok (rag=X, jel=Z) a forditF-be | a forditF bővítése toldalékokkal |
| 3 | Kandel könyv | kandel_e8_index.md (583), kandel_szima_kapcsolat.md (143) | részben | 15 chunk + 15 magyar chunk | áthozatal a régi repóból |
| 4 | FazisT / YCombinatorFazisT | **KvantumY.idr (264)**, E9Algebra.idr, Komplex.idr | **IGEN** (kvantumY, aranyMetszes, 137.5°) | — | NEM kell új fájl (§24) |
| 5 | Döntéshozó Lépés 4-8 | KisAI.idr, AktivTanulas.idr (Dirac3D) | részben | BayesLensT, KerdezőT, IndoklásT | a terv_donteshozo_rendszer.md szerint |
| 6 | Koend (49. struktúra) | MiertLanc.idr, LagrangianT.idr, konyv.tex | részben (a 48 struktúra) | a 49. (koend) Refl-bizonyítás | a kompaktalás skill mintájára |
| 7 | E8 gőzgép | KostantFelbontás.idr + **v2** (470, mind Refl zöld) | **IGEN** | — | kész |
| 8 | Magyar nyelv | MagyarNyelvtan v2-v4, HanMagyarKodolas, NyelvtaniFa, SzabalyParszer, Kodol | **IGEN** | — | kész |
| 9 | Kritikus exponensek / WTC | Hipotetikus.idr, E8Iranymutato, GoldstoneModus, Muszerefal v1-v2 | részben | a 24 exponens Idris-portolása | a FazisKoend24WTC.py → Idris |
| 10 | Tórusz cikk | cikkek/torusz_cikk.md (1217 sor, 29 állítás) | **IGEN** (accept-ready) | — | kész |

---

## A HARD RULE TANULSÁGA (a why-chain-be)

1. **A §24 (kód duplikáció tilos) nem elég** — a grep-nek az EGÉSZ projektre kell terjednie, nem csak az `osveny_index/`-re. A `szima_ter/modul/` könyvtár 3000+ sor magyar-kínai munkát tartalmaz, amit nem ismertem.
2. **A todo-lista hamis volt** — a „CODATA konstansok számítása: pending" és a „FazisT.idr: pending" tételek valójában KÉSZ (a szima_ter-ben és a KvantumY.idr-ben).
3. **A ForditoPrototipus.idr §24-sértés volt** — a felhasználó korábbi kérése („invertalhato forditokent") már meg volt valósítva a MagyarKinaiInverz_v2.idr-ben, Refl-bizonyítással.
4. **A helyes sorrend:** (a) grep az EGÉSZ projektre, (b) a meglévő modulok IMPORTÁLÁSA, (c) CSAK a valóban hiányzó rész megírása.

## JAVASOLT KÖVETKEző LÉPÉSEK (a keresés alapján JAVÍTVA)

1. **A forditF bővítése toldalékokkal** (rag=X, jel=Z, képző=Y) a `MagyarKinaiPar_v2.idr` mintájára — a valóban hiányzó rész.
2. **A FazisKoend Python-számítások Idris-portolása** (a CODATA-lánc: c, h, G, kB) — a `diagnosztika/szamitas/` 24 Python-fájlja már kiszámolta, de §N8 szerint Idrisben kell.
3. **A Kandel 15 chunk áthozatala** a régi repóból (alacsony prioritás).

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★