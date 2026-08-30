module MagyarNyelvtan

import Steane713
import E8E8Algebra

-- ═══════════════════════════════════════════════════════════════
-- MAGYAR NYELVTAN — A 18 ESETRAG + IGERAGOZÁS TÍPUSOKKÉNT
-- ═══════════════════════════════════════════════════════════════
-- Forrás: Kiefer Ferenc (szerk.): Új magyar nyelvtan (2011)
--         trail_index/books/magyar_esetragok.txt
--         trail_index/books/magyar_igeragozas.txt
--
-- A magyar nyelvtan kategóriaelméleti lebontása:
--   18 esetrag = 18 morfizmus (Kiefer szerint, nem 28)
--   igeragozás = igeidő × mód × alanyi/tárgyas
--   agglutináció = tő ⊗ képző ⊗ számjel ⊗ birtokjel ⊗ esetrag
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. A 18 ESETRAG ───────────────────────────────────────

||| A 18 magyar esetrag (Kiefer 2011 szerint).
||| A hagyományos 28-ból 18 valódi esetrag, a többi képző.
public export
data Esetrag = NominativusE  | AccusativusE  | DativusE
             | InessivusE    | ElativusE     | IllativusE
             | SuperessivusE | AdessivusE    | DelativusE
             | AblativusE    | SublativusE   | AllativusE
             | TerminativusE | InstrumentalisE | CausalisFinalisE
             | TranszlativusE | FormativusE  | EssivusFormalisE

public export
Eq Esetrag where
  NominativusE    == NominativusE    = True
  AccusativusE    == AccusativusE    = True
  DativusE        == DativusE        = True
  InessivusE      == InessivusE      = True
  ElativusE       == ElativusE       = True
  IllativusE      == IllativusE      = True
  SuperessivusE   == SuperessivusE   = True
  AdessivusE      == AdessivusE      = True
  DelativusE      == DelativusE      = True
  AblativusE      == AblativusE      = True
  SublativusE     == SublativusE     = True
  AllativusE      == AllativusE      = True
  TerminativusE   == TerminativusE   = True
  InstrumentalisE == InstrumentalisE = True
  CausalisFinalisE== CausalisFinalisE= True
  TranszlativusE  == TranszlativusE  = True
  FormativusE     == FormativusE     = True
  EssivusFormalisE== EssivusFormalisE= True
  _ == _ = False

||| Az esetrag magyar neve.
public export
esetragNev : Esetrag -> String
esetragNev NominativusE     = "nominativus"
esetragNev AccusativusE     = "accusativus"
esetragNev DativusE         = "dativus"
esetragNev InessivusE       = "inessivus"
esetragNev ElativusE        = "elativus"
esetragNev IllativusE       = "illativus"
esetragNev SuperessivusE    = "superessivus"
esetragNev AdessivusE       = "adessivus"
esetragNev DelativusE       = "delativus"
esetragNev AblativusE       = "ablativus"
esetragNev SublativusE      = "sublativus"
esetragNev AllativusE       = "allativus"
esetragNev TerminativusE    = "terminativus"
esetragNev InstrumentalisE  = "instrumentalis"
esetragNev CausalisFinalisE = "causalis-finalis"
esetragNev TranszlativusE   = "transzlativus-factivus"
esetragNev FormativusE      = "formativus"
esetragNev EssivusFormalisE = "essivus-formalisi"

||| Az esetrag kérdése (milyen kérdésre válaszol).
public export
esetragKerdes : Esetrag -> String
esetragKerdes NominativusE     = ""
esetragKerdes AccusativusE     = "tárgy"
esetragKerdes DativusE         = "kinek/minek?"
esetragKerdes InessivusE       = "hol?"
esetragKerdes ElativusE        = "honnan?"
esetragKerdes IllativusE       = "hová?"
esetragKerdes SuperessivusE    = "hol?"
esetragKerdes AdessivusE       = "hol?"
esetragKerdes DelativusE       = "honnan?"
esetragKerdes AblativusE       = "honnan?"
esetragKerdes SublativusE      = "hová?"
esetragKerdes AllativusE       = "hová?"
esetragKerdes TerminativusE    = "meddig?"
esetragKerdes InstrumentalisE  = "mivel?"
esetragKerdes CausalisFinalisE = "miért?"
esetragKerdes TranszlativusE   = "mivé?"
esetragKerdes FormativusE      = "miképpen?"
esetragKerdes EssivusFormalisE = "mint?"

-- ─── 2. ESETRAG ALAKOK — mély és magas hangrend ─────────────

||| Hangrend: mély (a, o, u) vagy magas (e, ö, ü).
public export
data Hangrend = Mely | Magas

