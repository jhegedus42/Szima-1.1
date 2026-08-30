module Real_v1_Szima

||| The ground real number type used throughout the algebra hierarchy.
||| We fix it to Double for concrete computation.
public export
Real : Type
Real = Double

||| Three concrete views of the reals, matching the user's request for
||| "three reals": additive group, multiplicative monoid, and normed field.
public export
record RealAdd where
  constructor MkRealAdd
  value : Real

public export
record RealMul where
  constructor MkRealMul
  value : Real

public export
record RealNorm where
  constructor MkRealNorm
  value : Real

public export
Num RealAdd where
  (MkRealAdd x) + (MkRealAdd y) = MkRealAdd (x + y)
  (MkRealAdd x) * (MkRealAdd y) = MkRealAdd (x + y)  -- additive notation reused
  fromInteger n = MkRealAdd (fromInteger n)

public export
Num RealMul where
  (MkRealMul x) + (MkRealMul y) = MkRealMul (x * y)  -- multiplicative notation reused
  (MkRealMul x) * (MkRealMul y) = MkRealMul (x * y)
  fromInteger n = MkRealMul (fromInteger n)

public export
Num RealNorm where
  (MkRealNorm x) + (MkRealNorm y) = MkRealNorm (abs x + abs y)
  (MkRealNorm x) * (MkRealNorm y) = MkRealNorm (abs x * abs y)
  fromInteger n = MkRealNorm (abs (fromInteger n))

public export
Show RealAdd where
  show (MkRealAdd x) = "RealAdd(" ++ show x ++ ")"

public export
Show RealMul where
  show (MkRealMul x) = "RealMul(" ++ show x ++ ")"

public export
Show RealNorm where
  show (MkRealNorm x) = "RealNorm(" ++ show x ++ ")"

public export
absReal : Real -> Real
absReal = abs

public export
sq : Real -> Real
sq x = x * x
