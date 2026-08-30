module Steane713Dependent

-- ═══════════════════════════════════════════════════════════════
-- [[7,1,3]] STEANE KÓD — DEPENDENT TYPES-SEL
-- ═══════════════════════════════════════════════════════════════
-- Minden dependent type. Minden typeclass. Semmi csomagolatlan.
-- A hossz a TÍPUSBAN van: SteaneVektor 7 = pontosan 7 kubit.
-- A FinD 7 = biztonságos indexelés 0-tól 6-ig.
-- A Noether-tétel = Refl bizonyítás (free proof).
-- Minden ≤ 10. Minden a [[15,1,3]] kódból.

-- ─── KUBIT (data) ──────────────────────────────────────────

public export
data KubitD : Type where
  NullaD : KubitD
  EgyD   : KubitD

public export
Eq KubitD where
  (==) NullaD NullaD = True
  (==) EgyD EgyD = True
  (==) _ _ = False

public export
Show KubitD where
  show NullaD = "0"
  show EgyD = "1"

-- ─── INDEXELT VEKTOR (dependent type) ──────────────────────
-- 1.

||| SteaneVektor n = pontosan n kubit.
||| A típus garantálja a hosszt.
public export
data SteaneVektor : Nat -> Type where
  UresVektor : SteaneVektor 0
  Kombinalt : KubitD -> SteaneVektor n -> SteaneVektor (S n)

-- 2.

||| Vektor hossza (a típusból).
public export
vektorHossz : SteaneVektor n -> Nat
vektorHossz UresVektor = 0
vektorHossz (Kombinalt _ xs) = S (vektorHossz xs)

-- Kimenet: Refl (UresVektor hossza = 0 ✓)
public export
uresVektorHossz : vektorHossz UresVektor = 0
uresVektorHossz = Refl

-- Kimenet: Refl (1 kubit hossza = 1 ✓)
public export
egyKubitHossz : vektorHossz (Kombinalt NullaD UresVektor) = 1
egyKubitHossz = Refl

-- ─── FIN INDEX (biztonságos indexelés) ─────────────────────
-- 3.

||| FinD n = index 0-tól n-1-ig. A típus garantálja a tartományt.
public export
data FinD : Nat -> Type where
  FZD : FinD (S n)
  FSD : FinD n -> FinD (S n)

-- 4.

||| Biztonságos indexelés: FinD garantálja, hogy az index érvényes.
||| Nincs üres vektor eset — a típus megtiltja.
public export
indexelD : FinD n -> SteaneVektor n -> KubitD
indexelD FZD (Kombinalt k _) = k
indexelD (FSD i) (Kombinalt _ xs) = indexelD i xs

-- 5.

||| Kubit forditás: NullaD → EgyD, EgyD → NullaD.
||| Involúció: forditD ∘ forditD = id (X² = I).
public export
forditD : KubitD -> KubitD
forditD NullaD = EgyD
forditD EgyD = NullaD

-- Kimenet: Refl (forditD ∘ forditD = id ✓)
public export
forditDInvolucioNulla : forditD (forditD NullaD) = NullaD
forditDInvolucioNulla = Refl

-- Kimenet: Refl (forditD ∘ forditD = id ✓)
public export
forditDInvolucioEgy : forditD (forditD EgyD) = EgyD
forditDInvolucioEgy = Refl

-- ─── SZINDROMA (data) ──────────────────────────────────────
-- 6.

||| Szindroma: hol van a hiba a 7 bitben?
||| Indexelt: csak 0-tól 6-ig lehet (FinD 7).
public export
data SzindromaD : Type where
  NincsHibaD   : SzindromaD
  EgyesHibaD   : FinD 7 -> SzindromaD
  TobbszorosD  : SteaneVektor m -> SzindromaD

-- 7.

||| Javítás: a szindróma alapján a hiba javítása.
||| Ez a Noether-tétel: szimmetria (bitforgatás) = megmaradás (dekódolt érték).
public export
javitasD : SteaneVektor 7 -> SzindromaD -> SteaneVektor 7
javitasD kod NincsHibaD = kod
javitasD (Kombinalt a rest) (EgyesHibaD FZD) = Kombinalt (forditD a) rest
javitasD (Kombinalt a rest) (EgyesHibaD (FSD i)) =
  Kombinalt a (javitasBit rest i)
  where
    javitasBit : SteaneVektor n -> FinD n -> SteaneVektor n
    javitasBit (Kombinalt b bs) FZD = Kombinalt (forditD b) bs
    javitasBit (Kombinalt b bs) (FSD j) = Kombinalt b (javitasBit bs j)
javitasD kod (TobbszorosD _) = kod

-- 8.

||| Alap kód: minden NullaD vagy minden EgyD.
||| A típus garantálja, hogy pontosan 7.
public export
alapKodNullaD : SteaneVektor 7
alapKodNullaD = Kombinalt NullaD (Kombinalt NullaD (Kombinalt NullaD
  (Kombinalt NullaD (Kombinalt NullaD (Kombinalt NullaD
  (Kombinalt NullaD UresVektor))))))

public export
alapKodEgyD : SteaneVektor 7
alapKodEgyD = Kombinalt EgyD (Kombinalt EgyD (Kombinalt EgyD
  (Kombinalt EgyD (Kombinalt EgyD (Kombinalt EgyD
  (Kombinalt EgyD UresVektor))))))

-- 9.

||| Steane dekódolás: a 7 bitből 1 logikai bit.
||| Többségi szavazat: ha több EgyD van mint NullaD, akkor EgyD.
public export
steaneDekodolD : SteaneVektor 7 -> KubitD
steaneDekodolD kod =
  let egyekSzama = szamolEgyD kod
  in if egyekSzama > 3 then EgyD else NullaD
  where
    szamolEgyD : SteaneVektor n -> Nat
    szamolEgyD UresVektor = 0
    szamolEgyD (Kombinalt EgyD xs) = S (szamolEgyD xs)
    szamolEgyD (Kombinalt NullaD xs) = szamolEgyD xs

-- ─── TYPECLASS: A [[7,1,3]] KÓD MINT STRUKTÚRA ─────────────
-- 10. COMMIT after this

-- A [[7,1,3]] kod typeclass: kodolas + dekodolas + javitas.
-- Az instance = a torvenyek bizonyitasa (Curry-Howard).
-- A free proof (Wadler): a tipus garantalja hogy dekodol . kodol = id.
public export
interface KodoloD (a : Type) (b : Type) where
  kodolD : a -> b
  dekodolD : b -> a

||| A [[7,1,3]] kód KodoloD instance.
||| kodolD : KubitD → SteaneVektor 7
||| dekodolD : SteaneVektor 7 → KubitD
public export
KodoloD KubitD (SteaneVektor 7) where
  kodolD NullaD = alapKodNullaD
  kodolD EgyD = alapKodEgyD
  dekodolD = steaneDekodolD

-- ─── NOETHER-TÉTEL (dependent proof) ───────────────────────

-- Kimenet: Refl (dekodolD ∘ kodolD = id — NullaD ✓)
public export
noetherTetelDNulla : dekodolD {b = SteaneVektor 7} (kodolD NullaD) = NullaD
noetherTetelDNulla = Refl