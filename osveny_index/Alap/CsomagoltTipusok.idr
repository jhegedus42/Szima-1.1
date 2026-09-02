module Alap.CsomagoltTipusok

-- ═════════════════════════════════════════════════════════════════════════
-- CSOMAGOLT TÍPUSOK — A RENDSZER KANONIKUS ALAPMODULJA
-- ═════════════════════════════════════════════════════════════════════════
-- A NUMBER 1 HARD RULE fundamentuma (a felhasználó, 2026-09-02):
--   «fogalomForrasa : Nat -> String, le legyenek meztelen tipusok, minden
--    tipus legyen beoltozve, becsomagolva, ez hard rule, kulonben nem lehet
--    rajuk type class-t irni» — DATA, nem newtype, nincs coercible.
--
-- Ebben a modulban NINCS se String, se Nat, se Bool, se Double, se Int,
-- se List, se Pair. A Betű a 44 betűs magyar ábécé; a számok Peano-
-- szerkezetű Sorszámok és 0–10-es EgészSzámok; a konstansok SZIMBÓLUMOK
-- («Pi is Pi, Pi stays Pi, always Pi, it's a symbol» — a felhasználó).
-- A megjelenítés NEM String-et ad, hanem Szöveget (MegjelenítésT);
-- a String csak a Határ-modulban jelenik meg (000.02), az IO peremén.
--
-- IRODALOM (§N14/4):
--   * A magyar nyelv eseteinek listája — Wikipédia (ellenőrzött változat,
--     2025-11-13): pontosan 18 valódi esetrag; a -nként/-stul/-kor képző.
--     Forrás: É. Kiss Katalin: Új magyar nyelvtan (ISBN 963-389-521-9).
--   * Peano-aritmetika: The Idris Book (Nat fejezet) — itt Sorsként,
--     a SAJÁT típusunkon.
--   * Wadler: Theorems for free! — a strukturális definíciók ingyenes
--     törvényei (Refl).
--
-- ÁTMENETI NÉVÜTKÖZÉSEK (dokumentáltak, a migrációval megszűnnek):
--   * Kubit / Nulla / Egy — a Steane713.idr-ben is él; a 400.03 lépésben
--     a Steane713 importra vált (ez a modul a kanonikus).
--   * SteaneVektor — a DependensSzamT.idr Nat-indexű vektora él még;
--     az itteni Sorszám-indexű a kanonikus (200.30 lépés).
--   * Igaz / Hamis — a SATCDCL_v1_Szima IgazÉrtéke él még; az itteni
--     a kanonikus (300.x lépés).
--
-- ═════════════════════════════════════════════════════════════════════════
-- 中文：本模块是全系统的规范基础模块——没有 String、Nat、Bool、Double、
-- Int、List、Pair。字母是 44 个匈牙利字母；数字是 Peano 式 Sorszám 与
-- 0–10 的 EgészSzám；常数是符号（Pi 就是 Pi）。显示用 Szöveg（不是 String）。
-- ═════════════════════════════════════════════════════════════════════════
-- Deutsch: Das kanonische Fundamentmodul — keine nackten Basistypen.
-- Buchstaben = 44 ungarische Buchstaben; Zahlen = Peano-Sorszám und
-- EgészSzám 0–10; Konstanten sind Symbole. Anzeige als Szöveg.
-- ═════════════════════════════════════════════════════════════════════════
-- עברית: מודול היסוד הקנוני — בלי טיפוסי בסיס חשופים. אותיות = 44 אותיות
-- הונגריות; מספרים = Sorszám פיאנו ו-EgészSzám 0–10; קבועים = סמלים.
-- ═════════════════════════════════════════════════════════════════════════

%default total

-- ═════════════════════════════════════════════════════════════════════════
-- I. AZ IGAZSÁG — a logika alapja (a Bool helyett)
--     中文：真值——代替 Bool
-- ═════════════════════════════════════════════════════════════════════════

||| Az igazság két értéke: Igaz és Hamis.
public export
data Igazság : Type where
  Igaz  : Igazság
  Hamis : Igazság

||| Egyenlőségvizsgálat typeclassja — Igazságot ad, nem Bool-t.
public export
interface EgyenlőségT (típus : Type) where
  egyenlőE : típus -> típus -> Igazság

public export
EgyenlőségT Igazság where
  egyenlőE Igaz Igaz = Igaz
  egyenlőE Hamis Hamis = Igaz
  egyenlőE _ _ = Hamis

||| A logikai műveletek typeclassja (és, vagy, nem).
public export
interface IgazságT (típus : Type) where
  ésE   : típus -> típus -> típus
  vagyE : típus -> típus -> típus
  nemE  : típus -> típus

||| Az és művelet Igazságon — top-level (a bizonyítások TÍPUSAiba ez mehet;
||| az interface-metódus a típusban nem oldódik fel az Idris 0.8.0-ban).
public export
ésIgazsággal : Igazság -> Igazság -> Igazság
ésIgazsággal Igaz Igaz = Igaz
ésIgazsággal Igaz Hamis = Hamis
ésIgazsággal Hamis Igaz = Hamis
ésIgazsággal Hamis Hamis = Hamis

||| A vagy művelet Igazságon — top-level.
public export
vagyIgazsággal : Igazság -> Igazság -> Igazság
vagyIgazsággal Igaz Igaz = Igaz
vagyIgazsággal Igaz Hamis = Igaz
vagyIgazsággal Hamis Igaz = Igaz
vagyIgazsággal Hamis Hamis = Hamis

||| A nem művelet Igazságon — top-level.
public export
nemIgazsággal : Igazság -> Igazság
nemIgazsággal Igaz = Hamis
nemIgazsággal Hamis = Igaz

public export
IgazságT Igazság where
  ésE   = ésIgazsággal
  vagyE = vagyIgazsággal
  nemE  = nemIgazsággal

-- ─── BIZONYÍTÁS: De Morgan-törvény (mind a négy eset, Refl) ───────────────
-- Kimenet: Refl (¬(a∧b) = ¬a∨¬b ✓ — mind a 4 esetben)

||| De Morgan: ¬(a ∧ b) = ¬a ∨ ¬b. Mind a négy eset lezárva.
||| (Idris 0.8.0: külön kötések; top-level műveletek a típusban.)
public export
deMorgan : (a : Igazság) -> (b : Igazság) ->
  nemIgazsággal (ésIgazsággal a b)
  = vagyIgazsággal (nemIgazsággal a) (nemIgazsággal b)
deMorgan Igaz Igaz = Refl
deMorgan Igaz Hamis = Refl
deMorgan Hamis Igaz = Refl
deMorgan Hamis Hamis = Refl

-- Kimenet: Refl (¬¬a = a ✓)

||| A dupla tagadás az identitás.
public export
duplaTagadás : (a : Igazság) -> nemIgazsággal (nemIgazsággal a) = a
duplaTagadás Igaz = Refl
duplaTagadás Hamis = Refl

-- Kimenet: Refl (¬(a∨b) = ¬a∧¬b ✓ — a MÁSODIK De Morgan, GAN 9.a)
||| A második De Morgan-törvény: ¬(a ∨ b) = ¬a ∧ ¬b.
public export
másodikDeMorgan : (a : Igazság) -> (b : Igazság) ->
  nemIgazsággal (vagyIgazsággal a b)
  = ésIgazsággal (nemIgazsággal a) (nemIgazsággal b)
másodikDeMorgan Igaz Igaz = Refl
másodikDeMorgan Igaz Hamis = Refl
másodikDeMorgan Hamis Igaz = Refl
másodikDeMorgan Hamis Hamis = Refl

-- Kimenet: Refl (a ∨ ¬a = Igaz ✓ — a kizárt harmadik)
||| A kizárt harmadik törvénye.
public export
kizártHarmadik : (a : Igazság) ->
  vagyIgazsággal a (nemIgazsággal a) = Igaz
kizártHarmadik Igaz = Refl
kizártHarmadik Hamis = Refl

-- Kimenet: Refl (a ∧ ¬a = Hamis ✓ — az ellentmondás)
||| Az ellentmondás törvénye.
public export
ellentmondás : (a : Igazság) ->
  ésIgazsággal a (nemIgazsággal a) = Hamis
ellentmondás Igaz = Refl
ellentmondás Hamis = Refl

-- Kimenet: Refl (a ∧ b = b ∧ a ✓)
||| Az és kommutativitása.
public export
ésKommutatív : (a : Igazság) -> (b : Igazság) ->
  ésIgazsággal a b = ésIgazsággal b a
ésKommutatív Igaz Igaz = Refl
ésKommutatív Igaz Hamis = Refl
ésKommutatív Hamis Igaz = Refl
ésKommutatív Hamis Hamis = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- II. A SORSZÁM — Peano-szerkezet a SAJÁT típusunkon (a Nat helyett)
--      中文：序数——自己的 Peano 结构（代替 Nat）
-- ═════════════════════════════════════════════════════════════════════════

||| A sorszám: nulla vagy a következő. Ez a projekt index-típusa —
||| a Nat sehol nem jelenik meg (sem értékként, sem típus-szintű indexként).
public export
data Sorszám : Type where
  SorNulla      : Sorszám
  SorKövetkező : Sorszám -> Sorszám

public export
EgyenlőségT Sorszám where
  egyenlőE SorNulla SorNulla = Igaz
  egyenlőE (SorKövetkező m) (SorKövetkező n) = egyenlőE m n
  egyenlőE _ _ = Hamis

||| Nevezetes sorszámok (0-tól 10-ig) — olvasható nevekkel.
public export
sorEgy, sorKettő, sorHárom, sorNégy, sorÖt : Sorszám
sorEgy = SorKövetkező SorNulla
sorKettő = SorKövetkező sorEgy
sorHárom = SorKövetkező sorKettő
sorNégy = SorKövetkező sorHárom
sorÖt = SorKövetkező sorNégy

public export
sorHat, sorHét, sorNyolc, sorKilenc, sorTíz : Sorszám
sorHat = SorKövetkező sorÖt
sorHét = SorKövetkező sorHat
sorNyolc = SorKövetkező sorHét
sorKilenc = SorKövetkező sorNyolc
sorTíz = SorKövetkező sorKilenc

-- ─── SORSZÁM-ARITMETIKA (strukturális — a törvények ingyenesek) ──────────

||| Sorszám-összeadás: (m+1)+n = (m+n)+1 — bal-rekurzív, bal-egység Refl.
public export
sorÖsszeadás : Sorszám -> Sorszám -> Sorszám
sorÖsszeadás SorNulla n = n
sorÖsszeadás (SorKövetkező m) n = SorKövetkező (sorÖsszeadás m n)

||| Sorszám-szorzás: (m+1)×n = m×n + n.
public export
sorSzorzás : Sorszám -> Sorszám -> Sorszám
sorSzorzás SorNulla _ = SorNulla
sorSzorzás (SorKövetkező m) n = sorÖsszeadás (sorSzorzás m n) n

||| Sorszám-kivonás (truncált: nincs negatív sorszám).
public export
sorKivonás : Sorszám -> Sorszám -> Sorszám
sorKivonás SorNulla _ = SorNulla
sorKivonás m SorNulla = m
sorKivonás (SorKövetkező m) (SorKövetkező n) = sorKivonás m n

||| Sorszám-rendezés: m < n ?
public export
sorKisebb : Sorszám -> Sorszám -> Igazság
sorKisebb SorNulla SorNulla = Hamis
sorKisebb SorNulla (SorKövetkező _) = Igaz
sorKisebb (SorKövetkező _) SorNulla = Hamis
sorKisebb (SorKövetkező m) (SorKövetkező n) = sorKisebb m n

-- ─── BIZONYÍTÁSOK: a sorszám-egységek (Refl + indukció) ──────────────────

-- Kimenet: Refl (0 + n = n ✓ — definicionálisan, minden n-re)

||| Bal-egység: a nulla balról az identitás (ingyen, a definícióból).
public export
sorBalEgység : (n : Sorszám) -> sorÖsszeadás SorNulla n = n
sorBalEgység _ = Refl

-- Kimenet: Refl (n + 0 = n ✓ — indukcióval)

||| Jobb-egység: a nulla jobbról is identitás (indukció + cong).
public export
sorJobbEgység : (n : Sorszám) -> sorÖsszeadás n SorNulla = n
sorJobbEgység SorNulla = Refl
sorJobbEgység (SorKövetkező m) = cong SorKövetkező (sorJobbEgység m)

-- Kimenet: Refl (7 + 1 = 8 ✓ — az oktonió nyolc alapja)

||| Hét plusz egy nyolc — a [[15,1,3]] és az oktonió kapcsolata.
||| (Idris 0.8.0: a szabad kisbetűs konstansokat a típusban MINŐSÍTVE
||| hivatkozzuk — különben implicit paraméterként kötődnének.)
public export
hétPluszEgyNyolcSor : sorÖsszeadás Alap.CsomagoltTipusok.sorHét
  Alap.CsomagoltTipusok.sorEgy = Alap.CsomagoltTipusok.sorNyolc
hétPluszEgyNyolcSor = Refl

-- Kimenet: Refl (2 × 5 = 10 ✓ — horgony × tükör = a kapu)
public export
kettőSzorÖtTízSor : sorSzorzás Alap.CsomagoltTipusok.sorKettő
  Alap.CsomagoltTipusok.sorÖt = Alap.CsomagoltTipusok.sorTíz
kettőSzorÖtTízSor = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- III. AZ EGÉSZ SZÁM 0-TÓL 10-IG — a [[15,1,3]] kód számai
--      中文：0 到 10 的整数——[[15,1,3]] 代码的数字
-- ═════════════════════════════════════════════════════════════════════════

||| Az egész szám 0-tól 10-ig — a projekt alapszámai (kanonizálva az
||| Alap.SzamT EgeszSzámjából; az ottani a 200.30-as lépésben importra vált).
public export
data EgészSzám : Type where
  EgészNulla  : EgészSzám  -- 0
  EgészEgy    : EgészSzám  -- 1
  EgészKettő  : EgészSzám  -- 2
  EgészHárom  : EgészSzám  -- 3
  EgészNégy   : EgészSzám  -- 4
  EgészÖt     : EgészSzám  -- 5
  EgészHat    : EgészSzám  -- 6
  EgészHét    : EgészSzám  -- 7
  EgészNyolc  : EgészSzám  -- 8
  EgészKilenc : EgészSzám  -- 9
  EgészTíz    : EgészSzám  -- 10

public export
EgyenlőségT EgészSzám where
  egyenlőE EgészNulla EgészNulla = Igaz
  egyenlőE EgészEgy EgészEgy = Igaz
  egyenlőE EgészKettő EgészKettő = Igaz
  egyenlőE EgészHárom EgészHárom = Igaz
  egyenlőE EgészNégy EgészNégy = Igaz
  egyenlőE EgészÖt EgészÖt = Igaz
  egyenlőE EgészHat EgészHat = Igaz
  egyenlőE EgészHét EgészHét = Igaz
  egyenlőE EgészNyolc EgészNyolc = Igaz
  egyenlőE EgészKilenc EgészKilenc = Igaz
  egyenlőE EgészTíz EgészTíz = Igaz
  egyenlőE _ _ = Hamis

||| A rendezés typeclassja: m < n (Igazságban).
public export
interface RendezésT (típus : Type) where
  kisebbE : típus -> típus -> Igazság

-- ─── A SORSZÁM-HÍD: minden EgészSzám-aritmetika strukturálisan megy ──────

||| Sorszámmá alakítás (pontosan — minden EgészSzám legfeljebb tíz).
public export
egészbőlSor : EgészSzám -> Sorszám
egészbőlSor EgészNulla = SorNulla
egészbőlSor EgészEgy = sorEgy
egészbőlSor EgészKettő = sorKettő
egészbőlSor EgészHárom = sorHárom
egészbőlSor EgészNégy = sorNégy
egészbőlSor EgészÖt = sorÖt
egészbőlSor EgészHat = sorHat
egészbőlSor EgészHét = sorHét
egészbőlSor EgészNyolc = sorNyolc
egészbőlSor EgészKilenc = sorKilenc
egészbőlSor EgészTíz = sorTíz

||| Utód — a tíznél telít (a [[15,1,3]] világában tíz a kapu).
public export
számKövetkező : EgészSzám -> EgészSzám
számKövetkező EgészNulla = EgészEgy
számKövetkező EgészEgy = EgészKettő
számKövetkező EgészKettő = EgészHárom
számKövetkező EgészHárom = EgészNégy
számKövetkező EgészNégy = EgészÖt
számKövetkező EgészÖt = EgészHat
számKövetkező EgészHat = EgészHét
számKövetkező EgészHét = EgészNyolc
számKövetkező EgészNyolc = EgészKilenc
számKövetkező EgészKilenc = EgészTíz
számKövetkező EgészTíz = EgészTíz

||| Sorszámból vissza (a tíznél telít — a tíz felett a perem kezdődik).
public export
sorbólEgész : Sorszám -> EgészSzám
sorbólEgész SorNulla = EgészNulla
sorbólEgész (SorKövetkező n) = számKövetkező (sorbólEgész n)

||| Az összeadás typeclassja (kanonizálva az Alap.SzamT OsszeadasT-jéből).
public export
interface ÖsszeadásT (típus : Type) where
  összead : típus -> típus -> típus

||| A szorzás typeclassja.
public export
interface SzorzásT (típus : Type) where
  szorzol : típus -> típus -> típus

||| A kivonás typeclassja.
public export
interface KivonásT (típus : Type) where
  kivonsz : típus -> típus -> típus

-- A híd: az EgészSzám aritmetikája a strukturális Sorszám-útón át megy.
-- Így a nagytáblázatok helyett INGYENES törvények (a definícióból).

public export
ÖsszeadásT EgészSzám where
  összead a b = sorbólEgész (sorÖsszeadás (egészbőlSor a) (egészbőlSor b))

public export
SzorzásT EgészSzám where
  szorzol a b = sorbólEgész (sorSzorzás (egészbőlSor a) (egészbőlSor b))

public export
KivonásT EgészSzám where
  kivonsz a b = sorbólEgész (sorKivonás (egészbőlSor a) (egészbőlSor b))

public export
RendezésT EgészSzám where
  kisebbE a b = sorKisebb (egészbőlSor a) (egészbőlSor b)

-- ─── BIZONYÍTÁSOK: az EgészSzám-aritmetika (Refl — a híd kiszámolja) ─────

-- Kimenet: Refl (1 + 1 = 2 ✓)
public export
egyPluszEgyKettő : összead EgészEgy EgészEgy = EgészKettő
egyPluszEgyKettő = Refl

-- Kimenet: Refl (2 × 2 = 4 ✓)
public export
kettőSzorKettőNégy : szorzol EgészKettő EgészKettő = EgészNégy
kettőSzorKettőNégy = Refl

-- Kimenet: Refl (7 + 1 = 8 ✓ — a Steane-hét plusz a perem-egy)
public export
hétPluszEgyNyolcEgész : összead EgészHét EgészEgy = EgészNyolc
hétPluszEgyNyolcEgész = Refl

-- Kimenet: Refl (5 − 1 = 4 ✓)
public export
ötKivonEgyNégy : kivonsz EgészÖt EgészEgy = EgészNégy
ötKivonEgyNégy = Refl

-- Kimenet: Refl (9 + 2 telít a tíznél — a kapu ✓)
public export
kilencPluszKettőTelít : összead EgészKilenc EgészKettő = EgészTíz
kilencPluszKettőTelít = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- IV. SZÁMJEGY, ELŐJEL, FŰZÉR, SZÁMJEGYES SZÁM — a nagy számok
--      (240 E8-gyök, 2026 év — az Integer kiváltása)
--      中文：数字、符号、串列与大数——十进制结构（代替 Integer/List）
-- ═════════════════════════════════════════════════════════════════════════

||| A tíz számjegy (0-tól 9-ig) — a nagy számok téglái.
public export
data Számjegy : Type where
  SzámjegyNulla  : Számjegy
  SzámjegyEgy    : Számjegy
  SzámjegyKettő  : Számjegy
  SzámjegyHárom  : Számjegy
  SzámjegyNégy   : Számjegy
  SzámjegyÖt     : Számjegy
  SzámjegyHat    : Számjegy
  SzámjegyHét    : Számjegy
  SzámjegyNyolc  : Számjegy
  SzámjegyKilenc : Számjegy

public export
EgyenlőségT Számjegy where
  egyenlőE SzámjegyNulla SzámjegyNulla = Igaz
  egyenlőE SzámjegyEgy SzámjegyEgy = Igaz
  egyenlőE SzámjegyKettő SzámjegyKettő = Igaz
  egyenlőE SzámjegyHárom SzámjegyHárom = Igaz
  egyenlőE SzámjegyNégy SzámjegyNégy = Igaz
  egyenlőE SzámjegyÖt SzámjegyÖt = Igaz
  egyenlőE SzámjegyHat SzámjegyHat = Igaz
  egyenlőE SzámjegyHét SzámjegyHét = Igaz
  egyenlőE SzámjegyNyolc SzámjegyNyolc = Igaz
  egyenlőE SzámjegyKilenc SzámjegyKilenc = Igaz
  egyenlőE _ _ = Hamis

||| Az előjel: pozitív vagy negatív.
public export
data Előjel : Type where
  PozitívElőjel  : Előjel
  NegatívElőjel : Előjel

public export
EgyenlőségT Előjel where
  egyenlőE PozitívElőjel PozitívElőjel = Igaz
  egyenlőE NegatívElőjel NegatívElőjel = Igaz
  egyenlőE _ _ = Hamis

||| A fűzér: a List becsomagolva (a GAN-felismerés — kritikus hiány pótlva).
||| FűzérVége = [], Fűzés x xs = x :: xs.
||| (Idris 0.8.0: a típusparaméter EXPLICIT implicit kötése; a „tag" név
||| a magyar „tag" szó — az elem; nem ütközik a Prelude elem-jével.)
public export
data Fűzér : Type -> Type where
  FűzérVége : {tag : Type} -> Fűzér tag
  Fűzés     : {tag : Type} -> tag -> Fűzér tag -> Fűzér tag

||| A fűzér egyenlősége (elemenként) — teleszkópos constraint-instance.
||| (Idris 0.8.0: NÉV NÉLKÜL — a névvel ellátott instance nem auto-feloldó.)
public export
{tag : Type} -> EgyenlőségT tag => EgyenlőségT (Fűzér tag) where
  egyenlőE FűzérVége FűzérVége = Igaz
  egyenlőE (Fűzés x xs) (Fűzés y ys) = ésE (egyenlőE x y) (egyenlőE xs ys)
  egyenlőE _ _ = Hamis

||| A nagy szám: előjel + számjegyfűzér (pl. 240, 2026, −31).
||| Az Integer kiváltása tiszta data-struktúrával.
||| (Idris 0.8.0: a rekord-konstruktor MINTA helyett mező-accessorok.)
public export
record SzámjegyesSzám where
  constructor SzámjegyesSzámKonstruktor
  számElőjele : Előjel
  számjegyei  : Fűzér Számjegy

public export
EgyenlőségT SzámjegyesSzám where
  egyenlőE elsőSzám másodikSzám = ésE
    (egyenlőE (számElőjele elsőSzám) (számElőjele másodikSzám))
    (egyenlőE (számjegyei elsőSzám) (számjegyei másodikSzám))

||| A kanonikus nulla: pozitív, egy számjegyű nulla.
public export
nullaSzám : SzámjegyesSzám
nullaSzám = SzámjegyesSzámKonstruktor PozitívElőjel
  (Fűzés SzámjegyNulla FűzérVége)

||| A normalizálás magja: strukturális rekurzió a számjegyfűzérre
||| (a rekord-accessoros rekurziót a totality-ellenőr nem látná át).
public export
normalizálFűzér : Előjel -> Fűzér Számjegy -> SzámjegyesSzám
normalizálFűzér _ FűzérVége = nullaSzám
normalizálFűzér _ (Fűzés SzámjegyNulla FűzérVége) = nullaSzám
normalizálFűzér előjel (Fűzés SzámjegyNulla több) = normalizálFűzér előjel több
normalizálFűzér előjel (Fűzés első több) =
  SzámjegyesSzámKonstruktor előjel (Fűzés első több)

||| A normalizálás: a vezető nullák ledobása, a mínusz-nulla pozitívvá.
||| (Accessorokkal — a rekordminta helyett; a mag strukturális.)
public export
normalizál : SzámjegyesSzám -> SzámjegyesSzám
normalizál szám = normalizálFűzér (számElőjele szám) (számjegyei szám)

-- ─── BIZONYÍTÁS: a normalizálás idempotenciája (Refl, zárt példán) ───────
-- Kimenet: Refl (normalizál (normalizál x) = normalizál x ✓)

||| A normalizálás idempotens: a már normalizált számon nem változtat.
||| (A példa: +[0,2,4] — a 240 vezető nullával; kétszer = egyszer.)
public export
normalizálIdempotens :
  normalizál (normalizál (SzámjegyesSzámKonstruktor
      PozitívElőjel (Fűzés SzámjegyNulla (Fűzés SzámjegyKettő
      (Fűzés SzámjegyNégy FűzérVége)))))
  = normalizál (SzámjegyesSzámKonstruktor
      PozitívElőjel (Fűzés SzámjegyNulla (Fűzés SzámjegyKettő
      (Fűzés SzámjegyNégy FűzérVége))))
normalizálIdempotens = Refl

-- ─── GAN 7: az ÁLTALÁNOS idempotencia-tétel (indukció — nem csak tanú) ────

||| A normalizálás FIXPONT-tétele: a normalizált alak a normalizálás
||| fixpontja (a második menet előjele az első menet KIMENETÉBŐL jön —
||| ezért fixpont-formuláció, előjel-függetlenül).
||| Indukció a számjegyfűzér szerkezetére; a vezető-nulla ág a rekurzió.
public export
normalizálFixpont : (előjel : Előjel) -> (ds : Fűzér Számjegy) ->
  normalizál (normalizálFűzér előjel ds) = normalizálFűzér előjel ds
normalizálFixpont _ FűzérVége = Refl
normalizálFixpont előjel (Fűzés első több) =
  case első of
    SzámjegyNulla =>
      case több of
        FűzérVége => Refl
        (Fűzés második tovább) => normalizálFixpont előjel (Fűzés második tovább)
    SzámjegyEgy => Refl
    SzámjegyKettő => Refl
    SzámjegyHárom => Refl
    SzámjegyNégy => Refl
    SzámjegyÖt => Refl
    SzámjegyHat => Refl
    SzámjegyHét => Refl
    SzámjegyNyolc => Refl
    SzámjegyKilenc => Refl

||| A normalizálás idempotencia-TÉTELE (minden SzámjegyesSzám-ra).
-- Kimenet: Refl + indukció (normalizál (normalizál x) = normalizál x ✓)
public export
normalizálIdempotensTétel : (szám : SzámjegyesSzám) ->
  normalizál (normalizál szám) = normalizál szám
normalizálIdempotensTétel szám =
  normalizálFixpont (számElőjele szám) (számjegyei szám)

-- Kimenet: Refl (a −[0] mínusz-nulla pozitív nullává normalizál ✓)
public export
mínuszNullaPozitív :
  normalizál (SzámjegyesSzámKonstruktor
    NegatívElőjel (Fűzés SzámjegyNulla FűzérVége))
  = Alap.CsomagoltTipusok.nullaSzám
mínuszNullaPozitív = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- V. A BETŰ (a 44 betűs magyar ábécé) ÉS A SZÖVEG — a String kiváltása
--     中文：44 个匈牙利字母与文本（代替 String/Char）
-- ═════════════════════════════════════════════════════════════════════════

||| A magyar ábécé 44 betűje — a digráfok (cs, dz, dzs, gy, ly, ny,
||| sz, ty, zs) és az idegen q, w, x, y egyaránt saját betűk.
||| A betű a betűgraféma (kisbetűs megjelenítéssel); a nagybetű későbbi réteg.
||| Forrás: AkH.12 — a magyar helyesírás 44 betűs ábécéje.
public export
data Betű : Type where
  ABetű   : Betű   -- a
  ÁBetű   : Betű   -- á
  BBetű   : Betű   -- b
  CBetű   : Betű   -- c
  CsBetű  : Betű   -- cs
  DBetű   : Betű   -- d
  DzBetű  : Betű   -- dz
  DzsBetű : Betű   -- dzs
  EBetű   : Betű   -- e
  ÉBetű   : Betű   -- é
  FBetű   : Betű   -- f
  GBetű   : Betű   -- g
  GyBetű  : Betű   -- gy
  HBetű   : Betű   -- h
  IBetű   : Betű   -- i
  ÍBetű   : Betű   -- í
  JBetű   : Betű   -- j
  KBetű   : Betű   -- k
  LBetű   : Betű   -- l
  LyBetű  : Betű   -- ly
  MBetű   : Betű   -- m
  NBetű   : Betű   -- n
  NyBetű  : Betű   -- ny
  OBetű   : Betű   -- o
  ÓBetű   : Betű   -- ó
  ÖBetű   : Betű   -- ö
  ŐBetű   : Betű   -- ő
  PBetű   : Betű   -- p
  QBetű   : Betű   -- q (idegen, de ábécébeli)
  RBetű   : Betű   -- r
  SBetű   : Betű   -- s
  SzBetű  : Betű   -- sz
  TBetű   : Betű   -- t
  TyBetű  : Betű   -- ty
  UBetű   : Betű   -- u
  ÚBetű   : Betű   -- ú
  ÜBetű   : Betű   -- ü
  ŰBetű   : Betű   -- ű
  VBetű   : Betű   -- v
  WBetű   : Betű   -- w (idegen, de ábécébeli)
  XBetű   : Betű   -- x (idegen, de ábécébeli)
  YBetű   : Betű   -- y (idegen, de ábécébeli)
  ZBetű   : Betű   -- z
  ZsBetű  : Betű   -- zs

public export
EgyenlőségT Betű where
  egyenlőE ABetű ABetű = Igaz
  egyenlőE ÁBetű ÁBetű = Igaz
  egyenlőE BBetű BBetű = Igaz
  egyenlőE CBetű CBetű = Igaz
  egyenlőE CsBetű CsBetű = Igaz
  egyenlőE DBetű DBetű = Igaz
  egyenlőE DzBetű DzBetű = Igaz
  egyenlőE DzsBetű DzsBetű = Igaz
  egyenlőE EBetű EBetű = Igaz
  egyenlőE ÉBetű ÉBetű = Igaz
  egyenlőE FBetű FBetű = Igaz
  egyenlőE GBetű GBetű = Igaz
  egyenlőE GyBetű GyBetű = Igaz
  egyenlőE HBetű HBetű = Igaz
  egyenlőE IBetű IBetű = Igaz
  egyenlőE ÍBetű ÍBetű = Igaz
  egyenlőE JBetű JBetű = Igaz
  egyenlőE KBetű KBetű = Igaz
  egyenlőE LBetű LBetű = Igaz
  egyenlőE LyBetű LyBetű = Igaz
  egyenlőE MBetű MBetű = Igaz
  egyenlőE NBetű NBetű = Igaz
  egyenlőE NyBetű NyBetű = Igaz
  egyenlőE OBetű OBetű = Igaz
  egyenlőE ÓBetű ÓBetű = Igaz
  egyenlőE ÖBetű ÖBetű = Igaz
  egyenlőE ŐBetű ŐBetű = Igaz
  egyenlőE PBetű PBetű = Igaz
  egyenlőE QBetű QBetű = Igaz
  egyenlőE RBetű RBetű = Igaz
  egyenlőE SBetű SBetű = Igaz
  egyenlőE SzBetű SzBetű = Igaz
  egyenlőE TBetű TBetű = Igaz
  egyenlőE TyBetű TyBetű = Igaz
  egyenlőE UBetű UBetű = Igaz
  egyenlőE ÚBetű ÚBetű = Igaz
  egyenlőE ÜBetű ÜBetű = Igaz
  egyenlőE ŰBetű ŰBetű = Igaz
  egyenlőE VBetű VBetű = Igaz
  egyenlőE WBetű WBetű = Igaz
  egyenlőE XBetű XBetű = Igaz
  egyenlőE YBetű YBetű = Igaz
  egyenlőE ZBetű ZBetű = Igaz
  egyenlőE ZsBetű ZsBetű = Igaz
  egyenlőE _ _ = Hamis

||| A szöveg: betűk füzére (a String kiváltása).
||| A szóköz és az írásjelek NEM betűk — a mondat Fűzér Szöveg (későbbi réteg).
public export
data Szöveg : Type where
  ÜresSzöveg : Szöveg
  BetűtFűz   : Betű -> Szöveg -> Szöveg

||| Két szöveg egyezik-e (betűnként).
public export
szövegEgyenlő : Szöveg -> Szöveg -> Igazság
szövegEgyenlő ÜresSzöveg ÜresSzöveg = Igaz
szövegEgyenlő ÜresSzöveg (BetűtFűz _ _) = Hamis
szövegEgyenlő (BetűtFűz _ _) ÜresSzöveg = Hamis
szövegEgyenlő (BetűtFűz b bs) (BetűtFűz c cs) =
  ésE (egyenlőE b c) (szövegEgyenlő bs cs)

||| Szöveg-összefűzés.
public export
szövegFűzés : Szöveg -> Szöveg -> Szöveg
szövegFűzés ÜresSzöveg folytatás = folytatás
szövegFűzés (BetűtFűz b bs) folytatás = BetűtFűz b (szövegFűzés bs folytatás)

||| Szöveg hossza (sorszám).
public export
szövegHossz : Szöveg -> Sorszám
szövegHossz ÜresSzöveg = SorNulla
szövegHossz (BetűtFűz _ tovább) = SorKövetkező (szövegHossz tovább)

||| Végződés-egyezés: a szó végződik-e a raggal?
||| A 18 esetrag-keresés ALAPJA (a magyar esetragos keresés: 600.10 lépés).
||| Példa: végEgyezzik „háznál" „nál" = Igaz.
public export
végEgyezzik : Szöveg -> Szöveg -> Igazság
végEgyezzik ÜresSzöveg ÜresSzöveg = Igaz
végEgyezzik (BetűtFűz _ _) ÜresSzöveg = Igaz
végEgyezzik ÜresSzöveg (BetűtFűz _ _) = Hamis
végEgyezzik (BetűtFűz b bs) (BetűtFűz c cs) =
  vagyE (ésE (egyenlőE b c) (szövegEgyenlő bs cs))
        (végEgyezzik bs (BetűtFűz c cs))

||| A szövegműveletek typeclassja.
public export
interface SzövegT (típus : Type) where
  szövegHossza   : típus -> Sorszám
  szövegFűzése   : típus -> típus -> típus
  szövegEgyezikE : típus -> típus -> Igazság
  végEgyezzikE   : típus -> típus -> Igazság

public export
SzövegT Szöveg where
  szövegHossza = szövegHossz
  szövegFűzése = szövegFűzés
  szövegEgyezikE = szövegEgyenlő
  végEgyezzikE = végEgyezzik

-- ─── BIZONYÍTÁSOK: a szöveg-egységek (Refl + indukció) ───────────────────

-- Kimenet: Refl (ÜresSzöveg ++ s = s ✓ — definicionálisan)

||| Bal-egység: az üres szöveg balról az identitás.
public export
szövegBalEgység : (s : Szöveg) -> szövegFűzés ÜresSzöveg s = s
szövegBalEgység _ = Refl

-- Kimenet: Refl (s ++ ÜresSzöveg = s ✓ — indukcióval)

||| Jobb-egység: az üres szöveg jobbról is identitás.
public export
szövegJobbEgység : (s : Szöveg) -> szövegFűzés s ÜresSzöveg = s
szövegJobbEgység ÜresSzöveg = Refl
szövegJobbEgység (BetűtFűz b bs) = cong (BetűtFűz b) (szövegJobbEgység bs)

||| A Betű-egyenlőség reflexivitása — a 44 soros instance TYPO-HÁLÓJA
||| (GAN 9.c: egy elírt konstruktor-sor itt bukik le, nem csendesen).
||| ELŐBB áll, mert a szövegRefl és a végEgyezzikRefl rewrite-olja.
public export
betűRefl : (b : Betű) -> egyenlőE b b = Igaz
betűRefl ABetű = Refl
betűRefl ÁBetű = Refl
betűRefl BBetű = Refl
betűRefl CBetű = Refl
betűRefl CsBetű = Refl
betűRefl DBetű = Refl
betűRefl DzBetű = Refl
betűRefl DzsBetű = Refl
betűRefl EBetű = Refl
betűRefl ÉBetű = Refl
betűRefl FBetű = Refl
betűRefl GBetű = Refl
betűRefl GyBetű = Refl
betűRefl HBetű = Refl
betűRefl IBetű = Refl
betűRefl ÍBetű = Refl
betűRefl JBetű = Refl
betűRefl KBetű = Refl
betűRefl LBetű = Refl
betűRefl LyBetű = Refl
betűRefl MBetű = Refl
betűRefl NBetű = Refl
betűRefl NyBetű = Refl
betűRefl OBetű = Refl
betűRefl ÓBetű = Refl
betűRefl ÖBetű = Refl
betűRefl ŐBetű = Refl
betűRefl PBetű = Refl
betűRefl QBetű = Refl
betűRefl RBetű = Refl
betűRefl SBetű = Refl
betűRefl SzBetű = Refl
betűRefl TBetű = Refl
betűRefl TyBetű = Refl
betűRefl UBetű = Refl
betűRefl ÚBetű = Refl
betűRefl ÜBetű = Refl
betűRefl ŰBetű = Refl
betűRefl VBetű = Refl
betűRefl WBetű = Refl
betűRefl XBetű = Refl
betűRefl YBetű = Refl
betűRefl ZBetű = Refl
betűRefl ZsBetű = Refl

||| A Sorszám-egyenlőség reflexivitása (GAN 9.c — indukció).
public export
sorszámRefl : (n : Sorszám) -> egyenlőE n n = Igaz
sorszámRefl SorNulla = Refl
sorszámRefl (SorKövetkező m) = sorszámRefl m

||| A szöveg-egyenlőség reflexivitása (GAN 9.c — bizonyítvány; indukció).
||| A betű-reflexivitás rewrite-ja kell (a változó betű nem redukál).
public export
szövegRefl : (s : Szöveg) -> szövegEgyenlő s s = Igaz
szövegRefl ÜresSzöveg = Refl
szövegRefl (BetűtFűz b tovább) =
  rewrite betűRefl b in rewrite szövegRefl tovább in Refl

||| A vagy bal-Igaz törvénye: Igaz ∨ x = Igaz (változó x-szel nem redukál —
||| a végEgyezzikRefl indukciójához kell).
public export
vagyIgazIgazBal : (x : Igazság) -> vagyIgazsággal Igaz x = Igaz
vagyIgazIgazBal Igaz = Refl
vagyIgazIgazBal Hamis = Refl

||| A végEgyezzik reflexivitása: minden szó végződik önmagával (GAN 11.b).
public export
végEgyezzikRefl : (s : Szöveg) -> végEgyezzik s s = Igaz
végEgyezzikRefl ÜresSzöveg = Refl
végEgyezzikRefl (BetűtFűz b tovább) =
  rewrite betűRefl b in
  rewrite szövegRefl tovább in
  rewrite vagyIgazIgazBal (végEgyezzik tovább (BetűtFűz b tovább)) in Refl

||| Az üres rag mindent igazol — DOKUMENTÁLT TULAJDONSÁG (GAN 11.a),
||| nem meglepetés: a 600.10-es motor ezt a koncepciója részének tudja.
||| HASONULÁSI HATÁR (GAN 11.c): a felületi alakok („házzal" = ház+val)
||| E motorból NEM találhatók — a ragfelismerés hasonulás-utófeldolgozása
||| vagy a lexikon felületi alakjai kezelik (600.10).
public export
végEgyezzikÜresRag : (s : Szöveg) -> végEgyezzik s ÜresSzöveg = Igaz
végEgyezzikÜresRag ÜresSzöveg = Refl
végEgyezzikÜresRag (BetűtFűz _ _) = Refl

-- Kimenet: Refl (a „ban" szó végződik „n"-nel ✓ — az esetrag-motor példája)
public export
végEgyezzikPélda : végEgyezzik
  (BetűtFűz BBetű (BetűtFűz ABetű (BetűtFűz NBetű ÜresSzöveg)))
  (BetűtFűz NBetű ÜresSzöveg) = Igaz
végEgyezzikPélda = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- VI. TALÁN ÉS PÁR — a Maybe és a Pair becsomagolva
--     中文：Talán 代替 Maybe，Pár 代替 Pair
-- ═════════════════════════════════════════════════════════════════════════

||| Talán: van érték vagy nincs (a Maybe helyett).
||| (Idris 0.8.0: a típusparaméter EXPLICIT implicit kötése.)
public export
data Talán : Type -> Type where
  Semmi : {érték : Type} -> Talán érték
  Csak  : {érték : Type} -> érték -> Talán érték

||| Pár: két érték együtt (a Pair helyett).
public export
data Pár : Type -> Type -> Type where
  Párosít : {bal : Type} -> {jobb : Type} -> bal -> jobb -> Pár bal jobb

||| Sorszám-előző: a Peano-struktúra fordítottja (Talán-ban — a nullán nincs;
||| GAN 6.a — ITT él, mert a Talán itt deklarált).
public export
sorElőző : Sorszám -> Talán Sorszám
sorElőző SorNulla = Semmi
sorElőző (SorKövetkező n) = Csak n

||| A számsor typeclassja: a következő és az előző elem — ha van
||| (a tíznél telít, a nullánál nincs előző; GAN 6.a).
public export
interface SzámsorT (típus : Type) where
  sorKövetkezője : típus -> Talán típus
  sorElőzője     : típus -> Talán típus

||| Az EgészSzám előzője (truncált — a nullán Nulla marad; a Talán-réteg
||| az instance-ban dönt: EgészNulla-nál Semmi).
public export
számElőző : EgészSzám -> EgészSzám
számElőző EgészNulla = EgészNulla
számElőző EgészEgy = EgészNulla
számElőző EgészKettő = EgészEgy
számElőző EgészHárom = EgészKettő
számElőző EgészNégy = EgészHárom
számElőző EgészÖt = EgészNégy
számElőző EgészHat = EgészÖt
számElőző EgészHét = EgészHat
számElőző EgészNyolc = EgészHét
számElőző EgészKilenc = EgészNyolc
számElőző EgészTíz = EgészKilenc

public export
SzámsorT EgészSzám where
  sorKövetkezője EgészTíz = Semmi   -- a tíznél nincs tovább (a kapu)
  sorKövetkezője szám = Csak (számKövetkező szám)
  sorElőzője EgészNulla = Semmi     -- a nullánál nincs előző (a forrás)
  sorElőzője szám = Csak (számElőző szám)

||| A Sorszám is számsor (GAN 6.c): a Peano-struktúra teljes sor.
public export
SzámsorT Sorszám where
  sorKövetkezője sor = Csak (SorKövetkező sor)
  sorElőzője = sorElőző

||| A Sorszám rendezése is instance (GAN 6.b — az aszimmetria megszüntetve).
public export
RendezésT Sorszám where
  kisebbE = sorKisebb

-- Kimenet: Refl (a tíz után Semmi — a kapu ✓)
public export
tízUtánSemmi : sorKövetkezője EgészTíz = Semmi
tízUtánSemmi = Refl

-- Kimenet: Refl (a nulla előtt Semmi — a forrás ✓)
public export
nullaElőttSemmi : sorElőzője EgészNulla = Semmi
nullaElőttSemmi = Refl

-- Kimenet: Refl (a Sorszám-sor sosem telít: mindig van következo ✓)
public export
sorszámMindigFolytatódik : (sor : Sorszám) -> sorKövetkezője sor = Csak (SorKövetkező sor)
sorszámMindigFolytatódik sor = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- VII. A KUBIT — a [[15,1,3]] hibajavító kód alapja (kanonikus)
--      中文：Kubit——纠错码基础（规范定义；Steane713 稍后改为导入）
-- ═════════════════════════════════════════════════════════════════════════

||| A kubit: nulla vagy egy (a Z₂-algebra alapja; a [[7,1,3]] Steane-kód téglája).
||| KANONIKUS: a Steane713-beli azonos definíció a 400.03 lépésben
||| importra vált (addig átmeneti névütközés — kvalifikálva oldható fel).
public export
data Kubit : Type where
  Nulla : Kubit
  Egy   : Kubit

public export
EgyenlőségT Kubit where
  egyenlőE Nulla Nulla = Igaz
  egyenlőE Egy Egy = Igaz
  egyenlőE _ _ = Hamis

||| A kubit-különbség (a Z₂ összeadása — a hibajavítás művelete).
public export
kubitKülönbség : Kubit -> Kubit -> Kubit
kubitKülönbség Nulla b = b
kubitKülönbség Egy Nulla = Egy
kubitKülönbség Egy Egy = Nulla

-- Kimenet: Refl (1 ⊕ 1 = 0 ✓ — a Z₂ törvénye)
public export
kubitKülönbségTörvény : kubitKülönbség Egy Egy = Nulla
kubitKülönbségTörvény = Refl

-- ─── Z₂-TÖRVÉNYEK (GAN 8: a véges típusra mind Refl — a hibajavítás
--     aritmetikája, a 400.03-as Steane-migrációnál kell) ──────────────────

-- Kimenet: Refl (a ⊕ b = b ⊕ a ✓ — kommutativitás)
public export
kubitKülönbségKommutatív : (a : Kubit) -> (b : Kubit) ->
  kubitKülönbség a b = kubitKülönbség b a
kubitKülönbségKommutatív Nulla Nulla = Refl
kubitKülönbségKommutatív Nulla Egy = Refl
kubitKülönbségKommutatív Egy Nulla = Refl
kubitKülönbségKommutatív Egy Egy = Refl

-- Kimenet: Refl ((a ⊕ b) ⊕ c = a ⊕ (b ⊕ c) ✓ — asszociativitás)
public export
kubitKülönbségAsszociatív : (a : Kubit) -> (b : Kubit) -> (c : Kubit) ->
  kubitKülönbség (kubitKülönbség a b) c
  = kubitKülönbség a (kubitKülönbség b c)
kubitKülönbségAsszociatív Nulla Nulla Nulla = Refl
kubitKülönbségAsszociatív Nulla Nulla Egy = Refl
kubitKülönbségAsszociatív Nulla Egy Nulla = Refl
kubitKülönbségAsszociatív Nulla Egy Egy = Refl
kubitKülönbségAsszociatív Egy Nulla Nulla = Refl
kubitKülönbségAsszociatív Egy Nulla Egy = Refl
kubitKülönbségAsszociatív Egy Egy Nulla = Refl
kubitKülönbségAsszociatív Egy Egy Egy = Refl

-- Kimenet: Refl (0 ⊕ b = b ✓ — a nulla bal egység)
public export
kubitNullaBalEgység : (b : Kubit) -> kubitKülönbség Nulla b = b
kubitNullaBalEgység _ = Refl

-- Kimenet: Refl (b ⊕ 0 = b ✓ — a nulla jobb egység)
public export
kubitNullaJobbEgység : (b : Kubit) -> kubitKülönbség b Nulla = b
kubitNullaJobbEgység Nulla = Refl
kubitNullaJobbEgység Egy = Refl

-- TODO (400.03-előkészület): a vektorFűzés jobb-egység és asszociativitás
-- tételéhez heterogén egyenlőség kell (a típus-szintű n+0 ≠ n a deklarációban
-- akadály) — a Steane713-migráció (400.03) előkészületében zárjuk.

-- ═════════════════════════════════════════════════════════════════════════
-- VIII. STEANE-VEKTOR — a hossz a TÍPUSBAN, Sorszám-indexelve (Nat nélkül)
--       中文：长度在类型里——Sorszám 索引向量（无 Nat）
-- ═════════════════════════════════════════════════════════════════════════

||| Sorszám-indexelt vektor: a hossz a típusban.
||| SteaneVektor sorHét = pontosan hét kubit (a [[7,1,3]] Steane-kód).
||| SteaneVektor sorNyolc = nyolc kubit (az oktonió).
||| KANONIKUS: a DependensSzamT Nat-indexű változata a 200.30 lépésig él.
public export
data SteaneVektor : Sorszám -> Type where
  ÜresVektor : SteaneVektor SorNulla
  Kombinált  : {sor : Sorszám} -> Kubit -> SteaneVektor sor ->
    SteaneVektor (SorKövetkező sor)

||| Sorszám-index: a vektor EGY biztonságos pontja (a Fin analógja,
||| de Sorszám-indexen). A fordító tiltja a tartományon kívüli indexet.
public export
data SorIndex : Sorszám -> Type where
  SorEleje : {sor : Sorszám} -> SorIndex (SorKövetkező sor)
  SorUtána : {sor : Sorszám} -> SorIndex sor -> SorIndex (SorKövetkező sor)

||| Biztonságos indexelés: az index TÍPUSBAN hordozza a garanciát.
||| (Idris 0.8.0: explicit implicit paraméter.)
public export
sorIndexel : {sor : Sorszám} -> SorIndex sor -> SteaneVektor sor -> Kubit
sorIndexel SorEleje (Kombinált kubit _) = kubit
sorIndexel (SorUtána tovább) (Kombinált _ többi) = sorIndexel tovább többi

||| Két-kubitű példavektor.
||| (Idris 0.8.0: a sorKettő konstans a típusban minősítve.)
public export
kettőKubitPélda : SteaneVektor Alap.CsomagoltTipusok.sorKettő
kettőKubitPélda = Kombinált Egy (Kombinált Nulla ÜresVektor)

-- Kimenet: Refl (a példavektor eleje az Egy ✓)
public export
kettőKubitIndexelBizonyítás :
  sorIndexel SorEleje Alap.CsomagoltTipusok.kettőKubitPélda = Egy
kettőKubitIndexelBizonyítás = Refl

||| Vektor-összefűzés: a hossz típus-szintű összeadás.
||| (Idris 0.8.0: explicit implicit teleszkóp — a nyíl-kötések nem
||| hozzáférhetők a törzsben, az implicit kötések igen.)
public export
vektorFűzés : {sor : Sorszám} -> {tovább : Sorszám} ->
  SteaneVektor sor -> SteaneVektor tovább ->
  SteaneVektor (sorÖsszeadás sor tovább)
vektorFűzés ÜresVektor ys = ys
vektorFűzés (Kombinált kubit többi) ys =
  Kombinált kubit (vektorFűzés többi ys)

-- Kimenet: Refl (a kettő-kubit + a nulla-kubit = kettő-kubit ✓)
public export
vektorFűzésPélda :
  vektorFűzés Alap.CsomagoltTipusok.kettőKubitPélda ÜresVektor
  = Alap.CsomagoltTipusok.kettőKubitPélda
vektorFűzésPélda = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- IX. E8-KOORDINÁTA — a 240 gyök véges koordinátakészlete {0, ±1, ±½}
--     中文：E8 坐标——240 个根的有限坐标集 {0, ±1, ±½}
-- ═════════════════════════════════════════════════════════════════════════

||| Az E8-gyökrendszer koordinátái pontosan ezekből az értékekből állnak
||| (minden E8-gyök nyolc koordinátája 0, ±1 vagy ±½ — a D8-réteg egész,
||| a spinor-réteg fél koordinátái). Forrás: az E8-gyökrendszer standard
||| leírása (l. E8Gyokrendszer.idr). A Double kiváltva: a koordináták
||| VÉGES halmaz — data-ként pontos.
public export
data E8Koordináta : Type where
  NullaKoordináta     : E8Koordináta  -- 0
  EgyKoordináta       : E8Koordináta  -- 1
  MínuszEgyKoordináta : E8Koordináta  -- −1
  FélKoordináta       : E8Koordináta  -- ½
  MínuszFélKoordináta : E8Koordináta  -- −½

public export
EgyenlőségT E8Koordináta where
  egyenlőE NullaKoordináta NullaKoordináta = Igaz
  egyenlőE EgyKoordináta EgyKoordináta = Igaz
  egyenlőE MínuszEgyKoordináta MínuszEgyKoordináta = Igaz
  egyenlőE FélKoordináta FélKoordináta = Igaz
  egyenlőE MínuszFélKoordináta MínuszFélKoordináta = Igaz
  egyenlőE _ _ = Hamis

||| A koordináta tükrözése: c ↦ −c (a [[15,1,3]] CPT-tükre).
public export
koordinátaTükör : E8Koordináta -> E8Koordináta
koordinátaTükör NullaKoordináta = NullaKoordináta
koordinátaTükör EgyKoordináta = MínuszEgyKoordináta
koordinátaTükör MínuszEgyKoordináta = EgyKoordináta
koordinátaTükör FélKoordináta = MínuszFélKoordináta
koordinátaTükör MínuszFélKoordináta = FélKoordináta

-- Kimenet: Refl (a tükör tükre az identitás ✓ — involúció)
public export
tükörInvolúció : (c : E8Koordináta) ->
  koordinátaTükör (koordinátaTükör c) = c
tükörInvolúció NullaKoordináta = Refl
tükörInvolúció EgyKoordináta = Refl
tükörInvolúció MínuszEgyKoordináta = Refl
tükörInvolúció FélKoordináta = Refl
tükörInvolúció MínuszFélKoordináta = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- X. A KONSTANSOK — SZIMBÓLUMOK, NEM DOUBLE-ök (a Pi-elv)
--     中文：常数是符号——Pi 就是 Pi，永远不是 Double
-- ═════════════════════════════════════════════════════════════════════════

||| A konstansok typeclassja: a jel (szimbólum) Szövegként.
||| A numerikus kiértékelés a HATÁRON történik (Határ-modul, meglévő
||| trigonometriával — «you can use existing trigonometry», a felhasználó).
public export
interface KonstansT (típus : Type) where
  konstansJeLe : típus -> Szöveg

||| Matematikai konstansok — szimbólumokként élnek.
public export
data MatematikaiKonstans : Type where
  PiSzimbólum           : MatematikaiKonstans  -- π
  EulerSzámSzimbólum    : MatematikaiKonstans  -- e
  AranymetszésSzimbólum : MatematikaiKonstans  -- φ
  GyökKettőSzimbólum    : MatematikaiKonstans  -- √2

||| A matematikai konstansok jelei — top-level (a bizonyítások hivatkoznak rá).
public export
matematikaiKonstansJeLe : MatematikaiKonstans -> Szöveg
matematikaiKonstansJeLe PiSzimbólum =
  BetűtFűz PBetű (BetűtFűz IBetű ÜresSzöveg)
matematikaiKonstansJeLe EulerSzámSzimbólum =
  BetűtFűz EBetű ÜresSzöveg
matematikaiKonstansJeLe AranymetszésSzimbólum =
  BetűtFűz FBetű (BetűtFűz IBetű ÜresSzöveg)
matematikaiKonstansJeLe GyökKettőSzimbólum =
  BetűtFűz GBetű (BetűtFűz YBetű ÜresSzöveg)

public export
KonstansT MatematikaiKonstans where
  konstansJeLe = matematikaiKonstansJeLe

-- Kimenet: Refl (a Pi jele „pi" — a szimbólum marad szimbólum ✓)
public export
piJelePélda : matematikaiKonstansJeLe PiSzimbólum =
  BetűtFűz PBetű (BetűtFűz IBetű ÜresSzöveg)
piJelePélda = Refl

||| Fizikai konstansok — a CÉL öt tagja (c, h, G, kB, α) szimbólumként.
||| A kiszámításuk tiszta matematikából a 9. szint felé vezető út lényege.
public export
data FizikaiKonstans : Type where
  FénysebességSzimbólum           : FizikaiKonstans  -- c
  PlanckKonstansSzimbólum         : FizikaiKonstans  -- h
  GravitációsKonstansSzimbólum    : FizikaiKonstans  -- G
  BoltzmannKonstansSzimbólum      : FizikaiKonstans  -- kB
  FinomSzerkezetKonstansSzimbólum : FizikaiKonstans  -- α

||| A fizikai konstansok jelei — top-level (a bizonyítások hivatkoznak rá).
public export
fizikaiKonstansJeLe : FizikaiKonstans -> Szöveg
fizikaiKonstansJeLe FénysebességSzimbólum =
  BetűtFűz CBetű ÜresSzöveg
fizikaiKonstansJeLe PlanckKonstansSzimbólum =
  BetűtFűz HBetű ÜresSzöveg
fizikaiKonstansJeLe GravitációsKonstansSzimbólum =
  BetűtFűz GBetű ÜresSzöveg
fizikaiKonstansJeLe BoltzmannKonstansSzimbólum =
  BetűtFűz KBetű (BetűtFűz BBetű ÜresSzöveg)
fizikaiKonstansJeLe FinomSzerkezetKonstansSzimbólum =
  BetűtFűz ABetű ÜresSzöveg

public export
KonstansT FizikaiKonstans where
  konstansJeLe = fizikaiKonstansJeLe

-- ═════════════════════════════════════════════════════════════════════════
-- XI. A 18 VALÓDI ESETRAG — a magyar nyelv kategóriaelméleti gerince
--     中文：匈牙利语 18 个真正的格后缀
-- ═════════════════════════════════════════════════════════════════════════

||| A 18 VALÓDI esetrag (a Wikipédia ellenőrzött listája alapján;
||| forrás: É. Kiss Katalin: Új magyar nyelvtan, ISBN 963-389-521-9).
||| A -nként, -stul/-stül, -kor, -képp(en) NEM valódi esetragok — képzők!
||| Az irányhármasság (honnan? hol? hová?) háromszor három helyi eset:
|||   belső (melybe/melyben/melyből), felszín (felszínre/felszínen/felszínről),
|||   közel (közelbe/közelben/közelből).
||| A 22 eset = 22 morfizmus (AGENTS) — a 18 esetrag a névszó-morfizmusok.
public export
data Esetrag : Type where
  -- A három szintaktikai eset:
  AlanyRag      : Esetrag  -- ∅ (nominativus)
  TárgyRag      : Esetrag  -- -t (accusativus)
  RészesRag     : Esetrag  -- -nak/-nek (dativus)
  -- A tizenöt lexikai eset:
  EszközTársRag : Esetrag  -- -val/-vel (instrumentalis-comitativus)
  OkCélRag      : Esetrag  -- -ért (causalis-finalis)
  EredményRag   : Esetrag  -- -vá/-vé (translativus-factivus)
  MelybeRag     : Esetrag  -- -ba/-be (illativus — hová? a belsejébe)
  MelybenRag    : Esetrag  -- -ban/-ben (inessivus — hol? a belsejében)
  MelybőlRag    : Esetrag  -- -ból/-ből (elativus — honnan? a belsejéből)
  FelszínreRag  : Esetrag  -- -ra/-re (sublativus — hová? a felszínére)
  FelszínRag    : Esetrag  -- -n (superessivus — hol? a felszínén)
  FelszínrőlRag : Esetrag  -- -ról/-ről (delativus — honnan? a felszínéről)
  KözelbeRag    : Esetrag  -- -hoz/-hez/-höz (allativus — hová? a közelébe)
  KözelbenRag   : Esetrag  -- -nál/-nél (adessivus — hol? a közelében)
  KözelbőlRag   : Esetrag  -- -tól/-től (ablativus — honnan? a közeléből)
  MeddigRag     : Esetrag  -- -ig (terminativus — meddig?)
  KéntRag       : Esetrag  -- -ként (essivus-formalis — mint?)
  UlÜlRag       : Esetrag  -- -ul/-ül (essivus-modalis — milyen módon?)

public export
EgyenlőségT Esetrag where
  egyenlőE AlanyRag AlanyRag = Igaz
  egyenlőE TárgyRag TárgyRag = Igaz
  egyenlőE RészesRag RészesRag = Igaz
  egyenlőE EszközTársRag EszközTársRag = Igaz
  egyenlőE OkCélRag OkCélRag = Igaz
  egyenlőE EredményRag EredményRag = Igaz
  egyenlőE MelybeRag MelybeRag = Igaz
  egyenlőE MelybenRag MelybenRag = Igaz
  egyenlőE MelybőlRag MelybőlRag = Igaz
  egyenlőE FelszínreRag FelszínreRag = Igaz
  egyenlőE FelszínRag FelszínRag = Igaz
  egyenlőE FelszínrőlRag FelszínrőlRag = Igaz
  egyenlőE KözelbeRag KözelbeRag = Igaz
  egyenlőE KözelbenRag KözelbenRag = Igaz
  egyenlőE KözelbőlRag KözelbőlRag = Igaz
  egyenlőE MeddigRag MeddigRag = Igaz
  egyenlőE KéntRag KéntRag = Igaz
  egyenlőE UlÜlRag UlÜlRag = Igaz
  egyenlőE _ _ = Hamis

||| A fűzér hossza (sorszám) — a megszámlálás alapja.
||| (Idris 0.8.0: explicit implicit paraméter.)
public export
fűzérHossz : {tag : Type} -> Fűzér tag -> Sorszám
fűzérHossz FűzérVége = SorNulla
fűzérHossz (Fűzés _ tovább) = SorKövetkező (fűzérHossz tovább)

||| Mind a 18 valódi esetrag — egy fűzérben (a gráf-motorba: 600.10).
||| Lépésenkénti felépítés: minden sor EGY konstruktor-morfizmus —
||| nincs mély zárójelfészek (a zárójelhiba gyökerének kiküszöbölése).
||| A magyar sorszáznevek maguk dokumentálják a kompozíciót:
||| az agglutináció = a morfizmusok kompozíciója.
public export
mindA18Esetrag : Fűzér Esetrag
mindA18Esetrag =
  let tizennyolcadik = Fűzés UlÜlRag FűzérVége
      tizenhetedik   = Fűzés KéntRag tizennyolcadik
      tizenhatodik   = Fűzés MeddigRag tizenhetedik
      tizenötödik    = Fűzés KözelbőlRag tizenhatodik
      tizennegyedik  = Fűzés KözelbenRag tizenötödik
      tizenharmadik  = Fűzés KözelbeRag tizennegyedik
      tizenkettedik  = Fűzés FelszínrőlRag tizenharmadik
      tizenegyedik   = Fűzés FelszínRag tizenkettedik
      tizedik        = Fűzés FelszínreRag tizenegyedik
      kilencedik     = Fűzés MelybőlRag tizedik
      nyolcadik      = Fűzés MelybenRag kilencedik
      hetedik        = Fűzés MelybeRag nyolcadik
      hatodik        = Fűzés EredményRag hetedik
      ötödik         = Fűzés OkCélRag hatodik
      negyedik       = Fűzés EszközTársRag ötödik
      harmadik       = Fűzés RészesRag negyedik
      második        = Fűzés TárgyRag harmadik
      első           = Fűzés AlanyRag második
  in első

-- Kimenet: Refl (a 18 esetrag megszámlálva: 10 + 8 = 18 ✓)
public export
tizennyolcEsetrag :
  fűzérHossz Alap.CsomagoltTipusok.mindA18Esetrag
  = sorÖsszeadás Alap.CsomagoltTipusok.sorTíz Alap.CsomagoltTipusok.sorNyolc
tizennyolcEsetrag = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- XII. METRIKÁK — időbélyeg, verziószám, bájtlánc-index, megbízhatóság
--      中文：度量——时间戳、版本号、字节索引、可信度
-- ═════════════════════════════════════════════════════════════════════════

||| Időbélyeg: év, hónap, nap — mind SzámjegyesSzám (pl. 2026, 9, 2).
public export
record Időbélyeg where
  constructor IdőbélyegKonstruktor
  éve     : SzámjegyesSzám
  hónapja : SzámjegyesSzám
  napja   : SzámjegyesSzám

||| Verziószám: fő- és mellékverzió (0–10 — a [[15,1,3]] világában elég).
public export
record VerzióSzám where
  constructor VerzióSzámKonstruktor
  főVerziója     : EgészSzám
  mellékVerziója : EgészSzám

||| Bájtlánc-index: a bájt sorszáma a láncban (nagy szám — SzámjegyesSzám).
public export
record BájtláncIndex where
  constructor BájtláncIndexKonstruktor
  bájtSorszáma : SzámjegyesSzám

||| A megbízhatóság három szintje (a MiértLánc bizalma 0–2).
public export
data Megbízhatóság : Type where
  AlacsonyBizalom : Megbízhatóság
  KözepesBizalom  : Megbízhatóság
  MagasBizalom    : Megbízhatóság

public export
EgyenlőségT Megbízhatóság where
  egyenlőE AlacsonyBizalom AlacsonyBizalom = Igaz
  egyenlőE KözepesBizalom KözepesBizalom = Igaz
  egyenlőE MagasBizalom MagasBizalom = Igaz
  egyenlőE _ _ = Hamis

||| A mennyiségek typeclassja (dimenzionált mennyiségek — későbbi réteg).
||| A HosszMennyiség a Geometriában (200.25) ezen alapul majd
||| (a Hossz-névütközés feloldása a SzótárHíd prozódiai Hossz-jával).
public export
interface MennyiségT (típus : Type) where
  mértékegysége   : típus -> Szöveg
  mennyiségÉrtéke : típus -> SzámjegyesSzám

-- ═════════════════════════════════════════════════════════════════════════
-- XIII. A BETŰK TYPECLASSJA — magánhangzó-e? (a hangrend alapja)
--       中文：字母类型类——是否元音（元音和谐的基础）
-- ═════════════════════════════════════════════════════════════════════════

||| A betűk typeclassja: a magánhangzás — a magyar hangrend alapja.
||| A magánhangzó-harmónia (véghangrend) a ragváltozatok kiválasztója:
||| a -ban/-ben, -ba/-be, ... párok a hangrend szerint választódnak.
public export
interface BetűT (típus : Type) where
  magánhangzóE : típus -> Igazság

||| A betűk magánhangzása — top-level (a bizonyítások TÍPUSÁBA ez mehet).
public export
betűMagánhangzóE : Betű -> Igazság
betűMagánhangzóE ABetű = Igaz
betűMagánhangzóE ÁBetű = Igaz
betűMagánhangzóE EBetű = Igaz
betűMagánhangzóE ÉBetű = Igaz
betűMagánhangzóE IBetű = Igaz
betűMagánhangzóE ÍBetű = Igaz
betűMagánhangzóE OBetű = Igaz
betűMagánhangzóE ÓBetű = Igaz
betűMagánhangzóE ÖBetű = Igaz
betűMagánhangzóE ŐBetű = Igaz
betűMagánhangzóE UBetű = Igaz
betűMagánhangzóE ÚBetű = Igaz
betűMagánhangzóE ÜBetű = Igaz
betűMagánhangzóE ŰBetű = Igaz
betűMagánhangzóE _ = Hamis

public export
BetűT Betű where
  magánhangzóE = betűMagánhangzóE

-- Kimenet: Refl (az „a" magánhangzó, a „b" mássalhangzó ✓)
public export
magánhangzóBizonyítás :
  Párosít (betűMagánhangzóE ABetű) (betűMagánhangzóE BBetű)
  = Párosít Igaz Hamis
magánhangzóBizonyítás = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- XIV. A MEGJELENÍTÉS TYPECLASSJA — minden típus Szövegként
--      中文：显示类型类——返回 Szöveg，绝不返回 String
-- ═════════════════════════════════════════════════════════════════════════

public export
interface MegjelenítésT (típus : Type) where
  megjelenít : típus -> Szöveg

||| Az igazság szava — top-level (a bizonyítás TÍPUSÁBA ez mehet).
public export
igazságMegjelenítése : Igazság -> Szöveg
igazságMegjelenítése Igaz = BetűtFűz IBetű (BetűtFűz GBetű (BetűtFűz ABetű
  (BetűtFűz ZBetű ÜresSzöveg)))
igazságMegjelenítése Hamis = BetűtFűz HBetű (BetűtFűz ABetű (BetűtFűz MBetű
  (BetűtFűz IBetű (BetűtFűz SBetű ÜresSzöveg))))

public export
MegjelenítésT Igazság where
  megjelenít = igazságMegjelenítése

||| A számok SZAVAKKÁ jelennek meg: az ábécében nincsenek számjegyek
||| (a rúnaszámok elve — a számjegy-grafémák későbbi rétegek).
public export
MegjelenítésT EgészSzám where
  megjelenít EgészNulla = BetűtFűz NBetű (BetűtFűz UBetű (BetűtFűz LBetű
    (BetűtFűz LBetű (BetűtFűz ABetű ÜresSzöveg))))
  megjelenít EgészEgy = BetűtFűz EBetű (BetűtFűz GBetű
    (BetűtFűz YBetű ÜresSzöveg))
  megjelenít EgészKettő = BetűtFűz KBetű (BetűtFűz EBetű (BetűtFűz TBetű
    (BetűtFűz TBetű (BetűtFűz ŐBetű ÜresSzöveg))))
  megjelenít EgészHárom = BetűtFűz HBetű (BetűtFűz ÁBetű (BetűtFűz RBetű
    (BetűtFűz OBetű (BetűtFűz MBetű ÜresSzöveg))))
  megjelenít EgészNégy = BetűtFűz NBetű (BetűtFűz ÉBetű (BetűtFűz GBetű
    (BetűtFűz YBetű ÜresSzöveg)))
  megjelenít EgészÖt = BetűtFűz ÖBetű (BetűtFűz TBetű ÜresSzöveg)
  megjelenít EgészHat = BetűtFűz HBetű (BetűtFűz ABetű
    (BetűtFűz TBetű ÜresSzöveg))
  megjelenít EgészHét = BetűtFűz HBetű (BetűtFűz ÉBetű
    (BetűtFűz TBetű ÜresSzöveg))
  megjelenít EgészNyolc = BetűtFűz NBetű (BetűtFűz YBetű (BetűtFűz OBetű
    (BetűtFűz LBetű (BetűtFűz CBetű ÜresSzöveg))))
  megjelenít EgészKilenc = BetűtFűz KBetű (BetűtFűz IBetű (BetűtFűz LBetű
    (BetűtFűz EBetű (BetűtFűz NBetű (BetűtFűz CBetű ÜresSzöveg)))))
  megjelenít EgészTíz = BetűtFűz TBetű (BetűtFűz ÍBetű
    (BetűtFűz ZBetű ÜresSzöveg))

||| A Sorszám megjelenítése a tíznél telít (a kapu-elv; dokumentálva).
public export
MegjelenítésT Sorszám where
  megjelenít sor = megjelenít (sorbólEgész sor)

public export
MegjelenítésT Számjegy where
  megjelenít SzámjegyNulla = megjelenít EgészNulla
  megjelenít SzámjegyEgy = megjelenít EgészEgy
  megjelenít SzámjegyKettő = megjelenít EgészKettő
  megjelenít SzámjegyHárom = megjelenít EgészHárom
  megjelenít SzámjegyNégy = megjelenít EgészNégy
  megjelenít SzámjegyÖt = megjelenít EgészÖt
  megjelenít SzámjegyHat = megjelenít EgészHat
  megjelenít SzámjegyHét = megjelenít EgészHét
  megjelenít SzámjegyNyolc = megjelenít EgészNyolc
  megjelenít SzámjegyKilenc = megjelenít EgészKilenc

public export
MegjelenítésT Előjel where
  megjelenít PozitívElőjel = BetűtFűz PBetű (BetűtFűz OBetű (BetűtFűz ZBetű
    (BetűtFűz IBetű (BetűtFűz TBetű (BetűtFűz ÍBetű
    (BetűtFűz VBetű ÜresSzöveg))))))
  megjelenít NegatívElőjel = BetűtFűz NBetű (BetűtFűz EBetű (BetűtFűz GBetű
    (BetűtFűz ABetű (BetűtFűz TBetű (BetűtFűz ÍBetű
    (BetűtFűz VBetű ÜresSzöveg))))))

||| A fűzér megjelenítése: az elemek szavainak összefűzése.
||| (Idris 0.8.0: teleszkópos constraint-instance, NÉV NÉLKÜL.)
public export
{tag : Type} -> MegjelenítésT tag => MegjelenítésT (Fűzér tag) where
  megjelenít FűzérVége = ÜresSzöveg
  megjelenít (Fűzés x xs) = szövegFűzés (megjelenít x) (megjelenít xs)

||| Számjegyes szám: az előjel szava + a számjegyszavak láncolata.
||| (Keverék-elválasztó nincs — a számjegyszavak egybefüggő olvasata;
||| a tagolás későbbi réteg. Accessorok — rekordminta helyett.)
public export
MegjelenítésT SzámjegyesSzám where
  megjelenít szám = szövegFűzés
    (megjelenít (számElőjele szám)) (megjelenít (számjegyei szám))

public export
MegjelenítésT Szöveg where
  megjelenít szöveg = szöveg

public export
MegjelenítésT Betű where
  megjelenít ABetű = BetűtFűz ABetű ÜresSzöveg
  megjelenít ÁBetű = BetűtFűz ÁBetű ÜresSzöveg
  megjelenít BBetű = BetűtFűz BBetű ÜresSzöveg
  megjelenít CBetű = BetűtFűz CBetű ÜresSzöveg
  megjelenít CsBetű = BetűtFűz CsBetű ÜresSzöveg
  megjelenít DBetű = BetűtFűz DBetű ÜresSzöveg
  megjelenít DzBetű = BetűtFűz DzBetű ÜresSzöveg
  megjelenít DzsBetű = BetűtFűz DzsBetű ÜresSzöveg
  megjelenít EBetű = BetűtFűz EBetű ÜresSzöveg
  megjelenít ÉBetű = BetűtFűz ÉBetű ÜresSzöveg
  megjelenít FBetű = BetűtFűz FBetű ÜresSzöveg
  megjelenít GBetű = BetűtFűz GBetű ÜresSzöveg
  megjelenít GyBetű = BetűtFűz GyBetű ÜresSzöveg
  megjelenít HBetű = BetűtFűz HBetű ÜresSzöveg
  megjelenít IBetű = BetűtFűz IBetű ÜresSzöveg
  megjelenít ÍBetű = BetűtFűz ÍBetű ÜresSzöveg
  megjelenít JBetű = BetűtFűz JBetű ÜresSzöveg
  megjelenít KBetű = BetűtFűz KBetű ÜresSzöveg
  megjelenít LBetű = BetűtFűz LBetű ÜresSzöveg
  megjelenít LyBetű = BetűtFűz LyBetű ÜresSzöveg
  megjelenít MBetű = BetűtFűz MBetű ÜresSzöveg
  megjelenít NBetű = BetűtFűz NBetű ÜresSzöveg
  megjelenít NyBetű = BetűtFűz NyBetű ÜresSzöveg
  megjelenít OBetű = BetűtFűz OBetű ÜresSzöveg
  megjelenít ÓBetű = BetűtFűz ÓBetű ÜresSzöveg
  megjelenít ÖBetű = BetűtFűz ÖBetű ÜresSzöveg
  megjelenít ŐBetű = BetűtFűz ŐBetű ÜresSzöveg
  megjelenít PBetű = BetűtFűz PBetű ÜresSzöveg
  megjelenít QBetű = BetűtFűz QBetű ÜresSzöveg
  megjelenít RBetű = BetűtFűz RBetű ÜresSzöveg
  megjelenít SBetű = BetűtFűz SBetű ÜresSzöveg
  megjelenít SzBetű = BetűtFűz SzBetű ÜresSzöveg
  megjelenít TBetű = BetűtFűz TBetű ÜresSzöveg
  megjelenít TyBetű = BetűtFűz TyBetű ÜresSzöveg
  megjelenít UBetű = BetűtFűz UBetű ÜresSzöveg
  megjelenít ÚBetű = BetűtFűz ÚBetű ÜresSzöveg
  megjelenít ÜBetű = BetűtFűz ÜBetű ÜresSzöveg
  megjelenít ŰBetű = BetűtFűz ŰBetű ÜresSzöveg
  megjelenít VBetű = BetűtFűz VBetű ÜresSzöveg
  megjelenít WBetű = BetűtFűz WBetű ÜresSzöveg
  megjelenít XBetű = BetűtFűz XBetű ÜresSzöveg
  megjelenít YBetű = BetűtFűz YBetű ÜresSzöveg
  megjelenít ZBetű = BetűtFűz ZBetű ÜresSzöveg
  megjelenít ZsBetű = BetűtFűz ZsBetű ÜresSzöveg

public export
{érték : Type} -> MegjelenítésT érték => MegjelenítésT (Talán érték) where
  megjelenít Semmi = ÜresSzöveg
  megjelenít (Csak tartalom) = megjelenít tartalom

public export
{bal : Type} -> {jobb : Type} ->
  (MegjelenítésT bal, MegjelenítésT jobb) => MegjelenítésT (Pár bal jobb) where
  megjelenít (Párosít balErő jobbErő) =
    szövegFűzés (megjelenít balErő) (megjelenít jobbErő)

public export
MegjelenítésT Kubit where
  megjelenít Nulla = megjelenít EgészNulla
  megjelenít Egy = megjelenít EgészEgy

public export
MegjelenítésT E8Koordináta where
  megjelenít NullaKoordináta = megjelenít EgészNulla
  megjelenít EgyKoordináta = megjelenít EgészEgy
  megjelenít MínuszEgyKoordináta = szövegFűzés
    (BetűtFűz MBetű (BetűtFűz ÍBetű (BetűtFűz NBetű (BetűtFűz UBetű
    (BetűtFűz SBetű (BetűtFűz ZBetű ÜresSzöveg)))))) (megjelenít EgészEgy)
  megjelenít FélKoordináta = BetűtFűz FBetű (BetűtFűz ÉBetű
    (BetűtFűz LBetű ÜresSzöveg))
  megjelenít MínuszFélKoordináta = szövegFűzés
    (BetűtFűz MBetű (BetűtFűz ÍBetű (BetűtFűz NBetű (BetűtFűz UBetű
    (BetűtFűz SBetű (BetűtFűz ZBetű ÜresSzöveg))))))
    (BetűtFűz FBetű (BetűtFűz ÉBetű (BetűtFűz LBetű ÜresSzöveg)))

||| Az esetragok megjelenítése az alapalakjukban (hátsó magánhangzós).
||| A hangrend szerinti változat (ban/ben, ba/be, ...) a BetűT-motorral
||| a 600.10 lépésben választódik.
public export
MegjelenítésT Esetrag where
  megjelenít AlanyRag = ÜresSzöveg
  megjelenít TárgyRag = BetűtFűz TBetű ÜresSzöveg
  megjelenít RészesRag = BetűtFűz NBetű (BetűtFűz ABetű
    (BetűtFűz KBetű ÜresSzöveg))
  megjelenít EszközTársRag = BetűtFűz VBetű (BetűtFűz ABetű
    (BetűtFűz LBetű ÜresSzöveg))
  megjelenít OkCélRag = BetűtFűz ÉBetű (BetűtFűz RBetű
    (BetűtFűz TBetű ÜresSzöveg))
  megjelenít EredményRag = BetűtFűz VBetű (BetűtFűz ÁBetű ÜresSzöveg)
  megjelenít MelybeRag = BetűtFűz BBetű (BetűtFűz ABetű ÜresSzöveg)
  megjelenít MelybenRag = BetűtFűz BBetű (BetűtFűz ABetű
    (BetűtFűz NBetű ÜresSzöveg))
  megjelenít MelybőlRag = BetűtFűz BBetű (BetűtFűz ÓBetű
    (BetűtFűz LBetű ÜresSzöveg))
  megjelenít FelszínreRag = BetűtFűz RBetű (BetűtFűz ABetű ÜresSzöveg)
  megjelenít FelszínRag = BetűtFűz NBetű ÜresSzöveg
  megjelenít FelszínrőlRag = BetűtFűz RBetű (BetűtFűz ÓBetű
    (BetűtFűz LBetű ÜresSzöveg))
  megjelenít KözelbeRag = BetűtFűz HBetű (BetűtFűz OBetű
    (BetűtFűz ZBetű ÜresSzöveg))
  megjelenít KözelbenRag = BetűtFűz NBetű (BetűtFűz ÁBetű
    (BetűtFűz LBetű ÜresSzöveg))
  megjelenít KözelbőlRag = BetűtFűz TBetű (BetűtFűz ÓBetű
    (BetűtFűz LBetű ÜresSzöveg))
  megjelenít MeddigRag = BetűtFűz IBetű (BetűtFűz GBetű ÜresSzöveg)
  megjelenít KéntRag = BetűtFűz KBetű (BetűtFűz ÉBetű (BetűtFűz NBetű
    (BetűtFűz TBetű ÜresSzöveg)))
  megjelenít UlÜlRag = BetűtFűz UBetű (BetűtFűz LBetű ÜresSzöveg)

public export
MegjelenítésT Megbízhatóság where
  megjelenít AlacsonyBizalom = BetűtFűz ABetű (BetűtFűz LBetű
    (BetűtFűz ABetű (BetűtFűz CBetű (BetűtFűz SBetű (BetűtFűz CBetű
    (BetűtFűz OBetű (BetűtFűz NBetű (BetűtFűz YBetű ÜresSzöveg))))))))
  megjelenít KözepesBizalom = BetűtFűz KBetű (BetűtFűz ÖBetű
    (BetűtFűz ZBetű (BetűtFűz EBetű (BetűtFűz PBetű (BetűtFűz EBetű
    (BetűtFűz SBetű ÜresSzöveg))))))
  megjelenít MagasBizalom = BetűtFűz MBetű (BetűtFűz ABetű
    (BetűtFűz GBetű (BetűtFűz ABetű (BetűtFűz SBetű ÜresSzöveg))))

public export
MegjelenítésT Időbélyeg where
  megjelenít bélyeg = szövegFűzés (megjelenít (éve bélyeg))
    (szövegFűzés (megjelenít (hónapja bélyeg)) (megjelenít (napja bélyeg)))

public export
MegjelenítésT VerzióSzám where
  megjelenít verzió = szövegFűzés
    (megjelenít (főVerziója verzió)) (megjelenít (mellékVerziója verzió))

public export
MegjelenítésT BájtláncIndex where
  megjelenít index = megjelenít (bájtSorszáma index)

-- Kimenet: Refl (az igaz megjelenítése az „igaz" szó ✓)
public export
igazMegjelenítésPélda : igazságMegjelenítése Igaz =
  BetűtFűz IBetű (BetűtFűz GBetű (BetűtFűz ABetű
  (BetűtFűz ZBetű ÜresSzöveg)))
igazMegjelenítésPélda = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- ZÁRÁS — a modul összefoglalása
-- 中文：本模块完成：零裸类型。下一步（000.02）：Határ（唯一的 String 边界）。
-- Deutsch: Fertig — keine nackten Typen. Nächster Schritt: das Grenzmodul.
-- עברית: הושלם — בלי טיפוסים חשופים. הצעד הבא: מודול הגבול.
--
-- A TÍPUSOK: Igazság, Sorszám, EgészSzám, Számjegy, Előjel, Fűzér,
--   SzámjegyesSzám, Betű (44), Szöveg, Talán, Pár, Kubit, SteaneVektor,
--   SorIndex, E8Koordináta, MatematikaiKonstans, FizikaiKonstans,
--   Esetrag (18), Időbélyeg, VerzióSzám, BájtláncIndex, Megbízhatóság.
-- A TYPECLASSOK: EgyenlőségT, IgazságT, RendezésT, ÖsszeadásT, SzorzásT,
--   KivonásT, SzövegT, SzámsorT, KonstansT, MennyiségT, BetűT, MegjelenítésT.
-- A BIZONYÍTÁSOK (Refl): deMorgan, duplaTagadás, sorBalEgység,
--   sorJobbEgység, hétPluszEgyNyolcSor, kettőSzorÖtTízSor, egyPluszEgyKettő,
--   kettőSzorKettőNégy, hétPluszEgyNyolcEgész, ötKivonEgyNégy,
--   kilencPluszKettőTelít, normalizálIdempotens, mínuszNullaPozitív,
--   szövegBalEgység, szövegJobbEgység, végEgyezzikPélda, tízUtánSemmi,
--   kubitKülönbségTörvény, kettőKubitIndexelBizonyítás, vektorFűzésPélda,
--   tükörInvolúció, piJelePélda, tizennyolcEsetrag, magánhangzóBizonyítás,
--   igazMegjelenítésPélda.
-- ═════════════════════════════════════════════════════════════════════════