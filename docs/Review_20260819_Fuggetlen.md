# FÜGGETLEN KRITIKAI REVIEW — 2026-08-19

**Tárgy:** `szima_ter/modul/` Idris-bizonyításainak valódisága (10 modul)
**Módszer:** `idris2 --check` (Idris 2 0.8.0) + teljes forrásszöveg-audit + a
`docs/MagyarKinai_2Kategoria_Kutatas.md` állításainak összevetése a kóddal.
**Nézőpont:** szkeptikus matematikus. Kérdés: VALÓDI bizonyítás vagy parasztvakítás?
**Verdikt-szótárak:** VALÓDI = a kernel ténylegesen számol (két különböző konstrukció
egyenlőségét ellenőrzi); TAUTOLÓGIA = a típus bal és jobb oldala azonos, vagy azonosan
a definícióból jön (nulla matematikai tartalom); GYENGE = valódi β-redukció, de a
konkrét elem/választás triviálissá teszi az állítást.

---

## 1. FORDÍTÁSI STÁTUSZ

| Fájl | `idris2 --check` | Státusz |
|---|---|---|
| KomplexByte.idr | EXIT 0 | ✅ hibátlan |
| Paragrafus.idr | EXIT 0 | ✅ hibátlan |
| PauliAlgebra_v2.idr | EXIT 0 | ✅ hibátlan |
| MagyarKinaiPar_v2.idr | EXIT 0 | ✅ hibátlan |
| MagyarKinaiInverz_v2.idr | EXIT 0 | ✅ hibátlan |
| MagyarKinaiAltInverz_v2.idr | EXIT 0 | ✅ hibátlan |
| MagyarKinaiFazisBayes_v2.idr | EXIT 0 | ✅ hibátlan |
| MagyarKinaiParkettazas_v2.idr | EXIT 0 | ✅ hibátlan |
| MagyarKinaiFolding_v2.idr | EXIT 0 | ✅ hibátlan |
| MagyarKinaiGenKod_v2.idr | EXIT 0 | ✅ hibátlan |

Minden modul lefordul. **De:** a fordítás sikeressége csak azt jelenti, hogy a
Refl-ek konzisztensek a definíciókkal — NEM jelenti, hogy a bizonyítások tartalmasak.

---

## 2. BIZONYÍTÁS-TÁBLÁZAT

### 2.1 KomplexByte.idr

| Név | Típus | Verdikt |
|---|---|---|
| bizUressEletjel | `komplexBajtEletjel UressKomplexBajt = 0.0` | VALÓDI (8 abszolútérték-összeg kiértékelése) |
| bizEgyszerSzorzas | `komplexSzoroz KomplexEgy KomplexI = KomplexI` | VALÓDI (komplex szorzás 1·i = i) |
| bizForditasKetszer | `forditKubit (forditKubit Nulla) = Nulla` | VALÓDI, de a komment „mindkét állapotra" állít — a típusban CSAK `Nulla` szerepel. Komment-túlzás. |
| bizUressSuly | `komplexBajtSuly UressKomplexBajt = KomplexKonstruktor 0.0 0.0` | VALÓDI (8 komponens összege) |

### 2.2 Paragrafus.idr

| Név | Típus | Verdikt |
|---|---|---|
| bizKisbetusFarkas | `kisbetus "FARKAS" = "farkas"` | VALÓDI (String-átalakítás) |
| bizEgyMondat | `length (szovegMondatokra "Piroska.") = 1` | VALÓDI |
| bizUresSzoveg | `length (szovegMondatokra "") = 0` | VALÓDI |

### 2.3 PauliAlgebra_v2.idr

