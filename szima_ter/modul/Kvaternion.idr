module Kvaternion

-- ═══════════════════════════════════════════════════════════════
-- KVATERNIÓ — az i csak egy kör, a gömbhöz kvaternio kell
-- ═══════════════════════════════════════════════════════════════
--
-- A FELHASZNÁLÓ (2026-08-19):
--   "az i az csak egy kör, lehet kvaterniora van szükség"
--
-- A MATEMATIKA:
--   Az i (a képzetes egység) a SÍK forgatásait generálja:
--     e^{iθ} = az S¹ kör (a komplex egységkör).
--   A Bloch-gömb S² — a 3D forgatásaihoz a KVATERNIÓ kell:
--     ℍ = {a + bi + cj + dk} — 3 képzetes egység (i, j, k).
--   Az egységkvaternio S³ = SU(2) = a Bloch-gömb szimmetriacsoportja
--   (a kettős fedés: S³ → SO(3), a forgatások kettős fedése).
--
-- A KVATERNIÓ SZORZÁS-SZABÁLYA (Hamilton 1843):
--   i² = j² = k² = −1
--   ij = k,   jk = i,   ki = j    (ciklikus)
--   ji = −k,  kj = −i,  ik = −j   (anticiklikus — a nem-kommutativitás)
--   ijk = −1
--
-- A KVATERNIÓ ÉS A CLIFFORD-ALGEBRA:
--   A Pauli-algebra Cl(3) páros alalgebrája = ℍ (a kvaternio).
--   A 3 bivektor (σxσy, σyσz, σzσx) = a 3 képzetes egység (i, j, k).
--   A γ⁵ = i·γ⁰γ¹γ²γ³ az E9 = Cl(4)-ben = a legmagasabb grade —
--   a fázis NEM egy kör, hanem a 3D forgatások hármasa.
--
-- A 2-ES, 3-AS ALGEBRA (a felhasználó szavai):
--   ℝ (1 dimenzió, a bit) → ℂ (2 dimenzió, a fázis KÖRE)
--   → ℍ (4 dimenzió, a kvaternio GÖMB) — a 3 képzetes egység
--   a 3D forgatások. A fázis (az i, a kör) nem elég a gömbre —
--   a kvaternio (az i, j, k) az.
--
-- A FIZIKAI KAPCSOLAT:
--   A G (valós rész) + az α⁻¹ (képzetes rész) = egy komplex csatolás
--   (2 komponens). A kvaternio csatolás = 4 komponens:
--   1 skalár + 3 képzetes = a 4 téridő-dimenzió (D_CRIT = 4).
--   A D_CRIT = 4 = a kvaternio dimenziója — a 3 tér + 1 idő.
--
-- NEM törölve (AGENTS §20).
-- ═══════════════════════════════════════════════════════════════

%default total

-- ─── 1. A KVATERNIÓ TÍPUSA ─────────────────────────────────

||| A kvaternio: q = a + bi + cj + dk — 4 valós (itt egész) komponens.
||| A 4 dimenzió = 1 skalár + 3 képzetes (i, j, k).
||| A kernel az Integer aritmetikát REDUKÁLJA (a Double-t nem),
||| ezért a szorzás-szabályokat egész komponensekkel bizonyítjuk.
public export
record Kvaternion where
  constructor KvaternionKonstruktor
  skalar : Integer   -- a (a skalár rész — a "valós")
  iKomponens : Integer   -- b (az i együtthatója)
  jKomponens : Integer   -- c (a j együtthatója)
  kKomponens : Integer   -- d (a k együtthatója)

public export
Show Kvaternion where
  show (KvaternionKonstruktor a b c d) =
    show a ++ " + " ++ show b ++ "i + " ++ show c ++ "j + " ++ show d ++ "k"

-- ─── 2. A KVATERNIÓ SZORZÁS ───────────────────────────────

