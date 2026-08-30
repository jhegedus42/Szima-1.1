module Carnot

import Data.Vect
import Fazis
import Lagrangian

-- =====================================================================
-- CARNOT modul: entropia kezelés = koherencia-őrzés.
--
-- Carnot-hűtőgép: T_meleg (zaj) ↔ T_hideg (koherencia).
-- η = 1 - T_hideg/T_meleg: maximális hatásfok.
-- Ez KORLÁTOZZA a hibajavítást.
--
-- QHMC = Carnot-ciklus alapú mintavételezés.
-- =====================================================================

%default total

-- =====================================================================
-- 1. Entropia.
-- =====================================================================

public export
entropia : Allapot -> Double
entropia allap =
  let egyedi = length (nub (toList (fazisok allap)))
  in log (cast egyedi + 1.0) / log 9.0
  where
    nub : Eq t => List t -> List t
    nub [] = []
    nub (x :: xs) = if x `elem` xs then nub xs else x :: nub xs

-- =====================================================================
-- 2. Carnot-hatásfok.
-- =====================================================================

public export
carnotHataskor : Double -> Double -> Double
carnotHataskor tMeleg tHideg = 1.0 - (tHideg / tMeleg)

-- =====================================================================
-- 3. Hőmérséklet és koherencia.
-- =====================================================================

public export
koherenciaHomerseklet : Allapot -> Double
koherenciaHomerseklet a = 1.0 + entropia a

-- =====================================================================
-- 4. Termodinamikai hibajavítás (4. kategória).
--
-- A Carnot-hatásfok megmondja, hány eltérő fazist cserélünk a cél felé.
-- hatasfok = 1 - T_hideg/T_meleg → [0,1]
-- Ennyi hányadát az eltérő fazisoknak kicseréljük.
-- =====================================================================

||| Termodinamikai hibajavítás: hatasfok arányában cserélünk eltérő fazisokat.
||| Elsőként összegyűjtjük, melyik pozíciók térnek el, majd az első `darab`-ot
||| kicseréljük a cél értékére.
public export
termodinamikaiJavitas : Allapot -> Allapot -> Double -> Double -> Allapot
termodinamikaiJavitas jelenlegi cel tMeleg tHideg =
  let
    hatasfok = carnotHataskor tMeleg tHideg
    ak = fazisok jelenlegi
    ce = fazisok cel
    -- Első 8 Fin pozíció
    finPozik = [FZ, FS FZ, FS (FS FZ), FS (FS (FS FZ)),
                FS (FS (FS (FS FZ))), FS (FS (FS (FS (FS FZ)))),
                FS (FS (FS (FS (FS (FS FZ))))),
                FS (FS (FS (FS (FS (FS (FS FZ))))))]
    -- Mely pozíciók térnek el?
    elterok = filter (\i => index i ak /= index i ce) finPozik
    -- Hány cserét enged a Carnot-hatásfok?
    osszesElt = hatasfok * 8.0
    darabNat = the Nat (cast {from=Double} osszesElt)
    darab = min darabNat (length elterok)
    ujFazisok = csereDarab darab ak ce elterok
  in MkAllapot ujFazisok (ido jelenlegi)
  where
    ||| darab db pozíciót kicserélünk a `elterok` listából.
    csereDarab : Nat -> Vect 8 Fazis -> Vect 8 Fazis -> List (Fin 8) -> Vect 8 Fazis
    csereDarab 0 v _ _ = v
    csereDarab _ v _ [] = v
    csereDarab n v ce (p :: ps) =
      let v' = updateAt p (const (index p ce)) v
      in csereDarab (minus n 1) v' ce ps

