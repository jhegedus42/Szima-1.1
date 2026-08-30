module Quaternion_v1_Szima

import Real_v1_Szima

||| Quaternions as a four-tuple of reals: q0 + q1*i + q2*j + q3*k.
public export
record Quaternion where
  constructor MkQuaternion
  q0, q1, q2, q3 : Real

public export
Show Quaternion where
  show (MkQuaternion a b c d) =
    show a ++ " + " ++ show b ++ "i + " ++ show c ++ "j + " ++ show d ++ "k"

public export
Num Quaternion where
  (+) (MkQuaternion a0 a1 a2 a3) (MkQuaternion b0 b1 b2 b3) =
    MkQuaternion (a0 + b0) (a1 + b1) (a2 + b2) (a3 + b3)

  (*) (MkQuaternion a0 a1 a2 a3) (MkQuaternion b0 b1 b2 b3) =
    MkQuaternion
      (a0*b0 - a1*b1 - a2*b2 - a3*b3)
      (a0*b1 + a1*b0 + a2*b3 - a3*b2)
      (a0*b2 - a1*b3 + a2*b0 + a3*b1)
      (a0*b3 + a1*b2 - a2*b1 + a3*b0)

  fromInteger n = MkQuaternion (fromInteger n) 0.0 0.0 0.0

public export
Neg Quaternion where
  negate (MkQuaternion a0 a1 a2 a3) =
    MkQuaternion (-a0) (-a1) (-a2) (-a3)
  (-) x y = x + (negate y)

public export
conjugate : Quaternion -> Quaternion
conjugate (MkQuaternion a0 a1 a2 a3) = MkQuaternion a0 (-a1) (-a2) (-a3)

public export
normSq : Quaternion -> Real
normSq (MkQuaternion a0 a1 a2 a3) = sq a0 + sq a1 + sq a2 + sq a3

public export
norm : Quaternion -> Real
norm q = sqrt (normSq q)

public export
i, j, k : Quaternion
i = MkQuaternion 0.0 1.0 0.0 0.0
j = MkQuaternion 0.0 0.0 1.0 0.0
k = MkQuaternion 0.0 0.0 0.0 1.0
