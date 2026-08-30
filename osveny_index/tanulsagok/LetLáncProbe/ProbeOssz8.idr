module ProbeOssz8
import Data.Vect
data Pr = Pr (List (Vect 7 Nat, Vect 7 Nat, String))
%default covering
prepend : Pr -> (Vect 7 Nat, Vect 7 Nat, String) -> Pr
prepend (Pr l) x = Pr (x :: l)
pr0 : Pr
pr0 = Pr []
e : (Vect 7 Nat, Vect 7 Nat, String)
e = ([1,0,0,0,0,0,0], [0,1,0,0,0,0,0], "teszt")
prN : Pr
prN = let a1 = prepend pr0 e
        a2 = prepend a1 e
        a3 = prepend a2 e
        a4 = prepend a3 e
        a5 = prepend a4 e
        a6 = prepend a5 e
        a7 = prepend a6 e
        a8 = prepend a7 e
    in a8
