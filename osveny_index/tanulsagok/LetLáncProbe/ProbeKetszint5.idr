module ProbeKetszint5
import Data.Vect
data Pr = Pr (List String) (List (Vect 7 Nat, Vect 7 Nat, String))
%default covering
tanitTud : Pr -> String -> Pr
tanitTud (Pr t m) s = Pr (s :: t) m
tanitMiert : Pr -> (Vect 7 Nat, Vect 7 Nat, String) -> Pr
tanitMiert (Pr t m) e = Pr t (e :: m)
pr0 : Pr
pr0 = Pr [] []
e : (Vect 7 Nat, Vect 7 Nat, String)
e = ([1,0,0,0,0,0,0], [0,1,0,0,0,0,0], "teszt")
kozep : Pr
kozep = let b1 = tanitTud pr0 "s"
          b2 = tanitTud b1 "s"
          b3 = tanitTud b2 "s"
          b4 = tanitTud b3 "s"
          b5 = tanitTud b4 "s"
          b6 = tanitTud b5 "s"
          b7 = tanitTud b6 "s"
      in b7
prN : Pr
prN = let a1 = tanitMiert kozep e
        a2 = tanitMiert a1 e
        a3 = tanitMiert a2 e
        a4 = tanitMiert a3 e
        a5 = tanitMiert a4 e
    in a5
