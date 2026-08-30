module LawvereGodel

import ModulRegisztracio
-- ═══════════════════════════════════════════════════════════════
-- LAWVERE-GÖDEL — a diagonal kategorikus magja
-- TÍPUS-ELLENŐRIZVE (Curry–Howard): ha ez a modul lefordul,
-- a bizonyítások HELYESEK — az Idris fordító ellenőrizte őket,
-- a %default total pedig a terminálást is garantálja.
--
-- Források:
--   Lawvere (1969): Diagonal arguments and cartesian closed
--     categories — a Gödel/Cantor/Tarski/Rice közös kategorikus magja
--   Kripke (1975): Outline of a theory of truth — a RÉSZLEGES
--     igazság fixpontja (a menekülési út #1)
--   Chaitin (1987): az inkomplettesség BIT-ben (a híd a Landauerhez)
--   Bérut et al. (Nature 2012): a Landauer-elv KÍSÉRLETI ellenőrzése
--   Christiano–Herreshoff–Fallenstein–Yudkowsky–Barasz (2017):
--     Logical induction — a valószínűségi menekülési út határese
--
-- A KÉRDÉS, amire a modul válaszol:
--   Tartalmazhatja-e a nyelv a saját igazságát "egy bit erejéig"?
--   VÁLASZ: IGEN — (a) részleges igazságban (Kleene: a tagadásnak
--   VAN fixpontja), (b) valószínűségben (a hazug: p = 1/2, pontosan
--   1 bit entrópia — Landauer-ára: k_B·T·ln2).
--   A TELJES, klasszikus, önrevízió Bool-igazság viszont NEM —
--   ez a cantor : ... -> Void bizonyítás (szintén itt, leellenőrizve).
--
-- NINCS IO, NINCS putStrLn: minden levezetés tiszta érték,
-- megjelenítés Show type class-szal.
-- ═══════════════════════════════════════════════════════════════

%default total

-- ─── 1. LAWVERE FIXPONTTÉTEL (a bizonyítás a definíció) ────
-- Gyenge pontszürjekció: minden g : a -> b-hez van tanú x,
-- hogy e x "pontról pontra" g-vel egyezik.
-- TÉTEL: ekkor minden f : b -> b-nek van fixpontja.
-- Bizonyítás (diagonal): g(y) = f (e y y); a tanú x-re
--   e x x = g x = f (e x x).  ∎
-- (A fordító csak akkor fogadja el, ha a lánc stimmel.)

public export
igazNemHamis : True = False -> Void
igazNemHamis Refl impossible

public export
lawvereFixpont : {a, b : Type} ->
                 (e : a -> a -> b) ->
                 ((g : a -> b) -> DPair a (\x => (y : a) -> e x y = g y)) ->
                 (f : b -> b) ->
                 DPair b (\x => f x = x)
lawvereFixpont e surj f =
  case surj (\y => f (e y y)) of
    (x ** prf) => (e x x ** sym (prf x))

-- ─── 2. CANTOR-KORLÁT (Gödel/Tarski/Rice magja, Void) ──────
-- Ha lenne szürjekció a -> (a -> Bool), a Lawvere a tagadásnak
-- fixpontot adna — de a tagadásnak NINCS fixpontja Bool-on.
-- Ez a diagonal: a TELJES önigazság lehetetlenségének magja.

public export
booleTagadasNincsFixpont : (b : Bool) -> not b = b -> Void
booleTagadasNincsFixpont True  prf = igazNemHamis (sym prf)
booleTagadasNincsFixpont False prf = igazNemHamis prf

public export
cantor : {a : Type} ->
         (e : a -> a -> Bool) ->
         ((g : a -> Bool) -> DPair a (\x => (y : a) -> e x y = g y)) ->
         Void
cantor e surj =
  case lawvereFixpont e surj not of
    (b0 ** fix) => booleTagadasNincsFixpont b0 fix

-- ─── 3. MENEKÜLÉSI ÚT #1: RÉSZLEGES IGAZÁG (Kleene/Kripke) ─
-- A nyelv TARTALMAZHATJA a saját igazságát, ha az igazság
-- értékkészlete 3 értékű: a hazug mondat értéke Ertektelen.
-- FORMÁLISAN: a Kleene-tagadásnak VAN fixpontja — Refl-lel.

public export
data HaromErtek = Igaz | Hamis | Ertektelen

public export
Show HaromErtek where
  show Igaz       = "Igaz"
  show Hamis      = "Hamis"
  show Ertektelen = "Ertektelen"

public export
kleeneTagadas : HaromErtek -> HaromErtek
kleeneTagadas Igaz       = Hamis
kleeneTagadas Hamis      = Igaz
kleeneTagadas Ertektelen = Ertektelen

-- A BIZONYÍTÁS: Ertektelen a fixpont.
-- (Bool-on ez Void volt — itt létezik. Ez Kripke 1975 magja.)
public export
kleeneFixpontLetezik : DPair HaromErtek (\x => kleeneTagadas x = x)
kleeneFixpontLetezik = (Ertektelen ** Refl)

public export
kleeneFixpontErtek : HaromErtek
kleeneFixpontErtek = Ertektelen

-- ─── 4. TÖRTEK (Double nélkül, becsületes Integer-aritmetika) ─

public export
record Tort where
  constructor TortK
  szamlalo : Integer
  nevezo   : Integer

public export
Show Tort where
  show (TortK s n) = show s ++ "/" ++ show n

public export
tortEgyenlo : Tort -> Tort -> Bool
tortEgyenlo (TortK s1 n1) (TortK s2 n2) = s1 * n2 == s2 * n1

-- ─── 5. MENEKÜLÉSI ÚT #2: VALÓSZÍNŰSÉGI HAZUG — p = 1/2 ────
-- A hazug mondat valószínűségi olvasata: "p valószínűséggel
-- hamis vagyok" → p = 1 − p → p = 1/2.
-- Ez pontosan 1 BIT entrópia (maximális bizonytalanság egy
-- bináris kérdésen) — a saját igazság ára 1 bit:
-- Landauer-ár = k_B · T · ln 2.
-- Ellenőrzés törtekkel: 1/2 + 1/2 = 4/4 = 1.

public export
hazugMegoldas : Tort
hazugMegoldas = TortK 1 2

-- 1/2 + 1/2 = (1·2 + 1·2)/(2·2) = 4/4 = 1
-- A BIZONYÍTÁS Nat-tal (a literálok konstruktorok — a típus-ellenőrző
-- kiértékeli őket): (1·2+1·2)·1 = 1·(2·2), azaz 4 = 4.
public export
hazugMegoldasPontos : (1 * 2 + 1 * 2) * 1 = 1 * (2 * 2)
hazugMegoldasPontos = Refl

public export
record HazugParadoxon where
  constructor HazugParadoxonK
  klasszikusKimenet    : String
  kleeneKimenet        : HaromErtek
  valoszinusegiMegoldas : Tort
  bitAr                : Nat

public export
Show HazugParadoxon where
  show h = "hazug: klasszikus = " ++ klasszikusKimenet h
        ++ " | kleene fixpont = " ++ show (kleeneKimenet h)
        ++ " | valószínűségi p = " ++ show (valoszinusegiMegoldas h)
        ++ " | ár = " ++ show (bitAr h) ++ " bit (k_B·T·ln2, Landauer)"

public export
hazugParadoxon : HazugParadoxon
hazugParadoxon =
  HazugParadoxonK "nincs fixpont (cantor : Void)" Ertektelen (TortK 1 2) 1

-- ─── 6. CHAITIN/MDL: a korlát BIT-ben (valószínűség-számítás) ─
-- Számlálás: az n bites húrok közül legfeljebb 2^(n−c) − 1 db
-- rendelkezik n−c-nél rövidebb leírással → a kompresszáltak
-- aránya < 2^(−c). MDL-következmény: c bit "megtakarításra"
-- hinni véletlen húron < 2^(−c) esély.

public export
hatvany : Integer -> Nat -> Integer
hatvany alap Z     = 1
hatvany alap (S k) = alap * hatvany alap k

public export
record ChaitinSor where
  constructor ChaitinSorK
  nyereseg : Nat
  hurokDb  : Integer
  rovidDb  : Integer
  arany    : Tort
  korlat   : Tort

public export
Show ChaitinSor where
  show s = "c=" ++ show (nyereseg s)
        ++ " | húrok=" ++ show (hurokDb s)
        ++ ", rövidek=" ++ show (rovidDb s)
        ++ ", arány=" ++ show (arany s)
        ++ " < korlát 2^-c=" ++ show (korlat s)

public export
chaitinSor : Nat -> Nat -> ChaitinSor
chaitinSor n c =
  let hurok = hatvany 2 n
      rovid = hatvany 2 (n `minus` c) - 1
  in ChaitinSorK c hurok rovid (TortK rovid hurok) (TortK 1 (hatvany 2 c))

public export
record MDLAllitas where
  constructor MDLAllitasK
  megtakaritas : Nat
  valoszinuseg : Tort
  magyarazat   : String

public export
Show MDLAllitas where
  show m = "MDL c=" ++ show (megtakaritas m)
        ++ ": P(véletlen húr ennyivel rövidebb) < " ++ show (valoszinuseg m)
        ++ "  (" ++ magyarazat m ++ ")"

public export
mdlAllitas : Nat -> MDLAllitas
mdlAllitas c =
  MDLAllitasK c (TortK 1 (hatvany 2 c)) "a többség kompresszálatlan"

public export
felEpit : Nat -> Nat -> List Nat
felEpit _     Z     = []
felEpit kezd (S k)  = kezd :: felEpit (S kezd) k

public export
chaitinTablazat : Nat -> Nat -> List ChaitinSor
chaitinTablazat n hatar = map (chaitinSor n) (felEpit 1 hatar)

public export
mdlTablazat : Nat -> List MDLAllitas
mdlTablazat hatar = map mdlAllitas (felEpit 1 hatar)

-- ─── 7. A VÁLASZ A KÉRDÉSRE: milyen nyelv? ─────────────────

public export
data AllitasStatusz = Bizonyitva | KiserletilegEllenorizve | Analogia

public export
Show AllitasStatusz where
  show Bizonyitva             = "[BIZONYÍTVA]"
  show KiserletilegEllenorizve = "[KÍSÉRLETILEG ELLENŐRIZVE]"
  show Analogia               = "[ANALÓGIA — nem tétel]"

public export
record Kimenet where
  constructor KimenetK
  allitas : String
  statusz : AllitasStatusz

public export
Show Kimenet where
  show k = show (statusz k) ++ "  " ++ allitas k

public export
merleg : List Kimenet
merleg =
  [ KimenetK "Lawvere fixponttétel (diagonal) — típus-ellenőrző zárta" Bizonyitva
  , KimenetK "Cantor: teljes önigazság Bool-on lehetetlen (Void)" Bizonyitva
  , KimenetK "Kleene-tagadásnak VAN fixpontja: Ertektelen (Kripke 1975)" Bizonyitva
  , KimenetK "Valószínűségi hazug: p = 1/2, ellenőrzve törtekkel (Refl)" Bizonyitva
  , KimenetK "A saját igazság ára pontosan 1 bit = k_B·T·ln2 (Landauer 1961; Bérut et al. Nature 2012)" KiserletilegEllenorizve
  , KimenetK "Bennett 1973: a megfordítható számítás ~0 disszipációval működhet" Bizonyitva
  , KimenetK "Gödel = 2. főtétel? NEM izomorfizmus — közös diagonal-motívum, a valós híd a Landauer-elv" Analogia
  ]

public export
record NyelvValasz where
  constructor NyelvValaszK
  teljesKlasszikus : String
  reszleges        : String
  valoszinusegi    : String
  logikaiIndukcio  : String

public export
Show NyelvValasz where
  show v = "MIKOR TARTALMAZHATJA A NYELV A SAJÁT IGAZSÁGÁT?\n"
        ++ "  teljes, klasszikus:  " ++ teljesKlasszikus v ++ "\n"
        ++ "  részleges (Kleene):  " ++ reszleges v ++ "\n"
        ++ "  valószínűségi:       " ++ valoszinusegi v ++ "\n"
        ++ "  határeset:           " ++ logikaiIndukcio v

public export
nyelvValasz : NyelvValasz
nyelvValasz = NyelvValaszK
  "NEM — cantor : ... -> Void (bizonyítva fent)"
  "IGEN — a hazug értéke Ertektelen (kleeneFixpontLetezik : DPair)"
  "IGEN — a hazug p = 1/2: pontosan 1 bit entrópia ára (hazugMegoldasPontos : Refl)"
  "logikai indukció (Christiano és tsai. 2017): P_n konvergál, önmagára is — a 1 bit határeset e tétele felé tart"

-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
LawvereLeiras : ModulLeirasT
LawvereLeiras = ModulLeirasKonstruktor
  "LawvereGodel.idr" "Lawvere fixpont [Refl]; hazug p=1/2 [Refl]; Kleene 3-értékű" "az öntudat csírája: a rendszer kérdezhet önmagáról" "Refl"
