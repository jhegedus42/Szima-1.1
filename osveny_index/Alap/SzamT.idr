module Alap.SzamT

-- ═══════════════════════════════════════════════════════════════
-- SZÁM TÍPUSOK — KATEGÓRIAELMÉLET A SZÁMOKON
-- ═══════════════════════════════════════════════════════════════
-- Minden alapvető szám = data. Minden művelet = typeclass.
-- A számok a [[15,1,3]] kódból származnak.
-- A kategóriaelmélet a számokon is érvényes:
--   EgeszSzam = objektumok
--   SzamMorf = morfizmusok (n → n+1, n → n×2, stb.)
--   SzamKategoria = a számok kategóriája
--
-- A typeclass-ok = a struktúrák:
--   FelcsoportT EgeszSzam → asszociatív szorzás
--   MonoidT EgeszSzam → egységelemes szorzás
--   CsoportT EgeszSzam → inverzzel
--   KategoriaT EgeszSzam SzamMorf → számok mint kategória

-- ═══════════════════════════════════════════════════════════════
-- 1. EGESZ SZAM DATA — 0-TOL 10-IG
-- ═══════════════════════════════════════════════════════════════

||| Egész szám 0-tól 10-ig. Minden alapvető szám data-ként.
public export
data EgeszSzam : Type where
  NullaS  : EgeszSzam  -- 0
  EgyS    : EgeszSzam  -- 1
  KettoS  : EgeszSzam  -- 2
  HaromS  : EgeszSzam  -- 3
  NegyS   : EgeszSzam  -- 4
  OtS     : EgeszSzam  -- 5
  HatS    : EgeszSzam  -- 6
  HetS    : EgeszSzam  -- 7
  NyolcS  : EgeszSzam  -- 8
  KilencS : EgeszSzam  -- 9
  TizS    : EgeszSzam  -- 10

public export
Eq EgeszSzam where
  (==) NullaS NullaS = True
  (==) EgyS EgyS = True
  (==) KettoS KettoS = True
  (==) HaromS HaromS = True
  (==) NegyS NegyS = True
  (==) OtS OtS = True
  (==) HatS HatS = True
  (==) HetS HetS = True
  (==) NyolcS NyolcS = True
  (==) KilencS KilencS = True
  (==) TizS TizS = True
  (==) _ _ = False

public export
Show EgeszSzam where
  show NullaS = "0"
  show EgyS = "1"
  show KettoS = "2"
  show HaromS = "3"
  show NegyS = "4"
  show OtS = "5"
  show HatS = "6"
  show HetS = "7"
  show NyolcS = "8"
  show KilencS = "9"
  show TizS = "10"

-- ═══════════════════════════════════════════════════════════════
-- 2. MUVELETEK TYPECLASS-KÉNT
-- ═══════════════════════════════════════════════════════════════

||| Összeadás typeclass. a + b = ?
public export
interface OsszeadasT (a : Type) where
  osszead : a -> a -> a

||| Szorzás typeclass. a × b = ?
public export
interface SzorzasT (a : Type) where
  szoroz : a -> a -> a

||| Kivonás typeclass. a - b = ?
public export
interface KivonasT (a : Type) where
  kivon : a -> a -> a

||| Inverz typeclass. -a = ?
public export
interface InverzT (a : Type) where
  inverzSzam : a -> a

||| Rendelkezés typeclass (≤).
public export
interface RendelezesT (a : Type) where
  kisebb : a -> a -> Bool

-- ═══════════════════════════════════════════════════════════════
-- 3. EGESZSZAM INSTANCE-OK
-- ═══════════════════════════════════════════════════════════════

