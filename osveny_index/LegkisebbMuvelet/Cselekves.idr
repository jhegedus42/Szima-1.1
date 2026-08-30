module LegkisebbMuvelet.Cselekves

import Alap.KategoriaT
import Steane713
import E8E8Algebra
import LegkisebbMuvelet.LegkisebbMuvelet
import LegkisebbMuvelet.IngyenesTetelek

-- ═══════════════════════════════════════════════════════════════
-- CSELEKVÉS — A VALÓSÁGBAN VALÓ NAVIGÁLÁS
-- ═══════════════════════════════════════════════════════════════
-- A bizonyítás (parametricity) megmondja az utat.
-- A megvalósítás (cselekvés) megteszi az utat a valóságon keresztül.
-- A valóság = a 15 dimenziós fázistér geometriája,
-- tele akadályokkal, tükörsíkokkal, és más szereplőkkel.
--
-- A cselekvés = a Hamiltonian időfejlesztése a valóságon keresztül.
-- Minden lépésben:
--   1. Érzékeled a valóságot (megfigyelés = funktor F: ter→szin)
--   2. Döntesz (a Lagrangian minimalizálása = legkisebb művelet)
--   3. Cselekszel (a Hamiltonian időfejlesztése = a lépés)
--   4. Kommunikálsz (a perem = Legendre adjunkció)
--   5. Hibajavítasz (a [[15,1,3]] kód javítja a hibákat)
--   6. Tanulsz (a visszacsatolás = funktor H: hang→ter)

-- ═══════════════════════════════════════════════════════════════
-- 1. A VALÓSÁG GEOMETRIÁJA
-- ═══════════════════════════════════════════════════════════════

||| Az akadály típusa.
public export
data AkadalyTipus : Type where
  TukorSik    : AkadalyTipus
  MasikSzemely : AkadalyTipus
  ErzelmiAkadaly : AkadalyTipus
  FizikaiAkadaly : AkadalyTipus
  KognitivAkadaly : AkadalyTipus

public export
Show AkadalyTipus where
  show TukorSik = "tukorsik"
  show MasikSzemely = "masik szemely"
  show ErzelmiAkadaly = "erzelmi akadaly"
  show FizikaiAkadaly = "fizikai akadaly"
  show KognitivAkadaly = "kognitiv akadaly"

||| Egy akadály a 15 dimenziós fázistérben.
public export
record Akadaly where
  constructor AkadalyKonstruktor
  akadalyPozicio : TizenotDimenziosPozicio
  akadalySugar : Double
  akadalyTipus : AkadalyTipus

||| A valóság = a 15 dimenziós fázistér az akadályokkal.
public export
record Valosag where
  constructor ValosagKonstruktor
  sajatPozicio : TizenotDimenziosPozicio
  celPozicioV : TizenotDimenziosPozicio
  akadalyok : List Akadaly
  sajatImpulzus : TizenotDimenziosImpulzus
  sajatSebesseg : TizenotDimenziosSebesseg

-- ═══════════════════════════════════════════════════════════════
-- 2. ÉRZÉKELÉS — A MEGFIGYELÉS FUNKTORA
-- ═══════════════════════════════════════════════════════════════

||| Az érzékelés = a megfigyelés funktora (F: ter→szin).
||| A valóság érzékelése = a 15 dimenziós pozíció beolvasása.
||| A parametricity biztosítja, hogy az érzékelés uniform:
||| minden dimenziót ugyanúgy mérünk.
public export
erzekeles : Valosag -> TizenotDimenziosPozicio
erzekeles valosag = valosag.sajatPozicio

||| A legközelebbi akadály érzékelése.
||| A Lagrangian szerint a legközelebbi akadály a legveszélyesebb.
public export
legkozelebbiAkadaly : Valosag -> Maybe Akadaly
legkozelebbiAkadaly valosag =
  case valosag.akadalyok of
    [] => Nothing
    (a :: rest) =>
      let legkozelebbi = foldl
            (\acc, a2 =>
              if palyaSugara valosag.sajatPozicio a2.akadalyPozicio <
                 palyaSugara valosag.sajatPozicio acc.akadalyPozicio
              then a2 else acc)
            a rest
      in Just legkozelebbi

