module CarnotCiklus_v1

-- ═══════════════════════════════════════════════════════════════
-- CARNOT-CIKLUS v1 — a hajtás Idris-modulja (W7 munkafolyam)
-- CARNOT CYCLE v1 · 卡诺循环 v1 · Carnot-Prozess v1 · מחזור קרנו v1
-- ═══════════════════════════════════════════════════════════════
--
-- TARTALOM (a W7 feladatsor szerint):
--   1. A Carnot-négylépés TÍPUSA — IMPORTÁLT (§24: kód duplikáció
--      TILOS): a CarnotLepes adattípus a MagyarCarnotE9_v3_CodatAlpha
--      modulban ÉL (a csomagban, fordul); ide NEM másoljuk — itt
--      ékezetes alias és állapotgép épül rá.
--   2. A hatásfok PONTOS törtszám-formája (Nat számláló/nevező),
--      Refl-bizonyításokkal 4 darab (Th, Tc) párra — két független
--      út, egy híd (§18: tautologikus Refl tilos).
--   3. Landauer-küszöb (kB SI-exakt) 300 K-re és 1 K-re (main).
--   4. A Carnot-ciklus mint ÁLLAPOTGÉP: a négy lépés végigfuttatva,
--      a záródás Refl-lel (a lépéssorozaton át vezet — nem `x = x`).
--
-- FORRÁSOK (§N12 — keresés 2026-08-23):
--   * Carnot-hatásfok η = 1 − Tc/Th; a négy lépés (izoterma
--     tágulás → adiabata lehűlés → izoterma sűrítés → adiabata
--     melegítés): https://en.wikipedia.org/wiki/Carnot_cycle
--   * Landauer-elv E = kB·T·ln 2; szobahőmérsékleten ≈ 2,9×10⁻²¹ J:
--     https://en.wikipedia.org/wiki/Landauer's_Principle
--   * kB = 1,380649×10⁻²³ J/K SI-EXAKT defináló állandó (a 2019-es
--     SI-revízió, 26. CGPM): https://www.bipm.org/en/-/resolution-cgpm-26-1
--     és https://en.wikipedia.org/wiki/Boltzmann_constant
--
-- §17 MEGJEGYZÉS (mérési hiba-kötelezettség): a kB DEFINÍCIÓ szerint
-- exakt (a kelvin maga a kB-ból van definiálva), ezért NINCS mérési
-- σ, és a Δ/σ elemzés nem alkalmazható — az egyetlen számítási
-- pontatlanság az IEEE-754 kerekítés (ln 2 értéke).
-- | §17：kB 是 SI 定义常数（无测量不确定度），故无 σ 可言。
--
-- §13: minden korábbi Carnot-modul (MagyarCarnotE9_v2, v2_2, v3,
-- MagyarKinaiFazisBayes_v2) ÉRINTETLENÜL marad; ez az ÚJ modul.
-- ═══════════════════════════════════════════════════════════════

import MagyarCarnotE9_v3_CodatAlpha

%default total

-- ===============================================================
-- 1. A CARNOT-NÉGYLÉPÉS — IMPORTÁLT TÍPUS (§24)
--    A négy lépés · 四个步骤 · Die vier Schritte · ארבעת השלבים
-- ===============================================================

||| Ékezetes alias az importált CarnotLepes típusra (§24: import,
||| NEM másolás — a négy konstruktor a MagyarCarnotE9_v3_CodatAlpha-ban él:
||| IzotermExpanzio, AdiabatikusExpanzio, IzotermKompresszio,
||| AdiabatikusKompresszio).
public export
CarnotLépés : Type
CarnotLépés = CarnotLepes

||| A Carnot-lépések megjelenítése (a main kiírásához).
Show CarnotLepes where
  show IzotermExpanzio        = "izoterma tágulás (Th)"
  show AdiabatikusExpanzio    = "adiabata lehűlés (Th → Tc)"
  show IzotermKompresszio     = "izoterma sűrítés (Tc)"
  show AdiabatikusKompresszio = "adiabata melegítés (Tc → Th)"

