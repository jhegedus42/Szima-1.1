module HtmlDsl

-- ═══════════════════════════════════════════════════════════════
-- HTML DSL — típusos HTML-fa Idrisben (nem String-sablon)
-- ═══════════════════════════════════════════════════════════════
-- A HTML-t STRUKTÚRÁLISAN építjük: nem String-összefűzés,
-- hanem egy algebrai adattípus, ami a HTML-fát reprezentálja.
-- A renderelés egy tiszta függvény (fa → String).
--
-- Előnyök a String-sablonnal szemben:
--   - a típus GARANTÁLJA a struktúrát (nem lehet rosszul zárt tag)
--   - a renderelő nem tudja elfelejteni lezárni egy elemet
--   - a fa komponálható és újrafelhasználható
--
-- Az Idris 2 DSL-mintája (operators.rst + interfaces.rst: Monad):
--   operátorok + algebrai adattípus = a DSL nyelvtanja
-- ═══════════════════════════════════════════════════════════════

%default covering

-- ─── 1. A HTML-FA ALGEBRAI ADATTÍPUSA ────────────────────

public export
data HtmlFa =
    Szoveg String
  | Cimke String (List (String, String)) (List HtmlFa)

-- Cimke: név, attribútumok (kulcs-érték párok), gyermekek

-- ─── 2. DSL-HELPEREK (a "nyelvtan") ───────────────────────

public export
html : List HtmlFa -> HtmlFa
html gyermekek = Cimke "html" [] gyermekek

public export
head : List HtmlFa -> HtmlFa
head gyermekek = Cimke "head" [] gyermekek

public export
body : List HtmlFa -> HtmlFa
body gyermekek = Cimke "body" [] gyermekek

public export
h1 : String -> HtmlFa
h1 szoveg = Cimke "h1" [] [Szoveg szoveg]

public export
h2 : String -> HtmlFa
h2 szoveg = Cimke "h2" [] [Szoveg szoveg]

public export
p : List HtmlFa -> HtmlFa
p gyermekek = Cimke "p" [] gyermekek

public export
pSzoveggel : String -> HtmlFa
pSzoveggel s = Cimke "p" [] [Szoveg s]

public export
pre : String -> HtmlFa
pre tartalom = Cimke "pre" [] [Szoveg tartalom]

public export
tabla : List HtmlFa -> HtmlFa
tabla sorok = Cimke "table" [] sorok

public export
th : String -> HtmlFa
th szoveg = Cimke "th" [] [Szoveg szoveg]

public export
tr : List HtmlFa -> HtmlFa
tr cellak = Cimke "tr" [] cellak

public export
td : String -> HtmlFa
td szoveg = Cimke "td" [] [Szoveg szoveg]

public export
tdOsztallyal : String -> String -> HtmlFa
tdOsztallyal osztaly szoveg =
  Cimke "td" [("class", osztaly)] [Szoveg szoveg]

public export
ul : List HtmlFa -> HtmlFa
ul elemek = Cimke "ul" [] elemek

public export
li : String -> HtmlFa
li szoveg = Cimke "li" [] [Szoveg szoveg]

public export
link : String -> String -> HtmlFa
link cim cel = Cimke "a" [("href", cel)] [Szoveg cim]

public export
code : String -> HtmlFa
code tartalom = Cimke "code" [] [Szoveg tartalom]

public export
dobox : List HtmlFa -> HtmlFa
dobox gyermekek = Cimke "div" [("class", "doboz")] gyermekek

public export
footer : List HtmlFa -> HtmlFa
footer gyermekek = Cimke "footer" [] gyermekek

public export
nav : List HtmlFa -> HtmlFa
nav gyermekek = Cimke "nav" [] gyermekek

public export
style : String -> HtmlFa
style tartalom = Cimke "style" [] [Szoveg tartalom]

public export
metaCharset : HtmlFa
metaCharset = Cimke "meta" [("charset", "UTF-8")] []

public export
metaViewport : HtmlFa
metaViewport =
  Cimke "meta" [("name", "viewport"), ("content", "width=device-width, initial-scale=1.0")] []

public export
title : String -> HtmlFa
title szoveg = Cimke "title" [] [Szoveg szoveg]

public export
header : List HtmlFa -> HtmlFa
header gyermekek = Cimke "header" [] gyermekek

public export
b : String -> HtmlFa
b szoveg = Cimke "b" [] [Szoveg szoveg]

-- ─── 3. A RENDERELŐ (fa → String) ────────────────────────

public export
renderAttributumok : List (String, String) -> String
renderAttributumok [] = ""
renderAttributumok ((kulcs, ertek) :: tobbi) =
  " " ++ kulcs ++ "=\"" ++ ertek ++ "\"" ++ renderAttributumok tobbi

public export
render : HtmlFa -> String
render (Szoveg s) = s
render (Cimke nev attr []) =
  "<" ++ nev ++ renderAttributumok attr ++ " />"
render (Cimke nev attr gyermekek) =
  "<" ++ nev ++ renderAttributumok attr ++ ">"
  ++ concatMap render gyermekek
  ++ "</" ++ nev ++ ">"

-- ─── 4. A TELJES DOKUMENTUM ──────────────────────────────

public export
dokumentum : String -> String -> List HtmlFa -> String
dokumentum cim cssSzoveg tartalom =
  "<!DOCTYPE html>\n"
  ++ render (html [
      head [metaCharset, metaViewport, title cim, style cssSzoveg],
      body tartalom
    ])
  ++ "\n"