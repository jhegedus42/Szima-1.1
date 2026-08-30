module Fizika.Legendre

-- ═══════════════════════════════════════════════════════════════
-- LAGRANGE TRANSZFORMACIO — geometria ⊣ ido
-- ═══════════════════════════════════════════════════════════════
--
-- HAROM KULONBOZO FOGALOM:
--   1. Derivalas:    f → f'   (lokalis valtozas, arany)
--   2. Antiderivalas: f' → f  (inverz muvelet, rekonstrukcio)
--   3. Integralas:   ∫_a^b f  (terulet, globalis osszeg)
--
-- A Fundamentalis Tetel koti ossze oket:
--   ∫_a^b f'(x) dx = f(b) - f(a)
--   Az antiderivalt = integral operator inverze, nem maga az integral.
--
-- LEGENDRE = INTEGRALAS PER PARTES:
--   ∫ u dv = u·v - ∫ v du
--   L = ∫ q̇ dp    (az egyik oldal = Lagrangi-an = geometria)
--   H = ∫ p dq̇    (masik oldal = Hamilton = ido + energia)
--   p·q̇ = perem   (Yoneda-parositas ⟨p, q̇⟩)
--   Legendre: H = p·q̇ - L
--
-- GEOMETRIA ⊣ IDO:
--   Lagrangi-an = GEOMETRIAI (konfiguracios ter, erintobundel TQ)
--     - q es q̇ erintovektorok → geometriai struktura
--     - L(q, q̇) a lehetseges palyak tere (kinematika)
--     - Integralva: S = ∫ L dt (hatas = geometriai mennyiseg)
--   Hamilton = IDOBELI + ENERGIA (fazister, kotangens T*Q)
--     - q es p kotangens vektorok → dinamikai struktura
--     - H(q, p) az idofejlesztes generalora (Noether tetel)
--     - q̇ = ∂H/∂p, ṗ = -∂H/∂q (Hamilton egyenletek = idofejlesztes)
--
--   MEGFORditVA (flipped):
--     L-ben a geometria van eloterben, az ido integralas (S = ∫ L dt)
--     H-ban az ido van eloterben, a geometria szarmaztatott
--       (q es p a fazisterben, az idofejlesztes Hamilton egyenletekkel)
--     Legendre: geometria (L) ↔ ido (H)
--               erintobundel (TQ) ↔ kotangens (T*Q)
--               kinematika ↔ dinamika
--               lehetseges palyak ↔ egyetlen valosagvonal
-- KATEGORIAELMELETBEN:
--   Derivalas = bal adjungalt (F: Konfig → Fazis, megtori a szimmetriat)
--   Antiderivalas = jobb adjungalt (G: Fazis → Konfig, helyreallit)
--   Integralas = a ketto kompozicioja (G∘F vagy F∘G)
--   Legendre = a counit: F(G(p)) → p (a peremtag = Yoneda ertekeles)

||| Derivalt: f'(x) ≈ (f(x+h) - f(x-h)) / (2·h)
public export
derivalt : (Double -> Double) -> Double -> Double
derivalt f x = (f (x + 0.001) - f (x - 0.001)) / 0.002

