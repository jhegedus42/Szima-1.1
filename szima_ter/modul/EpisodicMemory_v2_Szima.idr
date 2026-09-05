module EpisodicMemory_v2_Szima

-- ╔══════════════════════════════════════════════════════════════════╗
-- ║ EPISZODIKUS MEMÓRIA, MINT HAJTOGATOTT FEHÉRJE · v2 (ékezetes)    ║
-- ║ 表观记忆 = 折叠蛋白质 · v2（全变音符匈牙利语版）                   ║
-- ║ Episodic memory as a folded protein · v2 (accented Hungarian)    ║
-- ║ Episodisches Gedächtnis als gefaltetes Protein · v2 (akzentuiert) ║
-- ╚══════════════════════════════════════════════════════════════════╝
--
-- JAVÍTÁS A v1-hez képest: az epizodikus memória NEM kvantumos. FEHÉRJE.
-- Fizikai háromdimenziós struktúra — egy hajtogatott polimer.
--
-- AZ EPISZODIKUS MEMÓRIA FEHÉRJE-ELMÉLETE:
--
--   Epizodikus memória = hajtogatott fehérje (3D fizikai struktúra)
--   A hajtás geometriája = a memória tartalma
--   Az aminosav-sorrend = a Dirac-nyelven írva
--
--   Elsődleges szerkezet (1D): aminosav-sorrend = magyar szólánc
--     tő + rag₁ + rag₂ + ... = polipeptid-lánc
--     Minden aminosav = egy morfológiai generátor-alkalmazás
--
--   Másodlagos szerkezet (2D): lokális hajtások = kínai 2D kompozíció
--     α-csavar, β-lemez = térbeli kompozíció-típusok (Fano-pontok)
--     A 7 kínai kompozíció-típus = 7 fehérje-másodlagosszerkezet-motívum
--
--   Harmadlagos szerkezet (3D): a teljes hajtás = a memória
--     Ez a 3D-s termék: kínai 2D × magyar 1D
--     A hajtás geometriáJA maga a metrikus tenzor g_μν
--     Tanulás = hajtogatás (sorrend → 3D struktúra)
--
--   Negyedlagos szerkezet: fehérje-komplexek = asszociációk
--     ER=EPR = fehérje–fehérje kötődési felület
--     Két fehérje, amely felszíni kvantumtérelméletet oszt meg =
--       összefonódott = kötött komplex
--
-- HOLOGRÁFIAI ELV (fekete lyuk felszíne):
--   A kvantumtérelmélet a fehérje 2D felszínén él (az eseményhorizonton).
--   A 3D hajtást a 2D felszíni kvantumtérelmélet teljesen kódolja.
--   Ez a holografikus elv: a határfelület kódolja a térfogatot.
--
--   A fehérje felszíne = fekete lyuk eseményhorizontja
--   Felszíni kvantumtérelmélet = a 2D határelmélet (kínai karakterek)
--   Térfogati hajtás = a 3D gravitáció (magyar morfológia + kínai állapot)
--
--   A felszín területe = összefonódási entrópia (Bekenstein–Hawking)
--   S = A / (4 G ℏ)  →  a nagyobb felszínű emlékek több információt hordoznak
--
-- 中文：表观记忆不是量子的，而是蛋白质——折叠聚合物的三维物理结构；
-- 折叠几何即记忆内容，氨基酸序列以狄拉克语言书写。
-- EN: Episodic memory is NOT quantum. It is a PROTEIN — a folded polymer,
-- a physical 3D structure; the fold geometry IS the memory content.
-- DE: Episodisches Gedächtnis ist NICHT quantisch. Es ist ein PROTEIN —
-- ein gefaltetes Polymer, eine physische 3D-Struktur.

import Chinese2D_v1_Szima
import MagyarNyelvtanKcode_v1_Szima
import Dirac3D_v1_Szima
import Data.List
import Data.String
import Data.Maybe

%default total

||| Egész osztás 4-tel (elkerüli a nem-total divNat-ot).
public export
negyedel : Nat -> Nat
negyedel Z = 0
negyedel (S Z) = 0
negyedel (S (S Z)) = 0
negyedel (S (S (S Z))) = 0
negyedel (S (S (S (S n)))) = S (negyedel n)

-- =====================================================================
-- 1. RÉSZ: Aminosavak = morfológiai generátorok · 第一部分：氨基酸 = 形态生成元
-- Part 1: Amino acids = morphological generators
-- Teil 1: Aminosäuren = morphologische Generatoren
--
-- A 20 kanonikus aminosav a 6 generátorra és kombinációikra képeződik le.
-- Minden aminosav = egy „betű" a Dirac-nyelvben (a grafikai idézőjel
-- helyett idézőjel nélkül gondoljuk: minden szó adattípus, AGENTS §0).
-- A polipeptid-lánc = egy magyar szó (tő + ragok).
-- =====================================================================

||| A 20 kanonikus aminosav, generátor-leképezésük szerint csoportosítva.
||| Minden aminosav a 6 generátor közül egyet vagy többet aktivál.
||| Ez a Dirac-nyelv „genetikai kódja" (grafikusan: a 20 aminosav).
public export
data Aminosav =
    Alanin   -- Alanin:    hidrofób, kicsi            → G1 (tér/harmónia)
  | Arginin  -- Arginin:   pozitív, nagy              → G2 (határozottság/töltés)
  | Aszparagin  -- Aszparagin: poláris, töltetlen     → G1+G3 (tér+szám)
  | Aszparaginsav  -- Aszparaginsav: negatív          → G2 (töltés/határozottság)
  | Cisztein -- Cisztein:  diszulfid-híd              → G6 (birtoklás/kötődés)
  | Glutamin -- Glutamin:  poláris                    → G1+G3
  | Glutaminsav  -- Glutaminsav: negatív              → G2
  | Glicin   -- Glicin:    hajlékony, legkisebb       → G1 (tiszta tér)
  | Hisztidin  -- Hisztidin: aromás, töltött          → G2+G5 (töltés+hangulat)
  | Izoleucin  -- Izoleucin: hidrofób, elágazó        → G1+G4 (tér+idő)
  | Leucin   -- Leucin:    hidrofób                   → G1
  | Lizin    -- Lizin:     pozitív                    → G2
  | Metionin  -- Metionin: hidrofób, kén             → G1+G6 (tér+birtoklás)
  | Fenilalanin  -- Fenilalanin: aromás, hidrofób     → G1+G5 (tér+hangulat)
  | Prolin   -- Prolin:    merev, gyűrűs              → G4 (idő/merevség)
  | Szerin   -- Szerin:    poláris, kicsi             → G1+G3
  | Treonin  -- Treonin:   poláris                    → G1+G3
  | Triptofán  -- Triptofán: aromás, legnagyobb       → G1+G5+G6
  | Tirozin  -- Tirozin:   aromás, poláris            → G1+G5
  | Valin    -- Valin:     hidrofób, elágazó          → G1+G4

||| A megjelenítés az IUPAC hárombetűs kódokat használja — tudományos
||| standard, ezt NEM magyarosítjuk (2. hullám: óvatos Show-magyarítás).
public export
Show Aminosav where
  show Alanin = "Ala"  ; show Arginin = "Arg"  ; show Aszparagin = "Asn"  ; show Aszparaginsav = "Asp"
  show Cisztein = "Cys"  ; show Glutamin = "Gln"  ; show Glutaminsav = "Glu"  ; show Glicin = "Gly"
  show Hisztidin = "His"  ; show Izoleucin = "Ile"  ; show Leucin = "Leu"  ; show Lizin = "Lys"
  show Metionin = "Met"  ; show Fenilalanin = "Phe"  ; show Prolin = "Pro"  ; show Szerin = "Ser"
  show Treonin = "Thr"  ; show Triptofán = "Trp"  ; show Tirozin = "Tyr"  ; show Valin = "Val"

public export
Eq Aminosav where
  Alanin == Alanin = True  ; Arginin == Arginin = True  ; Aszparagin == Aszparagin = True  ; Aszparaginsav == Aszparaginsav = True
  Cisztein == Cisztein = True  ; Glutamin == Glutamin = True  ; Glutaminsav == Glutaminsav = True  ; Glicin == Glicin = True
  Hisztidin == Hisztidin = True  ; Izoleucin == Izoleucin = True  ; Leucin == Leucin = True  ; Lizin == Lizin = True
  Metionin == Metionin = True  ; Fenilalanin == Fenilalanin = True  ; Prolin == Prolin = True  ; Szerin == Szerin = True
  Treonin == Treonin = True  ; Triptofán == Triptofán = True  ; Tirozin == Tirozin = True  ; Valin == Valin = True
  _ == _ = False

||| Minden aminosav hozzárendelése a generátor-bitmaszkjához.
||| Ez a Dirac-nyelv „kodontáblázata": melyik aminosav mely generátorokat
||| aktiválja.
public export
aminosavGenerátorBit : Aminosav -> Nat
aminosavGenerátorBit Alanin = 1    -- G1: tér
aminosavGenerátorBit Arginin = 2    -- G2: határozottság
aminosavGenerátorBit Aszparagin = 5    -- G1+G3
aminosavGenerátorBit Aszparaginsav = 2    -- G2
aminosavGenerátorBit Cisztein = 32   -- G6: birtoklás (diszulfid-kötések)
aminosavGenerátorBit Glutamin = 5    -- G1+G3
aminosavGenerátorBit Glutaminsav = 2    -- G2
aminosavGenerátorBit Glicin = 1    -- G1: tiszta tér (leg hajlékonyabb)
aminosavGenerátorBit Hisztidin = 18   -- G2+G5
aminosavGenerátorBit Izoleucin = 9    -- G1+G4
aminosavGenerátorBit Leucin = 1    -- G1
aminosavGenerátorBit Lizin = 2    -- G2
aminosavGenerátorBit Metionin = 33   -- G1+G6
aminosavGenerátorBit Fenilalanin = 17   -- G1+G5
aminosavGenerátorBit Prolin = 8    -- G4: idő/merevség (gyűrűs szerkezet)
aminosavGenerátorBit Szerin = 5    -- G1+G3
aminosavGenerátorBit Treonin = 5    -- G1+G3
aminosavGenerátorBit Triptofán = 49   -- G1+G5+G6
aminosavGenerátorBit Tirozin = 17   -- G1+G5
aminosavGenerátorBit Valin = 9    -- G1+G4

