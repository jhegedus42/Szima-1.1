module FaVizualizacio

import Data.List
import Data.String
import System.Directory
import System.File
import System.File.Meta

-- ═══════════════════════════════════════════════════════════════
-- FA-VIZUALIZÁCIÓ — AZ IDRIS-FÁK GENERÁLÁSA OS-VIZUALIZÁCIÓHOZ
-- ═══════════════════════════════════════════════════════════════
-- A projekt fáját egy Fa (tree) típusba gyűjtjük, és ötféle
-- vizualizációs formátumot generálunk:
--   1. fa.txt — egyszerű behúzott szöveges fa
--   2. fa.dot — Graphviz DOT (klasszikus dendrogram-szerű)
--   3. fa.mmd — Mermaid flowchart (markdown-barát)
--   4. fa.py — önmagában futtatható Python (matplotlib)
--   5. fa.jl — önmagában futtatható Julia (Plots + graphplot)
--
-- A forrás-fa = az Idris-típus (egyetlen igazság), a vizualizációk
-- deriváltjai. A compiler a bíró.

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

-- ─── FÁJLRENDSZER-BEJÁRÁS ────────────────────────────────────

||| Eldönti egy útvonalról, hogy könyvtár-e.
public export
konyvtarE : String -> IO Bool
konyvtarE ut =
  do eredmeny <- listDir ut
     case eredmeny of
       Right _  => pure True
       Left  _  => pure False

||| Kihagyandó könyvtárak neve (build-zaj, VCS).
public export
kihagyando : List String
kihagyando = ["build", "node_modules", ".git", ".idea", "__pycache__"]

mutual
  ||| Rekurzív bejárás egy útvonal alatti teljes fa felépítéséhez.
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

  bejarGyerekek : String -> List String -> IO (List FaElem)
  bejarGyerekek szulo [] = pure []
  bejarGyerekek szulo (n :: ns) =
    do gyerekFa <- bejar (szulo ++ "/" ++ n)
       eset     <- case gyerekFa of
                     Right fa => pure fa
                     Left  _  => pure (FaFajl n)
       tobbi    <- bejarGyerekek szulo ns
       pure (eset :: tobbi)

||| A fa elemeinek száma.
public export
faMeret : FaElem -> Nat
faMeret (FaFajl _)            = 1
faMeret (FaSzint _ gyerekek)  = 1 + sum (map faMeret gyerekek)

-- ─── 1. SZÖVEGES FA ─────────────────────────────────────────

||| Behúzott szöveges fa (csővezeték karakterek).
public export
szovegesbe : FaElem -> String
szovegesbe elem = goSeq 0 elem ""
  where
    ind : Nat -> String
    ind d = replicate (d * 4) ' '

    replicate : Nat -> Char -> String
    replicate 0 _ = ""
    replicate k c = String.singleton c ++ replicate (k - 1) c

    goSeg : Nat -> Bool -> FaElem -> String -> String
    goSeg _ _    (FaFajl nev)        elozo =
      elozo ++ ind 0 ++ "└── " ++ nev ++ "\n"
    goSeg _ _    (FaSzint nev [])    elozo =
      elozo ++ ind 0 ++ "└── " ++ nev ++ "/\n"
    goSeg d utolso (FaSzint nev gyerekek) elozo =
      elozo ++ ind d ++ (if utolso then "└── " else "├── ") ++ nev ++ "/\n"
      ++ goSeq d gyerekek ""

    goSeq : Nat -> List FaElem -> String -> String
    goSeq d [] elozo = elozo
    goSeq d [x] elozo = goSeg d True x elozo
    goSeq d (x :: xs) elozo = goSeg d False x elozo ++ goSeq d xs elozo

-- ─── 2. GRAPHVIZ DOT ─────────────────────────────────────────