public export
Eq Hangrend where
  Mely == Mely = True
  Magas == Magas = True
  _ == _ = False

||| Az esetrag konkrét alakja hangrend szerint.
||| A Kiefer-féle nagybetűs jelölés: A=a/e, V=a/o/ö/e, stb.
public export
esetragAlak : Esetrag -> Hangrend -> String
esetragAlak NominativusE     _        = ""
esetragAlak AccusativusE     Mely     = "-t/-ot/-at"
esetragAlak AccusativusE     Magas    = "-t/-et/-öt"
esetragAlak DativusE         Mely     = "-nak"
esetragAlak DativusE         Magas    = "-nek"
esetragAlak InessivusE       Mely     = "-ban"
esetragAlak InessivusE       Magas    = "-ben"
esetragAlak ElativusE        Mely     = "-ból"
esetragAlak ElativusE        Magas    = "-ből"
esetragAlak IllativusE       Mely     = "-ba"
esetragAlak IllativusE       Magas    = "-be"
esetragAlak SuperessivusE    Mely     = "-on"
esetragAlak SuperessivusE    Magas    = "-en/-ön"
esetragAlak AdessivusE       Mely     = "-nál"
esetragAlak AdessivusE       Magas    = "-nél"
esetragAlak DelativusE       Mely     = "-ról"
esetragAlak DelativusE       Magas    = "-ről"
esetragAlak AblativusE       Mely     = "-tól"
esetragAlak AblativusE       Magas    = "-től"
esetragAlak SublativusE      Mely     = "-ra"
esetragAlak SublativusE      Magas    = "-re"
esetragAlak AllativusE       Mely     = "-hoz"
esetragAlak AllativusE       Magas    = "-hez/-höz"
esetragAlak TerminativusE    _        = "-ig"
esetragAlak InstrumentalisE  Mely     = "-val"
esetragAlak InstrumentalisE  Magas    = "-vel"
esetragAlak CausalisFinalisE _        = "-ért"
esetragAlak TranszlativusE   Mely     = "-vá"
esetragAlak TranszlativusE   Magas    = "-vé"
esetragAlak FormativusE      _        = "-képp"
esetragAlak EssivusFormalisE _        = "-ként"

-- ─── 3. ESETRAG OSZTÁLYOZÁS (Kiefer szerint) ────────────────

||| Az esetrag funkciója (Kiefer 4-osztálya).
public export
data EsetFunkcio = SzintaktikusEset | HelyHely | HelyIrany | AllapotHatarozo
                 | EszkozHatarozo | CelHatarozo | EredmenyHatarozo

||| Az esetrag funkciója.
public export
esetragFunkcio : Esetrag -> EsetFunkcio
esetragFunkcio NominativusE     = SzintaktikusEset
esetragFunkcio AccusativusE     = SzintaktikusEset
esetragFunkcio DativusE         = SzintaktikusEset
esetragFunkcio InessivusE       = HelyHely
esetragFunkcio SuperessivusE    = HelyHely
esetragFunkcio AdessivusE       = HelyHely
esetragFunkcio IllativusE       = HelyIrany
esetragFunkcio ElativusE        = HelyIrany
esetragFunkcio SublativusE      = HelyIrany
esetragFunkcio DelativusE       = HelyIrany
esetragFunkcio AllativusE       = HelyIrany
esetragFunkcio AblativusE       = HelyIrany
esetragFunkcio TerminativusE    = HelyIrany
esetragFunkcio InstrumentalisE  = EszkozHatarozo
esetragFunkcio CausalisFinalisE = CelHatarozo
esetragFunkcio TranszlativusE   = EredmenyHatarozo
esetragFunkcio FormativusE      = AllapotHatarozo
esetragFunkcio EssivusFormalisE = AllapotHatarozo

-- ─── 4. RAGFELISMERÉS — szó → (tő, esetrag) ─────────────────

||| String végződés vizsgálata.
public export
endsWith : String -> String -> Bool
endsWith suffix str =
  let slen : Nat = length str
      flen : Nat = length suffix
  in  if flen > slen then False
      else substr (slen `minus` flen) flen str == suffix

