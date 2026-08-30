module PróbaKicsi3

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
xorK : KubitProba -> KubitProba -> KubitProba
xorK NullaProba NullaProba = NullaProba
xorK NullaProba EgyProba   = EgyProba
xorK EgyProba   NullaProba = EgyProba
xorK EgyProba   EgyProba   = NullaProba

-- a) alkalmazás a bal oldalon (Teszt-minta):
bizA : xorK NullaProba NullaProba = NullaProba
bizA = Refl

-- b) csupusz név a bal oldalon, zárójel NÉLKÜL:
bizB : negyProba = PontProbaK EgyProba NullaProba
bizB = Refl

-- c) csupusz név a bal oldalon, ZÁRÓJELLEL:
bizC : (negyProba = PontProbaK EgyProba NullaProba)
bizC = Refl

-- d) név a JOBB oldalon:
bizD : PontProbaK EgyProba NullaProba = negyProba
bizD = Refl

public export
kettoProba : PontProba
kettoProba = PontProbaK NullaProba EgyProba

public export
xorPApp : PontProba -> PontProba -> PontProba
xorPApp a b = PontProbaK (xorK a.fp1 b.fp1) (xorK a.fp2 b.fp2)

-- e) alkalmazás NÉV argumentummal, zárójel nélkül: alkalmazás NÉV argumentummal, zárójel nélkül:
bizE : xorPApp negyProba kettoProba = PontProbaK EgyProba EgyProba
bizE = Refl

-- f) ugyanez ZÁRÓJELLEL:
bizF : (xorPApp negyProba kettoProba = PontProbaK EgyProba EgyProba)
bizF = Refl

-- g) teljes lánc, zárójellel:
bizG : (egyenloTeljes negyProba kettoProba) = True
bizG = Refl

public export
egyenloTeljes : PontProba -> PontProba -> Bool
egyenloTeljes a b = eqK (xorPApp a b).fp1 NullaProba && eqK (xorPApp a b).fp2 NullaProba

public export
eqK : KubitProba -> KubitProba -> Bool
eqK NullaProba NullaProba = True
eqK EgyProba   EgyProba   = True
eqK _          _          = False
