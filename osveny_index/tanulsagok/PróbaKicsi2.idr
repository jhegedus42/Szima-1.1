module PróbaKicsi2

public export
data KubitProba = NullaProba | EgyProba

public export
record PontProba where
  constructor PontProbaK
  fp1 : KubitProba
  fp2 : KubitProba

public export
negyProba : PontProba
negyProba = PontProbaK EgyProba NullaProba

public export
kettoProba : PontProba
kettoProba = PontProbaK NullaProba EgyProba

public export
xorK : KubitProba -> KubitProba -> KubitProba
xorK NullaProba NullaProba = NullaProba
xorK NullaProba EgyProba   = EgyProba
xorK EgyProba   NullaProba = EgyProba
xorK EgyProba   EgyProba   = NullaProba

public export
xorP : PontProba -> PontProba -> PontProba
xorP a b = PontProbaK (xorK a.fp1 b.fp1) (xorK a.fp2 b.fp2)

public export
egyenlőK : KubitProba -> KubitProba -> Bool
egyenlőK NullaProba NullaProba = True
egyenlőK EgyProba   EgyProba   = True
egyenlőK _          _          = False

-- 1. tiszta ékezetes Refl:
bizonyitasEkezet : negyProba = PontProbaK EgyProba NullaProba
bizonyitasEkezet = Refl

-- 2. XOR + projektiók:
bizonyitasXor : xorP negyProba kettoProba = PontProbaK EgyProba EgyProba
bizonyitasXor = Refl

-- 3. && lánc:
bizonyitasEs : (egyenlőK EgyProba EgyProba && egyenlőK NullaProba NullaProba) = True
bizonyitasEs = Refl

-- 4. teljes kombináció:
bizonyitasTeljes : egyenlőK (xorP negyProba kettoProba).fp1 EgyProba = True
bizonyitasTeljes = Refl
