module JelentésTérDisCoCat_v1_Szima

import Decidable.Equality

%default total

-- ============================================================
-- idris-mag / T3: JelentésTér — a jelentés mint gravitáció
-- ============================================================
-- Joco irányelve (2026-08-24):
--   "a jelentés maga nem más mint egy hierarchikus bayes háló"
--   "a hálót a geometria fogja megadni, az összefonódás"
--   "az asszociációk adják meg a jelentést"
--   "a jelentés maga a gravitáció... a szavaknak tömege van"
--   "a fekete lyukak ideális szkramblerek... lehet, hogy ők
--    lennének a memória? az asszociáció? a megoldás?"
--
-- Kutatási alapok:
--   DisCoCat (Coecke–Sadrzadeh–Clark 2010)
--   ER=EPR (Maldacena–Susskind 2013, arXiv:1306.0533)
--   Fast Scramblers (Sekino–Susskind 2008, arXiv:0808.2096)
--   Predictive coding (Friston–Kiebel 2009)
--   Holografikus memória (Pribram 1973)
-- ============================================================

-- -----------------------------------------------------------
-- 1. Szó — tömeggel
-- -----------------------------------------------------------
||| Egy szó: azonosító és tömeg.
||| Tömeg = szemantikai volumen (hány fogalmat fed).
public export
record Szó where
  constructor SzóKészít
  ||| A szó kódja (neve).
  azonosító : Nat
  ||| Szemantikai volumen: 0 = üres, nagyobb = tágabb fogalom.
  tömeg     : Nat

%name Szó w, w'

-- -----------------------------------------------------------
-- 2. Asszociáció — él két szó között
-- -----------------------------------------------------------
||| Asszociációs él: honnan -> hová, adott erősséggel.
||| Ez hordozza az összefonódást (ER=EPR belső oldala).
public export
record Asszociáció where
  constructor ÉlKészít
  honnan   : Nat
  hová     : Nat
  erősség  : Nat

%name Asszociáció e, e'

-- -----------------------------------------------------------
-- 3. Haló — hierarchikus asszociációs háló
-- -----------------------------------------------------------
||| A jelentéstér váza: szavak + élek + hierarchia-mélység.
public export
record Haló where
  constructor HalóKészít
  szavak       : List Szó
  élek         : List Asszociáció
  mélység      : Nat

%name Haló h, h'

-- -----------------------------------------------------------
-- 4. Evidencia — bejövő információ
-- -----------------------------------------------------------
||| Bejövő információ: megfigyelt szókódok sorozata (mondat).
public export
Evidencia : Type
Evidencia = List Nat

-- -----------------------------------------------------------
-- 5. Posterior — hisztogram, a jelentés diszkrét alakja
-- -----------------------------------------------------------
||| Hisztogram: (szókód, darabszám) párok.
public export
Posterior : Type
Posterior = List (Nat, Nat)

||| Egy szókód darabszámának növelése.
export
növeld : Nat -> Posterior -> Posterior
növeld k [] = [(k, 1)]
növeld k ((kód, db) :: maradék) =
  if k == kód
    then (kód, S db) :: maradék
    else (kód, db) :: növeld k maradék

||| Bayes-frissítés: az evidencia minden szava növeli a számát.
||| Új információ érkezik -> a posterior eltolódik -> ÚJ JELENTÉS.
export
frissít : Evidencia -> Posterior -> Posterior
frissít [] hs = hs
frissít (k :: ks) hs = frissít ks (növeld k hs)

||| Tétel: üres evidencia nem változtatja a posteriórt.
export
üresEvidenciaSemmi : (hs : Posterior) -> frissít [] hs = hs
üresEvidenciaSemmi hs = Refl

-- -----------------------------------------------------------
-- 6. Súly — a tömeg a mezőben (W = m·g)
-- -----------------------------------------------------------
||| A szó súlya = mező-erő × tömeg.
||| (A szorzás a nullával: 0 * m redukálódik azonnal.)
export
súly : Szó -> Nat -> Nat
súly w mezőErő = mezőErő * tömeg w

||| Tétel: nulla mezőben minden szó súlya nulla.
||| Kontextus nélkül a szó nem "nyom".
export
súlytalanMező : (w : Szó) -> súly w 0 = 0
súlytalanMező w = Refl

-- -----------------------------------------------------------
-- 7. Vonzás — gravitáció két szó között
-- -----------------------------------------------------------
||| Illeszkedik-e az él az (a -> b) lekérdezésre?
illeszkedik : Asszociáció -> Nat -> Nat -> Bool
illeszkedik e a b = (honnan e == a) && (hová e == b)