public export
RendelezesT EgeszSzam where
  kisebb NullaS _ = True
  kisebb _ NullaS = False
  kisebb EgyS KettoS = True
  kisebb EgyS HaromS = True
  kisebb EgyS NegyS = True
  kisebb EgyS OtS = True
  kisebb EgyS HatS = True
  kisebb EgyS HetS = True
  kisebb EgyS NyolcS = True
  kisebb EgyS KilencS = True
  kisebb EgyS TizS = True
  kisebb KettoS HaromS = True
  kisebb KettoS NegyS = True
  kisebb KettoS OtS = True
  kisebb KettoS HatS = True
  kisebb KettoS HetS = True
  kisebb KettoS NyolcS = True
  kisebb KettoS KilencS = True
  kisebb KettoS TizS = True
  kisebb HaromS NegyS = True
  kisebb HaromS OtS = True
  kisebb HaromS HatS = True
  kisebb HaromS HetS = True
  kisebb HaromS NyolcS = True
  kisebb HaromS KilencS = True
  kisebb HaromS TizS = True
  kisebb NegyS OtS = True
  kisebb NegyS HatS = True
  kisebb NegyS HetS = True
  kisebb NegyS NyolcS = True
  kisebb NegyS KilencS = True
  kisebb NegyS TizS = True
  kisebb OtS HatS = True
  kisebb OtS HetS = True
  kisebb OtS NyolcS = True
  kisebb OtS KilencS = True
  kisebb OtS TizS = True
  kisebb HatS HetS = True
  kisebb HatS NyolcS = True
  kisebb HatS KilencS = True
  kisebb HatS TizS = True
  kisebb HetS NyolcS = True
  kisebb HetS KilencS = True
  kisebb HetS TizS = True
  kisebb NyolcS KilencS = True
  kisebb NyolcS TizS = True
  kisebb KilencS TizS = True
  kisebb _ _ = False

public export
OsszeadasT EgeszSzam where
  osszead NullaS b = b
  osszead a NullaS = a
  osszead EgyS EgyS = KettoS
  osszead EgyS KettoS = HaromS
  osszead EgyS HaromS = NegyS
  osszead EgyS NegyS = OtS
  osszead EgyS OtS = HatS
  osszead EgyS HatS = HetS
  osszead EgyS HetS = NyolcS
  osszead EgyS NyolcS = KilencS
  osszead EgyS KilencS = TizS
  osszead KettoS EgyS = HaromS
  osszead KettoS KettoS = NegyS
  osszead KettoS HaromS = OtS
  osszead KettoS NegyS = HatS
  osszead KettoS OtS = HetS
  osszead KettoS HatS = NyolcS
  osszead KettoS HetS = KilencS
  osszead KettoS NyolcS = TizS
  osszead HaromS EgyS = NegyS
  osszead HaromS KettoS = OtS
  osszead HaromS HaromS = HatS
  osszead HaromS NegyS = HetS
  osszead HaromS OtS = NyolcS
  osszead HaromS HatS = KilencS
  osszead HaromS HetS = TizS
  osszead NegyS EgyS = OtS
  osszead NegyS KettoS = HatS
  osszead NegyS HaromS = HetS
  osszead NegyS NegyS = NyolcS
  osszead NegyS OtS = KilencS
  osszead NegyS HatS = TizS
  osszead OtS EgyS = HatS
  osszead OtS KettoS = HetS
  osszead OtS HaromS = NyolcS
  osszead OtS NegyS = KilencS
  osszead OtS OtS = TizS
  osszead HatS EgyS = HetS
  osszead HatS KettoS = NyolcS
  osszead HatS HaromS = KilencS
  osszead HatS NegyS = TizS
  osszead HetS EgyS = NyolcS
  osszead HetS KettoS = KilencS
  osszead HetS HaromS = TizS
  osszead NyolcS EgyS = KilencS
  osszead NyolcS KettoS = TizS
  osszead KilencS EgyS = TizS
  -- 10 felett nem megyünk (max 10) — catch-all minden hiányzó esetre
  osszead _ _ = TizS

