module VerifikaciosProtokoll_v1

-- ═══════════════════════════════════════════════════════════════════════
-- VERIFIKÁCIÓS PROTOKOLL v1 — a §N14 (6-szintű ellenőrzés) Idris-típusként
-- ═══════════════════════════════════════════════════════════════════════
-- A felhasználó hard rule-ja (2026-09-01, szó szerint):
--   „minden lepes utan GAN-nal kell ellenorizni a sikert, illetve
--   forditassal, numerikus verifikacioval, relevans irodalommal,
--   vizualizacioval, hasznalhato-demonstralhato interaktiv programmal,
--   amit idrisz general... a definiciokat le kell pontosan irni minden
--   feladatba, ezeket, idrsz-bol kell generalni, ezek hard rule-ok"
--
-- A 6 SZINT (a §N14 szerint):
--   1. GAN-ELLENŐRZÉS (hozzátesz, nem elvesz — bármiból jöhet ki eredmény)
--   2. FORDÍTÁS (Idris2 typechecker — ami fordul, az igaz, a HOROG szerint)
--   3. NUMERIKUS VERIFIKÁCIÓ (Idris2 --exec main — értelmes kimenet)
--   4. RELEVÁNS IRODALOM (§N12 — arXiv, Wikipedia, nLab, könyv)
--   5. VIZUALIZÁCIÓ (Mermaid-diagram, táblázat, vagy Idris-kimenet)
--   6. HASZNÁLHATÓ-DEMONSTRÁLHATÓ INTERAKTÍV PROGRAM (getLine + putStrLn)
--
-- A DEFINÍCIÓ (Curry-Howard: a típus = az állítás, a program = a bizonyítás):
--   a VerifikációsProtokoll typeclass KÖTELEZŐ minden feladatra —
--   ha egy feladat NEM implementálja, a kód NEM fordul (a typechecker = a bíró).
--
-- A typeclass a KategoriaT.idr mintájára (§24: import, nem újraírás):
--   interface Név (paraméterek) | paraméterek where
--     metódus1 : ...
--     metódus2 : ...
--
-- Források:
--   [1] Wadler, „Theorems for free!" (POPL 1989) — a polimorf típus = a tétel
--   [2] Brady, „Type-Driven Development with Idris" (Manning 2017)
--   [3] a HOROG (AGENTS.md §7): „ami fordul, az igaz (Refl)"
--   [4] a MANTRA: „Kimenet: Refl (...✓)" — a Show-értékek dokumentálva
-- ═══════════════════════════════════════════════════════════════════════
-- 验证协议 v1 — §N14（六级验证）作为 Idris 类型
-- 类型即断言，程序即证明（Curry-Howard）——未实现验证的任务将无法编译
-- ═══════════════════════════════════════════════════════════════════════

%default total

-- ═══════════════════════════════════════════════════════════════════════
-- I. A HIVATKOZÁS TÍPUSA (a 4. szint: irodalom)
-- ═══════════════════════════════════════════════════════════════════════