-- ===============================================================
-- 2. A HATÁSFOK PONTOS TÖRTJE (Nat számláló és nevező)
--    效率的精确分数 · Der exakte Wirkungsgrad · היעילות המדויקת
-- ===============================================================

||| A hatásfok pontos törtként: számláló/nevező (Nat).
||| η = (Th − Tc) / Th — a hőmérsékletek kelvinben, egész számként.
record Hatásfok where
  constructor HatásfokKonstruktor
  számláló : Nat
  nevező   : Nat

||| A hatásfok megjelenítése "számláló/nevező" alakban.
Show Hatásfok where
  show (HatásfokKonstruktor számláló nevező) =
    show számláló ++ "/" ++ show nevező

||| A hatásfok kiszámítása egész hőmérsékletekből (skálázott egész).
||| η = (tMeleg − tHideg) / tMeleg.
||| (A Nat-kivonás `minus` — a Prelude-ben nincs Neg Nat instance;
||| l. a MagyarCarnotE9_v3_CodatAlpha v3-javítását.)
public export
hatásfokTört : (tMeleg : Nat) -> (tHideg : Nat) -> Hatásfok
hatásfokTört tMeleg tHideg =
  HatásfokKonstruktor (minus tMeleg tHideg) tMeleg

-- ─── 2a. A keresztszorzat-bizonyítások (két út, egy híd) ────────
-- Az η = számláló/nevező állítást KERESZTSZORZAT-egyenlőségként
-- bizonyítjuk: nevező·(Th − Tc) = számláló·Th. A két oldal KÉT
-- FÜGGETLEN konstrukció, amelyet a kernel ugyanarra kényszerít —
-- ez a §18 szerinti értelmes Refl, nem tautológia.

-- Kimenet: Refl — 5·(500−300) = 1000 = 2·500, azaz η(500, 300) = 2/5
public export
bizEtaÖtszázHáromszáz : 5 * minus 500 300 = 2 * 500
bizEtaÖtszázHáromszáz = Refl

-- Kimenet: Refl — 2·(600−300) = 600 = 1·600, azaz η(600, 300) = 1/2
public export
bizEtaHatszázHáromszáz : 2 * minus 600 300 = 1 * 600
bizEtaHatszázHáromszáz = Refl

-- Kimenet: Refl — 8·(800−300) = 4000 = 5·800, azaz η(800, 300) = 5/8
public export
bizEtaNyolcszázHáromszáz : 8 * minus 800 300 = 5 * 800
bizEtaNyolcszázHáromszáz = Refl

-- Kimenet: Refl — 373·(373−273) = 37300 = 100·373,
-- azaz η(forrás/jég, 373, 273) = 100/373 (a víz/jég páros,
-- l. SzimaDashboard carnot_viz_jeg értékét)
public export
bizEtaVízJég : 373 * minus 373 273 = 100 * 373
bizEtaVízJég = Refl

-- ─── 2b. A tört-forma bizonyítása (a számláló számítása) ────────

||| Nagybetűs konstans a bizonyítás-típushoz (KisBetűsProjekcióCsapda).
public export
HatásfokÖtszázHáromszázKonst : Hatásfok
HatásfokÖtszázHáromszázKonst = HatásfokKonstruktor 200 500

-- Kimenet: Refl — a tört útja: számláló = 500−300 = 200 (a kernel
-- számolja a kivonást), nevező = 500.
public export
bizHatásfokÖtszázHáromszáz :
  hatásfokTört 500 300 = HatásfokÖtszázHáromszázKonst
bizHatásfokÖtszázHáromszáz = Refl

-- ─── 2c. A híd: a pontos tört és a Double-képlet találkozása ────

-- Kimenet: Refl — két független út, egy híd: a pontos törtszám
-- 2/5 = 0,4, és az importált Double-képlet (carnotHatekonysag,
-- MagyarCarnotE9_v3_CodatAlpha) ugyanezt adja IEEE-754-ben
-- (1.0 − 300.0/500.0 = 0.4 exakt Sterbenz-lemma szerint).
public export
bizEtaHídKétszerÖt : carnotHatekonysag 300.0 500.0 = 0.4
bizEtaHídKétszerÖt = Refl

