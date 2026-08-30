module Szotar

-- ═══════════════════════════════════════════════════════════════
-- SZOTAR — a fogalmak es kapcsolatok adatbazisa
-- ═══════════════════════════════════════════════════════════════
-- Az AI nyelve az Idris: a tudas = szotar, a dolgok kozotti
-- kapcsolatok es a LEHETSEGES kapcsolatok. Ez a modul az adat:
--
--   Fogalom  = csucs (nev + E8Pont bajt-hely + kategoria)
--   KapcsolatTipus = ELTIPUS — a 18 esetrag (Kiefer 2011)
--                    + 4 logikai kiegészítő (rész, ellentét,
--                    szinonima, generalizáció)
--   El       = iranyitott el (forras, tipus, cel)
--   Graf     = fogalmak +elek
--
-- Lekérdezések (mind tiszta, total):
--   fogalomKeres        : nev -> Maybe Fogalom
--   szomszedok          : nev -> List (nev, tipus)      (kimenő)
--   bejvoSzomszedok     : nev -> List (nev, tipus)      (bejövő)
--   fokSzam             : nev -> Nat
--   kapcsolatValoszinuseg : KapcsolatTipus -> Tort       (MDL-számlálás)
--   utHossz             : uzemanyag -> a -> b -> Maybe Nat (MDL-távolság)
--
-- MDL-elv: két fogalom távolsága = a legrövidebb leírás hossza
-- a gráfban (minden él 1 bit-értékű lépés). Valószínűség =
-- determinisztikus számlálás az adatból (Tort, nem Double).
-- ═══════════════════════════════════════════════════════════════

import Steane713
import E8E8Algebra
import LawvereGodel

%default total

-- ─── 1. TÖRT (valószínűség — determinisztikus számlálás) ───

public export
record Valoszinuseg where
  constructor ValK
  kedvezo : Integer
  osszes  : Integer

public export
Show Valoszinuseg where
  show (ValK k o) = show k ++ "/" ++ show o

public export
szazalek : Valoszinuseg -> Double
szazalek (ValK k o) = if o == 0 then 0.0 else fromInteger k * 100.0 / fromInteger o

-- ─── 2. ÉLTÍPUSOK — a 18 esetrag + 4 logikai ───────────────

public export
data KapcsolatTipus =
  -- a 18 esetrag (Kiefer) mint viszony
    CausalisK      -- miért? ok-okozat
  | InstrumentalisK -- mivel? eszköz
  | InessivusK     -- hol/ben? tartalmazás
  | IllativusK     -- hová/be? bekerülés
  | ElativusK      -- honnan/ből? származás
  | DativusK       -- kinek? cél, kedvezményezett
  | AccusativusK   -- mit? hatás tárgya
  | TranszlativusK -- mivé? átalakulás
  | EssivusK       -- mint? szerep, hasonlóság
  | SublativusK    -- mire? támaszkodás, épülés
  | AllativusK     -- kihez? kapcsolódás
  | TerminativusK  -- meddig? határ
  | NominativusK   -- ki/mi? alany, hordozó
  -- logikai kiegészítők
  | ReszeK         -- rész–egész
  | EllenteteK     -- ellentét
  | SzinonimaK     -- azonos értelemben
  | GeneralizacioK -- faj–nem (is-a)

public export
Eq KapcsolatTipus where
  CausalisK == CausalisK = True
  InstrumentalisK == InstrumentalisK = True
  InessivusK == InessivusK = True
  IllativusK == IllativusK = True
  ElativusK == ElativusK = True
  DativusK == DativusK = True
  AccusativusK == AccusativusK = True
  TranszlativusK == TranszlativusK = True
  EssivusK == EssivusK = True
  SublativusK == SublativusK = True
  AllativusK == AllativusK = True
  TerminativusK == TerminativusK = True
  NominativusK == NominativusK = True
  ReszeK == ReszeK = True
  EllenteteK == EllenteteK = True
  SzinonimaK == SzinonimaK = True
  GeneralizacioK == GeneralizacioK = True
  _ == _ = False

