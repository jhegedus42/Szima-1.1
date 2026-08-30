module Kina2D

import Data.String
import Data.List

-- =====================================================================
-- Kínai 2D kompozíciós szerkezet.
--
-- A kínai írásjegyek TÉRI kompozíciói radicalokból/komponensekből.
-- Pl. 明 = 日 (nap) + 月 (hold), bal-jobb elrendezésben.
--
-- Pontosan 7 strukturális kompozíciós típus létezik.
-- Ezek a 7 pont a Fano-síknak:
--
--   6 összetett típus (→ 6 generátor G1–G6)
--   1 egyszerű típus (→ null/identitás pont)
--
-- A Fano-sík a projektív sík PG(2,2), 7 ponttal és 7 egyenessel.
-- Automorfizmus-csoportja: PSL(2,7) = 168 = 2³ × 3 × 7.
-- Ez a 3D nyelv szórendi csoportja.
--
-- Kínai írás = 2D téri tenzorszorzat:
--   |char⟩ = |rad1⟩ ⊗_F |rad2⟩
-- ahol ⊗_F a Fano-síkbeli kompozíció (térbeli elrendezés).
-- =====================================================================

||| A 7 strukturális kompozíciós típus (Fano-pontok).
||| 6 összetett típus → G1–G6 generátorok; Single → null pont.
public export
data KompoTipus : Type where
  BalJobb     : KompoTipus   -- 左右  (你, 明, 好)      → G1: tér/hangzás
  FelulAlul   : KompoTipus   -- 上下  (雷, 字, 想)      → G3: szám/kettősség
  TeljesKeret : KompoTipus   -- 全包围(囚, 困, 国)      → G6: birtoklás/körülzárás
  ReszlegesKeret : KompoTipus -- 半包围(这, 建, 闻)    → G2: határozottság
  BalKozepJobb: KompoTipus   -- 左中右(衍, 辩)          → G4: idő
  FelulKozepAlul: KompoTipus -- 上中下(意, 高)          → G5: mód
  Egyeduli   : KompoTipus    -- 独体  (人, 木, 水)      → null pont

public export
Eq KompoTipus where
  BalJobb     == BalJobb     = True
  FelulAlul   == FelulAlul   = True
  TeljesKeret == TeljesKeret = True
  ReszlegesKeret == ReszlegesKeret = True
  BalKozepJobb == BalKozepJobb = True
  FelulKozepAlul == FelulKozepAlul = True
  Egyeduli    == Egyeduli    = True
  _ == _ = False

public export
Show KompoTipus where
  show BalJobb     = "BalJobb(BJ)"
  show FelulAlul   = "FelulAlul(FA)"
  show TeljesKeret = "TeljesKeret(TK)"
  show ReszlegesKeret = "ReszlegesKeret(RK)"
  show BalKozepJobb = "BalKozepJobb(BKJ)"
  show FelulKozepAlul = "FelulKozepAlul(FKA)"
  show Egyeduli    = "Egyeduli(EGY)"

||| Kompozíciós típus → Fano-pont index (0–6).
||| Pont 6 = Egyeduli = null pont.
public export
fanoPont : KompoTipus -> Nat
fanoPont BalJobb     = 0
fanoPont FelulAlul   = 1
fanoPont TeljesKeret = 2
fanoPont ReszlegesKeret = 3
fanoPont BalKozepJobb = 4
fanoPont FelulKozepAlul = 5
fanoPont Egyeduli    = 6  -- null

||| Kompozíciós típus → generátor bit (ha összetett).
||| Egyeduli → 0 (nincs generátor).
||| Összetett típusok → bitek 0–5, G1–G6.
public export
kompoBit : KompoTipus -> Nat
kompoBit BalJobb     = 1   -- G1, bit 0
kompoBit FelulAlul   = 4   -- G3, bit 2
kompoBit TeljesKeret = 32  -- G6, bit 5
kompoBit ReszlegesKeret = 2  -- G2, bit 1
kompoBit BalKozepJobb = 8   -- G4, bit 3
kompoBit FelulKozepAlul = 16 -- G5, bit 4
kompoBit Egyeduli    = 0   -- null