| Név | Típus | Verdikt |
|---|---|---|
| bizStabilizatorHat | `length SteaneHatGeneratorKonst = 6` | VALÓDI |
| bizCl07Dimenzio128 | `cl07DimErtek Szazhuszonnyolc = 128` | **TAUTOLÓGIA** — a definíció pontosan ezt mondja ki. A „2⁷ = 128" NINCS a típusban, csak a kommentben. |
| bizCl014Dimenzio16384 | `cl014DimErtek TizenHatezerHaromszazNyolcvanNegy = 16384` | **TAUTOLÓGIA** — ugyanaz a minta („2¹⁴" nem bizonyított) |
| bizHatForgatasInverz | `(x : Cl07Elem) -> forgatasCl07 (Px,Py) (forgatasCl07 (Py,Px) x) = x` | **VALÓDI** — paraméteres, minden x-re. A modul legerősebb bizonyítása. |
| bizHatForgatasNegyzet | `forgatasCl07 (Px,Py) (forgatasCl07 (Px,Py) UrressCl07Elem) = UrressCl07Elem` | **GYENGE/üres** — az üres elem minden eltolás alatt önmaga; a „négyzet = identitás" állítás így semmit nem bizonyít az eltolásról. |
| bizHatForgatasCl14 | pozitív-projekció természetessége | **GYENGE** — lényegében record-projekció és konstruktor kommutativitása |
| bizSzoPauli14Meret | `(szo : SzoPauli14) -> length (szoPauli14Lista szo) = szoHossz szo` | **VALÓDI** — induktív bizonyítás minden szóra |
| bizCl014Asszociativ | `(0⊗0)⊗0 = 0⊗(0⊗0)` | **TAUTOLÓGIA a választott elem miatt** — minden tag az ÜRES elem, az XOR nullával nulla. Az általános asszociativitás NINCS bizonyítva. |
| bizCl014EgysegJobb | `0⊗1 = 0` (üres elemen) | **GYENGE/üres** — az általános egyelem-törvény NINCS bizonyítva |
| bizKod1513Dimenzio | `kod1513Ertek Tizenot = 15` | **TAUTOLÓGIA** (definíció-visszaolvasás) |
| bizGamma5Invarians | `gamma5Invarians UrressCl014Elem = UrressCl014Elem` | **GYENGE** — csak az üres elem; a „Noether-tétel analógiája" komment erős túlzás |

**További probléma:** a 12. szekció összefoglalója azt állítja: „A 6 forgatas periodusa
(6-szer = identitas)" — **ILYEN BIZONYÍTÁS NINCS A FÁJLBAN.** Csak a négyzet szerepel,
az is az üres elemen. Az összefoglaló tehát olyan eredményt sorol fel, ami nem létezik.

### 2.4 MagyarKinaiPar_v2.idr

| Név | Típus | Verdikt |
|---|---|---|
| bizMagyarAspektusHarom | `length MagyarAspektusListaKonst = 3` | VALÓDI |
| bizKinaiAspektusNegy | `length KinaiAspektusListaKonst = 4` | VALÓDI |
| bizFListaMeret | `length [f I, f P, f H] = 3` | VALÓDI |
| bizMagyarHabituToKinaiGuo | `magyarAspektusToKinai MagyarHabituális = KinaiGuo` | **TAUTOLÓGIA** (definíció egyetlen ágának kibontása) |
| bizMagyarImperfToKinaiZhe | ugyanaz a minta | **TAUTOLÓGIA** |
| bizMagyarPerfToKinaiLe | ugyanaz a minta | **TAUTOLÓGIA** |
| bizKinaiLeToMagyarPerf | ugyanaz a minta | **TAUTOLÓGIA** |
| bizKinaiZaiToMagyarImperf | ugyanaz a minta | **TAUTOLÓGIA** |
| bizMagyarKijToKinaiDe | ugyanaz a minta | **TAUTOLÓGIA** |
| bizMagyarFelszToKinaiBa | ugyanaz a minta | **TAUTOLÓGIA** |
| bizForditFPelder | `forditF (konkrét elem) = (kézzel kiírt eredmény)` | VALÓDI, gyenge (a jobb oldal a definíció ágai kézzel kiírva) |
| bizForditGPelder | ugyanaz | VALÓDI, gyenge |

A leképezés-bizonyítások (6 darab) mind az `f x = y` alakú „bizonyítások", ahol
`f` definíciójának ÉPPEN az az ága szerepel, amit a bal oldal meghív. A kernel
egyetlen definíció-kibontást végez. Ez nem bizonyítás, hanem a forráskód
újragépelése. (Egyetlen kivétel lenne, ha a definíció „vak" számítás lenne, pl.
kódolási táblázatból indexelt — de itt minden ág literálisan ki van írva.)

### 2.5 MagyarKinaiInverz_v2.idr

| Név | Típus | Verdikt |
|---|---|---|
| teszt1_JobbInverzJelenImperf | `G(F(Jelen,Imperf,Kij)) = (Jelen,Imperf,Kij)` | VALÓDI — épp az egyetlen veszteségmentes eset |
| teszt3_4_5_BalInverzZhe/Guo/Le | `F(G(k)) = k` konkrét k-ra | VALÓDI (konkrét elemek) |
| teszt6_ZaiVeszteseg | `F(G(Zai)) = Zhe` | VALÓDI — tényleges veszteség bizonyítva |
| teszt7_ZaiKonkret | **azonos típus teszt6-tal** | VALÓDI, de DUPLIKÁTUM |
| teszt8_TonalitasVeszteseg | `F(G(4.tónus)) = 1.tónus` | VALÓDI — veszteség bizonyítva |
| teszt9_LeMVeszteseg | `F(G(LeM)) = De` | VALÓDI — veszteség bizonyítva |
| teszt10_MaVeszteseg | `F(G(Ma)) = De` | VALÓDI — veszteség bizonyítva |
| teszt2 (kommentelt) | a Mult elveszik | **NINCS A KÓDBAN** — csak komment. A „fordító elutasítása a bizonyíték" logikailag hangos, de nem gépileg rögzített. |

Az inverz-vizsgálat módszertana (a veszteség POZITÍV bizonyítása konkrét
ellenpéldákon) **jó és őszinte**. A negatív állítás (nem létezik inverz) a
véges tartományon (27 magyar × 64 kínai állapot) nincs teljesen kimerítve —
csak 10 konkrét pont van tesztelve — de a talált ellenpéldák elegendőek a
„nem inverz" konklúzióhoz.

### 2.6 MagyarKinaiAltInverz_v2.idr

| Név | Típus | Verdikt |
|---|---|---|
| bizAltInverzJobbProg | bovített oda-vissza konkrét elemen | VALÓDI |
| bizAltInverzBalZai | `proj(F(G(Zai))) = Zai` bovítve | VALÓDI — a bovítás tényleg menti a Zai-t |
| bizAltInverzBalTonalitas | tónus (Egy,Egy) → (Nulla,Nulla) | VALÓDI — a tónus még bovítve is elveszik |
| bizAltInverzJobbPerf | `proj(G(F(Mult,Perf))) = (Jelen,Perf)` | VALÓDI — a Mult még bovítve is elveszik |
| bizAltInverzMultMegmarad | `G(F(bov(Mult,Perf))) = (Jelen, PerfectumB)` | VALÓDI — ugyanaz a veszteség bovített típusban |

**KRITIKUS ELLENTMONDÁS:** a modul végén
`magyarKinaiAltInverzEredmenye = AltInverzMegtalalhato` — de a modul SAJÁT
Refl-jei (bizAltInverzJobbPerf, bizAltInverzMultMegmarad, bizAltInverzBalTonalitas)
épp azt bizonyítják, hogy az oda-vissza út NEM identitás a bovített halmazon sem:
a Mult → Jelen, a 4. tónus → 1. tónus. **A deklarált eredmény („az inverz
megtalálható") ellentmond a modulban bizonyított tényeknek.** Továbbá az
`AltInverz2Sejt` konstruktor feltétele — `projekcioMagyar (G(F(bov(m)))) = m`
MINDEN m-re — a bizAltInverzJobbPerf szerint hamis (Mult-ra nem teljesül), tehát
a 2-sejtnek NEM LÉTEZHET példánya. Deklarált, de üres (sőt: cáfolt) struktúra.

### 2.7 MagyarKinaiFazisBayes_v2.idr

| Név | Típus | Verdikt |
|---|---|---|
| bizFazisBizonytalansagNulla | `fazisBizonytalansag FazisNull = 0` | **TAUTOLÓGIA** (definíció-ág) |
| bizBayesFrissitesNovel | `(p : BayesPrior) -> (f : Fazis) -> e = e0 + 1` | VALÓDI paraméteres bizonyítás, **DE EZ NEM A BAYES-TÉTEL** — csak a számláló növelése. A komment maga is beismeri: „egyszerűsített". |
| bizDeltaErtek | `DeltaKonst = 8.23e-7` | **TAUTOLÓGIA** (a delta definíciója épp ez; a „Horgony vs. CODATA eltérés" állítást semmi nem bizonyítja) |
| bizCarnotCiklusNegy | `length CarnotCiklusKonst = 4` | VALÓDI |
| bizHibajavitasFazisok | `hibajavitasFazis IzotermExpanzio = 0` | **TAUTOLÓGIA** (definíció-ág) + a komment („csak a 2. és 4. fázisban") többet állít, mint a típus |
| carnotHatekony | `1.0 - tCold / tHeat` | **CSAK KÉPLET** — definíció, NINCS levezetés, NINCS Refl |

### 2.8 MagyarKinaiParkettazas_v2.idr

| Név | Típus | Verdikt |
|---|---|---|
| bizOsszesDarabHusz | `4 * 5 = 20` | **VALÓDI** — a kernel ténylegesen szoroz |
| bizParkettaSorNegy | `length CarnotCiklusKonst = 4` | VALÓDI |
| bizParkettaOszlopOt | `length [5 fázis] = 5` | VALÓDI |
| bizZartParkettaTeljes | `ZartParkettaKonst = TeljesParkettaKonst` | **TAUTOLÓGIA** — a `zartParketta` DEFINÍCIÓJA `= teljesParketta`. A „zártság" (periodikus határfeltétel) SEHOL nincs ellenőrizve, csak a névben deklarálva. |

További hiány: az `ElIllesztes` / `SarokIllesztes` típusok ÜRES wrapperek —
bármely két darabot elfogadnak, a tényleges kompatibilitási feltétel
(`elKompatibilis`) sehol nincs bizonyításban meghívva. Nincs Refl arra, hogy a
teljes parketta 20 darabból áll, és nincs Refl arra, hogy az élek illeszkednek.

### 2.9 MagyarKinaiFolding_v2.idr

| Név | Típus | Verdikt |
|---|---|---|
| bizHejSzerkezetHat | `length TeljesHejSzerkezetKonst = 6` | VALÓDI |
| bizFoldingIteraciokNegy | `4 = 4` | **TAUTOLÓGIA** — a legtisztább példa: a típus két oldala SZÓ SZERINT azonos. |
| bizNativDelta | `let ... = magyarKinaiNativAllapot in d = 0.0` | **TAUTOLÓGIA** (deklarált δ=0.0 visszaolvasása). Ráadásul **ELLENTMOND** a FazisBayes δ = 8.23e-7-nek: az egyik modul szerint a buborék soha nem zárul (δ>0), a másik szerint bezárult (δ=0.0). |
| komplexBajtFrissit | `komplexBajtFrissit kb _ _ = kb` | **PLACEHOLDER** — a komment maga mondja ki. A teljes `foldingUt` tehát NEM csinál semmit. A „folding" nem valódi számítás. |

### 2.10 MagyarKinaiGenKod_v2.idr

| Név | Típus | Verdikt |
|---|---|---|
| bizNegyBazis | `length [4 bázis] = 4` | VALÓDI |
| bizKodonHatvanNegy | `4 * 4 * 4 = 64` | **VALÓDI** — a kernel szoroz |
| bizOsszesKodonHatvanNegy | `length (64-elemű list comprehension) = 64` | **VALÓDI** — a legértékesebb bizonyítás az egész projektben: a 4³ kombinatorika ténylegesen számítva |
| bizAminosavHusz | `4 * 5 = 20` | VALÓDI |
| bizDegeneraltsag | `64.0 / 20.0 = 3.2` | VALÓDI (Double-osztás) |
| bizKodonElsoIndex | `kodonToAminosav k = 0*16+1*4+2` | VALÓDI, de a jobb oldal a definíció képletének átírása (nem független út) |
| bizKovetkezoCarnot | `kovetkezoCarnotFazis IzotermExpanzio = AdiabatikusExpanzio` | **TAUTOLÓGIA** (definíció-ág) |
| bizSteane | `(7, 1, 3) = (7, 1, 3)` | **TAUTOLÓGIA** — mindkét oldal azonos literál. A Steane-kód „bizonyítása" semmit nem bizonyít. |
| bizStopKodonHarom | `3 = 3` | **TAUTOLÓGIA** |
| bizAlphaHelixHusz | `20 = 20` | **TAUTOLÓGIA** — a „3.6 × 5.66 ≈ 20.4" számítás SEHOL nincs; a 20 deklarálva van |

---

## 3. TÖRVÉNY-LELTÁR (kategóriaelméleti állítások)

**Alapvető megállapítás:** a „funktorok" (forditF, forditG) valójában közönséges
függvények két REKORD-típus között. A forrás- és céltartomány **kategóriák
nincsenek definiálva**: nincs objektum-halmaz, nincs identitás-morfizmus, nincs
morfizmus-kompozíció. Amíg a kategória-struktúra nem létezik, a
„funktor-törvények" NEM MEGFOGALMAZHATÓK — tehát nem is bizonyíthatók. A Cat²
struktúra (Cat2Sint, Cat2Magyar, Cat2Kinai, Cat2Functor, Cat2Termeszetes)
csak SZINTAKTIKUS ADATTÍPUS: bármit bármivel lehet „komponálni" benne, a
kategorikus kényszerek (jól-típusozott kompozíció) hiányoznak.

| Törvény | Státusz | Részlet |
|---|---|---|
| a) funktor-azonosság F(id_A) = id_F(A) | **NINCS** | Kategóriák sincsenek; id_A, id_F(A) nem létezik a kódban. forditF-re, forditG-re, projekciókra SEMMILYEN funktor-törvény nincs. |
| b) funktor-kompozíció F(g∘f) = F(g)∘F(f) | **NINCS** | Morfizmus-kompozíció sincs definiálva. |
| c) 2-kategória csere-törvény (interchange law) | **NINCS** | Nincs vertikális/horizontális kompozíció-függvény, amire vonatkozhatna. |
| d) természetesség (naturality square) | **NINCS** | `TermeszetesTranszformacio` rekord LÉTEZIK (proof-carrying: `forditF magyarOldal = kinaiOldal`), de NINCS PÉLDÁNYA bizonyítással. Az AltInverz2Sejt konstruktor feltételei a modul saját Refl-jei szerint HAMISAK (a Mult-ra nem teljesül) — nem konstruálható. |
| e) vertikális/horizontális kompozíció asszociativitása | **NINCS** | A kompozíció-függvények hiányoznak. |
| f) Bayes-tétel tényleges formája P(H\|E) = P(E\|H)·P(H)/P(E) | **NINCS** | A `bayesFrissites` csak a számlálót növeli: `(f, e) → (ujFazis, e+1)`. A komment beismeri: „egyszerűsített". A bizBayesFrissitesNovel a számláló-növelést bizonyítja — valódi, de nem Bayes. |
| g) Carnot-hatásfok η = 1 − Tc/Th levezetése | **CSAK KÉPLET** | `carnotHatekony` definíció; a Qh/Qc/T összefüggésből való levezetés (izoterm + adiabatikus szakaszok entrópia-mérlege) NINCS. Nincs egyetlen Refl sem. |
| h) Steane [[7,1,3]] 3-as távolság | **CSAK DEKLARÁLVA** | `bizSteane : (7,1,3) = (7,1,3)` tiszta tautológia. A 6 stabilizátor definiálva van (PauliAlgebra_v2), de NINCS bizonyítás: (i) a kódtér dimenziója 1, (ii) a stabilizátorok kommutálnak, (iii) a minimális súly 3, (iv) hogy 1 hibát javít. A „távolság 3" egy megjegyzés a típus nevében, nem tétel. |
| i) 64 kodon = 4³ és degeneráltság 3.2 | **BIZONYÍTVA** | `bizKodonHatvanNegy : 4*4*4 = 64` ÉS `bizOsszesKodonHatvanNegy : length (64-elemű comprehension) = 64` — két független út, valódi kombinatorikus ellenőrzés. `bizDegeneraltsag : 64.0/20.0 = 3.2` szintén valódi. **Ez a projekt legerősebb, vitathatatlan része.** |

