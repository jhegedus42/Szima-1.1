module KlasszikusKódok_v1

import Data.List
import E8TizenhatPenge    -- §24: gf2, kodSuly, hammingTavolsag, egyedi, benVanLista
import ModulRegisztracio
import ZetaKe9Szórás_v1   -- §24: listaUtolsóVagy, listaKezdete, listaVégeForgat

%default total

-- ═══════════════════════════════════════════════════════════════
-- KLASSZIKUS KÓDOK_v1 — a classical_codes.py Idris-átirata
-- ─────────────────────────────────────────────────────────────
-- A .py három dolgot csinál: (1) a 24 magyar esetet 8-bites
-- vektorokba kódolja (5 bit az index + 3 nulla), (2) kiszámolja
-- az E8-paritásnak hitt 8×8-as mátrix szindrómáit, (3) egy
-- "konvolúciós" állapotgéppel kódol: v = eset ⊕ előző, majd
-- egyetlen bitfordítással igyekszik nullázni a szindrómát, és a
-- kimenet v ⊕ jobbra-forgatás(v), 16 bit.
--
-- AMIT EZ A MODUL MEGTALÁLT (a .py-ban NEM volt kiszámolva):
--   * A szindróma-leképezés a 24 esetre INJEKTÍV (24 különböző
--     szindróma) — a gép kimerítő felsorolással tanúsítja.
--   * A "paritás-mátrix" GF(2)-n INVERTÁLHATÓ: az összes 256
--     vektor felsorolásával a mag pontosan {0} — tehát NEM az
--     ellenőrzőmátrixa nemtriviális kódnak (a név félrevezető).
--   * A konvolúciós kódoló DEGENERÁLT: a 8 lépéses demóban csak
--     4 KÜLÖNBÖZŐ 16-bites szó keletkezik (a 8 esetből!) — a
--     NOM, ACC, DAT és SUB mind ugyanarra a nullszóra fut, mert
--     a szindróma-javító bitfordítás felülírja az információt.
--     A kimenetek súlyai: [0, 0, 6, 4, 0, 0, 6, 4]; a KÜLÖNBÖZŐ
--     szavak közti minimális távolság 4.
--
-- | 中文：把 classical_codes.py 移植到 Idris：24 个匈牙利语格 →
--   8 位向量（5 位索引+3 个零），E8 “奇偶矩阵”的综合征，以及
--   卷积状态机编码。发现：综合征映射在 24 个格上单射（穷举证
--   明）；该矩阵在 GF(2) 上可逆（256 枚举，核仅 {0}）——并非非
--   平凡码的校验矩阵；卷积编码器退化：演示 8 步只产生 4 个不同
--   的 16 位字（NOM/ACC/DAT/SUB 全部落到零字），权重
--   [0,0,6,4,0,0,6,4]，不同字之间最小距离 4。
-- | EN: Port of classical_codes.py to Idris: 24 Hungarian cases →
--   8-bit vectors, the "E8 parity" syndromes, and a convolutional
--   state machine. Findings: the syndrome map is injective on the
--   24 cases (exhaustive); the matrix is invertible over GF(2)
--   (256 enumerated, kernel = {0}) — not a parity-check of a
--   nontrivial code; the convolutional encoder is degenerate: the
--   8-step demo yields only 4 distinct 16-bit words (NOM/ACC/
--   DAT/SUB collapse to the zero word), weights [0,0,6,4,0,0,6,4],
--   minimum distance among distinct words 4.
-- | DE: Portierung von classical_codes.py nach Idris: 24
--   ungarische Fälle → 8-Bit-Vektoren, die „E8-Paritäts“-Syndrome
--   und eine convolutionale Zustandsmaschine. Befunde: die
--   Syndrom-Abbildung ist auf den 24 Fällen injektiv; die Matrix
--   ist über GF(2) invertierbar (Kern = {0}) — kein Prüfmatrix
--   eines nichttrivialen Codes; der Encoder ist degeneriert:
--   nur 4 verschiedene 16-Bit-Wörter, Minimumdistanz (unter
--   verschiedenen Wörtern) 4.
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. AZ E8-PARITÁS MÁTRIX ÉS A 24 ESET ─────────────────────────
-- A .py E8_PARITY-ja szó szerint (8×8, GF(2)-n értendő).

public export
paritásMátrix : List (List Integer)
paritásMátrix =
  [ [1,0,0,0,1,0,1,1]
  , [0,1,0,0,1,1,0,1]
  , [0,0,1,0,1,1,1,0]
  , [0,0,0,1,0,1,1,1]
  , [0,0,0,0,1,0,0,0]
  , [0,0,0,0,0,1,0,0]
  , [0,0,0,0,0,0,1,0]
  , [0,0,0,0,0,0,0,1]
  ]