||| Graphviz DOT-formátum (klasszikus fastruktúra).
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
    esc : String -> String
    esc s = pack (map (\c => if c == '"' then '`' else c) (unpack s))

    dotLapit : Nat -> Nat -> List FaElem -> String
    dotLapit _ _ [] = ""
    dotLapit szulo k (g :: gs) =
      "  n" ++ show szulo ++ " -> n" ++ show k ++ ";\n"
      ++ dotLapit szulo (k + 1 + faMeret g) gs

    dotElemek : Nat -> FaElem -> String
    dotElemek azonosito (FaFajl nev) =
      "  n" ++ show azonosito ++ " [label=\"" ++ esc nev ++ "\", shape=ellipse, fillcolor=\"#fff2cc\"];\n"
    dotElemek azonosito (FaSzint _ []) =
      "  n" ++ show azonosito ++ " [label=\"\", fillcolor=\"#dae8fc\"];\n"
    dotElemek azonosito (FaSzint _ gyerekek) =
      "  n" ++ show azonosito ++ " [label=\"\", fillcolor=\"#dae8fc\"];\n"
      ++ dotLapit azonosito (azonosito + 1) gyerekek

-- ─── 3. MERMAID ──────────────────────────────────────────────

||| Mermaid flowchart formátum.
public export
mermaidra : FaElem -> String
mermaidra elem = "graph TD\n" ++ mermaidElemek 1 elem
  where
    esc : String -> String
    esc s = pack (map (\c => if c == '"' then '\'' else c) (unpack s))

    mermaidLapit : Nat -> Nat -> List FaElem -> String
    mermaidLapit _ _ [] = ""
    mermaidLapit szulo k (g :: gs) =
      "  n" ++ show szulo ++ " --> n" ++ show k ++ "\n"
      ++ mermaidLapit szulo (k + 1 + faMeret g) gs

    mermaidElemek : Nat -> FaElem -> String
    mermaidElemek azonosito (FaFajl nev) =
      "  n" ++ show azonosito ++ "([/" ++ esc nev ++ "/])\n"
    mermaidElemek azonosito (FaSzint _ []) =
      "  n" ++ show azonosito ++ "[]\n"
    mermaidElemek azonosito (FaSzint _ gyerekek) =
      "  n" ++ show azonosito ++ "[\"\"]\n"
      ++ mermaidLapit azonosito (azonosito + 1) gyerekek

-- ─── 4. PYTHON (matplotlib) ──────────────────────────────────

||| Önálló Python-szkript (matplotlib), a fát szélességben rajzolja.
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
  ++ pyElem elem
  ++ "]\n"
  ++ "\n"
  ++ "fig, ax = plt.subplots(figsize=(14, 9))\n"
  ++ "ax.set_axis_off()\n"
  ++ "ax.set_title('opencode — Idris-fa (auto-generalt)', fontsize=14)\n"
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
  where
    esc : String -> String
    esc s = pack (map (\c => if c == '\'' then '"' else c) (unpack s))

    pyElem : FaElem -> String
    pyElem (FaFajl nev) =
      "    ('" ++ esc nev ++ "', 'FaFajl', []),\n"
    pyElem (FaSzint _ gyerekek) =
      "    ('csoport', 'FaSzint', [\n"
      ++ pyGyerekek gyerekek
      ++ "    ]),\n"
      where
        pyGyerekek : List FaElem -> String
        pyGyerekek [] = ""
        pyGyerekek (g :: gs) = pyElem g ++ pyGyerekek gs

-- ─── 5. JULIA (Plots + GraphRecipes) ────────────────────────