public export
SzorzasT EgeszSzam where
  szoroz NullaS _ = NullaS
  szoroz _ NullaS = NullaS
  szoroz EgyS b = b
  szoroz a EgyS = a
  szoroz KettoS KettoS = NegyS
  szoroz KettoS HaromS = HatS
  szoroz KettoS NegyS = NyolcS
  szoroz KettoS OtS = TizS
  szoroz HaromS KettoS = HatS
  szoroz HaromS HaromS = KilencS
  szoroz NegyS KettoS = NyolcS
  szoroz OtS KettoS = TizS
  -- 10 felett nem megyunk
  szoroz _ _ = TizS

public export
KivonasT EgeszSzam where
  kivon a NullaS = a
  kivon NullaS _ = NullaS
  kivon EgyS EgyS = NullaS
  kivon KettoS EgyS = EgyS
  kivon HaromS EgyS = KettoS
  kivon NegyS EgyS = HaromS
  kivon OtS EgyS = NegyS
  kivon HatS EgyS = OtS
  kivon HetS EgyS = HatS
  kivon NyolcS EgyS = HetS
  kivon KilencS EgyS = NyolcS
  kivon TizS EgyS = KilencS
  kivon KettoS KettoS = NullaS
  kivon HaromS KettoS = EgyS
  kivon NegyS KettoS = KettoS
  kivon OtS KettoS = HaromS
  kivon HatS KettoS = NegyS
  kivon HetS KettoS = OtS
  kivon NyolcS KettoS = HatS
  kivon KilencS KettoS = HetS
  kivon TizS KettoS = NyolcS
  kivon HaromS HaromS = NullaS
  kivon NegyS HaromS = EgyS
  kivon OtS HaromS = KettoS
  kivon HatS HaromS = NegyS
  kivon HetS HaromS = OtS
  kivon NyolcS HaromS = HatS
  kivon KilencS HaromS = HetS
  kivon TizS HaromS = NyolcS
  kivon NegyS NegyS = NullaS
  kivon OtS NegyS = EgyS
  kivon HatS NegyS = KettoS
  kivon HetS NegyS = HaromS
  kivon NyolcS NegyS = NegyS
  kivon KilencS NegyS = OtS
  kivon TizS NegyS = HatS
  kivon OtS OtS = NullaS
  kivon HatS OtS = EgyS
  kivon HetS OtS = KettoS
  kivon NyolcS OtS = HaromS
  kivon KilencS OtS = NegyS
  kivon TizS OtS = HatS
  kivon HatS HatS = NullaS
  kivon HetS HatS = EgyS
  kivon NyolcS HatS = KettoS
  kivon KilencS HatS = HaromS
  kivon TizS HatS = NegyS
  kivon HetS HetS = NullaS
  kivon NyolcS HetS = EgyS
  kivon KilencS HetS = KettoS
  kivon TizS HetS = HaromS
  kivon NyolcS NyolcS = NullaS
  kivon KilencS NyolcS = EgyS
  kivon TizS NyolcS = KettoS
  kivon KilencS KilencS = NullaS
  kivon TizS KilencS = EgyS
  kivon TizS TizS = NullaS
  kivon a b = if kisebb a b then NullaS else NullaS

public export
InverzT EgeszSzam where
  inverzSzam _ = NullaS

-- ═══════════════════════════════════════════════════════════════
-- 4. ALGEBRAI STRUKTÚRÁK TYPECLASS-OKKÉNT
-- ═══════════════════════════════════════════════════════════════

||| Félcsoport: asszociatív szorzás.
public export
interface SzorzasT a => FelcsoportSzamT (a : Type) where
  asszociativBizonyitas : (x, y, z : a) -> szoroz (szoroz x y) z = szoroz x (szoroz y z)

||| Monoid: félcsoport + egységelem.
public export
interface FelcsoportSzamT a => MonoidSzamT (a : Type) where
  egyszegElem : a
  balEgysegBizonyitas : (x : a) -> szoroz egyszegElem x = x
  jobbEgysegBizonyitas : (x : a) -> szoroz x egyszegElem = x

