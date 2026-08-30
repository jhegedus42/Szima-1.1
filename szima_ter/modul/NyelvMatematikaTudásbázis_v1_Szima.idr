module NyelvMatematikaTudásbázis_v1_Szima

-- ═══════════════════════════════════════════════════════════════
-- NYELV-MATEMATIKA TUDÁSBÁZIS v1 Szima — a kategóriaelméleti fogalmak
-- és a magyar nyelv fogalmainak párosítása (LangMathKB port).
--   A Scala forrás: agi_jul25_scala/src/main/scala/infra/langmath/
--   LangMathKB.scala (122 sor, 2025-07).
-- LANGUAGE-MATHEMATICS KNOWLEDGE BASE v1 — pairing category-theoretic
--   concepts with Hungarian linguistic concepts.
-- 语言-数学知识库 v1——范畴论概念与匈牙利语概念的配对。
-- SPRACHE-MATHEMATIK-WISSENSBASIS v1 — Paarung kategorientheoretischer
--   Begriffe mit ungarischen Sprachbegriffen.
-- בסיס ידע שפה-מתמטיקה v1——צימוד מושגי תורת הקטגוריות עם מושגי השפה ההונגרית.
-- ═══════════════════════════════════════════════════════════════
--
-- A TUDÁSBÁZIS RÉTEGEI (a Scala Szint enum szerint):
--   1. Prím — az alapfogalmak (objektum, morfizmus, kategória + a magyar
--      nyelv alapjai: főnév, ige, toldalék).
--   2. Származtatott — a prím-fogalmakból képezettek (nincs külön
--      konstruktor; a prím szint tartalmazza ezeket is).
--   3. Funktor — a funktoriális szint (funktor, monád, komonád +
--      a magyar morfológia funktoriális fogalmai: hangrend,
--      határozottság, szám, igeidő, birtoklás).
--   4. Adjunkció — az adjunkciós szint (adjunkció, limesz, kolimesz,
--      szorzat, koszorzat, Kleisli/Eilenberg-Moore).
--   5. Meta — a meta-szint (Yoneda, exponenciális, monoidális +
--      a mondat/discourse szint: tagmondat, mondat, diskurzus, tagadás,
--      mellérendelés, levezetés, kérdés, válasz + a formális logika:
--      SAT, CNF, DPLL, CDCL, rezolúció, modellszámlálás, MaxSAT).
--
-- §24 (KÓD DUPLIKÁCIÓ TILOS): ez a modul NEM definiálja újra a
--   kategória-rekordot (az a CategoryTheory_v1_Szima-ben él), NEM
--   definiálja újra a szófaj-típust (az a MagyarNyelvtan_v4-ben él).
--   Ez a modul egy LEXIKON: a kategóriaelméleti fogalmak NEVEIT és
--   a nyelvészeti fogalmak NEVEIT sorolja fel, és PÁROSÍTJA őket.
--   A típusok (Category, Functor, Monad) a CategoryTheory_v1_Szima-
--   ben vannak; itt csak a NEVEK és a PÁROK élnek.
--   | 代码重复禁止——此模块是词典，不重定义范畴论类型！ |
--   | Codeduplikation VERBOTEN — dies ist ein Lexikon! |
-- §13: EZ EGY ÚJ MODUL — minden korábbi modul érintetlenül marad.
-- §25: minden magyar azonosító ÉKEZETES (Szótár, Főnév, Ige, Tagadás).
-- §0: nincs rövidítés (Toldalék, nem ToldP; Főnév, nem Noun).
-- §N8: Python tilos — csak Idris.
-- ═══════════════════════════════════════════════════════════════

import Data.List  -- length, filter, map, elem (§24: standard, nem újraírva)

%default covering

-- ===============================================================
-- 1. A SZINT — a tudásbázis öt rétege
--    The level — five layers of the knowledge base
--    层级——知识库的五层 · Die Ebene — fünf Schichten · הרמה — חמש שכבות
-- ===============================================================

||| A tudásbázis öt rétege: a kategóriaelmélet és a nyelv hierarchiája.
||| A Scala `Szint` enum megfelelője (Prim, Derived, Functor,
||| Adjunction, Meta) — ékezetes magyar nevekkel (§25).
||| 知识库的五层：范畴论与语言的层级。
public export
data Szint : Type where
  Prím         : Szint   -- az alapfogalmak rétege (Prim)
  Származtatott : Szint  -- a prímből képezettek rétege (Derived)
  Funktor      : Szint   -- a funktoriális réteg (Functor)
  Adjunkció    : Szint   -- az adjunkciós réteg (Adjunction)
  Meta         : Szint   -- a meta-réteg (Yoneda, monoidális, logika)

||| A szintek egyenlősége (a szűrésekhez kell).
public export
Eq Szint where
  (==) Prím          Prím          = True
  (==) Származtatott  Származtatott  = True
  (==) Funktor        Funktor        = True
  (==) Adjunkció      Adjunkció      = True
  (==) Meta           Meta           = True
  (==) _ _ = False

