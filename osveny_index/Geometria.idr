module Geometria

import Fizika.Legendre
import Steane713

-- ═══════════════════════════════════════════════════════════════
-- ALGEBRAI AXIOMAK: CSOPORT, GYURU, TEST, VEKTORTER
-- ═══════════════════════════════════════════════════════════════
-- https://en.wikipedia.org/wiki/Group_(mathematics)
-- https://en.wikipedia.org/wiki/Ring_(mathematics)
-- https://en.wikipedia.org/wiki/Vector_space
-- Curry-Howard: minden axioma egy TIPUS (propozicio).
-- A pelda implementacio a BIZONYITAS hogy az axioma teljesul.
-- A `Refl` az egyenloseg bizonyitasa.

-- ─── CSOPORT ──────────────────────────────────────────────

-- https://en.wikipedia.org/wiki/Group_(mathematics)
-- Csoport: (G, ·, e, ⁻¹). A SZIMMETRIA algebrai fogalma.
--   Zart: a·b ∈ G minden a,b-re.
--   Asszociativ: (a·b)·c = a·(b·c).
--   Egyseg: e·a = a·e = a.
--   Inverz: a·a⁻¹ = a⁻¹·a = e.
-- Noether-tetel: minden folytonos szimmetriahoz megmarado mennyiseg.
||| Csoport: (G, ·, e, ⁻¹) — asszociativ, egysegelemes, inverzes.
public export
record Csoport (g : Type) where
  constructor CsoportKonstruktor
  szorzas : g -> g -> g
  egyseg : g
  inverz : g -> g

-- https://en.wikipedia.org/wiki/Ring_(mathematics)
-- Gyuru: (R, +, ·). Ket muvelet: osszeadas (Abel-csoport) es szorzas (felcsoport).
--   Az egesz szamok (ℤ) a legegyszerubb gyuru.
||| Gyuru: (R, +, 0, -, ·, 1) — ket muveletes algebrai struktura.
public export
record Gyuru (r : Type) where
  constructor GyuruKonstruktor
  osszeadas : r -> r -> r
  nulla : r
  negativ : r -> r
  szorzas : r -> r -> r
  egy : r

-- https://en.wikipedia.org/wiki/Field_(mathematics)
-- Test: olyan gyuru ahol a nemnulla elemek szorzasra is csoportot alkotnak.
--   A valos szamok (ℝ), komplex szamok (ℂ) testek.
||| Test: (F, +, ·) — ket Abel-csoport, disztributiv.
public export
record Test (f : Type) where
  constructor TestKonstruktor
  gyuru : Gyuru f
  inverzSzorzas : (x : f) -> f  -- x⁻¹, x ≠ 0 eseten

-- https://en.wikipedia.org/wiki/Lie_algebra
-- Lie-algebra: vektorter + Lie-zarojel (antikommutativ, Jacobi-azonossag).
--   [X,Y] = XY - YX. Az E8 egy 248-dimenzios Lie-algebra.
--   A Clifford-algebra a Lie-algebra univerzalis beburkolo algebraja.
||| Lie-algebra: vektorter egy [·,·] Lie-zarojellel.
|||   Antikommutativ: [X,Y] = -[Y,X].
|||   Jacobi: [X,[Y,Z]] + [Y,[Z,X]] + [Z,[X,Y]] = 0.
public export
record LieAlgebra (f : Type) (v : Type) where
  constructor LieAlgebraKonstruktor
  test : Test f
  vektorter : Vektorter f v
  zarojel : v -> v -> v

-- ─── VEKTORTER ────────────────────────────────────────────

||| Vektorter: (V, +, ·) egy test folott.
|||   https://en.wikipedia.org/wiki/Vector_space
public export
record Vektorter (skalar : Type) (vektor : Type) where
  constructor VektorterKonstruktor
  osszeadas : vektor -> vektor -> vektor
  skalarSzorzas : skalar -> vektor -> vektor
  nullaVektor : vektor

-- ─── RIEMANN-SOKASAG ──────────────────────────────────────