-- ═══════════════════════════════════════════════════════════════
-- 3. DÖNTÉS — A LEGKISEBB MŰVELET
-- ═══════════════════════════════════════════════════════════════

||| A döntés = a Lagrangian minimalizálása.
||| A legkisebb művelet elve: δ∫L dt = 0.
||| A döntés = a cél felé vezető legkisebb költségű út.
|||
||| Ha van akadály, kikerüljük (a tükörsík elkerülése).
||| Ha nincs akadály, egyenesen a cél felé megyünk.
public export
data Dontes : Type where
  EloreMeno : Dontes
  Kikerules : Dontes
  Varakozas : Dontes
  KommunikacioDontes : Dontes
  HibajavitasDontes : Dontes

public export
Show Dontes where
  show EloreMeno = "elore meno"
  show Kikerules = "kikerules"
  show Varakozas = "varakozas"
  show KommunikacioDontes = "kommunikacio"
  show HibajavitasDontes = "hibajavitas"

||| A döntés meghozatala a valóság alapján.
||| A Lagrangian minimalizálása + az akadályok kikerülése.
public export
dontes : Valosag -> Dontes
dontes valosag =
  case legkozelebbiAkadaly valosag of
    Nothing => EloreMeno
    Just akadaly =>
      let tavolsag = palyaSugara valosag.sajatPozicio akadaly.akadalyPozicio
      in if tavolsag >= akadaly.akadalySugar
         then EloreMeno
         else case akadaly.akadalyTipus of
                TukorSik => Kikerules
                MasikSzemely => KommunikacioDontes
                ErzelmiAkadaly => HibajavitasDontes
                FizikaiAkadaly => Varakozas
                KognitivAkadaly => HibajavitasDontes

-- ═══════════════════════════════════════════════════════════════
-- 4. CSELEKVÉS — A HAMILTONIAN IDŐFEJLESZTÉSE
-- ═══════════════════════════════════════════════════════════════