||| A szintek megjelenítése — a Scala label szerint.
public export
Show Szint where
  show Prím         = "Prím"
  show Származtatott = "Származtatott"
  show Funktor       = "Funktor"
  show Adjunkció     = "Adjunkció"
  show Meta          = "Meta"

-- ===============================================================
-- 2. A SZÓ — a kategóriaelméleti és nyelvészeti fogalmak nevei
--    The word — names of category-theoretic and linguistic concepts
--    词——范畴论与语言学概念的名称
--    Das Wort — Namen kategorientheoretischer und sprachlicher Begriffe
--    המילה——שמות מושגי תורת הקטגוריות והבלשנות
-- ===============================================================

||| A SZÓ: egy kategóriaelméleti vagy nyelvészeti fogalom neve.
||| A Scala `Szo` enum megfelelője — 44 konstruktor, ékezetes magyar
||| nevekkel (§25: Szótár, Főnév, Ige, Tagadás; §0: nincs rövidítés).
||| Minden konstruktor egy fogalmat nevez meg; a szintjüket a
||| `szint` függvény rendeli hozzá (a Scala `extends Szo(Szint.X)`
||| helyett — Idrisben a konstruktornak nincs paramétere, a szint
||| egy külön függvény).
||| 词：范畴论或语言学概念的名称。44 个构造器，带变音符号的匈牙利语。
public export
data Szo : Type where
  -- ─── Prím szint: az alapfogalmak (7) ──────────────────────────
  Objektum   : Szo   -- objektum (a kategória eleme)
  Morfizmus  : Szo   -- morfizmus (a kategória nyila)
  Kategória  : Szo   -- kategória (objektumok + morfizmusok)
  Boolé      : Szo   -- Boolé (igaz/hamis — a logika alapja)
  Főnév     : Szo   -- főnév (a nyelv objektuma)
  Ige       : Szo   -- ige (a nyelv morfizmusa)
  Toldalék  : Szo   -- toldalék (a nyelv funkora)

  -- ─── Funktor szint: a funktoriális fogalmak (10) ──────────────
  FunktorSzo              : Szo  -- funktor
  TermészetesTranszformáció : Szo  -- természetes transzformáció
  Monád                   : Szo  -- monád
  Komonád                 : Szo  -- komonád
  ReprezentálhatóFunktor  : Szo  -- reprezentálható funktor
  MagánhangzóHarmónia     : Szo  -- magánhangzó-harmónia (vowel harmony)
  Határozottság          : Szo  -- határozottság (definiteness)
  NyelvtaniSzám          : Szo  -- nyelvtani szám (singulár/plurál)
  Igeidő                  : Szo  -- igeidő (tense)
  Birtoklás              : Szo  -- birtoklás (possession)

  -- ─── Adjunkció szint: az adjunkciós fogalmak (7) ───────────────
  AdjunkcióSzo    : Szo  -- adjunkció
  Limesz          : Szo  -- limesz (limit)
  Kolimesz        : Szo  -- kolimesz (colimit)
  Szorzat         : Szo  -- szorzat (product)
  Koszorzat       : Szo  -- koszorzat (coproduct)
  KleisliKategória : Szo  -- Kleisli-kategória
  EilenbergMoore  : Szo  -- Eilenberg-Moore-kategória

  -- ─── Meta szint: a meta-fogalmak (13) ────────────────────────
  RészobjektumOsztályozó : Szo  -- részobjektum-osztályozó
  YonedaLemma            : Szo  -- Yoneda-lemma
  YonedaBeágyazás        : Szo  -- Yoneda-beágyazás
  MonoidálisKategória    : Szo  -- monoidális kategória
  Exponenciális          : Szo  -- exponenciális
  Tagmondat              : Szo  -- tagmondat (clause)
  Mondat                 : Szo  -- mondat (sentence)
  Diskurzus              : Szo  -- diskurzus (discourse)
  Tagadás               : Szo  -- tagadás (negation)
  Mellérendelés         : Szo  -- mellérendelés (coordination)
  Levezetés             : Szo  -- levezetés (derivation)
  Kérdés                : Szo  -- kérdés (question)
  Válasz                : Szo  -- válasz (answer)

  -- ─── Meta szint: a formális logika fogalmai (7) ──────────────
  Teljesíthetőség    : Szo  -- SAT (Boolean satisfiability)
  KonjunktívNormálForma : Szo  -- CNF (conjunctive normal form)
  DPLLAlgoritmus     : Szo  -- DPLL-algoritmus
  CDCLAlgoritmus     : Szo  -- CDCL-algoritmus
  Rezolúció         : Szo  -- rezolúció (resolution)
  ModellSzámlálás    : Szo  -- modellszámlálás (model counting)
  MaxTeljesíthetőség : Szo  -- MaxSAT (maximum satisfiability)