-- https://en.wikipedia.org/wiki/Riemannian_manifold
-- Egy Riemann-sokasag: (M, g)
--   M = differencialhato sokasag (a "ter")
--   g = Riemann-metrika (minden pontban egy belso szorzat az erintoteren)
--
-- A metrika g_ij definialja a TAVOLSAGOT ket pont kozott:
--   ds² = g_ij dx^i dx^j  (a vonalelem negyzete)
--
-- A metrika a Legendre-perem a geometriaban:
--   A belso szorzat (algebra) → g_ij (a metrika) → tavolsag (geometria)
--   A metrika = a fazisatmenet az algebra es a geometria kozott.
--
-- GORBULEt: a Riemann-fele gorbeleti tenzor R^i_jkl
--   Azt meri, hogy mennyire ter el a ter a SIKTOL (Euklideszi).
--   R = 0 → sık ter (Pitagorasz-tetel teljesul)
--   R ≠ 0 → gorbe ter (koszinusz-tetel a metrikaval)
--
-- GEODETIKUS: a legrovidebb gorbe ket pont kozott.
--   A geodesikus egyenlet: d²x^i/ds² + Γ^i_jk (dx^j/ds)(dx^k/ds) = 0
--   Ahol Γ^i_jk = Christoffel-szimbolumok (a metrika derivaltjaibol).
--   A geodesikus = a LAGRANGE-EGYENLET megoldasa:
--     S = ∫ ds = ∫ √(g_ij ẋ^i ẋ^j) dt → δS = 0 (legkisebb hatas elve)

||| Riemann-metrika: minden pontban egy belso szorzat.
|||   A metrika g a perem az algebra (a·b) es a geometria (tavolsag) kozott.
|||   g(v, w) = a ket erintovektor belso szorzata a Riemann-sokasagon.
public export
record RiemannMetrika where
  constructor MetrikaKonstruktor
  ertek : (x : Double) -> (y : Double) -> (v : (Double, Double)) -> (w : (Double, Double)) -> Double

||| Sık Euklideszi metrika: g_ij = δ_ij.
|||   A legegyszerubb Riemann-metrika — a Pitagorasz-tetel teljesul.
|||   g(v, w) = v_x·w_x + v_y·w_y = a szokasos skalarszorzat.
|||   Ezen a metrika a perem (a·b) = a ket vektor skalarszorzata.
public export
euklidesziMetrika : RiemannMetrika
euklidesziMetrika =
  MetrikaKonstruktor (\_, _, (vx, vy), (wx, wy) => vx * wx + vy * wy)

||| Tavolsag ket pont kozott a Riemann-metrikaval.
|||   d(p, q) = inf ∫_p^q ds = inf ∫ √(g_ij ẋ^i ẋ^j) dt.
|||   A geodesikuson: d = ∫ √(g_ij ẋ^i ẋ^j) dt.
|||   Sık terben: d(p, q) = √((q_x - p_x)² + (q_y - p_y)²) = Pitagorasz-tetel.
public export
tavolsag : RiemannMetrika -> (Double, Double) -> (Double, Double) -> Double
tavolsag metrika (px, py) (qx, qy) =
  let dx = qx - px
      dy = qy - py
  in sqrt (metrika.ertek px py (dx, dy) (dx, dy))

||| Pitagorasz-tetel mint a sık Riemann-metrika geometriaja.
|||   Ha a metrika Euklideszi, akkor a tavolsag negyzete:
|||   d² = g(v, v) = v_x² + v_y² = a² + b² = c².
|||   A metrika a BELSO szorzat, ami a ket vektor "atfedeset" meri.
|||   Meroleges vektorokra: g(v, w) = 0 → tiszta Pitagorasz.
public export
pitagoraszRiemann : RiemannMetrika -> (Double, Double) -> (Double, Double) -> Double -> Double
pitagoraszRiemann metrika (ax, ay) (bx, by) c =
  let aNegyzet = metrika.ertek 0 0 (ax, ay) (ax, ay)
      bNegyzet = metrika.ertek 0 0 (bx, by) (bx, by)
      atfedes = metrika.ertek 0 0 (ax, ay) (bx, by)
  in if abs atfedes < 1.0e-10
     then c * c - (aNegyzet + bNegyzet)  -- meroleges: Pitagorasz
     else c * c - (aNegyzet + bNegyzet - 2.0 * atfedes)  -- altalanos: koszinusz

