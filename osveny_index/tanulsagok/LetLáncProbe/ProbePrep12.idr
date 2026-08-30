module ProbePrep12
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
        a7 = prepend a6 7
        a8 = prepend a7 8
        a9 = prepend a8 9
        a10 = prepend a9 10
        a11 = prepend a10 11
        a12 = prepend a11 12
    in a12
