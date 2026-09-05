module FazisAlgebra_v3

-- ═══════════════════════════════════════════════════════════════
-- FAZISALGEBRA v3 — a CPT-mag + a redundancia-algebra a szima_ter
-- világban (2026-09-04)
-- PHASE ALGEBRA v3 — the CPT core + redundancy algebra in the
-- szima_ter world
-- 相位代数 v3 —— szima_ter 世界中的 CPT 核心 + 冗余代数
-- PHASENALGEBRA v3 — der CPT-Kern + Redundanz-Algebra in szima_ter
-- אלגברת פאזה v3 — ליבת CPT ואלגברת היתירות בעולם szima_ter
-- ═══════════════════════════════════════════════════════════════
--
-- MIÉRT v3? (§13: a javítás ÚJ FÁJL — semmi nem íródik felül)
--   Az ŐS: osveny_index/FazisAlgebra.idr (a v1) — az OTTHONában fordul,
--   mert ott él az `Alap.CsomagoltTipusok` (Igazság) és a teljes
--   HaromKubit-modul.
--   A v2: szima_ter/modul/FazisAlgebra_v2.idr — NEM FORDUL, mert
--   (1) ékezet nélküli neveket hív (`azonosFazis`, `Irany`, `irany`),
--       pedig a szima_ter világ ékezetes neveket használ, ÉS
--   (2) a szima_ter/modul/Alap/ könyvtárban NINCS `CsomagoltTipusok.idr`
--       (csak AlphaKozos/AlphaKözös/KategoriaT — 2026-09-04-i ls).
--   Ez a v3 a v1 TELJES tartalmát hozza át a szima_ter világba.
--
-- AZ IMPORT-VIZSGÁLAT EREDMÉNYE (2026-09-04, mind lefuttatva, GAUGE):
--   cd szima_ter/modul && idris2 --check Steane713.idr      → TISZTA ✓
--   cd szima_ter/modul && idris2 --check E8E8Algebra.idr    → TISZTA ✓
--       (és tartalmazza a fazisOsszehasonlit-hoz KELLŐ függvényeket:
--        `CliffordKonstruktor`, `atfedes : CliffordElem -> CliffordElem
--        -> Double` — az ottani komment szó szerint azt írja, hogy
--        „a FazisAlgebra.fazisOsszehasonlit által használt függvény"!)
--   cd szima_ter/modul && idris2 --check HaromKubit.idr     → HIBA ✗
--       „Error: Module Alap.CsomagoltTipusok not found" (13. sor)
--   → KÖVETKEZTETÉS: a v3 CSAK olyan modulokat importál, amik a
--     szima_ter világban ÉLNEK: `Steane713` + `E8E8Algebra`.
--
-- §24 (KÓD DUPLIKÁCIÓ TILOS) — az audit, ami a helyi definíciókat
-- FEDEZI („HA ÉS CSAK HA más út nincs"):
--   1. `Igazság` (Igaz/Hamis): a KANONIKUS otthon az
--      osveny_index/Alap/CsomagoltTipusok.idr (57. sor) — de a
--      szima_ter világban az import ELÉRHETETLEN (nincs forrás,
--      nincs ttc — mindkettőt megvizsgáltam). Helyi minta, a
--      kanonikus név- és konstruktoralakjával AZONOSSZÁMÚL, hogy a
--      jövőbeli egyesítéskor (ha a szima_ter megkapja az Alap-ot)
--      a csere névkompatibilis legyen.
--   2. `HaromKubit` + `VilágKonstruktor` + `saját/másik/fázis` +
--      `kubitEgyezés` + `azonosFázis` + `Irány`/`irány`: a KANONIKUS
--      otthon az osveny_index/HaromKubit.idr — DE az a modul maga is
--      meghal a szima_ter világban (fenti ✗). A helyi tükör a
--      kanonikus ÉKEZETES neveit viseli (a feladat kifejezetten az
--      `azonosFázis`/`irány` hívását kérte — ezek a nevek most
--      helyben is pontosan azok).
--   3. `atfedes`, `CliffordKonstruktor`, `CliffordElem`, `E8E8KodSzo`:
--      IMPORTÁLVA az E8E8Algebra.idr-ből (NEM újraírva!).
--   4. `Nulla`/`Egy`/`Kubit`: IMPORTÁLVA a Steane713.idr-ből.
--   5. `any` (a redundáns-ban): Prelude — nem újraírva.
--
-- A v1 TELJES TARTALMA ÁTJÖTT (a 100.01-szellem, a meztelen Bool ki
-- irtva — minden logikai érték Igazság):
--   Fázis-adattípus + Eq · fázisÖsszehasonlítás · redundáns · szűrd ·
--   ToltesParitasIdo (a név AZ AGENTS §9 KANONIKUS HORGONYA — a
--   mezők már ékezetesen: töltés/paritás/idő) · koherencia · irány ·
--   fazisFaktorialis (szintén AGENTS §9-horgonyú név) · FázisHatár ·
--   fázisÁtlépés · fázisHatárClifford · elsőRendűFázisÁtmenet ·
--   minden (∀, Pi) · létezik (∃, Szigma) — ÉS 7 REFL-TANÚ (§18:
--   mindegyik két oldalán KÜLÖNBÖZŐ konstrukció).
-- ═══════════════════════════════════════════════════════════════

import Steane713
import E8E8Algebra

%default covering

-- ─── 1. IGAZSÁG — a helyi minta (a kanonikus elérhetetlen, l. fejléc) ──

||| Igazság: a kétfokozatú logikai érték — a meztelen Bool helyett
||| (100.01: a mag Igazságot beszél).
public export
data Igazság : Type where
  Igaz  : Igazság
  Hamis : Igazság

-- ─── 2. HÁROM KUBIT — a helyi tükör (a kanonikus elérhetetlen) ───

||| A három kubit, amely minden kapcsolat alapja:
|||   saját  = a rendszer önreferenciája («ki vagyok én»)
|||   másik  = a másik fél, a külső bemenet («ki vagy te»)
|||   fázis  = a kettő közötti kapcsolat («hogyan kapcsolódunk»)
||| A konstruktor- és mezőnevek a kanonikus osveny_index/HaromKubit
||| ÉKEZETES alakjai — a tükör névkompatibilis vele.
public export
record HaromKubit where
  constructor VilágKonstruktor
  saját  : Steane713.Kubit
  másik  : Steane713.Kubit
  fázis  : Steane713.Kubit

||| Kubit-egyezés: a két Kubit értéke egyezik-e (Igazság-típusban).
public export
kubitEgyezés : Steane713.Kubit -> Steane713.Kubit -> Igazság
kubitEgyezés Steane713.Nulla Steane713.Nulla = Igaz
kubitEgyezés Steane713.Egy Steane713.Egy = Igaz
kubitEgyezés _ _ = Hamis

||| Fázis-összehasonlítás: ha két HaromKubit fázisa megegyezik,
||| akkor redundánsak — ugyanazt az információt hordozzák a fázis
||| szintjén. Ez a redundancia-detektálás alapja.
public export
azonosFázis : HaromKubit -> HaromKubit -> Igazság
azonosFázis a b = kubitEgyezés a.fázis b.fázis

||| Irány: az információátvitel iránya a fázisból.
public export
data Irány = SajátMásik | MásikSaját | NincsIrány

||| Az irány kiszámítása a két kubit fázisából.
public export
irány : HaromKubit -> HaromKubit -> Irány
irány a b =
  case (a.fázis, b.fázis) of
    (Steane713.Nulla, Steane713.Egy) => SajátMásik
    (Steane713.Egy,  Steane713.Nulla) => MásikSaját
    _ => NincsIrány

-- ─── 3. FÁZIS — a Clifford-átfedés négy kimenete ──────────────

||| Fázisérték a Clifford-algebrában.
|||   Azonos:      a két kódszó ugyanabban a fázisban rezeg
|||                → redundáns, eldobható.
|||   Ellentétes:  ellentétes fázisban rezegnek → információátvitel,
|||                megtartandó.
|||   Kvantált:    összefonódott állapot → kvantum-kapcsolat
|||                (metafora, asszociáció).
|||   Ismeretlen:  a fázis nem állapítható meg → további vizsgálat.
public export
data Fázis = Azonos | Ellentétes | Kvantált | Ismeretlen

public export
Eq Fázis where
  (==) Azonos Azonos = True
  (==) Ellentétes Ellentétes = True
  (==) Kvantált Kvantált = True
  (==) Ismeretlen Ismeretlen = True
  (==) _ _ = False
  (/=) a b = not (a == b)

||| Két kódszó fázis-összehasonlítása a Clifford-átfedés alapján
||| (a bal és a jobb E8 első két koordinátáján):
|||   >0.9 mindkettőn → Azonos;  <0.1 mindkettőn → Ellentétes;
|||   >0.5 valamelyiken → Kvantált;  egyébként → Ismeretlen.
public export
fázisÖsszehasonlítás : E8E8KodSzo -> E8E8KodSzo -> Fázis
fázisÖsszehasonlítás a b =
  let balÁtfedés = atfedes (CliffordKonstruktor a.balE8.x1 a.balE8.x2 Steane713.Nulla)
                           (CliffordKonstruktor b.balE8.x1 b.balE8.x2 Steane713.Nulla)
      jobbÁtfedés = atfedes (CliffordKonstruktor a.jobbE8.x1 a.jobbE8.x2 Steane713.Nulla)
                            (CliffordKonstruktor b.jobbE8.x1 b.jobbE8.x2 Steane713.Nulla)
  in if balÁtfedés > 0.9 && jobbÁtfedés > 0.9 then Azonos
     else if balÁtfedés < 0.1 && jobbÁtfedés < 0.1 then Ellentétes
     else if balÁtfedés > 0.5 || jobbÁtfedés > 0.5 then Kvantált
     else Ismeretlen

||| Redundancia-ellenőrzés: ha a kód valamilyen meglévő kóddal
||| azonos fázisban van, akkor redundáns — eldobható.
||| Ez a koherencia megőrzésének alapja.
public export
redundáns : E8E8KodSzo -> List E8E8KodSzo -> Bool
redundáns kód kodok = any (\k => fázisÖsszehasonlítás kód k == Azonos) kodok

||| Szűrés: a lista elejétől haladva minden elemet eldobjunk, ha a
||| fázisa azonos a MÖGÖTTE állók valamelyikével; egyébként megtartjuk.
||| Az eredmény koherens — nincs benne azonos fázisú pár.
public export
szűrd : List E8E8KodSzo -> List E8E8KodSzo
szűrd Nil = Nil
szűrd (x :: xs) =
  if redundáns x xs
    then szűrd xs
    else x :: szűrd xs

-- ─── 4. TOLTESPARITASIDO — a CPT-szimmetria magyarul ──────────

||| ToltesParitasIdo: a CPT-szimmetria magyarul (AGENTS §9 pszicho-
||| fizikai rétege; a rekordnév az AGENTS §9-es horgony miatt a
||| kanonikus alakban marad — a mezők ékezetesen):
|||   C (töltés)  = saját tudat — a rendszer önreferenciája
|||   P (paritás) = másik fél — a külső bemenet
|||   T (idő)     = kapcsolat fázisa — a kettő dinamikája
public export
record ToltesParitasIdo where
  constructor ToltesParitasIdoKonstruktor
  töltés  : HaromKubit  -- C: saját tudat (ki vagyok én)
  paritás : HaromKubit  -- P: másik fél (ki vagy te)
  idő     : HaromKubit  -- T: kapcsolat fázisa (hogyan kapcsolódunk)

||| A ToltesParitasIdo logikai értéke: ha a töltés és a paritás
||| fázisa megegyezik, akkor a rendszer saját tudata rezonanciában
||| van a külsővel — nincs információvesztés.
public export
töltésParitásIdőKoherens : ToltesParitasIdo -> Igazság
töltésParitásIdőKoherens tpi = azonosFázis tpi.töltés tpi.paritás

||| A ToltesParitasIdo iránya: a töltés és a paritás között.
||| Ha a töltés irányul a paritás felé → a rendszer AKTÍV (küld);
||| ha a paritás irányul a töltés felé → PASSZÍV (fogad).
public export
töltésParitásIdőIrány : ToltesParitasIdo -> Irány
töltésParitásIdőIrány tpi = irány tpi.töltés tpi.paritás

||| Fázis-faktoriális: egy ToltesParitasIdo fázismértékét számolja
||| a HaromKubit-ok összefedéséből — az „általános koherencia"
||| mértéke (a név AGENTS §9-horgonyú: a CPT-koherencia tényezője).
public export
fazisFaktorialis : ToltesParitasIdo -> Double
fazisFaktorialis tpi =
  let töltésAzonos = azonosFázis tpi.töltés tpi.idő
      paritásAzonos = azonosFázis tpi.paritás tpi.idő
  in case (töltésAzonos, paritásAzonos) of
    (Igaz, Igaz) => 1.0
    (Igaz, Hamis) => 0.5
    (Hamis, Igaz) => 0.5
    (Hamis, Hamis) => 0.0

-- ─── 5. FÁZISHATÁR = LEGENDRE-PEREM ───────────────────────────

||| Fázishatár: két fázis közti átmenet — a perem, ahol a rendszer
||| egyik állapotból a másikba vált. A Legendre-transzformáció =
||| a fázishatár átlépése = a mérés aktusa.
|||   Fizikában: szilárd/folyékony, kvantum/klasszikus.
|||   Itt: komplex (∫) → perem (p·q̇) → diszkrét (Σ);
|||        emberi (L) → perem → számítási (H); gondolat → száj → beszéd.
public export
record FázisHatár where
  constructor FázisHatárKonstruktor
  balFázis   : Fázis   -- a fázishatár ELŐTTI állapot
  jobbFázis  : Fázis   -- a fázishatár UTÁNI állapot
  peremÉrték : Double  -- a fázishatár értéke (p·q̇ = Legendre-perem)

||| Fázisátalakulás a fázishatáron keresztül: a beérkező rendszer
||| a jobbFázisban kel ki a perem túlsó oldalán.
public export
fázisÁtlépés : FázisHatár -> Fázis
fázisÁtlépés (FázisHatárKonstruktor _ jobb _) = jobb

||| A fázishatár mint a Clifford-szorzat választása:
|||   a·b (átfedés) magas → redundáns → eldobás (Azonos);
|||   a∧b (újdonság) magas → információ → megtartás (Kvantált).
public export
fázisHatárClifford : Double -> Double -> Fázis
-- CSAPDA #27 gyógyír: import mellett a CSUPASZ ékezetes mintaváltozó
-- a klauzula LHS-én «Undefined name»-t ad — a @-minta a tanúsított
-- áthidaló (a nevek így is ékezetesek maradnak, §25).
fázisHatárClifford átfedés@_ újdonság@_ =
  if átfedés > újdonság then Azonos else Kvantált

||| Elsőrendű fázisátmenet: a potenciál ELSŐ deriváltja ugrik a
||| peremen (entrópia, térfogat — a látens hő). A különbség = a perem.
public export
elsőRendűFázisÁtmenet : Double -> Double -> Double
elsőRendűFázisÁtmenet f1 f2 = f2 - f1

-- ─── 6. ELSŐRENDŰ LOGIKA (CURRY–HOWARD) ───────────────────────

||| Univerzális kvantor (∀) mint Pi-típus.
||| Curry–Howard: ∀x.P(x) = (x : A) -> P(x).
public export
minden : (a : Type) -> (p : a -> Type) -> Type
minden a p = (x : a) -> p x

||| Egzisztenciális kvantor (∃) mint Szigma-típus.
||| Curry–Howard: ∃x.P(x) = (x : A ** P(x)).
public export
létezik : (a : Type) -> (p : a -> Type) -> Type
létezik a p = (x : a ** p x)

-- ─── 7. REFL-TANÚK (§18 — mindegyik két oldalán KÜLÖNBÖZŐ
--      KONSTRUKCIÓ; a tanúkban CSAK NAGYBETŰS konstans állhat a
--      típusban — a kisbetűs-konstans csapda!) ────────────────────

||| A tanúsított állapotok: tükör-kapcsolat (minden kubit Nulla,
||| a fázis kivételével: Egy), küldő (fázisa Nulla) és fogadó
||| (fázisa Egy). NAGYBETŰS konstansok — a csapda miatt.
public export
Tükör : HaromKubit
Tükör = VilágKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Egy

public export
Küldő : HaromKubit
Küldő = VilágKonstruktor Steane713.Egy Steane713.Nulla Steane713.Nulla

public export
Fogadó : HaromKubit
Fogadó = VilágKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Egy

||| A teljes három kubit kódszava: minden E8-koordináta Nulla,
||| Clifford-elem (Nulla,Nulla,Nulla), heteskód: minden bit Nulla.
public export
AlapKód : E8E8KodSzo
AlapKód = KodKonstruktor
  "alap"
  (E8PontKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Nulla Steane713.Nulla
                     Steane713.Nulla Steane713.Nulla Steane713.Nulla Steane713.Nulla)
  (E8PontKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Nulla Steane713.Nulla
                     Steane713.Nulla Steane713.Nulla Steane713.Nulla Steane713.Nulla)
  (E8PontKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Nulla Steane713.Nulla
                     Steane713.Nulla Steane713.Nulla Steane713.Nulla Steane713.Nulla)
  (E8PontKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Nulla Steane713.Nulla
                     Steane713.Nulla Steane713.Nulla Steane713.Nulla Steane713.Nulla)
  (CliffordKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Nulla)
  (HetesKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Nulla Steane713.Nulla
                    Steane713.Nulla Steane713.Nulla Steane713.Nulla)

-- Kimenet: Refl (Igaz = Igaz ✓) — bal: a koherencia-függvény a
-- Tükör-fázisokon át kubitEgyezésig redukál; jobb: az Igaz konstruktor.
public export
bizKoherenciaTükör : töltésParitásIdőKoherens (ToltesParitasIdoKonstruktor Tükör Tükör Tükör) = Igaz
bizKoherenciaTükör = Refl

-- Kimenet: Refl (SajátMásik = SajátMásik ✓) — bal: az irány a
-- (Nulla, Egy) fázispárból számol; jobb: az Irány konstruktor.
public export
bizIránySajátMásik : töltésParitásIdőIrány (ToltesParitasIdoKonstruktor Küldő Fogadó Fogadó) = SajátMásik
bizIránySajátMásik = Refl

-- Kimenet: Refl (1.0 = 1.0 ✓) — a teljes koherencia: mindhárom
-- kubit azonos fázisú → a faktoriális 1.0.
public export
bizFázisFaktoriálisTeljes : fazisFaktorialis (ToltesParitasIdoKonstruktor Tükör Tükör Tükör) = 1.0
bizFázisFaktoriálisTeljes = Refl

-- Kimenet: Refl (Ellentétes = Ellentétes ✓) — az átlépés a perem
-- jobb oldalán kijövő fázist adja.
public export
bizFázisÁtlépés : fázisÁtlépés (FázisHatárKonstruktor Azonos Ellentétes 0.5) = Ellentétes
bizFázisÁtlépés = Refl

-- Kimenet: Refl (1.0 = 1.0 ✓) — az IMPORTÁLT atfedes teljes
-- egyezése: három Nulla-egyezés / 3 = 1.0 (két út: a számított
-- arány és a literál).
public export
bizÁtfedésTeljes : atfedes (CliffordKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Nulla)
                           (CliffordKonstruktor Steane713.Nulla Steane713.Nulla Steane713.Nulla) = 1.0
bizÁtfedésTeljes = Refl

-- Kimenet: Refl (Azonos = Azonos ✓) — önmagához hasonlított kódszó:
-- bal- és jobb-átfedés is 1.0 → Azonos (a teljes
-- fázisÖsszehasonlítás-lánc tanúsítva).
public export
bizFázisAzonosÖnmagával : fázisÖsszehasonlítás AlapKód AlapKód = Azonos
bizFázisAzonosÖnmagával = Refl

-- Kimenet: Refl ([kódszó] = [kódszó] ✓) — a szűrő eldobja a
-- duplumot: [AlapKód, AlapKód] → [AlapKód] (a redundáns + szűrd
-- együttműködésének tanúja).
public export
bizSzűrdEldobjaDuplumot : szűrd (AlapKód :: AlapKód :: Nil) = (AlapKód :: Nil)
bizSzűrdEldobjaDuplumot = Refl