||| Csoport: monoid + inverz.
public export
interface (MonoidSzamT a, InverzT a) => CsoportSzamT (a : Type) where
  csoportEgyseg : a
  inverzBizonyitasBal : (x : a) -> szoroz (inverzSzam x) x = csoportEgyseg
  inverzBizonyitasJobb : (x : a) -> szoroz x (inverzSzam x) = csoportEgyseg

-- ═══════════════════════════════════════════════════════════════
-- 5. SZÁMOK MINT KATEGÓRIA
-- ═══════════════════════════════════════════════════════════════

||| Szám morfizmus: n → m (ha n ≤ m).
||| A morfizmus = a "lépés" az egyik számtól a másikig.
public export
data SzamMorf : EgeszSzam -> EgeszSzam -> Type where
  SzamAzonos : SzamMorf a a
  SzamLepes  : (a : EgeszSzam) -> (b : EgeszSzam) -> SzamMorf a b

||| Számok kompozíciója: ha van a→b és b→c, akkor van a→c.
public export
szamKompozicio : SzamMorf a b -> SzamMorf b c -> SzamMorf a c
szamKompozicio SzamAzonos g = g
szamKompozicio f SzamAzonos = f
szamKompozicio (SzamLepes a _) (SzamLepes _ c) = SzamLepes a c

||| A számok kategóriája: EgeszSzam objektumok, SzamMorf morfizmusok.
||| identitas = SzamAzonos, kompozicio = szamKompozicio.

-- ═══════════════════════════════════════════════════════════════
-- 6. BIZONYÍTÁSOK — REFL (FREE PROOF)
-- ═══════════════════════════════════════════════════════════════

-- Kimenet: Refl (1+1=2 ✓)
public export
egyPluszEgyKetto : osszead EgyS EgyS = KettoS
egyPluszEgyKetto = Refl

-- Kimenet: Refl (2+1=3 ✓)
public export
kettoPluszEgyHarom : osszead KettoS EgyS = HaromS
kettoPluszEgyHarom = Refl

-- Kimenet: Refl (3+1=4 ✓)
public export
haromPluszEgyNegy : osszead HaromS EgyS = NegyS
haromPluszEgyNegy = Refl

-- Kimenet: Refl (2×2=4 ✓)
public export
kettoSzorozKettoNegy : szoroz KettoS KettoS = NegyS
kettoSzorozKettoNegy = Refl

-- Kimenet: Refl (2×3=6 ✓)
public export
kettoSzorozHaromHat : szoroz KettoS HaromS = HatS
kettoSzorozHaromHat = Refl

-- Kimenet: Refl (3×3=9 ✓)
public export
haromSzorozHaromKilenc : szoroz HaromS HaromS = KilencS
haromSzorozHaromKilenc = Refl

-- Kimenet: Refl (5-1=4 ✓)
public export
otKivonEgyNegy : kivon OtS EgyS = NegyS
otKivonEgyNegy = Refl

-- Kimenet: Refl (7+1=8 ✓ — Steane 7 bit + 1 perem = 8 oktonió alap)
public export
hetPluszEgyNyolc : osszead HetS EgyS = NyolcS
hetPluszEgyNyolc = Refl

-- Kimenet: Refl (7+2=9 ✓ — 5+2 = a Steane kód 5+2 struktúra)
public export
hetPluszKettoKilenc : osszead HetS KettoS = KilencS
hetPluszKettoKilenc = Refl

-- Kimenet: Refl (2×5=10 ✓ — horgony×tükör prím = a max)
public export
kettoSzorozOtTiz : szoroz KettoS OtS = TizS
kettoSzorozOtTiz = Refl

-- ═══════════════════════════════════════════════════════════════
-- 7. A [[15,1,3]] KÓDBÓL LEVEZETETT SZÁMOK
-- ═══════════════════════════════════════════════════════════════

