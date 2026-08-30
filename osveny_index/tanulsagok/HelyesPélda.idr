module HelyesPélda

-- HELYES PÉLDA (a kisbetűs-csapda gyógyírát mutatja):

public export
KorTermeszetesPontjai : Nat
KorTermeszetesPontjai = 2 * 2 * 2

-- Nagybetűs név: az elaborátor már NEM kötheti implicitnek
-- (az implicit kötés csak kisbetűs névre él) → a definícióra hivatkozik
-- → kifejtés → 2*2*2 → 8 → a típus 8 = 8 → Refl belefér:
BizKorNyolc : KorTermeszetesPontjai = 8
BizKorNyolc = Refl