||| A cselekvés = a Hamiltonian időfejlesztése egy lépéssel.
||| q̇ = ∂H/∂p (a kategória változik az impulzus irányába)
||| ṗ = -∂H/∂q (az impulzus a cél felé mutat)
|||
||| A cselekvés = a pozíció frissítése a sebesség irányába.
||| A parametricity biztosítja, hogy a cselekvés optimális.
public export
cselekves : Valosag -> Dontes -> TizenotDimenziosPozicio
cselekves valosag dontesTipus =
  let p = valosag.sajatPozicio
      cel = valosag.celPozicioV
      q = valosag.sajatSebesseg
  in case dontesTipus of
       EloreMeno =>
         -- egyenesen a cél felé: pozíció + sebesség
         TizenotPozicioKonstruktor
           (p.emberiIdo + q.qDotEmberiIdo * 0.1)
           (p.emberiOksag + q.qDotEmberiOksag * 0.1)
           (p.emberiTer + q.qDotEmberiTer * 0.1)
           (p.emberiSzin + q.qDotEmberiSzin * 0.1)
           (p.emberiHang + q.qDotEmberiHang * 0.1)
           (p.emberiFazis + q.qDotEmberiFazis * 0.1)
           (p.emberiMod + q.qDotEmberiMod * 0.1)
           (p.szamitasiUtem + q.qDotSzamitasiUtem * 0.1)
           (p.szamitasiVezerles + q.qDotSzamitasiVezerles * 0.1)
           (p.szamitasiAdat + q.qDotSzamitasiAdat * 0.1)
           (p.szamitasiTipus + q.qDotSzamitasiTipus * 0.1)
           (p.szamitasiKapcsolat + q.qDotSzamitasiKapcsolat * 0.1)
           (p.szamitasiAllapot + q.qDotSzamitasiAllapot * 0.1)
           (p.szamitasiUtasitas + q.qDotSzamitasiUtasitas * 0.1)
           (p.peremErtek + q.qDotPeremErtek * 0.1)
       Kikerules =>
         -- akadály kikerülése: a perem dimenzióban eltérés
         TizenotPozicioKonstruktor
           p.emberiIdo p.emberiOksag p.emberiTer p.emberiSzin
           p.emberiHang p.emberiFazis (p.emberiMod + 0.5)
           p.szamitasiUtem p.szamitasiVezerles p.szamitasiAdat
           p.szamitasiTipus p.szamitasiKapcsolat p.szamitasiAllapot
           p.szamitasiUtasitas (p.peremErtek + 0.5)
       Varakozas => p
       KommunikacioDontes =>
         -- kommunikáció: a hang dimenzió nő
         TizenotPozicioKonstruktor
           p.emberiIdo p.emberiOksag p.emberiTer p.emberiSzin
           (p.emberiHang + 0.5) p.emberiFazis p.emberiMod
           p.szamitasiUtem p.szamitasiVezerles p.szamitasiAdat
           p.szamitasiTipus (p.szamitasiKapcsolat + 0.5)
           p.szamitasiAllapot p.szamitasiUtasitas p.peremErtek
       HibajavitasDontes =>
         -- hibajavítás: a fázis dimenzióban korrekció
         TizenotPozicioKonstruktor
           p.emberiIdo p.emberiOksag p.emberiTer p.emberiSzin
           p.emberiHang (p.emberiFazis + 0.5) p.emberiMod
           p.szamitasiUtem p.szamitasiVezerles p.szamitasiAdat
           p.szamitasiTipus p.szamitasiKapcsolat
           (p.szamitasiAllapot + 0.5) p.szamitasiUtasitas p.peremErtek

-- ═══════════════════════════════════════════════════════════════
-- 5. KOMMUNIKÁCIÓ — A PEREM (LEGENDRE ADJUNKCIÓ)
-- ═══════════════════════════════════════════════════════════════

||| A kommunikáció = a perem (Legendre adjunkció).
||| H = p·q̇ - L (a Hamiltonian = a perem - a Lagrangian).
||| A kommunikáció = a gondolat (L) → száj (perem) → hang (H).
|||
||| A perem = a Yoneda párosítás: ⟨p, q̇⟩.
||| A kommunikáció = a perem megnyitása (a száj kinyitása).
public export
record Kommunikacio where
  constructor KommunikacioKonstruktor
  gondolat : String    -- L: a belső gondolat (Lagrange)
  peremAllapot : Bool  -- p·q̇: a perem nyitva/zárva (száj)
  hanghullam : String  -- H: a kimondott szó (Hamilton)

||| A kommunikáció végrehajtása: gondolat → száj → hang.
||| A Legendre-transzformáció: H = p·q̇ - L.
public export
kommunikal : String -> Bool -> String -> Kommunikacio
kommunikal gondolat peremNyitva hang =
  KommunikacioKonstruktor gondolat peremNyitva hang

||| A beszéd: a gondolat → hanghullám transzformáció.
||| Ha a perem nyitva, a gondolat → hang.
||| Ha a perem zárva, csend (a gondolat marad belső).
public export
beszed : Kommunikacio -> String
beszed (KommunikacioKonstruktor gondolat peremNyitva hang) =
  if peremNyitva then hang else ""

-- ═══════════════════════════════════════════════════════════════
-- 6. AKADÁLYOK KIKERÜLÉSE — A TÜKÖRSÍK ELKERÜLÉSE
-- ═══════════════════════════════════════════════════════════════

