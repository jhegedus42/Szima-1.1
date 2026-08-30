module ProbeRen4
data Pr = Pr (List Nat)
%default covering
pr0 : Pr
pr0 = Pr []
prN : Pr
prN = let a1 = pr0
        a2 = a1
        a3 = a2
        a4 = a3
    in a4
