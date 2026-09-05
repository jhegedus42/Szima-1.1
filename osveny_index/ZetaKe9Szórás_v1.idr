module ZetaKe9Szórás_v1

import Data.List
import Komplex
import ModulRegisztracio
import DeltaAnalizis_v1   -- §24: piKonstans + aranyMetszés innen, nem újraírva

%default total

-- ═══════════════════════════════════════════════════════════════
-- ζ-KE9 SZÓRÁS_v1 — a zeta_ke9_spectrum.py numerikus magja Idrisben
-- ─────────────────────────────────────────────────────────────
-- A .py három dolgot mér: (1) a ζ(s) nemtrivial gyökeinek
-- Montgomery-párkorrelációját (GUE: P(x) = 1 − (sin πx/πx)²),
-- (2) a K(E9) "Cartan-mátrix" spektrumát, (3) a Berman x1 generátor
-- spektrumát. A rajzoló .py-részt NEM másoljuk (§3); a számítás
-- itt, Idrisben él.
--
-- AZ ÚJDONSÁGOK (amiket ez a modul MEGTALÁLT):
--   * A .py "E9 Cartan-mátrixa" hármascsomópontjának karjai
--     (4,3,1) élhosszúak — a valódi affin E8^(1)-ben (1,2,5).
--     A (4,3,1)-es gráfra NEM létezik pozitív Kac-jelölés
--     (a jelölés-egyensúly 24p = 25p-re kényszerül → csak p = 0),
--     tehát a .py mátrixa NEM affin E8^(1) Cartan-mátrixa.
--   * A valódi affin E8^(1) mátrix nulltere a Kac-jelölés vektora
--     [2,4,6,5,4,3,2,1,3] — ezt Refl bizonyítja (egész, pontos),
--     a jelölések összege 30 = h (Coxeter-szám).
--   * A Berman x1 mátrix a .py állításával ellentétben NEM
--     anti-Hermitian, hanem Hermitian — spektruma VALÓS:
--     λ_k = −2·sin(2πk/10), és 2sin72° = √(2+φ) — az aranymetszés.
--
-- KÉT ÚT, EGY HÍD (a DeltaAnalizis-minta):
--   * ÚT1: a karakterisztikus polinom EGÉSZ aritmetikával,
--     Newton-identitásokból (a hatvány-mátrigyok nyomai + k·e_k =
--     Σ (−1)^{i−1} e_{k−i} p_i — a recidívát 2×2-n kézzel
--     ellenőriztem: A₂ Cartanra [3,−4,1] ✓).
--   * ÚT2: Jacobi-forgatásos sajátérték-számítás (Double) —
--     egészen más algoritmus-osztály.
--   * A híd: a Jacobi-értékekre az ÚT1 polinom ~0-t ad, és a
--     Kac-formula (4sin²(mπ/30)) maradékai eldöntik az affin
--     E8^(1) spektrum-azonosságot.
--
-- | 中文：把 zeta_ke9_spectrum.py 的数值核心移植到 Idris：GUE 配对
--   相关 P(x)=1−(sinπx/πx)²、K(E9) “Cartan 矩阵”谱、Berman x1 谱。
--   发现：.py 矩阵的三叉节点臂长为 (4,3,1)，而真实仿射 E8^(1) 为
--   (1,2,5)；(4,3,1) 无正 Kac 标记（24p=25p 只有零解）；真实仿射
--   E8^(1) 的 Kac 标记零向量 [2,4,6,5,4,3,2,1,3]（和=30=h）由
--   Refl 证明；Berman x1 实为 Hermitian，实谱 −2sin(2πk/10)，
--   含 √(2+φ)。两条独立路线：牛顿恒等式整系数特征多项式 +
--   Jacobi 旋转特征值。
-- | EN: Numerical core of zeta_ke9_spectrum.py in Idris. Findings:
--   the .py "E9 Cartan" node has arm lengths (4,3,1) vs the true
--   affine E8^(1) (1,2,5); no positive Kac labelling exists for
--   (4,3,1); the true affine E8^(1) null vector [2,4,6,5,4,3,2,1,3]
--   is Refl-proven; Berman x1 is Hermitian with real spectrum
--   −2sin(2πk/10) containing √(2+φ). Two independent paths: Newton
--   identity exact charpoly + Jacobi rotation eigenvalues.
-- | DE: Der numerische Kern von zeta_ke9_spectrum.py in Idris.
--   Befunde: die .py-Matrix hat Arme (4,3,1), die echte affine
--   E8^(1) (1,2,5); kein positiver Kac-Markierer für (4,3,1);
--   der Nullvektor [2,4,6,5,4,3,2,1,3] ist per Refl bewiesen;
--   Berman x1 ist hermitesch mit realem Spektrum −2sin(2πk/10)
--   samt √(2+φ). Zwei Wege: Newton-Charakteristikum + Jacobi.
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. A ζ(s) GYÖKÖK — HIVATKOZÁSI ÉRTÉKEK ───────────────────────
-- A .py-ban mpmath.zetazero(n) szolgáltatja őket. Itt az első tíz
-- gyök hivatkozási (Odlyzko-táblából vett) értéke — őszintén jelölve:
-- ezek BEMENETEK, nem számolt eredmények. A rájuk épülő
-- szóköz-statisztika viszont már Idrisben SZÁMÍTOTT.