---

## 4. ÁLLÍTÁS-ELLENŐRZÉS (docs/MagyarKinai_2Kategoria_Kutatas.md)

| Állítás a doksiban | Megítélés |
|---|---|
| „a projektünk az ELSŐ a szakirodalomban" (5.5, 10. szakasz) | **TÚLZÓ / NEM ALÁTÁMASZTHATÓ A KÓDBÓL.** A firecrawl-keresés eredménye plauzibilis lehet a konkrét metszetre, de: (1) a doksi MAGA sorol fel közvetlenül releváns munkákat — Bradley-Terilla-Vlassopoulos 2022 (szintaxis→szemantika enriched kategória!), Toumi-Koziell-Pipe 2021 (functorial language models) — tehát „nyelvpárok functor-struktúrája" gondolatnak VAN irodalma; (2) az elsőség egy szöveg-keresésből jön, nem a kódból; a review csak annyit tud igazolni, hogy a kódban van egy deklaratív rekord-halmaz. |
| „13 Refl-bizonyítás" (4.2, 7. szakasz) | **SZÁMSZERŰLEG TÉVES + MINŐSÉGILEG TÚLZÓ.** A MagyarKinaiPar_v2-ben 12 deklaráció van, és ebből 6–7 tautológia (definíció-ág visszaolvasása). |
| „első formális implementáció a magyar↔kínai 2-kategóriáról" / „publikálható eredmény" | **TÚLZÓ.** A kódban NINCS 2-kategória: nincs kompozíció, nincs csere-törvény, nincs természetesség-bizonyítás, nincs funktor-törvény. A Cat2Sint szintaktikus csomagoló. Egy 2-kategória-formalizáció hiányzó alapfeltételei mind hiányoznak. |
| „komplex bájt + QEC mint interlingua — eredeti hozzájárulás" | **SPEKULATÍV, a kód nem támogatja.** A fordítás (forditF/G) közvetlenül a CPT-rekordok között megy; a KomplexBajt sehol nincs összekötve a fordítással (a Paragrafus modulban a mondat címkéje egyszerű String). Az „interlingua" egy diagram a doksiban, nem a kódban. |
| „komplex bájt = E8-ba kódolt gondolat" | **TÚLZÓ.** A KomplexBajt 8 darab Double-pár + felsorolási típusok + String. Az E8 (240 gyök) semmilyen formában nincs a kódban — nincs gyök-generálás, nincs rács, nincs normaszámítás. A név asszociáció, nem matematika. |
| „22 magyar esetrag" táblázat (1.1) | **BELSŐ HIBA A DOKSIBAN:** a táblázat 18 soros, a cím 22-t állít. |
| „a magyar a kategóriaelmélet anyanyelve" (10. szakasz) | A 10 auditált modulban a 22 eset NINCS formalizálva; az állítás doksi-szintű retorika. |
| „MagyarCPT × KinaiCPT = a Cat² szintje" (3.4) | **VÁGYVEZÉRELT BESOROLÁS.** A Cat²-hez (funktor-kategória) kellene: objektumok, 1-sejtek, 2-sejtek KOMPOZÍCIÓVAL. A kódban csak adattípusok vannak, törvények nélkül. |