||| Két szó vonzása: az összes illeszkedő él erősségének összege.
||| Diszkrét gravitáció: az él maga a "féreglyuk".
export
vonzás : Haló -> Nat -> Nat -> Nat
vonzás h a b = összegzés (élek h)
  where
    összegzés : List Asszociáció -> Nat
    összegzés [] = 0
    összegzés (e :: többi) =
      if illeszkedik e a b
        then erősség e + összegzés többi
        else összegzés többi

-- -----------------------------------------------------------
-- 8. Geodézika — legrövidebb asszociációs út
-- -----------------------------------------------------------
||| Két szó közti minimális lépésszám (BFS üzemanyaggal,
||| távolság-címkés változat).
||| Ugyanaz a szó: 0. Nincs út / elfogyott az üzemanyag: 999.
export
útHossz : Haló -> Nat -> Nat -> Nat
útHossz h a b = keress 64 [(a, 0)]
  where
    szomszédok : Nat -> List Nat
    szomszédok x = szed (élek h)
      where
        szed : List Asszociáció -> List Nat
        szed [] = []
        szed (e :: többi) =
          if honnan e == x
            then hová e :: szed többi
            else szed többi

    tagjaE : Nat -> List Nat -> Bool
    tagjaE _ [] = False
    tagjaE x (y :: ys) = if x == y then True else tagjaE x ys

    újak : Nat -> List Nat -> List Nat -> List (Nat, Nat)
    újak _ [] _ = []
    újak dx (x :: xs) látottak =
      if tagjaE x látottak
        then újak dx xs látottak
        else (x, dx) :: újak dx xs látottak

    ||| Üzemanyag-paraméteres BFS: minden lépésben fogy.
    ||| A várakozók (szókód, távolság) párok; indulás: [(a, 0)].
    keress : Nat -> List (Nat, Nat) -> Nat
    keress Z _ = 999
    keress (S f) várakozók =
      case várakozók of
        [] => 999
        ((x, dx) :: többi) =>
          if x == b
            then dx
            else let u = újak (S dx) (szomszédok x) (map fst várakozók)
                 in keress f (többi ++ u)

-- -----------------------------------------------------------
-- 9. Összefonódás — a mondat belső köteléke
-- -----------------------------------------------------------
||| Az evidencia összefonódottsága: egymás melletti szavak
||| vonzásainak összege. (ER=EPR belső sűrűség.)
export
összefonódás : Haló -> Evidencia -> Nat
összefonódás h [] = 0
összefonódás h [_] = 0
összefonódás h (a :: b :: maradék) =
  vonzás h a b + összefonódás h (b :: maradék)

||| Tétel: egyszavas mondat összefonódása nulla.
export
egySzóNincsÖsszefonódás : (h : Haló) -> (w : Nat) ->
  összefonódás h [w] = 0
egySzóNincsÖsszefonódás h w = Refl

-- -----------------------------------------------------------
-- 10. Példa-háló és tételek
-- -----------------------------------------------------------
||| Minta: alma—piros (7), alma—eszik (4), piros—autó (1).
export
mintahaló : Haló
mintahaló = HalóKészít
  [ SzóKészít 1 5, SzóKészít 2 2, SzóKészít 3 3, SzóKészít 4 1 ]
  [ ÉlKészít 1 2 7, ÉlKészít 1 3 4, ÉlKészít 2 4 1 ]
  2

||| Nagybetűs alias a bizonyítás-típusoknak
||| (a kisbetűs-név-a-típusban csapda ellen).
export
MintaHaló : Haló
MintaHaló = mintahaló

||| Tétel: alma—piros vonzása 7 (az él erőssége).
bizVonzásAlmaPiros : vonzás MintaHaló 1 2 = 7
bizVonzásAlmaPiros = Refl

||| Tétel: alma—autó közt nincs közvetlen él: 0.
bizVonzásAlmaAutó : vonzás MintaHaló 1 4 = 0
bizVonzásAlmaAutó = Refl

||| Tétel: az "alma, piros" mondat összefonódása 7
||| (az él alma->piros irányú).
bizÖsszefonódásAlmaPiros : összefonódás MintaHaló [1, 2] = 7
bizÖsszefonódásAlmaPiros = Refl

||| Tétel: a súly skálázódik a mezővel (W = m·g).
bizSúlyNő : súly (SzóKészít 1 5) 3 = 15
bizSúlyNő = Refl
