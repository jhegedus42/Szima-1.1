module Attekintes

-- ═══════════════════════════════════════════════════════════════
-- HTML-ÁTTEKINTÉST GENERÁLÓ MODUL — az Idris a forrása a webnek
-- ═══════════════════════════════════════════════════════════════
-- Szabály: minden generálás Idrisből jön — a HTML is.
-- A SABLON (CSS-struktúra) itt van; az ADATOK (modullista,
-- tesztszámok) a Teszt.idr-ből importálva.
-- Kimenet:
--   idris2 --exec htmlKiiras Attekintes.idr > docs/attekintes.html
-- ═══════════════════════════════════════════════════════════════

import Teszt
import HtmlDsl
import ModulRegisztracio
import Fonetika
import FanoParitás
import Kerdoszo
import HanMagyarKodolas
import E8Gyokrendszer
import DiracGammaMatricak
import OktonionAlgebra
import SteaneHamiltonian
import LejeuneTranszformacio
import DiracIdoFejlodes
import ErtelmezoSzotar
import LawvereGodel
import Komplex
import KorOsztas

%default covering

-- ─── 1. A MODULOK LISTÁJA (adattípus, nem String) ───────

public export
record ModulAdat where
  constructor ModulAdatKonstruktor
  modulNev       : String
  mitBizonyit    : String
  miertKell      : String
  allapotJel     : String

-- A modullista AUTOMATIKUS a regisztrációkból:
-- minden modul saját magát regisztrálja (ModulRegisztracio.idr)
public export
osszesRegisztraltModul : List ModulLeirasT
osszesRegisztraltModul =
  [ FonetikaLeiras
  , FanoParitasLeiras
  , KérdőszóLeírás
  , HanMagyarKodolasLeiras
  , EGyokrendszerLeiras
  , DiracGammaLeírás
  , OktonionLeiras
  , SteaneHamiltonianLeiras
  , LejeuneLeiras
  , DiracIdoLeiras
  , ErtelmezoSzotarLeiras
  , LawvereLeiras
  , KomplexLeiras
  , KorOsztasLeiras
  ]

-- ─── 2. HTML-SABLON ──────────────────────────────────────

public export
cssSablon : String
cssSablon = """
:root { --festek:#1a1a2e; --papir:#fafaf7; --kiemel:#2563eb; --siker:#059669; --arany:#b45309; --keret:#d8d4cc; --hatter:#f0eee9; }
* { box-sizing:border-box; }
body { font-family:Georgia,serif; background:var(--hatter); color:var(--festek); max-width:1000px; margin:0 auto; padding:2rem 1rem 4rem; line-height:1.65; }
header { border-bottom:3px double var(--festek); padding-bottom:1.2rem; margin-bottom:2rem; }
h1 { font-size:1.8rem; margin:0 0 .3rem; }
h2 { font-size:1.3rem; border-bottom:1px solid var(--keret); padding-bottom:.3rem; margin-top:2.4rem; }
table { border-collapse:collapse; width:100%; margin:1rem 0; font-size:.9rem; }
th,td { border:1px solid var(--keret); padding:.45rem .6rem; text-align:left; vertical-align:top; }
th { background:var(--papir); font-family:Menlo,monospace; font-size:.82rem; }
.pipa { color:var(--siker); font-weight:bold; }
.doboz { background:var(--papir); border:1px solid var(--keret); border-radius:6px; padding:1rem 1.2rem; margin:1rem 0; }
pre { background:var(--festek); color:#e5e7eb; padding:1rem 1.2rem; border-radius:6px; overflow-x:auto; font-size:.84rem; }
a { color:var(--kiemel); text-decoration:none; }
a:hover { text-decoration:underline; }
.kicsi { font-size:.85rem; color:#6b7280; }
.mod { font-family:Menlo,monospace; font-size:.85rem; color:var(--kiemel); }
footer { margin-top:3rem; border-top:3px double var(--festek); padding-top:1rem; font-size:.88rem; color:#555; }
nav { background:var(--papir); border:1px solid var(--keret); border-radius:6px; padding:1rem 1.4rem; margin-bottom:2rem; }
nav a { margin-right:1.2rem; }
"""

-- ─── 3. A TESZTSZÁMOK A Teszt.idr-BŐL ────────────────────

public export
tesztSzamok : String
tesztSzamok =
  show (sikeresDb tesztJelentes) ++ "/" ++ show (tesztekDb tesztJelentes)
  ++ " teszt + " ++ show (bizonyitasokDb tesztJelentes) ++ " Refl"

-- ─── 4. A MODULTÁBLÁZAT a HtmlDsl-ből ─────────────────────

public export
modulSorHtml : ModulLeirasT -> HtmlFa
modulSorHtml m = tr
  [ Cimke "td" [("class", "mod")] [link (modulNeve m) ("https://github.com/jhegedus42/Szima/blob/master/osveny_index/" ++ modulNeve m)]
  , td (mitBizonyit m)
  , td (miertKell m)
  , tdOsztallyal "pipa" (allapotJele m)
  ]

public export
modulTablazatHtml : HtmlFa
modulTablazatHtml = tabla
  ( tr [ th "Modul", th "Mit bizonyít", th "Miért kell az AI-hez", th "Állapot" ]
  :: map modulSorHtml osszesRegisztraltModul
  )

