# KÖNYV-LELTÁR v1 — B-rész (L–Z prefixű modulok)

> A P1b leltár második fele. Az A–K prefixű modulokat az A-rész
> (`docs/KonyvLeltar_v1_A.md`) fedi. Forrás: `szima_ter/szima.ipkg`
> 64 modulból a L–Z kezdetű **29 modul** (19 M + 5 P + 3 S + 2 T).
> Minden modul ELOLVASVA (AGENTS §N11), nem futtatva — a számok a
> forráskódból és a kommentekből valók. Készült: 2026-08-23.
> Megjegyzés: a `Steane713` az ipkg-ban szerepel, de a fájl az
> `osveny_index/Steane713.idr`-ben él (a modul/ alatt nincs).

---

## M — MagyarCarnotE9_v3_CodatAlpha

**Mit csinál:** a Carnot–E9 keret CODATA-javított α-értékei: a
137.036 (Horgony) ↔ 137.035999177 (CODATA) delta, a 128/240/112
számainak algebraja, a Carnot-ciklus 4 lépése és a magyar
szimmetria-csoport (48) illesztése, a Piroska-mese 154 bitje.

- **KULCS-KIFUTÁSOK:** `alphaInverzCodat = 137.035999177`,
  `alphaInverzHorgony = 137.036`, `delta` (kivonás),
  `deltaRelativ`, `steaneHilbertTer = 128`, `e8Gyokok = 240`,
  `e8Redundancia = 240/128 = 1.875`, `szindromaTer = 112`,
  `e8Negyed = 960`, `e9Egyutthato = 16`, `buborekMeret = 944`,
  `gamma5 = delta`, `carnotHatekonysag`, `carnotVeszteseg`,
  `magyarSzimmetriaMeret = 48`, `magyarDeltaArany = 47/48`,
  `piroskaMondatokSzama = 22`, `piroskaBitek = 154`,
  `piroskaAzE8Reszhalmaza : Bool`; típusok: `CarnotLepes`,
  `CarnotCiklus`, `MagyarSzimmetria`; nagybetűs aliasok
  (AlphaInverzCodatKonst … PiroskaBitekKonst, DeltaSzamitas).
- **BIZONYÍTÁSOK (11 Refl):**
  `bizAlphaCodat : AlphaInverzCodatKonst = 137.035999177`;
  `bizAlphaHorgony : AlphaInverzHorgonyKonst = 137.036`;
  `bizDeltaErtek : DeltaKonst = DeltaSzamitas`;
  `bizSteaneTer : SteaneHilbertTerKonst = 128`;
  `bizE8Gyokok : E8GyokokKonst = 240`;
  `bizSzindromaTer112 : SzindromaTerKonst = 112`;
  `bizE9Egyutthato : E9EgyutthatoKonst = 16`;
  `bizMagyarSzimmetriaMeret48 : MagyarSzimmetriaMeretKonst = 48`;
  `bizPiroskaReszhalmaz : PiroskaBitekKonst = 154`;
  `bizPiroskaFelette : (PiroskaBitekKonst > SteaneHilbertTerKonst = True)`;
  `bizPiroskaAlatta : (PiroskaBitekKonst < E8GyokokKonst = True)`.
- **main:** nincs.
- **IMPORTOK:** nincs (önálló).
- **KÁRTYA-JELÖLTEK:** (1) a δ két útja (CODATA-különbség itt ↔
  lobásás az AlphaSteane-ben) — 1 kártya; (2) 240 − 128 = 112
  szindróma-tér — 1; (3) 960 − 16 = 944 Carnot-buborék — 1; (4) a
  Carnot 4 lépés ↔ magyar 4 szimmetria (paritás/hangrend/
  agglutináció/zöngésség) — 1; (5) 128 < 154 < 240 Piroska-híd — 1.
  **Összesen ~5 kártya / ~4 oldal.**

## M — MagyarKinaiAltInverz_v2

**Mit csinál:** a magyar↔kínai fordítás ÁLTALÁNOSÍTOTT inverze
(Cat² 2-sejt): a magyar CPT kibővítése 9 aspektusra (Progresszív,
Frekventatív, Inceptív, Terminatív, Iteratív, Resultatív + 3
klasszikus), bovítás–projekció párok, és a bővített halmazon a
forditFBovitett/forditGBovitett funktorok.

- **KULCS-KIFUTÁSOK:** `MagyarAspektusBovitett` (9 konstruktor),
  `MagyarCPTBovitett` rekord (81 állapot: 3×9×3),
  `KubitTonalitasBovitett`, `KinaiCPTBovitett`,
  `projekcioMagyarB`, `bovitMagyar`, `projekcioMagyar`,
  `projekcioKinaiB`, `bovitKinai`, `projekcioKinai`,
  `magyarAspektusBovitettToKinai`, `magyarModBovitettToKinai`,
  `forditFBovitett`, `kinaiAspektusBovitettToMagyar`,
  `kinaiModalitasBovitettToMagyar`, `forditGBovitett`;
  `AltInverz2Sejt`, `AltInverzEredmenye`
  (`magyarKinaiAltInverzEredmenye = AltInverzMegtalalhato`),
  `magyarKinaiBovitettSzintje = Cat3Cat`.
- **BIZONYÍTÁSOK (5 Refl):**
  `bizAltInverzJobbProg : projekcioMagyar (forditGBovitett (forditFBovitett (MagyarCPTBovitettKonstruktor MagyarJelen MagyarProgresszivB MagyarKijelento))) = MagyarCPTKonstruktor MagyarJelen MagyarImperfectum MagyarKijelento`;
  `bizAltInverzBalZai : projekcioKinai (forditFBovitett (forditGBovitett (KinaiCPTBovitettKonstruktor KinaiZai KinaiDe (…)))) = KinaiCPTKonstruktor KinaiZai KinaiDe (…Nulla Nulla)`;
  `bizAltInverzBalTonalitas : …(Egy,Egy) tonalitás → (Nulla,Nulla) — a veszteség Refl-lel`;
  `bizAltInverzJobbPerf : a Mult igeidő elveszik (Jelen tér vissza)`;
  `bizAltInverzMultMegmarad : forditGBovitett (forditFBovitett (bovitMagyar (…Mult…))) = MagyarCPTBovitettKonstruktor MagyarJelen MagyarPerfectumB MagyarKijelento`.
- **main:** nincs.
- **IMPORTOK:** KomplexByte, MagyarKinaiPar_v2.
- **KÁRTYA-JELÖLTEK:** (1) a naiv inverz bukása → bővítés
  (9+4 aspektus) — 1 kártya; (2) retrakció-diagram
  (projekcio ∘ bovit) — 1; (3) a Zai↔Progresszív híd — 1; (4) a
  maradék-veszteségek (tonalitás, igeidő) mint δ-stabilizátor — 1.
  **~4 kártya / ~3 oldal.**

## M — MagyarKinaiFazisBayes_v2

**Mit csinál:** a Cat⁴ szint: fázis (5 állapot, [0,2π] negyedelve),
Bayes-frissítés, körinformáció, δ = 8.23e-7, Carnot-ciklus 4 fázisa
↔ Cat-szintek, QEC a 2. és 4. fázisban.

