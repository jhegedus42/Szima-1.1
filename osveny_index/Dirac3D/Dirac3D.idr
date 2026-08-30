module Dirac3D

import Kina2D
import Magyar
import Data.List
import Data.String

-- =====================================================================
-- 3D nyelv: a Kínai (2D) × Magyar (1D) közvetlen szorzata.
--
-- A nyelv 3 dimenziós, mert két alapvetően különböző írásrendszer
-- közvetlen szorzata:
--
--   Kínai (2D): radicalok téri kompozíciója
--     |char⟩ = |r1⟩ ⊗_F |r2⟩     (Fano-sík tenzorszorzat)
--
--   Magyar (1D): toldalékok lineáris lánca
--     |word⟩ = Ĝₙ ... Ĝ₂ Ĝ₁ |tő⟩   (generátor kompozíció)
--
--   3D nyelv:
--     |Ψ⟩ = |char⟩ ⊗ Ô_lanc |tő⟩
--         = (|r1⟩ ⊗_F |r2⟩) ⊗ (Ĝₙ ... Ĝ₁ |tő⟩)
--
-- Dimenzió számítás:
--   Kínai 2D: 7 Fano-pont × ∞ radical → végtelen, de korlátozva
--     a 214 Kangxi radicalra → 214² × 7 ≈ 320k összetett forma
--   Magyar 1D: 6 generátor → 2⁶ = 64 feature kombináció,
--     legfeljebb 3 toldalékkal → 64³ ≈ 262k, de korlátozva
--     az érvényes magyar morfológiával → ~432 = 2⁴ × 3³
--   3D szorzat: 320k × 432 ≈ 1.4 × 10⁸ — elég kifejező erő.
--
-- A Stabilizátor/Dirac nyelvben:
--   - Főnevek (kínai karakterek) = stabilizátor állapotok (2D ketek)
--   - Toldalékok (magyar) = Clifford-szerű generátorok Ĝ1..Ĝ6
--   - A CPT involúció mindkettőre hat:
--     CPT|Ψ⟩ = Θ|char⟩ ⊗ Θ̂|word⟩
--   - CPT maszk = 37 = G1 ⊕ G3 ⊕ G6 (bitek 0,2,5)
-- =====================================================================

-- =====================================================================
-- 1. rész: Magyar 1D — toldalék operátorok Dirac generátorként.
-- =====================================================================

||| Morfológiai generátor: egyike a G1–G6-nak a bit maszkkal.
public export
record GenOp where
  constructor MkGenOp
  genNev  : String    -- "G1:harmonia", "G3:szám", stb.
  genBit  : Nat       -- 1, 2, 4, 8, 16, 32

public export
Show GenOp where
  show g = genNev g ++ "(bit=" ++ show (genBit g) ++ ")"

||| A 6 kanonikus generátor.
public export
g1, g2, g3, g4, g5, g6 : GenOp
g1 = MkGenOp "G1:harmonia/ter"    1
g2 = MkGenOp "G2:határozottság"   2
g3 = MkGenOp "G3:szám"            4
g4 = MkGenOp "G4:idő"             8
g5 = MkGenOp "G5:mód"             16
g6 = MkGenOp "G6:birtoklás"       32

||| Mind a 6 generátor.
public export
osszesGen : List GenOp
osszesGen = [g1, g2, g3, g4, g5, g6]

||| Bit kinyerése az f. bitből (0 vagy 1).
bitOf6 : Integer -> Integer -> Integer
bitOf6 n f = if mod (div n f) 2 == 1 then 1 else 0

||| XOR két Nat bit maszk között (6 bitre korlátozva = 0–63).
public export
xorNat : Nat -> Nat -> Nat
xorNat a b =
  let ai = the Integer (cast a)
      bi = the Integer (cast b)
      z1 = mod (bitOf6 ai 1 + bitOf6 bi 1) 2
      z2 = mod (bitOf6 ai 2 + bitOf6 bi 2) 2
      z3 = mod (bitOf6 ai 4 + bitOf6 bi 4) 2
      z4 = mod (bitOf6 ai 8 + bitOf6 bi 8) 2
      z5 = mod (bitOf6 ai 16 + bitOf6 bi 16) 2
      z6 = mod (bitOf6 ai 32 + bitOf6 bi 32) 2
  in cast (z1 + 2*z2 + 4*z3 + 8*z4 + 16*z5 + 32*z6)

||| Popcount: aktív bitek száma egy 6 bites maszkon.
public export
popcount6 : Nat -> Nat
popcount6 n =
  let ni = the Integer (cast n)
      b1 = the Nat (cast (bitOf6 ni 1))
      b2 = the Nat (cast (bitOf6 ni 2))
      b4 = the Nat (cast (bitOf6 ni 4))
      b8 = the Nat (cast (bitOf6 ni 8))
      b16 = the Nat (cast (bitOf6 ni 16))
      b32 = the Nat (cast (bitOf6 ni 32))
  in b1 + b2 + b4 + b8 + b16 + b32