||| Önálló Julia-szkript (Plots + GraphRecipes), a fát graphplot-tal rajzolja.
public export
juliaba : FaElem -> String
juliaba elem =
  "# Auto-generált Julia-vizualizáció — Idris FaVizualizacio modulból.\n"
  ++ "# Futtatás: julia fa.jl\n"
  ++ "# Függőség: Plots, GraphRecipes (vagy Graphs + SimpleWeightedGraphs)\n"
  ++ "using Plots\n"
  ++ "using GraphRecipes\n"
  ++ "\n"
  ++ "function fa_rajz()\n"
  ++ "    ELEMEK = [\n"
  ++ "        (\"opencode-gyoker\", \"FaSzint\", -1, 0),\n"
  ++ "    ]\n"
  ++ "    ELEK = [\n"
  ++ "    ]\n"
  ++ "    SZINEK = [\n"
  ++ "        \"#dae8fc\",\n"
  ++ "    ]\n"
  ++ "    idx = 1\n"
  ++ "    bejar(ELEMEK, ELEK, SZINEK, elem, 0, idx)\n"
  ++ "    cimkek = [e[1] for e in ELEMEK]\n"
  ++ "    graphplot(\n"
  ++ "        ELEK,\n"
  ++ "        names = cimkek,\n"
  ++ "        node_color = SZINEK,\n"
  ++ "        nodesize = 0.08,\n"
  ++ "        method = :tree,\n"
  ++ "        root = :top,\n"
  ++ "        curves = false,\n"
  ++ "        title = \"opencode — Idris-fa (Julia / GraphRecipes)\",\n"
  ++ "    )\n"
  ++ "    savefig(\"fa_julia.png\")\n"
  ++ "    println(\"Mentve: fa_julia.png\")\n"
  ++ "end\n"
  ++ "\n"
  ++ "function bejar(ELEMEK, ELEK, SZINEK, csomopont, szulo, idx_ref)\n"
  ++ "    if csomopont isa Tuple && length(csomopont) == 3 && csomopont[1] == :FaFajl\n"
  ++ "        push!(ELEMEK, (string(csomopont[2]), \"FaFajl\", szulo, csomopont[3]))\n"
  ++ "        push!(SZINEK, \"#fff2cc\")\n"
  ++ "    else\n"
  ++ "        push!(ELEMEK, (string(csomopont[1]), \"FaSzint\", szulo, csomopont[3]))\n"
  ++ "        push!(SZINEK, \"#dae8fc\")\n"
  ++ "        for g in csomopont[3]\n"
  ++ "            push!(ELEK, (szulo, idx_ref + 1))\n"
  ++ "            bejar(ELEMEK, ELEK, SZINEK, g, csomopont[3], idx_ref + 1)\n"
  ++ "        end\n"
  ++ "    end\n"
  ++ "end\n"
  ++ "\n"
  ++ "fa_rajz()\n"
  where
    esc : String -> String
    esc s = pack (map (\c => if c == '"' then '\'' else c) (unpack s))

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
            r1 <- writeFile "/Users/joco/opencode/trail_index/viz/fa.txt"
                                              (szovegesbe fa)
            putStrLn (case r1 of Right _ => "  ✓ fa.txt"; Left _ => "  ✗ fa.txt")
            r2 <- writeFile "/Users/joco/opencode/trail_index/viz/fa.dot"
                                               (dotra fa)
            putStrLn (case r2 of Right _ => "  ✓ fa.dot"; Left _ => "  ✗ fa.dot")
            r3 <- writeFile "/Users/joco/opencode/trail_index/viz/fa.mmd"
                                               (mermaidra fa)
            putStrLn (case r3 of Right _ => "  ✓ fa.mmd"; Left _ => "  ✗ fa.mmd")
            r4 <- writeFile "/Users/joco/opencode/trail_index/viz/fa.py"
                                               (pythonba fa)
            putStrLn (case r4 of Right _ => "  ✓ fa.py"; Left _ => "  ✗ fa.py")
            r5 <- writeFile "/Users/joco/opencode/trail_index/viz/fa.jl"
                                               (juliaba fa)
            putStrLn (case r5 of Right _ => "  ✓ fa.jl"; Left _ => "  ✗ fa.jl")
            putStrLn "FaVizualizacio: kesz."
     pure ()

||| A futtatható belépési pontja.
public export
main : IO ()
main = foProgram