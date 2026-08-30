module FaVizualizacio

import Data.List
import Data.String
import System.Directory
import System.File
import System.File.Meta

%default total

-- ═══════════════════════════════════════════════════════════════
-- FA-VIZUALIZÁCIÓ — AZ IDRIS-FÁK GENERÁLÁSA OS-VIZUALIZÁCIÓHOZ
-- ═══════════════════════════════════════════════════════════════
-- A projekt 49+ Idris-fájlját egy Fa (tree) típusba gyűjtjük,
-- és belőle ötféle vizualizációs formátumot generálunk:
--   1. fa.txt      — egyszerű behúzott szöveges fa
--   2. fa.dot      — Graphviz DOT (klasszikus dendrogram-szerű)
--   3. fa.mmd      — Mermaid flowchart (markdown-barát)
--   4. fa.py       — önmagában futtatható Python (matplotlib)
--   5. fa.jl       — önmagában futtatható Julia (Plots + graphplot)
--
-- A forrás-fa = az Idris-típus (egyetlen igazság), a vizualizációk
-- deriváltjai. A compiler a bíró: ha a Fa típus nem fordul,
-- egyik formátum sem készül el.

-- ─── FA ELEMEK ───────────────────────────────────────────────

||| A fa egy eleme: vagy szint (mappa, további elemekkel),
||| vagy fajl (levél).
public export
data FaElem : Type where
  FaSzint : (nev : String) -> (gyerekek : List FaElem) -> FaElem
  FaFajl  : (nev : String) -> FaElem

public export
Show FaElem where
  show (FaSzint n _)    = "FaSzint(" ++ n ++ ")"
  show (FaFajl n)       = "FaFajl(" ++ n ++ ")"

