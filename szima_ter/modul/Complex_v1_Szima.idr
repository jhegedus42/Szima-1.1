module Complex_v1_Szima

import Real_v1_Szima

||| Complex numbers as a pair of real numbers: a + b*i.
public export
record Complex where
  constructor MkComplex
  re : Real
  im : Real

public export
Show Complex where
  show (MkComplex a b) = show a ++ " + " ++ show b ++ "i"

public export
Num Complex where
  (+) (MkComplex a b) (MkComplex c d) = MkComplex (a + c) (b + d)
  (*) (MkComplex a b) (MkComplex c d) =
    MkComplex (a * c - b * d) (a * d + b * c)
  fromInteger n = MkComplex (fromInteger n) 0.0

public export
Neg Complex where
  negate (MkComplex a b) = MkComplex (-a) (-b)
  (-) (MkComplex a b) (MkComplex c d) = MkComplex (a - c) (b - d)

public export
conjugate : Complex -> Complex
conjugate (MkComplex a b) = MkComplex a (-b)

public export
normSq : Complex -> Real
normSq (MkComplex a b) = sq a + sq b

public export
norm : Complex -> Real
norm z = sqrt (normSq z)

public export
i : Complex
i = MkComplex 0.0 1.0