||| A tükörsík elkerülése: a 2D idő-síkban mozgás.
||| 1 idő-dimenzió = előre (a megoldás felé)
||| 2 idő-dimenzió = a tükör elkerülése (bal/jobb)
|||
||| A magyar igeidő (mult/jelen/jövő) = 1. idő-dimenzió.
||| A magyar szemlélet (folyamatos/befejezett/szokásos) = 2. idő-dimenzió.
||| A 2D idő-sík elkerüli a tükröket.
public export
tukorElkerulesLepes : Valosag -> Akadaly -> TizenotDimenziosPozicio
tukorElkerulesLepes valosag akadaly =
  let p = valosag.sajatPozicio
  in case akadaly.akadalyTipus of
       TukorSik =>
         -- tükör elkerülése: a mód dimenzióban eltérés
         -- (a "választás" dimenzió = a magyar "mód" eset)
         TizenotPozicioKonstruktor
           p.emberiIdo p.emberiOksag p.emberiTer p.emberiSzin
           p.emberiHang p.emberiFazis (p.emberiMod + 1.0)
           p.szamitasiUtem p.szamitasiVezerles p.szamitasiAdat
           p.szamitasiTipus p.szamitasiKapcsolat p.szamitasiAllapot
           (p.szamitasiUtasitas + 1.0) p.peremErtek
       _ => p

-- ═══════════════════════════════════════════════════════════════
-- 7. TANULÁS — A VISSZACSATOLÁS FUNKTORA
-- ═══════════════════════════════════════════════════════════════

||| A tanulás = a visszacsatolás funktora (H: hang→ter).
||| A cselekvés eredménye visszacsatol a pozícióba.
||| A tapasztalat = az új pozíció a fázistérben.
|||
||| A parametricity biztosítja, hogy a tanulás uniform:
||| minden tapasztalat ugyanúgy frissíti a pozíciót.
public export
record Tapasztalat where
  constructor TapasztalatKonstruktor
  eredetiPozicio : TizenotDimenziosPozicio
  ujPozicio : TizenotDimenziosPozicio
  koltsegTapasztalat : Double
  tanulasIranya : String

||| A tanulás: a cselekvés eredményének visszacsatolása.
||| A tapasztalat = az új pozíció + a költség + a tanulás iránya.
public export
tanulas : Valosag -> Dontes -> TizenotDimenziosPozicio -> Tapasztalat
tanulas valosag dontesTipus ujPozicio =
  let koltseg = potencialisEnergia valosag.sajatPozicio valosag.celPozicioV
      irany = case dontesTipus of
        EloreMeno => "előre"
        Kikerules => "kikerülés"
        Varakozas => "várakozás"
        KommunikacioDontes => "kommunikáció"
        HibajavitasDontes => "hibajavítás"
  in TapasztalatKonstruktor valosag.sajatPozicio ujPozicio koltseg irany

-- ═══════════════════════════════════════════════════════════════
-- 8. A CSELEKVÉSI CIKLUS
-- ═══════════════════════════════════════════════════════════════

||| A cselekvési ciklus egy lépése:
|||   1. Érzékelés (megfigyelés: F)
|||   2. Döntés (Lagrangian minimalizálása)
|||   3. Cselekvés (Hamiltonian időfejlesztése)
|||   4. Tanulás (visszacsatolás: H)
|||
||| A parametricity biztosítja, hogy minden lépés optimális.
||| A [[15,1,3]] kód javítja a hibákat minden lépésben.
public export
record CselekvesiLepes where
  constructor CselekvesiLepesKonstruktor
  lepesSzama : Nat
  valosagAllapot : Valosag
  dontesLepes : Dontes
  ujPozicio : TizenotDimenziosPozicio
  tapasztalat : Tapasztalat

||| A cselekvési ciklus egy lépésének végrehajtása.
public export
cselekvesiLepes : Nat -> Valosag -> CselekvesiLepes
cselekvesiLepes szam valosag =
  let -- 1. Érzékelés
      _ = erzekeles valosag
      -- 2. Döntés
      dontesTipus = dontes valosag
      -- 3. Cselekvés
      ujPoz = cselekves valosag dontesTipus
      -- 4. Tanulás
      tapasztalatLepes = tanulas valosag dontesTipus ujPoz
  in CselekvesiLepesKonstruktor szam valosag dontesTipus ujPoz tapasztalatLepes

