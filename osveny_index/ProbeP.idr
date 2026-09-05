module ProbeP

import ModulRegisztracio

%default total

vesszoProba : List Double -> String
vesszoProba ertekek =
  concat (intersperse ", " (map show ertekek))

osztóPróba : Nat
osztóPróba = gcd 8 12

halmazPróba : Nat
halmazPróba = div 12 4
