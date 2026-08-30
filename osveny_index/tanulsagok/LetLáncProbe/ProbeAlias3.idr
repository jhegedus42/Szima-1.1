module ProbeAlias3
import Data.Vect
BitKod : Type
BitKod = Vect 7 Nat
data Pr = Pr (List (BitKod, String)) (List (BitKod, BitKod, String))
%default covering
tudastar : Pr -> List (BitKod, String)
tudastar (Pr t m) = t
miertLanc : Pr -> List (BitKod, BitKod, String)
miertLanc (Pr t m) = m
tanitTud : Pr -> BitKod -> String -> Pr
tanitTud ai k s = Pr ((k, s) :: tudastar ai) (miertLanc ai)
tanitMiert : Pr -> BitKod -> BitKod -> String -> Pr
tanitMiert ai e u i = Pr (tudastar ai) ((e, u, i) :: miertLanc ai)
pr0 : Pr
pr0 = Pr [] []
kozep : Pr
kozep = let b1 = tanitTud pr0 [1,0,0,0,0,0,0] "az ido az oksag forrasa"
          b2 = tanitTud b1 [0,1,0,0,0,0,0] "az oksag a kerdes forrasa"
          b3 = tanitTud b2 [0,1,0,0,0,0,0] "az oksag a kerdes forrasa"
          b4 = tanitTud b3 [0,1,0,0,0,0,0] "az oksag a kerdes forrasa"
          b5 = tanitTud b4 [0,1,0,0,0,0,0] "az oksag a kerdes forrasa"
          b6 = tanitTud b5 [0,1,0,0,0,0,0] "az oksag a kerdes forrasa"
          b7 = tanitTud b6 [0,1,0,0,0,0,0] "az oksag a kerdes forrasa"
      in b7
prN : Pr
prN = let a1 = tanitMiert kozep [1,0,0,0,0,0,0] [0,1,0,0,0,0,0] "az ido az oksag forrasa mikor tortent mi okozta"
        a2 = tanitMiert a1 [0,0,0,0,0,1,0] [0,0,0,0,1,0,0] "a fazis hangot ad mit tett hogyan mondta"
        a3 = tanitMiert a2 [0,0,0,0,0,1,0] [0,0,0,0,1,0,0] "a fazis hangot ad mit tett hogyan mondta"
    in a3