-- A .py CASES-listája (a címkék megőrizve az összehasonlításhoz).
-- Teljes magyar neveik: Nominatívusz (NOM), Akkuzatívusz (ACC),
-- Datívusz (DAT), Instrumentális (INS), Komitatívusz (COM),
-- Kauzálisz-Finálisz (CAU), Transzlatívusz (TRA), Terminatívusz (TER),
-- Illatívusz (ILL), Inesszívusz (INE), Elatívusz (ELA), Allatívusz (ALL),
-- Adesszívusz (ADE), Ablatívusz (ABL), Superesszívusz (SUP),
-- Delatívusz (DEL), Szublatívusz (SUB), Temporálisz (TEM),
-- Szociatívusz (SOC), Distributívusz (DIST), Esszívusz (ESS),
-- Modálisz (MOD), Kauzátívusz-jel (CAS), Esszívusz-Formálisz (FOR).

public export
esetNevek : List String
esetNevek =
  [ "NOM","ACC","DAT","INS","COM","CAU","TRA","TER"
  , "ILL","INE","ELA","ALL","ADE","ABL","SUP","DEL"
  , "SUB","TEM","SOC","DIST","ESS","MOD","CAS","FOR"
  ]

-- ─── 2. AZ ESET-KÓDOK (5 bit LSB-előre + 3 nulla) ─────────────────

public export
kettőHatvány : Nat -> Integer
kettőHatvány 0 = 1
kettőHatvány 1 = 2
kettőHatvány 2 = 4
kettőHatvány 3 = 8
kettőHatvány 4 = 16
kettőHatvány 5 = 32
kettőHatvány 6 = 64
kettőHatvány 7 = 128
kettőHatvány _ = 256

public export
esetKód : Nat -> List Integer
esetKód i = [ gf2 (natToInteger i `div` kettőHatvány b) | b <- [0..4] ] ++ [0,0,0]

public export
esetKódok : List (List Integer)
esetKódok = map esetKód [0..23]

-- ─── 3. A SZINDRÓMA ───────────────────────────────────────────────

public export
sorSzindróma : List Integer -> List Integer -> Integer
sorSzindróma sor vektor = gf2 (sum (zipWith (*) sor vektor))

public export
szindróma : List Integer -> List Integer
szindróma vektor = map (\sor => sorSzindróma sor vektor) paritásMátrix

-- Kimenet: Refl ([0,0,0,0,0,0,0,0] ✓) — a nullvektor kódszó
-- (a lineáris kódok triviális törvénye; bal oldal számított).
public export
nominativuszSzindrómaTanú : szindróma (esetKód 0) = [0,0,0,0,0,0,0,0]
nominativuszSzindrómaTanú = Refl

-- Kimenet: Refl ([1,0,0,0,0,0,0,0] ✓) — az ACC (index 1)
-- szindrómaja a mátrix 0-számú OSZLOPA (a hibajelölés mintája).
public export
akkuzativuszSzindrómaTanú : szindróma (esetKód 1) = [1,0,0,0,0,0,0,0]
akkuzativuszSzindrómaTanú = Refl

public export
esetSzindrómák : List (List Integer)
esetSzindrómák = map szindróma esetKódok

||| Kimerítő tanú: a 24 eset szindrómája mind KÜLÖNBÖZŐ
||| (az `egyedi` importtal, §24) — a leképezés injektív.
public export
szindrómaInjektívTanú : Nat
szindrómaInjektívTanú = length (egyedi esetSzindrómák)

-- ─── 4. A MAG KIMERÍTŐ FELSOROLÁSA (mind a 256 vektor) ────────────

public export
minden8Bit : List (List Integer)
minden8Bit =
  [ [ gf2 (natToInteger i `div` kettőHatvány b) | b <- [0..7] ] | i <- [0..255] ]

public export
nullSzindrómásVektorok : List (List Integer)
nullSzindrómásVektorok = filter (\v => all (== 0) (szindróma v)) minden8Bit

||| A mag mérete: 1 (csak a nullvektor) → a mátrix GF(2)-n
||| invertálható → NEM ellenőrzőmátrixa nemtriviális kódnak.
public export
kernelMéretTanú : Nat
kernelMéretTanú = length nullSzindrómásVektorok

-- ─── 5. A KONVOLÚCIÓS ÁLLAPOTGÉP ──────────────────────────────────

public export
record KonvolúciósÁllapot where
  constructor KonvolúciósÁllapotKonstruktor
  előzőVektor : List Integer