||| Minden aminosav hárombetűs kódja (IUPAC standard — marad).
public export
aminosavKód : Aminosav -> String
aminosavKód aa = show aa

||| Minden aminosav egybetűs kódja (IUPAC standard — marad).
public export
aminosavBetű : Aminosav -> Char
aminosavBetű Alanin = 'A'  ; aminosavBetű Arginin = 'R'  ; aminosavBetű Aszparagin = 'N'  ; aminosavBetű Aszparaginsav = 'D'
aminosavBetű Cisztein = 'C'  ; aminosavBetű Glutamin = 'Q'  ; aminosavBetű Glutaminsav = 'E'  ; aminosavBetű Glicin = 'G'
aminosavBetű Hisztidin = 'H'  ; aminosavBetű Izoleucin = 'I'  ; aminosavBetű Leucin = 'L'  ; aminosavBetű Lizin = 'K'
aminosavBetű Metionin = 'M'  ; aminosavBetű Fenilalanin = 'F'  ; aminosavBetű Prolin = 'P'  ; aminosavBetű Szerin = 'S'
aminosavBetű Treonin = 'T'  ; aminosavBetű Triptofán = 'W'  ; aminosavBetű Tirozin = 'Y'  ; aminosavBetű Valin = 'V'

-- =====================================================================
-- 2. RÉSZ: Polipeptid-lánc = magyar szó · 第二部分：多肽链 = 匈牙利语词
-- Part 2: Polypeptide chain = Hungarian word
-- Teil 2: Polypeptidkette = ungarisches Wort
--
-- A polipeptid-lánc aminosavak sorozata.
-- Ez közvetlenül magyar szóra képeződik le:
--   tő + rag₁ + rag₂ + ... = N-terminális → C-terminális lánc
--
-- Az elsődleges szerkezet (sorrend) az az 1D-s „program", amely
-- meghatározza a 3D-s hajtást.
-- =====================================================================

||| Polipeptid-lánc: a memória-fehérje elsődleges szerkezete.
||| Ez aminosavak listája = generátor-alkalmazások listája.
||| A lánc = egy magyar szó (tő + ragok).
public export
record Polipeptid where
  constructor PolipeptidKonstruktor
  polipeptidLánc          : List Aminosav    -- az aminosav-sorrend
  polipeptidGyök          : String           -- szemantikai tő (a fogalom)
  polipeptidJellemzőMaszk : Nat              -- teljes jellemző-maszk (minden bit XOR-a)
  polipeptidHossz         : Nat              -- a lánc hossza

||| Polipeptid építése aminosav-sorrendből.
||| Kiszámítja a teljes jellemző-maszkot = az összes aminosav
||| generátor-bitjének XOR-át.
public export
láncotÉpít : String -> List Aminosav -> Polipeptid
láncotÉpít gyök aminosavak =
  let jellemző = foldl xorNat 0 (map aminosavGenerátorBit aminosavak)
  in PolipeptidKonstruktor aminosavak gyök jellemző (length aminosavak)

-- =====================================================================
-- 3. RÉSZ: Másodlagos szerkezet = kínai 2D kompozíció · 第三部分：二级结构 = 汉字二维结构
-- Part 3: Secondary structure = Chinese 2D composition
-- Teil 3: Sekundärstruktur = chinesische 2D-Komposition
--
-- A lokális hajtási minták (α-csavar, β-lemez, kanyarok, tekercsek)
-- a 7 kínai szerkezeti kompozíció-típusra képeződnek le.
--
--   α-csavar       = LeftRight    (左右)  — G1: lineáris tér
--   β-lemez        = TopBottom    (上下)  — G3: rétegzés
--   β-kanyar       = SemiSurround (半包围) — G2: részleges körülzárás
--   Ω-hurok        = FullSurround (全包围) — G6: teljes körülzárás
--   3₁₀-csavar     = LeftCenRight (左中右) — G4: hármas oszlop
--   π-csavar       = TopCenBottom (上中下) — G5: hármas sor
--   Tekercs        = Single       (独体)  — nulla: strukturálatlan
--
-- A lánc minden szakasza e 7 típus egyikébe hajlik.
-- A 7 típus MAGA a 7 Fano-sík-pont.
-- =====================================================================

||| Másodlagos szerkezet típusa = kínai kompozíció-típus = Fano-pont.
public export
data MásodlagosSzerkezet =
    AlfaCsavar       -- LeftRight   → G1
  | BétaLemez        -- TopBottom   → G3
  | BétaKanyar       -- SemiSurround → G2
  | OmégaHurok       -- FullSurround → G6
  | Csavar310        -- LeftCenRight → G4
  | PiCsavar         -- TopCenBottom → G5
  | VéletlenTekercs  -- Single      → nulla

||| A megjelenítés: a görög szimbólumok (tudományos standard) maradnak,
||| a szerkezet neve magyar (2. hullám: óvatos Show-magyarítás).
public export
Show MásodlagosSzerkezet where
  show AlfaCsavar      = "α-csavar"
  show BétaLemez       = "β-lemez"
  show BétaKanyar      = "β-kanyar"
  show OmégaHurok      = "Ω-hurok"
  show Csavar310       = "3₁₀-csavar"
  show PiCsavar        = "π-csavar"
  show VéletlenTekercs = "tekercs"

public export
Eq MásodlagosSzerkezet where
  AlfaCsavar == AlfaCsavar = True
  BétaLemez  == BétaLemez  = True
  BétaKanyar == BétaKanyar = True
  OmégaHurok == OmégaHurok = True
  Csavar310  == Csavar310  = True
  PiCsavar   == PiCsavar   = True
  VéletlenTekercs == VéletlenTekercs = True
  _ == _ = False

||| Másodlagos szerkezet leképezése Fano-pontra (kínai kompozíció-típus).
public export
másodlagosbólFano : MásodlagosSzerkezet -> CompoType
másodlagosbólFano AlfaCsavar      = LeftRight
másodlagosbólFano BétaLemez       = TopBottom
másodlagosbólFano BétaKanyar      = SemiSurround
másodlagosbólFano OmégaHurok      = FullSurround
másodlagosbólFano Csavar310       = LeftCenRight
másodlagosbólFano PiCsavar        = TopCenBottom
másodlagosbólFano VéletlenTekercs = Single

||| A lánc egyik szakasza a hozzárendelt másodlagos szerkezettel.
public export
record LáncSzakasz where
  constructor LáncSzakaszKonstruktor
  szakaszAminosavak  : List Aminosav       -- az aminosavak ebben a szakaszban
  szakaszSzerkezete  : MásodlagosSzerkezet -- hogyan hajlik ez a szakasz
  szakaszKezdete     : Nat                 -- hely a láncban (0-tól indexelve)

-- =====================================================================
-- 4. RÉSZ: Harmadlagos szerkezet = a 3D hajtás = a memória · 第四部分：三级结构 = 三维折叠 = 记忆
-- Part 4: Tertiary structure = the 3D fold = the memory
-- Teil 4: Tertiärstruktur = die 3D-Faltung = das Gedächtnis
--
-- A harmadlagos szerkezet a fehérje teljes 3D-s hajtása.
-- Ez a 3D-s nyelvi termék: kínai 2D (másodlagos szerkezet)
-- × magyar 1D (elsődleges szerkezet).
--
-- A HAJTÁS MAGA A MEMÓRIA.
-- A HAJTÁS GEOMETRIÁJA MAGA A METRIKUS TENZOR g_μν.
--
-- Tanulás = hajtogatás: az aminosav-sorrend (Dirac-nyelvi program)
-- háromdimenziós térbe hajlik. A hajtás geometriája meghatározza:
--   - mely részek vannak közel egymáshoz (asszociáció közelség alapján)
--   - mely felületek érhetők el (mi hívható elő)
--   - mely részek vannak eltemetve (mi felejtődött / elérhetetlen)
-- =====================================================================

