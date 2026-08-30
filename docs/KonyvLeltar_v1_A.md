# KÖNYV-LELTÁR v1 — A–K modulok (P1a)

> Forrás: `szima_ter/szima.ipkg` modullista + az egyes fájlok elolvasása
> (§N11). A TIEK: minden A–K kezdőbetűs modul — 34 darab (31 a
> `szima_ter/modul/`-ban, 3 az `osveny_index/`-ben: `Alap.KategoriaT`,
> `HaromKubit`, `Kategoriak.MagyarOntologia`).
> Dátum: 2026-08-23. Ez a könyv-terv nyersanyaga.

---

## 1. `Alap.AlphaKözös` — `modul/Alap/AlphaKözös.idr` (163 sor)

**Mit csinál:** az Alpha-család KANONIKUS, ÉKEZETES alaprétege — a
Steane [[7,1,3]] paramétereiből levezetett α⁻¹-horgony és δ egyetlen
(ékezetes) otthona; az ékezetes nemzedék moduljai innentől IMPORTÁLJÁK (§24).

**KULCS-KIFUTÁSOK** (mind `public export`, Double):
- `n = 7.0`, `k = 1.0`, `d = 3.0`, `s = 6.0` (stabilizátorok)
- `kódszóTér = 2⁷ = 128.0`, `kiterjesztettTér = 2⁸ = 256.0`
- `stabilizátorPluszTávolság = 9.0`, `törtrész = 9/250 = 0.036`
- `egyesRész = 128+8+1 = 137.0`, `alphaBare = 137.036`
- `tisztaTér = 121.0`, `lobásásBázis = 121/128`
- `lobásásExponensEgész = 249.0`, `pithagorásziHang = 9/8`
- `logPithagorászi = ln(9/8)`, `lobásásExponens = 249+ln(9/8)`
- `delta = (121/128)^(249+ln(9/8)) ≈ 8.23e-7`
- `sigmaG = 1.5e-15`
- Nagybetűs aliasok: `DeltaKonst`, `SigmaGKonst`, `AlphaBareKonst`

**BIZONYÍTÁSOK:** nincs Refl (értékdefiníciók + aliasok).

**main:** kiírja n/k/d/s, 128, 256, 137.036, δ, σ_G — GAUGE-elv.

**Importok:** nincs (teljesen alap).

**KÁRTYA-JELÖLTEK:** a bare csatolás felépítése (137+9/250) — 1 kártya;
a lobásás-lánc (121/128 → 249 → ln(9/8) → δ) — 1 kártya. Összesen ~2 kártya.

---

## 2. `Alap.AlphaKozos` — `modul/Alap/AlphaKozos.idr` (166 sor)

**Mit csinál:** az Alpha-család kanonikus alaprétege ÉKEZET NÉLKÜL —
a v1/v2 modulok importjaihoz (§13: a régi megmarad; §24: ez az EGYETLEN
otthona `delta`/`sigmaG`-nek a nem-ékezetes névtérben).

**KULCS-KIFUTÁSOK:** ugyanazok ékezet nélkül: `kodSzoTer = 128.0`,
`kiterjesztettTer = 256.0`, `alphaBare = 137.036`, `delta ≈ 8.23e-7`,
`sigmaG = 1.5e-15`, `lobaszasBase = 121/128` + `DeltaKonst`,
`SigmaGKonst`, `AlphaBareKonst`.

**BIZONYÍTÁSOK:** nincs Refl.

**main:** ua. mint az ékezetes, magyar + kínai felirattal.

**Importok:** nincs.

**KÁRTYA-JELÖLTEK:** az iker-modulok viszonya (miért él két nemzedék) —
1 kártya a bevezetőben.

---

## 3. `AlphaE8Szigor` — `modul/AlphaE8Szigor.idr` (621 sor)

**Mit csinál:** EGYETLEN bemenetből (E8 rang = 8) szigorúan, Nat-típusokkal
levezeti a Steane [[7,1,3]] kódot, α⁻¹-t ÉS G-t — a "nincs magic number"
programmája; `Dimenzio` típus a fizikai dimenzióőrzéshez.

**KULCS-KIFUTÁSOK** (Nat): `e8Rang = 8`, `steaneD = 3`, `steaeN = 7`,
`steaeK = 1`, `stabilizatorok = 6`, `kodszoTer = 128`,
`kiterjesztettTer = 256`, `perem = 1`, `e9Clifford = 16`, `e8Gyokok = 240`,
`e8LieAlgebra = 248`, `d8Gyokok = 112`, `egyesResz = 137`,
`tortreszSzamlalo = 9`, `tortreszNevezo = 250`, `tisztaTer = 121`,
`lobaszasExponensEgesz = 249`, `pithagorasziSzamlalo = 9`,
`pithagorasziNevezo = 8`, `kapuPrim = 11`, `tukorPrim = 5`,
`ketHatvanyTukor = 40` + ugyanezek nagybetűs `*Konst` alakban.
Double: `deltaSzamitott`, `alphaDressed`, `alphaCodata = 137.035999177`,
`sigmaAlpha = 2.1e-8`, `gDressed`, `gCodata = 6.67430e-11`,
`sigmaG = 1.5e-15`.

**BIZONYÍTÁSOK** (21 Refl, Nat):
- `bizE8Rang : E8RangKonst = 8`
- `bizSteaneD : SteaneDKonst = 3`
- `bizKetD : 8 = E8RangKonst` (2^d = rang)
- `bizSteaeN : SteaeNKonst = 7`
- `bizSteaeK : SteaeKKonst = 1`
- `bizPerem : PeremKonst = 1`
- `bizStabilizatorok : StabilizatorokKonst = 6`
- `bizKodszoTer : KodszoTerKonst = 128`
- `bizKiterjesztettTer : KiterjesztettTerKonst = 256`
- `bizE9Clifford : E9CliffordKonst = 16`
- `bizE8Gyokok : E8GyokokKonst = 240`
- `bizE8LieAlgebra : E8LieAlgebraKonst = 248`
- `bizD8Gyokok : D8GyokokKonst = 112`
- `bizEgyesResz : EgyesReszKonst = 137`
- `bizTortreszSzamlalo : TortreszSzamlaloKonst = 9`
- `bizTortreszNevezo : TortreszNevezoKonst = 250`
- `bizTisztaTer : TisztaTerKonst = 121`
- `bizLobaszasExponens : LobaszasExponensKonst = 249`
- `bizTukorPrim : TukorPrimKonst = 5`
- `bizKapuPrim : KapuPrimKonst = 11`
- `bizKetHatvanyTukor : KetHatvanyTukorKonst = 40`

**main:** az E8-rangtól a két konstansig; α⁻¹: Δ/σ = 0.00017 ✅,
G: Δ/σ = 0.038 ✅; "Egy szám (r=8), két konstans, egy hibajavítás."

**Importok:** `Data.Nat`.

**KÁRTYA-JELŐLTEK** (becslés ~8 kártya): a rang→kód levezetés (2^d=rang,
n=rang−1, k=perem) — 2 kártya; a 240=256−16 és 248=240+8 gyökrendszer
— 2 kártya; a bare 137=128+8+1 + 9/250 törtrész — 2 kártya; a G
prím-szerkezete (11=kapu, 5=tükör, 40=2³×5) — 2 kártya.

---

## 4. `AlphaGCheck` — `modul/AlphaGCheck.idr` (200 sor)

**Mit csinál:** a G és α⁻¹ KETTŐS levezetése a KÖZÖS (1+9/250)^(1/40)
korrekcióból — a G a valós, az α⁻¹ a képzetes rész.

**KULCS-KIFUTÁSOK:** `A=2.0` (Horgony/oktáv), `B=3.0` (Szél/kvint),
`C=5.0` (Tükör/terc), `D=7.0` (Part/szeptim), `E=11.0` (Kapu);
`alphaInverzHorgony = 137.036`, `alphaInverzCodat = 137.035999177`,
`sigmaAlpha = 2.1e-8`, `negyven = 40`, `korrekcio = (1.036)^(1/40)`,
`GLevezetett`, `GCodata = 6.67430e-11`,
`deltaSzamitott = korrekcioMinusEgy·ln(8)/(8·9·π³)`.

**BIZONYÍTÁSOK** (4 Refl):
- `bizNegyven : NegyvenKonst = 40.0` (40 = 2³×5)
- `bizOktav : OktavKonst = 8.0` (8 = 2³)
- `bizNona : NonaKonst = 9.0` (9 = 3²)
- `bizHorgony : HorgonyKonst = 137.036` (137 + 9/250)

**main:** G Δ/σ = 0.038 ✅; α⁻¹ Δ/σ = 0.045 ✅.

**Importok:** nincs.

**KÁRTYA-JELÖLTEK** (~3 kártya): az 5 prím mint 5 zenei hang (2,3,5,7,11);
a (1+9/250)^(1/40) közös forrás; δ = k·ln(8)/(8·9·π³).

---

## 5. `AlphaLobaszas` — `modul/AlphaLobaszas.idr` (273 sor)