||| A szó szintje — a Scala `Szo(val szint: Szint)` megfelelője.
||| Idrisben a konstruktornak nincs paramétere; a szintet ez a
||| függvény rendeli hozzá (kimerítő, covering — minden konstruktorra).
||| 词的层级——每个构造器对应一个层级。
public export
szint : Szo -> Szint
-- Prím szint
szint Objektum   = Prím
szint Morfizmus  = Prím
szint Kategória  = Prím
szint Boolé      = Prím
szint Főnév      = Prím
szint Ige        = Prím
szint Toldalék   = Prím
-- Funktor szint
szint FunktorSzo              = Funktor
szint TermészetesTranszformáció = Funktor
szint Monád                   = Funktor
szint Komonád                 = Funktor
szint ReprezentálhatóFunktor  = Funktor
szint MagánhangzóHarmónia     = Funktor
szint Határozottság          = Funktor
szint NyelvtaniSzám          = Funktor
szint Igeidő                  = Funktor
szint Birtoklás              = Funktor
-- Adjunkció szint
szint AdjunkcióSzo    = Adjunkció
szint Limesz          = Adjunkció
szint Kolimesz        = Adjunkció
szint Szorzat         = Adjunkció
szint Koszorzat       = Adjunkció
szint KleisliKategória = Adjunkció
szint EilenbergMoore  = Adjunkció
-- Meta szint — meta-fogalmak
szint RészobjektumOsztályozó = Meta
szint YonedaLemma            = Meta
szint YonedaBeágyazás        = Meta
szint MonoidálisKategória    = Meta
szint Exponenciális          = Meta
szint Tagmondat              = Meta
szint Mondat                 = Meta
szint Diskurzus              = Meta
szint Tagadás               = Meta
szint Mellérendelés         = Meta
szint Levezetés             = Meta
szint Kérdés                = Meta
szint Válasz                = Meta
-- Meta szint — formális logika
szint Teljesíthetőség    = Meta
szint KonjunktívNormálForma = Meta
szint DPLLAlgoritmus     = Meta
szint CDCLAlgoritmus     = Meta
szint Rezolúció         = Meta
szint ModellSzámlálás    = Meta
szint MaxTeljesíthetőség = Meta

||| A szó megjelenítése — a Scala `label` (toString) megfelelője.
||| A konstruktor neve magyarul, ékezetesen (§25).
public export
Show Szo where
  show Objektum   = "Objektum"
  show Morfizmus  = "Morfizmus"
  show Kategória  = "Kategória"
  show Boolé      = "Boolé"
  show Főnév      = "Főnév"
  show Ige        = "Ige"
  show Toldalék   = "Toldalék"
  show FunktorSzo              = "Funktor"
  show TermészetesTranszformáció = "TermészetesTranszformáció"
  show Monád                   = "Monád"
  show Komonád                 = "Komonád"
  show ReprezentálhatóFunktor  = "ReprezentálhatóFunktor"
  show MagánhangzóHarmónia     = "MagánhangzóHarmónia"
  show Határozottság          = "Határozottság"
  show NyelvtaniSzám          = "NyelvtaniSzám"
  show Igeidő                  = "Igeidő"
  show Birtoklás              = "Birtoklás"
  show AdjunkcióSzo    = "Adjunkció"
  show Limesz          = "Limesz"
  show Kolimesz        = "Kolimesz"
  show Szorzat         = "Szorzat"
  show Koszorzat       = "Koszorzat"
  show KleisliKategória = "KleisliKategória"
  show EilenbergMoore  = "EilenbergMoore"
  show RészobjektumOsztályozó = "RészobjektumOsztályozó"
  show YonedaLemma            = "YonedaLemma"
  show YonedaBeágyazás        = "YonedaBeágyazás"
  show MonoidálisKategória    = "MonoidálisKategória"
  show Exponenciális          = "Exponenciális"
  show Tagmondat              = "Tagmondat"
  show Mondat                 = "Mondat"
  show Diskurzus              = "Diskurzus"
  show Tagadás               = "Tagadás"
  show Mellérendelés         = "Mellérendelés"
  show Levezetés             = "Levezetés"
  show Kérdés                = "Kérdés"
  show Válasz                = "Válasz"
  show Teljesíthetőség    = "Teljesíthetőség"
  show KonjunktívNormálForma = "KonjunktívNormálForma"
  show DPLLAlgoritmus     = "DPLLAlgoritmus"
  show CDCLAlgoritmus     = "CDCLAlgoritmus"
  show Rezolúció         = "Rezolúció"
  show ModellSzámlálás    = "ModellSzámlálás"
  show MaxTeljesíthetőség = "MaxTeljesíthetőség"

