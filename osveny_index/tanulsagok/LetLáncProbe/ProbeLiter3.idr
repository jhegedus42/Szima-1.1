module ProbeLiter3
import Data.Vect
data Pr = Pr (List String) (List (Vect 7 Nat, Vect 7 Nat, String))
%default covering
tudastar : Pr -> List String
tudastar (Pr t m) = t
miertLanc : Pr -> List (Vect 7 Nat, Vect 7 Nat, String)
miertLanc (Pr t m) = m
tanitTud : Pr -> String -> Pr
tanitTud ai s = Pr (s :: tudastar ai) (miertLanc ai)
tanitMiert : Pr -> (Vect 7 Nat, Vect 7 Nat, String) -> Pr
tanitMiert ai e = Pr (tudastar ai) (e :: miertLanc ai)
pr0 : Pr
pr0 = Pr [] []
kozep : Pr
kozep = let b1 = tanitTud pr0 "az ido az oksag forrasa mikor tortent mi okozta"
          b2 = tanitTud b1 "a hang az oksagot kifejezi hogyan mondta mi okozta"
          b3 = tanitTud b2 "a hang az oksagot kifejezi hogyan mondta mi okozta"
          b4 = tanitTud b3 "a hang az oksagot kifejezi hogyan mondta mi okozta"
          b5 = tanitTud b4 "a hang az oksagot kifejezi hogyan mondta mi okozta"
          b6 = tanitTud b5 "a hang az oksagot kifejezi hogyan mondta mi okozta"
          b7 = tanitTud b6 "a hang az oksagot kifejezi hogyan mondta mi okozta"
      in b7
prN : Pr
prN = let a1 = tanitMiert kozep ([1,0,0,0,0,0,0], [0,1,0,0,0,0,0], "az ido az oksag forrasa mikor tortent mi okozta")
        a2 = tanitMiert a1 ([0,0,0,0,2,1,0], [0,1,0,0,2,0,0], "a fazis hangot ad mit tett hogyan mondta")
        a3 = tanitMiert a2 ([0,0,0,0,3,1,0], [0,1,0,0,3,0,0], "a fazis hangot ad mit tett hogyan mondta")
    in a3