||| Masodik derivalt: f''(x) = (f')'(x)
public export
masodikDerivalt : (Double -> Double) -> Double -> Double
masodikDerivalt f x = derivalt (\y => derivalt f y) x

||| Hatarozott integral (trapez): ∫_a^b f(x) dx
public export
integral : (Double -> Double) -> Double -> Double -> Double
integral f a b = integralIter f a b 100.0 0.0
  where
    integralIter : (Double -> Double) -> Double -> Double
                   -> Double -> Double -> Double
    integralIter f a b n x =
      case compare x n of
        GT => 0.0
        _  =>
          let dx = (b - a) / n
              xi = a + x * dx + dx / 2.0
              yi = f xi
          in yi * dx + integralIter f a b n (x + 1.0)

||| Antiderivalt: F'(x) = f(x) es F(0) = 0
|||   F(x) = ∫_0^x f(t) dt
|||   Az antiderivalt = integral, de mint FUGGVENY, nem szam.
public export
antiderivalt : (Double -> Double) -> Double -> Double
antiderivalt f x = integral f 0.0 x

||| Fundamental Tetel 1. resz: ∫_a^b f'(x) dx = f(b) - f(a)
public export
fundamentalTetelEgy : Double -> Double -> Double
fundamentalTetelEgy a b =
  integral (derivalt (\x => x * x / 2.0)) a b - (b * b / 2.0 - a * a / 2.0)

||| Fundamental Tetel 2. resz: d/dx ∫_a^x f(t) dt = f(x)
public export
fundamentalTetelKetto : Double -> Double
fundamentalTetelKetto x =
  derivalt (\y => antiderivalt (\t => t * t) y) x - x * x

-- ─── PEREM (a Legendre magja = integralas per partes) ──────────────
-- https://en.wikipedia.org/wiki/Legendre_transformation
-- https://en.wikipedia.org/wiki/Integration_by_parts
-- A Legendre-transzformacio: f*(p) = sup_x (p·x - f(x)).
-- Ket ekvivalens leiras kozotti atvaltas:
--   L(q,q̇) = Lagrange-fuggveny (geometriai, erintobundel TQ)
--   H(q,p) = Hamilton-fuggveny (idobeli, kotangens T*Q)
--   Kapcsolat: H(q,p) = p·q̇ - L(q,q̇)
-- A perem (p·q̇) a Yoneda-parositas: ⟨p, q̇⟩.
-- Integralas per partes: ∫ u dv = u·v - ∫ v du
--   u ← p, dv ← dq̇ (a q̇ integralja)  -- H oldal
--   v ← q̇, du ← dp (a p integralja)   -- L oldal
-- A Legendre = a dual adjunkcio a C es C^op kozott.

||| Perem: u·v = a Yoneda-parositas.
|||   Az integralas per partes formulajaban:
|||     ∫ u dv = u·v - ∫ v du
|||   itt a Legendre = u·v = p·q̇.
public export
perem : Double -> Double -> Double
perem u v = u * v

||| Integralas per partes (Legend formatum):
|||   H = p·q̇ - L
|||   ahol L = ∫ q̇ dp  es  H = ∫ p dq̇
|||
|||   Bizonyitas:
|||     d(p·q̇) = p·dq̇ + q̇·dp
|||     ∫ d(p·q̇) = p·q̇ = ∫ p dq̇ + ∫ q̇ dp = H + L
|||     → H = p·q̇ - L  (a Legendre transzformacio)
public export
integralasPerPartes : Double -> Double -> Double -> Double
integralasPerPartes p qdot l = perem p qdot - l

-- ─── 0. PARITAS — a derivalas es antiderivalas kozotti szimmetria ─

||| Paritas operator: P(f)(x) = f(-x), P² = id
public export
paritas : (Double -> Double) -> Double -> Double
paritas f x = f (-x)

||| L(q, q̇) paritas alatt: q̇ → -q̇, L valtozatlan
|||   T(q̇) = T(-q̇) → L valtozatlan
|||   DE ∂L/∂q̇ → -∂L/∂q̇, tehat p → -p
|||   Az impulzus elojelet valt — itt "tunik el" a paritas.
|||
||| A perem: p·q̇ → (-p)·(-q̇) = p·q̇ (ketszeres valtas = megmaradas)
|||   Ezert a Legendre transzformacio ketszer alkalmazva
|||   visszaadja az eredmenyt: H = p·q̇ - L = (-p)(-q̇) - L
public export
paritasKonfig : (Double -> Double -> Double) -> (Double -> Double -> Double)
paritasKonfig lagrangeFv hely sebesseg = lagrangeFv hely (-sebesseg)

public export
paritasFazis : (Double -> Double -> Double) -> (Double -> Double -> Double)
paritasFazis hamiltonFv hely impulzus = hamiltonFv hely (-impulzus)

-- ─── 1. MECHANIKA ─────────────────────────────────────────────────
-- https://en.wikipedia.org/wiki/Lagrangian_mechanics
-- https://en.wikipedia.org/wiki/Hamiltonian_mechanics
-- A klasszikus mechanika ket ekvivalens leirasa:
--   Lagrange: L(q, q̇) = T(q̇) - V(q)  — kinetikai minusz potencialis energia.
--     A konfiguracios ter (q-k tere) + erintovektorok (q̇).
--     A hatas: S = ∫ L dt. A valosagos palya az, amire δS = 0 (legkisebb hatas elve).
--   Hamilton: H(q, p) = p·q̇ - L(q, q̇)  — a Legendre-transzformalt.
--     A fazister (q-k es p-k tere) + idofejlesztes.
--     Hamilton-egyenletek: q̇ = ∂H/∂p, ṗ = -∂H/∂q.
--     Noether-tetel: minden szimmetriahoz megmarado mennyiseg tartozik.
-- A ket leiras kozott a Legendre-transzformacio teremt kapcsolatot:
--   H(q, p) = sup_q̇ (p·q̇ - L(q, q̇))

||| Lagrange: L(q, q̇) = T - V
|||   Egyszeru harmonikus oszcillator: T = ½q̇², V = ½q².
|||   L = ½q̇² - ½q²
public export
lagrangeMechanika : (hely : Double) -> (sebesseg : Double) -> Double
lagrangeMechanika q qdot = 0.5 * qdot * qdot - 0.5 * q * q

||| Kanonikus impulzus: p = ∂L/∂q̇
|||   Az altalanos impulzus definicioja a Lagrange-formalizmusban.
|||   p = ∂L/∂q̇ = q̇ (a harmonikus oszcillatorra).
|||   Ez az a valtozo amit a Legendre kicserel: q̇ → p.
public export
kanonikusImpulzus : (hely : Double) -> (sebesseg : Double) -> Double
kanonikusImpulzus q qdot = derivalt (\qd => lagrangeMechanika q qd) qdot

||| Hamilton: H(q, p) = p·q̇ - L = T + V
|||   A Legendre-transzformalt: H = ½p² + ½q² (energia = T + V).
|||   A Hamilton a teljes energia, idoben allando ha nincs disszipacio.
|||   Hamilton-egyenletek: q̇ = ∂H/∂p = p, ṗ = -∂H/∂q = -q.
public export
hamiltonMechanika : (hely : Double) -> (impulzus : Double) -> Double
hamiltonMechanika q p = 0.5 * p * p + 0.5 * q * q

||| Legendre: L → H (derivalas + perem)
|||   Altalanos Legendre: tetszoleges L(q,q̇)-bol H(q,p) kepzese.
|||   H(q, p) = p·q̇ - L(q, q̇)  ahol q̇ = g(q, p) az inverz relacio.
|||   Ketzer alkalmazva visszaadja az eredetit: Legendre⁻¹(Legendre(f)) = f.
public export
legendreMechanika : (Double -> Double -> Double) -> (Double -> Double -> Double)
legendreMechanika lagrangeFv hely impulzus =
  let qdot = impulzus
  in perem impulzus qdot - lagrangeFv hely qdot

||| Inverz Legendre: H → L (derivalas + perem — szimmetrikus!)
|||   A Legendre-transzformacio INVERZE onmaga (involucio):
|||   Ha f* = Legendre(f), akkor f = Legendre(f*).
|||   Ez a dualitas: L ↔ H ugyanaz a muvelet mindket iranyban.
public export
legendreInverzMechanika : (Double -> Double -> Double) -> (Double -> Double -> Double)
legendreInverzMechanika hamiltonFv hely impulzus =
  let qdot = impulzus
  in perem impulzus qdot - hamiltonFv hely impulzus

-- ─── 2. TERMODINAMIKA — entropia = idonyil, homerseklet = idosebesseg ──
-- https://en.wikipedia.org/wiki/Thermodynamic_potential
-- https://en.wikipedia.org/wiki/Legendre_transformation#Thermodynamics
-- A termodinamikai potencialok a Legendre-transzformacio klasszikus peldai.
-- Az U(S, V) belso energiahoz tartozo termodinamikai azonossag:
--   dU = T·dS - p·dV  (homerseklet × entropiavaltozas - nyomas × terfogatvaltozas)
-- A Legendre kicsereli a valtozokat: S → T, V → p.
-- Harom termeszetes potencial:
--   F(T,V) = U - T·S  (Helmholtz: S → T, termeszetes valtozok: T, V)
--   H(S,p) = U + p·V  (Entalpia: V → p, termeszetes valtozok: S, p)
--   G(T,p) = U - T·S + p·V  (Gibbs: S→T ES V→p, termeszetes valtozok: T, p)
-- A masodik fotetel: dS/dt ≥ 0 — az entropia nem csokken (idonyil).

||| Belso energia: U(S, V) — a termodinamika alap-potencialja.
|||   Az U teljes differencialja: dU = T·dS - p·dV.
|||   S = entropia (a rendezetlenseg merteke, az idonyil hajtoereje).
|||   V = terfogat (a geometriai kiterjedes).
|||   A homogen idealis gazra: U = c_V·T (csak T-tol fugg).
public export
belsoEnergia : (entropia : Double) -> (terfogat : Double) -> Double
belsoEnergia s v = 0.5 * s * s + v * v

||| Homerseklet: T = ∂U/∂S — a Legendre konjugalt valtozo.
|||   https://en.wikipedia.org/wiki/Temperature
|||   A termodinamikai definicio: 1/T = ∂S/∂U (mikrokanonikus).
|||   A homerseklet az energianak az entropia szerinti derivaltja.
|||   Mas szoval: T azt mutatja, hogy mennyivel no az energia ha az entropia 1 egyseggel no.
|||   A Legendre-peremben: T az "idosebesseg" — az entropia idobeli valtozasat meri.
public export
homerseklet : (entropia : Double) -> (terfogat : Double) -> Double
homerseklet s v = derivalt (\se => belsoEnergia se v) s

||| Nyomas: p = -∂U/∂V — a Legendre konjugalt valtozo (negativ elojellel).
|||   https://en.wikipedia.org/wiki/Pressure
|||   p = -∂U/∂V mert a terfogat NOVEKEDESE csokkenti a belso energiat.
|||   A nyomas a "geometriai ero" a termodinamikaban: a terfogat Legendre-konjugaltja.
public export
nyomas : (entropia : Double) -> (terfogat : Double) -> Double
nyomas s v = (-1.0) * derivalt (\ve => belsoEnergia s ve) v

||| Helmholtz szabadenergia: F(T, V) = U - T·S
|||   https://en.wikipedia.org/wiki/Helmholtz_free_energy
|||   Legendre: S → T. A termeszetes valtozok: (T, V).
|||   dF = -S·dT - p·dV.
|||   F = a maximalis hasznos munka allando homersekleten.
|||   Mechanikai analogia: F olyan mint a Lagrange — homerseklet-fuggo potencial.
public export
helmholtzEnergia : (homerseklet : Double) -> (terfogat : Double) -> Double
helmholtzEnergia t v = (-0.5) * t * t + v * v

||| Entalpia: H(S, p) = U + p·V
|||   https://en.wikipedia.org/wiki/Enthalpy
|||   Legendre: V → p. A termeszetes valtozok: (S, p).
|||   dH = T·dS + V·dp.
|||   H = a rendszer homennyisege allando nyomason.
|||   Mechanikai analogia: H olyan mint a Hamilton — nyomas-fuggo potencial.
public export
entalpia : (entropia : Double) -> (nyomas : Double) -> Double
entalpia s p = (-0.5) * s * s + p * p

||| Gibbs szabadenergia: G(T, p) = U - T·S + p·V
|||   https://en.wikipedia.org/wiki/Gibbs_free_energy
|||   Dupla Legendre: S→T ES V→p. A termeszetes valtozok: (T, p).
|||   dG = -S·dT + V·dp.
|||   G = a maximalis hasznos munka allando homersekleten ES nyomason.
|||   A kemiai potencial = ∂G/∂n. A fazisatmenetek G minimalizaljak.
|||   A Legendre-peremben: G a "teljes Legendre" — mindket valtozo kicserelve.
public export
gibbsEnergia : (homerseklet : Double) -> (nyomas : Double) -> Double
gibbsEnergia t p = (-0.5) * t * t + p * p

||| Legendre (termodinamika): U(S,V) → F(T,V)
|||   S → T: entropiat homersekletre csereljuk.
|||   Ez a "termikus Legendre": ido dimenzio csere.
public export
legendreTermodinamika : (Double -> Double -> Double) -> (Double -> Double -> Double)
legendreTermodinamika u t v =
  let s = t  -- linearis modell: T = S
  in perem t s - u s v

||| Inverz Legendre (termodinamika): F → U
public export
legendreInverzTermodinamika : (Double -> Double -> Double) -> (Double -> Double -> Double)
legendreInverzTermodinamika f s v =
  let t = s
  in perem s t - f t v

||| Legendre (entalpia): U(S,V) → H(S,p)
|||   V → p: terfogatot nyomasra csereljuk.
|||   Ez a "geometriai Legendre": ter dimenzio csere.
public export
legendreEntalpia : (Double -> Double -> Double) -> (Double -> Double -> Double)
legendreEntalpia u s p =
  let v = (-1.0) * p  -- linearis modell: p = -V
  in (-1.0) * perem p v - u s v

||| Legendre (Gibbs): U(S,V) → G(T,p)
|||   S → T, V → p: mindket dimenzio csereljuk.
|||   = termikus + geometriai Legendre = teljes Legendre.
|||   G = perem(t, s) + (-1)*perem(p, v) - u(s, v)
public export
legendreGibbs : (Double -> Double -> Double) -> Double -> Double -> Double
legendreGibbs u t p =
  let s = t
      v = (-1.0) * p
  in perem t s + (-1.0) * perem p v - u s v

||| Entropia: S = -∂F/∂T
|||   A homerseklet szerinti derivalt visszaadja az entropiat.
|||   Ez a termodinamikai "idonyil" egyenlet.
public export
entropia : (homerseklet : Double) -> (terfogat : Double) -> Double
entropia t v = (-1.0) * derivalt (\te => helmholtzEnergia te v) t

||| Masodik fotetel: dS/dt ≥ 0
|||   Az entropia nem csokkenhet — az ido egyiranyusaga.
|||   A Legendre transzformacio ezt a szimmetriat is megforditja:
|||   U-ban S novekszik (ido elore), F-ben T csokken (ido hatra).
|||   Ez a CPT T invarianciaja: idoforditas = Legendre.
public export
masodikFoTetel : Double -> Double -> Double
masodikFoTetel t v = derivalt (\te => entropia te v) t

-- ─── 2B. TOMEG-ENERGIA (E = mc² mint Legendre) ─────────────────────

||| Tomeg-energia ekvivalencia: E = m·c²
|||   A tomeg a "geometriai" forma (Lagrange-szerű)
|||   Az energia az "idobeli" forma (Hamilton-szerű)
|||   A Legendre: E ↔ m·c²
|||   Itt c² a "perem" = a ket leiras kozotti atvaltas.
|||
|||   Relativitas: E² = (pc)² + (mc²)²
|||     A Legendre transzformacio itt:
|||       L = -mc²√(1 - v²/c²) (Lagrange)
|||       H = γ·mc² (Hamilton = E)
|||       p = γ·m·v = ∂L/∂v (kanonikus impulzus)
|||       H = p·v - L = γ·mc² = E
public export
fenysebessegNegyzet : Double
fenysebessegNegyzet = 299792458.0 * 299792458.0

||| Tomeg → energia: E = m·c²
public export
tomegbolEnergia : Double -> Double
tomegbolEnergia tomeg = tomeg * fenysebessegNegyzet

||| Energia → tomeg: m = E/c²
public export
energiabolTomeg : Double -> Double
energiabolTomeg energia = energia / fenysebessegNegyzet

||| Relativisztikus Lagrange: L = -mc²√(1 - v²/c²)
public export
relLagrange : Double -> Double -> Double
relLagrange m v = (-1.0) * m * fenysebessegNegyzet * sqrt (1.0 - v * v / fenysebessegNegyzet)

||| Relativisztikus impulzus: p = ∂L/∂v = γ·m·v
public export
relImpulzus : Double -> Double -> Double
relImpulzus m v = (m * v) / sqrt (1.0 - v * v / fenysebessegNegyzet)

||| Relativisztikus Hamilton: H = γ·m·c² = E
|||   H = p·v - L = γ·m·c²
public export
relHamilton : Double -> Double -> Double
relHamilton m v =
  let gamma = 1.0 / sqrt (1.0 - v * v / fenysebessegNegyzet)
  in gamma * m * fenysebessegNegyzet

-- ─── 2C. ALTALANOS RELATIVITASELMELET (ADM formalizmus) ──────────

||| Einstein-Hilbert akcio: S = ∫ R √(-g) d⁴x
|||   R = Ricci skalar = gorbelet
|||   A Lagrangi-an: L = R √(-g) (geometriai)
|||   Ez a "geometriai hatarerteke" a fizikanak.
public export
einsteinHilbertLagrange : Double -> Double -> Double
einsteinHilbertLagrange ricciScalar metrikDeterminans =
  ricciScalar * sqrt (-metrikDeterminans)

||| ADM Hamilton-fuggveny (3+1 felbontas):
|||   H = ∫ (N·H + N_i·H^i) d³x
|||   N = lapse (ido), N_i = shift (ter)
|||   H = Hamilton-feltetel (energia), H^i = impulzus-feltetel
|||   A Legendre transzformacio: L(R) → H(H, H^i)
|||   Itt a geometria (R) az ido (N, N_i) valtozova valik.
public export
admHamilton : Double -> Double -> Double -> Double -> Double
admHamilton lapse shift energiaFeltetel impulzusFeltetel =
  lapse * energiaFeltetel + shift * impulzusFeltetel

||| Einstein egyenlet mint Legendre:
|||   G_μν = 8πG·T_μν
|||   Bal: geometria (R_μν - ½Rg_μν) = Lagrange-szerű
|||   Jobb: energia-impulzus = Hamilton-szerű
|||   A ket oldal kozott: Legendre transzformacio (G = 8π·T atvaltas)
public export
einsteinEgyenlet : Double -> Double -> Double -> Double
einsteinEgyenlet gorbelet energiaImpulzus gravitaciosAllando =
  gorbelet - 8.0 * pi * gravitaciosAllando * energiaImpulzus
  -- nullanak kell lennie: G_μν - 8πG·T_μν = 0

||| Fekete lyuk termodinamika:
|||   S_BH = A/4ℓ_p² (Bekenstein-Hawking entropia)
|||   T_BH = κ/2π (Hawking hőmerseklet)
|||   dM = T·dS (elso fotetel)
|||   Itt a Legendre: M(S) ↔ M(T) — tomeg ↔ hőmerseklet
|||   A fekete lyuk = Legendre transzformacio a gravitacio es
|||   a kvantummechanika kozott.
public export
bekensteinHawkingEntropia : Double -> Double
bekensteinHawkingEntropia horizontTerulet = horizontTerulet / 4.0

public export
feketeLyukElsoFoTetel : Double -> Double -> Double
feketeLyukElsoFoTetel homerseklet entropiaValtozas =
  homerseklet * entropiaValtozas  -- dM = T·dS

-- ─── 2D. FENY (a Legendre fixpontja) ───────────────────────────────

||| Fenysebesseg: c = 299792458 m/s
|||   A feny a Legendre transzformacio FIXPONTJA.
|||   m = 0 eseten: L = 0, H = pc = p·c
|||   A perem (p·c) az egyetlen tag — nincs L es H kulonbseg.
|||   A feny = a Legendre transzformacio azonossaga.
|||
|||   Foton: E = pc, nincs tomege
|||   A Legendre: L = 0, H = pc, H - 0 = pc = perem
|||   Itt a geometria (ter) es az ido (energia) kozott
|||   nincs kulonbseg — a feny a dualitas OLVADASPONTJA.
|||
|||   Maxwel egyenletek: a feny = elektromagneses hullam
|||   E es B mezok = ket oldal ugyanannak a Legendre-nek
public export
fenyFotonEnergia : Double -> Double
fenyFotonEnergia frekvencia =
  6.62607015e-34 * frekvencia  -- E = h·ν

public export
fenyFotonImpulzus : Double -> Double
fenyFotonImpulzus energia = energia / 299792458.0  -- p = E/c

||| Maxwel egyenletek Lagrangi-ana:
|||   L = -¼ F_μν·F^μν
|||   ahol F_μν = ∂_μA_ν - ∂_νA_μ
|||   Ez a Legendre: E es B mezok = L → H atvaltas
public export
maxwelLagrange : Double -> Double -> Double
maxwelLagrange elektromosMezo mágnesesMezo =
  (-0.25) * (elektromosMezo * elektromosMezo - mágnesesMezo * mágnesesMezo)

public export
maxwelHamilton : Double -> Double -> Double
maxwelHamilton elektromosMezo mágnesesMezo =
  0.5 * (elektromosMezo * elektromosMezo + mágnesesMezo * mágnesesMezo)

-- ─── 2E. KVANTUMMECHANIKA (palya integral mint Legendre) ──────────

||| Redukalt Planck-allando: ħ = h / 2π
public export
redukaltPlanck : Double
redukaltPlanck = 6.62607015e-34 / (2.0 * pi)

||| Hatas: S = ∫ L dt = ∫ (p·q̇ - H) dt
|||   A kvantummechanikai palya integral:
|||     ⟨qf|e^(-iHt/ħ)|qi⟩ = ∫ Dq e^(iS[q]/ħ)
|||   Itt a Legendre: S = p·q̇ - H = a kvantum hatas.
|||   Az exponencialis: e^(i·perem/ħ) = a kvantum Yoneda parositas.
|||
|||   A perem (p·q̇) a kvantumvaltozo:
|||     e^(ipx/ħ) = a sik hullam (foton)
|||     Ψ(x,t) = ⟨x|ψ(t)⟩ = a hullamfuggveny
public export
kvantumHatas : Double -> Double -> Double -> Double
kvantumHatas lagrangian kezdoIdo vegIdo =
  integral (\t => lagrangian) kezdoIdo vegIdo  -- S = ∫ L dt

||| Palya integral mag: e^(iS/ħ)
public export
palyaIntegralMag : Double -> Double
palyaIntegralMag hatas = cos (hatas / redukaltPlanck)  -- Re(e^(iS/ħ))

||| Schrodinger egyenlet: i·ħ·∂Ψ/∂t = H·Ψ
|||   Itt a Legendre: L es H kozotti valtas = kvantum ugras.
|||   Az idofejleszto operator: U(t) = e^(-iHt/ħ)
public export
idoFejleszto : Double -> (Double -> Double) -> Double -> Double
idoFejleszto ido hullamFuggveny x =
  hullamFuggveny x * cos (hamiltonMechanika x 0.0 * ido / redukaltPlanck)

-- ─── 2E. LANDAUER-ELV (energia = informacio) ─────────────────────

||| Landauer-elv: E = k·T·ln(2) · I
|||   Egy bit informacio torlese k·T·ln(2) energiat disszipal.
|||   A klorofill EZT forditva csinalja:
|||     foton (h·ν) → kémiai kotés = informacio tarolas
|||   Itt a Legendre: energia ↔ informacio a homersekleten at.
|||
|||   E (energia) = L (kvantum)
|||   I (informacio) = H (klasszikus)
|||   k·T·ln(2) = perem (p·q̇)
|||
|||   Fotoszintezis = Landauer visszafele:
|||     h·ν → kT·ln(2) · I → kemiai energia (ATP)
public export
boltzmannAllando : Double
boltzmannAllando = 1.380649e-23  -- k (J/K)

public export
landauerEnergia : Double -> Double -> Double
landauerEnergia homerseklet bitekSzama =
  boltzmannAllando * homerseklet * log 2.0 * bitekSzama
  -- E = k·T·ln(2) · N

public export
landauerInverz : Double -> Double -> Double
landauerInverz homerseklet energia =
  energia / (boltzmannAllando * homerseklet * log 2.0)
  -- I = E / (k·T·ln(2))

||| Foton energia = informacia:
|||   h·ν = k·T·ln(2) · I → I = h·ν / (k·T·ln(2))
|||   A foton kvantuma a "maximalis informacio" amit egy
|||   esemeny hordozhat.
public export
fotonInformacio : Double -> Double -> Double
fotonInformacio frekvencia homerseklet =
  landauerInverz homerseklet (fenyFotonEnergia frekvencia)

||| Klorofill hatasfok: a feny kvantumabol mennyi lesz kemiai
|||   kotés (informacio) es mennyi disszipal.
public export
klorofillHatasfok : Double -> Double -> Double
klorofillHatasfok homerseklet kemiaiEnergia =
  kemiaiEnergia / (boltzmannAllando * homerseklet * log 2.0)

-- ─── 2F. KVANTUMGRAVITÁCIÓ = ÖSSZEFONÓDÁS = INFORMÁCIÓ ──────────

||| ER=EPR: Einstein-Podolsky-Rosen = Einstein-Rosen híd.
|||   Minden összefonodott részecskepár egy féreglyukkal
|||   van összekötve.
|||   A kvantumgravitáció = összefonodás geometriája.
|||
|||   Itt a Legendre:
|||     L = összefonodás (kvantum, lokális, geometria)
|||     H = gravitáció (klasszikus, globális, idő)
|||     p·q̇ = a féreglyuk (a kettő közti kapcsolat)
|||
|||   Entrópia suruseg = Ryu-Takayanagi formula:
|||     S(A) = terület(γ_A) / (4G)
|||     Ahol γ_A a minimalis felület.
|||     Itt az információ = geometria = tömeg.
public export
ryuTakayanagi : Double -> Double -> Double
ryuTakayanagi minimalisFelulet gravitaciosAllando =
  minimalisFelulet / (4.0 * gravitaciosAllando)

||| Bekenstein-Hawking entropia (S = A/4ℓ_p²)
|||   A fekete lyuk entropiaja = információtartalma.
|||   Ez a kvantumgravitacio alapveto Legendre-je:
|||     M (tömeg) ↔ S (információ) ↔ rh (horizont sugara)
|||   Itt a tömeg = információ = geometria egy fekete lyukban.
public export
feketeLyukTomeg : Double -> Double
feketeLyukTomeg horizontSugara =
  horizontSugara / (2.0 * 6.67430e-11 / (299792458.0 * 299792458.0))
  -- r_s = 2GM/c²

public export
feketeLyukEntropia : Double -> Double -> Double
feketeLyukEntropia tomeg gravitaciosAllando =
  4.0 * pi * gravitaciosAllando * tomeg * tomeg
  -- S ∝ M²

||| Planck-egyseg: a kvantumgravitacio termeszetes mertekrendszere.
|||   ℓ_p = √(ħG/c³) ≈ 1.6e-35 m
|||   t_p = ℓ_p/c ≈ 5.4e-44 s
|||   m_p = √(ħc/G) ≈ 2.2e-8 kg
|||
|||   A Planck-skala = a Legendre transzformacio fixpontja:
|||     Itt a kvantum (L) es a gravitacio (H) egybeesik.
|||     ℓ_p·m_p = ħ/c = a perem termeszetes merteke.
public export
planckHossz : Double
planckHossz = sqrt (6.62607015e-34 * 6.67430e-11 /
              (8.0 * pi * 299792458.0 * 299792458.0 * 299792458.0))
  -- ℓ_p = √(ħG/c³)

public export
planckIdo : Double
planckIdo = planckHossz / 299792458.0  -- t_p = ℓ_p/c

public export
planckTomeg : Double
planckTomeg = sqrt (6.62607015e-34 * 299792458.0 /
              (8.0 * pi * 6.67430e-11))
  -- m_p = √(ħc/G)

-- ─── 2G. KVANTUMTERELMELET (mezo Legendre) ────────────────────────

||| Mezo Lagrangi-an suruseg: ℒ(φ, ∂_μφ) = ½(∂_μφ)(∂^μφ) - ½m²φ²
|||   Egy skalar mezo Lagrangi-anja:
|||     ℒ = ½(φ̇² - (∇φ)² - m²φ²)
|||   A kanonikus impulzus suruseg: π = ∂ℒ/∂φ̇ = φ̇
|||   A Hamilton suruseg: ℋ = π·φ̇ - ℒ = ½(π² + (∇φ)² + m²φ²)
|||   Ez a klasszikus Legendre a mezoelmeletben.
public export
mezoLagrangeSuruseg : Double -> Double -> Double -> Double -> Double
mezoLagrangeSuruseg idoDerivalt terDerivalt tomege mezo =
  0.5 * (idoDerivalt * idoDerivalt - terDerivalt * terDerivalt
         - tomege * tomege * mezo * mezo)

public export
mezoKanonikusImpulzus : Double -> Double
mezoKanonikusImpulzus idoDerivalt = idoDerivalt  -- π = φ̇

public export
mezoHamiltonSuruseg : Double -> Double -> Double -> Double -> Double
mezoHamiltonSuruseg idoDerivalt terDerivalt tomege mezo =
  0.5 * (idoDerivalt * idoDerivalt + terDerivalt * terDerivalt
         + tomege * tomege * mezo * mezo)

-- ─── 3. MATEMATIKA (konvex konjugalt = szupremum) ────────────────

||| Numerikus maximum: sup_x g(x) az [a,b]-n n lepesben.
public export
maximumFv : (Double -> Double) -> Double -> Double -> Nat -> Double
maximumFv g a b n = maxKereses g a b n a (g a)
  where
    maxKereses : (Double -> Double) -> Double -> Double -> Nat -> Double -> Double -> Double
    maxKereses g a b Z x0 fx0 = fx0
    maxKereses g a b (S k) x0 fx0 =
      let nNat = S k
          x = a + (b - a) * (cast nNat) / 100.0
          fv = g x
      in if fv > fx0
         then maxKereses g a b k x fv
         else maxKereses g a b k x0 fx0

||| Konvex konjugalt: f*(p) = sup_x (p·x - f(x))
|||   A vegtelen halmaz szupremuma = integral (kolimesz).
public export
konvexKonjugalt : (Double -> Double) -> Double -> Double
konvexKonjugalt f p = maximumFv (\x => perem p x - f x) (-10.0) 10.0 100

||| Ketszeres konjugalt = eredeti: f** = f (Yoneda)
public export
ketzeresKonjugalt : (Double -> Double) -> Double -> Double
ketzeresKonjugalt f x = konvexKonjugalt (konvexKonjugalt f) x

-- ─── 4. LIMESZ / KOLIMESZ (kategorikus dualitas) ─────────────────

||| Kolimesz (kategorikus dualis = derivalas):
|||   Ez az "osszeg" tipus — a lokalis informacio osszegyujtese.
|||   A Lagrangi-an = kolimesz (T - V, differencia).
public export
record Kolimesz (f : Type -> Type) where
  constructor KolimeszKonstruktor
  ertek : f Double

||| Limesz (kategorikus = integralas):
|||   Ez a "szorzat" tipus — a globalis informacio kivonasa.
|||   A Hamilton = limesz (T + V, osszeg).
public export
record Limesz (f : Type -> Type) where
  constructor LimeszKonstruktor
  ertek : f Double

-- ─── 5. CPT ES INFINITY ──────────────────────────────────────────

||| A Legendre transzformacio 3 arca = CPT.
public export
data LegendreArca : Type where
  CAraga : LegendreArca   -- hely (q), toltes, C
  PAraga : LegendreArca   -- sebesseg (q̇), paritas, P
  TAraga : LegendreArca   -- impulzus (p), ido, T

||| A derivalas ↔ antiderivalas ↔ integralas dualitas.
|||   Harom, nem kettő.
public export
data DerivalasAntiderivalasIntegralas : Type where
  DaiKonstruktor : DerivalasAntiderivalasIntegralas

-- ─── 6. CO-MINDEN ────────────────────────────────────────────────

||| Limesz = kategorikus szorzat / univerzalis konstrukcio.
|||   A Hamilton-fuggveny = LIMESZ:
|||     H(q, p) a fazister globalis, integralt leirasa.
|||     Minden konfiguraciobol egyertelmu morfizmus H-ba.
|||     A H = T + V a "legnagyobb kozos also korlat" (infimum).
public export
record KategoriaiLimesz (diagram : Type) (kategoria : Type) where
  constructor LimeszKonstruktorAlt
  limeszObjektum : kategoria -> Type
  univerzalisMorf : (konus : kategoria -> Type) -> kategoria

||| Kolimesz = kategorikus osszeg / koduális.
|||   A Lagrange-fuggveny = KOLIMESZ:
|||     L(q, q̇) a konfiguracios ter lokalis, differencialt leirasa.
|||     Minden mas leirasbol egyertelmu morfizmus L-be.
|||     Az L = T - V a "legkisebb felso korlat" (supremum).
public export
record KategoriaiKolimesz (diagram : Type) (kategoria : Type) where
  constructor KolimeszKonstruktorAlt
  kolimeszObjektum : kategoria -> Type
  kouniverzalisMorf : (kokonus : kategoria -> Type) -> kategoria

||| Co-minden: minden kategoriai fogalomnak van dualisa.
|||   Objektum ↔ Ko-objektum
|||   Limesz ↔ Kolimesz
|||   Morfizmus ↔ Ko-morfizmus (ellenmorf)
|||   Szorzat ↔ Osszeg
|||   Terminalis ↔ Inicialis
|||   Egalizator ↔ Koegalizator
|||   Exp ↔ Koexp
|||
||| A Legendre transzformacio = limesz ↔ kolimesz atvaltas.
|||   L (Lagrange) = kolimesz (lokalis, differencia, inicialis)
|||   H (Hamilton) = limesz (globalis, osszeg, terminalis)
|||   Legendre: kolimesz → limesz
|||   Inverz:    limesz → kolimesz
|||   A ketto kozott: a perem p·q̇ = Yoneda parositas.
|||
||| A 7 bit a [[7,1,3]] kodban:
|||   1. bit: ido   (q, hely) — C
|||   2. bit: oksag (q̇, sebesseg) — P (ko-ido)
|||   3. bit: ter   (p, impulzus) — T
|||   4. bit: szin  (L, Lagrangi-an) — KOLIMESZ
|||   5. bit: hang  (H, Hamilton) — LIMESZ
|||   6. bit: fazis (Legendre) — A KETTO KOZOTTI MORFIZMUS
|||   7. bit: mod   (a valasztas: melyik arcat hasznaljuk)
|||
|||   A kod javit 1 bitet → ha az egyik arca (pl. derivalas)
|||   eltunik, a masik (antiderivalas) meg helyreallitja.
|||   Tavolsag 3 → 1 hibat javit, 2 hibat erzekel.
public export
data CoMinden : Type where
  CoObjektum   : CoMinden  -- objektum ↔ ko-objektum (C^op)
  CoLimesz     : CoMinden  -- limesz ↔ kolimesz
  CoMorf       : CoMinden  -- morfizmus ↔ ellenmorf
  CoSzorzat    : CoMinden  -- szorzat ↔ osszeg
  CoTerminalis : CoMinden  -- terminalis ↔ inicialis
  CoEgalizator : CoMinden  -- egalizator ↔ koegalizator
  CoLegend     : CoMinden  -- Legendre: kolimesz → limesz

||| A Legendre-adjunkcio mint limesz ↔ kolimesz kapcsolat.
|||   L = kolimesz, H = limesz, Legendre = univerzalis morfizmus.
|||   Ez a kategorikus modellje a derivalas-antiderivalas-integralas
|||   haromseges szerkezetnek.
public export
record LegendreLimeszAdjunkcio where
  constructor LegLimAdj
  kolimeszFv : Type  -- a Lagrange (lokalis, differencialt)
  limeszFv   : Type  -- a Hamilton (globalis, integralt)
  peremMorf  : Type  -- a p·q̇ Yoneda-parositas
  -- A Legendre = perem - kolimesz = limesz
  -- Az adjunkcio: kolimesz ⊣ limesz

-- ═══════════════════════════════════════════════════════════════
-- ALAPVETŐ FIZIKAI ÁLLANDÓK (CODATA 2019, SI 2019)
-- ═══════════════════════════════════════════════════════════════

-- https://en.wikipedia.org/wiki/Speed_of_light
-- A fenysebesseg (c) az SI rendszerben PONTOSAN definialt: 299792458 m/s.
-- Ez a Specialis Relativitaselmelet alapveto allandoja: minden inerciarendszerben
-- ugyanannyi. A feny a Legendre-transzformacio FIXPONTJA: m=0 eseten L=0, H=pc,
-- a perem (p·c) az egyetlen tag — nincs kulonbseg a geometriai es az idobeli leiras kozott.
-- A feny = a dualitas olvadaspontja.
-- A fenysebesseg 1983 ota definicio szerint rogzitett; a meter ennek segitsegevel definialt.
||| Fénysebesség: c = 299 792 458 m/s (pontos, definíció szerint)
public export
fenysebesseg : Double
fenysebesseg = 299792458.0

-- https://en.wikipedia.org/wiki/Planck_constant
-- A Planck-allando (h) a kvantummechanika alapveto allandoja.
-- h = 6.62607015×10⁻³⁴ J·s (pontos, SI 2019 ota definicio szerint).
-- Planck vezette be 1900-ban a feketetest-sugarzas magyarazatara: E = h·f.
-- A hatas kvantuma: minden fizikai hatas egesz szamu tobbszorose h-nak.
-- A redukalt Planck-allando: ℏ = h/2π (lentebb).
-- Az SI 2019-es ujradefinicioja ota h erteke rogzitett, a kilogramm definiciojanak alapja.
||| Planck-állandó: h = 6.62607015e-34 J·Hz⁻¹ (pontos, SI 2019)
public export
planckAllando : Double
planckAllando = 6.62607015e-34

||| Gravitációs állandó: G = 6.67430e-11 m³·kg⁻¹·s⁻² (CODATA 2018)
public export
gravitaciosAllando : Double
gravitaciosAllando = 6.67430e-11

||| Avogadro-szám: NA = 6.02214076e23 mol⁻¹ (pontos, SI 2019)
public export
avogadroSzam : Double
avogadroSzam = 6.02214076e23

||| Elemi töltés: e = 1.602176634e-19 C (pontos, SI 2019)
public export
elemiToltes : Double
elemiToltes = 1.602176634e-19

||| Finomszerkezeti állandó: α = 7.2973525693e-3 (CODATA 2018)
public export
finomszerkezetiAllando : Double
finomszerkezetiAllando = 7.2973525693e-3

||| Vákuum permittivitás: ε₀ = 8.8541878128e-12 F·m⁻¹
public export
vakuumPermittivitas : Double
vakuumPermittivitas = 8.8541878128e-12

||| Vákuum permeabilitás: μ₀ = 1.25663706127e-6 N·A⁻²
public export
vakuumPermeabilitas : Double
vakuumPermeabilitas = 1.25663706127e-6

||| Stefan–Boltzmann-állandó: σ = 5.670374419e-8 W·m⁻²·K⁻⁴
public export
stefanBoltzmann : Double
stefanBoltzmann = 5.670374419e-8

||| Rydberg-állandó: R∞ = 10 973 731.568160 m⁻¹
public export
rydbergAllando : Double
rydbergAllando = 10973731.568160

-- ═══════════════════════════════════════════════════════════════
-- SZÁRMAZTATOTT MENNYISÉGEK
-- ═══════════════════════════════════════════════════════════════

||| Planck-hőmérséklet: TP = mP·c²/kB ≈ 1.416784e32 K
public export
planckHomerselet : Double
planckHomerselet = planckTomeg * fenysebesseg * fenysebesseg / boltzmannAllando

||| Planck-energia: EP = mP·c² ≈ 1.956081e9 J
public export
planckEnergia : Double
planckEnergia = planckTomeg * fenysebesseg * fenysebesseg

||| Foton-energia: E = h·ν
public export
fotonEnergia : Double -> Double
fotonEnergia frekvencia = planckAllando * frekvencia

||| Compton-hullámhossz: λ = h / (m·c)
public export
comptonHullamhossz : Double -> Double
comptonHullamhossz tomeg = planckAllando / (tomeg * fenysebesseg)

||| Schwarzschild-sugár: rs = 2·G·m / c²
public export
schwarzschildSugar : Double -> Double
schwarzschildSugar tomeg = 2.0 * gravitaciosAllando * tomeg / (fenysebesseg * fenysebesseg)

||| Hubble-állandó (Planck 2018): H₀ ≈ 67.4 km/s/Mpc
public export
hubbleAllando : Double
hubbleAllando = 67.4e3 / (3.085677581e22)

||| Hubble-idő: tH = 1/H₀ ≈ 14.4 milliárd év
public export
hubbleIdo : Double
hubbleIdo = 1.0 / hubbleAllando

||| Kozmológiai konstans: Λ = 3·H₀²/c² ≈ 1.1e-52 m⁻²
public export
kozmologiaiKonstans : Double
kozmologiaiKonstans = 3.0 * hubbleAllando * hubbleAllando / (fenysebesseg * fenysebesseg)