public export
kezdőÁllapot : KonvolúciósÁllapot
kezdőÁllapot = KonvolúciósÁllapotKonstruktor (replicate 8 0)

public export
vagyVagy : Integer -> Integer -> Integer
vagyVagy a b = gf2 (a + b)

public export
vektorGf2Összead : List Integer -> List Integer -> List Integer
vektorGf2Összead = zipWith vagyVagy

public export
bitFordít : Nat -> List Integer -> List Integer
bitFordít _ [] = []
bitFordít 0 (b :: többi) = vagyVagy 1 b :: többi
bitFordít (S k) (b :: többi) = b :: bitFordít k többi

public export
nullSzindrómájúE : List Integer -> Bool
nullSzindrómájúE v = all (== 0) (szindróma v)

public export
egyszeriFordításJó : List Integer -> Nat -> Maybe (List Integer)
egyszeriFordításJó v i =
  let t = bitFordít i v
  in if nullSzindrómájúE t then Just t else Nothing

public export
elsőSikeres : List (Maybe a) -> Maybe a
elsőSikeres [] = Nothing
elsőSikeres (Just x :: _) = Just x
elsőSikeres (Nothing :: többi) = elsőSikeres többi

||| A .py javító-hurka: az első olyan egyetlen bitfordítás, ami
||| nullázza a szindrómát (nincs ilyen → Nothing → marad a nyers).
public export
javítottVektor : List Integer -> Maybe (List Integer)
javítottVektor v = elsőSikeres (map (egyszeriFordításJó v) [0..7])

public export
record KódolásiLépés where
  constructor KódolásiLépésKonstruktor
  végsőVektor : List Integer      -- a javítás utáni v (16 bit első fele)
  rollRész : List Integer         -- r = v ⊕ jobbra-forgatás(v)
  teljesSzó : List Integer        -- v ++ r (16 bit)
  szóSúlya : Nat                  -- Hamming-súly (kodSuly import, §24)
  voltJavítás : Bool              -- sikerült-e a szindrómát bitfordítással nullázni

||| Egy eset lekódolása az aktuális állapotban (a .py encode_case).
public export
kódolEset : List Integer -> KonvolúciósÁllapot -> (KódolásiLépés, KonvolúciósÁllapot)
kódolEset esetK allapot =
  let nyers = vektorGf2Összead esetK (előzőVektor allapot)
      javított = javítottVektor nyers
      végső = case javított of
                Just t => t
                Nothing => nyers
      siker = case javított of
                Just _ => True
                Nothing => False
      r = vektorGf2Összead végső (listaVégeForgat végső)   -- §24: listaVégeForgat
  in (KódolásiLépésKonstruktor végső r (végső ++ r) (kodSuly (végső ++ r)) siker,
      KonvolúciósÁllapotKonstruktor végső)

-- ─── 6. A .py DEMÓJA (8 eset) ÉS AZ EXTRA MÉRÉSEK ─────────────────

||| A .py demo-sorozata: a címke + a CASES-listabeli index.
public export
demóEsetek : List (String, Nat)
demóEsetek =
  [ ("NOM", 0), ("ACC", 1), ("CAU", 5), ("TRA", 6)
  , ("DAT", 2), ("SUB", 16), ("INE", 9), ("ELA", 10)
  ]

public export
demóFutás : List (String, Nat) -> KonvolúciósÁllapot -> List (String, KódolásiLépés)
demóFutás [] _ = []
demóFutás ((tag, i) :: többi) allapot =   -- allapot: ASCII-kötő (á-csapda)
  let kimenet = kódolEset (esetKód i) allapot
  in (tag, fst kimenet) :: demóFutás többi (snd kimenet)

public export
demóLépések : List (String, KódolásiLépés)
demóLépések = demóFutás demóEsetek kezdőÁllapot

public export
demóSzavak : List (List Integer)
demóSzavak = map (teljesSzó . snd) demóLépések

public export
demóSúlyok : List Nat
demóSúlyok = map kodSuly demóSzavak

||| Hány KÜLÖNBÖZŐ 16-bites szó keletkezett (elvileg csak 4!).
public export
különbözőSzavakSzáma : Nat
különbözőSzavakSzáma = length (egyedi demóSzavak)

||| Páronkénti távolságok (hammingTavolsag import, §24).
public export
párTávolságok16 : List Nat
párTávolságok16 =
  [ hammingTavolsag a b | a <- demóSzavak, b <- demóSzavak, not (a == b) ]

||| A minimális távolság a demó-szavak közt (elvileg 0 — degenerált!).
public export
minTávolság16 : Nat
minTávolság16 = foldr min 1000000 párTávolságok16

