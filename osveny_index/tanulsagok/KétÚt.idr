module KétÚt

-- 1. ÚT: az OKTONION oldalról (egységek: 16 csúcs + 224 fél-pont)
public export
OktonionCsucsok    : Nat
OktonionCsucsok    = 2 * 8          -- ±e_i, i=1..8

public export
OktonionFelpontok  : Nat
OktonionFelpontok  = 224

public export
OktonionEgysegek   : Nat
OktonionEgysegek   = OktonionCsucsok + OktonionFelpontok

-- 2. ÚT: a RÁCS oldalról (E8 gyökök: 112 egész + 128 félegész)
public export
D8Resz            : Nat
D8Resz            = 4 * 28          -- (±1,±1,0..) : 4 elojel x C(8,2)

public export
FelegeszResz      : Nat
FelegeszResz      = 2 * 2 * 2 * 2 * 2 * 2 * 2   -- 2^7 paros bajtok

public export
RacsGyokok        : Nat
RacsGyokok        = D8Resz + FelegeszResz

-- A BIZONYÍTÁS: a két ÚT ugyanoda ér (a kernel MINDKETTŐT kiszámolja):
BizKetUtTalalkozik : OktonionEgysegek = RacsGyokok
BizKetUtTalalkozik = Refl
