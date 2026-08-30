module Alap.KeresoTabla

-- ═══════════════════════════════════════════════════════════════
-- KERESŐ TÁBLA — A TELJES PROJEKT TÉRKÉPE
-- ═══════════════════════════════════════════════════════════════
-- Minden struktúra, kategória, algebra egy helyen.
-- A tábla = a projekt memóriája: hol van, mi az, hova kapcsol.
-- Nincs Refl, nincs pattern matching — csak dependent types.
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. PROJEKT MODULOK INDEXE ──────────────────────────────

||| Projekt modul: hol található, mit tartalmaz.
public export
record ModulMutato where
  constructor ModulMutatoKonstruktor
  modulUtvonal    : String  -- pl. "Alap.SzamT"
  modulFajl       : String  -- pl. "osveny_index/Alap/SzamT.idr"
  modulLeiras     : String  -- magyar leírás
  modulTipus      : ModulTipus

public export
data ModulTipus = AlapModul | KategoriaModul | SzamModul | FizikaModul
                | QuantumModul | NyelvModul | GeometriaModul

-- ─── 2. KATEGÓRIAELMÉLETI STRUKTÚRÁK TÁBLÁJA ─────────────────

||| Kategóriaelméleti struktúra bejegyzés.
public export
record KategoriaBejegyzes where
  constructor KategoriaBejegyzesKonstruktor
  strukturaSorszam    : Nat
  strukturaAngolNev   : String
  strukturaMagyarNev  : String
  strukturaWikipedia  : String
  idrisTipusNev       : String       -- pl. "KategoriaT"
  idrisModul          : String       -- hol van definiálva
  szuperStrukturak    : List Nat     -- melyik struktúrákból épül fel
  algebraiParja       : Maybe String  -- pl. "Monoid"
  fizikaiParja        : Maybe String  -- pl. "IdoInverz"

-- ─── 3. ALGEBRAI STRUKTÚRÁK TÁBLÁJA ─────────────────────────

||| Algebrai struktúra bejegyzés.
public export
record AlgebraBejegyzes where
  constructor AlgebraBejegyzesKonstruktor
  algebraNev          : String
  algebraTipuscsalad  : String       -- melyik típuscsaládhoz tartozik
  muveletek           : List String   -- pl. ["osszead", "szoroz"]
  torvenyek           : List String   -- pl. ["asszociativ", "kommutativ"]
  kategoriaMegfelel   : Maybe Nat      -- melyik kategória sorszám
  fizikaiMegfelel     : Maybe String  -- pl. "ToltesParitasIdo"

-- ─── 4. FIZIKAI KONSTANSOK ÉS KÉPLETEK ───────────────────────

||| Fizikai mennyiség bejegyzés.
public export
record FizikaiBejegyzes where
  constructor FizikaiBejegyzesKonstruktor
  mennyisegNev        : String
  mennyisegJele       : String       -- pl. "α⁻¹"
  codataErtek         : String       -- hivatalos mért érték
  szamitottErtek      : Maybe String -- a mi számításunk
  relativHiba         : Maybe String -- pl. "5.8 ppb"
  tipuscsalad         : String       -- melyik típuscsalád számítja ki

-- ─── 5. MAGYAR NYELVI EGYEGÉSEK ─────────────────────────────

||| Magyar szó → kategóriaelméleti fogalom.
public export
record MagyarLexikonBejegyzes where
  constructor MagyarLexikonBejegyzesKonstruktor
  magyarSzo           : String
  magyarEsetRag       : String       -- pl. "-ban/-ben" (belső állapot)
  kategoriajelentes   : String       -- pl. "belső hom-funktor"
  algebraiJelentes    : String       -- pl. "kommutátor"
  fizikaiJelentes     : String       -- pl. "CPT-invariancia"

-- ═══════════════════════════════════════════════════════════════
-- 6. A [[15,1,3]] KÓD STRUKTÚRÁJA
-- ═══════════════════════════════════════════════════════════════

||| A kód paraméterei: [[n, k, d]]
||| n = kódszó hossz, k = logikai kubit, d = távolság
public export
record KvantumKodParameterek where
  constructor KvantumKodParameterekKonstruktor
  kodHossz            : Nat   -- n = 15 (vagy 7 Steane-nál)
  logikaiKubit        : Nat   -- k = 1
  kodTavolsag         : Nat   -- d = 3
  hibakJavithatok     : Nat   -- (d-1)/2 = 1

public export
steaneKodParameterek : KvantumKodParameterek
steaneKodParameterek = KvantumKodParameterekKonstruktor 7 1 3 1

public export
tizenotKodParameterek : KvantumKodParameterek
tizenotKodParameterek = KvantumKodParameterekKonstruktor 15 1 3 1