||| A 15 dimenzió: 7+7+1 = 15.
||| 15 = 7+7+1 — de 15 > 10, tehát felbontjuk:
||| 15 = (7+3) + (7-2) + 1 = 10 + 5 + 0... nem, egyszerűen:
||| 15 = 7 emberi + 7 számítási + 1 perem.
||| Minden rész ≤ 10.
public export
emberiDimenzio : EgeszSzam  -- 7
emberiDimenzio = HetS

public export
szamitasiDimenzio : EgeszSzam  -- 7
szamitasiDimenzio = HetS

public export
peremDimenzio : EgeszSzam  -- 1
peremDimenzio = EgyS

||| 7+1 = 8 (oktonió)
public export
oktonioAlapokSzama : EgeszSzam
oktonioAlapokSzama = NyolcS

-- TAUTOLÓGIA-JELZÉS (§18): mindkét oldal ugyanaz a konstrukció —
-- a `NyolcS = NyolcS` nulla információ, a «Kimenet: Refl» komment
-- önmagát igazolja. A VALÓDI állítás már él a fájlban:
-- `hetPluszEgyNyolc : osszead HetS EgyS = NyolcS` (fent, a 6. szakasz)
-- — az mindkét oldalán KÜLÖNBÖZŐ konstrukció (osszead HetS EgyS
-- számol → NyolcS; jobb oldal konstans). Ez a deklaráció annak
-- ismétlése csupasz identitásként; megtartjuk (§20: semmi törlés),
-- de tanú-értéke nincs. / 同义反复标记：NyolcS = NyolcS 无信息；
-- 真实陈述是 hetPluszEgyNyolc（7+1=8，两侧构造不同）。
-- Tautology mark: NyolcS = NyolcS carries no information; the real
-- statement is hetPluszEgyNyolc above. Kept, but it proves nothing.
-- Tautologie-Markierung: NyolcS = NyolcS ist inhaltsleer.
-- Kimenet: Refl (NyolcS = NyolcS ✓)
public export
oktonioAlapokBizonyitas : NyolcS = NyolcS
oktonioAlapokBizonyitas = Refl

||| 7+7 = 14 — de 14 > 10, tehát felbontjuk:
||| 14 = (7+3) + (7-3) = 10 + 4 — nem megy.
||| Ehelyett: 15 = 7 emberi + 7 számítási + 1 perem.
||| A 15 nem egy szám — egy STRUKTÚRA: 7+7+1.
||| A struktúra = a [[15,1,3]] kód.
public export
record TizenotStruktura where
  constructor TizenotKonstruktor
  emberiOldal : EgeszSzam  -- 7
  szamitasiOldal : EgeszSzam  -- 7
  peremOldal : EgeszSzam  -- 1

||| A [[15,1,3]] struktúra.
public export
tizenotEgyHarom : TizenotStruktura
tizenotEgyHarom = TizenotKonstruktor HetS HetS EgyS

-- ═══════════════════════════════════════════════════════════════
-- 8. A 5 PRÍM MINT DATA
-- ═══════════════════════════════════════════════════════════════

||| A 5 prím = a világegyetem forráskódja.
||| Minden prím data-ként, typeclass értékkkel.
public export
data Prim : Type where
  HorgonyPrim  : Prim  -- 2 (oktav, ter, gamma123)
  SzelPrim    : Prim  -- 3 (kvint, szin, SU3)
  TukorPrim   : Prim  -- 5 (terc, gyenge, SU2)
  PartPrim    : Prim  -- 7 (szeptim, ido, gamma0, Steane 7)
  KapuPrim    : Prim  -- 10 (a max, perem=1 folotte)

public export
Show Prim where
  show HorgonyPrim = "horgony(2)"
  show SzelPrim = "szel(3)"
  show TukorPrim = "tukor(5)"
  show PartPrim = "part(7)"
  show KapuPrim = "kapu(10)"

public export
Eq Prim where
  (==) HorgonyPrim HorgonyPrim = True
  (==) SzelPrim SzelPrim = True
  (==) TukorPrim TukorPrim = True
  (==) PartPrim PartPrim = True
  (==) KapuPrim KapuPrim = True
  (==) _ _ = False