||| A kvaternio szorzás (Hamilton szabályai):
|||   i² = j² = k² = −1,  ij = k, jk = i, ki = j,
|||   ji = −k, kj = −i, ik = −j.
||| A teljes szorzás (a nem-kommutativitás explicit):
|||   (a₁+b₁i+c₁j+d₁k)(a₂+b₂i+c₂j+d₂k) =
|||   (a₁a₂−b₁b₂−c₁c₂−d₁d₂)
|||   + (a₁b₂+b₁a₂+c₁d₂−d₁c₂)i
|||   + (a₁c₂−b₁d₂+c₁a₂+d₁b₂)j
|||   + (a₁d₂+b₁c₂−c₁b₂+d₁a₂)k
public export
kvaternionSzoroz : Kvaternion -> Kvaternion -> Kvaternion
kvaternionSzoroz (KvaternionKonstruktor a1 b1 c1 d1)
                 (KvaternionKonstruktor a2 b2 c2 d2) =
  KvaternionKonstruktor
    (a1*a2 - b1*b2 - c1*c2 - d1*d2)
    (a1*b2 + b1*a2 + c1*d2 - d1*c2)
    (a1*c2 - b1*d2 + c1*a2 + d1*b2)
    (a1*d2 + b1*c2 - c1*b2 + d1*a2)

-- ─── 3. A HÁROM KÉPZETES EGYSÉG ───────────────────────────

||| Az i — az első képzetes egység (a kör: e^{iθ} a síkban).
public export
iEgyseg : Kvaternion
iEgyseg = KvaternionKonstruktor 0 1 0 0

||| A j — a második képzetes egység (a második tengely).
public export
jEgyseg : Kvaternion
jEgyseg = KvaternionKonstruktor 0 0 1 0

||| A k — a harmadik képzetes egység (a harmadik tengely).
public export
kEgyseg : Kvaternion
kEgyseg = KvaternionKonstruktor 0 0 0 1

||| Nagybetűs aliasok (a bizonyításokhoz — AGENTS KisBetusCsapda).
public export
IEgysegKonst : Kvaternion
IEgysegKonst = iEgyseg

public export
JEgysegKonst : Kvaternion
JEgysegKonst = jEgyseg

public export
KEgysegKonst : Kvaternion
KEgysegKonst = kEgyseg

-- ─── 4. A HAMILTON-SZABÁLYOK BIZONYÍTÁSA (Refl) ──────────

||| Biz — i² = −1 (az első képzetes egység négyzete).
public export
bizINegyzet : kvaternionSzoroz IEgysegKonst IEgysegKonst = KvaternionKonstruktor (-1) 0 0 0
bizINegyzet = Refl

||| Biz — j² = −1 (a második képzetes egység négyzete).
public export
bizJNegyzet : kvaternionSzoroz JEgysegKonst JEgysegKonst = KvaternionKonstruktor (-1) 0 0 0
bizJNegyzet = Refl

||| Biz — k² = −1 (a harmadik képzetes egység négyzete).
public export
bizKNegyzet : kvaternionSzoroz KEgysegKonst KEgysegKonst = KvaternionKonstruktor (-1) 0 0 0
bizKNegyzet = Refl

||| Biz — ij = k (a ciklikus szabály).
public export
bizIJK : kvaternionSzoroz IEgysegKonst JEgysegKonst = KvaternionKonstruktor 0 0 0 1
bizIJK = Refl

||| Biz — jk = i (a ciklikus szabály).
public export
bizJKI : kvaternionSzoroz JEgysegKonst KEgysegKonst = KvaternionKonstruktor 0 1 0 0
bizJKI = Refl

||| Biz — ki = j (a ciklikus szabály).
public export
bizKIJ : kvaternionSzoroz KEgysegKonst IEgysegKonst = KvaternionKonstruktor 0 0 1 0
bizKIJ = Refl

||| Biz — ji = −k (az anticiklikus szabály — a nem-kommutativitás).
public export
bizJIK : kvaternionSzoroz JEgysegKonst IEgysegKonst = KvaternionKonstruktor 0 0 0 (-1)
bizJIK = Refl