-- =====================================================================
-- 5. Algebrai hibajavítás (2. kategória: Steane).
--
-- A Steane [[7,1,3]] kód: 7 bites vektor, 3-as távolság.
-- Hibajavítás: ha egyetlen bit hibás → szindrómák alapján
--azonosítjuk, melyik, és javítjuk.
--
-- A 7 dimenzió: {idő, okság, tér, szín, hang, fázis, mód}
-- (l. Steane7Bit a MagasabbRendszer.modulban)
--
-- Szindróma számítás:
--   s1 = b1 ⊕ b2 ⊕ b4 ⊕ b6   (idő, tér, hang, fázis)
--   s2 = b1 ⊕ b3 ⊕ b5 ⊕ b6   (idő, okság, szín, fázis)
--   s3 = b2 ⊕ b3 ⊕ b5 ⊕ b6   (tér, okság, szín, fázis)
-- Ha s1=s2=s3=0 → nincs hiba.
-- Ha nem → a szindróma értéke = a hibás pozíció indexe (1-7).
--
-- A javítás: a hibás pozíciót a cél értékére állítjuk.
-- =====================================================================

||| Bit érték kinyerése: ha a fazis = F0, akkor 0, különben 1.
public export
fazisBit : Fazis -> Nat
fazisBit F0 = 0
fazisBit _ = 1

||| XOR két bit között (csak 0 és 1, minden más 0).
public export
xorBit : Nat -> Nat -> Nat
xorBit 0 0 = 0
xorBit 0 1 = 1
xorBit 1 0 = 1
xorBit 1 1 = 0
xorBit _ _ = 0

||| 8-elemű Vect cseréje: updateAt használatával.
public export
csereFazis : Fin 8 -> Fazis -> Vect 8 Fazis -> Vect 8 Fazis
csereFazis poz uj v = updateAt poz (const uj) v

||| Nat → Fin 8 konverzió (ha >=8, akkor FZ).
public export
natToFin8 : Nat -> Fin 8
natToFin8 0 = FZ
natToFin8 1 = FS FZ
natToFin8 2 = FS (FS FZ)
natToFin8 3 = FS (FS (FS FZ))
natToFin8 4 = FS (FS (FS (FS FZ)))
natToFin8 5 = FS (FS (FS (FS (FS FZ))))
natToFin8 6 = FS (FS (FS (FS (FS (FS FZ)))))
natToFin8 _ = FS (FS (FS (FS (FS (FS (FS FZ))))))

||| Szindróma számítás: 3 szindróma bit a 7 Steane-ből.
||| A szindróma a CEL-hez képesti eltérést méri:
|||   eltérés[i] = fazisBit(aktuális[i]) XOR fazisBit(cél[i])
|||   s1 = e[0] XOR e[2] XOR e[4] XOR e[6]   (idő, tér, hang, fázis)
|||   s2 = e[0] XOR e[1] XOR e[4] XOR e[5]   (idő, okság, szín, fázis)
|||   s3 = e[1] XOR e[2] XOR e[4] XOR e[5]   (tér, okság, szín, fázis)
||| Ha s1=s2=s3=0 → nincs hiba vagy páros hiba (javíthatatlan 1-bit korrekcióval).
public export
szindroma : Vect 8 Fazis -> Vect 8 Fazis -> (Nat, Nat, Nat)
szindroma akt c =
  let e = zipWith (\a, b => xorBit (fazisBit a) (fazisBit b)) akt c
      s1 = xorBit (index 0 e) (xorBit (index 2 e) (xorBit (index 4 e) (index 6 e)))
      s2 = xorBit (index 0 e) (xorBit (index 1 e) (xorBit (index 4 e) (index 5 e)))
      s3 = xorBit (index 1 e) (xorBit (index 2 e) (xorBit (index 4 e) (index 5 e)))
  in (s1, s2, s3)

||| Szindróma → hibás pozíció indexe (0-alapú, 7 = nincs hiba).
public export
szindromaPozicio : (Nat, Nat, Nat) -> Nat
szindromaPozicio (0, 0, 0) = 7   -- nincs hiba
szindromaPozicio (1, 0, 0) = 0   -- 1. bit: idő
szindromaPozicio (0, 1, 0) = 1   -- 2. bit: okság
szindromaPozicio (1, 1, 0) = 2   -- 3. bit: tér
szindromaPozicio (0, 0, 1) = 3   -- 4. bit: szín
szindromaPozicio (1, 0, 1) = 4   -- 5. bit: hang
szindromaPozicio (0, 1, 1) = 5   -- 6. bit: fázis
szindromaPozicio (1, 1, 1) = 6   -- 7. bit: mód
szindromaPozicio _         = 7   -- ismeretlen → nincs javítás