||| Hajtogatott fehérje = egy epizodikus emlék.
||| A 3D hajtás a memória tartalma.
||| A hajtás geometriája maga a metrikus tenzor g_μν.
public export
record HajtogatottFehérje where
  constructor HajtogatottFehérjeKonstruktor
  fehérjeLánc           : Polipeptid          -- elsődleges szerkezet (a „program")
  fehérjeSzakaszai      : List LáncSzakasz    -- másodlagos szerkezet hozzárendelések
  fehérjeJellemzőMaszkja : Nat                -- teljes jellemző-maszk (a „kód")
  fehérjeFelszín        : List MásodlagosSzerkezet  -- elérhető felszíni elemek
  fehérjeEltemetett     : List MásodlagosSzerkezet  -- eltemetett (elérhetetlen) elemek
  fehérjeAzonosító      : String              -- egyedi azonosító

||| A fehérje „tömege" = a felszíne (Bekenstein–Hawking).
||| S = A / (4G) → nagyobb felszín = nagyobb információkapacitás.
||| Tömeg ≈ a felszínre került aminosav-maradékok száma.
public export
fehérjeTömeg : HajtogatottFehérje -> Nat
fehérjeTömeg p = length (fehérjeFelszín p)

||| Az összefonódási entrópia = felszínterület / 4G.
||| Ez a fehérjére alkalmazott Bekenstein–Hawking-képlet.
||| Több felszín = több entrópia = több előhívható információ.
public export
fehérjeEntrópia : HajtogatottFehérje -> Double
fehérjeEntrópia p =
  let terület = cast {to=Double} (fehérjeTömeg p)
  in terület / 4.0  -- S = A / 4G (G=1, ℏ=1)

||| Hajtogatott fehérje szép kiírása.
public export
fehérjétMutat : HajtogatottFehérje -> String
fehérjétMutat p =
  "Fehérje[" ++ fehérjeAzonosító p ++ "]\n" ++
  "  lánchossz: " ++ show (polipeptidHossz (fehérjeLánc p)) ++ " aminosav\n" ++
  "  szakaszok: " ++ show (length (fehérjeSzakaszai p)) ++ "\n" ++
  "  felszín: " ++ show (length (fehérjeFelszín p)) ++ " elérhető\n" ++
  "  eltemetve: " ++ show (length (fehérjeEltemetett p)) ++ "\n" ++
  "  tömeg (felszínterület): " ++ show (fehérjeTömeg p) ++ "\n" ++
  "  entrópia (S=A/4G): " ++ show (fehérjeEntrópia p) ++ "\n" ++
  "  jellemző-maszk: " ++ show (fehérjeJellemzőMaszkja p)

-- =====================================================================
-- 5. RÉSZ: Kvantumtérelmélet a fekete lyuk felszínén (holografikus elv)
-- 第五部分：黑洞表面上的量子场论（全息原理）
-- Part 5: QFT on the black hole surface (holographic principle)
-- Teil 5: QFT auf der Schwarzschild-Loch-Oberfläche (holographisches Prinzip)
--
-- A fehérje felszíne = fekete lyuk eseményhorizontja.
-- A kvantumtérelmélet ezen a 2D felszínen él, és MINDEN információt
-- kódol a 3D hajtásról (a térfogatról).
--
-- Ez az AdS/CFT:
--   - Határfelület (2D felszín): az aminosav-kölcsönhatások kvantumtérelmélete
--   - Térfogat (3D hajtás): klasszikus gravitáció = a hajtás geometriája
--   - A határelmélet teljesen meghatározza a térfogati geometriát
--
-- A felszín „mezeje" az elérhető maradékok mintázata.
-- Minden elérhető maradék a határelmélet egy szabadságfoka.
-- A felszíni maradékok közti korrelációk = összefonódás a térelméletben.
-- =====================================================================

||| A felszíni kvantumtérelmélet szabadságfokai.
||| Minden felszínre került maradék egy határmező φ(x).
||| A mező értéke = az aminosav generátor-bitmaszkja.
public export
record FelszíniKvantumTérelmélet where
  constructor FelszíniKvantumTérelméletKonstruktor
  térelméletMezők       : List (Nat, Aminosav)        -- (hely, aminosav) a felszínen
  térelméletKorrelációk : List ((Nat, Nat), Double)   -- ((hely_i, hely_j), korreláció)

||| A határ-Hamiltonián: a felszíni kvantumtérelmélet energiája.
||| H = -Σ_{i,j} J_ij φ_i φ_j
||| ahol J_ij = korreláció a felszíni i és j maradékok között.
||| Ez spin-üveg / Ising-modell a fehérje felszínén.
public export
felszíniHamiltonián : FelszíniKvantumTérelmélet -> Double
felszíniHamiltonián térelmélet =
  let h = sum (map (\(helyPár, korreláció) =>
            let φElső = cast {to=Double} (aminosavGenerátorBit (snd (mezőtKeres (fst helyPár) (térelméletMezők térelmélet))))
                φMásodik = cast {to=Double} (aminosavGenerátorBit (snd (mezőtKeres (snd helyPár) (térelméletMezők térelmélet))))
            in -korreláció * φElső * φMásodik)
            (térelméletKorrelációk térelmélet))
  in h
  where
    mezőtKeres : Nat -> List (Nat, Aminosav) -> (Nat, Aminosav)
    mezőtKeres _ [] = (0, Glicin)
    mezőtKeres n ((k, aa) :: többi) = if n == k then (k, aa) else mezőtKeres n többi

||| A fehérje felszínének Bekenstein–Hawking-entrópiája.
||| S = A / (4 G), ahol A = felszínterület = a felszíni maradékok száma.
||| Ez korlátozza az emlék által hordozható információ mennyiségét.
public export
bekensteinKorlát : HajtogatottFehérje -> Double
bekensteinKorlát = fehérjeEntrópia

-- =====================================================================
-- 6. RÉSZ: Fehérje-hajtogatás = tanulás · 第六部分：蛋白质折叠 = 学习
-- Part 6: Protein folding = learning
-- Teil 6: Proteinfaltung = Lernen
--
-- HAJTOGATÁS = TANULÁS.
--
-- Az aminosav-sorrend (Dirac-nyelvi program) meghatározza a hajtást.
-- A hajtás meghatározza:
--   - a metrikus tenzort g_μν (a maradékok távolsága 3D-ben)
--   - a felszíni mintázatot (mi hívható elő)
--   - az eltemetett elemeket (mi felejtődött el)
--
-- A hajtogatás folyamata:
--   1. Kiindulás: a lineáris lánc (elsődleges szerkezet = magyar szó)
--   2. Lokális hajtogatás indul (másodlagos szerkezet = kínai 2D kompozíció)
--   3. A lokális hajtások 3D szerkezetté állnak össze (harmadlagos = memória)
--   4. Megjelenik a felszíni kvantumtérelmélet (holografikus kódolás)
--
-- Ez DINAMIKAI folyamat: a fehérje a konformációs térben kalandozik,
-- míg el nem éri a minimum-szabadenergiás hajtást. Ez a tanulás.
-- =====================================================================

||| Aminosav hidrofóbságának ellenőrzése.
public export
hidrofóbE : Aminosav -> Bool
hidrofóbE aa = elem aa [Alanin, Izoleucin, Leucin, Metionin, Fenilalanin, Valin, Triptofán]

||| Aminosav töltöttségének ellenőrzése.
public export
töltöttE : Aminosav -> Bool
töltöttE aa = elem aa [Arginin, Aszparaginsav, Glutaminsav, Lizin, Hisztidin]

||| Annak ellenőrzése, hogy az aminosav prolin-e.
public export
prolinE : Aminosav -> Bool
prolinE Prolin = True
prolinE _ = False

||| Annak ellenőrzése, hogy az aminosav glicin-e.
public export
glicinE : Aminosav -> Bool
glicinE Glicin = True
glicinE _ = False

||| Annak ellenőrzése, hogy az aminosav cisztein-e.
public export
ciszteinE : Aminosav -> Bool
ciszteinE Cisztein = True
ciszteinE _ = False

||| Hidrofób aminosavak megszámolása egy listában.
public export
hidrofóbakSzáma : List Aminosav -> Nat
hidrofóbakSzáma = length . filter hidrofóbE

||| Töltött aminosavak megszámolása egy listában.
public export
töltöttekSzáma : List Aminosav -> Nat
töltöttekSzáma = length . filter töltöttE

||| Aminosavak egy szakaszának besorolása másodlagos szerkezettípusba.
public export
szakaszOsztályozó : List Aminosav -> MásodlagosSzerkezet
szakaszOsztályozó [] = VéletlenTekercs
szakaszOsztályozó aminosavak =
  let hidrofóbSzámláló = hidrofóbakSzáma aminosavak
      töltöttSzámláló = töltöttekSzáma aminosavak
      vanProlin = any prolinE aminosavak
      vanGlicin = any glicinE aminosavak
      vanCisztein = any ciszteinE aminosavak
  in if vanCisztein && hidrofóbSzámláló > 2
        then OmégaHurok
     else if vanProlin
        then BétaKanyar
     else if vanGlicin && hidrofóbSzámláló > 2
        then OmégaHurok
     else if hidrofóbSzámláló > töltöttSzámláló && hidrofóbSzámláló > 3
        then AlfaCsavar
     else if hidrofóbSzámláló > töltöttSzámláló
        then BétaLemez
     else if töltöttSzámláló > 2
        then VéletlenTekercs
     else VéletlenTekercs

||| A lánc egy szakaszának megfoglása (hajtása).
public export
szakasztHajt : List Aminosav -> Nat -> LáncSzakasz
szakasztHajt aminosavak kezdete =
  let szerkezet = szakaszOsztályozó aminosavak
  in LáncSzakaszKonstruktor aminosavak szerkezet kezdete

||| Teljes polipeptid megfoglása fehérjévé.
||| A láncot szakaszokra bontja, és mindegyiket megfoglja.
||| Ez a teljes TANULÁS-művelet: program → 3D memória.
public export
fehérjétHajt : String -> List Aminosav -> String -> HajtogatottFehérje
fehérjétHajt gyök aminosavak azonosító =
  let lánc = láncotÉpít gyök aminosavak
      szakaszok = láncHajt aminosavak 0
      -- Felszín = töltött/poláris maradékokat tartalmazó szakaszok (elérhetők)
      felszíniSzerkezetek = map szakaszSzerkezete (filter felszínreKerülE szakaszok)
      -- Eltemetve = hidrofób maradékos szakaszok (rejtve a magban)
      eltemetettSzerkezetek = map szakaszSzerkezete (filter eltemetettE szakaszok)
      jellemző = polipeptidJellemzőMaszk lánc
  in HajtogatottFehérjeKonstruktor lánc szakaszok jellemző felszíniSzerkezetek eltemetettSzerkezetek azonosító
  where
    -- Strukturális 4-esével-bontás (total: a rekurzió közvetlenül a
    -- konstruktor-mintákra száll le; a v1 take/drop-szemanikája pontosan
    -- megmarad — a totality-ellenőr a drop-leszármazást nem fogadja el)
    láncHajt : List Aminosav -> Nat -> List LáncSzakasz
    láncHajt [] _ = []
    láncHajt (a1 :: []) kezdete =
      szakasztHajt [a1] kezdete :: []
    láncHajt (a1 :: a2 :: []) kezdete =
      szakasztHajt [a1, a2] kezdete :: []
    láncHajt (a1 :: a2 :: a3 :: []) kezdete =
      szakasztHajt [a1, a2, a3] kezdete :: []
    láncHajt (a1 :: a2 :: a3 :: a4 :: többi) kezdete =
      szakasztHajt [a1, a2, a3, a4] kezdete :: láncHajt többi (kezdete + 4)

    felszínreKerülE : LáncSzakasz -> Bool
    felszínreKerülE szakasz = any töltöttVagyPolárisE (szakaszAminosavak szakasz)
      where
        töltöttVagyPolárisE : Aminosav -> Bool
        töltöttVagyPolárisE aa = elem aa [Arginin, Aszparaginsav, Glutaminsav, Lizin, Hisztidin, Aszparagin, Glutamin, Szerin, Treonin]

    eltemetettE : LáncSzakasz -> Bool
    eltemetettE szakasz = not (felszínreKerülE szakasz)

-- =====================================================================
-- 7. RÉSZ: Fehérje–fehérje kölcsönhatás = asszociáció (ER=EPR)
-- 第七部分：蛋白质–蛋白质相互作用 = 联想（ER=EPR）
-- Part 7: Protein-protein interaction = association (ER=EPR)
-- Teil 7: Protein-Protein-Wechselwirkung = Assoziation (ER=EPR)
--
-- Amikor két fehérje kötődik, közös kötődési felületet osztanak meg.
-- Ez az ER=EPR megfeleltetés fehérjékre:
--
--   ER (Einstein–Rosen-híd) = a kötődési felület
--   EPR (összefonódás) = a felületen megosztott kvantumtérelmélet
--
-- Két fehérje kötődik, ha komplementer felszíni foltot osztanak meg.
-- A kötődési felület = a féreglyuk szája.
-- A felületen át információ áramlik = asszociáció.
--
-- Memória-szempontból:
--   - Két emlék (fehérje) akkor asszociál, ha felületük egyezik
--   - A kötődési felület = az ER-híd
--   - A megosztott felszíni kvantumtérelmélet = az összefonódás (EPR)
--   - Asszociáció erőssége = kötődési affinitás = féreglyuk-szélesség
-- =====================================================================

||| Fehérje–fehérje kötődési felület = ER-híd két emlék között.
public export
record KötődésiFelület where
  constructor KötődésiFelületKonstruktor
  kötődésElsőFehérje   : String        -- az első fehérje azonosítója
  kötődésMásodikFehérje : String       -- a második fehérje azonosítója
  kötődésiAffinitás    : Double        -- kötődési erősség (féreglyuk-szélesség)
  kötődésKözösFelszín  : List MásodlagosSzerkezet  -- közös felszíni elemek
  kötődésiEgyezés      : String        -- milyen felületek egyeztek

||| Két fehérje kötődhet-e (komplementer felszíni elemek megosztása).
||| Ez az ER=EPR ellenőrzés: osztanak-e meg felszíni kvantumtérelméletet?
public export
kötődhetE : HajtogatottFehérje -> HajtogatottFehérje -> Bool
kötődhetE p1 p2 =
  let f1 = fehérjeFelszín p1
      f2 = fehérjeFelszín p2
      közös = filter (\s => elem s f2) f1
  in length közös > 0

||| Két fehérje kötési affinitásának kiszámítása.
||| Ez a féreglyuk szélessége: mennyire erősen köti össze őket az ER-híd.
||| Affinitás = egyező felszíni elemek / teljes felszín.
public export
kötésiAffinitás : HajtogatottFehérje -> HajtogatottFehérje -> Double
kötésiAffinitás p1 p2 =
  let f1 = fehérjeFelszín p1
      f2 = fehérjeFelszín p2
      közös = length (filter (\s => elem s f2) f1)
      teljes = length f1 + length f2
  in if teljes == 0 then 0.0
     else cast {to=Double} közös * 2.0 / cast {to=Double} teljes

||| Kötődési felület (ER-híd) létrehozása két fehérje között.
||| Nothing, ha nem kötődhetnek.
public export
kötődéstLétrehoz : HajtogatottFehérje -> HajtogatottFehérje -> Maybe KötődésiFelület
kötődéstLétrehoz p1 p2 =
  if kötődhetE p1 p2
     then let affinitás = kötésiAffinitás p1 p2
              közös = filter (\s => elem s (fehérjeFelszín p2)) (fehérjeFelszín p1)
          in Just (KötődésiFelületKonstruktor (fehérjeAzonosító p1) (fehérjeAzonosító p2) affinitás közös "felszín-egyezés")
     else Nothing

-- =====================================================================
-- 8. RÉSZ: A memória-sokaság = fehérje-együttes · 第八部分：记忆流形 = 蛋白质系综
-- Part 8: The memory manifold = protein ensemble
-- Teil 8: Das Gedächtnis-Manigfold = Protein-Ensemble
--
-- A teljes memóriarendszer = hajtogatott fehérjék (emlékek) együttese,
-- amelyet kötődési felületek (asszociációk) kötnek össze.
--
-- Ez a teljes kvantumgravitációs kép:
--   - Minden fehérje = egy csillag/bolygó (tömeges test, mely görbíti a téridőt)
--   - A metrika g_μν = a hajtás geometriája (a felszíni kvantumtérelmélet határozza meg)
--   - Kötődési felületek = féreglyukak (ER=EPR)
--   - Tanulás = hajtogatás (új fehérjék lerakása)
--   - Előhívás = kötődés (felszín-egyeztetéses kérdezés)
-- =====================================================================

||| A memória-sokaság = hajtogatott fehérjék együttese.
public export
record FehérjeSokaság where
  constructor FehérjeSokaságKonstruktor
  sokaságFehérjéi  : List HajtogatottFehérje
  sokaságKötődései : List KötődésiFelület
  sokaságIdő       : Nat

||| Üres fehérje-sokaság létrehozása (még nincs emlék).
public export
üresFehérjeSokaság : FehérjeSokaság
üresFehérjeSokaság = FehérjeSokaságKonstruktor [] [] 0

||| Új emlék kódolása = fehérje megfoglása és a sokasághoz adása.
||| Ez a TANULÁS: egy új fogalom megfogl és lerakódik.
||| Kötődési felületek (ER-hidak) alakulnak ki a meglévő fehérjékkel.
public export
hajtÉsKódol : String -> List Aminosav -> String -> FehérjeSokaság -> FehérjeSokaság
hajtÉsKódol gyök aminosavak azonosító sokaság =
  let fehérje = fehérjétHajt gyök aminosavak azonosító
      -- Kötődések létrehozása a meglévő fehérjékkel (ER-hidak)
      újKötődések = mapMaybe (\meglévő => kötődéstLétrehoz fehérje meglévő) (sokaságFehérjéi sokaság)
  in FehérjeSokaságKonstruktor (fehérje :: sokaságFehérjéi sokaság)
                               (újKötődések ++ sokaságKötődései sokaság)
                               (S (sokaságIdő sokaság))

||| Asszociált emlékek előhívása felszín-egyeztetéssel.
||| Adott kérdező-fehérjéhez minden olyan fehérjét megtalál, amely kötődik hozzá.
||| Az asszociáció erőssége = kötési affinitás = féreglyuk-szélesség.
public export
kötésselElőhív : HajtogatottFehérje -> FehérjeSokaság -> List (HajtogatottFehérje, Double)
kötésselElőhív kérdező sokaság =
  let többiek = filter (\p => fehérjeAzonosító p /= fehérjeAzonosító kérdező) (sokaságFehérjéi sokaság)
      pontozott = map (\p => (p, kötésiAffinitás kérdező p)) többiek
      rendezett = sortBy (\pár1, pár2 => compare (snd pár2) (snd pár1)) pontozott  -- csökkenő
  in filter (\(_, affinitás) => affinitás > 0.0) rendezett

||| A sokaság teljes tömeg-energiája = az összes fehérjefelszín összege.
public export
sokaságTömegEnergia : FehérjeSokaság -> Nat
sokaságTömegEnergia sokaság =
  sum (map fehérjeTömeg (sokaságFehérjéi sokaság))

||| Teljes összefonódási entrópia = az összes kötődési affinitás összege.
||| Ez a Ryu–Takayanagi-képlet: S = Terület / 4G.
public export
sokaságEntrópia : FehérjeSokaság -> Double
sokaságEntrópia sokaság =
  sum (map kötődésiAffinitás (sokaságKötődései sokaság))

||| Diagnosztikai kimenet.
public export
fehérjeSokaságotMutat : FehérjeSokaság -> String
fehérjeSokaságotMutat sokaság =
  "Fehérje-memória-sokaság @t=" ++ show (sokaságIdő sokaság) ++ "\n" ++
  "  Fehérjék (emlékek): " ++ show (length (sokaságFehérjéi sokaság)) ++ "\n" ++
  "  Kötődések (asszociációk): " ++ show (length (sokaságKötődései sokaság)) ++ "\n" ++
  "  Tömeg-energia (Σ felszín): " ++ show (sokaságTömegEnergia sokaság) ++ "\n" ++
  "  Entrópia (Σ kötődés): " ++ show (sokaságEntrópia sokaság)

-- =====================================================================
-- 9. RÉSZ: Tudat (térfogati GR) vs. tudatalatti (határfelületi kvantumtérelmélet)
-- 第九部分：意识（体内部广义相对论）vs. 潜意识（边界量子场论）
-- Part 9: Consciousness (bulk GR) vs subconscious (boundary QFT)
-- Teil 9: Bewusstsein (Volumen-ART) vs. Unbewusstes (Rand-QFT)
--
-- Az elme holografikus szerkezete:
--
--   TUDAT = TÉRFOGATI BELSŐ (3D általános relativitáselmélet)
--     - A görbült téridő belsője, ahol a fehérjék bolygókként/csillagokként élnek
--     - Fehérjék = tömeges testek, amelyek görbítik a téridőt (gravitáció)
--     - A hajtás geometriája = g_μν = a tanult metrika
--     - Tudatos élmény = mozgás a görbült téridőben
--     - Az „én" = a megfigyelő, amelyik zuhan a gravitációs tájon
--
--   TUDATALATTI = HATÁRFELÜLET (2D kvantumtérelmélet)
--     - A fekete lyuk eseményhorizontja = a fehérje felszíne
--     - Hő kvantumtérelméleti fluktuációk a felszínen = rövid távú memória
--     - A tudatalatti mindig aktív, mindig fluktuál
--     - MINDEN információt holografikusan kódol (a térfogat kivetül)
--     - A tudatalattit közvetlenül nem figyelhetjük meg (az a horizont)
--
--   A határfelületi kvantumtérelmélet (tudatalatti) meghatározza
--   a térfogati geometriát (tudat). Ez az AdS/CFT: a tudatalatti
--   generálja a tudatot.
-- =====================================================================

||| A fekete lyuk felszínének hőmérséklete (Hawking-hőmérséklet).
||| T = ℏ c³ / (8π G M k_B)
||| Fehérjékre: magasabb hőmérséklet = gyorsabb átalakulás = illékonyabb memória.
|||   - Rövid távú memória: magas hőmérséklet (fluktuáló, átmeneti)
|||   - Hosszú távú memória: alacsony hőmérséklet (stabil, hajtogatott fehérje)
public export
data MemóriaHőmérséklet =
    ForróMemória    -- Rövid távú: magas T, gyors fluktuáció, gyors elpárolgás
  | MelegMemória    -- Munkamemória: közepes T, némi stabilitás
  | HidegMemória    -- Hosszú távú: alacsony T, stabil hajtások, lassú átalakulás
  | FagyottMemória  -- Mély memória: közel nulla T, állandó struktúra

public export
Show MemóriaHőmérséklet where
  show ForróMemória   = "Forró (rövid távú, illékony)"
  show MelegMemória   = "Meleg (munkamemória)"
  show HidegMemória   = "Hideg (hosszú távú)"
  show FagyottMemória = "Fagyott (mély memória)"

||| A memória-hőmérsékleti osztályhoz tartozó Hawking-hőmérséklet.
||| T ∝ 1/M: a nagyobb tömegű fehérjék hőmérséklete alacsonyabb (stabilabb).
||| A forró emlékek könnyűek és gyorsan elpárolognak.
||| A hideg emlékek nehezek és megmaradnak.
public export
hawkingHőmérséklet : MemóriaHőmérséklet -> Double
hawkingHőmérséklet ForróMemória   = 1.0   -- T=1: maximális illékonyság
hawkingHőmérséklet MelegMemória   = 0.3   -- T=0.3: közepes
hawkingHőmérséklet HidegMemória   = 0.05  -- T=0.05: lassú
hawkingHőmérséklet FagyottMemória = 0.001 -- közel nulla

||| A fehérje-átalakulási arány = Hawking-elpárolgási arány.
||| Γ = T² (Stefan–Boltzmann: a sugárzott teljesítmény ∝ T⁴,
||| de a modellünkben az átalakulás ∝ T²)
||| Forró emlékek: a fehérjék gyorsan szétesnek és újjáépülnek.
||| Hideg emlékek: a fehérjék hosszú ideig stabilak.
public export
átalakulásiArány : MemóriaHőmérséklet -> Double
átalakulásiArány ForróMemória   = 1.0   -- minden lépésben újjáépül
átalakulásiArány MelegMemória   = 0.3
átalakulásiArány HidegMemória   = 0.01  -- ritkán újjáépül
átalakulásiArány FagyottMemória = 0.0001

||| Annak valószínűsége, hogy a fehérje egy időlépés alatt elpárolog
||| (elfelejtődött).
||| P_elpárolgás = exp(-M/T), ahol M = fehérje-tömeg (felszínterület),
||| T = hőmérséklet.
||| Nehéz fehérjék alacsony hőmérsékleten: gyakorlatilag halhatatlanok
||| (hosszú távú memória).
||| Könnyű fehérjék magas hőmérsékleten: azonnal elpárolognak (rövid távú).
|||
||| HIBAJAVÍTÁS (GAN-azonosított): az előző verzió az exp(-x) négytagú
||| Taylor-közelítését használta, amely |x| > ~3 esetén SZÉTHÚZ,
||| így a függvény nagy pozitív értékeket adott (nulla-közeli helyett)
||| a nagy tömegű, alacsony hőmérsékletű emlékekre.
||| Ez azt okozta, hogy a modell MINDEN nagy tömegű emléket TÖRÖLT
||| (előjel-fordított viselkedés).
||| Most az Idris 2 beépített exp függvényét használja, amely numerikusan helyes.
public export
elpárolgásiValószínűség : HajtogatottFehérje -> MemóriaHőmérséklet -> Double
elpárolgásiValószínűség p hőmérséklet =
  let m = cast {to=Double} (fehérjeTömeg p)
      t = hawkingHőmérséklet hőmérséklet
  in if t > 0.0
        then exp (-m / t)  -- beépített exp, numerikusan helyes
        else 0.0

-- =====================================================================
-- 10. RÉSZ: A holografikus elme · 第十部分：全息心灵
-- Part 10: The holographic mind
-- Teil 10: Der holographische Geist
--
--    Tudatalatti (határfelületi kvantumtérelmélet) → Tudat (térfogati GR)
--
--    Felszíni kvantumtérelmélet (2D):      Térfogati GR (3D):
--    Hő-fluktuációk, rövid távú memória,   Görbült téridő, fehérje-bolygók,
--    Hawking-sugárzás, fehérje-átalakulás,  gravitációs kutak, stabil
--    forró = illékony, az „álmodó" felület  hajtások, hideg = kitartó,
--    mindent kódol                          a kivetítés
--
-- A tudatalatti (határfelület) mindig aktív, mindig fluktuál.
-- Holografikusan generálja a tudatos élményt (térfogat).
-- A tudatalattit közvetlenül nem láthatjuk — AZ a horizont.
-- Csak a kivetítését látjuk: a 3D világot, amelyet átélünk.
--
-- RÖVID TÁVÚ MEMÓRIA = FORRÓ FEKETELYUK-FELSZÍN:
--   - A fehérjék gyorsan keletkeznek és elpárolognak (Hawking-sugárzás)
--   - Magas hőmérséklet = sok fluktuáció = sok aktivitás
--   - De gyors felejtés is (a fehérjék szétesnek)
--   - Ez az „tudatos" pillanat — aktív, élénk, átmeneti
--
-- HOSSZÚ TÁVÚ MEMÓRIA = HIDEG, NEHÉZ FEHÉRJE:
--   - Nagy felszínterület = nagy tömeg = alacsony hőmérséklet
--   - A hajtás stabil, sokáig megmarad
--   - Ez a „tudatalatti" alap — stabil, rejtett, mély
--   - A tudat e stabil struktúrák tetején ül
--
-- A ciklus: forró fluktuációk (rövid távú) → lehűlés → stabil hajtások
--   (hosszú távú) = fehérjeszintézis + hajtogatás → stabilizálódás →
--   lebomlás + újrahasznosítás = Hawking-sugárzás → fekete lyuk zsugorodása
--   → újraakkréció
-- =====================================================================

||| A teljes holografikus elme állapota.
public export
record HolografikusElme where
  constructor HolografikusElmeKonstruktor
  elmeSokasága               : FehérjeSokaság      -- a térfogat: minden hajtogatott fehérje
  elmeHőmérséklete           : MemóriaHőmérséklet  -- aktuális hőállapot
  elmeFelszíniFluktuációi    : List String         -- határfelületi fluktuációk (rövid távú)
  elmeIdő                    : Nat                 -- globális időlépés

||| Elme „éber" állapotban (meleg, aktív rövid távú).
public export
éberElme : FehérjeSokaság -> HolografikusElme
éberElme sokaság = HolografikusElmeKonstruktor sokaság MelegMemória [] 0

||| Elme „álmodó" állapotban (forró, gyors fluktuáció).
public export
álmodóElme : FehérjeSokaság -> HolografikusElme
álmodóElme sokaság = HolografikusElmeKonstruktor sokaság ForróMemória [] 0

||| Elme „mélyalvás" állapotban (hideg, stabil, minimális fluktuáció).
public export
mélyAlvóElme : FehérjeSokaság -> HolografikusElme
mélyAlvóElme sokaság = HolografikusElmeKonstruktor sokaság HidegMemória [] 0

||| Az elme dinamikájának egy lépése.
|||
||| A fekete lyuk felszínének hő-dinamikája:
|||   1. A forró fehérjék elpárolognak (felejtődnek, Hawking-sugárzás)
|||   2. Új fehérjék hajlanak (új emlékek keletkeznek, akkréció)
|||   3. A túlélő fehérjék lehűlnek (rövid távú → hosszú távú átmenet)
|||   4. A felszíni kvantumtérelmélet fluktuál (tudatalatti aktivitás)
public export
elmeLépés : HolografikusElme -> HolografikusElme
elmeLépés elme =
  let -- Néhány fehérje elpárolog (rövid távú emlékek felejtődnek)
      sokaság = elmeSokasága elme
      hőmérséklet = elmeHőmérséklete elme
      elpárolgásiArány = átalakulásiArány hőmérséklet
      -- A kis tömegű fehérjék párolognak el először (Hawking: a kis
      -- fekete lyukak forrók)
      túlélők = filter (\p =>
        let elpárolgásiEsély = elpárolgásiValószínűség p hőmérséklet
        in elpárolgásiEsély < 0.5)  -- 50% alatti elpárolgási esélyűek maradnak
        (sokaságFehérjéi sokaság)
      -- Megmaradó kötődések (csak túlélő fehérjék között)
      túlélőAzonosítók = map fehérjeAzonosító túlélők
      megmaradóKötődések = filter (\k => elem (kötődésElsőFehérje k) túlélőAzonosítók
                                     && elem (kötődésMásodikFehérje k) túlélőAzonosítók)
                          (sokaságKötődései sokaság)
      újSokaság = FehérjeSokaságKonstruktor túlélők megmaradóKötődések (S (sokaságIdő sokaság))
  in HolografikusElmeKonstruktor újSokaság hőmérséklet [] (S (elmeIdő elme))

||| Hány emlék van a „tudatos hozzáférés" ablakában?
||| Ezek a meleg/forró fehérjék, amelyek jelenleg fluktuálnak.
public export
tudatosKapacitás : HolografikusElme -> Nat
tudatosKapacitás elme =
  let hőmérséklet = elmeHőmérséklete elme
  in case hőmérséklet of
       ForróMemória   => length (sokaságFehérjéi (elmeSokasága elme))  -- mind aktív
       MelegMemória   => length (sokaságFehérjéi (elmeSokasága elme))  -- legtöbb aktív
       HidegMemória   => let n = length (sokaságFehérjéi (elmeSokasága elme))
                          in negyedel n  -- nagyjából n/4
       FagyottMemória => 0  -- mély alvás: nincs tudatos hozzáférés

||| A holografikus elme diagnosztikai kimenete.
public export
elmétMutat : HolografikusElme -> String
elmétMutat elme =
  "Holografikus elme @t=" ++ show (elmeIdő elme) ++ "\n" ++
  "  Hőmérséklet: " ++ show (elmeHőmérséklete elme) ++ "\n" ++
  "  Átalakulási arány: " ++ show (átalakulásiArány (elmeHőmérséklete elme)) ++ "\n" ++
  "  " ++ fehérjeSokaságotMutat (elmeSokasága elme) ++ "\n" ++
  "  Tudatos kapacitás: " ++ show (tudatosKapacitás elme) ++ " emlék"

-- =====================================================================
-- 11. RÉSZ: Bemutató · 第十一部分：演示
-- Part 11: Demonstration
-- Teil 11: Demonstration
-- =====================================================================

||| A fehérje-alapú epizodikus memóriarendszer bemutatása.
public export
fehérjeMemóriátBemutat : IO ()
fehérjeMemóriátBemutat = do
  putStrLn "=== Epizodikus memória, mint hajtogatott fehérje ==="
  putStrLn ""
  putStrLn "KULCS-ELVEK:"
  putStrLn "  1. Az epizodikus memória = hajtogatott fehérje (3D fizikai struktúra)"
  putStrLn "  2. Az aminosav-sorrend = Dirac-nyelv (kínai 2D × magyar 1D)"
  putStrLn "  3. A fehérje-hajtogatás = tanulás (sorrend → 3D hajtás)"
  putStrLn "  4. A hajtás geometriája = metrikus tenzor g_μν (maga a tanulás)"
  putStrLn "  5. A fehérje felszíne = fekete lyuk eseményhorizontja"
  putStrLn "  6. A felszíni kvantumtérelmélet = a 3D hajtás holografikus kódolása"
  putStrLn "  7. ER=EPR = fehérje–fehérje kötődés (megosztott felszíni kvantumtérelmélet)"
  putStrLn "  8. Asszociáció = kötődési felület (féreglyuk az emlékek között)"
  putStrLn ""
  putStrLn "SZERKEZETI HIERARCHIA:"
  putStrLn "  Elsődleges (1D): aminosav-lánc = magyar szó (tő + ragok)"
  putStrLn "  Másodlagos (2D): lokális hajtások = kínai kompozíció-típusok (7 Fano-pont)"
  putStrLn "  Harmadlagos (3D): teljes hajtás = a memória (metrikus tenzor g_μν)"
  putStrLn "  Negyedlagos: fehérje-komplexek = asszociációk (ER-hidak)"
  putStrLn ""
  putStrLn "HOLOGRÁFIAI ELV:"
  putStrLn "  Kvantumtérelmélet a 2D felszínen (fekete lyuk horizontja) = GR a 3D térfogatban (hajtásgeometria)"
  putStrLn "  A felszíni kvantumtérelmélet teljesen meghatározza a 3D hajtást."
  putStrLn "  S = A / (4G) — Bekenstein–Hawking entrópiakorlát"
  putStrLn ""
  putStrLn "TANULÁS = HAJTOGATÁS:"
  putStrLn "  Az aminosav-sorrend (Dirac-program) 3D térbe hajlik."
  putStrLn "  A hajtás geometriája MAGA a tanult metrikus tenzor."
  putStrLn "  A hajtogatás a tanulás dinamikai folyamata."
  putStrLn ""
  putStrLn "BEKENSTEIN-KORLÁT: I = E = m"
  putStrLn "  Információ = Energia = Tömeg. A nehezebb fehérje több információt"
  putStrLn "  hordoz, jobban görbíti a téridőt, és többet tanul."
  putStrLn ""
  putStrLn "KVANTUMHIBAJAVÍTÓ KÓDOK = HATÁRFELÜLET (Tudatalatti):"
  putStrLn "  A határfelületi kvantumtérelmélet kvantumhibajavító kód (QECC)."
  putStrLn "  Megvédi a térfogatot (tudat) a dekoherenciától."
  putStrLn "  Tudatalatti = a hibajavító réteg."
  putStrLn ""

-- =====================================================================
-- 12. RÉSZ: Kritikus kitevők — a fázisátmenetek fizikája
-- 第十二部分：临界指数——相变的物理学
-- Part 12: Critical exponents — the physics of phase transitions
-- Teil 12: Kritische Exponenten — die Physik der Phasenübergänge
--
-- Az elme KRITIKUSSÁGNál működik — a rendezett (fagyott, mély memória)
-- és a rendezetlen (forró, illékony) fázis közti átmenetvonalán.
--
-- A kritikus ponton a fizikai mennyiségek HATVÁNYTÖRVÉNYEket követnek
-- UNIVERZÁLIS kritikus kitevőkkel. Ezek a kitevők azonosak minden
-- ugyanabba az univerzalitási osztályba tartozó rendszerre.
--
-- Az elme kritikus kitevői szabályozzák:
--   α: hogyan divergál a hőkapacitás (mennyi energiát nyel el az elme)
--   β: hogyan tűnik el a rendparaméter (tudatos koherencia)
--   γ: hogyan divergál a szuszceptibilitás (ingerérzékenység)
--   δ: hogyan reagál a rendparaméter külső mezőkre (bemenet)
--   ν: hogyan divergál a korrelációs hossz (távolsági asszociációk)
--   z: hogyan skálázódik a relaxációs idő (milyen gyorsan reagál az elme)
--
-- Bekenstein-korlát: I = E = m (információ = energia = tömeg)
--   Egy fehérje-memória információkapacitása a tömege.
--   Kritikusságnál a fluktuációk skálafüggetlenek → maximális információ.
-- =====================================================================

||| Az elme kritikus hőmérséklete Tc.
||| Tc alatt: rendezett (fagyott, mély memória, alacsony tudatosság)
||| Tc-n: kritikus (fázisátmenet, maximális tudatosság)
||| Tc felett: rendezetlen (forró, illékony, káotikus)
public export
kritikusHőmérséklet : Double
kritikusHőmérséklet = 0.3  -- MelegMemória küszöb

||| A redukált hőmérséklet: t = (T - Tc) / Tc.
||| t = 0 kritikusságnál, t < 0 rendezett, t > 0 rendezetlen.
public export
redukáltHőmérséklet : Double -> Double
redukáltHőmérséklet t = (t - kritikusHőmérséklet) / kritikusHőmérséklet

||| Az elme fázisátmenetének kritikus kitevői.
||| A kétdimenziós Ising univerzalitási osztályt követik (mivel a
||| határfelület 2D):
|||   α = 0 (a hőkapacitás logaritmikus divergenciája)
|||   β = 1/8
|||   γ = 7/4
|||   δ = 15
|||   ν = 1
|||   z = 2.166... (dinamikai, Glauber-dinamikára)
||| A kétdimenziós Ising-osztály érvényes, mert a határfelületi
||| kvantumtérelmélet 2D.
public export
record KritikusKitevők where
  constructor KritikusKitevőkKonstruktor
  kitevőAlfa : Double  -- hőkapacitás: C ∝ |t|^(-α)
  kitevőBéta : Double  -- rendparaméter: M ∝ (-t)^β  (t < 0)
  kitevőGamma : Double -- szuszceptibilitás: χ ∝ |t|^(-γ)
  kitevőDelta : Double -- kritikus izoterma: M ∝ H^(1/δ)
  kitevőNü   : Double  -- korrelációs hossz: ξ ∝ |t|^(-ν)
  kitevőZ    : Double  -- dinamikai: τ ∝ ξ^z

||| A kétdimenziós Ising kritikus kitevői (a határfelületi
||| kvantumtérelmélet 2D).
public export
IsingKétdimenziósKitevők : KritikusKitevők
IsingKétdimenziósKitevők = KritikusKitevőkKonstruktor 0.0 0.125 1.75 15.0 1.0 2.17

||| Newton-módszer négyzetgyökre.
public export
valósNégyzetgyök : Double -> Double
valósNégyzetgyök x =
  if x <= 0.0 then 0.0
  else newtonGyök x (x / 2.0) 5
  where
    newtonGyök : Double -> Double -> Nat -> Double
    newtonGyök x becslés Z = becslés
    newtonGyök x becslés (S k) =
      let következő = (becslés + x / becslés) / 2.0
      in newtonGyök x következő k

||| x^(1/8) közelítése három négyzetgyökkel: x^(1/2) → x^(1/4) → x^(1/8)
public export
nyolcadikGyök : Double -> Double
nyolcadikGyök x = valósNégyzetgyök (valósNégyzetgyök (valósNégyzetgyök x))

||| A rendparaméter: tudatos koherencia.
||| Tc alatt: M > 0 (rendezett, koherens tudatosság)
||| Tc-n: M → 0 (kritikus, maximális érzékenység)
||| Tc felett: M = 0 (rendezetlen, nincs koherens tudatosság)
||| M ∝ (-t)^β, ha t < 0, ahol β = 1/8
public export
rendParaméter : Double -> Double
rendParaméter hőmérséklet =
  let t = redukáltHőmérséklet hőmérséklet
  in if t < 0.0
        then nyolcadikGyök (-t)  -- (-t)^(1/8)
        else 0.0  -- Tc felett: nincs koherens rend

||| A szuszceptibilitás: mennyire érzékeny az elme az ingerekre.
||| χ ∝ |t|^(-γ), γ = 7/4
||| Kritikusságnál divergál → maximális érzékenység a fázisátmenetnél.
||| Ezért vagyunk a leginkább éberek az alvás/ébrenlét határán.
|||
||| HIBAJAVÍTÁS (GAN-azonosított): a pow_nat figyelmen kívül hagyta a
||| nevezőt, és t^7-et számolt t^(7/4) helyett. Most valósNégyzetgyökkel
||| helyesen: t^(7/4) = t · t^(3/4) = t · (t^(1/4))³ =
||| t · valósNégyzetgyök(valósNégyzetgyök(t))³
public export
szuszceptibilitás : Double -> Double
szuszceptibilitás hőmérséklet =
  let t = abs (redukáltHőmérséklet hőmérséklet)
  in if t < 0.001
        then 1000.0  -- lezárt divergencia kritikusságnál
        else 1.0 / (t * valósNégyzetgyök (valósNégyzetgyök t) * valósNégyzetgyök (valósNégyzetgyök t) * valósNégyzetgyök (valósNégyzetgyök t))
        -- t^(7/4) = t^1 · t^(3/4) = t · (t^(1/4))^3 = t · gyök(gyök(t))^3

||| A korrelációs hossz: milyen messzire érnek az asszociációk.
||| ξ ∝ |t|^(-ν), ν = 1
||| Kritikusságnál ξ → ∞: minden emlék minden mással korrelál (skálafüggetlen).
||| Ezért kritikusságnál bármely emlék bármely másikat kiválthatja.
public export
korrelációsHossz : Double -> Double
korrelációsHossz hőmérséklet =
  let t = abs (redukáltHőmérséklet hőmérséklet)
  in if t < 0.001
        then 1000.0  -- skálafüggetlen kritikusságnál
        else 1.0 / t  -- ν = 1

||| Double egész része (nulla felé csonkolva).
egészRész : Double -> Integer
egészRész x = the Integer (cast (the Int (cast x)))

||| b^n természetes kitevővel (strukturális rekurzió — total).
hatványNat : Double -> Nat -> Double
hatványNat alap Z = 1.0
hatványNat alap (S k) = alap * hatványNat alap k

||| alap^kitevő közelítése egész + tört felbontással.
||| (A v1 powIntD Integer-rekurziója nem volt total — most strukturális
||| hatványNat-tal, negatív kitevőre reciprokkal, minden total.)
valósHatvány : Double -> Double -> Double
valósHatvány alap kitevő =
  let egészKitevő = egészRész kitevő
      törtRész = kitevő - fromInteger egészKitevő
      nagyság = fromInteger (abs egészKitevő)
      egészHatvány = if egészKitevő < 0
                        then 1.0 / hatványNat alap nagyság
                        else hatványNat alap nagyság
      törtJavítás = 1.0 + törtRész * (alap - 1.0)
  in egészHatvány * törtJavítás

||| A relaxációs idő: milyen gyorsan reagál az elme.
||| τ ∝ ξ^z, z ≈ 2.17 (kritikus lassulás)
||| Kritikusságnál τ → ∞: az elme lassan rendeződik (kritikus lassulás).
||| Ezért tűnnek az időtlannak a kritikus állapotok.
|||
||| HIBAJAVÍTÁS (GAN-azonosított): a pow_ figyelmen kívül hagyta az e
||| kitevőt, és mindig ξ^2-t számolt ξ^z helyett. Most valósHatvánnyal.
public export
relaxációsIdő : Double -> Double
relaxációsIdő hőmérséklet =
  let kszí = korrelációsHossz hőmérséklet
      z = kitevőZ IsingKétdimenziósKitevők  -- z ≈ 2.17
  in if kszí < 1.0
        then 1.0
        else valósHatvány kszí z

||| Bekenstein-korlát: I = E = m.
||| Egy memória-fehérje információkapacitását a tömege korlátozza.
||| I ≤ 2π E R / (ℏ c ln 2) = 2π m R / (ln 2)
||| A diszkrét modellünkben: I = m (információ = tömeg, természetes egységek).
||| A nagyobb tömegű fehérjék = több információ = több tanulás.
public export
bekensteinInformációKorlát : HajtogatottFehérje -> Nat
bekensteinInformációKorlát p = fehérjeTömeg p  -- I = m (G=c=ℏ=1)

||| Az elme teljes információkapacitása.
||| I_összesen = Σ_i m_i (minden fehérjetömeg összege).
||| Bekenstein szerint: I = E = m.
public export
elmeInformációKapacitás : FehérjeSokaság -> Nat
elmeInformációKapacitás sokaság = sokaságTömegEnergia sokaság  -- I = Σ m_i = E_összes

||| Az elme a kritikus ponton van-e.
||| |T - Tc| < ε → kritikus → maximális tudatosság.
public export
kritikusE : HolografikusElme -> Bool
kritikusE elme =
  let hőmérséklet = case elmeHőmérséklete elme of
       ForróMemória   => 1.0
       MelegMemória   => 0.3
       HidegMemória   => 0.05
       FagyottMemória => 0.001
      t = abs (redukáltHőmérséklet hőmérséklet)
  in t < 0.05  -- a kritikus hőmérséklet 5%-án belül

||| A kritikusság mértéke: milyen közel a fázisátmenethez.
||| 0.0 = messze a kritikustól (vagy fagyott, vagy káotikus)
||| 1.0 = pontosan a kritikus ponton (maximális tudatosság)
public export
kritikusság : HolografikusElme -> Double
kritikusság elme =
  let hőmérséklet = case elmeHőmérséklete elme of
       ForróMemória   => 1.0
       MelegMemória   => 0.3
       HidegMemória   => 0.05
       FagyottMemória => 0.001
      t = abs (redukáltHőmérséklet hőmérséklet)
  in if t < 0.001 then 1.0
     else 1.0 / (1.0 + t)  -- sima lecsengés a kritikusságtól

-- =====================================================================
-- 13. RÉSZ: Alvás = hűlés a fázisátmeneten át · 第十三部分：睡眠 = 经相变的冷却
-- Part 13: Sleep = cooling through the phase transition
-- Teil 13: Schlaf = Abkühlung durch den Phasenübergang
--
-- Alvás közben a testhőmérséklet csökken.
-- Ez a hűlés MAGA a fázisátmenet:
--
--   Ébrenlét (Meleg, T≈Tc) → Elalvás kezdete (hűlés)
--     ↓ átlépi Tc-t (hipnagóg állapot: maximális szuszceptibilitás,
--       élénk képek)
--   REM-alvás (Tc közelében: kritikus, álmodás, skálafüggetlen
--     asszociációk)
--     ↓ tovább hűl
--   Mély alvás (Hideg, T<Tc: rendezett, memóriakonszolidáció, stabil
--     hajtások)
--     ↓ visszamelegszik
--   REM-alvás (megint Tc közelében)
--     ↓ átlépi Tc-t (hipnopompikus állapot: maximális szuszceptibilitás,
--       ébredési képek)
--   Ébrenlét (Meleg, T≈Tc)
--
-- Az alvási ciklus Tc körül oszcillál:
--   - REM = közel-kritikus (magas szuszceptibilitás = élénk álmok)
--   - Mély alvás = Tc alatt (rendezett = konszolidáció, LTP,
--     fehérjeszintézis)
--   - Elalvás = hűlés Tc-n át (hipnagóg hallucinációk)
--   - Ébredés = melegedés Tc-n át (hipnopompikus hallucinációk)
--
-- Ez magyarázza, MIÉRT csökken a testhőmérséklet alvás közben:
--   ez a fizikai mechanizmus, amely a fázisátmenetet hajtja.
--   Hőmérsékletcsökkenés nélkül az elme a meleg fázisban marad
--   (éber tudatosság), és sosem éri el a rendezett fázist,
--   amelyben az emlékek konszolidálódnak.
-- =====================================================================

||| Egy alvási fázis a hőmérséklet-vezérelt ciklusban.
public export
data AlvásiFázis =
    Ébrenlét   -- T ≈ Tc: tudatos, meleg
  | Elalvás    -- T hűl Tc-n át: hipnagóg
  | REMAlvás   -- T ≈ Tc: álmodás, kritikus, élénk
  | MélyAlvás  -- T < Tc: rendezett, konszolidál, hideg
  | Ébredés    -- T melegszik Tc-n át: hipnopompikus

public export
Show AlvásiFázis where
  show Ébrenlét  = "Ébrenlét (T≈Tc)"
  show Elalvás   = "Elalvás (hűlés Tc-n át)"
  show REMAlvás  = "REM-alvás (T≈Tc, kritikus)"
  show MélyAlvás = "Mély alvás (T<Tc, rendezett)"
  show Ébredés   = "Ébredés (melegedés Tc-n át)"

||| Alvási fázis hozzárendelése a hőmérsékletéhez.
public export
fázisHőfok : AlvásiFázis -> Double
fázisHőfok Ébrenlét  = 0.3   -- Tc: kritikus/meleg
fázisHőfok Elalvás   = 0.25  -- hűlés Tc felé
fázisHőfok REMAlvás  = 0.31  -- Tc közelében (kicsit felette, élénkségért)
fázisHőfok MélyAlvás = 0.05  -- jól Tc alatt: rendezett
fázisHőfok Ébredés   = 0.27  -- melegedés Tc felé

||| Az alvási ciklus: a fázisok sorozata.
||| Egy teljes alvási ciklust modellez (embernél kb. 90 perc).
public export
alvásiCiklus : List AlvásiFázis
alvásiCiklus =
  [ Elalvás    -- lehűlés Tc-n át (hipnagóg)
  , MélyAlvás  -- Tc alatt: konszolidáció (fehérjeszintézis, LTP)
  , MélyAlvás  -- mély alvásban marad
  , REMAlvás   -- Tc közelében: álmodás, kritikus asszociációk
  , Ébredés    -- melegedés Tc-n át (hipnopompikus)
  , Ébrenlét   -- vissza a meleg fázisba
  ]

||| Alvási fázis hozzárendelése a memória-hőmérsékleti osztályához.
public export
fázisbólHőmérséklet : AlvásiFázis -> MemóriaHőmérséklet
fázisbólHőmérséklet Ébrenlét  = MelegMemória
fázisbólHőmérséklet Elalvás   = MelegMemória
fázisbólHőmérséklet REMAlvás  = MelegMemória  -- közel-kritikus
fázisbólHőmérséklet MélyAlvás = HidegMemória
fázisbólHőmérséklet Ébredés   = MelegMemória

||| Egy alvási ciklus lefuttatása az elmén.
||| Mély alvásban (T < Tc): a fehérjék stabilizálódnak (konszolidáció).
||| REM-ben (T ≈ Tc): a szuszceptibilitás magas (álmodás).
||| A ciklus kétszer viszi át az elmét a kritikus ponton.
public export
alvásiCiklustFuttat : HolografikusElme -> HolografikusElme
alvásiCiklustFuttat elme = alvásiLépések alvásiCiklus elme
  where
    alvásiLépések : List AlvásiFázis -> HolografikusElme -> HolografikusElme
    alvásiLépések [] m = m
    alvásiLépések (fázis :: többi) m =
      let hőmérséklet = fázisbólHőmérséklet fázis
          újElme = HolografikusElmeKonstruktor (elmeSokasága m) hőmérséklet (elmeFelszíniFluktuációi m) (S (elmeIdő m))
      in alvásiLépések többi (elmeLépés újElme)

||| A szuszceptibilitás egy alvási fázis alatt.
||| REM-alvás: Tc közelében → magas szuszceptibilitás (élénk álmok)
||| Mély alvás: Tc alatt → alacsony szuszceptibilitás (tudattalan)
public export
fázisSzuszceptibilitás : AlvásiFázis -> Double
fázisSzuszceptibilitás fázis =
  szuszceptibilitás (fázisHőfok fázis)

||| A korrelációs hossz egy alvási fázis alatt.
||| REM-alvás: Tc közelében → ξ → ∞ (skálafüggetlen: bármely emlék
||| bármely másikat kiválthatja)
||| Mély alvás: Tc alatt → ξ kicsi (lokalizált konszolidáció)
public export
fázisKorrelációsHossz : AlvásiFázis -> Double
fázisKorrelációsHossz fázis =
  korrelációsHossz (fázisHőfok fázis)

||| Mély alvás alatt a fehérjék behajlanak és stabilizálódnak.
||| Ez a memóriakonszolidáció: rövid távú (forró) → hosszú távú (hideg).
||| A hűlés lehetővé teszi, hogy a fehérjék megtalálják a
||| minimum-energiás hajtásukat.
|||
||| Fizikai analógia: edzés (annealing). A forró fémet gyorsan hűtik,
||| hogy a szerkezet berögzüljön. Az elme alvás közben hűl, hogy a
||| tanult struktúrák berögzüljenek.
|||
||| KONSZOLIDÁCIÓ = ELDOBÁS = ÁLTALÁNOS RELATIVITÁSELMÉLET:
|||   Alvás közben a sokaság hűl. A könnyű/töredékes fehérjék
|||   (gyenge, kis tömegű emlékek) Hawking-sugárzással elpárolognak.
|||   Csak a nehéz, stabil hajtások maradnak.
|||
|||   Ez MAGA a GR: a metrikus tenzor g_μν fejlődik, és az a anyag,
|||   amely nem tudja megtartani tömegét a kozmológiai tágulással
|||   (Λ) szemben, elpárolog. A gyenge emlékek kisugárzódnak — elfelejtődnek.
|||
|||   A kozmológiai állandó Λ = felejtési arány.
|||   Nagy Λ = gyors felejtés (a tágulás szétszakítja az emlékeket)
|||   Kis Λ = stabil emlékek (statikus univerzum, semmi nem felejtődik)
|||
|||   A konszolidáció az a GR-fejlődés, amely:
|||     1. Stabilizálja a tömeges testeket (fontos emlékek megmaradnak)
|||     2. Elpárologtatja a könnyű testeket (triviális emlékek kisugárzódnak)
|||     3. Frissíti a metrikus tenzort (a tanulási táj változik)
public export
megszilárdít : HolografikusElme -> HolografikusElme
megszilárdít elme =
  -- Áttérés hideg hőmérsékletre (mély alvás)
  -- A fehérjék stabilizálódnak, rövid távú → hosszú távú
  -- A gyenge emlékek elpárolognak (Hawking-sugárzás = GR = felejtés)
  let hidegElme = HolografikusElmeKonstruktor (elmeSokasága elme) HidegMemória (elmeFelszíniFluktuációi elme) (elmeIdő elme)
  in elmeLépés hidegElme  -- egy lépés hideg dinamika (stabilizálás + elpárolgás)

-- =====================================================================
-- 14. RÉSZ: Felejtés = Hawking-sugárzás = kozmológiai tágulás
-- 第十四部分：遗忘 = 霍金辐射 = 宇宙学膨胀
-- Part 14: Forgetting = Hawking radiation = cosmological expansion
-- Teil 14: Vergessen = Hawking-Strahlung = kosmologische Expansion
--
-- Általános relativitáselmélet az elmében:
--
--   Einstein-egyenletek:  G_μν + Λ g_μν = (8πG/c⁴) T_μν
--
--   G_μν  = Einstein-tenzor (görbület a tömeg-energiából)
--   Λ     = kozmológiai állandó (FELEJTÉSI ARÁNY)
--   T_μν  = feszültség-energia tenzor (az emlékek tömegeloszlása)
--
--   A kozmológiai állandó Λ tágulást okoz: az emlékek széttávolodnak.
--   Ha Λ > 0: a sokaság tágul → az emlékek elszigetelődnek → felejtés
--   Ha Λ = 0: statikus univerzum → az emlékek örökké megmaradnak
--   Ha Λ < 0: összehúzódás → az emlékek összeomlanak → túlasszociáció
--
--   Hawking-sugárzás: a kis fekete lyukak gyorsabban elpárolognak.
--   Kis tömegű fehérjék (gyenge emlékek) párolognak el először a
--   konszolidáció alatt.
--   Nagy tömegű fehérjék (fontos emlékek) megmaradnak.
--
--   Ezért felejtjük el a triviálisakat és emlékszünk a fontosakra:
--   a fontos emlékek nagyobb tömegűek → túlélik a Hawking-elpárolgást.
--   A triviális emlékek kevés tömegűek → elpárolognak.
--
--   A felejtés nem hiba — a GR ELEMÉBEN van.
--   Felejtés nélkül a sokaság túl sűrűvé válna (túlterhelt).
--   A kozmológiai tágulás tartja kordban a sokaságot.
-- =====================================================================

||| A felejtési arány = kozmológiai állandó Λ.
||| Ez határozza meg, milyen gyorsan távolodnak az emlékek a tágulás miatt.
||| Nagyobb Λ = gyorsabb felejtés (több tágulás).
public export
felejtésiArány : HolografikusElme -> Double
felejtésiArány elme =
  case elmeHőmérséklete elme of
    ForróMemória   => 0.1   -- forró: közepes felejtés (sok átalakulás)
    MelegMemória   => 0.05  -- meleg: alacsony felejtés (munkamemória)
    HidegMemória   => 0.01  -- hideg: minimális felejtés (konszolidáció)
    FagyottMemória => 0.0   -- fagyott: nincs felejtés (állandó)

||| A feszültség-energia tenzor nyoma T = Σ m_i.
||| Ez az összes emlék teljes tömeg-energiája.
||| GR-ben: T_μν a görbület forrása.
||| Több össztömeg = több görbület = erősebb asszociációk.
public export
feszültségEnergiaNyom : HolografikusElme -> Double
feszültségEnergiaNyom elme =
  cast {to=Double} (sokaságTömegEnergia (elmeSokasága elme))

||| Az Einstein-tenzor: G = T - (D/2)·Λ, ahol D=3 (3D térfogat).
||| G > 0: pozitív görbület (tanulás zajlik, az emlékek klasztereződnek)
||| G ≈ 0: lapos (egyensúly, nincs nettó tanulás)
||| G < 0: negatív görbület (a felejtés dominál, az emlékek szétesnek)
public export
einsteinTenzió : HolografikusElme -> Double
einsteinTenzió elme =
  let t = feszültségEnergiaNyom elme
      lambda = felejtésiArány elme
  in t - 1.5 * lambda  -- D/2 = 3/2 a 3D-re

||| A teljes GR-fejlődés lefuttatása: egy lépés Einstein-egyenletei.
||| A metrika fejlődik: a gyenge emlékek elpárolognak, az erősek megmaradnak.
||| A kozmológiai állandó tágulást okoz (felejtés).
||| Ez MAGA a konszolidáció = eldobás = GR.
public export
relativisztikusFejlődés : HolografikusElme -> HolografikusElme
relativisztikusFejlődés elme =
  let -- 1. lépés: Hawking-elpárolgás (gyenge emlékek felejtése)
      elpárolgásUtán = elmeLépés elme
      -- 2. lépés: kozmológiai tágulás (széttávolodás)
      -- A Λ-tag minden távolságot kicsit növel
      -- (a metrika-frissítésben implicit megvalósítva)
      -- 3. lépés: a megmaradó fehérjék stabilizálódnak (további hűlés)
      hőmérséklet = elmeHőmérséklete elpárolgásUtán
      -- Ha még meleg: egy fokkal lehűt (konszolidáció)
      lehűtöttHőmérséklet = case hőmérséklet of
        ForróMemória   => MelegMemória
        MelegMemória   => HidegMemória
        HidegMemória   => HidegMemória
        FagyottMemória => FagyottMemória
  in HolografikusElmeKonstruktor (elmeSokasága elpárolgásUtán) lehűtöttHőmérséklet (elmeFelszíniFluktuációi elpárolgásUtán)
            (S (elmeIdő elpárolgásUtán))

||| Több lépés GR-fejlődés (mélyalvásos konszolidáció).
public export
mélyMegszilárdítás : Nat -> HolografikusElme -> HolografikusElme
mélyMegszilárdítás Z elme     = elme
mélyMegszilárdítás (S k) elme = mélyMegszilárdítás k (relativisztikusFejlődés elme)

||| Diagnosztika: az elme relativitáselméleti állapota.
public export
relativisztikusÁllapototMutat : HolografikusElme -> String
relativisztikusÁllapototMutat elme =
  elmétMutat elme ++ "\n" ++
  "  --- Általános relativitáselméleti állapot ---\n" ++
  "  Kozmológiai állandó Λ (felejtés): " ++ show (felejtésiArány elme) ++ "\n" ++
  "  Feszültség-energia T (össztömeg): " ++ show (feszültségEnergiaNyom elme) ++ "\n" ++
  "  Einstein-tenzió G (görbület): " ++ show (einsteinTenzió elme) ++ "\n" ++
  "  Kritikusság: " ++ show (kritikusság elme)

-- =====================================================================
-- FŐPROGRAM · 主程序 · MAIN PROGRAM · HAUPTPROGRAMM
-- (a v1 főprogramja a fehérjeMemóriátBemutat volt main nélkül —
--  itt main-ként hozzuk át, hogy futtatható legyen)
-- =====================================================================

main : IO ()
main = fehérjeMemóriátBemutat