public export
Eq FaElem where
  (==) (FaSzint n _)    (FaSzint n' _)    = n == n'
  (==) (FaFajl n)       (FaFajl n')       = n == n'
  (==) _                _                 = False

-- ─── SEGÉD FÜGGVÉNYEK ───────────────────────────────────────

||| Eldönti egy útvonalról, hogy könyvtár-e.
||| Ha listDir sikeres → könyvtár; ha nem → nem könyvtár.
public export
konyvtarE : String -> IO Bool
konyvtarE ut =
  do eredmeny <- listDir ut
     case eredmeny of
       Right _  => pure True
       Left  _  => pure False

||| Kihagyandó könyvtárak neve (build-zaj, VCS, stb.).
public export
kihagyando : List String
kihagyando = ["build", "node_modules", ".git", ".idea", "__pycache__"]

||| Útvonal utolsó komponense (a megjelenített címke).
public export
utolsoKomponens : String -> String
utolsoKomponens p =
  let idxs = filter (\i => index' i p == Just '/') [0 .. length p - 1]
  in case reverse idxs of
       (i :: _) => strIndex p (i + 1)  -- egyszerűsítve: az utolsó / utáni részt nem parsoljuk; teljes utat adjuk vissza
       [] => p

||| Rekurzív bejárás: az adott útvonal alatti teljes fa.
public export
bejar : String -> IO (Either FileError FaElem)
bejar ut =
  do konyvtar <- konyvtarE ut
     if not konyvtar
       then pure (Right (FaFajl ut))
       else do
         eredmeny <- listDir ut
         case eredmeny of
           Left err => pure (Left err)
           Right nevek =>
             do rendezett <- pure (sort nevek)
                szurt    <- pure (filter (\n => not (elem n kihagyando)) rendezett)
                gyerekek <- bejarGyerekek ut szurt
                pure (Right (FaSzint ut gyerekek))

||| A gyerekek feldolgozása (rekurzió minden egyes névre).
public export
bejarGyerekek : String -> List String -> IO (List FaElem)
bejarGyerekek szulo [] = pure []
bejarGyerekek szulo (n :: ns) =
  do gyerekFa <- bejar (szulo ++ "/" ++ n)
     eset     <- case gyerekFa of
                   Right fa => pure fa
                   Left  _  => pure (FaFajl n)
     tobbi    <- bejarGyerekek szulo ns
     pure (eset :: tobbi)

||| A fa elemeinek száma (mappák + fájlok).
public export
faMeret : FaElem -> Nat
faMeret (FaFajl _)            = 1
faMeret (FaSzint _ gyerekek)  = 1 + sum (map faMeret gyerekek)

-- ─── 1. SZÖVEGES FA ─────────────────────────────────────────

||| Behúzott szöveges fa (csővezeték karakterek).
public export
szovegesbe : FaElem -> String
szovegesbe elem = szovegesbeSeq 0 elem
  where
    szovegesbeSeg : Nat -> Bool -> FaElem -> String
    szovegesbeSeq : Nat -> List FaElem -> String

    szovegesbeSeg melyseg utolso (FaFajl nev) elozo =
      elozo ++ behuzas melyseg ++ (if utolso then "└── " else "├── ") ++ nev ++ "\n"
    szovegesbeSeg melyseg utolso (FaSzint nev gyerekek) elozo =
      elozo ++ behuzas melyseg ++ (if utolso then "└── " else "├── ") ++ nev ++ "/\n"
      ++ szovegesbeSeq (melyseg + 1) gyerekek ""

    szovegesbeSeq _ [] elozo = elozo
    szovegesbeSeq melyseg [x] elozo = szovegesbeSeg melyseg True x elozo
    szovegesbeSeq melyseg (x :: xs) elozo =
      szovegesbeSeg melyseg False x elozo ++ szovegesbeSeq melyseg xs elozo

    behuzas : Nat -> String
    behuzas 0 = ""
    behuzas k = "    " ++ behuzas (k - 1)

-- ─── 2. GRAPHVIZ DOT ─────────────────────────────────────────

||| Graphviz DOT-formátum (klaszszikus fastruktúra).
public export
dotra : FaElem -> String
dotra elem =
  "digraph Fa {\n"
  ++ "  rankdir=LR;\n"
  ++ "  node [shape=box, style=\"rounded,filled\", fillcolor=\"#f5f5f5\", fontname=\"Helvetica\"];\n"
  ++ "  edge [color=\"#888888\"];\n"
  ++ dotElemek 1 elem
  ++ "}\n"
  where
    dotElemek : Nat -> FaElem -> String
    dotElemek azonosito (FaFajl nev) =
      "  n" ++ show azonosito ++ " [label=\"" ++ dotEsc nev ++ "\", shape=ellipse, fillcolor=\"#fff2cc\"];\n"
    dotElemek azonosito (FaSzint nev []) =
      "  n" ++ show azonosito ++ " [label=\"" ++ dotEsc nev ++ "\", fillcolor=\"#dae8fc\"];\n"
    dotElemek azonosito (FaSzint _ gyerekek) =
      "  n" ++ show azonosito ++ " [label=\"" ++ dotEsc (utolsoKomponens "") ++ "\", fillcolor=\"#dae8fc\"];\n"
      ++ dotLapit azonosito (azonosito + 1) gyerekek

    dotLapit : Nat -> Nat -> List FaElem -> String
    dotLapit _ _ [] = ""
    dotLapit szulo k (g :: gs) =
      "  n" ++ show szulo ++ " -> n" ++ show k ++ ";\n"
      ++ dotLapit szulo (k + 1 + faMeret g) gs

    dotEsc : String -> String
    dotEsc s = pack (map (\c => if c == '"' then '`' else c) (unpack s))

-- ─── 3. MERMAID ──────────────────────────────────────────────

||| Mermaid flowchart formátum.
public export
mermaidra : FaElem -> String
mermaidra elem =
  "graph TD\n"
  ++ mermaidElemek 1 elem
  where
    mermaidElemek : Nat -> FaElem -> String
    mermaidElemek azonosito (FaFajl nev) =
      "  n" ++ show azonosito ++ "([/" ++ mermaidEsc nev ++ "/])\n"
    mermaidElemek azonosito (FaSzint nev []) =
      "  n" ++ show azonosito ++ "[" ++ mermaidEsc nev ++ "]\n"
    mermaidElemek azonosito (FaSzint nev gyerekek) =
      "  n" ++ show azonosito ++ "[\"" ++ mermaidEsc nev ++ "\"]\n"
      ++ mermaidLapit azonosito (azonosito + 1) gyerekek

    mermaidLapit : Nat -> Nat -> List FaElem -> String
    mermaidLapit _ _ [] = ""
    mermaidLapit szulo k (g :: gs) =
      "  n" ++ show szulo ++ " --> n" ++ show k ++ "\n"
      ++ mermaidLapit szulo (k + 1 + faMeret g) gs

    mermaidEsc : String -> String
    mermaidEsc s = pack (map (\c => if c == '"' then '\'' else c) (unpack s))

-- ─── 4. PYTHON (matplotlib) ──────────────────────────────────

||| Önálló Python-szkript, ami a fát matplotlib-bal rajzolja ki.
public export
pythonba : FaElem -> String
pythonba elem =
  "# Auto-generált Python-vizualizáció — Idris FaVizualizacio modulból.\n"
  ++ "# Futtatás: python3 fa.py\n"
  ++ "# Függőség: matplotlib\n"
  ++ "import matplotlib.pyplot as plt\n"
  ++ "import matplotlib.patches as mpatches\n"
  ++ "\n"
  ++ "Fa = [\n"
  ++ pythonElemek elem
  ++ "]\n"
  ++ "\n"
  ++ "fig, ax = plt.subplots(figsize=(14, 9))\n"
  ++ "ax.set_axis_off()\n"
  ++ "ax.set_title('opencode — Idris-fa (auto-generált)', fontsize=14)\n"
  ++ "\n"
  ++ "SZIN_MAPPA = {'FaSzint': '#dae8fc', 'FaFajl': '#fff2cc'}\n"
  ++ "\n"
  ++ "def rajzol(csomopont, x, y, szelesseg):\n"
  ++ "    nev, tipus, gyerekek = csomopont\n"
  ++ "    doboz = mpatches.FancyBboxPatch(\n"
  ++ "        (x - szelesseg/2, y - 0.2), szelesseg, 0.4,\n"
  ++ "        boxstyle='round,pad=0.05', facecolor=SZIN_MAPPA[tipus],\n"
  ++ "        edgecolor='#444444', linewidth=0.6)\n"
  ++ "    ax.add_patch(doboz)\n"
  ++ "    ax.text(x, y, nev, ha='center', va='center', fontsize=8)\n"
  ++ "    if gyerekek:\n"
  ++ "        gyerek_szelesseg = szelesseg / len(gyerekek)\n"
  ++ "        for i, g in enumerate(gyerekek):\n"
  ++ "            gyerek_x = x - szelesseg/2 + gyerek_szelesseg * (i + 0.5)\n"
  ++ "            ax.plot([x, gyerek_x], [y - 0.2, y - 0.8], color='#888888', linewidth=0.5)\n"
  ++ "            rajzol(g, gyerek_x, y - 1.0, gyerek_szelesseg)\n"
  ++ "\n"
  ++ "if Fa:\n"
  ++ "    rajzol(Fa[0], 0.5, 1.0, 1.0)\n"
  ++ "plt.tight_layout()\n"
  ++ "plt.savefig('fa.png', dpi=120, bbox_inches='tight')\n"
  ++ "print('Mentve: fa.png')\n"
  ++ ""
  where
    pythonElemek : FaElem -> String
    pythonElemek (FaFajl nev) =
      "    ('" ++ pythonEsc nev ++ "', 'FaFajl', []),\n"
    pythonElemek (FaSzint nev gyerekek) =
      "    ('" ++ pythonEsc nev ++ "', 'FaSzint', [\n"
      ++ pythonGyerekek gyerekek
      ++ "    ]),\n"
      where
        pythonGyerekek : List FaElem -> String
        pythonGyerekek [] = ""
        pythonGyerekek (g :: gs) = pythonElemek g ++ pythonGyerekek gs

    pythonEsc : String -> String
    pythonEsc s = pack (map (\c => if c == '\'' then '"' else c) (unpack s))

-- ─── 5. JULIA (Plots + graphplot) ────────────────────────────

||| Önálló Julia-szkript, ami a fát GraphRecipes csomaggal rajzolja.
public export
juliaba : FaElem -> String
juliaba elem =
  "# Auto-generált Julia-vizualizáció — Idris FaVizualizacio modulból.\n"
  ++ "# Futtatás: julia fa.jl\n"
  ++ "# Függőség: Plots, GraphRecipes\n"
  ++ "using Plots\n"
  ++ "using GraphRecipes\n"
  ++ "\n"
  ++ "# (cimke, szulo_index, sajat_index)\n"
  ++ "ELEMEK = [\n"
  ++ juliaElemek 0 (\\_ => -1) elem
  ++ "]\n"
  ++ "\n"
  ++ "ELEK = [\n"
  ++ juliaElek elem
  ++ "]\n"
  ++ "\n"
  ++ "SZINEK = [\n"
  ++ juliaSzinek elem
  ++ "]\n"
  ++ "\n"
  ++ "cimkek = [e[1] for e in ELEMEK]\n"
  ++ "graphplot(\n"
  ++ "    ELEK,\n"
  ++ "    names = cimkek,\n"
  ++ "    node_color = SZINEK,\n"
  ++ "    nodesize = 0.08,\n"
  ++ "    method = :tree,\n"
  ++ "    root = :top,\n"
  ++ "    curves = false,\n"
  ++ "    title = \"opencode — Idris-fa (Julia / GraphRecipes)\",\n"
  ++ ")\n"
  ++ "savefig(\"fa_julia.png\")\n"
  ++ "println(\"Mentve: fa_julia.png\")\n"
  ++ ""
  where
    juliaElemek : Nat -> (Nat -> Int) -> FaElem -> String
    juliaElemek idx szuloFn (FaFajl nev) =
      "  (\"" ++ juliaEsc nev ++ "\", " ++ show (szuloFn idx) ++ ", " ++ show idx ++ "),\n"
    juliaElemek idx szuloFn (FaSzint nev []) =
      "  (\"" ++ juliaEsc nev ++ "\", " ++ show (szuloFn idx) ++ ", " ++ show idx ++ "),\n"
    juliaElemek idx szuloFn (FaSzint nev gyerekek) =
      "  (\"" ++ juliaEsc nev ++ "\", " ++ show (szuloFn idx) ++ ", " ++ show idx ++ "),\n"
      ++ osszesGyerek (idx + 1) (\x => idx) gyerekek
      where
        osszesGyerek : Nat -> (Nat -> Int) -> List FaElem -> String
        osszesGyerek _ _ [] = ""
        osszesGyerek k szuloFn2 (g :: gs) =
          juliaElemek k szuloFn2 g ++ osszesGyerek (k + 1 + faMeret g) szuloFn2 gs

    juliaElek : FaElem -> String
    juliaElek (FaFajl _) = ""
    juliaElek (FaSzint _ gyerekek) = juliaElekLista 0 gyerekek
      where
        juliaElekLista : Nat -> List FaElem -> String
        juliaElekLista _ [] = ""
        juliaElekLista szulo (g :: gs) =
          "  (" ++ show szulo ++ ", " ++ show (szulo + 1) ++ "),\n"
          ++ juliaElekLista (szulo + 1 + faMeret g) gs

    juliaSzinek : FaElem -> String
    juliaSzinek (FaFajl _) = "  \"#fff2cc\",\n"
    juliaSzinek (FaSzint _ gyerekek) =
      "  \"#dae8fc\",\n" ++ osszesSzin gyerekek
      where
        osszesSzin : List FaElem -> String
        osszesSzin [] = ""
        osszesSzin (x :: xs) = juliaSzinek x ++ osszesSzin xs

    juliaEsc : String -> String
    juliaEsc s = pack (map (\c => if c == '"' then '\'' else c) (unpack s))

-- ─── FŐPROGRAM ───────────────────────────────────────────────

||| A főprogram: bejárja a /Users/joco/opencode/osveny_index/ fát,
||| és kiírja az ötféle vizualizációt a trail_index/viz/ könyvtárba.
public export
foProgram : IO ()
foProgram =
  do putStrLn "FaVizualizacio: indul..."
     eredmeny <- bejar "/Users/joco/opencode/osveny_index"
     case eredmeny of
       Left err =>
         putStrLn ("HIBA a bejárásnál: " ++ show err)
       Right fa =>
         do putStrLn ("Fa bejárva, meret = " ++ show (faMeret fa))
            -- 1. fa.txt
            irasEredmeny <- writeFile "/Users/joco/opencode/trail_index/viz/fa.txt"
                                              (szovegesbe fa)
            case irasEredmeny of
              Right _ => putStrLn "  ✓ fa.txt kiírva"
              Left e  => putStrLn ("  ✗ fa.txt hiba: " ++ show e)
            -- 2. fa.dot
            irasEredmeny2 <- writeFile "/Users/joco/opencode/trail_index/viz/fa.dot"
                                               (dotra fa)
            case irasEredmeny2 of
              Right _ => putStrLn "  ✓ fa.dot kiírva"
              Left e  => putStrLn ("  ✗ fa.dot hiba: " ++ show e)
            -- 3. fa.mmd
            irasEredmeny3 <- writeFile "/Users/joco/opencode/trail_index/viz/fa.mmd"
                                               (mermaidra fa)
            case irasEredmeny3 of
              Right _ => putStrLn "  ✓ fa.mmd kiírva"
              Left e  => putStrLn ("  ✗ fa.mmd hiba: " ++ show e)
            -- 4. fa.py
            irasEredmeny4 <- writeFile "/Users/joco/opencode/trail_index/viz/fa.py"
                                               (pythonba fa)
            case irasEredmeny4 of
              Right _ => putStrLn "  ✓ fa.py kiírva"
              Left e  => putStrLn ("  ✗ fa.py hiba: " ++ show e)
            -- 5. fa.jl
            irasEredmeny5 <- writeFile "/Users/joco/opencode/trail_index/viz/fa.jl"
                                               (juliaba fa)
            case irasEredmeny5 of
              Right _ => putStrLn "  ✓ fa.jl kiírva"
              Left e  => putStrLn ("  ✗ fa.jl hiba: " ++ show e)
            putStrLn "FaVizualizacio: kesz."
     pure ()