- **KULCS-KIFUTÁSOK:** `Fazis` (5 konstruktor),
  `fazisBizonytalansag` (0..4), `BayesPrior`, `bayesFrissites`,
  `magyarEntropia = 100000`, `kinaiEntropia = 50000`,
  `korinformacioMagyarKinai = 50000`, `delta = 8.23e-7`,
  `DeltaKonst`, `CarnotFazis` (4), `carnotCiklus : List CarnotFazis`,
  `CarnotCiklusKonst`, `carnotHatekony`,
  `carnotFazisToCatSzint` (Cat0Set..Cat3Cat),
  `magyarKinaiCarnot` (zip), `hibajavitasFazis`,
  `fazisBayesCarnotMagyarKinai : String`.
- **BIZONYÍTÁSOK (5 Refl):**
  `bizFazisBizonytalansagNulla : fazisBizonytalansag FazisNull = 0`;
  `bizBayesFrissitesNovel : ∀ p f → e = e0 + 1` (let-case típus);
  `bizDeltaErtek : DeltaKonst = 8.23e-7`;
  `bizCarnotCiklusNegy : List.length CarnotCiklusKonst = 4`;
  `bizHibajavitasFazisok : hibajavitasFazis IzotermExpanzio = 0`.
- **main:** nincs.
- **IMPORTOK:** KomplexByte, MagyarKinaiPar_v2,
  MagyarKinaiAltInverz_v2, Data.List.
- **KÁRTYA-JELÖLTEK:** (1) fázis-negyedek ↔ CPT — 1; (2)
  Bayes-frissítés lépésről lépésre — 1; (3) Carnot ↔ Cat⁴
  táblázat — 1; (4) QEC az adiabatikus fázisokban — 1.
  **~4 kártya / ~3 oldal.**

## M — MagyarKinaiFolding_v2

**Mit csinál:** fehérje-folding analógia: a magyar szavak
(aminosav-szekvencia, 1D) kifoldódnak a Cat^∞ konformációs térbe;
hidrofób mag / hidrofil burok / chaperon / natív állapot (δ=0).

- **KULCS-KIFUTÁSOK:** `Aminosav` (szó + CPT + fázis),
  `MagyarMondat = List Aminosav`, `piroskaElsoHaromAminosav`
  („egyszer", „volt", „holom"), `HejSzerkezet` (6 konstruktor:
  BelsoMag..NatívAllapot), `teljesHejSzerkezet`,
  `TeljesHejSzerkezetKonst`, `Chaperon` (2), `chaperonMagyar`,
  `chaperonKinai`, `FoldingLepes`, `foldingKezdet`,
  `foldingIteraciok = 4`, `NativAllapot`,
  `magyarKinaiNativAllapot` (δ=0.0, entrópia=0), `komplexBajtFrissit`
  (placeholder), `foldingUt`, `piroskaFolded`, `foldingMagyarKinai`.
- **BIZONYÍTÁSOK (3 Refl):**
  `bizHejSzerkezetHat : List.length TeljesHejSzerkezetKonst = 6`;
  `bizFoldingIteraciokNegy : 4 = 4` — TAUTOLÓGIA (§18 jelölés);
  `bizNativDelta : let NativAllapotKonstruktor _ d _ = magyarKinaiNativAllapot in d = 0.0`.
- **main:** nincs.
- **IMPORTOK:** KomplexByte, MagyarKinaiPar_v2,
  MagyarKinaiAltInverz_v2, MagyarKinaiFazisBayes_v2,
  MagyarKinaiParkettazas_v2.
- **KÁRTYA-JELÖLTEK:** (1) a folding-analógia lépcsőháza (1D→3D)
  — 1; (2) a 6 héj (Cat⁰..Cat^∞) — 1; (3) Levinthal-paradoxon
  feloldása (determinisztikus út) — 1. **~3 kártya / ~2 oldal.**

## M — MagyarKinaiGenKod_v2

**Mit csinál:** genetikai kód analógia: 4 bázis (eset/igeidő/
aspektus/mód) → 64 kodon (4³) → 20 aminosav (degeneráltság 3.2),
tRNS = funktorok, riboszóma = Carnot, Steane proofreading, 3 stop
kodon = δ, α-hélix periódus 20.

- **KULCS-KIFUTÁSOK:** `Bazis` (4), `negyBazis`, `Kodon`,
  `kodonSzam = 64`, `osszesKodon` (felsorolt 64),
  `OsszesKodonKonst`, `aminosavSzam = 20`,
  `degeneraltsag = 3.2`, `kodonToAminosav` (bázis-16/4/1 index),
  `TRNS`, `trnsForditF`, `trnsForditG`, `Ribosoma`,
  `ribosomaKezdet`, `kovetkezoCarnotFazis`, `ribosomaLepes`,
  `Hibajavitas`, `steaneKod = (7,1,3)`, `stopKodonSzam = 3`,
  `deltaGenKod = 8.23e-7`, `alphaHelixPeriódus = 20`,
  `alphaHelixMegfelel`, `genKodMagyarKinai`.
- **BIZONYÍTÁSOK (10 Refl):**
  `bizNegyBazis : length [4 bázis] = 4`;
  `bizKodonHatvanNegy : 4 * 4 * 4 = 64`;
  `bizOsszesKodonHatvanNegy : List.length OsszesKodonKonst = 64` (KÉT ÚT);
  `bizAminosavHusz : 4 * 5 = 20`;
  `bizDegeneraltsag : 64.0 / 20.0 = 3.2` (kernel oszt);
  `bizKodonElsoIndex : kodonToAminosav (A,T,G) = 0*16 + 1*4 + 2`;
  `bizKovetkezoCarnot : kovetkezoCarnotFazis IzotermExpanzio = AdiabatikusExpanzio`;
  `bizSteane : (7,1,3) = (7,1,3)` — TAUTOLÓGIA;
  `bizStopKodonHarom : 3 = 3` — TAUTOLÓGIA;
  `bizAlphaHelixHusz : 20 = 20` — TAUTOLÓGIA.
- **main:** nincs (a Main_MagyarKinaiGenKod_v2 futtatja).
- **IMPORTOK:** KomplexByte, MagyarKinaiPar_v2,
  MagyarKinaiAltInverz_v2, MagyarKinaiFazisBayes_v2,
  MagyarKinaiParkettazas_v2, MagyarKinaiFolding_v2.
- **KÁRTYA-JELÖLTEK:** (1) 4 bázis ↔ DNS bázisok — 1; (2) a 64
  kodon enumeráció = 4³ (két út) — 1; (3) degeneráltság 64/20 =
  3.2 — 1; (4) kodon→aminosav index-képlet — 1; (5) a riboszóma
  mint Carnot-ciklus — 1; (6) stop kodon = δ — 1; (7) α-hélix
  3.6×5.66≈20 — 1. **~7 kártya / ~5 oldal.**

## M — MagyarKinaiInverz_v2

**Mit csinál:** a naiv inverz-vizsgálat: 10 teszt, amelyből 9 Refl
(hol egyezik, hol nem egyezik az oda-vissza fordítás) + 1
kipipálhatatlan (a fordító elutasítása maga a bizonyíték).

- **KULCS-KIFUTÁSOK:** `teszt1..teszt10` (mind publikus Refl),
  `InverzEredmenye` (4 konstruktor),
  `magyarKinaiInverzEredmenye = NemInverz`,
  `magyarKinai2SejtMegjegyzes`.