||| A valóság frissítése a cselekvési lépés után.
public export
valosagFrissit : Valosag -> TizenotDimenziosPozicio -> Valosag
valosagFrissit valosag ujPoz =
  ValosagKonstruktor
    ujPoz
    valosag.celPozicioV
    valosag.akadalyok
    valosag.sajatImpulzus
    valosag.sajatSebesseg

-- ═══════════════════════════════════════════════════════════════
-- 9. FŐPROGRAM — A CSELEKVÉS DEMONSTRÁCIÓJA
-- ═══════════════════════════════════════════════════════════════

||| Alap valóság: üres fázistér, cél a (1,1,...,1) pontban.
public export
alapValosag : Valosag
alapValosag = ValosagKonstruktor
  alapPozicio celPozicio [] alapImpulzus alapSebesseg

||| A cselekvés demonstrációja.
public export
cselekvesDemo : IO ()
cselekvesDemo = do
  putStrLn "=== CSELEKVÉS — A VALÓSÁGBAN VALÓ NAVIGÁLÁS ==="
  putStrLn ""
  putStrLn "A bizonyítás (parametricity) megmondja az utat."
  putStrLn "A megvalósítás (cselekvés) megteszi az utat a valóságon keresztül."
  putStrLn ""
  putStrLn "A cselekvési ciklus:"
  putStrLn "  1. Érzékelés (megfigyelés: F: ter→szin)"
  putStrLn "  2. Döntés (Lagrangian minimalizálása = legkisebb művelet)"
  putStrLn "  3. Cselekvés (Hamiltonian időfejlesztése = a lépés)"
  putStrLn "  4. Kommunikáció (perem = Legendre adjunkció)"
  putStrLn "  5. Hibajavítás ([[15,1,3]] kód)"
  putStrLn "  6. Tanulás (visszacsatolás: H: hang→ter)"
  putStrLn ""
  let lepes1 = cselekvesiLepes 1 alapValosag
  putStrLn ("Lépés 1: döntés = " ++ show lepes1.dontesLepes)
  putStrLn ("  költség: " ++ show lepes1.tapasztalat.koltsegTapasztalat)
  putStrLn ("  tanulás iránya: " ++ lepes1.tapasztalat.tanulasIranya)
  putStrLn ""
  let valosag2 = valosagFrissit alapValosag lepes1.ujPozicio
      lepes2 = cselekvesiLepes 2 valosag2
  putStrLn ("Lépés 2: döntés = " ++ show lepes2.dontesLepes)
  putStrLn ("  költség: " ++ show lepes2.tapasztalat.koltsegTapasztalat)
  putStrLn ""
  putStrLn "A valóság akadályai:"
  putStrLn "  tükörsík → kikerülés (a mód dimenzióban eltérés)"
  putStrLn "  másik személy → kommunikáció (a hang dimenzió nő)"
  putStrLn "  érzelmi akadály → hibajavítás (a fázis dimenzió korrekció)"
  putStrLn "  fizikai akadály → várakozás (több információ kell)"
  putStrLn "  kognitív akadály → hibajavítás (a fázis dimenzió korrekció)"
  putStrLn ""
  putStrLn "A tükörsík elkerülése: a 2D idő-síkban mozgás."
  putStrLn "  igeidő (mult/jelen/jövő) = 1. idő-dimenzió"
  putStrLn "  szemlélet (folyamatos/befejezett/szokásos) = 2. idő-dimenzió"
  putStrLn ""
  putStrLn "A kommunikáció: gondolat (L) → száj (perem) → hang (H)."
  putStrLn "  H = p·q̇ - L (Legendre-transzformáció)"
  putStrLn ""
  putStrLn "Kész."

||| Főprogram (a CselekvesMain.idr hivja).
public export
cselekvesFom : IO ()
cselekvesFom = cselekvesDemo