**Mit csinál:** a δ LOBÁSZÁS levezetése önmagában: a Steane
hibajavítás 7/128-át "költi el" lépésenként, 249+ln(9/8) lépés után a
maradék = δ = a CPT-törés maradéka.

**KULCS-KIFUTÁSOK:** `steaneHossz = 7.0`, `steaneKodszoTer = 128.0`,
`tisztaTer = 121.0`, `hibajavitasKoltseg = 7/128`, `lobaszasRata = 121/128`,
`alphaEgesz = 137.0`, `alphaTortresz = 9/250`, `alphaBare = 137.036`,
`legendrePerem = 1.0`, `pithagorasziEgeszHang = 9/8`,
`lepesSzam = 249+ln(9/8)`, `deltaSzamitott`, `alphaDressed`,
`gLevezetett = (7×11)/(2³×5²)·√3·(1+9/250)^(1/40)·10⁻¹⁰`.

**BIZONYÍTÁSOK** (5 Refl):
- `bizSteaneKodszoTer : SteaneKodszoTerKonst = 128.0`
- `bizTisztaTer : TisztaTerKonst = 121.0`
- `bizAlphaBare : AlphaBareKonst = 137.036`
- `bizLobaszasRata : LobaszasRataKonst = 121.0/128.0`
- `bizHibajavitasKoltseg : HibajavitasKoltsegKonst = 7.0/128.0`

**main:** a lobásás-görbe értékei, Δ/σ-kkal.

**Importok:** nincs.

**KÁRTYA-JELÖLTEK** (~2 kártya): a lobásás mechanizmusa (γ = 7/128,
(1−γ)ⁿ); a püthagoraszi hang mint az exponens törtrésze.

---

## 6. `AlphaSteane` — `modul/AlphaSteane.idr` (283 sor)

**Mit csinál:** az EREDETI felfedezés-modul (2026-08-19): α⁻¹ a Steane
[[7,1,3]] kódból, a teljes recept-kommentárral (a levezetés láncolata
információ — §16 szerint megőrizve az Alap.AlphaKozos-ban is).

**KULCS-KIFUTÁSOK:** `n=7`, `k=1`, `d=3`, `s=6`, `kodSzoTer=128`,
`kiterjesztettTer=256`, `alphaBare=137.036`, `delta`, `alphaDressed`,
`gLevezetett`, `gCodata`, `sigmaG`.

**BIZONYÍTÁSOK** (5 Refl):
- `bizKodSzoTer : KodSzoTerKonst = 128.0`
- `bizTisztaTer : TisztaTerKonst = 121.0`
- `bizEgyesResz : EgyesReszKonst = 137.0`
- `bizTortreszNevezo : TortreszNevezoKonst = 250.0`
- `bizLobaszasExponensEgesz : LobaszasExponensEgeszKonst = 249.0`

**main:** a levezetés lépésről lépésre + Δ/σ-k.

**Importok:** nincs.

**KÁRTYA-JELÖLTEK** (~3 kártya): az alap-képlet
α⁻¹ = 2ⁿ+2ᵈ+1+(s+d)/(2^(n+1)−s); a történeti kártya (a felfedezés).

---

## 7. `AlphaSteaneDashboard` — `modul/AlphaSteaneDashboard.idr` (437 sor)

**Mit csinál:** 17 lépéses DASHBOARD-generátor — Idris számol, és a
`docs/dashboard_alphasteane/`-ba ír: JSON-adatokat, Python-plottert
(5 grafikon) és HTML-oldalt; minden lépéshez MIÉRT + hivatkozás (DOI/arXiv/PMID).

**KULCS-KIFUTÁSOK:** `Lepes` rekord (sorszam, cim, keplet, ertek, miert,
hivatkozas); `lepesek : List Lepes` — 17 elem; `adatokJson`, `rajzoloPython`
(matplotlib: lobásás-görbe, konvergencia, α-összehasonlítás, G-összehasonlítás,
konstansok-táblázat), `htmlFejlec`/`htmlLablec`, `teljesHtml`.

**BIZONYÍTÁSOK:** nincs helyi Refl (az értékek importált AlphaSteane-ből).

**main:** megírja a 3 fájlt + konzol-összefoglaló (α: 0.00017, G: 0.038).

**Importok:** `AlphaSteane`, `TetrapodaTest`, `System.File`.

**KÁRTYA-JELÖLTEK** (~4 kártya): a 17 lépés táblázata; a base-10 = 2×5
(137 = [k,d,n] számjegyei); a test-szimmetriák (2/4/5 — tetrapodia,
pentadactylia, Hox-gének: Shh→Hoxa11→Hoxa13); a dashboard szerkezete.

---

## 8. `AlphaSteaneE8` — `modul/AlphaSteaneE8.idr` (341 sor)

**Mit csinál:** KÉT bemenet (E8 rang = 8, [n,k,d]=[7,1,3]) — n = rang−1,
M = 2^rang, perem = r−n = a Cartan; α⁻¹ és G ugyanabból a szerkezetből.

**KULCS-KIFUTÁSOK:** `e8Rang = 8.0`, `n = e8Rang−1 = 7.0`, `perem = 1.0`,
`kodSzoTer = 2^(r−1) = 128`, `kiterjesztettTer = 2^r = 256`,
`kapuPrim = 11`, `tukorPrim = 5`, `ketHatvanyTukor = 40`, `gBare`, `gDressed`.

**BIZONYÍTÁSOK** (10 Refl):
- `bizE8Rang : E8RangKonst = 8.0`
- `bizPerem : PeremKonst = 1.0`
- `bizKodSzoTer : N = 128.0`
- `bizKiterjesztettTer : M = 256.0`
- `bizEgyesResz : EgyesReszKonst = 137.0`
- `bizTortreszNevezo : TortreszNevezoKonst = 250.0`
- `bizLobaszasExponensEgesz : LobaszasExponensEgeszKonst = 249.0`
- `bizTukorPrim : TukorPrimKonst = 5.0`
- `bizKapuPrim : KapuPrimKonst = 11.0`
- `bizKetHatvanyTukor : KetHatvanyTukorKonst = 40.0`

**main:** "2 bemenet → 2 kimenet (α⁻¹: 0.00017, G: 0.038)".

**Importok:** nincs.

**KÁRTYA-JELÖLTEK** (~2 kártya): a rang-híd (n = r−1, a +1 = Cartan);
a G_bare × (1+9/250)^(1/40) szerkezet.

---

## 9. `AlphaSteaneVegso` — `modul/AlphaSteaneVegso.idr` (400 sor)

**Mit csinál:** A VÉGSŐ LEVEZETÉS — a legrészletesebb kommentlánc
(15 lépés), benne a 9/250 G-ből való KIVEZETÉSE és a CPT iránya
(C=α KIVON, P=G HOZZÁAD, T=a lobásás lépésszáma).

**KULCS-KIFUTÁSOK:** ua. mint az AlphaSteane + `gBare`, `gDressed`,
`ketHatvanyTukor = 40`.

**BIZONYÍTÁSOK** (8 Refl):
- `bizKodSzoTer : KodSzoTerKonst = 128.0`
- `bizTisztaTer : TisztaTerKonst = 121.0`
- `bizEgyesResz : EgyesReszKonst = 137.0`
- `bizTortreszNevezo : TortreszNevezoKonst = 250.0`
- `bizLobaszasExponensEgesz : LobaszasExponensEgeszKonst = 249.0`
- `bizTukorPrim : TukorPrimKonst = 5.0`
- `bizKapuPrim : KapuPrimKonst = 11.0`
- `bizKetHatvanyTukor : KetHatvanyTukorKonst = 40.0`

**main:** a 9/250 kivezetése futásidőben: `(G/G_bare)^40 − 1 = 9/250 ✅`.

**Importok:** nincs.

**KÁRTYA-JELÖLTEK** (~3 kártya): a 15 lépéses levezetés-ábra; a CPT
irány-táblázat; a 137 = [k,d,n] base-10 kártya.

---

## 10. `Alap.KategoriaT` — `osveny_index/Alap/KategoriaT.idr` (444 sor)

**Mit csinál:** 49 KATEGÓRIAELMÉLETI STRUKTÚRA MIND TYPECLASS-KÉNT
(Awodey 39 + Mac Lane 10) — a könyv formális gerince; a törvények
(típusok!) a Curry–Howard-szerződés részei.

**KULCS-KIFUTÁSOK** (49 interface, 10 szintbe rendezve):
- Szint 1: `KategoriaT` (identitas, kompozicio + balAzonos, jobbAzonos,
  asszociativ), `FelcsoportT`, `ElorerendezesT`, `ReszbenrendezettHalmazT`,
  `EllenkezoKategoriaT`
- Szint 2: `FunktorT` (morfizmusKep), `TermeszetesTranszformacioT`
  (komponens), `TermeszetesIzomorfizmusT`, `FunktorKategoriaT`
- Szint 3: `MonoidT`, `CsoportT` (inverz), `IzomorfizmusT`,
  `MonomorfizmusT`, `EpimorfizmusT`