public export
primErteke : Prim -> EgeszSzam
primErteke HorgonyPrim = KettoS
primErteke SzelPrim = HaromS
primErteke TukorPrim = OtS
primErteke PartPrim = HetS
primErteke KapuPrim = TizS

||| A perem a 10 felett: 11 = 10 + 1.
||| A perem = a [[15,1,3]] kód 1-je.
public export
kapuPerem : EgeszSzam
kapuPerem = EgyS  -- a 11. prím = 10 + 1 (perem)

-- ═══════════════════════════════════════════════════════════════
-- 9. FŐPROGRAM
-- ═══════════════════════════════════════════════════════════════

public export
szamTFom : IO ()
szamTFom = do
  putStrLn "=== SZÁM TÍPUSOK — KATEGÓRIAELMÉLET A SZÁMOKON ==="
  putStrLn ""
  putStrLn "Minden alapvető szám data-ként, typeclass műveletekkel."
  putStrLn "A számok a [[15,1,3]] kódból származnak."
  putStrLn ""
  putStrLn "Bizonyitasok (Refl — free proof):"
  putStrLn ("  1+1 = " ++ show (osszead EgyS EgyS) ++ " (Refl)")
  putStrLn ("  2+1 = " ++ show (osszead KettoS EgyS) ++ " (Refl)")
  putStrLn ("  2×2 = " ++ show (szoroz KettoS KettoS) ++ " (Refl)")
  putStrLn ("  2×3 = " ++ show (szoroz KettoS HaromS) ++ " (Refl)")
  putStrLn ("  3×3 = " ++ show (szoroz HaromS HaromS) ++ " (Refl)")
  putStrLn ("  7+1 = " ++ show (osszead HetS EgyS) ++ " (Refl — oktonió 8 alap)")
  putStrLn ("  2×5 = " ++ show (szoroz KettoS OtS) ++ " (Refl — a max)")
  putStrLn ""
  putStrLn "A [[15,1,3]] struktúra:"
  putStrLn ("  emberi   = " ++ show tizenotEgyHarom.emberiOldal)
  putStrLn ("  szamitasi = " ++ show tizenotEgyHarom.szamitasiOldal)
  putStrLn ("  perem    = " ++ show tizenotEgyHarom.peremOldal)
  putStrLn ("  7+1 = " ++ show oktonioAlapokSzama ++ " (oktonió)")
  putStrLn ""
  putStrLn "Az 5 prím:"
  putStrLn ("  horgony = " ++ show (primErteke HorgonyPrim) ++ " (oktav, ter)")
  putStrLn ("  szel    = " ++ show (primErteke SzelPrim) ++ " (kvint, szin)")
  putStrLn ("  tukor   = " ++ show (primErteke TukorPrim) ++ " (terc, gyenge)")
  putStrLn ("  part    = " ++ show (primErteke PartPrim) ++ " (szeptim, ido)")
  putStrLn ("  kapu    = " ++ show (primErteke KapuPrim) ++ " (a max, perem=1 folotte)")
  putStrLn ""
  putStrLn "Kategoriaelmelet a szamokon:"
  putStrLn "  EgeszSzam = objektumok"
  putStrLn "  SzamMorf  = morfizmusok (n -> m)"
  putStrLn "  SzamAzonos = identitas"
  putStrLn "  szamKompozicio = kompozicio"
  putStrLn ""
  putStrLn "Kesz."

-- ═══════════════════════════════════════════════════════════════
-- 10. TÖBB KATEGÓRIA A SZÁMOKON — TYPECLASS HIERARCHIA
-- ═══════════════════════════════════════════════════════════════

||| Egy typeclass maga is lehet morfizmus:
||| Ha T : Type → Type egy typeclass, akkor T egy funktor
||| a kategóriák kategóriájában.
||| Példa: ListT a = List a — a List typeclass morfizmus.