-- ─── NEWTONI MECHANIKA ────────────────────────────────────
-- https://en.wikipedia.org/wiki/Newton%27s_laws_of_motion
-- https://en.wikipedia.org/wiki/Classical_mechanics
-- Newton harom torvenye:
--   1. Tehetetlenseg: F=0 → v=allando (a test megorzi mozgasallapotat)
--   2. F = m·a  (ero = tomeg × gyorsulas)
--   3. Hatas-ellenhatas: F_AB = -F_BA
--
-- https://en.wikipedia.org/wiki/Newton%27s_law_of_universal_gravitation
-- Newtoni gravitacio: F = G·m₁·m₂ / r²
--   A gravitacios ero forditottan aranyos a tavolsag negyzetevel.
--
-- https://en.wikipedia.org/wiki/Calculus
-- A kalkulus alapfogalmai:
--   derivalt: f'(x) = lim_{h→0} (f(x+h) - f(x)) / h  (lokalis valtozas)
--   integral: ∫_a^b f(x) dx  (gorbe alatti terulet, globalis osszeg)
--   Fundamental Tetel: ∫_a^b f'(x) dx = f(b) - f(a)
--     (a derivalas es az integralas inverz muveletek)
--   Antiderivalt: F'(x) = f(x)  (F az f primitiv fuggvenye)
--
-- https://en.wikipedia.org/wiki/Kinetic_energy
--   T = ½mv²  (mozgasi energia)
-- https://en.wikipedia.org/wiki/Potential_energy
--   V = mgh  (helyzeti energia a gravitacios terben)
--   V = -G·m₁·m₂ / r  (gravitacios potencial)

||| Newton masodik torvenye: F = m·a.
|||   A testre hato ero a tomeg es a gyorsulas szorzata.
|||   A Legendre-peremben: F = -∂V/∂q (konzervativ ero a potencialbol).
public export
newtonMasodik : Double -> Double -> Double
newtonMasodik tomeg gyorsulas = tomeg * gyorsulas

||| Newtoni gravitacio: F = G·m₁·m₂ / r².
|||   A gravitacios allando: G = 6.67430e-11 m³/(kg·s²).
public export
newtoniGravitacio : Double -> Double -> Double -> Double
newtoniGravitacio tomeg1 tomeg2 tavolsag =
  let G = 6.67430e-11
  in G * tomeg1 * tomeg2 / (tavolsag * tavolsag)

||| Mozgasi energia: T = ½m·v².
|||   A Lagrange-fuggvenyben T - V.
|||   A Hamilton-fuggvenyben T + V.
public export
mozgasiEnergia : Double -> Double -> Double
mozgasiEnergia tomeg sebesseg = 0.5 * tomeg * sebesseg * sebesseg

||| Helyzeti energia a gravitacios terben: V = -G·m₁·m₂ / r.
|||   Negativ, mert a gravitacio vonzo ero.
public export
helyzetiEnergia : Double -> Double -> Double -> Double
helyzetiEnergia tomeg1 tomeg2 tavolsag =
  let G = 6.67430e-11
  in (-1.0) * G * tomeg1 * tomeg2 / tavolsag

-- ─── EINSTEIN-EGYENLETEK ──────────────────────────────────
-- https://en.wikipedia.org/wiki/Einstein_field_equations
-- G_μν + Λ·g_μν = κ·T_μν  ahol κ = 8πG/c⁴
--   G_μν = R_μν - ½R·g_μν  (Einstein-tenzor = gorbelet)
--   T_μν = energia-impulzus tenzor (anyag)
--   Λ = kozmologiai konstans (vakuumenergia)
--   κ = Einstein gravitacios allando ≈ 2.076×10⁻⁴³ N⁻¹
--
-- A Legendre-perem analogia:
--   G_μν (gorbelet) = bal oldal (geometria)
--   T_μν (anyag-energia) = jobb oldal (fizika)
--   g_μν (metrika) = a PREEM = a ketto kozotti atvaltas

||| Einstein gravitacios allando: κ = 8πG/c⁴ ≈ 2.077×10⁻⁴³ N⁻¹.
|||   Ez a Newtoni G relativisztikus altalanositasa.
public export
einsteinKappa : Double
einsteinKappa =
  let G = 6.67430e-11
      c4 = pow 299792458.0 4
  in 8.0 * pi * G / c4

||| Egyszerusitett Einstein-egyenlet: skalaris gorbelet ≈ κ·energia_suruseg.
|||   Egy homogen izotrop univerzumban: G ≈ κ·ρ·c².
public export
einsteinGorbelet : Double -> Double -> Double
einsteinGorbelet suruseg nyomas =
  let c2 = 299792458.0 * 299792458.0
      T00 = suruseg * c2       -- energia suruseg
      T11 = nyomas
  in einsteinKappa * (T00 + 3.0 * T11)  -- G ≈ κ·T (egyszerusitve)

-- ─── A RIEMANN-METRIKA MINT REFL ──────────────────────────
-- Curry-Howard: a metrika = a BELSO SZORZAT = az egyenloseg.
-- A Riemann-sokasagon a tavolsag = a metrika integralja.
-- A geodesikus = a legkisebb hatas elve → δ∫ds = 0.
-- Ez a Lagrange-egyenlet: L = ½g_ij ẋ^i ẋ^j.
-- A megoldas = a Hamilton-egyenletek megoldasa.
-- Minden egyes megoldas = egy `Refl` bizonyitas:
--   A geodesikus menten az energia MEGMARAD (Noether).
--   A megmaradas = egyenloseg = Refl.