||| Zártsági számláló: hány (a,b) pár XOR-a marad a demó-szó-halmazban.
public export
zártságiSzámláló : Nat
zártságiSzámláló =
  length (filter (\p => benVanLista p demóSzavak)
                 [ vektorGf2Összead a b | a <- demóSzavak, b <- demóSzavak ])

-- ─── 7. SHOW-SOROK ────────────────────────────────────────────────

public export
bitFüzér : List Integer -> String
bitFüzér [] = ""
bitFüzér (b :: többi) = (if b == 1 then "1" else "0") ++ bitFüzér többi

public export
esetSor : (String, Nat) -> String
esetSor (tag, i) =
  "  " ++ tag ++ " (index " ++ show i ++ ")  kód = " ++ bitFüzér (esetKód i)
      ++ "  szindróma = " ++ bitFüzér (szindróma (esetKód i))

public export
mindEsetTábla : String
mindEsetTábla = concatMap (\s => s ++ "\n") (map esetSor (zip esetNevek [0..23]))

public export
lépésSora : (String, KódolásiLépés) -> String
lépésSora (tag, l) =
  "  " ++ tag ++ " → " ++ bitFüzér (végsőVektor l) ++ "|" ++ bitFüzér (rollRész l)
      ++ "   súly = " ++ show (szóSúlya l)
      ++ "   javítás = " ++ (if voltJavítás l then "VAN" else "nincs")

public export
demóTábla : String
demóTábla = concatMap (\s => s ++ "\n") (map lépésSora demóLépések)

-- ─── 8. A FŐPROGRAM — Show-kimenet (GAUGE: olvasd!) ───────────────

main : IO ()
main = do
  putStrLn "=== KLASSZIKUS KÓDOK — Idrisben (classical_codes.py átirata) ==="
  putStrLn ""
  putStrLn "=== 1. A 24 magyar eset: kód és szindróma (kimerítő tábla) ==="
  putStr mindEsetTábla
  putStrLn ("  különböző szindrómák száma = " ++ show szindrómaInjektívTanú
            ++ " (a 24-ből) → a szindróma-leképezés injektív ✓")
  putStrLn ""
  putStrLn "=== 2. A mag kimerítő felsorolása (mind a 256 vektor) ==="
  putStrLn ("  null szindrómájú vektorok száma = " ++ show kernelMéretTanú
            ++ "  → a mátrix GF(2)-n INVERTÁLHATÓ,")
  putStrLn "  tehát NEM ellenőrzőmátrixa nemtriviális kódnak (a 'paritás' név félrevezető)."
  putStrLn ""
  putStrLn "=== 3. A konvolúciós demó (a .py 8 esete) ==="
  putStr demóTábla
  putStrLn ("  súlyok: " ++ show demóSúlyok)
  putStrLn ("  különböző 16-bites szavak: " ++ show különbözőSzavakSzáma
            ++ " (a 8 lépésből!)")
  putStrLn ("  minimális páronkénti távolság: " ++ show minTávolság16
            ++ "  → a kód DEGENERÁLT (több eset ugyanarra a szóra fut)")
  putStrLn ("  zárt (a,b)-párok XOR-jának száma a halmazban: " ++ show zártságiSzámláló
            ++ " / 64")
  putStrLn ""
  putStrLn "=== MIT JELENT (projekt-nyelven) ==="
  putStrLn "  a) a 24 eset szindrómája egyértelműen azonosítja az esetet —"
  putStrLn "     a szindróma = az eset 'fázis-ujjlenyomata' (7-1-3: a redundancia)."
  putStrLn "  b) az E8-paritás-mátrix invertálható: mint MÁTRIX hordoz információt,"
  putStrLn "     mint KÓD viszont nem véd — a védelem a konvolúciós állapotban lenne."
  putStrLn "  c) a demó degenerációja (8 esetből csak 4 különböző szó) kimutatja:"
  putStrLn "     a szindróma-javító bitfordítás FELÜLÍRJA az információt —"
  putStrLn "     a javításnak az eredeti esetet kell őriznie, nem csak a szindrómát."
  putStrLn "Kész."

-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ────────────────────────────
public export
KlasszikusKódokLeiras : ModulLeirasT
KlasszikusKódokLeiras = ModulLeirasKonstruktor
  "KlasszikusKódok_v1.idr"
  "24 eset szindróma-injektivitása (kimerítő); a 'paritás'-mátrix magja {0} (256 felsorolás, invertálható); konvolúciós demó: 8 esetből 4 különböző szó — degenerált; min. táv a különböző szavak közt 4"
  "a classical_codes.py Idris-átirata; felfedés: a javító-lépés felülírja az információt"
  "Show-teszt + 2 Refl-szindróma-tanú"