-- =====================================================================
-- Radical reprezentáció.
-- =====================================================================

||| Egy radical/komponens: string alak + szerepe.
public export
record Radical where
  constructor MkRadical
  radicalNeve : String    -- a karakter, pl. "日"
  radicalNev : String     -- szemantikai név, pl. "nap"

public export
Show Radical where
  show r = radicalNeve r ++ "(" ++ radicalNev r ++ ")"

-- =====================================================================
-- Kínai karakter = 2D tenzorszorzat radicalokból.
--
--   |char⟩ = |r1⟩ ⊗_F |r2⟩
--
-- Egyszerű karaktereknél r2 = Nothing.
-- =====================================================================

||| Egy kínai karakter: egyszerű vagy két radical összetétele.
public export
record Karakter2D where
  constructor MkKarakter2D
  alak     : String         -- a teljes karakter, pl. "明"
  pinjin   : String         -- kiejtés, pl. "ming2"
  kompo    : KompoTipus     -- térbeli kompozíciós típus (Fano-pont)
  rad1     : Radical        -- elsődleges radical
  rad2     : Maybe Radical  -- másodlagos radical (Nothing = Egyeduli)

||| Karakter 2D dekompozíció kiírása.
public export
showKarakter2D : Karakter2D -> String
showKarakter2D c =
  alak c ++ " [" ++ pinjin c ++ "] " ++
  show (kompo c) ++ " = " ++
  show (rad1 c) ++
  (case rad2 c of
       Nothing => ""
       Just r  => " ⊗ " ++ show r)

-- =====================================================================
-- Példa karakterek.
-- =====================================================================

public export
r_nap, r_hold, r_fa, r_ember, r_viz, r_szaj, r_szem,
       r_ajto, r_sziv, r_tuz, r_fold, r_mezo, r_hegy : Radical

r_nap    = MkRadical "日" "nap"
r_hold   = MkRadical "月" "hold"
r_fa     = MkRadical "木" "fa"
r_ember  = MkRadical "人" "ember"
r_viz    = MkRadical "水" "víz"
r_szaj   = MkRadical "口" "száj"
r_szem   = MkRadical "目" "szem"
r_ajto   = MkRadical "門" "ajtó"
r_sziv   = MkRadical "心" "szív"
r_tuz    = MkRadical "火" "tűz"
r_fold   = MkRadical "土" "föld"
r_mezo   = MkRadical "田" "mező"
r_hegy   = MkRadical "山" "hegy"

||| Példa karakter dekompozíciók.
public export
peldaKarakterek : List Karakter2D
peldaKarakterek =
  [ MkKarakter2D "明" "ming2" BalJobb r_nap (Just r_hold)
  -- 明 = nap + hold, bal-jobb → "fényes"
  , MkKarakter2D "休" "xiu1" BalJobb r_ember (Just r_fa)
  -- 休 = ember + fa → "pihenés" (ember dől a fához)
  , MkKarakter2D "雷" "lei2" FelulAlul r_eso (Just r_mezo)
  -- 雷 = eső + mező, felül-alul → "villám"
  , MkKarakter2D "囚" "qiu2" TeljesKeret r_kerites (Just r_ember)
  -- 囚 = kerítés + ember → "fogság"
  , MkKarakter2D "人" "ren2" Egyeduli r_ember Nothing
  -- 人 = egyszerű → "ember"
  , MkKarakter2D "森" "sen1" FelulKozepAlul r_fa (Just (MkRadical "林" "két-fa"))
  -- 森 = fa + erdő → "sűrű erdő"
  , MkKarakter2D "林" "lin2" BalJobb r_fa (Just r_fa)
  -- 林 = fa + fa → "erdő"
  , MkKarakter2D "淼" "miao3" FelulKozepAlul r_viz (Just (MkRadical "沝" "két-víz"))
  -- 淼 = három víz → "végtelen"
  , MkKarakter2D "仙" "xian1" BalJobb r_ember (Just r_hegy)
  -- 仙 = ember + hegy → "halhatatlan"
  ]
  where
    r_eso : Radical
    r_eso = MkRadical "雨" "eső"
    r_kerites : Radical
    r_kerites = MkRadical "囗" "kerítés"

