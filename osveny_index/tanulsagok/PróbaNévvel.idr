module PróbaNévvel

public export
kettoLeg : Nat
kettoLeg = 2

-- nagybetűs álnév:
public export
KettoLegNev : Nat
KettoLegNev = 2

bizNagy : KettoLegNev = 2
bizNagy = Refl

bizKettoKival : (the Nat kettoLeg) = 2
bizKettoKival = Refl