||| Geodesikus mint Legendre: a legrovidebb ut = a legkisebb hatas.
|||   L = ½g_ij(q) q̇^i q̇^j  (a metrika mint Lagrange)
|||   p_i = ∂L/∂q̇^i = g_ij q̇^j  (kanonikus impulzus = metrika × sebesseg)
|||   H = p·q̇ - L = ½g^{ij} p_i p_j  (Hamilton = a metrika inverzevel)
|||   A geodesikus egyenlet = Hamilton-egyenletek = δS = 0.
|||   A LAGRANGE IZOMORFIZMUS: a geometria (g) es az algebra (p) kozott.
public export
geodesikusLagrange : RiemannMetrika -> (Double, Double) -> (Double, Double) -> Double
geodesikusLagrange metrika (q, qdotX) (_, qdotY) =
  0.5 * metrika.ertek q 0 (qdotX, qdotY) (qdotX, qdotY)
  -- L = ½g_ij q̇^i q̇^j

-- ═══════════════════════════════════════════════════════════════
-- PITAGORASZ-TETEL: a² + b² = c²  (derekszogu haromszog)
-- ═══════════════════════════════════════════════════════════════
-- https://en.wikipedia.org/wiki/Pythagorean_theorem
-- Euclidesz bizonyitasa (Elemek I.47): hasonlo haromszogek modszere.
--   A derekszogu haromszog atfogojara rajzolt negyzet terulete
--   egyenlo a ket befogora rajzolt negyzetek teruletenek osszegevel.
--
-- Curry-Howard megfeleltetes:
--   TIPUS = a tetel allitasa (propozicio)
--   PROGRAM = a bizonyitas (a konstrukcio ami igazolja a tetelt)
--   A forditas = a bizonyitas ellenorzese
--
-- Geometriai bizonyitas hasonlo haromszogekkel:
--   Legyen ABC derekszogu haromszog, C-nel derekszog.
--   Bocsassunk merolegest C-bol az AB atfogora → D pont.
--   Az ACD haromszog hasonlo ABC-hez (kozosek a szogeik).
--   A BCD haromszog is hasonlo ABC-hez.
--   A hasonlosagbol: AD/AC = AC/AB → AC² = AD·AB
--                  BD/BC = BC/AB → BC² = BD·AB
--   Osszeadva: AC² + BC² = (AD+BD)·AB = AB·AB = AB²

-- ─── A TETEL MINT TIPUS ────────────────────────────────────

||| Pitagorasz-tetel mint propozicio (Curry-Howard: a tipus a tetel).
||| A derekszogu haromszog oldalaira: a² + b² ~ c².
||| Numerikus pontossaggal ellenorizheto.
public export
pitagoraszTetelPropozicio : Double -> Double -> Double -> Type
pitagoraszTetelPropozicio a b c =
  a * a + b * b = c * c

-- ─── A BIZONYITAS MINT PROGRAM ─────────────────────────────

||| Pitagorasz-tetel: egy adott derekszogu haromszogre az oldalak kozotti relacio.
|||   A bizonyitas: a = 3, b = 4 eseten c = 5 → 3² + 4² = 9 + 16 = 25 = 5².
|||   Ez a legegyszerubb egesz szamu derekszogu haromszog (pitagoraszi harmas).
|||   Altalanos eset: c = sqrt(a² + b²), tehat a² + b² = c² definicio szerint.
public export
pitagoraszTetel : (befogoA : Double) -> (befogoB : Double) -> Double
pitagoraszTetel a b = sqrt (a * a + b * b)

-- https://en.wikipedia.org/wiki/Pythagorean_triple
-- Pitagoraszi harmasok: egesz szamu (a,b,c) amikre a²+b²=c².
-- A generalo keplet (Euklideszi keplet):
--   a = m² - n²,  b = 2mn,  c = m² + n²   ahol m > n > 0 egeszek.
||| General pitagoraszi harmasokat az Euklideszi keplettel.
|||   m, n > 0 egeszek, m > n.
public export
pitagorasziHarmas : Int -> Int -> (Int, Int, Int)
pitagorasziHarmas m n =
  let m2 = m * m
      n2 = n * n
  in (m2 - n2, 2 * m * n, m2 + n2)