- Szint 4 (limitek): `KezdoObjektumT`, `VegobjektumT`, `SzorzatT`,
  `KoszorzatT`, `KiegyenlitoT`, `KokiegyenlitoT`, `VisszahuzasT`,
  `KitolasT`, `LimeszT`, `KolimeszT`
- Szint 5: `ExponencialT`, `KartezianusZartKategoriaT`, `HeytingAlgebraT`,
  `BooleAlgebraT`
- Szint 6: `AdjunkcioT` (adjunkcioEgyseg/Koegysseg), `MonadT`, `KomonadT`
- Szint 7 (Mac Lane): `MonoidalisKategoriaT` (tenzor, asszociator —
  "a magyar agglutináció: tő ⊗ képző ⊗ rag = szó"), `FonottMonoidalisKategoriaT`
  (fonas), `SzimmetrikusMonoidalisKategoriaT`, `ZartKategoriaT` (belsoHom)
- Szint 8: `KettoKategoriaT` (függőleges/vízszintes összetétel),
  `BikategoriaT` (asszociator 2-sejtekre)
- Szint 9: `KanKiterjesztesT` (jobbKan, balKan), `EndT` (vegObjektum,
  vegErosites), `KoendT` (kovegObjektum, kovegErosites)
- Szint 10: `ToposzT` (reszobjektumOsztalyozo, igazNyil),
  `ReszobjektumT`, `YonedaBeagyazasT`, `KategoriakEkvivalenciajaT`,
  `SzeletKategoriaT`, `SzabadKategoriaT`, `ReprezentalhatoFunktorT`,
  `CsoportKategoriabanT`

**BIZONYÍTÁSOK:** nincs Refl — maguk az interface-törvények a
bizonyítandók (a könyvben ez a definíció-gyűjtemény fejezet).

**main:** nincs.

**Importok:** nincs.

**KÁRTYA-JELÖLTEK** (~20 kártya): minden szinthez 1-3 strukturális kártya
(a KategoriaT törvényei; a limit-kolimit tükör-párok; a monoidális
kategória mint agglutináció; adjunkció mint perem; Kan/End/Coend;
toposz; 2-kategória). Ez a könyv II. része váza.

---

## 11. `E8BelsoSzorzat` — `modul/E8BelsoSzorzat.idr` (227 sor)

**Mit csinál:** a 240×240 belső szorzat-tábla anatómiája + a
Weyl-reflexiók zártságának kimerítő ellenőrzése (E8-anatómia 1. lépés).

**KULCS-KIFUTÁSOK:** `belsoszorzat` (értékek {−8,−4,0,+4,+8}),
`gyokKulonbseg`, `gyokSkalar`, `gyokEllentett`,
`weylReflexio : σ_α(β) = β − (⟨α,β⟩/4)·α`,
`eloszlas` (minden gyökre (1,56,126,56,1)), `zarasHibakSzama`,
`eloszlasHibakSzama` (futásidőben 0).

**BIZONYÍTÁSOK** (6 Refl):
- `BizSzorzatT1T2 : belsoszorzat (2,2,0⁶) (1⁸) = 4`
- `BizSzorzatEllentett : belsoszorzat (2,2,0⁶) (−2,−2,0⁶) = -8`
- `BizSzorzatMeroleges : belsoszorzat (2,2,0⁶) (2,−2,0⁶) = 0`
- `BizReflexioOnmagara : weylReflexio α α = E8GyokKonstruktor (-2) (-2) 0…`
- `BizReflexioMeroleges : weylReflexio α β⊥ = β⊥`
- `BizReflexioSzomszed : weylReflexio α β = (0,−2,2,0⁵)`

**main:** eloszlás (1,56,126,56,1) minden gyökre; 57 600 reflexió
mind gyök (0 hiba).

**Importok:** `E8Gyokok_v2`.

**KÁRTYA-JELÖLTEK** (~4 kártya): a 2-szeres skála (norma²=8, simply-laced);
az (1,56,126,56,1) eloszlás; a Weyl-reflexió képlete; a 57 600=szög-spektrum.

---

## 12. `E8BelsőSzorzat` — `modul/E8BelsőSzorzat.idr` (216 sor)

**Mit csinál:** az előző ÉKEZETES nemzedéke (belsőSzorzat, gyökKülönbség,
weylReflexió, eloszlás, zárásHibákSzáma); §24: a `benVan` helyett a
standard `elem`.

**BIZONYÍTÁSOK** (6 Refl): `BizSzorzatT1T2`, `BizSzorzatEllentett`,
`BizSzorzatMerőleges`, `BizReflexióÖnmagára`, `BizReflexióMerőleges`,
`BizReflexióSzomszéd` — ugyanazok ékezetesen.

**Importok:** `E8Gyökök`.

**KÁRTYA-JELÖLTEK:** az iker-modulok kártyája (1).

---

## 13. `E8Fa_v3` — `modul/E8Fa_v3.idr` (315 sor)

**Mit csinál:** a magyar nyelv hierarchikus E8-fája — 5 szint
(Levél→Szotag→Szo→Mondat→Gondolat), minden szinten Carnot-ciklus,
a δ szintenként duplázódik (hierarchikus hibajavítás).

**KULCS-KIFUTÁSOK:** `FaSzint` (Levél|Szotag|Szo|Mondat|Gondolat),
`faSzintErtek`, rekordok: `BetuFa`, `SzotagFa`, `SzoFa`, `MondatFa`,
`GondolatFa`; `faSzintCarnot`, `deltaSzint : FaSzint → Double`
(δ·2^szint), `alfaSzinten`, `javitasSzint` (1/2/4/8/16),
`totalJavitas = 31`, `szimmetriaSzinten`, `ForgatasEredmenye`,
`atlagosDeltaSzint`, `piroskaFaMondatokSzama = 22`,
`piroskaFaMagassag = 5`, `piroskaDeltaGondolat = 16δ`.

**BIZONYÍTÁSOK** (7 Refl):
- `bizFaOtSzint : faSzintErtek Levél + … + faSzintErtek Gondolat = 10`
- `bizTotalJavitas : TotalJavitasKonst = 31`
- `bizPiroskaDeltaGondolat : deltaSzint Gondolat = DeltaSzorTizenhat`
- `bizLevélDelta : deltaSzint Levél = DeltaKonst`
- `bizGondolatDelta : deltaSzint Gondolat = DeltaSzorTizenhat`
- `bizPiroskaMagassag : PiroskaFaMagassagKonst = 5`
- `bizPiroskaJavitas : TotalJavitasKonst = 31`

**main:** nincs (a v3 import-gyógyítás, tartalom változatlan).

**Importok:** `MagyarNyelvtan_v4`, `MagyarCarnotE9_v3_CodatAlpha`.

**KÁRTYA-JELÖLTEK** (~4 kártya): az 5 szint fá-ábrája; a δ-hierarchia
(δ,2δ,4δ,8δ,16δ); az 1+2+4+8+16=31=2⁵−1 javítás; a Piroska-mese
mint 22 GondolatFa-level.

---

## 14. `E8FazisKapcsolat` — `modul/E8FazisKapcsolat.idr` (230 sor)

**Mit csinál:** a FÁZIS-KVANTÁLÁS bizonyítható magja: az E8 gyökpárok
közti szög csak a 5 kristallográfiai érték (0/60/90/120/180°) — a rács
a fázist öt értékre kvantálja; + a Steane CSS-híd (H·Hᵀ≡0 mod 2).

**KULCS-KIFUTÁSOK:** `koszinSzamlalo` (= ⟨α,β⟩),
`kristallografiaiSzog : −8→180, −4→120, 0→90, +4→60, +8→0`,
`forgasRend : 0°→1, 180°→2, 120°→3, 90°→4, 60°→6`,
`fazisKvantalasHibak` (0 az 57 600 párra), `fazisSpektrum = eloszlas`,
`hSorok` (3×7 Hamming-mátrix), `gf2Pontszorzat` (a VÉGÉN mod 2!),
`cssHibak` (0 a 9 sorpárra), `fazisGondolatok` (SPECULATÍV szakasz).

**BIZONYÍTÁSOK** (8 Refl):
- `BizFazisEllentett : koszinSzamlalo (2,2,0⁶) (−2,−2,0⁶) = -8`
- `BizFazisHatvan : koszinSzamlalo (2,2,0⁶) (2,0,2,0⁵) = 4`
- `BizFazisKilencven : koszinSzamlalo (2,2,0⁶) (2,−2,0⁶) = 0`
- `BizRendek : (forgasRend 60 = 6, forgasRend 90 = 4)`
- `BizRendekTobb : (forgasRend 0 = 1, forgasRend 180 = 2, forgasRend 120 = 3)`
- `BizHCssOnmaga : gf2Pontszorzat [0,1,1,1,1,0,0] [0,1,1,1,1,0,0] = 0`
- `BizHCssPar : gf2Pontszorzat [0,1,1,1,1,0,0] [1,0,1,1,0,1,0] = 0`
- `BizHSuly : length (filter (== 1) [0,1,1,1,1,0,0]) = 4`

**main:** a kvantálás + a CSS-ellenőrzés + a spekulatív gondolatok.