-- =====================================================================
-- 2. rész: Az 1D magyar szó ket operátor lánccal.
--
-- |word⟩ = Ĝₙ ... Ĝ₂ Ĝ₁ |tő⟩
--
-- A Magyar.idr Elemzes rekordja már megadja a tőt és a feature maszkot.
-- Dirac jelölésbe csomagoljuk.
-- =====================================================================

||| Egy magyar 1D ket: tő + teljes feature maszk + toldalék lánc.
||| Ez a morfológiaiailag elemzett szó Dirac reprezentációja.
public export
record Ket1D where
  constructor MkKet1D
  ketTorzs  : String     -- |tő⟩
  ketFeat   : Nat        -- teljes feature maszk (összes toldalék XOR-ja)
  ketLanc   : List String  -- alkalmazott toldalék nevek, balról jobbra
  ketHarm   : Hangharmonia  -- a tő hangzóharmóniája

||| Magyar Elemzes → Dirac ket átalakítás.
public export
elemzesToKet : Elemzes -> Ket1D
elemzesToKet e =
  let toldNevek = map (\x => nev (fst x)) (szegmensek e)
  in MkKet1D (torzs e) (teljesFeat e) toldNevek (harmonia e)

||| Sztringek összefűzése ", "-el.
osszefuz : List String -> String
osszefuz [] = ""
osszefuz [x] = x
osszefuz (x :: xs) = x ++ ", " ++ osszefuz xs

||| 1D ket szép kiírása Dirac jelölésben.
||| Példa: "|ház⟩ · Ĝ(Tb,Iness)  feat=5"
public export
showKet1D : Ket1D -> String
showKet1D k =
  "|" ++ ketTorzs k ++ "⟩ · Ĝ(" ++ osszefuz (ketLanc k) ++ ")  " ++
  "feat=" ++ show (ketFeat k) ++ "  harm=" ++ show (ketHarm k)

-- =====================================================================
-- 3. rész: A 3D szorzat ket = Kínai 2D ⊗ Magyar 1D.
-- =====================================================================

||| Egy 3D nyelvi elem: egy kínai karakter és egy magyar szó párosítása.
|||
||| |Ψ⟩ = |char⟩ ⊗ |word⟩
|||
||| A kínai rész az ÁLLAPOTot kódolja (mi — főnév/koncepció 2D térben).
||| A magyar rész a MORFIZMUST kódolja (hogyan — toldalékolás/kapcsolat 1D-ben).
public export
record Ket3D where
  constructor MkKet3D
  char2D   : Karakter2D    -- |char⟩ ∈ H²ᴰ (kínai 2D állapot)
  word1D   : Ket1D        -- |word⟩ ∈ H¹ᴰ (magyar 1D operátor-lánc állapot)
  horgony   : String       -- közös szemantikai horgony, pl. "ház/lakás"

||| 3D ket szép kiírása.
public export
showKet3D : Ket3D -> String
showKet3D k =
  "Ψ = |" ++ alak (char2D k) ++ "⟩ ⊗ |" ++ ketTorzs (word1D k) ++ "⟩\n" ++
  "  karakter: " ++ showKarakter2D (char2D k) ++ "\n" ++
  "  szó: " ++ showKet1D (word1D k) ++ "\n" ++
  "  horgony: " ++ horgony k

-- =====================================================================
-- 4. rész: Szótípus-függő távolság metrica.
--
-- A KULCS FELISMERÉS: a távolság NEM egységes a szótípusok között.
-- Különböző szótípusok különböző metrikákat használnak különböző csatornákon.
--
-- FŐNÉV/ÁLLAPOT szavak (kínai karakterek):
--   d = strukturális szerkesztési távolság 2D radical-rácsban
--   d = radicalCserák + kompozícióTípusVáltozás
--
-- MORFIZMUS/MŰVELET szavak (magyar toldalék láncok):
--   d = feature maszkok XOR-ja (generátor-tér strukturális távolsága)
--   d = popcount(feat1 ⊕ feat2)
--
-- 3D szorzatra:
--   d3D = α · d2D + β · d1D
--   ahol α, β a szótípusfüggő súlyok.
-- =====================================================================

||| Szótípus osztályozás — meghatározza, mely távolság metrica érvényes.
public export
data Szotipus = FonevAllapot | MorfMuvelet | Kapcsolat | AllapotModosito

public export
Show Szotipus where
  show FonevAllapot    = "Főnév/Állapot(2D)"
  show MorfMuvelet     = "Morfizmus/Művelet(1D)"
  show Kapcsolat       = "Kapcsolat(gráf)"
  show AllapotModosito = "ÁllapotMódosító(feat)"