||| Algebrai hibajavítás: Steane szindróma alapú.
||| Ha egyetlen fazis hibás → kijavítjuk a cél értékére.
public export
algebraiJavitas : Allapot -> Allapot -> Allapot
algebraiJavitas jelenlegi cel =
  let (s1, s2, s3) = szindroma (fazisok jelenlegi) (fazisok cel)
      hibaPozicio = szindromaPozicio (s1, s2, s3)
      celFazisok = fazisok cel
      ujFazisok = if hibaPozicio == 7
                     then fazisok jelenlegi  -- nincs hiba
                     else csereFazis (natToFin8 hibaPozicio) (index (natToFin8 hibaPozicio) celFazisok) (fazisok jelenlegi)
  in MkAllapot ujFazisok (ido jelenlegi)

-- =====================================================================
-- 6. Teljes hibajavítás: 2→3→4 kategória.
--
-- Sorrend: algebrai (Steane) → geometriai (Lagrangian) → termodinamikai (Carnot)
--
-- 2. kategória: szindrómák → hibás fazis azonosítás → javítás.
-- 3. kategória: geometriai eltérés → visszaprojektálás a geodéziára.
-- 4. kategória: Carnot-hatásfok → maximális entropia-csökkentés.
-- =====================================================================

public export
teljesHibajavitas : Allapot -> Allapot -> Allapot
teljesHibajavitas jelenlegi cel =
  let
    szint2 = algebraiJavitas jelenlegi cel
    szint3 = geometriaiJavitas szint2 cel
    szint4 = termodinamikaiJavitas szint3 cel 100.0 1.0
  in szint4

-- =====================================================================
-- 6. QHMC: Quantum Hamiltonian Monte Carlo.
--
-- A leapfrog integrátor a fázistérben halad:
--   p(t+dt/2) = p(t) - (dt/2) * ∇V(q(t))
--   q(t+dt)   = q(t) + dt * p(t+dt/2) / m
--   p(t+dt)   = p(t+dt/2) - (dt/2) * ∇V(q(t+dt))
--
-- Metropolis elfogadás: ΔH = H(új) - H(régi)
--   ha ΔH < 0 → elfogad
--   ha ΔH ≥ 0 → elfogad valószínűséggel e^(-ΔH)
--
-- A Sebesseg: fazisSebesseg : Vect 8 Fazis, idoSebesseg : Double
-- A momentum: 8 fázis-komponens (Z₈-ban).
-- =====================================================================

public export
record QHMCAllapot where
  constructor MkQHMCAllapot
  pozicio  : Allapot
  momentum : Sebesseg

public export
qhmHamiltonian : QHMCAllapot -> Double -> Double
qhmHamiltonian q m =
  let t = 0.5 * tinetikusEnergia (momentum q) / m
      v = -entropia (pozicio q)
  in t + v

||| Gradiens: a potenciális energia (negatív entropia) deriváltja.
||| Közelítés: minden fazis pozícióban ±1 Z₈ lépéssel mérjük az entropiaváltozást.
public export
leapfrogGrad : Allapot -> Sebesseg
leapfrogGrad allap =
  let akt = fazisok allap
      baseE = entropia allap
      g = map (\i => let regi = index i akt
                         uj = fazisOsszead regi F1
                         valt = entropia (MkAllapot (replaceAt i uj akt) (ido allap))
                     in valt - baseE) finPozik
  in MkSebesseg (map dfz g) 0.0
  where
    finPozik : Vect 8 (Fin 8)
    finPozik = [FZ, FS FZ, FS (FS FZ), FS (FS (FS FZ)),
                FS (FS (FS (FS FZ))), FS (FS (FS (FS (FS FZ)))),
                FS (FS (FS (FS (FS (FS FZ))))),
                FS (FS (FS (FS (FS (FS (FS FZ))))))]
    dfz : Double -> Fazis
    dfz d = let n = cast {to=Nat} (the Integer (cast d))
            in case mod n 8 of
                 0 => F0
                 1 => F1
                 2 => F2
                 3 => F3
                 4 => F4
                 5 => F5
                 6 => F6
                 7 => F7
                 _ => F0

