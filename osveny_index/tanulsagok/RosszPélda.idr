module RosszPélda

-- ROSSZ PÉLDA (a kisbetűs-csapdára): KISBETŰS konstansnév a bizonyítás TÍPUSÁBAN:
public export
korTermeszetesPontjai : Nat
korTermeszetesPontjai = 2 * 2 * 2

-- az elaborátor itt a "korTermeszetesPontjai"-t ÚJ IMPLICIT ARGUMENTUMNAK
-- köti (nem a fenti definíciót látja!) → a Refl nem redukálódik:
BizKorNyolcRossz : korTermeszetesPontjai = 8
BizKorNyolcRossz = Refl