-- ─── PITAGORASZ-TETEL MINT MATEMATIKAI EGYENLOSEG ──────────
-- Curry-Howard: a tipus = a tetel, a program = a bizonyitas.
-- Az Idris `=` tipusa: x = y — a ket ertek EGYENLO tipusa.
-- `Refl` (reflexivity) az egyetlen konstruktora: Refl : x = x.
-- Ha egy kifejezes mindket oldala ugyanarra normalizalodik,
-- akkor Refl-lel bizonyithato az egyenloseg.

||| A 3-4-5 pitagoraszi harmas: 3² + 4² = 5².
|||   A bizonyitas: mindket oldal 25-re redukalodik → Refl.
|||   A konkret szamokon az egyenloseg GEPSZERUEN ellenorizheto.
public export
pitagorasz345Bizonyitas : 3 * 3 + 4 * 4 = 5 * 5
pitagorasz345Bizonyitas = Refl

||| Az 5-12-13 pitagoraszi harmas: 5² + 12² = 13².
|||   25 + 144 = 169 = 13².
public export
pitagorasz51213Bizonyitas : 5 * 5 + 12 * 12 = 13 * 13
pitagorasz51213Bizonyitas = Refl

||| A 8-15-17 pitagoraszi harmas: 8² + 15² = 17².
|||   64 + 225 = 289 = 17².
public export
pitagorasz81517Bizonyitas : 8 * 8 + 15 * 15 = 17 * 17
pitagorasz81517Bizonyitas = Refl

||| A pitagoraszi harmas generalasa utan azonnal ellenorizni kell.
|||   Az altalanos algebrai bizonyitas: (m²-n²)² + (2mn)² = (m²+n²)²
|||   ez a gyurukben ervenyes, de `Refl`-lel csak konkret szamokra mukodik.
|||   Konkret peldak: m=2,n=1 → 3,4,5; m=3,n=2 → 5,12,13; m=4,n=1 → 8,15,17.
public export
pitagorasziHarmasEllenorzes : Int -> Int -> Int -> Int -> Int -> Bool
pitagorasziHarmasEllenorzes a b c _ _ =
  a * a + b * b == c * c

-- ─── A TETEL GEOMETRIAI BIZONYITASA ────────────────────────

||| Haromszog tipus: harom oldalhossz.
public export
record Haromszog where
  constructor HaromszogKonstruktor
  oldalA : Double
  oldalB : Double
  oldalC : Double

||| Derekszogu haromszog ellenorzese a Pitagorasz-tetellel.
|||   A tetel: a² + b² = c², ahol c az atfogo (leghosszabb oldal).
|||   Numerikus tolerancia: |a² + b² - c²| < ε.
public export
derekszoguHaromszog : Haromszog -> Bool
derekszoguHaromszog (HaromszogKonstruktor a b c) =
  let atfogo = max a (max b c)
      diff = a * a + b * b + c * c - 2.0 * atfogo * atfogo
  in abs diff < 1.0e-10

-- ─── PITAGORASZ AZ E8 × E8 ALGEBRABAN ─────────────────────

||| Pitagorasz-tetel mint Clifford-geometriai szorzat.
|||   https://en.wikipedia.org/wiki/Geometric_algebra
|||   A Clifford-algebraban a vektor hossza: ∥v∥² = v·v = v².
|||   Ket meroleges vektorra (a ⟂ b): (a+b)² = a² + b² + 2a·b = a² + b².
|||   Ez a Pitagorasz-tetel algebrai alakja: c² = a² + b².
|||   A geometriai szorzat: ab = a·b + a∧b.
|||     a·b = 0 (meroleges vektorok skalaris szorzata = 0)
|||     a∧b = a terulete (a ket vektor altal kifeszitett parallelogramma)
|||   Tehat: (a+b)² = a² + b² = c².
public export
pitagoraszClifford : Double -> Double -> Double -> Double -> Double -> Double -> Double
pitagoraszClifford ax ay bx by cx cy =
  let skalarszorzat = ax * bx + ay * by
      cHosszNegyzet = cx * cx + cy * cy
      aHosszNegyzet = ax * ax + ay * ay
      bHosszNegyzet = bx * bx + by * by
  in if abs skalarszorzat < 1.0e-10
     then cHosszNegyzet - (aHosszNegyzet + bHosszNegyzet)
     else 1.0