-- ═══════════════════════════════════════════════════════════════
-- 7. A 7 BIT JELENTÉSE (Steane [[7,1,3]])
-- ═══════════════════════════════════════════════════════════════

||| Steane kód 7 bitjének jelentése:
||| [idő, okság, tér, szín, hang, fázis, mód]
public export
data SteaneBitJelentes = Idobit | Oksagbit | Terbit | Szinbit
                       | Hangbit | Fazisbit | Modbit

public export
Show SteaneBitJelentes where
  show Idobit    = "idő (idő)"
  show Oksagbit  = "okság (ok)"
  show Terbit    = "tér (tér)"
  show Szinbit   = "szín (szín)"
  show Hangbit   = "hang (hang)"
  show Fazisbit  = "fázis (fázis)"
  show Modbit    = "mód (mód)"

-- ═══════════════════════════════════════════════════════════════
-- 8. CPT RÉTEGEK LEKÉPEZÉSE
-- ═══════════════════════════════════════════════════════════════

||| CPT három rétegen: fizikai, nyelvtani, pszichofizikai.
public export
record CptRekord where
  constructor CptRekordKonstruktor
  fizikaiC    : String   -- C: töltés (charge)
  fizikaiP    : String   -- P: paritás (parity)
  fizikaiT    : String   -- T: idő (time)
  nyelvtaniC  : String   -- C: forrás (honnan tudom)
  nyelvtaniP  : String   -- P: szemlélet (hogyan látom)
  nyelvtaniT  : String   -- T: igeidő (mikor)
  pszichoC    : String   -- C: saját tudat (önreferencia)
  pszichoP    : String   -- P: másik fél (külső bemenet)
  pszichoT    : String   -- T: kapcsolat fázisa (dinamika)

public export
cptPelda : CptRekord
cptPelda = CptRekordKonstruktor
  "töltés (részecske ↔ antirészecske)"
  "paritás (bal ↔ jobb tükrözés)"
  "idő (idő visszafordítása)"
  "forrás (közvetlen / következtetett / jelentett)"
  "szemlélet (folyamatos / befejezett / szokásos)"
  "igeidő (múlt / jelen / jövő)"
  "saját tudat (ki vagyok én)"
  "másik fél (ki vagy te)"
  "kapcsolat fázisa (hogyan vagyunk együtt)"

-- ═══════════════════════════════════════════════════════════════
-- 9. FÁJLLOKÁCIÓK TÁBLÁJA
-- ═══════════════════════════════════════════════════════════════

||| Minden fájl és funkciója.
public export
record FajlBejegyzes where
  constructor FajlBejegyzesKonstruktor
  fajlUtvonal         : String
  fajlFunkcio         : String
  exportaltTipusok    : List String
  fuggesek            : List String

-- Példák a meglévő fájlokra:
public export
alapSzamTFajl : FajlBejegyzes
alapSzamTFajl = FajlBejegyzesKonstruktor
  "osveny_index/Alap/SzamT.idr"
  "Számok mint data (0-10), műveletek typeclass-ként"
  ["EgeszSzam", "OsszeadasT", "SzorzasT", "KivonasT", "InverzT", "RendelezesT"]
  []

public export
alapKategoriaTFajl : FajlBejegyzes
alapKategoriaTFajl = FajlBejegyzesKonstruktor
  "osveny_index/Alap/KategoriaT.idr"
  "49 kategóriaelméleti struktúra typeclass-ként"
  ["KategoriaT", "FunktorT", "TermeszetesTranszformacioT", "AdjunkcioT", "MonadT"]
  []

public export
fazisAlgebraFajl : FajlBejegyzes
fazisAlgebraFajl = FajlBejegyzesKonstruktor
  "osveny_index/FazisAlgebra.idr"
  "Fázis algebra, redundancia detektálás, CPT"
  ["Fazis", "ToltesParitasIdo", "FazisHatar"]
  ["HaromKubit", "E8E8Algebra"]

public export
e8E8AlgebraFajl : FajlBejegyzes
e8E8AlgebraFajl = FajlBejegyzesKonstruktor
  "osveny_index/E8E8Algebra.idr"
  "E8 × E8 Clifford algebra, kvantum kódok"
  ["E8E8KodSzo", "CliﬀordSzorzat"]
  []

-- ═══════════════════════════════════════════════════════════════
-- 10. KERESŐ FÜGGVÉNY — A TÁBLÁK LEKÉRDEZÉSE
-- ═══════════════════════════════════════════════════════════════

||| Keresés: melyik modulban van egy típus?
public export
modulKereses : String -> List FajlBejegyzes -> Maybe String
modulKereses _ [] = Nothing
modulKereses nev (x :: xs) =
  if elem nev x.exportaltTipusok
    then Just x.fajlUtvonal
    else modulKereses nev xs

-- ═══════════════════════════════════════════════════════════════
-- 11. A TELJES PROJEKT GRÁFJA
-- ═══════════════════════════════════════════════════════════════