public export
Show KapcsolatTipus where
  show CausalisK       = "-ért (ok)"
  show InstrumentalisK = "-val (eszköz)"
  show InessivusK      = "-ban (tartalmaz)"
  show IllativusK      = "-ba (beérkezik)"
  show ElativusK       = "-ból (származik)"
  show DativusK        = "-nak (cél)"
  show AccusativusK    = "-t (hatás tárgya)"
  show TranszlativusK  = "-vá (átalakul)"
  show EssivusK        = "-ként (mint)"
  show SublativusK     = "-re (épül)"
  show AllativusK      = "-hoz (kapcsolódik)"
  show TerminativusK   = "-ig (határ)"
  show NominativusK    = "ø (alany)"
  show ReszeK          = "része"
  show EllenteteK      = "ellentéte"
  show SzinonimaK      = "= (szinonima)"
  show GeneralizacioK  = "faj>a (generalizál)"

-- ─── 3. FOGALOM KATEGÓRIA ──────────────────────────────────

public export
data Kategoria =
    MatekK | FizikaK | NyelvK | ZeneK | SzamitastudomanyK
  | FilozofiaK | BiologiaK | KozgazdasagK

public export
Show Kategoria where
  show MatekK            = "matematika"
  show FizikaK           = "fizika"
  show NyelvK            = "nyelv"
  show ZeneK             = "zene"
  show SzamitastudomanyK = "számítástudomány"
  show FilozofiaK        = "filozófia"
  show BiologiaK         = "biológia"
  show KozgazdasagK      = "ökonómia"

-- ─── 4. FOGALOM — csucs, E8-bajt helypozicióval ────────────

public export
record Fogalom where
  constructor FogalomK
  nev        : String
  kat        : Kategoria
  e8hely     : E8Pont     -- a fogalom byte-helye a rácsban

public export
Show Fogalom where
  show f = show (nev f) ++ " [" ++ show (kat f) ++ "]"

-- ─── 5. ÉL es GRAF ─────────────────────────────────────────

public export
record El where
  constructor ElK
  forras : String
  tipus  : KapcsolatTipus
  cel    : String

public export
Show El where
  show e = show (forras e) ++ " " ++ show (tipus e) ++ " " ++ show (cel e)

public export
record Graf where
  constructor GrafK
  fogalmak : List Fogalom
  elek     : List El

public export
Show Graf where
  show g = "Graf: " ++ show (length (fogalmak g)) ++ " fogalom, "
         ++ show (length (elek g)) ++ " él"

-- ─── 6. AZ ADAT — a projekt fogalom-univerzuma ─────────────
-- E8-bájt-kódok: a Kodol.idr szótárával konzisztens fő fogalmak.

p8 : Kubit -> Kubit -> Kubit -> Kubit -> Kubit -> Kubit -> Kubit -> Kubit -> E8Pont
p8 = E8PontKonstruktor