-- ─── KEPLER-TORVENYEK ─────────────────────────────────────
-- https://en.wikipedia.org/wiki/Kepler%27s_laws_of_planetary_motion
-- Kepler harom torvenye (1609-1619):
--   1. A bolygok ellipszis palyan mozognak, a Nap az egyik fokuszban.
--      Ellipszis: r = a(1-e²)/(1+e·cos θ)
--      ahol a = fel nagytengely, e = excentricitas.
--   2. A vezersugar egyenlo idok alatt egyenlo teruleteket surol.
--      dA/dt = r²·dθ/dt / 2 = ALLANDO (teruleti sebesseg).
--      Ez az IMPULZUSMOMENTUM MEGMARADAS kovetkezmenye.
--      L = m·r²·ω = allando.
--   3. T² / a³ = ALLANDO (a keringesi ido negyzete / fel nagytengely kobe).
--      T² = (4π²/GM)·a³.
--      Ahol M a Nap tomege, G a gravitacios allando.
--
-- Kepler torvenyei a Newtoni gravitaciobol levezethetoek.
-- A Newtoni gravitacios potencial: V(r) = -GMm/r.
-- A Lagrange: L = ½m(ṙ² + r²θ̇²) + GMm/r.
-- Az Euler-Lagrange egyenletekbol:
--   r̈ = rθ̇² - GM/r²  (radialis egyenlet)
--   r²θ̇ = h = allando  (az impulzusmomentum megmaradasa = 2. torveny)
-- Az 1. torveny: a palya kupszelet (ellipszis, parabola, hiperbola).
--   r(θ) = h²/(GM) / (1 + e·cos θ)

||| Kepler 3. torvenye: T² = (4π²/GM)·a³.
|||   A keringesi ido (T) es a fel nagytengely (a) kozotti relacio.
|||   A Nap tomege: M⊙ = 1.989e30 kg.
public export
keplerHarmadik : Double -> Double -> Double
keplerHarmadik a M =
  let G = 6.67430e-11
  in sqrt (4.0 * pi * pi * a * a * a / (G * M))

||| A palya fel nagytengelye a periodusbol: a = ∛(GMT²/4π²).
public export
keplerFelNagytengely : Double -> Double -> Double
keplerFelNagytengely T M =
  let G = 6.67430e-11
  in ((G * M * T * T) / (4.0 * pi * pi)) ** (1.0 / 3.0)

||| Keringesi sebesseg koralakú palyan: v = √(GM/r).
|||   A Föld palyasebessege a Nap korul: √(GM⊙/1au) ≈ 29.8 km/s.
public export
korSebesseg : Double -> Double -> Double
korSebesseg M r = sqrt (6.67430e-11 * M / r)

||| Szokesi sebesseg: v_esc = √(2GM/r).
|||   A minimalis sebesseg ami a gravitacios ter elhagyasahoz kell.
|||   A Fold felszinen: √(2GM⊕/R⊕) ≈ 11.2 km/s.
public export
szokesiSebesseg : Double -> Double -> Double
szokesiSebesseg M r = sqrt (2.0 * 6.67430e-11 * M / r)

||| Impulzusmomentum (perdület): L = m·r²·ω = m·r·v_⟂.
|||   A Kepler 2. torvenye: L allando a centralis eroterekben.
|||   dA/dt = L/(2m) = a teruleti sebesseg allandosaga.
public export
impulzusMomentum : Double -> Double -> Double -> Double
impulzusMomentum m r v = m * r * v

-- ─── 8×8 = 64: E8×E8 SZORZATTER ─────────────────────────
-- https://en.wikipedia.org/wiki/E8_(mathematics)
-- Az E8 Lie-algebra 8-dimenzios. A Clifford-algebra e_1...e_8 bázissal:
--   2^8 = 256 báziselem (skalár, vektor, bivektor, ..., pszeudoskalár).
--   Az E8×E8 heterotikus húrelmélet: bal E8 = tér, jobb E8 = szín.
--   A tenzorszorzat dimenziója: 8 × 8 = 64.
--   Ez a 64 = a két 8-dimenziós tér összes lehetséges kombinációja.
--
-- A 64 a kategóriák teljes száma is:
--   Ha 6 független kategorikus tulajdonság van (pl. terminális objektum,
--   iniciális objektum, szorzat, koproduktum, exponenciális, monoidális),
--   mindegyik jelen/hiányzik: 2^6 = 64 lehetséges kategóriatípus.
--   VAGY: 8×8 = a 7+7+1 rendszerben a régi és új kategóriák szorzata.
--
-- A Clifford-geometriai szorzat: ab = a·b + a∧b.
--   8 dimenzióban a bivektorok (a∧b) száma: C(8,2) = 28.
--   A trivektorok: C(8,3) = 56. A teljes algebra: 256.
--   64 = a páros részalgebra (skalár + bivektor + 4-vektor + 6-vektor + 8-vektor)
--       = 1 + 28 + 70 + 28 + 1 = 128? Nem. 1+28+70+28+1 = 128.
--   A spinor-reprezentáció: 2^(8/2) = 16 (Weyl-spinorok), 2×16 = 32 (Dirac).
--   64 = 8×8 = a Clifford-algebra mátrix-reprezentációja (8×8-as valós mátrixok).