- **BIZONYÍTÁSOK (9 Refl + 1 tiltott):**
  `teszt1_JobbInverzJelenImperf : forditG (forditF (Jelen,Imperf,Kijel)) = (Jelen,Imperf,Kijel)`;
  `teszt2_MultVeszteseg` — KOMMENTBEN, a Refl NEM fordul le (a
  fordító elutasítása = a bizonyíték);
  `teszt3_BalInverzZhe`, `teszt4_BalInverzGuo`, `teszt5_BalInverzLe`
  (oda-vissza egyezés);
  `teszt6_ZaiVeszteseg : F(G(Zai)) = Zhe-t ad, nem Zai-t`;
  `teszt7_ZaiKonkret` (ugyanaz kifejtve);
  `teszt8_TonalitasVeszteseg : (Egy,Egy) → (Nulla,Nulla)`;
  `teszt9_LeMVeszteseg : LeM → De`;
  `teszt10_MaVeszteseg : Ma → De`.
- **main:** nincs (a Main_MagyarKinaiInverz_v2 futtatja).
- **IMPORTOK:** KomplexByte, MagyarKinaiPar_v2.
- **KÁRTYA-JELÖLTEK:** (1) a 10 teszt táblázata (✅/❌) — 2 kártya;
  (2) a „fordító-elutasítás mint bizonyíték" metódus — 1; (3) a 4
  veszteség-típus (igeidő, Zai, tonalitás, LeM/Ma) — 1.
  **~4 kártya / ~3 oldal.**

## M — MagyarKinaiPar_v2

**Mit csinál:** a magyar↔kínai partikula-pár alapja: CatSzint
(Cat⁰..Cat^∞), MagyarCPT (igeidő×aspektus×mód), KinaiCPT
(aspektus×modalitás×tonalitás), az F/G fordító-funktorok, a
természetes transzformáció rekordja, Cat²-pozíció.

- **KULCS-KIFUTÁSOK:** `CatSzint` (5), `magyarKinaiRendszerSzintje
  = Cat2Cat`; `MagyarIgeido` (3), `MagyarAspektus` (3),
  `MagyarMod` (3), `MagyarCPT` rekord; `KubitTonalitas` (2 kubit),
  `KinaiAspektus` (Le 了/Guo 过/Zhe 着/Zai 在),
  `KinaiModalitas` (De 的/LeM 了/Ma 吗/Ba 吧), `KinaiCPT` rekord;
  `magyarAspektusToKinai`, `magyarModToKinaiModalitas`, `forditF`,
  `kinaiAspektusToMagyar`, `kinaiModalitasToMagyarMod`, `forditG`,
  `TermeszetesTranszformacio` (egyenlőség-mezős rekord),
  `Cat2Sint`; listák: `magyarAspektusLista` (3),
  `kinaiAspektusLista` (4), nagybetűs konstansokkal.
- **BIZONYÍTÁSOK (12 Refl):**
  `bizMagyarAspektusHarom : length MagyarAspektusListaKonst = 3`;
  `bizKinaiAspektusNegy : length KinaiAspektusListaKonst = 4`;
  `bizFListaMeret : length (map-ált lista explicit) = 3`;
  `bizMagyarHabituToKinaiGuo`, `bizMagyarImperfToKinaiZhe`,
  `bizMagyarPerfToKinaiLe`, `bizKinaiLeToMagyarPerf`,
  `bizKinaiZaiToMagyarImperf`, `bizMagyarKijToKinaiDe`,
  `bizMagyarFelszToKinaiBa` (leképezések egy-konstruktoronként);
  `bizForditFPelder : forditF (Jelen,Habituális,Kijelentő) = KinaiCPT(Guo,De,(0,0))`;
  `bizForditGPelder : forditG (Le,Ma,(0,0)) = MagyarCPT(Jelen,Perfectum,Kijelentő)`.
- **main:** nincs (a Main_MagyarKinaiPar_v2 futtatja).
- **IMPORTOK:** KomplexByte.
- **KÁRTYA-JELÖLTEK:** (1) a magyar CPT 27 ↔ kínai 64 diagram — 1;
  (2) az F-funktor 3→4 aspektus-leképezés — 1; (3) a G-funktor
  4→3 (Zai/Imperfectum összecsukás) — 1; (4) természetes
  transzformáció (η) — 1; (5) a partikula-táblázat (了过着在 /
  的了吗吧) — 1. **~5 kártya / ~4 oldal.**

## M — MagyarKinaiParkettazas_v2

**Mit csinál:** mondat-szintű parkettázás: 4 Carnot-sor × 5
fázis-oszlop = 20 jelentés-darab; él-illesztés (Bayes),
sarok-illesztés (Carnot), zárt parketta; a mondat mint parketta +
komplex bájt.

- **KULCS-KIFUTÁSOK:** `JelentesDarab`, `osszesDarab = 20`,
  `Parketta`, `parkettaNegySor`, `parkettaOtOszlop`,
  `teljesParketta`, `parkettaSorokSzama = 4`,
  `parkettaOszlopokSzama = 5`, `ElIllesztes`, `fazisDarab`,
  `deltaDarab = 1`, `elKompatibilis`, `SarokIllesztes`,
  `zartParketta`, `ZartParkettaKonst`, `TeljesParkettaKonst`,
  `Mondat` rekord (parketta + komplex bájt + Carnot-fázis),
  `parkettaSorok`, `parkettaToKomplexBajt`, `piroskaElsoMondat`,
  `parkettaCatInf`, `magyarKinaiParkettaSzintje = CatN`.
- **BIZONYÍTÁSOK (4 Refl):**
  `bizOsszesDarabHusz : 4 * 5 = 20`;
  `bizParkettaSorNegy : List.length CarnotCiklusKonst = 4`;
  `bizParkettaOszlopOt : length [5 fázis] = 5`;
  `bizZartParkettaTeljes : ZartParkettaKonst = TeljesParkettaKonst`
  — definíció-egyezés (gyenge).
- **main:** nincs.
- **IMPORTOK:** KomplexByte, MagyarKinaiPar_v2,
  MagyarKinaiFazisBayes_v2.
- **KÁRTYA-JELÖLTEK:** (1) a 4×5 parketta-rács rajza — 1; (2)
  él-/sarok-illesztés szabályai — 1; (3) a zárt parketta
  (periodikus határfeltétel) — 1. **~3 kártya / ~2 oldal.**

## M — MagyarKinaiTorvenyek_v3

**Mit csinál:** a review utáni VALÓDI (nem-tautologikus)
törvények: Carnot-hatásfok számított értéke, Bayes-kétszeres,
bovítás–projekció retrakció ∀ m-re, aspektus-túlélés, túlélő
alkategória (F∘G=id), Zai/Mult NEGATÍV tételek (Not … impossible),
64 kodon két úton, degeneráltság, δ-számítás.

- **KULCS-KIFUTÁSOK:** `carnotHatekonyVizJeg = carnotHatekony 273 373`,
  `evidenciaSzam`, `tonalitasBovitett`,
  `TuleloKinai` (dependent predikátum, 3 konstruktor),
  `alphaInverzCodatV3 = 137.035999177`,
  `alphaInverzHorgonyV3 = 137.036`,
  `deltaSzamitott = Horgony − CODATA` (kernel számol),
  `deltaDeklaralt = 8.23e-7`.
