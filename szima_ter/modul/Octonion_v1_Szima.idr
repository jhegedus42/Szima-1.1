module Octonion_v1_Szima

import Real_v1_Szima
import Quaternion_v1_Szima

||| Octonions as a pair of quaternions using the Cayley-Dickson doubling.
||| o = (q0, q1) corresponds to q0 + q1 * l where l is the new imaginary unit.
public export
record Octonion where
  constructor MkOctonion
  o0, o1 : Quaternion

public export
Show Octonion where
  show (MkOctonion a b) =
    "(" ++ show a ++ ") + (" ++ show b ++ ")*l"

public export
Num Octonion where
  (+) (MkOctonion a b) (MkOctonion c d) =
    MkOctonion (a + c) (b + d)

  (*) (MkOctonion a b) (MkOctonion c d) =
    MkOctonion
      (a * c - (Quaternion_v1_Szima.conjugate d) * b)
      (d * a + b * (Quaternion_v1_Szima.conjugate c))

  fromInteger n = MkOctonion (fromInteger n) (fromInteger 0)

public export
Neg Octonion where
  negate (MkOctonion a b) = MkOctonion (negate a) (negate b)
  (-) x y = x + (negate y)

public export
conjugate : Octonion -> Octonion
conjugate (MkOctonion a b) = MkOctonion (Quaternion_v1_Szima.conjugate a) (negate b)

public export
normSq : Octonion -> Real
normSq o = normSq (o0 o) + normSq (o1 o)

public export
norm : Octonion -> Real
norm o = sqrt (normSq o)