||| A szavak egyenlősége (a szűrésekhez és a villához kell).
public export
Eq Szo where
  (==) Objektum   Objektum   = True
  (==) Morfizmus  Morfizmus  = True
  (==) Kategória  Kategória  = True
  (==) Boolé      Boolé      = True
  (==) Főnév      Főnév      = True
  (==) Ige        Ige        = True
  (==) Toldalék   Toldalék   = True
  (==) FunktorSzo              FunktorSzo              = True
  (==) TermészetesTranszformáció TermészetesTranszformáció = True
  (==) Monád                   Monád                   = True
  (==) Komonád                 Komonád                 = True
  (==) ReprezentálhatóFunktor  ReprezentálhatóFunktor  = True
  (==) MagánhangzóHarmónia     MagánhangzóHarmónia     = True
  (==) Határozottság          Határozottság          = True
  (==) NyelvtaniSzám          NyelvtaniSzám          = True
  (==) Igeidő                  Igeidő                  = True
  (==) Birtoklás              Birtoklás              = True
  (==) AdjunkcióSzo    AdjunkcióSzo    = True
  (==) Limesz          Limesz          = True
  (==) Kolimesz        Kolimesz        = True
  (==) Szorzat         Szorzat         = True
  (==) Koszorzat       Koszorzat       = True
  (==) KleisliKategória KleisliKategória = True
  (==) EilenbergMoore  EilenbergMoore  = True
  (==) RészobjektumOsztályozó RészobjektumOsztályozó = True
  (==) YonedaLemma            YonedaLemma            = True
  (==) YonedaBeágyazás        YonedaBeágyazás        = True
  (==) MonoidálisKategória    MonoidálisKategória    = True
  (==) Exponenciális          Exponenciális          = True
  (==) Tagmondat              Tagmondat              = True
  (==) Mondat                 Mondat                 = True
  (==) Diskurzus              Diskurzus              = True
  (==) Tagadás               Tagadás               = True
  (==) Mellérendelés         Mellérendelés         = True
  (==) Levezetés             Levezetés             = True
  (==) Kérdés                Kérdés                = True
  (==) Válasz                Válasz                = True
  (==) Teljesíthetőség    Teljesíthetőség    = True
  (==) KonjunktívNormálForma KonjunktívNormálForma = True
  (==) DPLLAlgoritmus     DPLLAlgoritmus     = True
  (==) CDCLAlgoritmus     CDCLAlgoritmus     = True
  (==) Rezolúció         Rezolúció         = True
  (==) ModellSzámlálás    ModellSzámlálás    = True
  (==) MaxTeljesíthetőség MaxTeljesíthetőség = True
  (==) _ _ = False

-- ===============================================================
-- 3. A DEFINÍCIÓ — egy kategóriaelméleti fogalom és egy nyelvi
--    fogalom párosa (a Scala `Def` case class megfelelője).
--    The definition — a pairing of a category concept and a language
--    concept. 定义——范畴论概念与语言概念的配对。
--    Die Definition — Paarung eines Kategorientheorie-Begriffs mit
--    einem Sprachbegriff. ההגדרה——צימוד מושג קטגורי עם מושג לשוני.
-- ===============================================================

||| A DEFINÍCIÓ: egy kategóriaelméleti fogalom (a) és egy nyelvi
||| fogalom (b) párosa, címke és példa szöveggel. A Scala `Def`
||| case class megfelelője — ékezetes mezőnevekkel (§25).
||| 定义：一个范畴论概念与一个语言概念的配对，含标签与示例。
public export
record Definitio where
  constructor DefinitioKonstruktor
  aOldal    : Szo     -- a kategóriaelméleti fogalom (a)
  bOldal    : Szo     -- a nyelvi fogalom (b)
  cimke    : String   -- a páros címkéje (pl. "Obj ↔ főnév")
  pelda    : String   -- a páros példája (pl. "ház, kert, ember")

||| A definíció megjelenítése — a címke és a példa együtt.
public export
Show Definitio where
  show (DefinitioKonstruktor a b cimkeMező peldaMező) =
    cimkeMező ++ "  példa: " ++ peldaMező

-- ===============================================================
-- 4. A 17 DEFINÍCIÓ — a kategóriaelmélet és a magyar nyelv hídja
--    The 17 definitions — the bridge between category theory and
--    the Hungarian language.
--    17 个定义——范畴论与匈牙利语的桥梁。
--    Die 17 Definitionen — die Brücke zwischen Kategorientheorie und
--    der ungarischen Sprache.
--    17 ההגדרות——הגשר בין תורת הקטגוריות והשפה ההונגרית.
-- ===============================================================