-- ===============================================================
-- 3. LANDAUER-KÜSZÖB — E = kB·T·ln 2 (kB SI-EXAKT)
--    兰道尔极限 · Landauer-Grenze · גבול לנדאואר
-- ===============================================================

||| A Boltzmann-állandó SI-EXAKT értéke (2019-es SI-revízió, BIPM):
||| kB = 1,380649×10⁻²³ J/K — DEFINÍCIÓ, nem mérés (§17: nincs σ).
public export
boltzmannÁllandó : Double
boltzmannÁllandó = 1.380649e-23

||| A 2 természetes logaritmusa (ln 2 ≈ 0,693147…).
public export
kettőTermészetesLogaritmusa : Double
kettőTermészetesLogaritmusa = log 2.0

||| A Landauer-küszöb: E = kB·T·ln 2 — egy bit TÖRLÉSÉNEK minimális
||| energiája a T hőmérsékleten (Landauer-elv, 1961).
public export
landauerKüszöb : (hőmérsékletKelvinben : Double) -> Double
landauerKüszöb hőmérsékletKelvinben =
  boltzmannÁllandó * hőmérsékletKelvinben * kettőTermészetesLogaritmusa

-- ===============================================================
-- 4. A CARNOT-CIKLUS MINT ÁLLAPOTGÉP
--    状态机 · Zustandsmaschine · מכונת מצבים
-- ===============================================================

||| A Carnot-állapotgép négy állapota (a ciklus négy üteme).
public export
data CarnotÁllapot : Type where
  ElsőIzotermaTágulás     : CarnotÁllapot
  MásodikAdiabataLehűlés  : CarnotÁllapot
  HarmadikIzotermaSűrítés : CarnotÁllapot
  NegyedikAdiabataMelegítés : CarnotÁllapot

||| Az állapotok megjelenítése.
Show CarnotÁllapot where
  show ElsőIzotermaTágulás       = "1. izoterma tágulás"
  show MásodikAdiabataLehűlés    = "2. adiabata lehűlés"
  show HarmadikIzotermaSűrítés   = "3. izoterma sűrítés"
  show NegyedikAdiabataMelegítés = "4. adiabata melegítés"

||| Az állapotgép LÉPÉSFÜGGVÉNYE: a Carnot-ciklus következő üteme.
||| 1 → 2 → 3 → 4 → 1 (a ciklus zárul).
public export
következőÁllapot : CarnotÁllapot -> CarnotÁllapot
következőÁllapot ElsőIzotermaTágulás       = MásodikAdiabataLehűlés
következőÁllapot MásodikAdiabataLehűlés    = HarmadikIzotermaSűrítés
következőÁllapot HarmadikIzotermaSűrítés   = NegyedikAdiabataMelegítés
következőÁllapot NegyedikAdiabataMelegítés = ElsőIzotermaTágulás

||| A híd az importált Carnot-lépésekhez: melyik CarnotLepes
||| (MagyarCarnotE9_v3_CodatAlpha) tartozik az állapothoz.
public export
állapotLépése : CarnotÁllapot -> CarnotLepes
állapotLépése ElsőIzotermaTágulás       = IzotermExpanzio
állapotLépése MásodikAdiabataLehűlés    = AdiabatikusExpanzio
állapotLépése HarmadikIzotermaSűrítés   = IzotermKompresszio
állapotLépése NegyedikAdiabataMelegítés = AdiabatikusKompresszio

||| A TELJES CIKLUS: a négy lépés kompozíciója (egyetlen fordulat).
public export
teljesCiklus : CarnotÁllapot -> CarnotÁllapot
teljesCiklus =
  következőÁllapot . következőÁllapot
                 . következőÁllapot . következőÁllapot

