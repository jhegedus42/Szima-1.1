module Vizualizaciok

-- ═══════════════════════════════════════════════════════════════
-- VIZUALIZÁCIÓ-ADATOK — az Idris generálja, a böngésző rajzolja
-- ═══════════════════════════════════════════════════════════════
-- Kimenet:
--   idris2 --exec jsonKiiras Vizualizaciok.idr > ../docs/adatok/vizualizaciok.json
-- ═══════════════════════════════════════════════════════════════

import E8Gyokrendszer
import OktonionAlgebra
import SteaneHamiltonian

%default covering

-- ─── 1. FANO-SÍK (hardcodeolt indexek, a FanoParitás-ból) ──

fanoPontokJson : String
fanoPontokJson = "[{\"id\":0,\"x\":100,\"y\":20},{\"id\":1,\"x\":169,\"y\":70},{\"id\":2,\"x\":143,\"y\":150},{\"id\":3,\"x\":57,\"y\":150},{\"id\":4,\"x\":31,\"y\":70},{\"id\":5,\"x\":100,\"y\":85},{\"id\":6,\"x\":100,\"y\":130}]"

fanoEgyenesekJson : String
fanoEgyenesekJson = "[[4,2,6],[4,1,5],[2,1,3],[4,7,3],[2,7,5],[1,7,6],[6,5,3]]"

-- A pont indexei: a FanoParitás FanóPont-jainak bináris értéke
-- (FanóNégy=4, FanóKettő=2, FanóHat=6, ... → index = fp1*4+fp2*2+fp3)
-- A 7 egyenes a FanoParitás FanóEgyenesek-ből jön (ellenőrizve).

fanoJson : String
fanoJson = "{\"pontok\":" ++ fanoPontokJson ++ ",\"egyenesek\":" ++ fanoEgyenesekJson ++ "}"

-- ─── 2. E8-TORONY ────────────────────────────────────────

toronyJson : String
toronyJson = "["
  ++ "{\"nev\":\"R\",\"egys\":2,\"bit\":1},"
  ++ "{\"nev\":\"C\",\"egys\":4,\"bit\":2},"
  ++ "{\"nev\":\"kor\",\"egys\":8,\"bit\":3},"
  ++ "{\"nev\":\"H\",\"egys\":24,\"bit\":5},"
  ++ "{\"nev\":\"O\",\"egys\":240,\"bit\":8}"
  ++ "]"

-- ─── 3. OKTONION TÁBLA (7×7) ─────────────────────────────

elojelesSzoveg : ElojelesGyok -> String
elojelesSzoveg ValosMinuszEgy = "-1"
elojelesSzoveg ValosPluszEgy = "+1"
elojelesSzoveg (PozitivGyok g) = "+" ++ show g
elojelesSzoveg (NegativGyok g) = "-" ++ show g

sorFuzo : List String -> String
sorFuzo [] = ""
sorFuzo [x] = x
sorFuzo (x :: xs) = x ++ "," ++ sorFuzo xs

oktonionSorJson : HetesGyok -> String
oktonionSorJson i =
  "[" ++ sorFuzo (map (\j => "\"" ++ elojelesSzoveg (egysegSzorzatTabla i j) ++ "\"") [E1,E2,E3,E4,E5,E6,E7]) ++ "]"

oktonionTablazatJson : String
oktonionTablazatJson =
  "[" ++ sorFuzo (map oktonionSorJson [E1,E2,E3,E4,E5,E6,E7]) ++ "]"

-- ─── 4. STEANE SPEKTRUM ─────────────────────────────────

steaneSpektrumJson : String
steaneSpektrumJson = "["
  ++ "{\"t\":\"tiszta\",\"szint\":" ++ show (energiaSzint TisztaAllapot) ++ ",\"H\":" ++ show (hamiltonianErtek TisztaAllapot) ++ "},"
  ++ "{\"t\":\"X1\",\"szint\":" ++ show (energiaSzint EgyesHibaAllapot) ++ ",\"H\":" ++ show (hamiltonianErtek EgyesHibaAllapot) ++ "},"
  ++ "{\"t\":\"X4\",\"szint\":" ++ show (energiaSzint NegyesHibaAllapot) ++ ",\"H\":" ++ show (hamiltonianErtek NegyesHibaAllapot) ++ "},"
  ++ "{\"t\":\"Z5\",\"szint\":" ++ show (energiaSzint OtosFazisHibaAllapot) ++ ",\"H\":" ++ show (hamiltonianErtek OtosFazisHibaAllapot) ++ "}"
  ++ "]"

-- ─── 5. A TELJES JSON ────────────────────────────────────

public export
osszesJson : String
osszesJson = "{\"fano\":" ++ fanoJson
  ++ ",\"torony\":" ++ toronyJson
  ++ ",\"oktonion\":" ++ oktonionTablazatJson
  ++ ",\"steane\":" ++ steaneSpektrumJson
  ++ "}"

public export
jsonKiiras : IO ()
jsonKiiras = putStr osszesJson

main : IO ()
main = jsonKiiras