||| A projekt függőségi gráfja: melyik modul mit importál.
public export
record FuggosegGraf where
  constructor FuggosegGrafKonstruktor
  csucs               : String   -- modul neve
  gyerekCsucsok       : List String  -- mely modulokat importálja

-- A teljes projekt modul gráfja (manuálisan karbantartva):
public export
projektGraf : List FuggosegGraf
projektGraf =
  [ FuggosegGrafKonstruktor "Alap.SzamT" []
  , FuggosegGrafKonstruktor "Alap.DependensSzamT" ["Alap.SzamT"]
  , FuggosegGrafKonstruktor "Alap.KategoriaT" ["Alap.SzamT"]
  , FuggosegGrafKonstruktor "Alap.KeresoTabla" ["Alap.SzamT", "Alap.KategoriaT"]
  , FuggosegGrafKonstruktor "HaromKubit" []
  , FuggosegGrafKonstruktor "E8E8Algebra" ["HaromKubit"]
  , FuggosegGrafKonstruktor "FazisAlgebra" ["HaromKubit", "E8E8Algebra"]
  ]

-- ═══════════════════════════════════════════════════════════════
-- 12. ÜRES TÁBLÁK — KITÖLTENDŐ
-- ═══════════════════════════════════════════════════════════════

||| A 49 kategóriaelméleti struktúra listája.
||| Ezt a KategoriaT.idr-ből kell kitölteni.
public export
kategoriaStrukturak : List KategoriaBejegyzes
kategoriaStrukturak = []  -- TODO: kitölteni a 49 bejegyzéssel

||| Az algebrai struktúrák listája.
public export
algebraStrukturak : List AlgebraBejegyzes
algebraStrukturak = []  -- TODO: kitölteni

||| A fizikai konstansok listája.
public export
fizikaiKonstansok : List FizikaiBejegyzes
fizikaiKonstansok = []  -- TODO: kitölteni

||| A magyar lexikon bejegyzések.
public export
magyarLexikon : List MagyarLexikonBejegyzes
magyarLexikon = []  -- TODO: kitölteni

-- ═══════════════════════════════════════════════════════════════
-- FŐPROGRAM
-- ═══════════════════════════════════════════════════════════════

public export
keresoTablaFom : IO ()
keresoTablaFom = do
  putStrLn "=== KERESŐ TÁBLA ==="
  putStrLn ""
  putStrLn "A projekt teljes térképe. Minden modul, típus, kapcsolat."
  putStrLn ""
  putStrLn "Steane kód paraméterek:"
  putStrLn ("  n=" ++ show steaneKodParameterek.kodHossz ++
            " k=" ++ show steaneKodParameterek.logikaiKubit ++
            " d=" ++ show steaneKodParameterek.kodTavolsag)
  putStrLn ""
  putStrLn "A 7 bit jelentése:"
  putStrLn ("  1. " ++ show Idobit)
  putStrLn ("  2. " ++ show Oksagbit)
  putStrLn ("  3. " ++ show Terbit)
  putStrLn ("  4. " ++ show Szinbit)
  putStrLn ("  5. " ++ show Hangbit)
  putStrLn ("  6. " ++ show Fazisbit)
  putStrLn ("  7. " ++ show Modbit)
  putStrLn ""
  putStrLn "CPT rétegek példa:"
  putStrLn ("  Fizikai: " ++ cptPelda.fizikaiC ++ ", " ++ cptPelda.fizikaiP ++ ", " ++ cptPelda.fizikaiT)
  putStrLn ("  Nyelvtani: " ++ cptPelda.nyelvtaniC ++ ", " ++ cptPelda.nyelvtaniP ++ ", " ++ cptPelda.nyelvtaniT)
  putStrLn ("  Pszichofizikai: " ++ cptPelda.pszichoC ++ ", " ++ cptPelda.pszichoP ++ ", " ++ cptPelda.pszichoT)
  putStrLn ""
  putStrLn "Fájl keresés példa ('EgeszSzam'):"
  case modulKereses "EgeszSzam" [alapSzamTFajl, alapKategoriaTFajl, fazisAlgebraFajl, e8E8AlgebraFajl] of
    Just utvonal => putStrLn ("  Találat: " ++ utvonal)
    Nothing      => putStrLn "  Nem található."
  putStrLn ""
  putStrLn "Üres táblák (kitöltendő):"
  putStrLn ("  Kategóriák: " ++ show (length kategoriaStrukturak) ++ "/49")
  putStrLn ("  Algebrák: " ++ show (length algebraStrukturak))
  putStrLn ("  Fizikai konstansok: " ++ show (length fizikaiKonstansok))
  putStrLn ("  Magyar lexikon: " ++ show (length magyarLexikon))
  putStrLn ""
  putStrLn "Kész.