||| A 17 DEFINÍCIÓ: a kategóriaelmélet és a magyar nyelv párosai.
||| A Scala `Def.all` megfelelője — lista-konstans (kályha-minta,
||| NEM let-lánc; l. LetLáncProbe tanulság). Minden páros egy
||| kategóriaelméleti fogalmat (a) és egy nyelvi fogalmat (b) köt
||| össze, címke és példa szöveggel.
||| 17 个定义：范畴论与匈牙利语的配对（列表常量，非 let 链）。
public export
definíciók : List Definitio
definíciók =
  [ DefinitioKonstruktor Objektum   Főnév     "Objektum ↔ főnév"                "ház, kert, ember"
  , DefinitioKonstruktor Morfizmus  Ige       "Morfizmus ↔ ige"                 "megy, lát, ad"
  , DefinitioKonstruktor FunktorSzo Toldalék  "Funktor ↔ toldalék"              "-ban/-ben"
  , DefinitioKonstruktor TermészetesTranszformáció MagánhangzóHarmónia "η ↔ harmónia" "házban vs földben"
  , DefinitioKonstruktor AdjunkcióSzo Tagmondat "⊣ ↔ esetpár"                    "-nak/-nek ⊣ -tól/-től"
  , DefinitioKonstruktor Monád      Igeidő    "T ↔ idő"                         "-t past"
  , DefinitioKonstruktor Komonád    Határozottság "W ↔ mód"                    "-j subj, -na/-ne cond"
  , DefinitioKonstruktor KleisliKategória Tagmondat "C_T ↔ mellékm."           "hogy..."
  , DefinitioKonstruktor Szorzat    Mellérendelés "× ↔ mellérend."             "A és B"
  , DefinitioKonstruktor Koszorzat  Diskurzus "+ ↔ diszjunkció"                "A vagy B"
  , DefinitioKonstruktor RészobjektumOsztályozó Tagadás "Ω ↔ tagadás"           "nem, nincs"
  , DefinitioKonstruktor ReprezentálhatóFunktor Határozottság "Hom(A,-) ↔ határozottság" "a(z)"
  , DefinitioKonstruktor YonedaLemma Diskurzus "y ↔ diskurzus"                 "ház = building/home/firm"
  , DefinitioKonstruktor Exponenciális Tagmondat "B^A ↔ ha-akkor"              "ha... akkor..."
  , DefinitioKonstruktor Limesz     Diskurzus "lim ↔ univerzális"              "minden, aki, ami"
  , DefinitioKonstruktor Teljesíthetőség Mondat "SAT ↔ grammatika"             "feature constraints satisfiable"
  , DefinitioKonstruktor DPLLAlgoritmus Levezetés "DPLL ↔ elemzés"             "kimerítő elemzés"
  ]

-- ===============================================================
-- 5. A MIÉRT-LÁNC — a definíciók ok-okozati lánca
--    The why-chain — the causal chain of definitions
--    为何链——定义的因果链 · Die Warum-Kette · שרשרת הסיבה
-- ===============================================================

||| A MIÉRT-LÁNC: a definíciók ok-okozati lánca. A Scala `MiertLanc`
||| enum megfelelője — három konstruktor (Vege, Kozvetlen, Osszetett).
||| A lánc egy definícióval kezdődik, és további definíciókra mutathat.
||| 为何链：定义的因果链（三种构造器）。
public export
data MiertLanc : Type where
  ||| A lánc vége: egy (a, b) definícióval zárul.
  LáncVége : (a : Szo) -> (b : Szo) -> (d : Definitio) -> MiertLanc
  ||| Közvetlen lánc: egy (a) szó, egy definíció, és egy következő lánc.
  LáncKözvetlen : (a : Szo) -> (d : Definitio) -> (k : MiertLanc) -> MiertLanc
  ||| Összetett lánc: egy (a) szó, egy definíció-lista, és egy szó-lista.
  LáncÖsszetett : (a : Szo) -> (defek : List Definitio) -> (szavak : List Szo) -> MiertLanc

||| A miért-lánc megjelenítése — a Scala nem adott show-t, de a
||| futásidejű ellenőrzéshez ide kell.
public export
Show MiertLanc where
  show (LáncVége a b d) =
    "LáncVége(" ++ show a ++ ", " ++ show b ++ ", " ++ show d ++ ")"
  show (LáncKözvetlen a d k) =
    "LáncKözvetlen(" ++ show a ++ ", " ++ show d ++ ", " ++ show k ++ ")"
  show (LáncÖsszetett a defek szavak) =
    "LáncÖsszetett(" ++ show a ++ ", " ++ show (length defek)
      ++ " def, " ++ show (length szavak) ++ " szó)"

-- ===============================================================
-- 6. A VILLA — két fogalom-halmaz közös és külön részei
--    The fork — common and distinct parts of two concept sets
--    分叉——两个概念集的公共与独有部分 · Die Gabel · המזלג
-- ===============================================================

||| A VILLA: két szó-lista közös, bal-oldali külön, és jobb-oldali
||| külön részei. A Scala `VillaLang` case class megfelelője —
||| a `villa` függvény számolja ki a két listából.
||| 分叉：两个词列表的公共、左独有、右独有部分。
public export
record Villa where
  constructor VillaKonstruktor
  közös  : List Szo   -- a két listában közös szavak
  balÁg  : List Szo   -- csak a bal listában lévő szavak
  jobbÁg : List Szo   -- csak a jobb listában lévő szavak

||| A villa megjelenítése — a három ág mérete.
public export
Show Villa where
  show (VillaKonstruktor közösMező balMező jobbMező) =
    "Villa(közös: " ++ show (length közösMező)
      ++ ", bal: " ++ show (length balMező)
      ++ ", jobb: " ++ show (length jobbMező) ++ ")"