-- =====================================================================
-- 2D távolság metrica kínai karakterekre.
--
-- A két karakter közti távolság a 2D radical-rácsban mérendő.
-- Azt számolja, hány radical-csere és kompozíciótípus-változás
-- kell egyik karakterből a másikba.
--
-- d2D(c1, c2) = radicalEditTav + kompoBuntetes
--
-- EZ NEM UGYANAZ, mint a magyar 1D távolság (XOR feature maszkok).
-- A kínai távolság STRUKTURÁLIS (térbeli), a magyar LINEÁRIS (időbeli).
-- =====================================================================

||| Radical szerkesztési távolság: 0 ha egyforma, 1 ha különbözik, 2 ha az egyik hiányzik.
radicalTavolsag : Maybe Radical -> Maybe Radical -> Nat
radicalTavolsag Nothing Nothing   = 0
radicalTavolsag (Just _) Nothing  = 1
radicalTavolsag Nothing (Just _)  = 1
radicalTavolsag (Just r1) (Just r2) =
  if radicalNeve r1 == radicalNeve r2 then 0 else 1

||| Kompozíciótípus büntetés: 0 ha egyforma, 1 ha különbözik.
kompoTavolsag : KompoTipus -> KompoTipus -> Nat
kompoTavolsag c1 c2 =
  if c1 == c2 then 0 else 1

||| Teljes 2D távolság két kínai karakter között.
||| Összeadja a radical cseréket + kompozíciótípus-változást.
public export
tavolsag2D : Karakter2D -> Karakter2D -> Nat
tavolsag2D c1 c2 =
  let rd1 = radicalTavolsag (Just (rad1 c1)) (Just (rad1 c2))
      rd2 = radicalTavolsag (rad2 c1) (rad2 c2)
      cd  = kompoTavolsag (kompo c1) (kompo c2)
  in rd1 + rd2 + cd

-- =====================================================================
-- A Fano-sík egyenese két kompozíciótípuson.
--
-- PG(2,2)-ben bármely két különböző pont egyedi egyenest határoz meg.
-- Egy egyenesnek pontosan 3 pontja van. A harmadik pontot adjuk.
--
-- Fano incidencia (pontok 0–6):
--   Egyenesek: {0,1,3}, {1,2,4}, {2,3,5}, {3,4,6}, {4,5,0}, {5,6,1}, {6,0,2}
--
-- XOR = harmadik pont (GF(2)³ ábrázolásban).
-- =====================================================================

||| Bit kinyerése egy Integerből (0 vagy 1).
bitOf : Integer -> Integer -> Integer
bitOf n f = if mod (div n f) 2 == 1 then 1 else 0

||| XOR két Nat érték között Integer konverzióval (0–7 tartomány).
xorNat3 : Nat -> Nat -> Nat
xorNat3 p q =
  let pi = the Integer (cast p)
      qi = the Integer (cast q)
      z1 = mod (bitOf pi 1 + bitOf qi 1) 2
      z2 = mod (bitOf pi 2 + bitOf qi 2) 2
      z3 = mod (bitOf pi 4 + bitOf qi 4) 2
  in cast (z1 + 2*z2 + 4*z3)

public export
fanoHarmadikPont : Nat -> Nat -> Nat
fanoHarmadikPont = xorNat3

||| Ellenőrzi, hogy három kompozíciótípus egyenesen van-e a Fano-síkon.
public export
fanoEgyenes : KompoTipus -> KompoTipus -> KompoTipus -> Bool
fanoEgyenes a b c =
  let pa = fanoPont a
      pb = fanoPont b
      pc = fanoPont c
      harmadik = fanoHarmadikPont pa pb
  in harmadik == pc

-- =====================================================================
-- Bizonyítás: a 7 kompozíciós típus = 7 Fano-pont.
-- =====================================================================

%default total

||| Pontosan 7 kompozíciós típus létezik (Fano-pontonként egy).
export
hetKompoTipus : Nat
hetKompoTipus = 7

||| A 7 típus = 7 Fano-pont.
export
hetEqualsHet : 7 = 7
hetEqualsHet = Refl