public export
zetaGyökReferenciák : List Double
zetaGyökReferenciák =
  [ 14.134725142, 21.022039639, 25.010857580, 30.424876126
  , 32.935061588, 37.586178159, 40.918719012, 43.327073281
  , 48.005150881, 49.773832478
  ]

||| γ₁₀₀ = 236,524229665816 — a századik gyök (hivatkozási érték,
||| a .py avg_spacing normalizálásához kell).
public export
zetaSzázadikGyök : Double
zetaSzázadikGyök = 236.524229665816

||| Szomszédos szóközök: (γ₂−γ₁, γ₃−γ₂, …).
public export
szóközSor : List Double -> List Double
szóközSor [] = []
szóközSor [_] = []
szóközSor (x :: y :: többi) = (y - x) :: szóközSor (y :: többi)

||| Lista átlaga (Double).
public export
listaÁtlaga : List Double -> Double
listaÁtlaga xs = sum xs / fromInteger (natToInteger (length xs))

||| A .py avg_spacing-je: az első 100 gyök szóköz-átlaga, a
||| hivatkozási γ₁ és γ₁₀₀ differenciájából (99 szóközre osztva).
public export
átlagosSzóközSzázig : Double
átlagosSzóközSzázig = (zetaSzázadikGyök - 14.134725142) / 99.0

-- ─── 2. A GUE PÁRKORRELÁCIÓ — MONTGOMERY ──────────────────────────
-- A .py gue_pair_correlation: P(x) = 1 − (sin(πx)/(πx))², ahol a
-- sinc(0) = 1 kiegészítés. Ez a GUE (Gauss-i Egységari Enszemble —
-- szokásos fizikai rövidítés, E8-szabályú kivétel) pártaszítás-görbéje.

public export
guePárkorreláció : Double -> Double
guePárkorreláció x = 1.0 - (sinc * sinc)
  where
    sinc : Double
    sinc = if x == 0.0 then 1.0 else sin (piKonstans * x) / (piKonstans * x)

-- ─── 3. POLINOM-ESZKÖZÖK (§24-audit: a projektben máshol nincs) ───
-- Polinom = List Integer, a LEGALACSONYABB foktól felfelé:
-- [c₀, c₁, c₂, …] jelentése c₀ + c₁x + c₂x² + …

public export
poliÖsszead : List Integer -> List Integer -> List Integer
poliÖsszead [] ys = ys
poliÖsszead xs [] = xs
poliÖsszead (x :: xs) (y :: ys) = (x + y) :: poliÖsszead xs ys

||| Polinom értéke x-ben (Horner, a legmagasabb foktól lefelé).
public export
poliÉrték : List Integer -> Double -> Double
poliÉrték p x = foldr (\e => \acc => fromInteger e + x * acc) 0.0 p

-- ─── 4. MÁTRIXMŰVELETEK (egész) ───────────────────────────────────

public export
egészListaEleme : Nat -> List Integer -> Integer
egészListaEleme _ [] = 0
egészListaEleme 0 (x :: _) = x
egészListaEleme (S k) (_ :: xs) = egészListaEleme k xs

||| Nyom (a főátló összege) — 9×9-es mátrixokra, a zip [0..8]-cal.
public export
nyom : List (List Integer) -> Integer
nyom mátrix = sum (zipWith diákon mátrix [0..8])
  where
    diákon : List Integer -> Integer -> Integer
    diákon sor k = egészListaEleme (fromInteger k) sor

public export
mátrixSzorzat : List (List Integer) -> List (List Integer) -> List (List Integer)
mátrixSzorzat a b =
  map (\sor => map (\oszlop => sum (zipWith (*) sor oszlop)) (transpose b)) a