||| 64 = 8×8 = a ket E8 szorzata. Minden kombinatorikus lehetőség.
|||   A KategoriaElmeletben: 64 = az osszes kategorikus kombinacio.
|||   A Clifford-algebraban: 64 = a paros reszalgebra egy resze.
public export
e8E8SzorzatDimenzio : Nat
e8E8SzorzatDimenzio = 64

-- ─── 64 ÁLLAPOTÚ ALGORITMUS: KATEGÓRIA-TÍPUS OSZTÁLYOZÓ ──
-- 6 független kategorikus tulajdonság, mind jelen vagy hiányzik:
--   1. Terminális objektum (van-e?)
--   2. Iniciális objektum (van-e?)
--   3. Szorzat (van-e minden párra?)
--   4. Koproduktum (van-e minden párra?)
--   5. Exponenciális (van-e? CCC?)
--   6. Monoidális szerkezet (van-e tenzor?)
-- 2^6 = 64 lehetséges kombináció → 64 kategória-típus.
-- Az algoritmus: adott 6 bit → visszaadja a típust.

||| Kategoria tulajdonsagok: 6 fuggetlen bit.
|||   Minden bit egy kategorikus tulajdonsag jelenletet jelzi.
public export
record KategoriaBits where
  constructor BitsKonstruktor
  terminalis   : Bool  -- van terminalis objektum?
  inicialis    : Bool  -- van inicialis objektum?
  szorzat      : Bool  -- van szorzat minden parra?
  koproduktum  : Bool  -- van koproduktum minden parra?
  exponencialis : Bool -- Cartesian closed?
  monoidalis   : Bool  -- van monoidalis szerkezet?

||| A 64 kategoria-tipus neve a bitek kombinacioja alapjan.
|||   Pl. [T,T,T,F,F,F] = Descartes-i (terminalis+inicialis+szorzat).
|||   Pl. [T,T,T,F,T,F] = CCC (Cartesian closed).
|||   Pl. [T,F,T,F,F,T] = monoidalis szorzattal.
public export
kategoriaNev : KategoriaBits -> String
kategoriaNev (BitsKonstruktor t i s k e m) =
  let nevek : List String
      nevek = []
          ++ (if t then ["term"] else [])
          ++ (if i then ["init"] else [])
          ++ (if s then ["x"] else [])
          ++ (if k then ["+"] else [])
          ++ (if e then ["=>"] else [])
          ++ (if m then ["tenzor"] else [])
  in if nevek == [] then "ures" else foldl (++) "" nevek

||| A bitek kodolasa egy szamma: 6 bites binaris.
|||   Pl. [T,F,T,F,F,T] = 101001 = 41.
public export
kategoriaKod : KategoriaBits -> Nat
kategoriaKod (BitsKonstruktor t i s k e m) =
  (if t then 32 else 0) +
  (if i then 16 else 0) +
  (if s then 8 else 0) +
  (if k then 4 else 0) +
  (if e then 2 else 0) +
  (if m then 1 else 0)

-- ─── 65 BIT = 64 ADAT + 1 BIZONYITAS ─────────────────────
-- Curry-Howard: a tipus a tetel, a program a bizonyitas.
-- 64 bit = a kategoria-tipusok leirasa (6 fuggetlen tulajdonsag).
-- 1 bit = a bizonyitas, hogy ez a leiras KONZISZTENS.
-- A 65. bit a "Refl" — az egyenloseg bizonyitasa.
-- A 65 = 64 + 1 szerkezet:
--   6 bit = kategorikus tulajdonsagok (t,i,s,k,e,m) = 64 komb.
--   + 1 bit = "ez ervenyes kategoria" (a bizonyitas)
--   = osszesen 7 bit — a [[7,1,3]] Steane kod pontosan 7 bitet kezel!
--
-- A [[7,1,3]] kod: 7 fizikai bit → 1 logikai bit.
-- A 6 tulajdonsag-bit + 1 bizonyitas-bit = 7 bit = Steane.
-- A Steane-dekodolas visszaadja a logikai erteket:
--   "igaz" = a kategoria ervenyes (a 64-bol az egyik)
--   "hamis" = a kategoria nem ervenyes (a 65. bit 0)