public export
projektFogalmak : List Fogalom
projektFogalmak =
  [ -- matematika
    FogalomK "kategória"       MatekK    (p8 Egy Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
  , FogalomK "funktor"         MatekK    (p8 Nulla Nulla Nulla Egy Nulla Nulla Nulla Nulla)
  , FogalomK "adjunkció"       MatekK    (p8 Nulla Nulla Nulla Nulla Egy Nulla Nulla Nulla)
  , FogalomK "fixpont"         MatekK    (p8 Egy Nulla Nulla Nulla Nulla Nulla Nulla Egy)
  , FogalomK "aranymetszés"    MatekK    (p8 Nulla Egy Nulla Nulla Egy Nulla Nulla Nulla)
  , FogalomK "E8"              MatekK    (p8 Egy Nulla Nulla Egy Nulla Nulla Nulla Nulla)
  , FogalomK "E9"              MatekK    (p8 Egy Nulla Nulla Egy Nulla Nulla Nulla Egy)
  , FogalomK "KacMoody"        MatekK    (p8 Egy Nulla Nulla Egy Nulla Egy Nulla Nulla)
  , FogalomK "kvaternió"       MatekK    (p8 Nulla Nulla Egy Egy Nulla Nulla Nulla Nulla)
  , FogalomK "oktonió"         MatekK    (p8 Nulla Nulla Egy Egy Nulla Nulla Nulla Egy)
  , FogalomK "CayleyDickson"   MatekK    (p8 Nulla Nulla Egy Egy Nulla Egy Nulla Egy)
  , FogalomK "Cantor"          MatekK    (p8 Egy Nulla Nulla Nulla Nulla Nulla Egy Nulla)
  , FogalomK "Gödel"           MatekK    (p8 Egy Nulla Nulla Nulla Nulla Nulla Egy Egy)
  , FogalomK "Lawvere"         MatekK    (p8 Egy Nulla Nulla Nulla Nulla Egy Egy Nulla)
  , FogalomK "Tarski"          MatekK    (p8 Egy Nulla Nulla Nulla Nulla Egy Egy Egy)
  , FogalomK "Chaitin"         MatekK    (p8 Nulla Egy Nulla Nulla Nulla Nulla Egy Nulla)
  , FogalomK "ζ-gyök"          MatekK    (p8 Nulla Nulla Nulla Nulla Egy Egy Nulla Nulla)
  , FogalomK "ϱ"               MatekK    (p8 Nulla Nulla Nulla Nulla Egy Nulla Nulla Egy)
  -- fizika
  , FogalomK "Carnot-ciklus"   FizikaK   (p8 Nulla Nulla Nulla Nulla Nulla Nulla Nulla Egy)
  , FogalomK "entrópia"        FizikaK   (p8 Nulla Nulla Nulla Nulla Nulla Nulla Egy Nulla)
  , FogalomK "információ"      FizikaK   (p8 Nulla Nulla Nulla Nulla Nulla Egy Egy Nulla)
  , FogalomK "energia"         FizikaK   (p8 Egy Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
  , FogalomK "Landauer"        FizikaK   (p8 Nulla Nulla Nulla Nulla Egy Egy Egy Nulla)
  , FogalomK "CPT"             FizikaK   (p8 Nulla Nulla Nulla Egy Nulla Egy Nulla Nulla)
  , FogalomK "instanton"       FizikaK   (p8 Nulla Nulla Nulla Nulla Nulla Egy Egy Egy)
  , FogalomK "axion"           FizikaK   (p8 Egy Nulla Nulla Nulla Egy Nulla Nulla Nulla)
  , FogalomK "θ-szög"          FizikaK   (p8 Nulla Egy Nulla Nulla Nulla Egy Egy Nulla)
  , FogalomK "Steane-kód"      FizikaK   (p8 Egy Nulla Nulla Egy Nulla Nulla Egy Nulla)
  , FogalomK "kubit"           FizikaK   (p8 Egy Nulla Egy Nulla Nulla Nulla Nulla Nulla)
  , FogalomK "bájt"            FizikaK   (p8 Egy Nulla Egy Nulla Nulla Nulla Nulla Egy)
  , FogalomK "vákuum"          FizikaK   (p8 Nulla Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
  , FogalomK "S4-gömb"         MatekK    (p8 Nulla Nulla Egy Nulla Nulla Nulla Nulla Egy)
  , FogalomK "α⁻¹"             FizikaK   (p8 Egy Nulla Nulla Nulla Nulla Egy Nulla Egy)
  -- nyelv
  , FogalomK "magyar-nyelv"    NyelvK    (p8 Nulla Egy Nulla Nulla Nulla Nulla Nulla Nulla)
  , FogalomK "esetrag"         NyelvK    (p8 Nulla Egy Nulla Nulla Nulla Nulla Egy Nulla)
  , FogalomK "mondat"          NyelvK    (p8 Nulla Egy Egy Nulla Nulla Nulla Nulla Nulla)
  , FogalomK "ragozás"         NyelvK    (p8 Nulla Egy Egy Nulla Nulla Nulla Egy Nulla)
  , FogalomK "szó"             NyelvK    (p8 Nulla Egy Nulla Nulla Nulla Egy Nulla Nulla)
  -- zene
  , FogalomK "Bach"            ZeneK     (p8 Egy Nulla Nulla Nulla Egy Nulla Nulla Nulla)
  , FogalomK "komma"           ZeneK     (p8 Nulla Nulla Nulla Nulla Egy Nulla Egy Egy)
  , FogalomK "kvint"           ZeneK     (p8 Nulla Nulla Nulla Egy Nulla Nulla Nulla Nulla)
  , FogalomK "oktáv"           ZeneK     (p8 Egy Nulla Nulla Egy Nulla Nulla Nulla Nulla)
  , FogalomK "hangvilla"       ZeneK     (p8 Egy Egy Nulla Egy Nulla Nulla Nulla Nulla)
  , FogalomK "tonométer"       ZeneK     (p8 Egy Egy Nulla Egy Nulla Nulla Nulla Egy)
  , FogalomK "A440"            ZeneK     (p8 Nulla Egy Nulla Nulla Egy Nulla Nulla Egy)
  , FogalomK "diapason-normal" ZeneK     (p8 Nulla Egy Nulla Egy Nulla Nulla Nulla Egy)
  , FogalomK "ISO-16"          ZeneK     (p8 Egy Egy Nulla Nulla Egy Nulla Nulla Nulla)
  , FogalomK "Fermat-prím"     MatekK    (p8 Egy Nulla Nulla Nulla Nulla Egy Nulla Egy)
  , FogalomK "terc"            ZeneK     (p8 Nulla Nulla Nulla Egy Nulla Egy Nulla Nulla)
  , FogalomK "gauge-rögzítés"  FizikaK   (p8 Egy Nulla Nulla Nulla Egy Egy Nulla Nulla)
  -- számítástudomány
  , FogalomK "Y-kombinátor"    SzamitastudomanyK (p8 Nulla Nulla Nulla Egy Nulla Egy Nulla Nulla)
  , FogalomK "Turing-gép"      SzamitastudomanyK (p8 Nulla Nulla Nulla Egy Nulla Egy Nulla Egy)
  , FogalomK "Idris"           SzamitastudomanyK (p8 Egy Egy Nulla Nulla Nulla Nulla Nulla Nulla)
  , FogalomK "keresés"         SzamitastudomanyK (p8 Nulla Nulla Nulla Nulla Nulla Egy Nulla Nulla)
  , FogalomK "MDL"             SzamitastudomanyK (p8 Nulla Nulla Nulla Nulla Egy Egy Egy Egy)
  , FogalomK "valószínűség"    MatekK    (p8 Nulla Egy Nulla Egy Nulla Nulla Nulla Nulla)
  , FogalomK "Markov-blanket"  SzamitastudomanyK (p8 Nulla Nulla Nulla Nulla Nulla Egy Egy Nulla)
  , FogalomK "valószínűségi-hazug" FilozofiaK (p8 Nulla Egy Nulla Egy Nulla Egy Nulla Nulla)
  -- biológia
  , FogalomK "sejt"            BiologiaK (p8 Egy Nulla Nulla Nulla Nulla Nulla Nulla Egy)
  , FogalomK "anyagcsere"      BiologiaK (p8 Nulla Nulla Nulla Nulla Nulla Nulla Egy Egy)
  -- mindennapi / vers
  , FogalomK "víz"             FizikaK   (p8 Nulla Nulla Nulla Nulla Nulla Nulla Egy Nulla)
  , FogalomK "fény"            FizikaK   (p8 Egy Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
  , FogalomK "lét"             FilozofiaK (p8 Nulla Egy Nulla Nulla Egy Nulla Nulla Nulla)
  , FogalomK "vers"            NyelvK    (p8 Nulla Egy Egy Nulla Egy Nulla Nulla Nulla)
  , FogalomK "Óda"             NyelvK    (p8 Nulla Egy Egy Nulla Egy Nulla Nulla Egy)
  ]

public export
projektElek : List El
projektElek =
  [ -- ok-okozat (causalis)
    ElK "entrópia"      CausalisK      "információ"
  , ElK "Landauer"      CausalisK      "energia"
  , ElK "Gödel"         CausalisK      "Cantor"
  , ElK "Chaitin"       CausalisK      "MDL"
  , ElK "Bach"          CausalisK      "komma"
  , ElK "instanton"     CausalisK      "θ-szög"
  , ElK "θ-szög"        CausalisK      "axion"
  , ElK "anyagcsere"    CausalisK      "entrópia"
  , ElK "Carnot-ciklus" CausalisK      "munka"
  , ElK "keresés"       CausalisK      "Carnot-ciklus"
  -- eszköz (instrumentalis)
  , ElK "magyar-nyelv"  InstrumentalisK "kategória"
  , ElK "Idris"         InstrumentalisK "kategória"
  , ElK "aranymetszés"  InstrumentalisK "keresés"
  , ElK "esetrag"       InstrumentalisK "keresés"
  , ElK "Y-kombinátor"  InstrumentalisK "fixpont"
  , ElK "E8"            InstrumentalisK "keresés"
  -- tartalmazás (inessivus)
  , ElK "magyar-nyelv"  InessivusK     "esetrag"
  , ElK "E9"            InessivusK     "E8"
  , ElK "KacMoody"      InessivusK     "E9"
  , ElK "CayleyDickson" InessivusK     "oktonió"
  , ElK "oktonió"       InessivusK     "kvaternió"
  , ElK "bájt"          InessivusK     "kubit"
  , ElK "Steane-kód"    InessivusK     "kubit"
  , ElK "vers"          InessivusK     "mondat"
  , ElK "Óda"           InessivusK     "vers"
  , ElK "mondat"        InessivusK     "szó"
  -- beékezés (illativus)
  , ElK "kérdés"        IllativusK     "keresés"
  , ElK "információ"    IllativusK     "E8"
  -- származás (elativus)
  , ElK "entrópia"      ElativusK      "keresés"
  , ElK "α⁻¹"           ElativusK      "aranymetszés"
  , ElK "ϱ"             ElativusK      "CayleyDickson"
  , ElK "ζ-gyök"        ElativusK      "valószínűség"
  -- cél (dativus)
  , ElK "keresés"       DativusK       "információ"
  , ElK "axion"         DativusK       "θ-szög"
  , ElK "MDL"           DativusK       "keresés"
  -- hatás tárgya (accusativus)
  , ElK "keresés"       AccusativusK   "mondat"
  , ElK "Turing-gép"    AccusativusK   "Y-kombinátor"
  , ElK "Carnot-ciklus" AccusativusK   "entrópia"
  -- átalakulás (transzlativus)
  , ElK "kérdés"        TranszlativusK "információ"
  , ElK "információ"    TranszlativusK "energia"
  , ElK "entrópia"      TranszlativusK "információ"
  , ElK "θ-szög"        TranszlativusK "axion"
  -- mint (essivus)
  , ElK "E8"            EssivusK       "rács"
  , ElK "kategória"     EssivusK       "nyelv"
  , ElK "valószínűségi-hazug" EssivusK "valószínűség"
  , ElK "vers"          EssivusK       "Carnot-ciklus"
  -- épül (sublativus)
  , ElK "adjunkció"     SublativusK    "kategória"
  , ElK "funktor"       SublativusK    "kategória"
  , ElK "Carnot-ciklus" SublativusK    "keresés"
  -- kapcsolódik (allativus)
  , ElK "Markov-blanket" AllativusK    "keresés"
  , ElK "Markov-blanket" AllativusK    "entrópia"
  , ElK "S4-gömb"       AllativusK     "kvaternió"
  , ElK "instanton"     AllativusK     "S4-gömb"
  , ElK "CPT"           AllativusK     "θ-szög"
  -- határ (terminativus)
  , ElK "bájt"          TerminativusK  "kubit"
  , ElK "Gödel"         TerminativusK  "nyelv"
  , ElK "Chaitin"       TerminativusK  "MDL"
  -- alany/hordozó (nominativus)
  , ElK "kubit"         NominativusK   "információ"
  , ElK "kategória"     NominativusK   "kombinator"
  , ElK " víz"          NominativusK   "entrópia"
  , ElK "fény"          NominativusK   "energia"
  , ElK "sejt"          NominativusK   "Markov-blanket"
  -- rész–egész
  , ElK "kubit"         ReszeK         "bájt"
  , ElK "esetrag"       ReszeK         "ragozás"
  , ElK "kvint"         ReszeK         "oktáv"
  , ElK "E8"            ReszeK         "E9"
  , ElK "mondat"        ReszeK         "vers"
  -- ellentét
  , ElK "entrópia"      EllenteteK     "információ"
  , ElK "divergencia"   EllenteteK     "konvergencia"
  , ElK "kérdés"        EllenteteK     "válasz"
  -- szinonima
  , ElK "lét"           SzinonimaK     "információ"
  , ElK "vers"          SzinonimaK     "why-chain"
  -- generalizáció
  , ElK "E8"            GeneralizacioK "KacMoody"
  , ElK "kvaternió"     GeneralizacioK "CayleyDickson"
  , ElK "valószínűség"  GeneralizacioK "MDL"
  , ElK "magyar-nyelv"  GeneralizacioK "nyelv"
  -- hangvilla / A440 (docs/hangvilla_440hz.md)
  , ElK "tonométer"       InessivusK     "hangvilla"    -- 52 hangvillából áll (Scheibler)
  , ElK "tonométer"       CausalisK      "A440"         -- Stuttgart 1834: Scheibler javaslata
  , ElK "A440"            EssivusK       "hangvilla"    -- A440 = egy hangvilla frekvenciája
  , ElK "A440"            CausalisK      "α⁻¹"          -- a Bach-korrekcio bemenete
  , ElK "diapason-normal" EllenteteK     "A440"         -- francia 435 vs ISO 440
  , ElK "ISO-16"          NominativusK   "A440"         -- a szabvány hordozója (1975)
  , ElK "hangvilla"       InstrumentalisK "keresés"     -- a hangvilla mint referencia-eszköz
  , ElK "Bach"            TerminativusK  "komma"        -- Bach: a komma elosztásáig
  -- kör-újraolvasás (docs/kor_ujraolvasa.md): a konzonancia = a szerkeszthetőség
  , ElK "kvint"           EssivusK       "Fermat-prím"  -- 3/2: a 3 = F0 Fermat-prím
  , ElK "terc"            EssivusK       "Fermat-prím"  -- 5/4: az 5 = F1 Fermat-prím
  , ElK "Fermat-prím"     CausalisK      "Gödel"        -- Gauss–Wantzel a Gödel-tétel geometriai rokona
  , ElK "A440"            EssivusK       "gauge-rögzítés" -- az abszolút hang = gauge, nem fizika
  , ElK "MDL"             CausalisK      "A440"         -- 440=2^3·5·11 rövid leírás vs. prím 439
  , ElK "komma"           DativusK       "axion"        -- a komma elosztása = az axion-mechanizmus
  ]

public export
projektGraf : Graf
projektGraf = GrafK projektFogalmak projektElek

-- ─── 7. LEKÉRDEZÉSEK ───────────────────────────────────────

public export
benneVan : Eq a => a -> List a -> Bool
benneVan _ [] = False
benneVan x (y :: ys) = if x == y then True else benneVan x ys

public export
fogalomKeres : String -> Graf -> Maybe Fogalom
fogalomKeres _ (GrafK [] _) = Nothing
fogalomKeres keresett (GrafK (f :: fs) elek) =
  if nev f == keresett then Just f else fogalomKeres keresett (GrafK fs elek)

public export
kimenoSzelek : String -> Graf -> List El
kimenoSzelek nev (GrafK _ elek) = filter (\e => forras e == nev) elek

public export
bejvoSzelek : String -> Graf -> List El
bejvoSzelek nev (GrafK _ elek) = filter (\e => cel e == nev) elek

public export
szomszedok : String -> Graf -> List String
szomszedok nev g = map cel (kimenoSzelek nev g)

public export
fokSzam : String -> Graf -> Nat
fokSzam nev g = length (kimenoSzelek nev g) + length (bejvoSzelek nev g)

-- ─── 8. VALÓSZÍNŰSÉG — determinisztikus számlálás (MDL) ────

public export
tipusDarab : KapcsolatTipus -> Graf -> Integer
tipusDarab t (GrafK _ elek) =
  cast {from = Nat} {to = Integer} (length (filter (\e => tipus e == t) elek))

public export
osszesEl : Graf -> Integer
osszesEl (GrafK _ elek) = cast {from = Nat} {to = Integer} (length elek)

public export
kapcsolatValoszinuseg : KapcsolatTipus -> Graf -> Valoszinuseg
kapcsolatValoszinuseg t g = ValK (tipusDarab t g) (osszesEl g)

-- ─── 9. MDL-TÁVOLSÁG — gráf-távolság üzemanyaggal ──────────

public export
nub : Eq a => List a -> List a
nub [] = []
nub (x :: xs) = x :: nub (assert_smaller xs (filter (\y => y /= x) xs))

public export
alsoSzomszedok : String -> Graf -> List String
alsoSzomszedok nev g = nub (szomszedok nev g ++ map forras (bejvoSzelek nev g))

-- BFS üzemanyaggal: a mélység az MDL leírás-hossza (él = 1 bit-lépés)
public export
utHosszSeged : Nat -> List String -> String -> Graf -> Maybe Nat
utHosszSeged Z     _      _    _ = Nothing
utHosszSeged (S m) szintek cel g =
  if benneVan cel szintek then Just Z
  else
    let kovetkezo = concatMap (\n => alsoSzomszedok n g) szintek
        ujak = filter (\x => not (benneVan x szintek)) (nub kovetkezo)
    in case utHosszSeged m ujak cel g of
         Just d  => Just (S d)
         Nothing => Nothing

public export
utHossz : Nat -> String -> String -> Graf -> Maybe Nat
utHossz uzemanyag kezd cel g = utHosszSeged uzemanyag [kezd] cel g

-- ─── 10. KIIRATAS — tiszta Show-ertekek ────────────────────

public export
record FogalomJelentes where
  constructor FogalomJelentesK
  fogalom  : Fogalom
  kimenok  : List String
  bejovok  : List String
  fok      : Nat

public export
Show FogalomJelentes where
  show j = show (fogalom j)
        ++ " | fok=" ++ show (fok j)
        ++ " | kimenő: " ++ show (kimenok j)
        ++ " | bejövő: " ++ show (bejovok j)

public export
jelentes : String -> Graf -> String
jelentes nev g =
  case fogalomKeres nev g of
    Nothing => "nincs ilyen fogalom: " ++ nev
    Just f  => show (FogalomJelentesK f (szomszedok nev g)
                        (map forras (bejvoSzelek nev g)) (fokSzam nev g))

public export
mdlTavolsagJelentes : String -> String -> Graf -> String
mdlTavolsagJelentes a b g =
  case utHossz 6 a b g of
    Nothing => "MDL(" ++ a ++ "," ++ b ++ ") > 6 él (nem érhető el)"
    Just d  => "MDL(" ++ a ++ "," ++ b ++ ") = " ++ show d ++ " bit-lépés"

public export
valoszinusegTablazat : Graf -> List String
valoszinusegTablazat g =
  map (\t => show t ++ " : P = " ++ show (kapcsolatValoszinuseg t g)
             ++ " (" ++ show (szazalek (kapcsolatValoszinuseg t g)) ++ "%)")
      [ CausalisK, InstrumentalisK, InessivusK, IllativusK, ElativusK
      , DativusK, AccusativusK, TranszlativusK, EssivusK, SublativusK
      , AllativusK, TerminativusK, NominativusK, ReszeK, EllenteteK
      , SzinonimaK, GeneralizacioK ]

public export
grafStatisztika : Graf -> String
grafStatisztika g =
  "fogalmak: " ++ show (length (fogalmak g))
  ++ ", élek: " ++ show (length (elek g))
  ++ ", kategóriák: matematika/fizika/nyelv/zene/számítás/biológia/filozófia"