-- ─── 5. ÚT1: KARAKTERISZTIKUS POLINOM NEWTON-IDENTITÁSOKBÓL ───────
-- B_k = A^k, p_k = tr(B_k); e_k az eigenvalue-k elemi szimmetrikus
-- polinomjai; Newton: k·e_k = Σ_{i=1..k} (−1)^{i−1}·e_{k−i}·p_i.
-- charpoly = x⁹ − e₁x⁸ + e₂x⁷ − … − e₉. Minden EGÉSZ, pontos.
-- (Kézi ellenőrzés A₂ Cartanra [[2,−1],[−1,2]]: p₁=4, p₂=10,
--  e₁=4, e₂=(16−10)/2=3 → [3,−4,1] ✓.)

public export
newtonLánc : Nat -> List (List Integer) -> List (List Integer) -> List Integer -> List Integer
-- (hátralévő lépés, A, aktuális B_k, gyűjtött nyomok) → [p₁,…,p₉]
newtonLánc 0 _ _ gyűjtő = gyűjtő
newtonLánc (S hátra) mátrix aktuális gyűjtő =
  newtonLánc hátra mátrix (mátrixSzorzat mátrix aktuális) (gyűjtő ++ [nyom aktuális])

||| Páratlan-e (Nat, `mod` nélkül — a Nat nincs az Integral-osztályban).
public export
páratlan : Nat -> Bool
páratlan 0 = False
páratlan (S 0) = True
páratlan (S (S n)) = páratlan n

||| e_k: k·e_k = Σ_{i=1..k} (−1)^{i−1}·e_{k−i}·p_i, ahol e₀ = 1.
public export
eKövetkező : List Integer -> List Integer -> Nat -> Integer
eKövetkező eddig pk k =
  let eSor = reverse eddig ++ [1]                    -- [e₀, e_{k−1}, …, e₁]
      hármasok = zip [1..k] (zip eSor pk)
      tagok = map (\(i, (ej, pi)) =>
                     (if páratlan i then 1 else -1) * ej * pi) hármasok
  in sum tagok `div` fromInteger (natToInteger k)

||| Az [e₁,…,e₉] együtthatók építése.
public export
newtonEgyütthatók : Nat -> List Integer -> List Integer -> List Integer
newtonEgyütthatók 0 _ eddigi = eddigi
newtonEgyütthatók (S hátra) pk eddigi =
  newtonEgyütthatók hátra pk (eddigi ++ [eKövetkező eddigi pk (S (length eddigi))])

||| A karakterisztikus polinom (legalacsonyabb fok előre):
||| [c₀,…,c₈, 1], ahol c_d = (−1)^{9−d}·e_{9−d}.
public export
newtonKarakterisztika : List (List Integer) -> List Integer
newtonKarakterisztika mátrix =
  let pk = newtonLánc 9 mátrix mátrix []
      ek = newtonEgyütthatók 9 pk []
  in reverse (map (\(i, e) => if páratlan i then negate e else e)
                  (zip [1..9] ek)) ++ [1]

-- ─── 6. A KÉT MÁTRIX — A .py-ÉS A VALÓDI ──────────────────────────

||| A .py "E9 Cartan-mátrixa" (berman_e9_matrix): a Dinjkin-graf
||| 0-1-2-3-4-5-6-7 lánc + a 8. csomópont a 4-hez csatlakozik.
||| A hármascsomópont (4) karjai: 4, 3, 1 él.
public export
aPyMátrix : List (List Integer)
aPyMátrix =
  [ [ 2,-1, 0, 0, 0, 0, 0, 0, 0]
  , [-1, 2,-1, 0, 0, 0, 0, 0, 0]
  , [ 0,-1, 2,-1, 0, 0, 0, 0, 0]
  , [ 0, 0,-1, 2,-1, 0, 0, 0, 0]
  , [ 0, 0, 0,-1, 2,-1, 0, 0,-1]
  , [ 0, 0, 0, 0,-1, 2,-1, 0, 0]
  , [ 0, 0, 0, 0, 0,-1, 2,-1, 0]
  , [ 0, 0, 0, 0, 0, 0,-1, 2, 0]
  , [ 0, 0, 0, 0,-1, 0, 0, 0, 2]
  ]

||| A VALÓDI affin E8^(1) (= E9) Cartan-mátrixa: 0-1-2-3-4-5-6-7
||| lánc + a 8. csomópont a 2-HOZ csatlakozik. Karok: 2, 5, 1 él —
||| csak így létezik pozitív Kac-jelölés, csak így affin.
public export
affinE8Mátrix : List (List Integer)
affinE8Mátrix =
  [ [ 2,-1, 0, 0, 0, 0, 0, 0, 0]
  , [-1, 2,-1, 0, 0, 0, 0, 0, 0]
  , [ 0,-1, 2,-1, 0, 0, 0, 0,-1]
  , [ 0, 0,-1, 2,-1, 0, 0, 0, 0]
  , [ 0, 0, 0,-1, 2,-1, 0, 0, 0]
  , [ 0, 0, 0, 0,-1, 2,-1, 0, 0]
  , [ 0, 0, 0, 0, 0,-1, 2,-1, 0]
  , [ 0, 0, 0, 0, 0, 0,-1, 2, 0]
  , [ 0, 0,-1, 0, 0, 0, 0, 0, 2]
  ]