**Importok:** `E8Gyokok_v2`, `E8BelsoSzorzat`, `E8TizenhatPenge` (gf2).

**KÁRTYA-JELÖLTEK** (~4 kártya): a 5 szög ↔ 5 rend ({1,2,3,4,6}) tábla;
a (1,56,126,56,1) fázis-spektrum; a CSS-feltétel (X/Z-kommutálás);
a "kvantumszámítógép = TÁVÍRÓ" sejtés (jelölve: SPECULATÍV).

---

## 15. `E8FazisKapcsolat_v2` — `modul/E8FazisKapcsolat_v2.idr` (227 sor)

**Mit csinál:** a 2. fázis magva: a Weyl-tükrözés mint FÁZIS-ÁTMENET a
120 szimbólum-ú pozitív gyökábécén, a [[7,1,3]]-mal összekötve — mindent
IMPORTÁL (§24), semmit nem ír újra.

**KULCS-KIFUTÁSOK:** `előNemNulla`, `pozitivGyok`, `pozitivGyokok`
(120 szimbólum), `weylFazisLepes : c = ⟨α,β⟩/4 ∈ {−2,−1,0,+1,+2}`,
`weylFazisAtmenet : (E8Gyok, Integer)`, `fazisSzogDouble`,
`weylFazisKubit`, `steaneHetBitNevek` ([idő,okság,tér,szín,hang,fázis,mód]),
`steaneFazisIndex = 5` (0-alapú).

**BIZONYÍTÁSOK** (5 Refl):
- `BizTukrozésNégyzete : weylReflexio α (weylReflexio α β) = β`
- `BizKifordulasKapcsolat : weylReflexio α α = gyokEllentett α`
- `BizPozitivTukorNegativ : pozitivGyok (weylReflexio α α) = False`
- `BizFazisBitHíd : SteaneFazisIndexKonst = 5`
- `BizFazisLepesZart : weylFazisLepes (2,2,0⁶) (2,0,2,0⁵) = 1`

**main:** pozitív ábécé 120; a fázis-átmenet példa; CSS importtal.

**Importok:** `FazisKubit`, `E8BelsoSzorzat`, `E8Gyokok_v2`, `Data.List`,
`Data.Maybe`, `Data.Fin`, `E8TizenhatPenge`, `E8FazisKapcsolat`.

**KÁRTYA-JELÖLTEK** (~3 kártya): a pozitív/negatív ábécé (240/2=120);
σ²=id mint a tükör involúció; a "fázis-bit = 6. bit" két-út híd.

---

## 16. `E8FázisKapcsolat` — `modul/E8FázisKapcsolat.idr` (233 sor)

**Mit csinál:** a 14. modul ÉKEZETES ikermodernje (koszinuszSzámláló,
kristallográfiaiSzög, forgásRend, fázisKvantálásHibák, cssHibák).

**BIZONYÍTÁSOK** (8 Refl): `BizFázisEllentett`, `BizFázisHatvan`,
`BizFázisKilencven`, `BizRendek`, `BizRendekTöbb`, `BizHCssÖnmaga`,
`BizHCssPár`, `BizHSúly`.

**Importok:** `E8Gyökök`, `E8BelsőSzorzat`, `TizenhatPenge`.

**KÁRTYA-JELÖLTEK:** l. a 14. modult (közös kártyák).

---

## 17. `E8Gyokok_v2` — `modul/E8Gyokok_v2.idr` (358 sor)

**Mit csinál:** a 240 E8-gyök (240 SZIMBÓLUM) INTEGER kernellel — a v1
Nat-kernel-robbanásának gyógyíra; a Weyl-csoport rendje is Integer.

**KULCS-KIFUTÁSOK:** `E8Gyok` rekord (8 Integer), `gyokNorma` (=8),
`tipus1GyokTeljes`, `pozicioParok` (28), `elojelParok` (4),
`tipus1Gyokok` (112), `minuszokSzama`, `parosNat`, `parosParitas`,
`osszesElojel` (256), `gyokLista`, `listaGyokke`, `tipus2Gyokok` (128),
`e8Gyokok` (240), `Faktorialis`, `WeylD8Rend = 5160960`,
`TrialitySzazharmincot = 135`, `WeylE8Rend = 696729600`,
`gyokSzimbolum` (+,·,0,−,–), `elsoN`, `gondolatok`.

**BIZONYÍTÁSOK** (13 Refl, Integer):
- `bizFaktorialisNyolc : Faktorialis 8 = 40320`
- `bizFaktorialisPrim : 128 * 9 * 5 * 7 = 40320`
- `bizTipusEgy : 28 * 4 = 112`
- `bizTipusKetto : 256 = 128 + 128`
- `bizE8GyokSzam : 112 + 128 = 240`
- `bizGyokPluszTizenhat : 240 + 16 = 256`
- `bizTipus1Norma : gyokNorma (tipus1GyokTeljes 1 2 1 1) = 8`
- `bizTipus2Norma : gyokNorma (1⁸) = 8`
- `bizWeylD8 : WeylD8Rend = 5160960`
- `bizSzazharmincot : TrialitySzazharmincot = 135`
- `bizWeylE8 : WeylE8Rend = 696729600`
- `bizWeylE8Prim : 16384 * 243 * 25 * 7 = 696729600` (KÉT ÚT: struktúra ⟷ prímek)
- `bizE8Dimenzio : 240 + 8 = 248`

**main:** 112/128/240 számlálás futásidőben; normák; W(E8); az első
12 szimbólum írásjelei.

**Importok:** nincs.

**KÁRTYA-JELÖLTEK** (~6 kártya): a két gyöktípus (112 D8 + 128 fél-egész
demiocteract); a Nat-vs-Integer kernel-tanulság; 8! két úton; W(D8)=2⁷·8!;
a trialitás-135; W(E8)=696 729 600 prímfelbontása; 240+16=256 híd;
a szimbólum-írásrendszer.

---

## 18. `E8Gyökök` — `modul/E8Gyökök.idr` (358 sor)

**Mit csinál:** az előző ÉKEZETES nemzedéke (E8Gyök, gyökNorma,
típus1GyökTeljes, pozícióPárok, előjelPárok, összesElőjel, listaGyökké,
Faktoriális, WeylD8Rend, TrialitásSzázharmincöt, gyökSzimbólum);
§24: az `elsoN` helyett standard `take`.

**BIZONYÍTÁSOK** (13 Refl): `bizFaktoriálisNyolc`, `bizFaktoriálisPrím`,
`bizTípusEgy`, `bizTípusKettő`, `bizE8GyökSzám`, `bizGyökPluszTizenhat`,
`bizTípus1Norma`, `bizTípus2Norma`, `bizWeylD8`, `bizSzázharmincöt`,
`bizWeylE8`, `bizWeylE8Prím`, `bizE8Dimenzió`.

**Importok:** `Data.List` (take).

**KÁRTYA-JELÖLTEK:** közös a 17-essel.

---

## 19. `E8TizenhatPenge` — `modul/E8TizenhatPenge.idr` (276 sor)

**Mit csinál:** a Cl(4) 16 pengéje (bitmask 0..15) + a Hamming [7,4,3]
kód + a 256-os híd: 240 gyök (TARTALOM) + 16 penge (KERET) = 1 bájt.

**KULCS-KIFUTÁSOK:** `tizenhatPenge` [0..15], `pengeFok` (popcount),
`pengeDual : 15−x` (Hodge), `fokSzamlalok` = (1,4,6,4,1), `gf2`,
`generaloSorok` (4×7 G-mátrix), `kodszamitas` (m·G mod 2, a 7 bit:
[idő,okság,tér,szín,hang,fázis,mód]), `osszesUzenet` (16),
`mindenKodszo` (16), `kodSuly`, `hammingTavolsag`, `egyedi`,
`parTavolsagok`, `mindLegalabbHarom`, `vanHarom`, `pengeGondolatok`.

**BIZONYÍTÁSOK** (9 Refl):
- `BizFokszamOsszeg : 1 + 4 + 6 + 4 + 1 = 16`
- `BizKettoNegyedik : 2 * 2 * 2 * 2 = 16`
- `BizHodgePelda : pengeDual 3 = 12`
- `BizHodgeInvolutioPelda : pengeDual (pengeDual 5) = 5`
- `BizKodszoElso : kodszamitas [1,0,0,0] = [1,0,0,0,0,1,1]`
- `BizKodszoMindEgyes : kodszamitas [1,1,1,1] = [1,1,1,1,1,1,1]`
- `BizSulyOsszeg : 1 + 7 + 7 + 1 = 16`
- `BizHid : 240 + 16 = 256`
- `BizKettoNyolcadik : 256 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2`

**main:** fokszámok (1,4,6,4,1); Hodge-involúció mind a 16-on; a 16
kódszó (egyedi, súlyeloszlás (1,7,7,1), d=3); a 240+16=256 híd.

**Importok:** `E8Gyokok_v2`.

**KÁRTYA-JELÖLTEK** (~5 kártya): a Cl(4) grading (1,4,6,4,1); a Hodge-duál
k↔4−k; a Hamming G-mátrix és a 16 kódszó; a (1,7,7,1)↔(1,4,6,4,1)
"testvér" szimmetria; a 256-os híd (KÉT ÚT: kombinatorika ⟷ binomiális).

