module PróbaÉlSoraB

-- PRÓBA B: ugyanaz + em-dash (—) a stringben
%default total

gondolatJel : Nat -> String
gondolatJel szám = "előtte — utána " ++ show szám