||| A leghosszabb rag, ami illeszkedik a szó végére.
||| A lista (rag, eset) párokként, leghosszabb rag elöl.
public export
ragLista : List (String, Esetrag)
ragLista =
  [ ("ként", EssivusFormalisE), ("képp", FormativusE)
  , ("ért", CausalisFinalisE)
  , ("ban", InessivusE), ("ben", InessivusE)
  , ("ból", ElativusE), ("ből", ElativusE)
  , ("hoz", AllativusE), ("hez", AllativusE), ("höz", AllativusE)
  , ("nál", AdessivusE), ("nél", AdessivusE)
  , ("ról", DelativusE), ("ről", DelativusE)
  , ("tól", AblativusE), ("től", AblativusE)
  , ("val", InstrumentalisE), ("vel", InstrumentalisE)
  , ("zal", InstrumentalisE), ("zel", InstrumentalisE)
  , ("szal", InstrumentalisE), ("szel", InstrumentalisE)
  , ("tal", InstrumentalisE), ("tel", InstrumentalisE)
  , ("bal", InstrumentalisE), ("bel", InstrumentalisE)
  , ("pal", InstrumentalisE), ("pel", InstrumentalisE)
  , ("fal", InstrumentalisE), ("fel", InstrumentalisE)
  , ("gal", InstrumentalisE), ("gel", InstrumentalisE)
  , ("kal", InstrumentalisE), ("kel", InstrumentalisE)
  , ("ral", InstrumentalisE), ("rel", InstrumentalisE)
  , ("lal", InstrumentalisE), ("lel", InstrumentalisE)
  , ("mal", InstrumentalisE), ("mel", InstrumentalisE)
  , ("nal", InstrumentalisE), ("nel", InstrumentalisE)
  , ("nal", InstrumentalisE), ("nyal", InstrumentalisE), ("nyel", InstrumentalisE)
  , ("nak", DativusE), ("nek", DativusE)
  , ("ba", IllativusE), ("be", IllativusE)
  , ("ra", SublativusE), ("re", SublativusE)
  , ("on", SuperessivusE), ("en", SuperessivusE), ("ön", SuperessivusE)
  , ("vá", TranszlativusE), ("vé", TranszlativusE)
  , ("ig", TerminativusE)
  , ("ot", AccusativusE), ("et", AccusativusE)
  , ("öt", AccusativusE), ("at", AccusativusE)
  , ("t", AccusativusE)
  ]

||| Egy szó végéről leveszi a ragot és visszaadja az esetet.
||| A felismerés a leghosszabb rag alapján történik (maximális munch).
||| A ragLista leghosszabb rag elől van, így az első találat a jó.
public export
ragFelismer : String -> Maybe (String, Esetrag)
ragFelismer szo =
  if length szo == 0 then Nothing
  else keres szo ragLista
  where
    keres : String -> List (String, Esetrag) -> Maybe (String, Esetrag)
    keres _ [] = Just (szo, NominativusE)
    keres s ((rag, eset) :: xs) =
      if endsWith rag s
        then Just (substr 0 (length s `minus` length rag) s, eset)
        else keres s xs

-- ─── 5. IGERAGOZÁS — igeidő, mód, ragozási típus ─────────────

||| Igeidő (Kiefer szerint: jövő NEM morfológiai kategória).
public export
data Igeido = JelenI | MultI | JovoI

||| Mód (modusz).
public export
data Modusz = KijelentoM | FelteletesM | FelszolitoM

||| Ragozási típus: alanyi vs tárgyas (határozottság szerint).
public export
data RagozasTipus = AlanyiR | TargyasR

||| Az igeragozás teljes kategóriája: idő × mód × típus.
||| 3 × 3 × 2 = 18 (de jövő nem morfológiai, így 2 × 3 × 2 = 12).
public export
record Igeragozas where
  constructor IgeragozasKonstruktor
  igeido    : Igeido
  modusz    : Modusz
  ragozas   : RagozasTipus

-- ─── 6. CPT — igeidő × szemlélet × forrás ───────────────────

||| A CPT szimmetria nyelvtani rétege (AGENTS.md 9. szabály).
||| C = forrás (evidenciálisság), P = szemlélet (aspektus), T = igeidő.
||| A könyv NEM tárgyalja az aspektust, de a projekt szerint:
|||   folyamatos = jelen, befejezett = mult, szokasos = jovo (fog + szokott)

||| Forrás (evidenciálisság): honnan tudom?
public export
data ForrasTipus = KozvetlenF | KovetkeztetettF | JelentettF

||| Szemlélet (aspektus): hogyan látom?
||| A Kiefer könyv nem tárgyalja, de a projekt szerint:
public export
data SzemleletTipus = FolyamatosSz | BefejezettSz | SzokasosSz

||| CPT rekord: a magyar ige ragozásának három dimenziója.
public export
record CptIgeragozas where
  constructor CptIgeragozasKonstruktor
  cptT : Igeido          -- T = idő (mikor?)
  cptP : SzemleletTipus  -- P = szemlélet (hogyan látom?)
  cptC : ForrasTipus     -- C = forrás (honnan tudom?)