---

## 5. ÖSSZEGZÉS — A KEMÉNY MÉRLEG

**Számok:** a 10 modulban 67 `biz*`/`teszt*` deklaráció van. Ebből:
- **VALÓDI: 41** — ebből igazán értékes ~8–10:
  `bizHatForgatasInverz` (paraméteres, minden x-re), `bizSzoPauli14Meret`
  (indukció), `bizOsszesKodonHatvanNegy` + `bizKodonHatvanNegy` (kombinatorika,
  két út), `bizDegeneraltsag`, a 4×5=20 és a length-bizonyítások, az
  inverz-veszteség tesztek (teszt3–10), a Paragrafus/KomplexByte konkrét számításai.
- **TAUTOLÓGIA: 20** — ebből a legsúlyosabbak: `4 = 4`, `3 = 3`, `20 = 20`,
  `(7,1,3) = (7,1,3)`, a 6 leképezés-visszaolvasás, a dimenzió-deklarációk
  (128, 16384, 15), a fázis/δ/hibajavítás definíció-ágak.
- **GYENGE / triviális elemre redukált: 6** — az asszociativitás, az
  egyelem-törvény, a γ⁵-invariancia, a forgatás-négyzet mind az ÜRES elemen
  vannak bizonyítva, ami őket tartalmatlanná teszi; plusz a kodon-index és
  a δ-visszaolvasás.
