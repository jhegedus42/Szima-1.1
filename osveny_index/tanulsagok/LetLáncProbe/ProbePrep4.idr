module ProbePrep4
data Pr = Pr (List Nat)
%default covering
prepend : Pr -> Nat -> Pr
prepend (Pr l) x = Pr (x :: l)
pr0 : Pr
pr0 = Pr []
prN : Pr
prN = let a1 = prepend pr0 1
        a2 = prepend a1 2
        a3 = prepend a2 3
        a4 = prepend a3 4
    in a4