---

## 20. `E8Iranymutato_v1` — `modul/E8Iranymutato_v1.idr` (162 sor)

**Mit csinál:** "E8 — MIÉRT KIVÉTELES?" dashboard-mutatók rekordban +
kernel-bizonyítások — mindent IMPORTÁL (§24), semmit nem ír újra.

**KULCS-KIFUTÁSOK:** `E8IranymutatoMutatok` rekord: gyokSzam=240,
weylCsoportRend=696729600, e8Dimenzio=248, e8E8Dimenzio=496,
isingAlfa=0, isingBeta=0.125, isingGamma=1.75, isingNu=1,
univerzalitasiOsztaly="2D Ising (Z2 szimmetria-torés)";
`gyokSzamSzamitott`, `tipus1SzamSzamitott`, `tipus2SzamSzamitott`,
`hid256Szamitott`, `mindenGyokNormajaNyolc` (futásidőben True).

**BIZONYÍTÁSOK** (5 Refl):
- `TipusOsszegBizonyit : 112 + 128 = 240`
- `WeylRendFelezettBizonyit : 2 * 348364800 = 696729600`
- `WeylRendPrimtenyezosBizonyit : 16384 * 243 * 25 * 7 = 696729600`
- `E8E8DimenzioBizonyit : 248 * 2 = 496` (heterotikus string)
- `GyokFelezesBizonyit : 240 = 2 * 120`

**Importok:** `E8Gyokok_v2`, `E8BelsoSzorzat`, `E8TizenhatPenge`.

**KÁRTYA-JELÖLTEK** (~3 kártya): a mutató-tábla (240/696M/248/496);
a 496 = heterotikus string dimenzió; a 2D Ising exponensek.

---

## 21. `E8Univerzalitas_v1` — `modul/E8Univerzalitas_v1.idr` (462 sor)

**Mit csinál:** univerzalitási osztályok PONTOS kritikus exponensei
törteként (skálázott Integer) + a skálacímkék kernel-bizonyítása KÉT
FÜGGETLEN ÚTTAL; a 3D Ising konform-bootstrap értékei különbség-
ellenőrzéssel (nem Refl — §17/§18).

**KULCS-KIFUTÁSOK:** `ExponensTört` rekord (számláló/nevező Integer),
`exponensTörtÉrték`; 2D Ising (nyolcadok): AlfaNyolcad=0, BétaNyolcad=1,
GammaNyolcad=14, NúNyolcad=8, NúEgész=1, ÉtaNegyed=1, GammaNegyed=7;
2D perkoláció (72-edek): Alfa=−48, Béta=10, Gamma=172, Nú=96, Éta=15;
2D önkerülő séta: AlfaNegyed=2, BétaHatvannegyed=5,
GammaHarminckettő=43, NúNegyed=3, ÉtaHuszonnegyed=5,
GammaKilencvenhatod=129, AlfaHatvannegyed=32, GammaHatvannegyed=86;
3D közelítő: alfa=0.11008708, béta=0.32641871, gamma=1.23707551,
nú=0.62997097, éta=0.036297612 + maradékok (tűrés 10⁻⁶).

**BIZONYÍTÁSOK** (10 Refl):
- `RushbrookeKétDimenziósIsingNyolcadokban : 0 + 2*1 + 14 = 2*8`
- `HiperskálázásKétDimenziósIsingNyolcadokban : 2*8 − 0 = 2*8`
- `FisherKétDimenziósIsingNegyedekben : 1*(2*4 − 1) = 7`
- `MértékváltásKétDimenziósIsingGamma : 2*7 = 14`
- `RushbrookeKétDimenziósPerkolációHetvenkettedekben : −48 + 2*10 + 172 = 2*72`
- `HiperskálázásKétDimenziósPerkolációHetvenkettedekben : 2*72 − (−48) = 2*96`
- `FisherKétDimenziósPerkolációHetvenkettedekben : 96*(2*72 − 15) = 72*172`
- `RushbrookeÖnkerülőSétaHatvannegyedekben : 32 + 2*5 + 86 = 2*64`
- `HiperskálázásÖnkerülőSétaNegyedekben : 2*4 − 2 = 2*3`
- `FisherÖnkerülőSétaKilencvenhatodokban : 3*(2*24 − 5) = 129`

**main:** mindhárom pontos osztály + a 3D maradékok + az
E8Iranymutato-importtal való egyezés.

**Importok:** `E8Iranymutato_v1`.

**KÁRTYA-JELÖLTEK** (~6 kártya): a három skálacímke (Rushbrooke
α+2β+γ=2; hiperskála 2−α=dν; Fisher γ=ν(2−η)); a 2D Ising frakciók;
a perkoláció 72-edek (SLE₆, Smirnov–Werner); a önkerülő séta
(Nienhuis ν=3/4); a 3D bootstrap értékek (Chang et al. 2025,
arXiv:2411.15300); a mértékváltás-technika.

---

## 22. `FazisKubit` — `modul/FazisKubit.idr` (371 sor)

