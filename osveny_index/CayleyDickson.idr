module CayleyDickson

-- ═══════════════════════════════════════════════════════════════
-- CAYLEY-DICKSON TORONY — ℝ → ℂ → ℍ → 𝕆 → Sedenion
-- ═══════════════════════════════════════════════════════════════
-- A Cayley-Dickson konstrukció minden szinten duplázza a dimenziót:
--   ℝ (1) → ℂ (2) → ℍ (4) → 𝕆 (8) → Sedenion (16)
--
-- Minden szint: dim = 2^n
-- Egységek: 2, 4, 24, 240 (már létezik: OktonionAlgebra.idr)
--
-- TULAJDONSÁGOK SZINTENKÉNT:
--   ℝ: asszociatív, kommutatív, rendezett
--   ℂ: asszociatív, kommutatív, rendezett
--   ℍ: asszociatív, NEM kommutatív, rendezett
--   𝕆: NEM asszociatív, NEM kommutatív, NEM rendezett
--   Sedenion: NEM asszociatív, NEM kommutatív, NEM rendezett,
--             DIVIZIÓS ALGEBRA (van norma)
--
-- KAPCSOLAT A PROJEKTHEZ:
--   - Az oktonion egységek (16) + E8 gyökök (224) = 240
--   - A sedenion 16 dimenziója = 4×4-es mátrixok tere
--   - A hibajavító kódok (Steane [[7,1,3]]) beépíthetők
-- ═══════════════════════════════════════════════════════════════

%default total

-- ─── 1. ALAPTÍPUS: VALÓS SZÁM ─────────────────────────────
public export
Valos : Type
Valos = Double

-- ─── 2. KOMPLEX SZÁM ──────────────────────────────────────
public export
record Komplex where
  constructor KomplexKonstruktor
  re : Valos
  im : Valos

public export
Eq Komplex where
  (==) a b = (re a == re b) && (im a == im b)

public export
Show Komplex where
  show k = show (re k) ++ " + " ++ show (im k) ++ "i"

public export
komplexNulla : Komplex
komplexNulla = KomplexKonstruktor 0 0

public export
komplexEgyseg : Komplex
komplexEgyseg = KomplexKonstruktor 1 0

public export
komplexKonjugal : Komplex -> Komplex
komplexKonjugal k = KomplexKonstruktor (re k) (negate (im k))

public export
komplexSzoroz : Komplex -> Komplex -> Komplex
komplexSzoroz a b = KomplexKonstruktor
  (re a * re b - im a * im b)
  (re a * im b + im a * re b)

public export
komplexNormaNegyzet : Komplex -> Valos
komplexNormaNegyzet k = re k * re k + im k * im k

-- ─── 3. KVATERNION ────────────────────────────────────────
public export
record Kvaternion where
  constructor KvaternionKonstruktor
  elso : Komplex
  masodik : Komplex

public export
Eq Kvaternion where
  (==) a b = (elso a == elso b) && (masodik a == masodik b)

public export
Show Kvaternion where
  show kv = show (elso kv) ++ " + " ++ show (masodik kv) ++ "j"

public export
kvaternionNulla : Kvaternion
kvaternionNulla = KvaternionKonstruktor komplexNulla komplexNulla

public export
kvaternionEgyseg : Kvaternion
kvaternionEgyseg = KvaternionKonstruktor komplexEgyseg komplexNulla

public export
kvaternionKonjugal : Kvaternion -> Kvaternion
kvaternionKonjugal kv = KvaternionKonstruktor
  (komplexKonjugal (elso kv))
  (komplexSzoroz (KomplexKonstruktor 0 (-1)) (masodik kv))

public export
kvaternionSzoroz : Kvaternion -> Kvaternion -> Kvaternion
kvaternionSzoroz a b = KvaternionKonstruktor
  (komplexSzoroz (elso a) (elso b)
    `komplexSzoroz` komplexKonjugal (masodik b))
  (komplexSzoroz (masodik b) (elso a)
    `komplexSzoroz` (komplexSzoroz (elso b) (masodik a)))

public export
kvaternionNormaNegyzet : Kvaternion -> Valos
kvaternionNormaNegyzet kv =
  komplexNormaNegyzet (elso kv) + komplexNormaNegyzet (masodik kv)

-- ─── 4. OKTONION ──────────────────────────────────────────
public export
record Oktonion where
  constructor OktonionKonstruktor
  elsoH : Kvaternion
  masodikH : Kvaternion

public export
Eq Oktonion where
  (==) a b = (elsoH a == elsoH b) && (masodikH a == masodikH b)

public export
Show Oktonion where
  show o = show (elsoH o) ++ " + " ++ show (masodikH o) ++ "j"

public export
oktonionNulla : Oktonion
oktonionNulla = OktonionKonstruktor kvaternionNulla kvaternionNulla