-- Kimenet: Refl — a kezdőállapot a NÉGY lépésen át visszatér
-- önmagába (a kernel a teljes láncot számolja ki — nem `x = x`
-- tautológia, §18: a lépéssorozaton át vezet az egyenlőség).
public export
bizCiklusZáródikElsőről :
  teljesCiklus ElsőIzotermaTágulás = ElsőIzotermaTágulás
bizCiklusZáródikElsőről = Refl

-- Kimenet: Refl — a záródás a MÁSODIK állapotból is teljesül
-- (a ciklus minden állapotból zárul — itt két független kezdőpont).
public export
bizCiklusZáródikMásodikról :
  teljesCiklus MásodikAdiabataLehűlés = MásodikAdiabataLehűlés
bizCiklusZáródikMásodikról = Refl

||| A teljes ciklus állomásai (a main végigfuttatja; lista-konstans,
||| NEM let-lánc — l. a LetLáncProbe tanulságot).
public export
ciklusÁllomások : List CarnotÁllapot
ciklusÁllomások =
  [ ElsőIzotermaTágulás
  , következőÁllapot ElsőIzotermaTágulás
  , következőÁllapot (következőÁllapot ElsőIzotermaTágulás)
  , következőÁllapot (következőÁllapot (következőÁllapot ElsőIzotermaTágulás))
  , teljesCiklus ElsőIzotermaTágulás
  ]

||| Nagybetűs konstans a bizonyítás-típushoz (KisBetűsProjekcióCsapda).
public export
CiklusÁllomásokKonst : List CarnotÁllapot
CiklusÁllomásokKonst = ciklusÁllomások

-- Kimenet: Refl — az állomássor öt elemű (kezdő + 4 ütem, az utolsó
-- visszatér a kezdőhöz).
public export
bizÁllomásokSzámaÖt : length CiklusÁllomásokKonst = 5
bizÁllomásokSzámaÖt = Refl

-- ===============================================================
-- 5. A MAIN — a hajtás végigfuttatása
--    主函数 · Das Hauptprogramm · התוכנית הראשית
-- ===============================================================

||| A W7-hajtás: hatásfok-törtek, Landauer-küszöb, állapotgép-futás.
main : IO ()
main = do
  putStrLn "═══ CARNOT-CIKLUS v1 — a hajtás Idris-modulja (W7) ═══"
  putStrLn ""
  putStrLn "-- 1. A hatásfok pontos törtként (Nat, Refl-lel bizonyítva):"
  putStrLn ("   η(Th=500 K, Tc=300 K) = " ++ show (hatásfokTört 500 300)
            ++ "   [5·(500−300) = 2·500 = 1000, Refl]")
  putStrLn ("   η(Th=600 K, Tc=300 K) = " ++ show (hatásfokTört 600 300)
            ++ "   [2·(600−300) = 1·600, Refl]")
  putStrLn ("   η(Th=800 K, Tc=300 K) = " ++ show (hatásfokTört 800 300)
            ++ "   [8·(800−300) = 5·800, Refl]")
  putStrLn ("   η(Th=373 K, Tc=273 K) = " ++ show (hatásfokTört 373 273)
            ++ "   [373·(373−273) = 100·373, Refl]")
  putStrLn ("   Double-híd: carnotHatekonysag 300 500 = 0.4 [Refl]")
  putStrLn ""
  putStrLn "-- 2. Landauer-küszöb E = kB·T·ln 2 (kB SI-exakt; §17: nincs σ):"
  putStrLn ("   T = 300 K:  E = " ++ show (landauerKüszöb 300.0)
            ++ " J  (≈ 2,87×10⁻²¹ J)")
  putStrLn ("   T = 1 K:    E = " ++ show (landauerKüszöb 1.0)
            ++ " J")
  putStrLn ""
  putStrLn "-- 3. A Carnot-ciklus mint állapotgép (a négy ütem futása):"
  putStrLn ("   " ++ show ciklusÁllomások)
  putStrLn ("   lépései: " ++ show (map állapotLépése ciklusÁllomások))
  putStrLn ("   a ciklus záródik: teljesCiklus Első = Első [Refl]")