-- ─── 4a. A TESZTKATEGÓRIÁK ÉS BIZONYÍTÁSOK (automatikus) ──

public export
tesztKategoriaSor : (String, List TesztEredmeny) -> HtmlFa
tesztKategoriaSor (nev, tesztek) = tr
  [ Cimke "td" [] [link nev "https://github.com/jhegedus42/Szima/blob/master/osveny_index/Teszt.idr"]
  , td (show (length tesztek))
  , tdOsztallyal "pipa" (if all sikeres tesztek then "✓" else "✗")
  ]

public export
tesztKategoriaTablazat : HtmlFa
tesztKategoriaTablazat = tabla
  ( tr [ th "Tesztkategória", th "Darab", th "Állapot" ]
  :: [ tesztKategoriaSor ("e8", e8Tesztek)
     , tesztKategoriaSor ("hamming", hammingTesztek)
     , tesztKategoriaSor ("rag", ragTesztek)
     , tesztKategoriaSor ("kerdoszo (régi)", kerdoszoTesztek)
     , tesztKategoriaSor ("graf", grafTesztek)
     , tesztKategoriaSor ("mdl", mdlTesztek)
     , tesztKategoriaSor ("valoszinuseg", valoszinusegTesztek)
     , tesztKategoriaSor ("lawvere", lawvereTesztek)
     , tesztKategoriaSor ("fonetika", fonetikaTesztek)
     , tesztKategoriaSor ("fanoParitas", fanoParitasTesztek)
     , tesztKategoriaSor ("szotar", szotarTesztek)
     , tesztKategoriaSor ("steaneHamiltonian", steaneHamiltonianTesztek)
     , tesztKategoriaSor ("lejeune", lejeuneTesztek)
     , tesztKategoriaSor ("hanmag", hanmagTesztek)
     , tesztKategoriaSor ("kerdoszo (típusos)", kerdoszoTipusosTesztek)
     , tesztKategoriaSor ("e8Gyok", e8GyokTesztek)
     , tesztKategoriaSor ("diracGamma", diracGammaTesztek)
     , tesztKategoriaSor ("oktonion", oktonionTesztek)
     , tesztKategoriaSor ("diracIdo", diracIdoTesztek)
     ]
  )

public export
bizonyitasSorHtml : String -> HtmlFa
bizonyitasSorHtml sz = tr [ Cimke "td" [("class", "pipa")] [link sz "https://github.com/jhegedus42/Szima/blob/master/osveny_index/Teszt.idr"] ]

public export
bizonyitasTablazat : HtmlFa
bizonyitasTablazat = tabla
  ( tr [ th "Bizonyítás (Refl)" ]
  :: map bizonyitasSorHtml (toList bizonyitasLista)
  )

-- ─── 5. A TELJES HTML (HtmlDsl fa → render) ──────────────

public export
htmlKimenet : String
htmlKimenet =
  dokumentum "Szima — Projekt-áttekintés (Idris-generált)" cssSablon
    [ header
        [ h1 "Szima — Projekt-áttekintés"
        , pSzoveggel "A kód maga a kutatás. Ezt az oldalt az Idris generálta a HtmlDsl-ből."
        , pSzoveggel ("Frissítve: 2026-08-18 · " ++ tesztSzamok ++ " ✓")
        ]
    , nav
        [ link "📊 Dashboard" "dashboard.html"
        , link "📖 Carnot" "carnot_entropia.html"
        , link "📈 Zitterbewegung" "zitterbewegung.html"
        , link "🏠 Régi főoldal" "index.html"
        , link "📊 Vizualizációk" "vizualizaciok.html"
        ]
    , h2 "1. A megépült elemek (mind Idrisben, gép-ellenőrzött)"
    , modulTablazatHtml
    , h2 "2. Tesztkategóriák (automatikus a Teszt.idr-ből)"
    , tesztKategoriaTablazat
    , h2 "3. A bizonyítások (automatikus a Teszt.idr-ből)"
    , bizonyitasTablazat
    , h2 "4. Ami NEM megvan (őszintén)"
    , dobox
        [ ul
            [ li "Nincs egy main, ami gondolkodik. A LEGO-elemek külön-külön bizonyítottak."
            , li "A hiányzó lépés: egy main ami kap egy kérdést, kódolja, lefuttatja a Carnot-ciklust."
            , li "α⁻¹ = 137 + 9/250: 6,5σ nyitott ⚡"
            , li "A szerveri Dirac-nyelv gammái hibásak (javítva Idrisben, szerveren nem)."
            ]
        ]
    , h2 "5. Hogyan futtasd"
    , pre ("git clone https://github.com/jhegedus42/Szima && cd Szima/osveny_index\\nidris2 -c Teszt.idr && idris2 --exec main Teszt.idr  → " ++ tesztSzamok ++ " ✓\\n\\nidris2 --exec htmlKiiras Attekintes.idr > ../docs/attekintes.html\\n./ellenorzes.sh")
    , footer
        [ pSzoveggel "Szima · a kód maga a kutatás · github.com/jhegedus42/Szima"
        , pSzoveggel "Dedikálva Szimának, a szeretett cicának 🐱"
        ]
    ]

public export
htmlKiiras : IO ()
htmlKiiras = putStr htmlKimenet

main : IO ()
main = htmlKiiras