- **BIZONYÍTÁSOK (12 tétel):**
  `bizCarnotHatekonyFel : carnotHatekony 300.0 600.0 = 0.5` (kernel számol);
  `bizBayesKetszer : evidenciaSzam (bayesFrissites (bayesFrissites (prior 0) …) …) = 2`;
  `bizBovitProjekcioMagyar : ∀ m → projekcioMagyar (bovitMagyar m) = m` (3 aspektus-ág);
  `bizTonalitasRetrakcio : ∀ t → projekcioKinaiB (tonalitasBovitett t) = t` (4 tonem-ág);
  `bizAspektusMegmarad : ∀ m → kinaiAspektusToMagyar (magyarAspektusToKinai (aspektusMagyar m)) = aspektusMagyar m` (3 ág);
  `bizModMegmaradKijelento : ∀ m → modMagyar m = MagyarKijelento → … = modMagyar m`;
  `bizTuleloRetrakcio : ∀ k → TuleloKinai k → forditF (forditG k) = k` (dependent, 3 ág: Le/Guo/Zhe);
  `bizZaiNemTulelo : Not (forditF (forditG (Zai…)) = Zai…)` — `Refl impossible` (NEGATÍV);
  `bizMultNemMaradMeg : Not (forditG (forditF (Mult…)) = Mult…)` — impossible (NEGATÍV);
  `bizKodonKetUt : List.length OsszesKodonKonst = 4 * 4 * 4` (enumeráció ⟷ szorzat);
  `bizAminosavKetUt : 4 * 5 = 20`;
  `bizDegeneraltsagSzamitott : 64.0 / 20.0 = 3.2`.
- **main:** nincs.
- **IMPORTOK:** KomplexByte, MagyarKinaiPar_v2,
  MagyarKinaiAltInverz_v2, MagyarKinaiFazisBayes_v2,
  MagyarKinaiGenKod_v2.
- **KÁRTYA-JELÖLTEK:** (1) retrakció-diagram ∀ m — 1; (2) a túlélő
  alkategória {Le,Guo,Zhe}×De×(0,0) — 1; (3) a Zai/Mult negatív
  tételek (impossible) — 2; (4) a 64 két út — 1; (5)
  η(300,600)=0.5 számítás — 1; (6) δ_szamitott levezetése — 1.
  **~7 kártya / ~5 oldal.**

## M — MagyarNyelvtan_v4

**Mit csinál:** a teljes magyar nyelvtani fa: fonetika (14
magánhangzó + 25 mássalhangzó-konstruktor + 9 digráf), hangrend,
18 esetrag (Kiefer 2011) toldalék-alakokkal és kérdéseivel,
igeragozás 3×3×3=27, szófajok, toldaléklista, SzoElemzes rekord.
(v4: a valódi betűnevek konstruktorai — Cs, Gy, A, Á … — a D/V
rövidítés-hullám gyógyítása.)

- **KULCS-KIFUTÁSOK:** `Maganhangzo` (14: A,Á,E,É,I,Í,O,Ó,Ö,Ő,U,Ú,Ü,Ű),
  `Massalhangzo` (25), `Hang`, `Digraf` (9: Cs,Gy,Ly,Ny,Sz,Ty,Zs,Dz,Dzs),
  `Hangrend` (mely/magas/vegyes), `magánhangzóMélyÉ`,
  `karakterbőlMagánhangzó`, `digrafEgyezés`, `szoHangrendje`,
  `szoElsőMh`, `Esetrag` (18), `esetragAlakja` (hangrend-függő),
  `esetragKerdes` (ki? mi? … milyen minőségben?), `Igeido`,
  `Aspektus`, `Evidencialissag`, `Igeragozas` rekord, `Szofaj` (9),
  `ToldalekLista` (~32 tétel), `szotőKinyeres` (egyszerűsített),
  `SzoElemzes` rekord, `egyszerűElemzés`.
- **BIZONYÍTÁSOK:** 0 Refl.
- **main:** nincs.
- **IMPORTOK:** Data.List.
- **KÁRTYA-JELÖLTEK:** (1) a 14 magánhangzó tábla (mély/magas) —
  1; (2) a 9 digráf — 1; (3) a 18 esetrag táblázat (kérdés +
  mély/magas alak) — 2; (4) a 27 igeragozás kocka — 1; (5)
  toldaléklista — 1. **~6 kártya / ~5 oldal.**

## M — Main

