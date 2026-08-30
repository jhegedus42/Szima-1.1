module ProbeKeresoRefl

import E8Gyokok_v2
import E8BelsoSzorzat
import GyokSzo_v1
import Data.List

%default covering

KezdőP : E8Gyok
KezdőP = jel PéldaEgészSzó

CélP : E8Gyok
CélP = gyokEllentett (jel PéldaFélEgészSzó)

CélszóP : GyökSzó
CélszóP = GyökSzóKonstruktor CélP (szóOsztályMeghatároz CélP)

útP : List E8Gyok
útP =
  [ KezdőP
  , weylReflexio (jel PéldaFélEgészSzó) KezdőP
  , weylReflexio (jel PéldaEgészSzó)
      (weylReflexio (jel PéldaFélEgészSzó) KezdőP)
  ]

-- A-változat: átnevezett kötőnév (út → útvonal)
útVégeA : List E8Gyok -> E8Gyok
útVégeA útvonal = foldl (\_, gyök => gyök) KezdőP útvonal

-- B-változat: pont nélküli (point-free)
útVégeB : List E8Gyok -> E8Gyok
útVégeB = foldl (\_, gyök => gyök) KezdőP

-- BETŰ-MÁTRIX: melyik kezdőbetűs kötőnév él?
mátrixG : List E8Gyok -> Nat
mátrixG xs = length xs

mátrixH : List E8Gyok -> Nat
mátrixH vonal = length vonal

mátrixI : List E8Gyok -> Nat
mátrixI űr = length űr

mátrixJ : List E8Gyok -> Nat
mátrixJ ábra = length ábra

mátrixK : List E8Gyok -> Nat
mátrixK ék = length ék

mátrixL : List E8Gyok -> Nat
mátrixL útjelző = length útjelző

próbaD : belsoszorzat (útVégeA útP) CélP = 8
próbaD = Refl

próbaE : jelentésTávolság
          (GyökSzóKonstruktor (útVégeA útP) (szóOsztályMeghatároz (útVégeA útP)))
          CélszóP = AzonosJel
próbaE = Refl

próbaF : elem (weylReflexio (jel PéldaFélEgészSzó) KezdőP) e8Gyokok = True
próbaF = Refl

-- KÖR 2: melyik kontextusban él az ékezetes kötőnév?
mátrixP : List E8Gyok -> Nat
mátrixP ábrázat = length ábrázat

mátrixR : List E8Gyok -> Nat
mátrixR = hosszSzámol
  where
    hosszSzámol : List E8Gyok -> Nat
    hosszSzámol ábraBelső = length ábraBelső

mátrixS : List E8Gyok -> Nat
mátrixS = \ábraLambda => length ábraLambda

mátrixT : Maybe E8Gyok -> Nat
mátrixT (Just ékesKonstruktorban) = 1
mátrixT Nothing = 0

mátrixU : List E8Gyok -> Nat
mátrixU ábrix = length ábrix

-- KÖR 4: minimálrepro-kísérlet a fő modul két gyanúsítottjára
public export
próbaÚtVége : List E8Gyok -> E8Gyok
próbaÚtVége útvonal = foldl (\_, gyök => gyök) KezdőP útvonal

public export
próbaElemBizonyítás : elem (weylReflexio (jel PéldaFélEgészSzó) KezdőP) e8Gyokok = True
próbaElemBizonyítás = Refl