||| A VILLA KÉSZÍTÉSE: két szó-listából a közös, bal-oldali külön,
||| és jobb-oldali külön részek. A Scala `VillaLang.apply` megfelelője
||| — a `elem` (Data.List / Prelude, §24: nem újraírva) alapján.
||| 分叉构造：从两个词列表计算公共与独有部分。
public export
villa : List Szo -> List Szo -> Villa
villa balLista jobbLista =
  VillaKonstruktor
    (filter (\sz => elem sz jobbLista) balLista)        -- közös
    (filter (\sz => not (elem sz jobbLista)) balLista)   -- bal külön
    (filter (\sz => not (elem sz balLista)) jobbLista)   -- jobb külön

-- ===============================================================
-- 7. A TUDÁSBÁZIS — a szótár, a definíciók és a miért-láncok
--    The knowledge base — dictionary, definitions, why-chains
--    知识库——词典、定义、为何链
--    Die Wissensbasis — Wörterbuch, Definitionen, Warum-Ketten
--    בסיס הידע——מילון, הגדרות, שרשרת הסיבה
-- ===============================================================

||| A TUDÁSBÁZIS: a szótár (összes szó), a definíciók (17 pár), és a
||| miért-láncok. A Scala `LangMathKB` case class megfelelője —
||| ékezetes mezőnevekkel (§25).
||| 知识库：词典、定义、为何链。
public export
record NyelvMatematikaTudásbázis where
  constructor NyelvMatematikaTudásbázisKonstruktor
  szótár      : List Szo        -- az összes szó (Scala: szotar)
  definíciókMező : List Definitio  -- a 17 definíció (Scala: definiciok)
  miértLáncok : List MiertLanc   -- a miért-láncok (Scala: mertLanc)

||| A szavak szűrése szint szerint — a Scala `ctForSzint` megfelelője.
||| A `filter` és a `szint` a Prelude-ből / ebből a modulból (§24).
||| 按层级筛选词。
public export
szavakSzintSzerint : NyelvMatematikaTudásbázis -> Szint -> List Szo
szavakSzintSzerint tudásbázis keresettSzint =
  filter (\sz => szint sz == keresettSzint) (szótár tudásbázis)

||| A definíciók szűrése címke szerint — a Scala `ctForLang` megfelelője.
||| A címke EGYENLŐ a b-oldal nevével, VAGY tartalmazza a keresett
||| címkét (a Scala `d.b.label.equals(label) || d.label.contains(label)`
||| logikája — Idrisben a String-isInfixOf a Prelude-ből).
||| 按标签筛选定义。
public export
definíciókCímkeSzerint : NyelvMatematikaTudásbázis -> String -> List Definitio
definíciókCímkeSzerint tudásbázis keresettCímke =
  filter (\def =>
    show (bOldal def) == keresettCímke
      || isInfixOf (unpack keresettCímke) (unpack (cimke def)))
    (definíciókMező tudásbázis)

-- ===============================================================
-- 8. A SZÓTÁR — az összes szó (a Scala `Szo.values.toList` helyett
--    Idrisben manuális lista, mert az Idrisnek nincs enum.values-je).
--    The dictionary — all words (manual list, no enum.values in Idris).
--    词典——所有词（手动列表，Idris 无 enum.values）。
-- ===============================================================

||| A SZÓTÁR: az összes szó (44). A Scala `Szo.values.toList`
||| megfelelője — Idrisben manuális lista, mert nincs enum.values.
||| A lista-konstans a kályha-minta szerint (NEM let-lánc).
||| 词典：所有 44 个词（列表常量）。
public export
szótárMinden : List Szo
szótárMinden =
  -- Prím szint (7)
  [ Objektum, Morfizmus, Kategória, Boolé, Főnév, Ige, Toldalék
  -- Funktor szint (10)
  , FunktorSzo, TermészetesTranszformáció, Monád, Komonád
  , ReprezentálhatóFunktor, MagánhangzóHarmónia, Határozottság
  , NyelvtaniSzám, Igeidő, Birtoklás
  -- Adjunkció szint (7)
  , AdjunkcióSzo, Limesz, Kolimesz, Szorzat, Koszorzat
  , KleisliKategória, EilenbergMoore
  -- Meta szint — meta-fogalmak (13)
  , RészobjektumOsztályozó, YonedaLemma, YonedaBeágyazás
  , MonoidálisKategória, Exponenciális, Tagmondat, Mondat
  , Diskurzus, Tagadás, Mellérendelés, Levezetés, Kérdés, Válasz
  -- Meta szint — formális logika (7)
  , Teljesíthetőség, KonjunktívNormálForma, DPLLAlgoritmus
  , CDCLAlgoritmus, Rezolúció, ModellSzámlálás, MaxTeljesíthetőség
  ]

-- ===============================================================
-- 9. A GYÖKÉR TUDÁSBÁZIS — a Scala `LangMathKB.root` megfelelője
--    The root knowledge base — the Scala `LangMathKB.root`
--    根知识库——Scala `LangMathKB.root` 的对应物。
-- ===============================================================