||| Fázis-szorzás: Double → Fazis (növeljük a fazist annyival, amennyi a double).
public export
doubleToFazis : Double -> Fazis
doubleToFazis d = let n = cast {to=Nat} (the Integer (cast d))
                  in natToFazis (mod n 8)
  where
    natToFazis : Nat -> Fazis
    natToFazis 0 = F0
    natToFazis 1 = F1
    natToFazis 2 = F2
    natToFazis 3 = F3
    natToFazis 4 = F4
    natToFazis 5 = F5
    natToFazis 6 = F6
    natToFazis 7 = F7
    natToFazis _ = F0

||| Sebesseg szorzás: minden komponenst szorozunk egy Double-lal.
public export
sebessegSzoroz : Double -> Sebesseg -> Sebesseg
sebessegSzoroz k s =
  MkSebesseg (map (\f => fazisOsszead F0 (doubleToFazis (k * cast (fazisIndex f)))) (fazisSebesseg s))
             (k * idoSebesseg s)

||| Sebesseg összeadás.
public export
sebessegOsszead : Sebesseg -> Sebesseg -> Sebesseg
sebessegOsszead a b =
  MkSebesseg (zipWith fazisOsszead (fazisSebesseg a) (fazisSebesseg b))
             (idoSebesseg a + idoSebesseg b)

||| Leapfrog lépés: 1 teljes integrációs lépés (dt időlépés).
public export
leapfrogLepes : QHMCAllapot -> Double -> Double -> QHMCAllapot
leapfrogLepes q m dt =
  let grad1 = leapfrogGrad (pozicio q)
      f1 = fazisok (pozicio q)
      -- fél lépés momentum: p -= 0.5*dt*grad
      félMomentum = sebessegOsszead (momentum q) (sebessegSzoroz (-0.5 * dt) grad1)
      -- teljes lépés pozíció: minden fazis += dt * p / m
      ujFazisok = zipWith (\f, p =>
        let delta = doubleToFazis (dt * cast (fazisIndex p) / m)
        in fazisOsszead f delta) f1 (fazisSebesseg félMomentum)
      ujPoz = MkAllapot ujFazisok (ido (pozicio q))
      -- fél lépés momentum: p -= 0.5*dt*grad2
      grad2 = leapfrogGrad ujPoz
      vegeMom = sebessegOsszead félMomentum (sebessegSzoroz (-0.5 * dt) grad2)
  in MkQHMCAllapot ujPoz vegeMom

||| Metropolis elfogadás: ΔH < 0 → elfogad.
public export
metropolisElfogad : Double -> Double -> Bool
metropolisElfogad deltaH _ = deltaH < 0.0

||| Teljes QHMC lépés: leapfrog + Metropolis.
public export
qhmLepes : QHMCAllapot -> Double -> Double -> Double -> QHMCAllapot
qhmLepes q m dt tMeleg =
  let
    regiH = qhmHamiltonian q m
    ujQ = leapfrogLepes q m dt
    ujH = qhmHamiltonian ujQ m
    deltaH = ujH - regiH
    hatasfok = carnotHataskor tMeleg 1.0
    elfogad = metropolisElfogad deltaH hatasfok
  in if elfogad then ujQ else q

-- =====================================================================
-- 7. Lehetséges mód stabilitása.
-- =====================================================================

public export
lehetsegesModStabilitas : Allapot -> Double -> Double -> Double
lehetsegesModStabilitas a tMeleg tHideg =
  let eta = carnotHataskor tMeleg tHideg
      s = entropia a
  in eta * (1.0 - s)