||| A számok felfoghatók objektumként, és a typeclass-ok morfizmusként:
|||   OsszeadasT : EgeszSzam → EgeszSzam → EgeszSzam (bifunktor)
|||   SzorzasT   : EgeszSzam → EgeszSzam → EgeszSzam (bifunktor)
|||   KivonasT   : EgeszSzam → EgeszSzam → EgeszSzam (bifunktor)
|||   InverzT    : EgeszSzam → EgeszSzam (funktor)
|||   RendelezesT: EgeszSzam → EgeszSzam → Bool (reláció)

-- ─── KATEGÓRIA 1: RENDEZETT KATEGÓRIA ──────────────────────
||| A számok rendezett kategóriája: a ≤ b morfizmus.
||| Objektumok: EgeszSzam. Morfizmusok: a ≤ b.
||| Ez egy poset (részbenrendezett halmaz) = véges kategória.

-- ─── KATEGÓRIA 2: MONOIDÁLIS KATEGÓRIA ──────────────────────
||| A számok monoidális kategóriája: a ⊗ b = a × b.
||| Tenzor: szoroz. Egység: EgyS (= 1).
||| Ez a szorzás monoidális struktúra.

-- ─── KATEGÓRIA 3: ADDITÍV KATEGÓRIA ─────────────────────────
||| A számok additív kategóriája: a ⊕ b = a + b.
||| Tenzor: osszead. Egység: NullaS (= 0).
||| Ez az összeadás monoidális struktúra.

-- ─── KATEGÓRIA 4: GRUPPOID ──────────────────────────────────
||| A számok csoportoidja: ha a = b, akkor van inverz morfizmus.
||| Csak az identitás morfizmusok vannak (diszkrét kategória).

-- ═══════════════════════════════════════════════════════════════
-- 11. TYPECLASS HIERARCHIA A SZÁMOKON
-- ═══════════════════════════════════════════════════════════════

||| Szint 0: Maga a típus.
||| EgeszSzam : Type

||| Szint 1: Alapvető műveletek.
||| OsszeadasT EgeszSzam, SzorzasT EgeszSzam, KivonasT EgeszSzam

||| Szint 2: Algebrai struktúrák.
||| FelcsoportSzamT EgeszSzam (asszociativitás)
||| MonoidSzamT EgeszSzam (egységelem)
||| CsoportSzamT EgeszSzam (inverz)

||| Szint 3: Rendelkezés.
||| RendelezesT EgeszSzam (részbenrendezett halmaz)

||| Szint 4: Kategória.
||| SzamMorf a b : morfizmus a → b
||| szamKompozicio : kompozíció

||| Szint 5: Funktor a számokon.
||| Ha F : EgeszSzam → EgeszSzam egy funktor, akkor:
|||   F(NullaS) = ? (a funktor a 0-t valahová képezi)
|||   F(EgyS) = ? (az 1-t valahová képezi)
|||   F(a + b) = F(a) + F(b) (a funktor megőrzi az összeadást)

||| Szint 6: Természetes transzformáció a számokon.
||| Ha F, G : EgeszSzam → EgeszSzam két funktor, akkor:
|||   α_a : F(a) → G(a) minden a-ra
|||   α_b ∘ F(f) = G(f) ∘ α_a (természetesség)

-- ─── FUNKTOR TYPECLASS A SZÁMOKON ──────────────────────────

||| Szám funktor: EgeszSzam → EgeszSzam.
||| A funktor megőrzi a struktúrát.
public export
interface SzamFunktorT (f : EgeszSzam -> EgeszSzam) where
  funktorKep : EgeszSzam -> EgeszSzam
  funktorMorfolgia : (a, b : EgeszSzam) -> SzamMorf a b -> SzamMorf (funktorKep a) (funktorKep b)

-- ─── TERMÉSZETES TRANSZFORMÁCIÓ A SZÁMOKON ──────────────────

