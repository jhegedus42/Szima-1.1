module CayleyDickson_v1_Szima

import Real_v1_Szima

||| A generic Cayley-Dickson doubling over a base type equipped with
||| addition, multiplication, conjugation, and negation.
public export
record CayleyDickson (a : Type) where
  constructor MkCD
  left  : a
  right : a

public export
mapCD : (a -> b) -> CayleyDickson a -> CayleyDickson b
mapCD f (MkCD x y) = MkCD (f x) (f y)

||| Build a Cayley-Dickson multiplication from a base conjugation.
public export
cdMult : (Num a, Neg a) => (a -> a) -> CayleyDickson a -> CayleyDickson a -> CayleyDickson a
cdMult conj (MkCD x y) (MkCD u v) =
  MkCD (x * u - (conj v) * y)
       (v * x + y * (conj u))

||| Cayley-Dickson conjugation.
public export
cdConj : Neg a => (a -> a) -> CayleyDickson a -> CayleyDickson a
cdConj conj (MkCD x y) = MkCD (conj x) (negate y)

||| Embed a base value into the doubled algebra.
public export
cdEmbed : Num a => a -> CayleyDickson a
cdEmbed x = MkCD x (fromInteger 0)

||| The new imaginary unit in the doubled algebra.
public export
cdUnit : Num a => a -> CayleyDickson a
cdUnit x = MkCD (fromInteger 0) x