||| A három kezdő miért-lánc: az első három definíció (Objektum↔Főnév,
||| Morfizmus↔Ige, Funktor↔Toldalék) mindegyike egy LáncVége. A Scala
||| `LangMathKB.root.mertLanc` megfelelője.
||| 三个起始为何链。
public export
miértLáncokGyökér : List MiertLanc
miértLáncokGyökér =
  [ LáncVége Objektum Főnév (DefinitioKonstruktor Objektum Főnév "Objektum ↔ főnév" "ház, kert, ember")
  , LáncVége Morfizmus Ige (DefinitioKonstruktor Morfizmus Ige "Morfizmus ↔ ige" "megy, lát, ad")
  , LáncVége FunktorSzo Toldalék (DefinitioKonstruktor FunktorSzo Toldalék "Funktor ↔ toldalék" "-ban/-ben")
  ]

||| A GYÖKÉR TUDÁSBÁZIS: a teljes szótár, a 17 definíció, és a három
||| kezdő miért-lánc. A Scala `LangMathKB.root` megfelelője.
||| 根知识库：完整词典、17 定义、三个起始为何链。
public export
gyökérTudásbázis : NyelvMatematikaTudásbázis
gyökérTudásbázis =
  NyelvMatematikaTudásbázisKonstruktor
    szótárMinden
    definíciók
    miértLáncokGyökér

-- ===============================================================
-- 10. BIZONYÍTÁSOK — KÉT FÜGGETLEN ÚT, EGY HÍD (§18)
--     Proofs — two independent paths, one bridge
--     证明——两条独立道路，一座桥
--     Beweise — zwei Wege, eine Brücke · הוכחות — שני נתיבים, גשר אחד
-- ===============================================================

-- ─── 10a. A szótár mérete: enumeráció ⟷ konstruktor-számlálás ────
--    Az (a) út: a kernel a szótárMinden listát számolja. A (b) út:
--    a 44 = 7 + 10 + 7 + 13 + 7 konstruktor-számlálás. A HÍD: a két
--    szám kényszerített találkozása. Nincs X = X (§18).

-- Nagybetűs konstans a bizonyítás-típushoz (KisBetűsProjekcióCsapda).
public export
SzótárMindenKonst : List Szo
SzótárMindenKonst = szótárMinden

-- Kimenet: Refl — a szótár mérete: 44 szó.
-- (a) enumeráció: SzótárMindenKonst hossza; (b) konstruktor-számlálás: 44.
public export
bizSzótárMérete : length SzótárMindenKonst = 44
bizSzótárMérete = Refl

-- ─── 10b. A 17 definíció száma: enumeráció ⟷ a Scala lista hossza ──
--    Az (a) út: a kernel a definíciók listát számolja. A (b) út:
--    a Scala `Def.all` 17 elemből áll — ez a forrás-igazság. A HÍD:
--    a két szám kényszerített találkozása.

-- Nagybetűs konstans a bizonyítás-típushoz (KisBetűsProjekcióCsapda).
public export
DefiníciókKonst : List Definitio
DefiníciókKonst = definíciók

-- Kimenet: Refl — a definíciók száma: 17.
-- (a) enumeráció: DefiníciókKonst hossza; (b) a Scala forrás: 17.
public export
bizDefiníciókSzáma : length DefiníciókKonst = 17
bizDefiníciókSzáma = Refl

-- ─── 10c. A Prím szint szavainak száma: 7 ──────────────────────
--    A kernel a szótárt szűri a Prím szintre, aztán megszámolja.
public export
prímSzavak : List Szo
prímSzavak = filter (\sz => szint sz == Prím) SzótárMindenKonst

public export
PrímSzavakKonst : List Szo
PrímSzavakKonst = prímSzavak

-- Kimenet: Refl — a Prím szint szavainak száma: 7.
public export
bizPrímSzavakSzáma : length PrímSzavakKonst = 7
bizPrímSzavakSzáma = Refl

-- ─── 10d. A Funktor szint szavainak száma: 10 ──────────────────
public export
funktorSzavak : List Szo
funktorSzavak = filter (\sz => szint sz == Funktor) SzótárMindenKonst

public export
FunktorSzavakKonst : List Szo
FunktorSzavakKonst = funktorSzavak

-- Kimenet: Refl — a Funktor szint szavainak száma: 10.
public export
bizFunktorSzavakSzáma : length FunktorSzavakKonst = 10
bizFunktorSzavakSzáma = Refl

-- ─── 10e. Az Adjunkció szint szavainak száma: 7 ────────────────
public export
adjunkcióSzavak : List Szo
adjunkcióSzavak = filter (\sz => szint sz == Adjunkció) SzótárMindenKonst

public export
AdjunkcióSzavakKonst : List Szo
AdjunkcióSzavakKonst = adjunkcióSzavak

