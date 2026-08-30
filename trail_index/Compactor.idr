module Compactor

import E8Code

public export
record ScoredAssoc where
  constructor MkScored
  concept   : String
  confidence : Double
  code      : CodeWord
  score     : Double

public export
sortByScore : List ScoredAssoc -> List ScoredAssoc
sortByScore [] = []
sortByScore (x :: xs) =
  let lesser = filter (\a => a.score <= x.score) xs
      greater = filter (\a => a.score > x.score) xs
  in sortByScore greater ++ [x] ++ sortByScore lesser

public export
dedup : List ScoredAssoc -> List ScoredAssoc
dedup [] = []
dedup (x :: xs) =
  if any (\a => a.concept == x.concept) xs
    then dedup xs
    else x :: dedup xs

public export
compact : Double -> List ScoredAssoc -> (List ScoredAssoc, Nat)
compact threshold assocs =
  let deduped = dedup assocs
      sorted = sortByScore deduped
      keepCount = max 1 (length sorted * 7 `div` 10)
      kept = take keepCount sorted
      dropped = length sorted - keepCount
  in (kept, dropped)

public export
computeScore : Double -> CodeWord -> List CodeWord -> Double
computeScore conf cw existing =
  let maxOverlap = foldl (\mx, e => max mx (overlap cw e)) 0.0 existing
  in conf * (1.0 - maxOverlap)
