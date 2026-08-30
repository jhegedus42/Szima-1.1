module ProbePrep6
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
        a5 = prepend a4 5
        a6 = prepend a5 6
    in a6