**Mit csinál:** a Paragrafus-kódolás futtatható tesztje: szótárkeresés
(„farkas"), „Piroska." mondat kódolása, kétmondatos paragrafus, üres
szöveg, üres komplex bájt életjele. Show instance-ok a KomplexBajt-ra,
SzoJelentes-re, CptFazis-ra.

- **KULCS-KIFUTÁSOK:** `Show CptFazis`, `Show KomplexBajt`,
  `Show SzoJelentes`, `kinyomtatLista`, `kinyomtatSzovegLista`.
- **BIZONYÍTÁSOK:** 0 (a futtatás az ellenőrzés).
- **main:** kiírja a farkas jelentésvektorát, 3 paragrafus-kódolást,
  az üres szöveg mondatlistáját (0), az életjelet (0).
- **IMPORTOK:** KomplexByte, Paragrafus.
- **KÁRTYA-JELŐLTEK:** a fő kimenet ábrája — 1 kártya.
  **~1 kártya / ~1 oldal.**

## M — Main_MagyarKinaiGenKod_v2

**Mit csinál:** a genetikai-kód demó: 4 bázis, 64 kodon, 20
aminosav, 3.2, 3 stop, δ, Steane (7,1,3), α-hélix, első kodon
indexe, első 5 kodon, összefoglaló szövegek.

- **KULCS-KIFUTÁSOK:** `elsoOtKodon : List Kodon -> List Kodon`.
- **BIZONYÍTÁSOK:** 0 (importált biz* futási listája).
- **main:** 10 pontban kinyomtatja a fenti számokat + összefoglaló.
- **IMPORTOK:** KomplexByte, MagyarKinaiGenKod_v2.
- **KÁRTYA-JELÖLTEK:** a demó-kimenet — 1 kártya. **~1 / ~1 oldal.**

## M — Main_MagyarKinaiInverz_v2

**Mit csinál:** az inverz-vizsgálat demója: ✅/❌ lista a jobb és bal
inverzről, a 4 veszteség-típus, az eredmény (NemInverz), a Cat²
2-sejt magyarázata.

- **BIZONYÍTÁSOK:** 0.
- **main:** a fenti lista + `magyarKinaiInverzEredmenye` +
  `magyarKinai2SejtMegjegyzés` + `magyarKinaiRendszerSzintje`.
- **IMPORTOK:** KomplexByte, MagyarKinaiPar_v2, MagyarKinaiInverz_v2.
- **KÁRTYA-JELÖLTEK:** a ✅/❌ táblázat — 1 kártya. **~1 / ~1 oldal.**

## M — Main_MagyarKinaiPar_v2

**Mit csinál:** a partikula-pár demó: 4 magyar CPT példa, F
alkalmazása, G alkalmazása, listahosszak, F a magyar listán,
Cat-szint, a 12 bizonyítás neve.

- **BIZONYÍTÁSOK:** 0.
- **main:** a fentiek kiírása.
- **IMPORTOK:** KomplexByte, MagyarKinaiPar_v2.
- **KÁRTYA-JELÖLTEK:** fordítási példatáblázat — 1 kártya.
  **~1 / ~1 oldal.**

## M — Main_PauliAlgebra_v2

**Mit csinál:** a Pauli-algebra MANTRA-teszt: 9 forgatás a
nulla-elemre, a 6 stabilizátor-generator hossza, Cl(0,14)
egység/nulla elem, [[15,1,3]] érték, a bizonyítások listája.

- **BIZONYÍTÁSOK:** 0 (a lista a fordítási idejű Refl-ekre hivatkozik).
- **main:** a fentiek.
- **IMPORTOK:** PauliAlgebra_v2.
- **KÁRTYA-JELÖLTEK:** a forgatás-tábla — 1 kártya. **~1 / ~1 oldal.**

## M — Main_v2

**Mit csinál:** a holografikus kód v2 MANTRA-teszt: komplex
nulla/egy, perem- és kód-típusnevek, a v2 Refl-jeinek nevei.

- **BIZONYÍTÁSOK:** 0.
- **main:** 5 pont: konstansok, típusnevek, bizonyításlista.
- **IMPORTOK:** KomplexByte, HolografikusKod49_v2_MantraModul.
- **KÁRTYA-JELÖLTEK:** típusnév-demó — 1 kártya. **~1 / ~1 oldal.**

## M — Mondat_v1

**Mit csinál:** a 3D-nyelv 4. emelete: CPTBélyeg rekord (töltés=Forrás,
paritás=Szemlélet, idő=Igeidő; 27 kombináció), réteghidak (IdoBeljegyzes,
ToltesParitasIdo diagonális), CímkézettMondat, VégpontCPTMutató, futási
nub-ellenőrzés.

- **KULCS-KIFUTÁSOK:** `CPTBélyeg` rekord; `Eq`/`Show` instance-ok
  (IgeIdo, IgeSzem, Forras, CPTBélyeg); `igeidők`, `szemléletek`,
  `források`, `cptBélyegek` (27-es lista), `CPTBélyegekKonst`;
  `bélyegIdőBejegyzésre`, `bélyegTöltésParitásIdőre` (homomorfizmus
  a diagonálisra), `fázistényező`; `CímkézettMondat` rekord;
  `VégpontCPTMutató` rekord, `végpontCPTMutató`; `PéldaBélyegKonst`
  (Kozvetlen, Befejezett, Jelen), `CímkézettPéldaKonst`;
  `különbözőBélyegekSzáma = length (nub …) = 27`.
- **BIZONYÍTÁSOK (5 Refl):**
  `bizBélyegekSzáma : length CPTBélyegekKonst = 27` (enumeráció);
  `bizBélyegHíd : 3 * 3 * 3 = length CPTBélyegekKonst` (szorzat ⟷ enumeráció — KÉT ÚT);
  `bizCímkézettVégpont : mondatVégpont (mondat CímkézettPéldaKonst) = FogalomKonstruktor (GyökSzó (E8Gyok (−1)⁸) FélEgészGyökSzó) FélEgészGyökPálya IndividuumJK` (tükrözés-kifejtés ⟷ konstans);
  `bizVégpontPályaMutató : végpontPálya (végpontCPTMutató CímkézettPéldaKonst) = FélEgészGyökPálya`;
  `bizVégpontTávolság : jelentésTávolság (gyökSzó …) PéldaFélEgészSzó = Ellentett` (⟨(−1)⁸,(1⁸)⟩ = −8).
- **main:** a 27 bélyeg, szorzat-híd, nub, példabélyeg fázistényezője
  (1.0), a címkézett mondat, a végpont-mutató, 3 távolság-ellenőrzés.
- **IMPORTOK:** SzintaxisMorfizmus_v1, Fogalom_v1, GyokSzo_v1,
  E8Gyokok_v2, E8BelsoSzorzat, Kategoriak.MagyarOntologia, Steane713,
  HaromKubit, FazisAlgebra_v2, Data.List.
- **KÁRTYA-JELÖLTEK:** (1) a 27-es bélyeg-kocka (3×3×3) — 1; (2) a
  bélyeg-híd (enumeráció=szorzat) — 1; (3) a réteg-homomorfizmus
  (nyelvtani→pszichofizikai diagonális) — 1; (4) a végpont-mutató
  láncrajza — 1; (5) a távolság-ellenőrzések (−8/−4/+8) — 1.
  **~5 kártya / ~4 oldal.**

## M — Muszerefal_v1

**Mit csinál:** a projekt ÖSSZES kulcsmutatója egy 38 mezős rekordban
(csak importált projekciók — §24): E8-geometria (240/112/128/
696729600/248/496/256), [[7,1,3]]-híd (120 pozitív ábécé, fázis-bit
5., 7 bitnév), nyelv (240/112/128/240/27/1.0/eloszlás), GAUGE
hiba-számlálók, fizika (Ising, skálamaradékok, Carnot, Landauer, kB).

- **KULCS-KIFUTÁSOK:** `MűszerfalMutatók` rekord (38 mező),
  `műszerfalMutatók` (EGYETLEN rekord-konstans — let-lánc tilalom
  szerint), `bizMűszerfalEmeletekHídja`.
- **BIZONYÍTÁSOK (1 tétel):**
  `bizMűszerfalEmeletekHídja : List.length AlapszókincsKonst = List.length FogalomTárKonst`
  — bizonyítás: `trans (sym bizKétÚtHíd) bizKétPályaHídFogalmon`
  (KÉT IMPORTÁLT, független enumeráció kompozíciója — §18).
- **main:** 6 csoportos kiírás: E8-geometria, [[7,1,3]]-híd, nyelv,
  fizika (η(500/600/800/373), kB, Landauer), GAUGE-állapotok (mind 0),
  híd-bizonyítás + importált támaszok.
- **IMPORTOK:** E8Iranymutato_v1, E8Univerzalitas_v1, CarnotCiklus_v1,
  MagyarCarnotE9_v3_CodatAlpha, GyokSzo_v1, Fogalom_v1,
  SzintaxisMorfizmus_v1, Mondat_v1, E8FazisKapcsolat_v2,
  E8BelsoSzorzat, E8Gyokok_v2, Data.List, Data.String.
- **KÁRTYA-JELÖLTEK:** (1) a 38 mező egy oldalon (műszerfal-kép) —
  1; (2) az emeletek-híd trans-bizonyítása — 1. **~2 kártya / ~2 oldal.**

## M — Muszerefal_v2

**Mit csinál:** a TELJES műszerfal: a v1 38 mutatója IMPORTÁLVA +
§17 fizikai mérések (α dressed/bare két σ-val, G), a δ két útja,
α_G = 2⁻¹²⁷, E8-rács/szimmetria mutatók, a 17 lépés, kronológia.

- **KULCS-KIFUTÁSOK:** `FizikaiMérés` rekord (§17-négysoros),
  `Mérföldkő`, `codataSzigmaTizenegy = 1.1e-8`,
  `alfaDressedMérés`, `alfaBareMérésSzigmaTizenegy`,
  `alfaBareMérésSzigmaHuszonegy`, `gMérés`, `fizikaiMérések`;
  `FizikaiÁllandóMutatók` (10 mező: alphaBare, delta, alphaDressed,
  alphaCodata, sigmaAlpha, szigma11, gLevezetett, gCodata, sigmaG,
  deltaSzamitott); `E8RácsSzimmetriaMutatók` (7 mező: 1.875, 16, 48,
  154, Bool, 112, 944); `lépésSorok` (17 sor), `kétHetiMérföldkövek`
  (2026-08-18..23), `méresKiírása` (Δ és Δ/σ FUTÁSBAN számolódik).
- **BIZONYÍTÁSOK (1 új Refl):**
  `bizSzindrómaHíd : CarnotE9.SteaneHilbertTerKonst + CarnotE9.SzindromaTerKonst = CarnotE9.E8GyokokKonst`
  (128 + 112 = 240 — két importált konstans összege ⟷ enumeráció).
- **main:** 10 csoport: v1-csoportok + §17-mérések (BELÜL/KÍVÜL
  besorolással), σ-ellentmondás kártya, δ két útja (|δ₁−δ₂| futásból),
  α_G-torony, E8-rács, 17 lépés, kronológia.
- **IMPORTOK:** Muszerefal_v1, E8Iranymutato_v1, AlphaSteane,
  MagyarCarnotE9_v3_CodatAlpha (as CarnotE9),
  MagyarKinaiTorvenyek_v3, Data.String.
- **KÁRTYA-JELÖLTEK:** (1) a §17-négysoros mérikártyák (4 db) — 2;
  (2) a σ-ellentmondás (11 vs 21) — 1; (3) a δ két útja — 1; (4)
  α_G Mersenne-torony — 1; (5) a 17 lépés — 2; (6) kronológia — 1;
  (7) szindróma-híd 128+112=240 — 1. **~9 kártya / ~7 oldal.**

## P — Paragrafus

**Mit csinál:** paragrafus-szintű kódolás: szöveg → mondatok →
szavak → szótári 8-komponensű komplex jelentésvektor → összeadás →
komplex bájt (küszöbölt 7 Steane-bit + CPT-fázis + címke).

- **KULCS-KIFUTÁSOK:** `SzoJelentes` rekord (szó + 8 Komplex),
  `Szotar = List SzoJelentes`, `Paragrafus = List KomplexBajt`,
  `mondatvege`, `szovegMondatokra`, `kisbetus`, `szotarKeres`,
  `osszeadJelentes`, `mondatJelentese`, `jelentesKomplexBajtra`,
  `paragrafusKodol`, `Peldaszotar` (farkas, piroska, hazugsag,
  vadasz).
- **BIZONYÍTÁSOK (3 Refl):**
  `bizKisbetusFarkas : kisbetus "FARKAS" = "farkas"`;
  `bizEgyMondat : length (szovegMondatokra "Piroska.") = 1`;
  `bizUresSzoveg : length (szovegMondatokra "") = 0`.
- **main:** nincs (a Main futtatja).
- **IMPORTOK:** KomplexByte, Data.String, Data.List1.
- **KÁRTYA-JELÖLTEK:** (1) a kódolási folyamatábra (szöveg→bájt) —
  1; (2) a Példaszótár vektorai — 1. **~2 kártya / ~2 oldal.**

## P — PauliAlgebra_v2

**Mit csinál:** 37 hang (14+23, önálló Hang-típus), Pauli X/Y/Z,
6 permutáció = 6 forgás, Steane 6 stabilizátor-generátor (3X+3Z),
Cl(0,7)=128 és Cl(0,14)=16384, tenzor=XOR, [[15,1,3]]=15, γ⁵-
invariancia, szó = Cl(0,14)-elemek láncja.

- **KULCS-KIFUTÁSOK:** `Hang` (37 konstruktor), `HangSzam` /
  `hangSzamErtek = 37`; `PauliHarom` (Px,Py,Pz),
  `PermutacioSzam` (6), `hatPauliPermutacio`, `hatForgatas`;
  `SteaneStabilizator`, `generátorX1..X3`, `generátorZ1..Z3`,
  `steaneHatGenerator`, `SteaneHatGeneratorKonst`; `PauliString`,
  `kompozicioPauli`, `inverzPauli`; `Cl07Dim` (128), `Cl07Elem`
  (7 Kubit), `cl07Megmutat`, `UrressCl07Elem`; `Cl014Dim` (16384),
  `Cl014Elem` (pozitív+negatív+γ⁵); `forgatasCl07` (9 ág: ciklikus
  eltólások); `BetuPauli14`, `SzoPauli14` (UresSzo/BetuSzo),
  `szoHossz`, `szoPauli14Lista`; `cl014Egyseg`,
  `Cl014EgysegKonst`, `UrressCl014Elem`, `xorKubit`, `cl014Tenzor`;
  `Kod1513Dim` (15), `gamma5Invarians`; `pauliAlgebraOnallo`.
- **BIZONYÍTÁSOK (11 Refl):**
  `bizStabilizatorHat : length SteaneHatGeneratorKonst = 6`;
  `bizCl07Dimenzio128 : cl07DimErtek Szazhuszonnyolc = 128`;
  `bizCl014Dimenzio16384 : cl014DimErtek … = 16384`;
  `bizHatForgatasInverz : ∀ x → forgatasCl07 (Px,Py) (forgatasCl07 (Py,Px) x) = x`;
  `bizHatForgatasNegyzet : forgatasCl07 (Px,Py) (forgatasCl07 (Px,Py) UrressCl07Elem) = UrressCl07Elem`;
  `bizHatForgatasCl14 : ∀ p n → …(pozitív oldal a Cl(0,14)-ben)`;
  `bizSzoPauli14Meret : ∀ szo → length (szoPauli14Lista szo) = szoHossz szo` (induktív, cong S);
  `bizCl014Asszociativ`, `bizCl014EgysegJobb` (tenzor-törvények a nullaelemen);
  `bizKod1513Dimenzio : kod1513Ertek Tizenot = 15`;
  `bizGamma5Invarians : gamma5Invarians UrressCl014Elem = UrressCl014Elem`.
- **main:** nincs (a Main_PauliAlgebra_v2 futtatja).
- **IMPORTOK:** KomplexByte.
- **KÁRTYA-JELÖLTEK:** (1) a 6 forgás táblázata (ciklikus eltólás) —
  1; (2) a 6 stabilizátor (X1-X3, Z1-Z3) — 1; (3) Cl(0,7)→Cl(0,14)
  szerkezet (7+7+γ⁵=15) — 1; (4) tenzor=XOR és törvényei — 1; (5) a
  37 hang — 1. **~5 kártya / ~4 oldal.**

## P — PiroskaHolografikusKod49_v3_Teljes

**Mit csinál:** a teljes 22 mondatos Grimm-mese holografikus
kódolásának átalakítói: Komplex→Kubit küszöb, szó→7-bites perem,
toldalék-kezelő szótárkeresés, perem-OR, mondat→HolografikusKod49V2.
(v3: if-zárójelezés javítás a v2-höz képest.)

- **KULCS-KIFUTÁSOK:** `komplexBit`, `szóPerem`,
  `szóPeremKeres`, `részSzöveg`, `tolSzótárKeres` (toldalék-vágásos
  újrapróbálás), `vagyBit`, `peremVagy`, `üresPeremTuple`,
  `mondatPerem`, `mondatHolografikusKód`.
- **BIZONYÍTÁSOK:** 0.
- **main:** nincs.
- **IMPORTOK:** Data.Nat, KomplexByte, Data.String, Paragrafus,
  PiroskaSztarTeljes, HolografikusKod49_v2_MantraModul.
- **KÁRTYA-JELÖLTEK:** (1) a küszöb-konverzió (Komplex→Kubit) — 1;
  (2) a toldalék-kezelő keresés — 1. **~2 kártya / ~1 oldal.**

## P — PiroskaSztar

**Mit csinál:** a mese rövidített szótára: 12 szó (piroska, viszi,
kalacs, nagyany, erdo, talalkozik, farkas, megkerdezi, hova, megy,
elmondja, igazat, hamis, tanacsot) 8-komplex vektorokkal + az 5
egyszerűsített mondat.

- **KULCS-KIFUTÁSOK:** `PiroskaSztarLista : Szotar` (12 szó),
  `PiroskaMese : List String` (5 mondat).
- **BIZONYÍTÁSOK:** 0.
- **main:** nincs.
- **IMPORTOK:** KomplexByte, Paragrafus.
- **KÁRTYA-JELÖLTEK:** a 12 szó vektortáblája — 1 kártya.
  **~1 kártya / ~1 oldal.**

## P — PiroskaSztarTeljes

**Mit csinál:** a teljes Grimm-mese adatbázisa: ~30 szó (szereplők,
helyszínek, tárgyak, cselekvés-igék) 8-komplex vektorokkal és a 22
mondatos szöveg (magyar Wikipédia, CC BY-SA 4.0).

- **KULCS-KIFUTÁSOK:** `PiroskaSztarTeljesLista : Szotar` (~30 szó),
  `PiroskaSztarTeljesMondatok : List String` (22 mondat — forrása a
  22-ös Piroska-számnak a CarnotE9 modulban).
- **BIZONYÍTÁSOK:** 0.
- **main:** nincs.
- **IMPORTOK:** KomplexByte, Paragrafus.
- **KÁRTYA-JELÖLTEK:** (1) a teljes szótár — 2 kártya; (2) a 22
  mondat — 1. **~3 kártya / ~2 oldal.**

## S — SzimaDashboard

**Mit csinál:** dashboard-generator: az Idris SZÁMOL és JSON-t +
Python rajzolót ÍR (a Python csak megjelenít — minden szám a
JSON-ból): kodonok, aminosavak, degeneráltság, Carnot, δ, α-k, a
review-statisztika (41 valódi / 20 tautológia / 6 gyenge), Cat-létra.

- **KULCS-KIFUTÁSOK:** `adatokJson` (JSON-string, minden szám
  Idrisből), `rajzoloPython` (generált matplotlib-kód), `hatvanyKet`,
  `numerikusTeszt` (11 sor).
- **BIZONYÍTÁSOK (1 Refl):**
  `bizHatvanyKetHet : hatvanyKet 7 = 128` (a 2⁷ Steane-kódszó-ter).
- **main:** numerikus tesztek kiírása + `docs/dashboard/adatok.json`
  és `rajzol.py` írása.
- **IMPORTOK:** KomplexByte, MagyarKinaiGenKod_v2,
  MagyarKinaiFazisBayes_v2, MagyarKinaiTorvenyek_v3, System.File.
- **KÁRTYA-JELÖLTEK:** (1) az „Idris számol, Python rajzol"
  architektúra — 1; (2) a generált grafikonok (Cat-létra,
  bizonyítás-statisztika, genetikai kód, Carnot-kör, δ-log) — 2.
  **~3 kártya / ~2 oldal.**

## S — SzintaxisMorfizmus_v1

**Mit csinál:** a nyelv szintaxisa typeclass-ként: `komponál` (Weyl-
tükrözés σ_α(β) = β − (⟨α,β⟩/4)·α a 2-szeres skálán) és `ellenpont`
(β ↦ −β); GyökSzó- és Fogalom-instance; a Mondat = láncolt tükrözés;
kernel-Refl involúcióra, pályaváltásra; 240×240 kimerítő futásidő.

- **KULCS-KIFUTÁSOK:** `SzintaxisMorfizmus` interface (komponál,
  ellenpont); instance-ok `GyökSzó`-ra és `Fogalom`-ra (pálya
  újraszámolódik, kategória MEGMARAD); `Mondat` rekord
  (kezdőFogalom + tükrözésSor), `mondatVégpont` (foldl);
  `RövidMondatKonst` ((2,2,0⁶)→σ(1⁸)→(1,1,−1⁶)→σ(2,2)→(−1)⁸);
  `komponálásZártságiHibákSzáma` (240×240, várt 0),
  `involúcióHibákSzáma` (240×240, várt 0),
  `ellenpontPályaHibákSzáma` (240, várt 0).
- **BIZONYÍTÁSOK (6 Refl):**
  `bizInvolúcióSzón : komponál (1⁸) (komponál (1⁸) (2,2,0⁶)) = (2,2,0⁶)`;
  `bizInvolúcióFogalmon : … = PéldaEgészFogalom` (pálya kétszer vált, kategória sosem);
  `bizEllenpontNégyzet : ellenpont (ellenpont (1⁸)) = (1⁸)`;
  `bizEllenpontPályaMegtartás : pálya (ellenpont (1⁸)) = FélEgészGyökPálya`;
  `bizPályaváltás : pálya (komponál (1⁸)-fogalom (2,2,0⁶)-fogalom) = FélEgészGyökPálya` (W(E8) átlép a D8-pályákon!);
  `bizMondatVégpont : mondatVégpont RövidMondatKonst = FogalomKonstruktor (GyökSzó (−1)⁸ FélEgészGyökSzó) FélEgészGyökPálya IndividuumJK`.
- **main:** tükrözés-példák, involúció, a példamondat lánc, 3
  kimerítő számláló (mind 0).
- **IMPORTOK:** Fogalom_v1, GyokSzo_v1, E8BelsoSzorzat,
  E8Gyokok_v2, Kategoriak.MagyarOntologia, Data.List.
- **KÁRTYA-JELÖLTEK:** (1) a tükrözés-képlet levezetése (⟨α,β⟩/4) —
  1; (2) involúció-rajz (σ∘σ=id, pálya oda-vissza) — 1; (3) a
  pályaváltás (W(E8) vs W(D8) két pálya) — 1; (4) a mondat-lánc
  diagram — 1; (5) a 240×240 zártsági kimerítés — 1. **~5 kártya /
  ~4 oldal.**

## S — Steane713 (fájl: osveny_index/Steane713.idr)

**Mit csinál:** a [[7,1,3]] Steane-kód magja: Kubit, HetesKod,
alapKod, forditKubit, Szindroma, javitas (7 pozíció), többségi
dekódolás (16+1 ág), noetherTetel (a javítás mindig visszaadja a
logikai értéket), IgeIdo/IgeSzem/Forras (a CPT 3 dimenziója),
IdoBeljegyzes, [[15,1,3]] (tizenotKodol/Dekodol), TGate,
Inverz/Kodolo typeclass-ok kompozícióval (ParInverz,
KodoloOsszetetel).

- **KULCS-KIFUTÁSOK:** `Kubit` (Nulla/Egy), `HetesKod`,
  `alapKod`, `forditKubit`, `Szindroma` (NincsHiba/EgyesHiba/
  Tobbszoros), `javitas`, `steaneDekodol`; `IgeIdo` (Mult/Jelen/Jovo),
  `IgeSzem` (Folyamatos/Befejezett/Szokasos), `Forras` (Kozvetlen/
  Kovetkeztetett/Jelentett), `IdoBeljegyzes`, `IdoMorfizmus`;
  `PauliMx` (I/X/Y/Z), `PauliTenzor`, `TizenotEgyHaromKod`,
  `TizenotBit`, `tizenotKodol`, `tizenotDekodol`, `TGate`;
  `Inverz`, `Kodolo` interface-ok + `[ParInverz]`,
  `[KodoloOsszetetel]` instance-ok; `Inverz Kubit`, `Kodolo Kubit
  HetesKod` instance-ok.
- **BIZONYÍTÁSOK (7 tétel):**
  `noetherTetel : ∀ k n → steaneDekodol (javitas (alapKod k) (EgyesHiba n)) = k` — 16 Refl-ág (2×7 konkrét + 2 catch-all);
  `forditTorveny` (Kubit, Inverz): 2 Refl-ág;
  `ParInverz.forditTorveny` : cong+trans-kompozíció (konstruktoros bizonyítás);
  `KodoloOsszetetel.kodTorveny` : cong+trans-lánc;
  `Kodolo Kubit HetesKod.kodTorveny` : 2 Refl-ág.
  (Összesen ~23 Refl-ág 7 tétel-név alatt.)
- **main:** nincs.
- **IMPORTOK:** nincs (önálló).
- **KÁRTYA-JELÖLTEK:** (1) a 7 bit jelentése [idő, okság, tér, szín,
  hang, fázis, mód] — 1; (2) szindróma+javítás folyamata — 1; (3) a
  noetherTetel (16 ág) — 2; (4) a 27 = 3×3×3 igei bélyeg — 1; (5)
  [[15,1,3]] = 7+8 — 1; (6) a Kodolo-kompozíció törvénye — 1.
  **~7 kártya / ~5 oldal.**

## T — TetrapodaTest

**Mit csinál:** a tetrapoda-test (2 oldal × 5 ujj = 10, 4 végtag)
számainak algebraja: base 10 = oktáv×tükör, 137 = [k,d,n] = a
Steane-paraméterek base 10-ben, Hox-gének (Shh, Hoxa11, Hoxa13).

- **KULCS-KIFUTÁSOK:** `oldalakSzama = 2`, `vegltagokSzama = 4`,
  `ujjakSzama = 5`, `osszesUjj = 10`, `oktavPrim = 2`,
  `tukorPrim = 5`, `dCrit = 4`, `steaneN = 7`, `steaneK = 1`,
  `steaneD = 3`, `szazHaromHet = 137`, `baseTiz = 10`;
  nagybetűs konstansok (OsszesUjjKonst, BaseTizKonst,
  SzazHaromHetKonst).
- **BIZONYÍTÁSOK (3 Refl):**
  `bizOsszesUjj : OsszesUjjKonst = 10` (2×5);
  `bizBaseTiz : BaseTizKonst = 10`;
  `biz137 : SzazHaromHetKonst = 137` (k×100+d×10+n).
- **main:** a test-struktúra, az 5 ujj evolúciója (Tiktaalik…),
  base 10, a 137=[k,d,n], a lánc (test→base10→137→Steane→α⁻¹→CODATA).
- **IMPORTOK:** nincs (önálló).
- **KÁRTYA-JELÖLTEK:** (1) a 2×5×4 test-algebra — 1; (2) a
  137=[k,d,n] egyetlen bázisban — 1; (3) a Hox-lánc — 1.
  **~3 kártya / ~2 oldal.**

## T — TizenhatPenge

**Mit csinál:** a Cl(4) 16 pengéje (bitmask 0..15, fok = popcount,
fokszámok (1,4,6,4,1), Hodge-duál 15−x involúció) + a Hamming
[7,4,3] kód (generátor G, 16 kódszó, súlyeloszlás (1,7,7,1),
d≥3) + a híd: 240 + 16 = 256 = 2⁸ (ékezetes nemzedék, az
E8TizenhatPenge utóda).

- **KULCS-KIFUTÁSOK:** `tizenhatPenge : List Integer` [0..15],
  `pengeFok` (popcount), `pengeDuál` (15−x), `fokSzámlálók` =
  (1,4,6,4,1); `gf2` (KANONIKUS otthon), `generátorSorok` (4×7
  mátrix), `kódszámítás` (m·G mod 2), `összesÜzenet` (16),
  `mindenKódszó` (16), `kódSúly`, `hammingTávolság`,
  `párTávolságok`, `mindLegalábbHárom`, `vanHárom`;
  `pengeGondolatok` (SPECULATÍV — §18.4 jelöléssel).
- **BIZONYÍTÁSOK (9 Refl):**
  `BizFokszámÖsszeg : 1 + 4 + 6 + 4 + 1 = 16` (binomiális tétel);
  `BizKettőNegyedik : 2 * 2 * 2 * 2 = 16` (KÉT ÚT);
  `BizHodgePélda : pengeDuál 3 = 12` (e1∧e2 → e3∧e4);
  `BizHodgeInvolúcióPélda : pengeDuál (pengeDuál 5) = 5`;
  `BizKódszóElső : kódszámítás [1,0,0,0] = [1,0,0,0,0,1,1]`;
  `BizKódszóMindEgyes : kódszámítás [1,1,1,1] = [1,1,1,1,1,1,1]`;
  `BizSúlyÖsszeg : 1 + 7 + 7 + 1 = 16` ((1,7,7,1) szimmetria);
  `BizHíd : 240 + 16 = 256` (KÉT ÚT: E8-gyökök + Cl(4)-pengék);
  `BizKettőNyolcadik : 256 = 2⁸`.
- **main:** fokszámok, Hodge-példák + involúció mind a 16-ra,
  16 kódszó (nub-bal: nincs ütközés), súlyeloszlás (1,7,7,1),
  d≥3 + van-3, a híd (E8GyökökKonst = 240), spekulatív gondolatok.
- **IMPORTOK:** E8Gyökök, Data.List.
- **KÁRTYA-JELÖLTEK:** (1) a 16 penge rácsa fok szerint (1,4,6,4,1)
  — 1; (2) a Hodge-duál (k↔4−k) — 1; (3) a Hamming G-mátrix és egy
  kódszó-számítás — 1; (4) a súlyeloszlás (1,7,7,1) ↔ Hodge
  (1,4,6,4,1) — 1; (5) a 240+16=256 híd — 1; (6) a spekulatív
  zárszó (TÁVÍRÓ) — 1. **~6 kártya / ~4 oldal.**

---

# ÖSSZESÍTÉS

| Mutató | Érték |
|---|---|
| L–Z modulok száma | **29** (19 M + 5 P + 3 S + 2 T) |
| Ebből bizonyítás-tartalmú | 19 |
| Ebből csak demó/adat/main | 10 (MagyarNyelvtan_v4, Main×6, Piroska×3 — a PiroskaHolografikusKod49_v3 átalakító) |
| Bizonyítás-nevek (Refl/biz*/teszt*/törvények) összesen | **~118** (a többlágúak: noetherTetel 16 ág, retrakciók 3–4 ág) |
| Refl-ágak becsült összege | ~150 |
| Ebből §18 szerint TAUTOLÓGIA (jelölve) | 5 (bizFoldingIteraciokNegy, bizSteane, bizStopKodonHarom, bizAlphaHelixHusz, bizZartParkettaTeljes-gyenge) |
| Negatív tételek (Not … impossible) | 2 (bizZaiNemTulelo, bizMultNemMaradMeg) + 1 fordító-elutasításos (teszt2, kommentben) |
| „Két független út, egy híd" bizonyítások | 8+ (bizKodonKetUt, bizBélyegHíd, bizKodonHatvanNegy, bizMűszerfalEmeletekHídja, bizSzindrómaHíd, BizHíd, BizKettőNegyedik/Nyolcadik, bizE8Gyokok-család) |
| Futtatható main | 13 modulban |
| Becsült KÁRTYÁK (B-rész) | **~105 kártya** (sáv: 95–120) |
| Becsült OLDALAK (B-rész) | **~80 oldal** (sáv: 75–95; magyar-bal/angol-jobb könyvoldalon) |

Megjegyzések a könyv-tervhez:
1. A legerősebb kártya-anyag: **MagyarKinaiTorvenyek_v3** (valódi
   törvények + negatív tételek), **SzintaxisMorfizmus_v1** (tükrözés,
   pályaváltás, 240×240 kimerítés), **Mondat_v1** (27-bélyeg + híd),
   **Steane713** (noetherTetel), **Muszerefal_v2** (§17-méréskártyák).
2. A tautológiákat a könyvben MINDIG jelölve kell mutatni (§18).
3. A Steane713 az ipkg-ban van, de a fájl az `osveny_index/`-ben —
   a könyv fejezet-számozásánál ezt a rendellenessést érdemes
   feltüntetni.
4. A „KÁRTYA" itt = egy összefüggő levezetés/ábra/táblázat egység
   (kb. fél–egy könyvoldal).
