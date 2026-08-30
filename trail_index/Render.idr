module Render

||| Custom rendering interface (string-free core, render on demand).
public export
interface Render a where
  render : a -> String

||| Render a list with separator.
public export
renderSep : String -> List String -> String
renderSep _ [] = ""
renderSep _ [x] = x
renderSep sep (x :: xs) = x ++ sep ++ renderSep sep xs
