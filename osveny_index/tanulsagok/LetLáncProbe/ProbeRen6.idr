module ProbeRen6
data Pr = Pr (List Nat)
%default covering
pr0 : Pr
pr0 = Pr []
prN : Pr
prN = let a1 = pr0
        a2 = a1
        a3 = a2
        a4 = a3
        a5 = a4
        a6 = a5
    in a6
