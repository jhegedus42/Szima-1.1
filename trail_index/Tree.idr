module Tree

import Ontology

public export
record NodeData where
  constructor MkNode
  label : String
  desc  : String
  refs  : List String
  conf  : Double

public export
data Tree : OType -> Type where
  Leaf   : NodeData -> Tree t
  Branch : NodeData
         -> List (s : OType ** (Tree s, Valid t s))
         -> Tree t

public export
size : Tree t -> Nat
size (Leaf _) = 1
size (Branch _ cs) = 1 + sum (map (\(a ** (tr, _)) => size tr) cs)

public export
evidence : Tree t -> List String
evidence (Leaf d) = d.refs
evidence (Branch d cs) = d.refs ++ concat (map (\(a ** (tr, _)) => evidence tr) cs)

indent : Nat -> String
indent Z = ""
indent (S n) = "  " ++ indent n

showNode : NodeData -> String
showNode d = d.label ++ " [" ++ show d.conf ++ "]"

mutual
  renderAt : Nat -> Tree t -> String
  renderAt n (Leaf d) = indent n ++ "• " ++ showNode d
  renderAt n (Branch d cs) =
    indent n ++ "○ " ++ showNode d ++ "\n"
    ++ concat (map (renderChild n) cs)

  renderChild : Nat -> (a : OType ** (Tree a, Valid t a)) -> String
  renderChild n (a ** (tr, _)) = renderAt (n + 1) tr ++ "\n"

public export
render : Tree t -> String
render tr = renderAt 0 tr
