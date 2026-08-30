module PróbaVégső

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
xorPApp : PontProba -> PontProba -> PontProba
xorPApp a b = PontProbaK (xorK a.fp1 b.fp1) (xorK a.fp2 b.fp2)

public export
eqK : KubitProba -> KubitProba -> Bool
eqK NullaProba NullaProba = True
eqK EgyProba   EgyProba   = True
eqK _          _          = False

public export
egyenloTeljes : PontProba -> PontProba -> Bool
egyenloTeljes a b =
  eqK (xorPApp a b).fp1 NullaProba && eqK (xorPApp a b).fp2 NullaProba

-- 1. alkalmazás NÉV argumentummal, zárójel nélkül:
bizE : xorPApp negyProba kettoProba = PontProbaK EgyProba EgyProba
bizE = Refl

-- 2. ugyanez ZÁRÓJELLEL:
bizF : (xorPApp negyProba kettoProba = PontProbaK EgyProba EgyProba)
bizF = Refl

-- 3. teljes lánc (&& + projekció), zárójellel:
bizG : (egyenloTeljes negyProba kettoProba) = True
bizG = Refl