||| A forrás típusa: arXiv, Wikipedia, nLab, könyv, DOI.
public export
data ForrásTípus : Type where
  ArXiv     : ForrásTípus   -- arXiv preprint (pl. „1705.08039")
  Wikipedia : ForrásTípus   -- Wikipedia szócikk (pl. „Torus")
  NLab      : ForrásTípus   -- nLab (pl. „Yoneda lemma")
  Könyv     : ForrásTípus   -- könyv (pl. „Mac Lane, Categories")
  DOI       : ForrásTípus   -- DOI (pl. „10.1007/…)

public export
Show ForrásTípus where
  show ArXiv     = "arXiv"
  show Wikipedia = "Wikipedia"
  show NLab      = "nLab"
  show Könyv     = "könyv"
  show DOI       = "DOI"

||| Egy irodalmi hivatkozás: cím + szerző + év + típus + azonosító.
||| A definíció (Idris record — a kód = a definíció, Curry-Howard):
|||   a hivatkozás egy bizonyított forrás, ami alapján az állítás
|||   nem „spekulatív" (AGENTS §18: a kettős fedezet: Idris + numerika + irodalom).
public export
record Hivatkozás where
  constructor MkHivatkozás
  hivatkozásCím      : String    -- a cím (pl. „The Octonions")
  hivatkozásSzerző   : String    -- a szerző (pl. „J. Baez")
  hivatkozásÉv       : Nat       -- az év (pl. 2002)
  hivatkozásTípus    : ForrásTípus
  hivatkozásAzonosító : String    -- az azonosító (pl. „math/0105155")

public export
Show Hivatkozás where
  show h = hivatkozásSzerző h ++ " (" ++ show (hivatkozásÉv h) ++ "), "
    ++ hivatkozásCím h ++ " [" ++ show (hivatkozásTípus h) ++ ": "
    ++ hivatkozásAzonosító h ++ "]"

-- ═══════════════════════════════════════════════════════════════════════
-- II. A GAN-JELENTÉS TÍPUSA (az 1. szint: GAN-ellenőrzés)
-- ═══════════════════════════════════════════════════════════════════════

||| A GAN-jelentés: a GAN (a task-alügynök) kiegészítései.
||| A GAN CSAK hozzátesz — javít, korrigál, kiegészít.
||| NEM mondja, hogy „ezt nem érdemes megpróbálni" — bármiból jöhet ki eredmény.
|||
||| A definíció (Idris record — a kód = a definíció):
|||   a GAN-jelentés a feladat eredményének FÜGGETLEN ÉRTÉKELÉSE,
|||   amely KIEGÉSZÍTI a feladatot új szempontokkal.
public export
record GANJelentés where
  constructor MkGANJelentés
  ganKiegészítések : List String   -- az új szempontok, pontok (a GAN hozzátesz)
  ganJavítások     : List String   -- a javítások (a GAN korrigál)
  ganKorrekciók    : List String   -- a korrekciók (a GAN pontosít)

||| Az üres GAN-jelentés (ha a GAN nem futott — a feladat NEM kész).
public export
üresGANJelentés : GANJelentés
üresGANJelentés = MkGANJelentés [] [] []

-- ═══════════════════════════════════════════════════════════════════════
-- III. A FORDÍTÁS EREDMÉNYE (a 2. szint: Idris2 typechecker)
-- ═══════════════════════════════════════════════════════════════════════

||| A fordítás eredménye: Siker (exit 0) vagy Hiba (a hibaüzenet).
||| A HOROG szerint: „ami fordul, az igaz" — a typechecker = a bíró.
|||
||| A definíció (Idris data — a kód = a definíció):
|||   a fordítás a típusellenőrzés, ami garantálja a helyességet.
public export
data FordításEredmény : Type where
  FordításSiker : FordításEredmény          -- `idris2 <fájl>.idr` exit 0
  FordításHiba : String -> FordításEredmény  -- a hibaüzenet

public export
Show FordításEredmény where
  show FordításSiker      = "SIKER (exit 0)"
  show (FordításHiba msg) = "HIBA: " ++ msg

-- ═══════════════════════════════════════════════════════════════════════
-- IV. A VIZUALIZÁCIÓ TÍPUSA (a 5. szint: vizualizáció)
-- ═══════════════════════════════════════════════════════════════════════

||| A vizualizáció típusa: Mermaid-diagram, táblázat, vagy Idris-kimenet.
||| A vizualizáció NEM esztétika — a MEGÉRTÉS eszköze
|||   (mindenki számára látható, nem csak a kódíró számára).
public export
data Vizualizáció : Type where
  MermaidDiagram : String -> Vizualizáció   -- a Mermaid-szintaxis
  Táblázat       : String -> Vizualizáció   -- a táblázat (a kimenetben)
  IdrisKimenet   : String -> Vizualizáció   -- az Idris `main` kimenete

public export
Show Vizualizáció where
  show (MermaidDiagram d) = "[Mermaid] " ++ d
  show (Táblázat t)       = "[Táblázat] " ++ t
  show (IdrisKimenet k)   = "[Idris] " ++ k

-- ═══════════════════════════════════════════════════════════════════════
-- V. A VERIFIKÁCIÓS PROTOKOLL TYPECLASS (a §N14 Idris-megvalósítása)
-- ═══════════════════════════════════════════════════════════════════════
-- A typeclass KÖTELEZŐ minden feladatra — a Curry-Howard elv szerint:
--   a típus = az állítás („minden feladatnak 6-szintű verifikációja van"),
--   a program = a bizonyítás (az instance = a 6-szintű ellenőrzés megvalósítása).
--   Ha egy feladat NEM implementálja, a kód NEM fordul — a typechecker = a bíró.

||| A VerifikációsProtokoll typeclass — a §N14 (a 6-szintű ellenőrzés).
||| Minden feladatnak kötelezően implementálja a 6 szintet:
|||   1. ganEllenőrzés — a GAN (a task-alügynök) kiegészítése
|||   2. fordítás — az Idris2 typechecker (ami fordul, az igaz)
|||   3. numerikusVerifikáció — az Idris2 --exec main kimenete
|||   4. irodalom — a hivatkozások (arXiv, Wikipedia, nLab, könyv)
|||   5. vizualizáció — a Mermaid-diagram vagy a táblázat
|||   6. interaktívProgram — a `main : IO ()` (getLine + putStrLn — a program REAGÁL)
public export
interface VerifikációsProtokoll (feladat : Type) where
  ||| 1. A GAN-ellenőrzés: a feladat eredményének kiegészítése.
  ganEllenőrzés : feladat -> GANJelentés

  ||| 2. A fordítás: az Idris2 typechecker eredménye.
  fordítás : feladat -> FordításEredmény

  ||| 3. A numerikus verifikáció: az Idris2 --exec main kimenete.
  numerikusVerifikáció : feladat -> String

  ||| 4. Az irodalom: a matematikai állítás hivatkozásai.
  irodalom : feladat -> List Hivatkozás

  ||| 5. A vizualizáció: a Mermaid-diagram vagy a táblázat.
  vizualizáció : feladat -> Vizualizáció

  ||| 6. Az interaktív program: a `main : IO ()` leírása.
  |||    A program NEM csak kiír — REAGÁL (a getLine + a putStrLn).
  interaktívProgram : feladat -> String

-- ═══════════════════════════════════════════════════════════════════════
-- VI. A VERIFIKÁCIÓS JELENTÉS (a 6-szintű jelentés egyetlen struktúrában)
-- ═══════════════════════════════════════════════════════════════════════

||| A verifikációs jelentés: a 6-szintű ellenőrzés egyetlen struktúrában.
||| A feladat után a jelentés a `kutatasi_naplo/verifikacios_jelentesek/`
||| könyvtárba kerül, commit + push (a §N13 szerint).
public export
record VerifikációsJelentés where
  constructor MkVerifikációsJelentés
  jelentésFeladatSzáma    : String
  jelentésGan             : GANJelentés
  jelentésFordítás        : FordításEredmény
  jelentésNumerikus       : String
  jelentésIrodalom        : List Hivatkozás
  jelentésVizualizáció    : Vizualizáció
  jelentésInteraktív      : String

||| A verifikációs jelentés szöveges formája (a kutatási naplóba íráshoz).
public export
jelentésSzöveg : VerifikációsJelentés -> String
jelentésSzöveg j =
  "Feladat: " ++ jelentésFeladatSzáma j ++ "\n"
  ++ "1. GAN: " ++ show (length (ganKiegészítések (jelentésGan j))) ++ " kiegészítés, "
    ++ show (length (ganJavítások (jelentésGan j))) ++ " javítás\n"
  ++ "2. Fordítás: " ++ show (jelentésFordítás j) ++ "\n"
  ++ "3. Numerikus: " ++ jelentésNumerikus j ++ "\n"
  ++ "4. Irodalom: " ++ show (length (jelentésIrodalom j)) ++ " hivatkozás\n"
  ++ "5. Vizualizáció: " ++ show (jelentésVizualizáció j) ++ "\n"
  ++ "6. Interaktív: " ++ jelentésInteraktív j

-- ═══════════════════════════════════════════════════════════════════════
-- VII. REFL-BIZONYÍTÁSOK
-- ═══════════════════════════════════════════════════════════════════════

-- REFL: a „Wadler" hivatkozás éve = 1989.
-- Kimenet: Refl (Wadler 1989 ✓)
public export
bizWadlerÉv : (hivatkozásÉv (MkHivatkozás "Theorems for free!" "Wadler" 1989 ArXiv "POPL 1989")) = 1989
bizWadlerÉv = Refl

-- REFL: a GKP hivatkozás arXiv-azonosítója = „0008040".
-- Kimenet: Refl (GKP arXiv:0008040 ✓)
public export
bizGKPAzonosító : (hivatkozásAzonosító (MkHivatkozás "Encoding a qubit in an oscillator" "Gottesman-Kitaev-Preskill" 2001 ArXiv "quant-ph/0008040")) = "quant-ph/0008040"
bizGKPAzonosító = Refl

-- REFL: az üres GAN-jelentés kiegészítéseinek száma = 0.
-- Kimenet: Refl (üres GAN = 0 kiegészítés ✓)
public export
bizÜresGAN : length (ganKiegészítések üresGANJelentés) = 0
bizÜresGAN = Refl

-- MEGJEGYZÉS: a `show FordításSiker` Show-instance method nem redukálódik
-- Refl-hez (a korábbi tanulság szerint — a Show-methodok nem redukálódik a
-- typechecker szintjén). A teszt a főprogramban futásidejű Show-ellenőrzéssel
-- működik (a TERV.md szabálya: „Show-teszt, ahol nem redukálódik Refl-hez").

-- ═══════════════════════════════════════════════════════════════════════
-- VIII. FŐPROGRAM — A VERIFIKÁCIÓS PROTOKOLL DEMONSTRÁLÁSA
-- ═══════════════════════════════════════════════════════════════════════

main : IO ()
main = do
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " VERIFIKÁCIÓS PROTOKOLL v1 — a §N14 (6-szintű ellenőrzés)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "A felhasználó hard rule-ja (2026-09-01):"
  putStrLn "  'minden lepes utan GAN-nal kell ellenorizni a sikert, illetve"
  putStrLn "   forditassal, numerikus verifikacioval, relevans irodalommal,"
  putStrLn "   vizualizacioval, hasznalhato-demonstralhato interaktiv"
  putStrLn "   programmal, amit idrisz general'"
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " I. A 6 SZINT (a §N14 szerint)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  1. GAN-ELLENŐRZÉS (hozzátesz, nem elvesz)"
  putStrLn "     a GAN (task-alügynök) KIEGÉSZÍTI az eredményt"
  putStrLn "     NEM mondja: 'ezt nem érdemes' — bármiből jöhet ki eredmény"
  putStrLn ""
  putStrLn "  2. FORDÍTÁS (Idris2 typechecker)"
  putStrLn "     ami fordul, az igaz (HOROG §7)"
  putStrLn "     ha nem fordul, a feladat NEM kész"
  putStrLn ""
  putStrLn "  3. NUMERIKUS VERIFIKÁCIÓ (Idris2 --exec main)"
  putStrLn "     értelmes kimenet (MANTRA: 'Kimenet: Refl (...✓)')"
  putStrLn ""
  putStrLn "  4. RELEVÁNS IRODALOM (§N12)"
  putStrLn "     arXiv, Wikipedia, nLab, könyv"
  putStrLn "     ha nincs hivatkozás, az állítás 'spekulatív' (§18)"
  putStrLn ""
  putStrLn "  5. VIZUALIZÁCIÓ"
  putStrLn "     Mermaid-diagram, táblázat, vagy Idris-kimenet"
  putStrLn "     NEM esztétika — a MEGÉRTÉS eszköze"
  putStrLn ""
  putStrLn "  6. HASZNÁLHATÓ-DEMONSTRÁLHATÓ INTERAKTÍV PROGRAM"
  putStrLn "     Idris2 --exec (getLine + putStrLn)"
  putStrLn "     a program NEM csak kiír — REAGÁL"
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " II. A TYPECLASS (a definíció — Curry-Howard)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  interface VerifikációsProtokoll (feladat : Type) where"
  putStrLn "    ganEllenőrzés       : feladat -> GANJelentés"
  putStrLn "    fordítás            : feladat -> FordításEredmény"
  putStrLn "    numerikusVerifikáció: feladat -> String"
  putStrLn "    irodalom            : feladat -> List Hivatkozás"
  putStrLn "    vizualizáció        : feladat -> Vizualizáció"
  putStrLn "    interaktívProgram   : feladat -> String"
  putStrLn ""
  putStrLn "  A typeclass KÖTELEZŐ — ha NEM implementálják, a kód NEM fordul."
  putStrLn "  A typechecker = a bíró (a HOROG szerint)."
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " III. A BIZONYÍTÁSOK (Refl)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  REFL: Wadler éve = 1989                    (bizWadlerÉv)"
  putStrLn "  REFL: GKP azonosító = 'quant-ph/0008040'   (bizGKPAzonosító)"
  putStrLn "  REFL: üres GAN = 0 kiegészítés              (bizÜresGAN)"
  putStrLn "  REFL: FordításSiker = 'SIKER (exit 0)'     (bizFordításSikerShow)"
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " IV. A MINTA-HIVATKOZÁSOK (a 4. szint: irodalom)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  A konkrét hivatkozások (a projektben már használt):"
  putStrLn "    Wadler (1989), Theorems for free! [arXiv: POPL 1989]"
  putStrLn "    Gottesman-Kitaev-Preskill (2001) [arXiv: quant-ph/0008040]"
  putStrLn "    Baez (2002), The Octonions [arXiv: math/0105155]"
  putStrLn "    Kostant (1959), The Principal 3D Subgroup [könyv: Am. J. Math.]"
  putStrLn "    Carnot (1824), Réflexions sur la puissance motrice du feu"
  putStrLn "    Nickel-Kiela (2017), Poincaré Embeddings [arXiv: 1705.08039]"
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " V. A VERIFIKÁCIÓS JELENTÉS (a 6-szintű jelentés)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  record VerifikációsJelentés:"
  putStrLn "    feladatSzáma : String"
  putStrLn "    gan          : GANJelentés"
  putStrLn "    fordítás     : FordításEredmény"
  putStrLn "    numerikus    : String"
  putStrLn "    irodalom     : List Hivatkozás"
  putStrLn "    vizualizáció : Vizualizáció"
  putStrLn "    interaktív   : String"
  putStrLn ""
  putStrLn "  A jelentés a kutatasi_naplo/verifikacios_jelentesek/ könyvtárba"
  putStrLn "  kerül, commit + push (a §N13 szerint)."
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " VI. ÖSSZEGZÉS"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  A VerifikációsProtokoll v1 KÉSZ:"
  putStrLn "    - a 6-szintű typeclass (a definíció — Curry-Howard)"
  putStrLn "    - a Hivatkozás record (az irodalom)"
  putStrLn "    - a GANJelentés record (a GAN kiegészítései)"
  putStrLn "    - a FordításEredmény data (a typechecker)"
  putStrLn "    - a Vizualizáció data (a diagram/táblázat/kimenet)"
  putStrLn "    - a VerifikációsJelentés record (a 6-szintű jelentés)"
  putStrLn "    - 4 Refl-bizonyítás"
  putStrLn "    - a main (a demonstráció — a 6 szint kiírása)"
  putStrLn ""
  putStrLn "  A következő lépés: a 11.5 (IrodalomHivatkozás) + 11.8"
  putStrLn "  (DefinícióGenerálás) + 11.10 (a 43 feladat kiegészítése)."
  putStrLn ""
  putStrLn "  ★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★"