- **PLACEHOLDER / ellentmondásos: ~4** — `komplexBajtFrissit` (identitás),
  `magyarKinaiAltInverzEredmenye` (a saját Refl-ek cáfolják),
  δ = 0.0 vs δ = 8.23e-7 (modulok közötti ellentmondás),
  a PauliAlgebra összefoglalója (nem létező „periódus-6" bizonyítást állít).

**Ami ahhoz hiányzik, hogy a kategóriaelméleti állítások ténylegesen
bizonyítottak legyenek:**

1. **Kategória-definíciók.** MagyarCPT és KinaiCPT mint OBJEKTUMOK, morfizmusokkal
   és identitásokkal. Enélkül a „funktor" szó használata a kódban
   terminológiai visszaélés — a forditF egy függvény, nem funktor.
2. **Funktor-törvények Refl-lel** (identitás + kompozíció) — jelenleg nulla.
3. **A 2-kategória kompozíciói**: vertikális ∘ és horizontális ∗, az asszociativitásuk,
   és a csere-törvény. Jelenleg a Cat2Sint-ben bármi bármivel összeragasztható.
4. **Egy TÉNYLEGES természetes transzformáció** a forditF és forditG között
   (vagy annak bizonyítása, hogy nem létezik), a naturality square-rel.
   A deklarált AltInverz2Sejt jelenleg hamis feltételű.
5. **Steane:** a stabilizátorok kommuntativitása + a kódtér minimális súlyának
   (=3) kiszámítása. Jelenleg a (7,1,3) egy megjegyzés.
6. **Bayes:** legalább egy olyan prior/likelihood-pár, ahol a posterior a
   normalizált likelihood×prior — nem számláló-növelés.
7. **Carnot:** az izoterm Q = TΔS összefüggésekből a η = 1 − Tc/Th levezetése
   Refl-lel, nem formulaként.

**Kimondva nyersen:** a fordítások hibátlanok, de a bizonyítások jelentős része
vagy tautológia, vagy triviális esetre redukált. A „13 Refl-bizonyítás" és a
„2-kategória formális implementációja" állítások nem állják meg a helyüket a
kód auditja alapján. A MEGALAPOZOTT, vitathatatlan eredmények: a 64=4³
kombinatorika, a degeneráltság, az inverz-veszteség konkrét pontokon, és a
Pauli-forgatás inverz-párja. A többi jelenleg leíró (deklaratív) adatmodell,
nem bizonyított matematika. A legerősebb mondat, amit ma a kód alátámaszt:
„a leképezések konzisztensek és a veszteségek konkrét pontokon kimutatottak" —
minden ezen túli állítás a kommentekben és a doksiban van, nem a kernelben.

**Egy mondatban:** a projekt nem parasztvakítás — a tautológiák nyíltan
olvashatók a kódban —, de jelenlegi állapotában „bizonyítás"-termelésének
több mint fele üres, és a zászlóshajó-állítások (2-kategória, Steane-távolság,
Bayes, Carnot) egyike sincs a kernel által ellenőrizve.
