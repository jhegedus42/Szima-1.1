module ProbeQ

import ModulRegisztracio

%default total

kisebbPróba : Bool
kisebbPróba = 3 < 5

vesszősPróba : List Double -> String
vesszősPróba értékek = show (take 2 értékek)

kivonásosEuklidészPróba : Nat -> Nat -> Nat -> Nat
kivonásosEuklidészPróba Z a b = a + b
kivonásosEuklidészPróba (S tovább) Z b = b
kivonásosEuklidészPróba (S tovább) a Z = a
kivonásosEuklidészPróba (S tovább) a b =
  if a < b
    then kivonásosEuklidészPróba tovább b a
    else kivonásosEuklidészPróba tovább (minus a b) b

fejSzámPróba : Nat
fejSzámPróba = kivonásosEuklidészPróba 400 168 64

FejSzámPróba : Nat
FejSzámPróba = fejSzámPróba

bizFejSzámPróba : FejSzámPróba = 8
bizFejSzámPróba = Refl