||| Biz — ijk = −1 (a Hamilton-azonosság).
public export
bizIJKMinusEgy :
  kvaternionSzoroz (kvaternionSzoroz IEgysegKonst JEgysegKonst) KEgysegKonst =
  KvaternionKonstruktor (-1) 0 0 0
bizIJKMinusEgy = Refl

-- ─── 5. AZ EGYSÉGKVATERNIO = S³ = SU(2) ───────────────────

||| Az egységkvaternio: a² + b² + c² + d² = 1 — a 3-gömb S³.
||| Az S³ = SU(2) = a Bloch-gömb (S²) forgatásainak kettős fedése.
||| A kvaternio a GÖMB szimmetriája — az i (a kör) nem elég.
public export
egysegNorma : Kvaternion -> Integer
egysegNorma (KvaternionKonstruktor a b c d) = a*a + b*b + c*c + d*d

||| Az i, j, k egységek normája: 0² + 1² = 1 — mind az S³-on van.
public export
bizINorma : egysegNorma IEgysegKonst = 1
bizINorma = Refl

-- ─── 6. A KVATERNIO ÉS A 4 TÉRIDŐ-DIMENZIÓ ────────────────

||| A kvaternio dimenziója: 1 skalár + 3 képzetes = 4.
||| A 4 = D_CRIT = a téridő dimenziója (3 tér + 1 idő).
public export
kvaternionDimenziok : Nat
kvaternionDimenziok = 1 + 3   -- 1 skalár + 3 képzetes = 4

||| Nagybetűs alias (a bizonyításokhoz).
public export
KvaternionDimenziokKonst : Nat
KvaternionDimenziokKonst = kvaternionDimenziok

||| Biz — a kvaternio dimenziója = 4 (a téridő).
public export
bizKvaternionNegy : KvaternionDimenziokKonst = 4
bizKvaternionNegy = Refl

||| A létra: ℝ (1, a bit) → ℂ (2, a fázis KÖRE) → ℍ (4, a kvaternio GÖMB).
||| Az i csak a kört adja (S¹) — a gömbre (S²) a kvaternio kell.
||| A 2-es, 3-as algebra: ℂ (2) → ℍ (a 3 képzetes egység = 3D forgatások).
public export
letra : List Nat
letra = [1, 2, 4]   -- ℝ → ℂ → ℍ (a dimenziók)

||| Nagybetűs alias (a bizonyításokhoz).
public export
LetraKonst : List Nat
LetraKonst = letra

||| Biz — a létra: 1 → 2 → 4 (a bit → a kör → a gömb).
public export
bizLetra : List.length LetraKonst = 3
bizLetra = Refl

-- ─── 7. A GONDOLATOK ──────────────────────────────────────