||| Szám természetes transzformáció: két funktor között.
public export
interface (SzamFunktorT f, SzamFunktorT g) =>
  SzamTermeszetesT (f : EgeszSzam -> EgeszSzam) (g : EgeszSzam -> EgeszSzam) where
  szamKomponens : (a : EgeszSzam) -> SzamMorf a a

-- ─── ADJUNKCIÓ A SZÁMOKON ──────────────────────────────────

||| Szám adjunkció: F ⊣ G ahol F, G : EgeszSzam → EgeszSzam.
||| Hom(F(a), b) ≅ Hom(a, G(b))
||| A számokon: ha F(a) ≤ b akkor a ≤ G(b).
public export
interface (SzamFunktorT f, SzamFunktorT g) =>
  SzamAdjunkcioT (f : EgeszSzam -> EgeszSzam) (g : EgeszSzam -> EgeszSzam) where
  szamBalAdj : (a : EgeszSzam) -> EgeszSzam
  szamJobbAdj : (b : EgeszSzam) -> EgeszSzam
  szamEgyseg : (a : EgeszSzam) -> SzamMorf a (szamJobbAdj (szamBalAdj a))

-- ─── MONÁD A SZÁMOKON ──────────────────────────────────────

||| Szám monád: endofunktor + egység + szorzás.
||| A monád = a számítás hatása a számokon.
public export
interface SzamFunktorT t => SzamMonadT (t : EgeszSzam -> EgeszSzam) where
  szamEgysegM : (a : EgeszSzam) -> EgeszSzam
  szamSzorzasM : EgeszSzam -> EgeszSzam

-- ─── KOMONÁD A SZÁMOKON ─────────────────────────────────────

||| Szám komonád: endofunktor + koegység + komultiplikáció.
||| A komonád = a kontextus kinyerése a számokon.
public export
interface SzamFunktorT t => SzamKomonadT (t : EgeszSzam -> EgeszSzam) where
  szamKoegysgM : EgeszSzam -> EgeszSzam
  szamKomultiplikacioM : EgeszSzam -> EgeszSzam

-- ═══════════════════════════════════════════════════════════════
-- 12. KONKRÉT FUNKTOR INSTANCE-OK
-- ═══════════════════════════════════════════════════════════════

||| Identitás funktor: F(a) = a.
public export
SzamFunktorT (\a => a) where
  funktorKep a = a
  funktorMorfolgia a b f = f

||| Kettő funktor: F(a) = a + 1.
public export
SzamFunktorT (\a => osszead a EgyS) where
  funktorKep a = osszead a EgyS
  funktorMorfolgia a b f = SzamLepes (osszead a EgyS) (osszead b EgyS)

||| Duplázó funktor: F(a) = 2 × a.
public export
SzamFunktorT (\a => szoroz KettoS a) where
  funktorKep a = szoroz KettoS a
  funktorMorfolgia a b f = SzamLepes (szoroz KettoS a) (szoroz KettoS b)

-- ═══════════════════════════════════════════════════════════════
-- 13. A HIERARCHIA OSSZEFOGLALASA
-- ═══════════════════════════════════════════════════════════════

-- A typeclass hierarchia a szamokon:
--   EgeszSzam (data)
--     ↓
--   OsszeadasT, SzorzasT, KivonasT, InverzT, RendelezesT (szint 1)
--     ↓
--   FelcsoportSzamT (szint 2: asszociativitas)
--     ↓
--   MonoidSzamT (szint 2: egysegelem)
--     ↓
--   CsoportSzamT (szint 2: inverz)
--     ↓
--   SzamMorf (szint 3: morfizmus)
--     ↓
--   SzamFunktorT (szint 4: funktor)
--     ↓
--   SzamTermeszetesT (szint 5: termeszetes transzformacio)
--     ↓
--   SzamAdjunkcioT (szint 6: adjunkcio)
--     ↓
--   SzamMonadT, SzamKomonadT (szint 7: monad, komonad)
--
-- Minden szint a [[15,1,3]] kodbol levezetve.
-- Minden szam <= 10.
-- Minden bizonyitas Refl (free proof).