**Mit csinál:** a felhasználó tézisének ("a bitnek a mértékegysége a
fázis") formális kidolgozása: a 2→3 átmenet (bit + fázis = Bloch-gömb),
a mérés és az összefonódás, a makroszkopikus fázismérés.

**KULCS-KIFUTÁSOK:** `fazisEgyseg : e^{iθ}`, `iEgyseg`, `KomplexEgesz`
rekord, `egeszSzoroz`, `FazisKubit` rekord (theta, fi), `valoszinusegNulla`
(Born-szabály), `blochX/Y/Z`, `MeresiKimenet`, `kiszedetlenInformacio`
(von Neumann-entrópia), `josephsonAram : I₀·sin(Δφ)`,
`bitAllapotok = 2`, `fazisSzogek = 1`, `blochDimenziok = 3`,
`alfaInverzValos = 137.035999177`, `deltaFazis = 8.23e-7`,
`komplexCsataslas`, `csatolasFazis = atan(δ/α⁻¹)`.

**BIZONYÍTÁSOK** (4 Refl):
- `bizIKet : egeszSzoroz i i = KomplexEgeszKonstruktor (-1) 0`
- `bizINegyedik : i⁴ = KomplexEgeszKonstruktor 1 0`
- `bizBlochHarom : BlochDimenziokKonst = 3`
- `bizBitKetto : BitAllapotokKonst = 2`

**main:** i²=−1, i⁴=+1; a 2→3 átmenet; P(0), entrópia; Josephson;
a komplex csatolás fázisa.

**Importok:** `KomplexByte`.

**KÁRTYA-JELÖLTEK** (~5 kártya): a tézis (fázis = mértékegység);
a 2→3 átmenet ábrája; a mérés→összefonódás (|E₀⟩/|E₁⟩); a négy
makroszkopikus fázismérés (interferencia, AB, Josephson, Berry);
a γ⁵ = i·γ⁰γ¹γ²γ³ (a fázis a legmagasabb grade).

---

## 23. `FazisAlgebra_v2` — `modul/FazisAlgebra_v2.idr` (84 sor)

**Mit csinál:** a CPT-mag fordítható újraalapozása (a v1 nem fordul —
§13 szerint új fájl): `ToltesParitasIdo` (C=saját tudat, P=másik fél,
T=kapcsolat fázisa) a HaromKubit importjaira építve.

**KULCS-KIFUTÁSOK:** `ToltesParitasIdo` rekord (töltés, paritás, idő :
HaromKubit), `töltésParitásIdőKoherens`, `töltésParitásIdőIrány`,
`fazisFaktorialis` (1.0 / 0.5 / 0.0 koherencia).

**BIZONYÍTÁSOK:** nincs Refl (a szerkezet új alapokra áll).

**Importok:** `HaromKubit`.

**KÁRTYA-JELÖLTEK** (~2 kártya): a CPT három rétege (fizikai/nyelvtani/
pszichofizikai — AGENTS §9); a fazisFaktorialis koherencia-skála.

---

## 24. `Fogalom_v1` — `modul/Fogalom_v1.idr` (408 sor)

**Mit csinál:** a 3 dimenziós nyelv MÁSODIK EMELETE: Fogalom =
GyökSzó × D8-pálya (112 egész / 128 fél-egész) × JK-kategória;
a W(E8)-pálya triviumának kutatási indoklása a fejlécben.

**KULCS-KIFUTÁSOK:** `D8Pálya` (EgészGyökPálya | FélEgészGyökPálya),
`pályaOsztályból : SzóOsztály → D8Pálya`, `Fogalom` rekord (gyökSzó,
pálya, kategória), `Eq JK` + `Show JK` (11 kategória), `fogalomKészít`,
`alapKategória` (egész→IndividuumJK, fél-egész→CselekvesJK — jelöletlen
döntés, terv §6.5), `fogalommáEmel`, `fogalomTár` (240),
`egészFogalmak` (112), `félEgészFogalmak` (128), `fogalomTávolság`,
példák: `PéldaEgészFogalom`, `PéldaFélEgészFogalom`,
`PéldaEllentettFogalom`.

**BIZONYÍTÁSOK** (7 Refl):
- `bizEgészFogalmakSzáma : length EgészFogalmakKonst = 112`
- `bizFélEgészFogalmakSzáma : length FélEgészFogalmakKonst = 128`
- `bizKétPályaHídFogalmon : 112 + 128 = length FogalomTárKonst`
- `bizPályaHídFélEgészPélda : pályaOsztályból (szóOsztályMeghatároz (1⁸)) = FélEgészGyökPálya`
- `bizPéldaFélEgészFogalomPályája : pálya PéldaFélEgészFogalom = FélEgészGyökPálya`
- `bizFogalomTávolságKevereltPár : fogalomTávolság PéldaEgészFogalom PéldaFélEgészFogalom = SzorosanHasonló`
- `bizFogalomTávolságEllentett : fogalomTávolság PéldaEgészFogalom PéldaEllentettFogalom = Ellentett`

**main:** D8-pálya-méretek; a W(E8)-trivium; példafogalmak; távolságok;
kategória-konzisztencia (0 hiba).

**Importok:** `GyokSzo_v1`, `E8Gyokok_v2`, `E8BelsoSzorzat`,
`Kategoriak.MagyarOntologia`, `Data.List`.

**KÁRTYA-JELÖLTEK** (~4 kártya): a D8-pálya vs. W(E8)-pálya (a tranzitivitás
— Humphreys, Madore-hivatkozásokkal); a Fogalom-hármas ábrája; az
alap-kategória-hozzárendelés táblázata; a fogalom-távolság példái.

---

## 25. `GCheck` — `modul/GCheck.idr` (60 sor)

**Mit csinál:** minimalista G-ellenőrzés (a ProtonDrive-beli
all_constants_exact.py Idris-megfelelője).

**KULCS-KIFUTÁSOK:** `A=2, B=3, C=5, D=7, E=11`, `alphaFrac = 9/250`,
`GLevezetett = (7×11)/(2³×5²)·√3·(1+9/250)^(1/40)·10⁻¹⁰`,
`GCodata = 6.67430e-11`, `SigmaG = 1.5e-15`.

**BIZONYÍTÁSOK:** nincs Refl.

**main:** Δ/σ = 0.038 — a mérési hibán belül ✅.

**Importok:** nincs.

**KÁRTYA-JELÖLTEK:** 1 kártya (a G-képlet).

---

## 26. `GyokSzo_v1` — `modul/GyokSzo_v1.idr` (384 sor)

**Mit csinál:** a 3 dimenziós nyelv ALAPSZÓKINCSE: a 240 E8-gyök mint
szó; két szóosztály (112 állandó / 128 kapcsolati fogalom) + az
ötszintű jelentés-távolság-skála (⟨α,β⟩/8 ∈ {+1,+½,0,−½,−1}).

**KULCS-KIFUTÁSOK:** `SzóOsztály` (EgészGyökSzó | FélEgészGyökSzó),
`GyökSzó` rekord (jel, szóOsztály), `gyökSzóFel : Maybe GyökSzó`,
`szóOsztályMeghatároz`, `egészSzavak` (112), `félEgészSzavak` (128),
`alapszókincs` (240), `HasonlóságÖtSzint` (AzonosJel, SzorosanHasonló,
Semleges, EllentétesRokon, Ellentett), `jelentésTávolság`, példaszavak:
`PéldaEgészSzó`, `PéldaEllentettSzó`, `PéldaMerőlegesSzó`,
`PéldaFélEgészSzó`, `PéldaEllentétesRokonSzó`; futásidejű:
`osztályHibákSzáma = 0`, `távolságSkálaHibákSzáma = 0` (57 600 pár).

**BIZONYÍTÁSOK** (11 Refl):
- `bizEgészSzavakSzáma : length EgészSzavakKonst = 112`
- `bizFélEgészSzavakSzáma : length FélEgészSzavakKonst = 128`
- `bizAlapszókincsSzáma : length AlapszókincsKonst = 240`
- `bizKétÚtHíd : 112 + 128 = length AlapszókincsKonst` (KOMBINATORIKA ⟷ ENUMERÁCIÓ)
- `bizOsztályEgészPélda : szóOsztályMeghatároz (2,2,0⁶) = EgészGyökSzó`
- `bizOsztályFélEgészPélda : szóOsztályMeghatároz (1⁸) = FélEgészGyökSzó`
- `bizTávolságAzonosJel : jelentésTávolság PéldaEgészSzó PéldaEgészSzó = AzonosJel`
- `bizTávolságKevereltPár : jelentésTávolság PéldaEgészSzó PéldaFélEgészSzó = SzorosanHasonló`
- `bizTávolságMerőleges : jelentésTávolság PéldaEgészSzó PéldaMerőlegesSzó = Semleges`
- `bizTávolságEllentétesRokon : jelentésTávolság PéldaFélEgészSzó PéldaEllentétesRokonSzó = EllentétesRokon`
- `bizTávolságEllentett : jelentésTávolság PéldaEgészSzó PéldaEllentettSzó = Ellentett`

**main:** szókincsszámlálás; példaszavak írásjelekkel; távolságok;
kimerítő ellenőrzések.

**Importok:** `E8Gyokok_v2`, `E8BelsoSzorzat`, `Data.List`.

**KÁRTYA-JELÖLTEK** (~5 kártya): a 240 szavas szókincs; a két szóosztály
fogalmi szerepe; az ötszintű skála táblázata (érték/szög/neve); a
bizKétÚtHíd (a híd-minta kanonikus példája); a példapárok ábrája.

---

## 27. `HaromKubit` — `osveny_index/HaromKubit.idr` (89 sor)

**Mit csinál:** a HÁROM KUBIT — Saját (én), Másik (te), Fázis (kapcsolat):
a világ nem kétpolfüggő, hanem hárompolfüggő; a magyar igeidő×szemlélet×
forrás térképeződik a három kubit fázisára.

**KULCS-KIFUTÁSOK:** `HaromKubit` rekord (sajat, masik, fazis : Kubit),
`azonosFazis` (redundancia-detektálás), `Irany` (SajatMasik | MasikSajat
| NincsIrany), `irany`, `idoKubit`/`szemKubit`/`forrasKubit`
(Mult/Jelen/Jövő ↔ Nulla/Egy), `idoFazisba : IdoBeljegyzes → HaromKubit`,
`HaromKubitMorfizmus`.

**BIZONYÍTÁSOK:** nincs Refl (definíciók).

**main:** nincs.

**Importok:** `Steane713`.

**KÁRTYA-JELÖLTEK** (~3 kártya): a három kubit ábrája (én–te–kapcsolat);
a CPT-leképezés táblázata (27 kombináció); az irányelmélet
(információátvitel).

---

## 28. `HaromKategoria_v3` — `modul/HaromKategoria_v3.idr` (343 sor)

**Mit csinál:** a HÁROM KATEGÓRIA (pozitív = szintézis, negatív =
dekódolás, γ⁵ = átmenet/buborék) + a "s.a.t.o.b.b.i" = n-kategóriák
(Cat⁰…Cat^N) + a 10 szintű boot-up hierarchia; a γ⁵ minden szinten
megjelenik (δ × 2^szint).

**KULCS-KIFUTÁSOK:** `HarmadikKategoria` (Gamma5Atmenet, CarnotBuborek,
TranszcendentalisEgyseg, YonedaLemma, YKombinator), `harmadikEgyseges`,
`ElsoK/MasodikK/HarmadikK/HaromK` (a három típus hármasa),
`haromKMeret = 19` (7+7+5), `NSzint` (Cat0…CatN, nSzintErtek — CatN=100),
`TranszcendentalisÉrtékTípus`, `BootSzint` (10 konstruktor:
Alapveto…Magasabb), `bootSzintErtek` (1..10), `bootSzintekSzama = 10`,
`deltaSzint`, `hierarchiaDeltaOsszeg`, `magasabbSzintuErtelem`, `abszolut`.

**BIZONYÍTÁSOK** (9 Refl):
- `bizHaromKMeret19 : HaromKMeretKonst = 19`
- `bizGamma5Delta2 : Gamma5ÉrtékKonst = DeltaKonst`
- `bizTranszcendentalisDelta : TranszcendentalisEgysegErtekKonst = DeltaKonst`
- `bizBootSzintek10 : BootSzintekSzamaKonst = 10`
- `bizAlapvetoSzint1 : bootSzintErtek Alapveto = 1`
- `bizMagasabbSzint10 : bootSzintErtek Magasabb = 10`
- `bizNSzint0 : nSzintErtek Cat0 = 0`
- `bizNSzint1 : nSzintErtek Cat1 = 1`
- `bizHaromK : HaromK = (PozitivBit, NegativBit, HarmadikKategoria)` (v3 űszinte javítás)

**main:** nincs (típusok + bizonyítások).

**Importok:** `KetoldaliE8Fa_v3`, `KetoldaliKategoria_v3`,
`MagyarCarnotE9_v3_CodatAlpha`, `KomplexByte`, `Data.Nat`.

**KÁRTYA-JELÖLTEK** (~4 kártya): a három kategória ábrája; a Cat-létra
(0→∞); a 10 szintű boot-up hierarchia; a γ⁵ = δ-stabilizátor (a "pár"
mint 9. szint).

---

## 29. `HolografikusKod49_v2_MantraModul` — `modul/HolografikusKod49_v2_MantraModul.idr` (130 sor)

**Mit csinál:** a HaPPY holografikus kód (Pastawski–Yoshida–Harlow–
Preskill 2015, DOI 10.1007/jhep06(2015)149) MANTRA-stílusú (typeclass +
dependent record) megvalósítása: a 7 perem-bit a TÍPUSBAN van.

**KULCS-KIFUTÁSOK:** `FazaKorrelacioT (i j : Kubit)` interface + 4
instance (csak Egy-Egy → komplexEgy), `Perem7HetesV2` dependent record
(7 Kubit típusparaméter), `UrressPerem7HetesV2` (mind Nulla),
`TeljesPerem7HetesV2` (mind Egy), `HolografikusKod49V2` rekord
(perem + cimke), `UrressHolografikusKod49V2`.

**BIZONYÍTÁSOK** (1 Refl + 4 instance-konstans):
- `bizUressCimkeUres : cimke UrressHolografikusKod49V2 = ""`
- (`bizUresUresEgyenlo`, `bizUresEgyEgyenlo`, `bizEgyUresEgyenlo`,
  `bizEgyEgyEgyenlo` — instance-feltételes Komplex értékek, nem =-típusok.)

**main:** nincs.

**Importok:** `KomplexByte`.

**KÁRTYA-JELÖLTEK** (~2 kártya): a HaPPY perfect-tensor (7 perem + 7×7=49
belső); a "7 bit a TÍPUSBAN" MANTRA-elv.

---

## 30. `KetoldaliE8Fa_v3` — `modul/KetoldaliE8Fa_v3.idr` (392 sor)

**Mit csinál:** a KÉTOLDALI E8-fa: 7 pozitív réteg (idő…mód — szintézis)
+ 7 negatív réteg (inverzek — dekódolás) + γ⁵ átmenet = 14 dimenzió
(a Dirac-spec 14-bit stem megfelelője).

**KULCS-KIFUTÁSOK:** `PozitivBit` (PIdo…PMod), `pozitivLista`,
`pozitivBitekSzama = 7`; `NegativBit` (NIdo…NMod), `negativBitekSzama = 7`;
`Gamma5 = Double` (típusálnév), `gamma5Pozitiv`,
`KetoldaliBit` rekord (pozitiv, negativ, gamma5), `KetoldaliSteane`
(pBitek, nBitek, gamma5), `KetoldaliCarnotCiklus`,
`ketoldaliHatekonysag : η_p·η_n·(1−γ⁵)`, `ketoldaliVeszteseg`,
`Stem14`, `stem14Allapotok = 16384`, `stem14MegfelelMagyarnak`,
`hibajavitasKetoldali = 2`, `totalJavitasKetoldali = 62`,
`ketoldaliJavitasSzinten` (2/4/8/16/32), `totalKetoldaliJavitas = 62`,
`piroskaPozitiv = 154`, `piroskaNegativ = 154`, `piroskaKetoldali = 308`,
`piroska128Felett`, `piroska240Alatt`.

**BIZONYÍTÁSOK** (9 Refl):
- `bizPozitivHét : PozitivBitekSzamaKonst = 7`
- `bizNegativHét : NegativBitekSzamaKonst = 7`
- `bizKetoldaliTizennegy : BitekOsszegeKonst = 14`
- `bizGamma5Delta : Gamma5Konst = DeltaKonst`
- `bizStem14Allapot : Stem14AllapotokKonst = 16384`
- `bizKetoldaliJavitas2 : ketoldaliJavitasSzinten Levél = 2`
- `bizTotalJavitas62 : TotalKetoldaliJavitasKonst = 62`
- `bizPiroska308Felett : PiroskaKetoldaliKonst = 308`
- `bizGamma5Pozitiv : Gamma5PozitivKonst = True`

**main:** nincs.

**Importok:** `MagyarCarnotE9_v3_CodatAlpha`, `MagyarNyelvtan_v4`,
`E8Fa_v3`, `KomplexByte`, `Data.List`.

**KÁRTYA-JELÖLTEK** (~4 kártya): a 7+7+1 réteg-ábra; a 14-bit stem
(2¹⁴ = 16 384); a 62 = 2×31 javítás; a Piroska-mese 308 bitje
(128 < 308 < 480).

---

## 31. `KetoldaliKategoria_v3` — `modul/KetoldaliKategoria_v3.idr` (389 sor)

**Mit csinál:** a kétoldali struktúra FORMÁLIS kategóriatörvényei:
pozitív kategória (OR, egység Nulla), negatív kategória (AND, egység
Egy), a dualitás mint funktor (De Morgan!), izomorfizmus, természetes
transzformáció, 2-kategória — minden törvény Refl-lel.

**KULCS-KIFUTÁSOK:** `pozitivMor` (OR), `negativMor` (AND), `pozitivId =
Nulla`, `negativId = Egy`, `dualitas` (0↔1), `dualitasInverz`,
`dualitasFunktor`, `pozitivMap`, `Izomorfizmus` rekord, `ketoldaliIzo`,
`termeszetesTranszformacio`, `természetesTranszformációKimerítő`
(futásidejű: 4 függvény × 127 lista), `PozitivKategoria`,
`NegativKategoria`, `Ketoldali2Kategoria`, `ketoldaliObjektumok = 2`,
`ketoldaliMorfizmusok = 2`.

**BIZONYÍTÁSOK** (18 Refl-tétel):
- `bizPozitivAsszoc : (a,b,c) → (a∨b)∨c = a∨(b∨c)` (8 klóz)
- `bizNegativAsszoc : (a∧b)∧c = a∧(b∧c)` (8 klóz)
- `bizPozitivIdBal : pozitivMor PozitivIdKonst a = a`
- `bizPozitivIdJobb : pozitivMor a PozitivIdKonst = a`
- `bizNegativIdBal : negativMor NegativIdKonst a = a`
- `bizNegativIdJobb : negativMor a NegativIdKonst = a`
- `bizDualitasOninverz : dualitas (dualitas x) = x`
- `bizDeMorganOR : ¬(a∨b) = ¬a ∧ ¬b`
- `bizDeMorganAND : ¬(a∧b) = ¬a ∨ ¬b`
- `bizDualitasFunktor : ¬(a∨b) = (¬a)∧(¬b)` (a v2 hamis OR→OR állításának űszinte javítása)
- `bizDualitasEgyseg : dualitas PozitivIdKonst = NegativIdKonst`
- `bizMapId : pozitivMap Prelude.id xs = xs` (cong-indukció)
- `bizMapKompozicio : pozitivMap (g∘f) xs = pozitivMap g (pozitivMap f xs)`
- `bizIzoEloreVissza : dualitasInverz (dualitas x) = x`
- `bizIzoVisszaElore : dualitas (dualitasInverz x) = x`
- `bizTeljesPozitivAsszoc`, `bizTeljesNegativAsszoc` (átirányítások)
- `bizTeljesIzomorfizmus : (dualitas∘dualitas x = x, dualitas∘dualitas x = x)`
(+ a természetes-transzformáció-tétel futásidejű kimerítő fedése — az
elaborátor cong-kvírkja miatt; l. CongBeragadtGlobálisFejCsapda.)

**main:** nincs.

**Importok:** `KetoldaliE8Fa_v3`, `KomplexByte`.

**KÁRTYA-JELÖLTEK** (~6 kártya): OR-kategória és AND-kategória (duális
monoidok); a dualitás mint funktor (De Morgan); az izomorfizmus
(involúció); a funktor-törvények map-re; a természetes transzformáció
+ a cong-kvírk-tanulság; a 2-kategória.

---

## 32. `KomplexByte` — `modul/KomplexByte.idr` (254 sor)

**Mit csinál:** a GONDOLAT E8-ba kódolása: Kubit, HetesKod
(Steane-bitek), Komplex szám, CPT-fázis (3×3×3=27) és a KomplexBajt
rekord — a rendszer teljesen önállóan fordul (nulláról).

**KULCS-KIFUTÁSOK:** `Kubit` (Nulla|Egy), `forditKubit`, `HetesKod`
(idoBit…modBit), `Komplex` (re, im), `komplexZero/Egy/I`,
`komplexEuler : e^{iφ}`, `komplexSzoroz`, `komplexAbs`,
`Igeido` (MultI|JelenI|JovoI), `Szemlelet` (3), `Forras` (3),
`CptFazis` rekord, `KomplexBajt` (8 Komplex komponens + CPT + Steane +
címke), `uressKomplexBajt`, `komplexBajtSuly`, `komplexBajtEletjel`.

**BIZONYÍTÁSOK** (4 Refl):
- `bizUressEletjel : komplexBajtEletjel UressKomplexBajt = 0.0`
- `bizEgyszerSzorzas : komplexSzoroz KomplexEgy KomplexI = KomplexI`
- `bizForditasKetszer : forditKubit (forditKubit Nulla) = Nulla`
- `bizUressSuly : komplexBajtSuly UressKomplexBajt = KomplexKonstruktor 0.0 0.0`

**main:** nincs.

**Importok:** nincs (a Kubit EGYETLEN otthona — minden más modul innen importál).

**KÁRTYA-JELÖLTEK** (~4 kártya): a 8 komplex komponens sé mája (idő→γ⁵);
a CPT 27-kocka; a komplex-bájtnak mint "gondolat-tároló"; a Kubit mint
kanonikus alap (a többi modul Kubit-importja).

---

## 33. `Kvaternion` — `modul/Kvaternion.idr` (282 sor)

**Mit csinál:** "az i csak egy kör, a gömbhöz kvaternió kell" — a
Hamilton-szabályok teljes bizonyítása Integer-komponensekkel; a ℝ→ℂ→ℍ
létra (bit → kör → gömb).

**KULCS-KIFUTÁSOK:** `Kvaternion` rekord (skalar, iKomponens,
jKomponens, kKomponens : Integer), `kvaternionSzoroz` (a teljes
Hamilton-képlet), `iEgyseg`, `jEgyseg`, `kEgyseg` + nagybetűs aliasok,
`egysegNorma`, `kvaternionDimenziok = 4`, `letra = [1,2,4]`,
`gondolatok`.

**BIZONYÍTÁSOK** (12 Refl):
- `bizINegyzet : i·i = (−1,0,0,0)`
- `bizJNegyzet : j·j = (−1,0,0,0)`
- `bizKNegyzet : k·k = (−1,0,0,0)`
- `bizIJK : i·j = (0,0,0,1)` (= k)
- `bizJKI : j·k = (0,1,0,0)` (= i)
- `bizKIJ : k·i = (0,0,1,0)` (= j)
- `bizJIK : j·i = (0,0,0,−1)` (= −k — a NEM-kommutativitás!)
- `bizIJKMinusEgy : (i·j)·k = (−1,0,0,0)`
- `bizINorma : egysegNorma i = 1`
- `bizKvaternionNegy : KvaternionDimenziokKonst = 4`
- `bizLetra : List.length LetraKonst = 3`

(A 12. a main-ben futó 8 Hamilton-kimenet + a fenti 11 típus.)
Számlálva a fájlban: 11 Refl-típus (bizINegyzet…bizLetra).

**main:** mind a 8 Hamilton-szorzat, a nem-kommutativitás, a létra,
a gondolatok.

**Importok:** nincs.

**KÁRTYA-JELÖLTEK** (~4 kártya): a Hamilton-szabályok táblája; a
nem-kommutativitás (Rubik-kocka-analógia); az S³ = SU(2) → SO(3) kettős
fedés; a ℝ→ℂ→ℍ létra és a D_CRIT = 4.

---

## 34. `Kategoriak.MagyarOntologia` — `osveny_index/Kategoriak/MagyarOntologia.idr` (596 sor)

**Mit csinál:** MAGYAR ONTOLÓGIA — minden szó önálló TÍPUS (nincs
String!): 11 jelentéskategória (JK), 3 szócsalád (szám-, tér-, jó-),
képzők mint funktorok (KepzoT), 22 esetrag mint természetes
transzformációk (RagT), a CPT-igeragozás típusai.

**KULCS-KIFUTÁSOK:**
- `JK` : 11 kategória (IndividuumJK…KapcsolatJK)
- Szótövek: `SzamToTipus`, `TerToTipus`, `JoToTipus`
- Képzők: `OlKepzoTipus`, `ItKepzoTipus`, `AsKepzoTipus`, `ElKepzoTipus`,
  `SagKepzoTipus`, `LKepzoTipus`, `TalanKepzoTipus`, `OKepzoTipus`
- Szavak (15 típus): `SzamTipus`, `SzamolTipus`, `SzamitTipus`,
  `SzamitasTipus`, `SzamlaloTipus`, `SzamitogepTipus`, `SzamtalanTipus`,
  `TerTipus`, `TerelTipus`, `TeritTipus`, `TerjedTipus`, `TerfogatTipus`,
  `JoTipus`, `JosagTipus`, `JolTipus`
- Interface-ek: `JelentesT` (15 instance), `SzotoT` (15), `KepzoT` (9),
  `RokonSzoT` (8), `KinaiMegfeleloT` (5), `RagT` (14), `EsetKategoriaT` (22)
- Mondatok: `SzamSzamolMondat`, `SzamitogepSzamitMondat`, `JoSzamitasMondat`
- MEO-szintek: `OntologiaiSzint` (MetaMeta/Meta/Targy/Instancia),
  `KeresztRelacio` (Instancialas, Tipizalas, Formalizalas)
- 22 esetrag-típus: 9 helyi (Nominativusz…Sublativusz), 6 strukturális
  (Temporalis…Essivusz), 7 átalakító (Transzlativusz…Abessivusz)
- Ragozott szavak: `SzamotTipus`…`SzammaTipus` (9), `TeretTipus`,
  `TernekTipus`, `TerbeTipus`, `JotTipus`, `JonasTipus`
- CPT: `IgeidoTipus` (3), `SzemleletTipus` (3), `ForrasTipus` (3),
  `CptIgeragozasTipus` rekord (3×3×3 = 27)
- `magyarOntologiaFom` (main-szerű kiíratás)

**BIZONYÍTÁSOK:** nincs Refl-típus (a fájl végén a 3×3×3=27 megjegyzés
"Kimenet: Refl" felirattal, de lezáró bizonyítás nélkül — kártya-jelölt!).

**main:** `magyarOntologiaFom : IO ()` — a szócsaládok, képzők,
mondatok, kínai megfelelők és a MEO-szintek kiírása.

**Importok:** `Alap.KategoriaT`.

**KÁRTYA-JELÖLTEK** (~10 kártya): a "nincs String" elv; a szám-szócsalád
fa-ábrája (képzők mint nyilak); a KepzoT=funktor / RagT=természetes
transzformáció szembeállítás; a 22 eset táblázata (eset → kategóriaelméleti
szerep: id, hom, injekció, projekció, funktor, adjunkció, kolimit…);
a 9 ragozott szám-típus; a kínai megfelelők; a MEO-négyes; a CPT-27;
a mondat mint típus-kompozíció; a hiányzó 3×3×3=27 bizonyítás kártyája.

---

# ÖSSZESÍTÉS

| Mutató | Érték |
|---|---|
| Modulok (A–K, ipkg-lista) | **34** (31 `szima_ter/modul/`, 3 `osveny_index/`) |
| Refl-bizonyítás (tétel-szinten) | **218** |
| Futásidejű kimerítő ellenőrzés | ~15 (57 600-páros futtatások, CSS-, eloszlás-, zártság-, konzisztencia-ellenőrzések) |
| Becsült kártyák | **~135** |
| Becsült oldal (3 kártya/oldal) | **~45 oldal** |

**Refl-bontás modulonként** (0-k: Alap.AlphaKözös 0, Alap.AlphaKozos 0,
AlphaSteaneDashboard 0, Alap.KategoriaT 0, FazisAlgebra_v2 0, GCheck 0,
HaromKubit 0, Kategoriak.MagyarOntologia 0):
AlphaE8Szigor 21, AlphaGCheck 4, AlphaLobaszas 5, AlphaSteane 5,
AlphaSteaneE8 10, AlphaSteaneVegso 8, E8BelsoSzorzat 6, E8BelsőSzorzat 6,
E8Fa_v3 7, E8FazisKapcsolat 8, E8FazisKapcsolat_v2 5, E8FázisKapcsolat 8,
E8Gyokok_v2 13, E8Gyökök 13, E8TizenhatPenge 9, E8Iranymutato_v1 5,
E8Univerzalitas_v1 10, FazisKubit 4, Fogalom_v1 7, GyokSzo_v1 11,
HaromKategoria_v3 9, HolografikusKod49_v2_MantraModul 1,
KetoldaliE8Fa_v3 9, KetoldaliKategoria_v3 18, KomplexByte 4,
Kvaternion 11.

**A könyv természetes fejezetei a leltár alapján:**
1. Az α⁻¹/G levezetés-család (Alpha*, 9 modul, ~33 kártya)
2. Az E8 gyökrendszer és szimmetriák (E8*, 11 modul, ~45 kártya)
3. A nyelv: szókincs → fogalom (GyokSzo, Fogalom, MagyarOntologia, ~19 kártya)
4. A kubit-fizika: fázis, kvaternió, komplex bájt (FazisKubit, Kvaternion,
   KomplexByte, FazisAlgebra_v2, HaromKubit, ~15 kártya)
5. A hierarchia: fa, kétoldal, három kategória (E8Fa, Ketoldali×2,
   HaromKategoria, Holografikus, ~16 kártya)
6. A formális gerinc: Alap.KategoriaT 49 typeclass (~20 kártya — a
   legnagyobb egybefüggő fejezet-nyersanyag)