||| Mátrix · vektor (egész, csak List Integer-re).
public export
szorzatMátrixVektor : List (List Integer) -> List Integer -> List Integer
szorzatMátrixVektor mátrix vektor =
  map (\sor => sum (zipWith (*) sor vektor)) mátrix

||| A Kac-jelölés vektora (az affin E8^(1) nulltere): a csúcs
||| jelölései összegzik a Coxeter-számot: 2+4+6+5+4+3+2+1+3 = 30 = h.
public export
affinE8Nullvektor : List Integer
affinE8Nullvektor = [2, 4, 6, 5, 4, 3, 2, 1, 3]

-- Nagybetűs ALIAZOK a bizonyítás típusához (KisBetűsProjekcióCsapda #1!)
public export
AffinE8MátrixNagy : List (List Integer)
AffinE8MátrixNagy = affinE8Mátrix

public export
AffinE8NullvektorNagy : List Integer
AffinE8NullvektorNagy = affinE8Nullvektor

-- Kimenet: Refl ([0,0,0,0,0,0,0,0,0] ✓) — a Kac-jelölés vektor
-- TENYLEG nullvektora az affin E8^(1) Cartan-mátrixnak (egész,
-- pontos, §18-konform: bal oldal számított, jobb oldal literál).
public export
affinE8NullvektorTanú :
  szorzatMátrixVektor AffinE8MátrixNagy AffinE8NullvektorNagy = [0,0,0,0,0,0,0,0,0]
affinE8NullvektorTanú = Refl

||| A .py mátrix karakterisztikus polinoma (ÚT1, Newton, egész).
public export
aPyKarakterisztika : List Integer
aPyKarakterisztika = newtonKarakterisztika aPyMátrix

||| A valódi affin E8^(1) karakterisztikus polinoma (ÚT1, egész).
public export
affinE8Karakterisztika : List Integer
affinE8Karakterisztika = newtonKarakterisztika affinE8Mátrix

-- ─── 7. ÚT2: JACOBI-FORGATÁSOS SAJÁTÉRTÉK-SZÁMÍTÁS (Double) ───────
-- Klasszikus ciklikus Jacobi: p<q síkbeli forgatás, τ = (aqq−app)/
-- (2apq), t = jel(τ)/(|τ|+√(1+τ²)), c = 1/√(1+t²), s = t·c.
-- 30 teljes söprés (mind a 36 pár) — konvergált, determinisztikus.

public export
duplaListaEleme : Nat -> List Double -> Double
duplaListaEleme _ [] = 0.0
duplaListaEleme 0 (x :: _) = x
duplaListaEleme (S k) (_ :: xs) = duplaListaEleme k xs

public export
duplaListaCserél : Nat -> Double -> List Double -> List Double
duplaListaCserél _ _ [] = []
duplaListaCserél 0 uj (_ :: xs) = uj :: xs
duplaListaCserél (S k) uj (x :: xs) = x :: duplaListaCserél k uj xs

public export
duplaListaSora : Nat -> List (List Double) -> List Double
duplaListaSora _ [] = []
duplaListaSora 0 (sor :: _) = sor
duplaListaSora (S k) (_ :: többi) = duplaListaSora k többi

public export
mátrixSorCserél : Nat -> List Double -> List (List Double) -> List (List Double)
mátrixSorCserél _ _ [] = []
mátrixSorCserél 0 uj (_ :: többi) = uj :: többi
mátrixSorCserél (S k) uj (sor :: többi) = sor :: mátrixSorCserél k uj többi

public export
mátrixElemD : List (List Double) -> Nat -> Nat -> Double
mátrixElemD m i j = duplaListaEleme j (duplaListaSora i m)

public export
mátrixElemRakD : Nat -> Nat -> Double -> List (List Double) -> List (List Double)
mátrixElemRakD i j uj m =
  mátrixSorCserél i (duplaListaCserél j uj (duplaListaSora i m)) m

||| Az i ≠ p,q sorok [p]- és [q]-oszlopának frissítése i-től felfelé.
public export
oszlopFrissítések : Nat -> Nat -> Nat -> Nat -> Double -> Double ->
                    List (List Double) -> List (List Double)
oszlopFrissítések 0 _ _ _ _ _ m = m
oszlopFrissítések (S hátra) i p q c s m =
  let frissített =
        if i == p || i == q then m
        else let aip = mátrixElemD m i p
                 aiq = mátrixElemD m i q
             in mátrixElemRakD i q (s * aip + c * aiq)
                   (mátrixElemRakD i p (c * aip - s * aiq) m)
  in oszlopFrissítések hátra (S i) p q c s frissített

||| A p, q sorok visszamásolása a frissített oszlopokból (szimmetria).
public export
sorVisszaMásolások : Nat -> Nat -> Nat -> Nat -> List (List Double) -> List (List Double)
sorVisszaMásolások 0 _ _ _ m = m
sorVisszaMásolások (S hátra) j p q m =
  let frissített =
        if j == p || j == q then m
        else mátrixElemRakD q j (mátrixElemD m j q)
               (mátrixElemRakD p j (mátrixElemD m j p) m)
  in sorVisszaMásolások hátra (S j) p q frissített

||| Egy (p,q) forgatás teljes végrehajtása.
public export
jacobiForgatás : Nat -> Nat -> List (List Double) -> List (List Double)
jacobiForgatás p q m =
  let apq = mátrixElemD m p q
  in if abs apq < 1.0e-30 then m
     else let app = mátrixElemD m p p
              aqq = mátrixElemD m q q
              tau = (aqq - app) / (2.0 * apq)
              jel = if tau >= 0.0 then 1.0 else -1.0
              t = jel / (abs tau + sqrt (1.0 + tau * tau))
              c = 1.0 / sqrt (1.0 + t * t)
              s = t * c
              oszlopok = oszlopFrissítések 9 0 p q c s m
              visszamásolt = sorVisszaMásolások 9 0 p q oszlopok
              appUj = app - t * apq
              aqqUj = aqq + t * apq
          in mátrixElemRakD q q aqqUj
               (mátrixElemRakD q p 0.0
                 (mátrixElemRakD p q 0.0
                   (mátrixElemRakD p p appUj visszamásolt)))

||| A 36 forgatási pár (ciklikus söprés sorrendje).
public export
jacobiPárok : List (Nat, Nat)
jacobiPárok =
  [ (0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8)
  , (1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8)
  , (2,3),(2,4),(2,5),(2,6),(2,7),(2,8)
  , (3,4),(3,5),(3,6),(3,7),(3,8)
  , (4,5),(4,6),(4,7),(4,8)
  , (5,6),(5,7),(5,8)
  , (6,7),(6,8)
  , (7,8)
  ]

public export
jacobiPárokÁt : List (Nat, Nat) -> List (List Double) -> List (List Double)
jacobiPárokÁt [] m = m
jacobiPárokÁt ((p, q) :: többi) m = jacobiPárokÁt többi (jacobiForgatás p q m)

||| 30 teljes söprés utáni sajátérték-diagonal (növekvő sorrendben).
public export
jacobiSpektrum : List (List Double) -> List Double
jacobiSpektrum m =
  let diagonal = jacobiSpektrumLépések 30 m
  in sort (map (\i => mátrixElemD diagonal i i) [0..8])
  where
    jacobiSpektrumLépések : Nat -> List (List Double) -> List (List Double)
    jacobiSpektrumLépések 0 m = m
    jacobiSpektrumLépések (S k) m = jacobiSpektrumLépések k (jacobiPárokÁt jacobiPárok m)

||| A két mátrix Double-változata.
public export
aPyMátrixD : List (List Double)
aPyMátrixD = map (map fromInteger) aPyMátrix

public export
affinE8MátrixD : List (List Double)
affinE8MátrixD = map (map fromInteger) affinE8Mátrix

||| Pozitív szemidefinitség gépi tesztje (tűrés: 10⁻⁹).
public export
mindNemNegatív : List Double -> Bool
mindNemNegatív = all (\x => x >= negate 1.0e-9)

-- ─── 8. AZ AFFIN E8^(1) SPEKTRUM — AZ ARANYMETSZÉS-JELENTÉS ───────
-- A gép (két út) szerint az affin E8^(1) Cartan-mátrix sajátértékei:
--   {0} ∪ {2 − 2, 2 − φ, 2 − 1, 2 − 1/φ, 2, 2 + 1/φ, 2 + 1, 2 + φ}
-- = {0, 0.381966…, 1, 1.381966…, 2, 2.618034…, 3, 3.618034…, 4},
-- szimmetrikusan a 2 körül: 2 ± {2, φ, 1, φ⁻¹} — a φ KÉTSZER is
-- megjelenik! (A korábbi "4sin²(mπ/30)-emlékezet" a gép szerint
-- HAMIS — a maradék-táblát megőrizzük mint megfalsított hipotézist.)

public export
kacSajátérték : Nat -> Double
kacSajátérték m = 4.0 * (szinusz * szinusz)
  where
    szinusz : Double
    szinusz = sin (fromInteger (natToInteger m) * piKonstans / 30.0)

public export
kacNégyKülönböző : List Double
kacNégyKülönböző = map kacSajátérték [1, 7, 11, 13]

||| A téves "4sin²(mπ/30)-hipotézis" maradékai (NEM ~0 → hamis).
public export
kacHídMaradékok : List Double
kacHídMaradékok =
  map (\s => abs (poliÉrték affinE8Karakterisztika s)) kacNégyKülönböző

||| Az affin E8^(1) gépi sajátértékei (Jacobi, növekvő sorrend).
public export
affinE8Sajátértékek : List Double
affinE8Sajátértékek = jacobiSpektrum affinE8MátrixD

||| |λ₁ − (2 − φ)| — az alsó aranymetszés-tanú (elvileg ~10⁻¹⁶).
public export
fiMaradékAlacsony : Double
fiMaradékAlacsony = abs (duplaListaEleme 1 affinE8Sajátértékek - (2.0 - aranyMetszés))

||| |λ₇ − (2 + φ)| — a felső aranymetszés-tanú (elvileg ~10⁻¹⁶).
public export
fiMaradékMagas : Double
fiMaradékMagas = abs (duplaListaEleme 7 affinE8Sajátértékek - (2.0 + aranyMetszés))

-- ─── 9. SZÁMSZERŰ GYÖKÖK — BIZREKCIÓ az ÚT1 polinomon ─────────────

public export
előjelPár : Double -> Double -> Bool
előjelPár u v = (u <= 0.0 && v >= 0.0) || (u >= 0.0 && v <= 0.0)

||| Bizrekció egy előjelváltó [a,b] intervallumon (rögzített lépésszám).
public export
bizrekcióGyök : (Double -> Double) -> Double -> Double -> Nat -> Double
bizrekcióGyök f a b 0 = (a + b) / 2.0
bizrekcióGyök f a b (S k) =
  let közép = (a + b) / 2.0
  in if előjelPár (f a) (f közép)
       then bizrekcióGyök f a közép k
       else bizrekcióGyök f közép b k

||| Szken: [kezdet, kezdet + lépés·lépésszám] tartományon minden
||| előjelváltó intervallumot bizrekcióval pontosít.
public export
gyökSzen : (Double -> Double) -> Double -> Double -> Nat -> List Double
gyökSzen f _ _ 0 = []
gyökSzen f x lépés@_ (S k) =
  let következő = x + lépés
      előtag = if előjelPár (f x) (f következő)
                 then [bizrekcióGyök f x következő 80]
                 else []
  in előtag ++ gyökSzen f következő lépés k

||| A .py mátrix charpoly-gyökei (Gershgorin: λ ∈ [−3, 5]-be zárva).
public export
aPyPolinomGyökök : List Double
aPyPolinomGyökök =
  gyökSzen (\x => poliÉrték aPyKarakterisztika x) (negate 3.4) 0.02 431

||| Az affin E8^(1) charpoly-gyökei (előjelváltók — a kettős gyökök
||| nem váltanak előjelet, ezért itt csak a " egyszeresek" látszanak).
public export
affinE8PolinomGyökök : List Double
affinE8PolinomGyökök =
  gyökSzen (\x => poliÉrték affinE8Karakterisztika x) (negate 3.4) 0.02 431

-- ─── 10. A BERMAN x1 GENERÁTOR (K(E10)) ───────────────────────────
-- A .py M[i,i+1] = i, M[i+1,i] = −i, M[0,9] = i, M[9,0] = −i —
-- ez i·C, ahol C az IRÁNYÍTOTT tízes-csúcsor skew-szimmetrikus
-- szomszédsági mátrixa. M Hermitian (M† = M), nem anti-Hermitian!
-- Sajátértékei VALÓSAK: λ_k = −2·sin(2πk/10), k = 0…9
-- (az u_k(j) = e^{2πikj/10} vektorra: i(v_{j+1} − v_{j−1})
--  = i·v_j(ω − ω̄) = −2sin(2πk/10)·v_j).

public export
bermanSajátérték : Nat -> Double
bermanSajátérték k =
  negate (2.0 * sin (2.0 * piKonstans * fromInteger (natToInteger k) / 10.0))

public export
bermanSpektrum : List Double
bermanSpektrum = map bermanSajátérték [0..9]

||| Az u_k(j) = e^{2πi·k·j/10} sajátvektor (List Komplex, j = 0…9).
public export
sajátvektorKomplex : Nat -> List Komplex
sajátvektorKomplex k =
  [ euler (2.0 * piKonstans * fromInteger (natToInteger k) * fromInteger (natToInteger j) / 10.0)
  | j <- [0..9]
  ]

||| Lista eleje forgatva balra: [a₀,a₁,…,a₉] → [a₁,…,a₉,a₀]
||| (a j-edik helyen most a_{j+1} áll).
public export
listaElejeForgat : List a -> List a
listaElejeForgat [] = []
listaElejeForgat (x :: xs) = xs ++ [x]

||| Lista utolsó eleme tartalékkal (a base `last` NonEmpty-pereme
||| számított listára nem köthető — ezért totál helyi változat).
public export
listaUtolsóVagy : a -> List a -> a
listaUtolsóVagy tartalék [] = tartalék
listaUtolsóVagy _ (y :: ys) = listaUtolsóVagy y ys

||| Lista kezdete (init) — totál, üresen is.
public export
listaKezdete : List a -> List a
listaKezdete [] = []
listaKezdete [_] = []
listaKezdete (x :: y :: ys) = x :: listaKezdete (y :: ys)

||| Lista vége forgatva jobbra: [a₀,…,a₉] → [a₉,a₀,…,a₈]
||| (a j-edik helyen most a_{j−1} áll).
public export
listaVégeForgat : List a -> List a
listaVégeForgat [] = []
listaVégeForgat [x] = [x]
listaVégeForgat (x :: y :: ys) =
  listaUtolsóVagy y ys :: x :: listaKezdete (y :: ys)

||| A ‖Mv − λv‖ maradéknorma a k-adik sajátvektoron — a formula-út
||| numerikus tanúja (elvileg ~10⁻¹⁴).
public export
bermanMaradékNorma : Nat -> Double
bermanMaradékNorma k =
  let v = sajátvektorKomplex k
      bal = listaElejeForgat v            -- v_{j+1}
      jobb = listaVégeForgat v            -- v_{j−1}
      lambda = bermanSajátérték k
      párok = zip bal (zip jobb v)
      maradékok =
        map (\(bj, (jj, vj)) =>
          kKivon (kSzoroz (K 0.0 1.0) (kKivon bj jj)) (kSzoroz (K lambda 0.0) vj))
          párok
  in sqrt (sum (map (\r => let méret = kAbs r in méret * méret) maradékok))

||| |2sin(72°) − √(2+φ)| — az aranymetszés megjelenése a
||| Berman-spektrumban (elvileg ~10⁻¹⁶).
public export
bermanAranymetszésKülönbség : Double
bermanAranymetszésKülönbség =
  abs (negate (bermanSajátérték 2) - sqrt (2.0 + aranyMetszés))

-- ─── 11. A FŐPROGRAM — Show-kimenet (GAUGE: olvasd!) ──────────────

||| Egy tábla-sor: címke + Double érték.
főSor : String -> Double -> String
főSor címke érték@_ = "  " ++ címke ++ " = " ++ show érték

||| GUE-tábla Show-sorokban (tiszta függvény, az IO csak a perem).
gueTábla : List Double -> String
gueTábla [] = ""
gueTábla (x :: többi) =
  főSor ("P(" ++ show x ++ ")") (guePárkorreláció x) ++ "\n" ++ gueTábla többi

main : IO ()
main = do
  putStrLn "=== ζ-GYÖKÖK + K(E9) SPEKTRUM — Idrisben (zeta_ke9_spectrum.py átirata) ==="
  putStrLn ""
  putStrLn "=== 1. A ζ(s) első 10 nemtrivial gyöke (HIVATKOZÁSI értékek, Odlyzko) ==="
  putStrLn ("  γ₁…γ₁₀ = " ++ show zetaGyökReferenciák)
  putStrLn ("  szóközök (γₙ₊₁−γₙ) = " ++ show (szóközSor zetaGyökReferenciák))
  putStrLn ("  10 gyökre átlagos szóköz = "
            ++ show (listaÁtlaga (szóközSor zetaGyökReferenciák)))
  putStrLn ("  a .py avg_spacing-je (első 100 gyökre) = " ++ show átlagosSzóközSzázig)
  putStrLn ""
  putStrLn "=== 2. Montgomery-párkorreláció vs GUE: P(x) = 1 − (sin πx/πx)² ==="
  putStr (gueTábla [0.0, 0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0, 5.0])
  putStrLn ("  első ζ-szóköz normalizálva (γ₂−γ₁)/⟨s⟩₁₀₀ = "
            ++ show ((21.022039639 - 14.134725142) / átlagosSzóközSzázig))
  putStrLn ("  GUE-várakozás ott: P = "
            ++ show (guePárkorreláció ((21.022039639 - 14.134725142) / átlagosSzóközSzázig)))
  putStrLn ""
  putStrLn "=== 3. K(E9): a .py mátrixa — ÚT1 (Newton, egész) ==="
  putStrLn ("  ÚT1 karakterisztikus polinom: " ++ show aPyKarakterisztika)
  putStrLn ("  gyökei (bizrekció):           " ++ show aPyPolinomGyökök)
  putStrLn ("  gyökök száma: " ++ show (length aPyPolinomGyökök) ++ " (a mátrix mérete: 9)")
  putStrLn ("  Jacobi-forgatásos sajátértékek (ÚT2): " ++ show (jacobiSpektrum aPyMátrixD))
  putStrLn ("  pozitív szemidefinít? " ++ show (mindNemNegatív (jacobiSpektrum aPyMátrixD)))
  putStrLn ""
  putStrLn "=== 4. A VALÓDI affin E8^(1) = E9 Cartan-mátrixa (karok 1,2,5) ==="
  putStrLn ("  ÚT1 karakterisztikus polinom: " ++ show affinE8Karakterisztika)
  putStrLn ("  gyökei (bizrekció — csak az egyszeresek!): " ++ show affinE8PolinomGyökök)
  putStrLn ("  Jacobi-forgatásos sajátértékek (ÚT2): " ++ show (jacobiSpektrum affinE8MátrixD))
  putStrLn ("  pozitív szemidefinít? " ++ show (mindNemNegatív (jacobiSpektrum affinE8MátrixD)))
  putStrLn "  nullvektor-tanú (Refl): Kac-jelölés [2,4,6,5,4,3,2,1,3], összege 30 = h ✓"
  putStrLn ("  a (téves) 4sin²(mπ/30)-hipotézis |F| maradékai: " ++ show kacHídMaradékok ++ "  → HAMIS")
  putStrLn "  a helyes spektrum (két úttal megerősítve): 0 ∪ 2±{2, φ, 1, φ⁻¹}"
  putStrLn ("  alsó φ-tanú |λ₁−(2−φ)| = " ++ show fiMaradékAlacsony)
  putStrLn ("  felső φ-tanú |λ₇−(2+φ)| = " ++ show fiMaradékMagas)
  putStrLn ""
  putStrLn "=== 5. Berman x1 (K(E10)): Hermitian, VALÓS spektrum λ_k = −2sin(2πk/10) ==="
  putStrLn ("  spektrum: " ++ show bermanSpektrum)
  putStrLn ("  maradék-tanú ‖Mv−λv‖ k=2-re: " ++ show (bermanMaradékNorma 2))
  putStrLn ("  maradék-tanú ‖Mv−λv‖ k=1-re: " ++ show (bermanMaradékNorma 1))
  putStrLn ("  |2sin72° − √(2+φ)| = " ++ show bermanAranymetszésKülönbség
            ++ "  (φ = aranymetszés — a Berman-spektrumban ÚJRA φ!)")
  putStrLn ""
  putStrLn "=== MIT JELENT (projekt-nyelven) ==="
  putStrLn "  a) a .py 'E9 Cartan' mátrixa ROSSZ Dinjkin-grafon áll ((4,3,1) karok;"
  putStrLn "     nincs pozitív Kac-jelölés) — a valódi affin E8^(1): (1,2,5) karok,"
  putStrLn "     Kac-jelölés [2,4,6,5,4,3,2,1,3] (Refl ✓), spektruma 0 ∪ 2±{2, φ, 1, φ⁻¹}."
  putStrLn "  b) ζ-gyökök pártaszítása (GUE) ↔ affin Cartan 0-s sajátértéke:"
  putStrLn "     mindkettő 'a kapcsolat fázisa' (T-kubit) — Hilbert–Pólya lánc."
  putStrLn "  c) a Berman x1 spektrumának φ-arányai: a hurokváltozó (t→t⁻¹)"
  putStrLn "     forgatása az aranymetszés-kontrakción él (Komplex.idr φ-spirál!)"
  putStrLn "Kész."

-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ────────────────────────────
public export
ZetaKe9SzórásLeiras : ModulLeirasT
ZetaKe9SzórásLeiras = ModulLeirasKonstruktor
  "ZetaKe9Szórás_v1.idr"
  "GUE P(x)=1−sinc²; K(E9) sajátértékek KÉT független úton (Newton-identitásos egész karakterisztika + Jacobi-forgatás); affin E8^(1) nullvektor Refl-lel; Berman x1 valós spektruma −2sin(2πk/10)"
  "a zeta_ke9_spectrum.py numerikus magja Idrisben; felfedés: a .py Cartan-mátrixa (karok 4,3,1) nem affin — a valódi (1,2,5)"
  "Show-teszt + Refl-nullvektor"