||| 3 × 3 × 3 = 27 kombináció (a magyar ige ragozásának három dimenziója).
public export
cptPelda : CptIgeragozas
cptPelda = CptIgeragozasKonstruktor JelenI FolyamatosSz KozvetlenF

-- ─── 7. AGGLUTINÁCIÓ — toldalékok sorrendje ─────────────────

||| A toldalékok sorrendje (Kiefer 2.1.6 szerint):
||| tő → képző → [többesjel ↔ birtokviszonyjel] → birtokos személyrag → birtokjel → esetrag
public export
data ToldalekTipus = TosztT | KepzoT | TobbesszamT | BirtokviszonyjelT
                   | BirtokosSzemelyragT | BirtokjelT | EsetragT

||| A toldaléksor egy eleme.
public export
record Toldalek where
  constructor ToldalekKonstruktor
  toldalekTipus : ToldalekTipus
  toldalekAlak  : String

||| A toldaléksor rendezettsége: tő → ... → esetrag.
||| Ez a kompozíció iránya: minden baloldali morfizmus a jobboldali előtt.
public export
toldalekSorrend : ToldalekTipus -> Nat
toldalekSorrend TosztT                 = 0
toldalekSorrend KepzoT                 = 1
toldalekSorrend TobbesszamT            = 2
toldalekSorrend BirtokviszonyjelT      = 2  -- alternativ a tobbesszam mellett
toldalekSorrend BirtokosSzemelyragT    = 3
toldalekSorrend BirtokjelT             = 4
toldalekSorrend EsetragT               = 5

-- ─── 8. KÉRDŐSZAVAK → ESETRAG ───────────────────────────────

||| Magyar kérdőszó → esetrag (kérdés típusa → eset).
||| Ez a kérdés kódolásának alapja.
public export
kerdoszoEset : String -> Maybe Esetrag
kerdoszoEset "mi"    = Just NominativusE
kerdoszoEset "miért" = Just CausalisFinalisE
kerdoszoEset "micsoda" = Just NominativusE
kerdoszoEset "mit"   = Just AccusativusE
kerdoszoEset "kinek" = Just DativusE
kerdoszoEset "minek" = Just DativusE
kerdoszoEset "hol"   = Just InessivusE
kerdoszoEset "hová"  = Just IllativusE
kerdoszoEset "hova"  = Just IllativusE
kerdoszoEset "honnan" = Just ElativusE
kerdoszoEset "mivel" = Just InstrumentalisE
kerdoszoEset "mivé"  = Just TranszlativusE
kerdoszoEset "mive"  = Just TranszlativusE
kerdoszoEset "miképpen" = Just FormativusE
kerdoszoEset "hogyan" = Just FormativusE
kerdoszoEset "mikent" = Just FormativusE
kerdoszoEset "miként" = Just FormativusE
kerdoszoEset "miert"  = Just CausalisFinalisE
kerdoszoEset "mint"  = Just EssivusFormalisE
kerdoszoEset "meddig" = Just TerminativusE
kerdoszoEset "melyik" = Just NominativusE
kerdoszoEset "ki"    = Just NominativusE
kerdoszoEset "kit"   = Just AccusativusE
kerdoszoEset "kivel" = Just InstrumentalisE
kerdoszoEset "kihez" = Just AllativusE
kerdoszoEset "kinél" = Just AdessivusE
kerdoszoEset "kin"   = Just SuperessivusE
kerdoszoEset _       = Nothing

-- ─── 9. SEGÉDFÜGGVÉNYEK ─────────────────────────────────────

||| String elejének eltávolítása.
public export
dropPrefix : Nat -> String -> String
dropPrefix n s = substr n (length s) s

-- ─── 10. FŐPROGRAM ──────────────────────────────────────────