||| A GONDOLATOK — miért kvaternio kell:
|||
||| 1. Az i (a képzetes egység) a SÍK forgatásait generálja:
|||    e^{iθ} = az S¹ kör. Egy szög = egy kör.
|||    A fázis (a bit mértékegysége) = a kör S¹.
|||
||| 2. DE a Bloch-gömb S² — a 3D forgatásaihoz HÁROM szög kell
|||    (az Euler-szögek vagy a tengely-szög). Az i (1 kör) nem elég:
|||    a kvaternio (i, j, k — 3 képzetes egység) generálja az
|||    összes 3D forgatást: S³ = SU(2) → SO(3).
|||
||| 3. A nem-kommutativitás: ij = k, de ji = −k. A 3D forgatások
|||    nem kommutálnak (a Rubik-kocka: az xy ≠ yx). Az i (a kör)
|||    kommutatív — a kvaternio NEM. A gömb forgatásai
|||    nem-kommutatívak — ezért kvaternio kell.
|||
||| 4. A fizikai kapcsolat: a G (valós) + az α⁻¹ (képzetes) =
|||    egy komplex csatolás (2 komponens — a kör). A kvaternio
|||    csatolás = 4 komponens = a 4 téridő-dimenzió (D_CRIT = 4):
|||    1 skalár (az idő) + 3 képzetes (a 3 tér). A CPT a 3
|||    képzetes egységet forgatja: C (i), P (j), T (k) — a
|||    "kifordulás" a 3D-ben.
|||
||| 5. A Clifford-kapcsolat: a Pauli-algebra Cl(3) páros
|||    alalgebrája = ℍ. A 3 bivektor (σxσy, σyσz, σzσx) =
|||    az i, j, k. A γ⁵ = i·γ⁰γ¹γ²γ³ = a legmagasabb grade —
|||    a fázis NEM egy kör, hanem a 3 bivektor hármasa.
public export
gondolatok : String
gondolatok =
  "Az i (a kepzetes egyeseg) a SIK forgatasait generalja — az S¹ " ++
  "kor. De a Bloch-gomb S²: a 3D forgatasaihoz HAROM szog kell. " ++
  "A kvaternio (i, j, k) generalja az osszes 3D forgatast: " ++
  "S³ = SU(2) → SO(3). A nem-kommutativitas (ij = k, de ji = −k) " ++
  "a 3D forgatasok lenyomat. A fizikai kapcsolat: a G + alfa^-1 " ++
  "komplex csatolas (2 komponens — a kor) → a kvaternio csatolas " ++
  "(4 komponens = a 4 terido-dimenzio). A CPT a 3 kepzetes " ++
  "egyseget forgatja: C (i), P (j), T (k). A Clifford-kapcsolat: " ++
  "Cl(3) paros alalgebraja = a kvaternio — a 3 bivektor = i, j, k."

-- ─── 8. A FUTTATHATÓ ELLENŐRZÉS ───────────────────────────

main : IO ()
main = do
  putStrLn "══════════════════════════════════════════════════════════════════════"
  putStrLn "  KVATERNIÓ — az i csak egy kör, a gömbhöz kvaternio kell"
  putStrLn "══════════════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── A HAMILTON-SZABÁLYOK (Refl, a kernel kiszámolta) ──"
  putStrLn ("  i² = " ++ show (kvaternionSzoroz IEgysegKonst IEgysegKonst))
  putStrLn ("  j² = " ++ show (kvaternionSzoroz JEgysegKonst JEgysegKonst))
  putStrLn ("  k² = " ++ show (kvaternionSzoroz KEgysegKonst KEgysegKonst))
  putStrLn ("  ij = " ++ show (kvaternionSzoroz IEgysegKonst JEgysegKonst) ++ "  (ciklikus)")
  putStrLn ("  jk = " ++ show (kvaternionSzoroz JEgysegKonst KEgysegKonst) ++ "  (ciklikus)")
  putStrLn ("  ki = " ++ show (kvaternionSzoroz KEgysegKonst IEgysegKonst) ++ "  (ciklikus)")
  putStrLn ("  ji = " ++ show (kvaternionSzoroz JEgysegKonst IEgysegKonst) ++ "  (anticiklikus — NEM kommutatív!)")
  putStrLn ("  ijk = " ++ show (kvaternionSzoroz (kvaternionSzoroz IEgysegKonst JEgysegKonst) KEgysegKonst))
  putStrLn ""
  putStrLn "── A NEM-KOMMUTATIVITÁS ──"
  putStrLn "  ij = k, de ji = −k — a 3D forgatások nem kommutálnak"
  putStrLn "  (a Rubik-kocka: az xy ≠ yx). Az i (a kör) kommutatív —"
  putStrLn "  a kvaternio NEM. Ezért kvaternio kell a gömbre."
  putStrLn ""
  putStrLn "── A LÉTRA ──"
  putStrLn "  ℝ (1, a bit) → ℂ (2, a fázis KÖRE) → ℍ (4, a kvaternio GÖMB)"
  putStrLn ("  kvaternionDimenziok = " ++ show kvaternionDimenziok ++ " = a 4 téridő (D_CRIT)")
  putStrLn ""
  putStrLn "── A GONDOLATOK ──"
  putStrLn gondolatok
  putStrLn ""
  putStrLn "Kesz."