-- Kimenet: Refl — az Adjunkció szint szavainak száma: 7.
public export
bizAdjunkcióSzavakSzáma : length AdjunkcióSzavakKonst = 7
bizAdjunkcióSzavakSzáma = Refl

-- ─── 10f. A Meta szint szavainak száma: 20 (13 + 7) ────────────
public export
metaSzavak : List Szo
metaSzavak = filter (\sz => szint sz == Meta) SzótárMindenKonst

public export
MetaSzavakKonst : List Szo
MetaSzavakKonst = metaSzavak

-- Kimenet: Refl — a Meta szint szavainak száma: 20.
public export
bizMetaSzavakSzáma : length MetaSzavakKonst = 20
bizMetaSzavakSzáma = Refl

-- ─── 10g. A HÍD (§18): a négy szint összege = a szótár mérete ────
--    A bal oldal a NÉGY szint kombinatorikája (7 + 10 + 7 + 20);
--    a jobb oldal a szótár ENUMERÁCIÓJA (44). A kényszerített
--    találkozás — ha bármelyik szint listáját megváltoztatják, a híd
--    automatikusan törik. Nincs X = X.
public export
bizNégySzintHíd : 7 + 10 + 7 + 20 = length SzótárMindenKonst
bizNégySzintHíd = Refl

-- ─── 10h. A miért-láncok száma: 3 ──────────────────────────────
public export
MiértLáncokGyökérKonst : List MiertLanc
MiértLáncokGyökérKonst = miértLáncokGyökér

-- Kimenet: Refl — a gyökér miért-láncok száma: 3.
public export
bizMiértLáncokSzáma : length MiértLáncokGyökérKonst = 3
bizMiértLáncokSzáma = Refl

-- ===============================================================
-- 11. FUTÁSIDEJŰ ELLENŐRZÉSEK ÉS A MAIN (GAUGE-elv)
--     Runtime checks and main · 运行时检查与主函数
--     Laufzeitprüfungen und Hauptprogramm · בדיקות זמן־ריצה ותוכנית ראשית
-- ===============================================================

||| A gyökér tudásbázis futásidejű mérete (a main kiírja).
public export
szótárMéreteFutás : Nat
szótárMéreteFutás = length SzótárMindenKonst

||| A definíciók futásidejű száma (a main kiírja).
public export
definíciókSzámaFutás : Nat
definíciókSzámaFutás = length DefiníciókKonst

||| A W8-futtatás: szótár-méret, szint-szűrések, definíciók,
||| miért-láncok, villa — minden kimenet értelmezhető (GAUGE-elv).
main : IO ()
main = do
  putStrLn "═══ NYELV-MATEMATIKA TUDÁSBÁZIS v1 Szima — LangMathKB port ═══"
  putStrLn ""
  putStrLn "-- 1. A szótár mérete (két független út, §18):"
  putStrLn ("   szótár összesen:        " ++ show szótárMéreteFutás
    ++ "   (várható: 44 = 7+10+7+20, Refl)")
  putStrLn ("   Prím szint:             " ++ show (length PrímSzavakKonst) ++ "   (várható: 7, Refl)")
  putStrLn ("   Funktor szint:          " ++ show (length FunktorSzavakKonst) ++ "   (várható: 10, Refl)")
  putStrLn ("   Adjunkció szint:        " ++ show (length AdjunkcióSzavakKonst) ++ "   (várható: 7, Refl)")
  putStrLn ("   Meta szint:             " ++ show (length MetaSzavakKonst) ++ "   (várható: 20, Refl)")
  putStrLn ""
  putStrLn "-- 2. A 17 definíció (a kategóriaelmélet-magyar nyelv hídja):"
  putStrLn ("   definíciók száma:       " ++ show definíciókSzámaFutás
    ++ "   (várható: 17, Refl)")
  putStrLn ""
  putStrLn "-- 3. A miért-láncok (a gyökér tudásbázisban):"
  putStrLn ("   miért-láncok száma:     " ++ show (length MiértLáncokGyökérKonst)
    ++ "   (várható: 3, Refl)")
  putStrLn ""
  putStrLn "-- 4. A villa (példa: Prím szavak ∩ Funktor szavak):"
  let villaPélda = villa PrímSzavakKonst FunktorSzavakKonst
  putStrLn ("   " ++ show villaPélda)
  putStrLn ""
  putStrLn "-- 5. A szint-szűrés (gyökér tudásbázis, Meta szint):"
  let metaSzavakTudásbázis = szavakSzintSzerint gyökérTudásbázis Meta
  putStrLn ("   Meta szavak a gyökérből: " ++ show (length metaSzavakTudásbázis)
    ++ "   (várható: 20)")
  putStrLn ""
  putStrLn "-- 6. A címke-szűrés (gyökér tudásbázis, \"főnév\"):"
  let főnévDefiníciók = definíciókCímkeSzerint gyökérTudásbázis "Főnév"
  putStrLn ("   főnév-definíciók száma: " ++ show (length főnévDefiníciók)
    ++ "   (várható: 1 — Objektum ↔ főnév)")
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"