public export
magyarNyelvtanFom : IO ()
magyarNyelvtanFom = do
  putStrLn "=== MAGYAR NYELVTAN — 18 ESETRAG + IGERAGOZÁS ==="
  putStrLn ""
  putStrLn "A 18 esetrag (Kiefer 2011 szerint):"
  putStrLn "  1. Nominativus (alany) — ø"
  putStrLn "  2. Accusativus (tárgy) — -t/-ot/-et/-öt"
  putStrLn "  3. Dativus (részeshatározó) — -nak/-nek"
  putStrLn "  4. Inessivus (hol? belül) — -ban/-ben"
  putStrLn "  5. Elativus (honnan? belül) — -ból/-ből"
  putStrLn "  6. Illativus (hová? belül) — -ba/-be"
  putStrLn "  7. Superessivus (hol? felület) — -on/-en/-ön"
  putStrLn "  8. Adessivus (hol? mellett) — -nál/-nél"
  putStrLn "  9. Delativus (honnan? felület) — -ról/-ről"
  putStrLn "  10. Ablativus (honnan? mellől) — -tól/-től"
  putStrLn "  11. Sublativus (hová? felületre) — -ra/-re"
  putStrLn "  12. Allativus (hová? mellé) — -hoz/-hez/-höz"
  putStrLn "  13. Terminativus (meddig?) — -ig"
  putStrLn "  14. Instrumentalis (mivel?) — -val/-vel"
  putStrLn "  15. Causalis-finalis (miért?) — -ért"
  putStrLn "  16. Transzlativus-factivus (mivé?) — -vá/-vé"
  putStrLn "  17. Formativus (miképpen?) — -képp"
  putStrLn "  18. Essivus-formalisi (mint?) — -ként"
  putStrLn ""
  putStrLn "Igeragozás:"
  putStrLn "  Igeidők: jelen, múlt (jövő = nem morfológiai)"
  putStrLn "  Módok: kijelentő, feltételes (-n), felszólító"
  putStrLn "  Ragozás: alanyi vs tárgyas (határozottság)"
  putStrLn ""
  putStrLn "CPT (3×3×3 = 27):"
  putStrLn "  T = igeidő (múlt/jelen/jövő)"
  putStrLn "  P = szemlélet (folyamatos/befejezett/szokásos)"
  putStrLn "  C = forrás (közvetlen/következtetett/jelentett)"
  putStrLn ""
  putStrLn "Ragfelismerés példa ('házban'):"
  case ragFelismer "házban" of
    Just (to, eset) => putStrLn ("  tő: " ++ to ++ ", eset: " ++ esetragNev eset)
    Nothing         => putStrLn "  Nem ismert fel."
  putStrLn ""
  putStrLn "Kérdőszó példa ('miért'):"
  case kerdoszoEset "miért" of
    Just eset => putStrLn ("  eset: " ++ esetragNev eset ++ " (" ++ esetragKerdes eset ++ ")")
    Nothing   => putStrLn "  Nem ismert fel."
  putStrLn ""
  putStrLn "Kész."

-- ─── ESETRAG → E8PONT (a nyelvtan resze) ────────────────────

||| Az esetrag E8 kódja (jobb E8 = szín = fázis).
||| 18 eset → 8 Kubit.
public export
esetKod : Esetrag -> E8Pont
esetKod NominativusE     = E8PontKonstruktor Egy Nulla Nulla Egy Nulla Nulla Nulla Nulla
esetKod AccusativusE     = E8PontKonstruktor Egy Nulla Nulla Nulla Egy Nulla Nulla Nulla
esetKod DativusE         = E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Egy Nulla Nulla
esetKod InessivusE       = E8PontKonstruktor Nulla Egy Egy Nulla Nulla Nulla Nulla Nulla
esetKod ElativusE        = E8PontKonstruktor Nulla Egy Nulla Egy Nulla Nulla Nulla Nulla
esetKod IllativusE       = E8PontKonstruktor Nulla Egy Nulla Nulla Egy Nulla Nulla Nulla
esetKod SuperessivusE    = E8PontKonstruktor Nulla Egy Egy Nulla Nulla Nulla Nulla Nulla
esetKod AdessivusE       = E8PontKonstruktor Nulla Egy Nulla Nulla Nulla Egy Nulla Nulla
esetKod DelativusE       = E8PontKonstruktor Nulla Nulla Egy Egy Nulla Nulla Nulla Nulla
esetKod AblativusE       = E8PontKonstruktor Nulla Nulla Egy Nulla Egy Nulla Nulla Nulla
esetKod SublativusE      = E8PontKonstruktor Nulla Nulla Nulla Egy Egy Nulla Nulla Nulla
esetKod AllativusE       = E8PontKonstruktor Nulla Nulla Nulla Egy Nulla Egy Nulla Nulla
esetKod TerminativusE    = E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Egy Nulla
esetKod InstrumentalisE  = E8PontKonstruktor Nulla Nulla Nulla Nulla Egy Nulla Egy Nulla
esetKod CausalisFinalisE = E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Egy Egy Nulla
esetKod TranszlativusE   = E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla Egy
esetKod FormativusE      = E8PontKonstruktor Nulla Nulla Nulla Nulla Egy Egy Nulla Nulla
esetKod EssivusFormalisE = E8PontKonstruktor Nulla Nulla Nulla Nulla Egy Nulla Nulla Egy