||| Távolság súlypár: (alpha_2D, beta_1D).
||| Szótípusfüggő: a főnevek a 2D szerkezetet súlyozzák, az igék az 1D morfológiát.
public export
tavolsagSulyok : Szotipus -> (Nat, Nat)
tavolsagSulyok FonevAllapot    = (3, 1)  -- főnevek: 2D szerkezet dominál
tavolsagSulyok MorfMuvelet     = (1, 3)  -- igék: 1D morfológia dominál
tavolsagSulyok Kapcsolat       = (1, 2)  -- kapcsolatok: morfológia mérsékelt
tavolsagSulyok AllapotModosito = (2, 2)  -- melléknevek: kiegyensúlyozott

||| 1D távolság: feature maszkok XOR + tő szerkesztési költség.
public export
tavolsag1D : Ket1D -> Ket1D -> Nat
tavolsag1D k1 k2 =
  let featTav = popcount6 (xorNat (ketFeat k1) (ketFeat k2))
      torzsTav = if ketTorzs k1 == ketTorzs k2 then 0 else 1
  in featTav + torzsTav

||| Teljes 3D távolság: szótípusfüggő súlyozott összeg.
|||
||| d3D(Ψ1, Ψ2, τ) = α(τ) · d2D(char1, char2) + β(τ) · d1D(word1, word2)
|||
||| ahol τ a szótípus és (α,β) = tavolsagSulyok(τ).
public export
tavolsag3D : Szotipus -> Ket3D -> Ket3D -> Nat
tavolsag3D st k1 k2 =
  let (alpha, beta) = tavolsagSulyok st
      d2 = tavolsag2D (char2D k1) (char2D k2)
      d1 = tavolsag1D (word1D k1) (word1D k2)
  in alpha * d2 + beta * d1

-- =====================================================================
-- 5. rész: CPT involúció a 3D nyelven.
--
-- CPT hatása: CPT|Ψ⟩ = Θ|char⟩ ⊗ Θ̂|word⟩
--
-- Kínai oldalon: CPT = kompozíciótípus megfordítás
--   (bal-jobb ↔ jobb-bal, felül-alul → alul-felül).
--   Ez a térbeli paritás művelet P.
--
-- Magyar oldalon: CPT = feature maszk invertálás XOR 37-tel:
--   Θ̂|szo, feat⟩ = |szo, feat ⊕ 37⟩
--   Ez a töltés konjugáció C és időfordítás T kombinációja.
--
-- CPT² = I (involutió), mert 37 ⊕ 37 = 0.
-- =====================================================================

||| CPT maszk = G1 ⊕ G3 ⊕ G6 = bitek 0,2,5 = 37.
public export
cptMaszk : Nat
cptMaszk = 37

||| CPT hatása 1D ketre: feature maszk XOR 37.
||| CPT² = identitás, mert xor 37 37 = 0.
public export
cpt1D : Ket1D -> Ket1D
cpt1D k = { ketFeat := xorNat (ketFeat k) cptMaszk } k

||| CPT hatása 2D karakterre: térbeli kompozíció megfordítás.
||| Bal-Jobb ↔ Jobb-Bal, Felül-Alul → Alul-Felül.
||| (Egyszerűsített modellben identitás.)
public export
cpt2D : Karakter2D -> Karakter2D
cpt2D c = c  -- térbeli paritás triviális ebben a modellben

||| Teljes CPT 3D keten.
public export
cpt3D : Ket3D -> Ket3D
cpt3D k = { char2D := cpt2D (char2D k), word1D := cpt1D (word1D k) } k

-- =====================================================================
-- 6. rész: Bizonyítás-hordozó szerkezet.
-- =====================================================================

%default total

||| CPT involúció a feature maszkokon: CPT²(f) = f.
||| Bizonyítás: xor (xor f 37) 37 = xor f (xor 37 37) = xor f 0 = f.
||| Kulcs lemma: xor 37 37 = 0.
export
cptNejzetMaszk : xorNat 37 37 = 0
cptNejzetMaszk = Refl

||| Az állapottér dimenziója: 432 = 2⁴ × 3³.
||| Az érvényes magyar morfológiai állapotok száma.
export
allapotTerDim : Nat
allapotTerDim = 432

||| Bizonyítás: 16 × 27 = 432.
export
allapotTerBizonyitas : 16 * 27 = 432
allapotTerBizonyitas = Refl

||| PSL(2,7) rendje = 168 = 8 × 3 × 7.
||| A 7 Fano-ponton (kínai kompozíciós típusokon) hat.
export
pslRend : Nat
pslRend = 168

export
pslRendBizonyitas : 8 * 3 * 7 = 168
pslRendBizonyitas = Refl

||| Teljes 3D állapottér: 432 (magyar) × 7 (kínai Fano-pont)
||| = 3024 főorbita. (Nem számolva a radical sokszínűséget.)
export
teljesDim3D : Nat
teljesDim3D = 432 * 7

||| Bizonyítás: 432 × 7 = 3024.
export
teljesDim3DBizonyitas : 432 * 7 = 3024
teljesDim3DBizonyitas = Refl