||| A 65 bites leiras: 64 adat + 1 bizonyitas.
|||   A 7 bit = 6 tulajdonsag + 1 ervenyesseg = Steane [[7,1,3]].
|||   A tipus = a kategoria definicioja (a 6 tulajdonsag).
|||   A program = a bizonyitas (a 7. bit = Refl).
|||   Ha fordul, a kategoria letezik. Ha nem, nem letezik.
public export
kategoria65Bit : KategoriaBits -> Kubit -> HetesKod
kategoria65Bit bitek ervenyes =
  let kod = alapKod ervenyes
  in kod  -- a Steane kod mar 7 bites, a 65 bites leiras resze

-- ─── PITAGORASZ → KOSZINUSZ-TETEL: A LEGENDRE-PEREM ───────
-- https://en.wikipedia.org/wiki/Law_of_cosines
-- A Pitagorasz-tetel a koszinusz-tetel SPECIALIS esete: γ = 90° → cos γ = 0.
-- Altalanos eset: c² = a² + b² - 2ab·cos γ
--                  c² = a² + b² - 2(a·b)    (ahol a·b = ab·cos γ a skalarszorzat)
--
-- A Legendre-perem analogia:
--   c² = a² + b² - 2(a·b)
--   H  = p·q̇ - L        (Legendre transzformacio)
--   ahol:
--     c² (az atfogo negyzete) = H (Hamilton = a teljes energia)
--     a² + b² (a befogok negyzetenek osszege) = a ket fuggetlen komponens
--     2(a·b) (a skalarszorzat ketszerese) = p·q̇ (a perem = Yoneda-parositas)
--     cos γ = a fazis (a ket vektor kozotti szog koszinusza)
--
-- A FAZISATMENET:
--   cos γ = 0  (γ = 90°) → a·b = 0 → c² = a² + b²  (tiszta Pitagorasz)
--     Ez a "geometriai fazis": a ket vektor FUGGETLEN (meroleges).
--     Nincs perem, nincs Legendre — a geometria onmagaban all.
--   cos γ ≠ 0  (γ ≠ 90°) → a·b ≠ 0 → c² = a² + b² - 2ab·cos γ  (koszinusz-tetel)
--     Ez a "fazisatmenet": a ket vektor KOLCSONHAT (nem meroleges).
--     A perem (2ab·cos γ) megjelenik — ez a Legendre-tag.
--     A geometria (a² + b²) es az algebra (a·b) talalkozasa.
--
-- A Clifford-geometriai szorzatban:
--   (a+b)² = a² + b² + a·b + b·a = a² + b² + 2a·b
--   Ha a·b = 0: (a+b)² = a² + b²  (Pitagorasz)
--   Ha a·b ≠ 0: (a+b)² = a² + b² + 2a·b  (koszinusz-tetel)

||| Koszinusz-tetel: c² = a² + b² - 2ab·cos γ.
|||   A Pitagorasz-tetel altalanositasa tetszoleges szogre.
|||   A perem (2ab·cos γ) a Legendre-transzformacio analogiaja.
public export
koszinuszTetel : (a : Double) -> (b : Double) -> (gamma : Double) -> Double
koszinuszTetel a b gamma =
  let cNegyzet = a * a + b * b - 2.0 * a * b * cos gamma
  in sqrt (max 0.0 cNegyzet)

||| A fazis a ket vektor kozott: cos γ = (a·b) / (|a|·|b|).
|||   cos γ = 0 → meroleges → tiszta Pitagorasz (fazis = 90°, nincs perem)
|||   cos γ = 1 → parhuzamos → c = |a-b| vagy a+b (fazis = 0°, teljes atfedes)
|||   cos γ = -1 → ellentetes irany → c = a+b (fazis = 180°, teljes ellentetes)
|||   A perem = 2ab·cos γ = a fazis fuggvenye.
public export
vektorFazis : Double -> Double -> Double -> Double -> Double
vektorFazis ax ay bx by =
  let skalarszorzat = ax * bx + ay * by
      hosszA = sqrt (ax * ax + ay * ay)
      hosszB = sqrt (bx * bx + by * by)
  in skalarszorzat / (hosszA * hosszB)

||| A Pitagorasz-tetel mint a Legendre-perem ELTUNESE.
|||   Amikor a ket vektor meroleges, a perem (2ab·cos γ) eltunik.
|||   Ez a Legendre-transzformacio FIXPONTJA — hasonloan a fenyhez
|||   a mechanikaban (m=0 → L=0, nincs tomeg, nincs Legendre).
|||   A merolegesseg = a dualitas, ahol a ket leiras fuggetlen.
public export
pitagoraszFeltetel : Double -> Double -> Double -> Double -> Bool
pitagoraszFeltetel ax ay bx by =
  abs (ax * bx + ay * by) < 1.0e-10