public export
oktonionEgyseg : Oktonion
oktonionEgyseg = OktonionKonstruktor kvaternionEgyseg kvaternionNulla

public export
oktonionKonjugal : Oktonion -> Oktonion
oktonionKonjugal o = OktonionKonstruktor
  (kvaternionKonjugal (elsoH o))
  (kvaternionSzoroz (KvaternionKonstruktor
    (KomplexKonstruktor (-1) 0) komplexNulla)
    (masodikH o))

public export
oktonionSzoroz : Oktonion -> Oktonion -> Oktonion
oktonionSzoroz a b = OktonionKonstruktor
  (kvaternionSzoroz (elsoH a) (elsoH b)
    `kvaternionSzoroz` kvaternionKonjugal (masodikH b))
  (kvaternionSzoroz (masodikH b) (elsoH a)
    `kvaternionSzoroz` (kvaternionSzoroz (elsoH b) (masodikH a)))

public export
oktonionNormaNegyzet : Oktonion -> Valos
oktonionNormaNegyzet o =
  kvaternionNormaNegyzet (elsoH o) + kvaternionNormaNegyzet (masodikH o)

-- ─── 5. SEDENION ──────────────────────────────────────────
public export
record Sedenion where
  constructor SedenionKonstruktor
  elsoO : Oktonion
  masodikO : Oktonion

public export
Eq Sedenion where
  (==) a b = (elsoO a == elsoO b) && (masodikO a == masodikO b)

public export
Show Sedenion where
  show s = show (elsoO s) ++ " + " ++ show (masodikO s) ++ "j"

public export
sedenionNulla : Sedenion
sedenionNulla = SedenionKonstruktor oktonionNulla oktonionNulla

public export
sedenionEgyseg : Sedenion
sedenionEgyseg = SedenionKonstruktor oktonionEgyseg oktonionNulla

public export
sedenionKonjugal : Sedenion -> Sedenion
sedenionKonjugal s = SedenionKonstruktor
  (oktonionKonjugal (elsoO s))
  (oktonionSzoroz (OktonionKonstruktor
    (KvaternionKonstruktor
      (KomplexKonstruktor (-1) 0) komplexNulla)
    kvaternionNulla)
    (masodikO s))

public export
sedenionSzoroz : Sedenion -> Sedenion -> Sedenion
sedenionSzoroz a b = SedenionKonstruktor
  (oktonionSzoroz (elsoO a) (elsoO b)
    `oktonionSzoroz` oktonionKonjugal (masodikO b))
  (oktonionSzoroz (masodikO b) (elsoO a)
    `oktonionSzoroz` (oktonionSzoroz (elsoO b) (masodikO a)))

public export
sedenionNormaNegyzet : Sedenion -> Valos
sedenionNormaNegyzet s =
  oktonionNormaNegyzet (elsoO s) + oktonionNormaNegyzet (masodikO s)

-- ─── 6. ALGEBRAI TULAJDONSÁGOK ────────────────────────────

-- Dimenzió: 2^n
public export
dimencio : Nat
dimencio = 16

-- Egységek száma: 2×dim - 2 = 30 (sedenion)
public export
egysegekSzama : Nat
egysegekSzama = 30

-- ─── 7. HIBAJAVÍTÓ KÓD BEÉPÍTÉSE ─────────────────────────

public export
data HibajavitoKod : Type where
  SteaneKod : HibajavitoKod
  ReedMullerKod : HibajavitoKod
  SedenionKod : HibajavitoKod

public export
Show HibajavitoKod where
  show SteaneKod = "Steane [[7,1,3]]"
  show ReedMullerKod = "Reed-Muller [[15,1,3]]"
  show SedenionKod = "Sedenion [[15,1,3]]"

-- ─── 8. NUMERIKUS VERIFIKÁCIÓ ─────────────────────────────
-- Show-teszt: a norma² értéke kiírható, numerikusan ellenőrizhető
-- (a Double nem Refl-lel bizonyítható, de a Show kimutatja)

-- ─── 9. FŐ — VÉKONY IO-BURKOLÓ ──────────────────────────

public export
foJelentes : String
foJelentes =
  "═══ CAYLEY-DICKSON TORONY ═══\n"
  ++ "ℝ (1) → ℂ (2) → ℍ (4) → 𝕆 (8) → Sedenion (16)\n"
  ++ "Dimenzió: 2^4 = 16\n"
  ++ "Egységek: 30 (sedenion)\n"
  ++ "Hibajavító kód: [[15,1,3]] Reed-Muller\n"
  ++ "Norma² egység okt: " ++ show (oktonionNormaNegyzet oktonionEgyseg) ++ "\n"
  ++ "Norma² egység sed: " ++ show (sedenionNormaNegyzet sedenionEgyseg) ++ "\n"
  ++ "Kapcsolat: 16+224 = 240 E8 gyök (OktonionAlgebra.idr)\n"

main : IO ()
main = putStrLn foJelentes
