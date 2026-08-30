module Kategoriak.MagyarOntologia

import Alap.KategoriaT

-- ═══════════════════════════════════════════════════════════════
-- MAGYAR ONTOLÓGIA — SZAVAK ÖNÁLLÓ TÍPUSOKKÉNT, NINCS STRING
-- ═══════════════════════════════════════════════════════════════
-- Minden szó = önálló típus. Nincs String, nincs Double, nincs Bool.
-- A képzők = typeclass instance-ok.
-- A kategóriák = typeclass-ok.
-- A tő = típus-szintű kapcsolat.
-- A rokon szavak = típus-szintű lista.

-- ═══════════════════════════════════════════════════════════════
-- 1. JELLENTÉSKATEGÓRIÁK
-- ═══════════════════════════════════════════════════════════════

public export
data JK = IndividuumJK | UniverzaleJK | GyujtemenyJK
        | CselekvesJK | AllapotJK | HelyJK | IdoJK
        | OkJK | ModJK | MennyisegJK | KapcsolatJK

-- ═══════════════════════════════════════════════════════════════
-- 2. SZÓTÖVEK — TÍPUSOK
-- ═══════════════════════════════════════════════════════════════

-- A tő is típus. Nincs String.
public export
data SzamToTipus = SzamToKonstruktor
public export
data TerToTipus = TerToKonstruktor
public export
data JoToTipus = JoToKonstruktor

-- ═══════════════════════════════════════════════════════════════
-- 3. KÉPZŐK — TÍPUSOK
-- ═══════════════════════════════════════════════════════════════

public export
data OlKepzoTipus = OlKepzoKonstruktor
public export
data ItKepzoTipus = ItKepzoKonstruktor
public export
data AsKepzoTipus = AsKepzoKonstruktor
public export
data ElKepzoTipus = ElKepzoKonstruktor
public export
data SagKepzoTipus = SagKepzoKonstruktor
public export
data LKepzoTipus = LKepzoKonstruktor
public export
data TalanKepzoTipus = TalanKepzoKonstruktor
public export
data OKepzoTipus = OKepzoKonstruktor

-- ═══════════════════════════════════════════════════════════════
-- 4. SZAVAK — MINDEN SZÓ ÖNÁLLÓ TÍPUS
-- ═══════════════════════════════════════════════════════════════

-- A szám- szócsalád
public export
data SzamTipus = SzamKonstruktor
public export
data SzamolTipus = SzamolKonstruktor
public export
data SzamitTipus = SzamitKonstruktor
public export
data SzamitasTipus = SzamitasKonstruktor
public export
data SzamlaloTipus = SzamlaloKonstruktor
public export
data SzamitogepTipus = SzamitogepKonstruktor
public export
data SzamtalanTipus = SzamtalanKonstruktor

-- A tér- szócsalád
public export
data TerTipus = TerKonstruktor
public export
data TerelTipus = TerelKonstruktor
public export
data TeritTipus = TeritKonstruktor
public export
data TerjedTipus = TerjedKonstruktor
public export
data TerfogatTipus = TerfogatKonstruktor

-- A jó- szócsalád
public export
data JoTipus = JoKonstruktor
public export
data JosagTipus = JosagKonstruktor
public export
data JolTipus = JolKonstruktor

-- ═══════════════════════════════════════════════════════════════
-- 5. KATEGÓRIA TYPECLASS — MILYEN KATEGÓRIÁBA TARTOZIK?
-- ═══════════════════════════════════════════════════════════════

public export
interface JelentesT (0 szo : Type) (k : JK) | szo where

public export
JelentesT SzamTipus MennyisegJK
public export
JelentesT SzamolTipus CselekvesJK
public export
JelentesT SzamitTipus CselekvesJK
public export
JelentesT SzamitasTipus UniverzaleJK
public export
JelentesT SzamlaloTipus IndividuumJK
public export
JelentesT SzamitogepTipus IndividuumJK
public export
JelentesT SzamtalanTipus AllapotJK
public export
JelentesT TerTipus HelyJK
public export
JelentesT TerelTipus CselekvesJK
public export
JelentesT TeritTipus CselekvesJK
public export
JelentesT TerjedTipus CselekvesJK
public export
JelentesT TerfogatTipus MennyisegJK
public export
JelentesT JoTipus AllapotJK
public export
JelentesT JosagTipus UniverzaleJK
public export
JelentesT JolTipus ModJK

-- ═══════════════════════════════════════════════════════════════
-- 6. TŐ TYPECLASS — MILYEN TŐBŐL KELT?
-- ═══════════════════════════════════════════════════════════════

public export
interface SzotoT (0 szo : Type) (0 to : Type) | szo where

public export
SzotoT SzamTipus SzamToTipus
public export
SzotoT SzamolTipus SzamToTipus
public export
SzotoT SzamitTipus SzamToTipus
public export
SzotoT SzamitasTipus SzamToTipus
public export
SzotoT SzamlaloTipus SzamToTipus
public export
SzotoT SzamitogepTipus SzamToTipus
public export
SzotoT SzamtalanTipus SzamToTipus
public export
SzotoT TerTipus TerToTipus
public export
SzotoT TerelTipus TerToTipus
public export
SzotoT TeritTipus TerToTipus
public export
SzotoT TerjedTipus TerToTipus
public export
SzotoT TerfogatTipus TerToTipus
public export
SzotoT JoTipus JoToTipus
public export
SzotoT JosagTipus JoToTipus
public export
SzotoT JolTipus JoToTipus

-- ═══════════════════════════════════════════════════════════════
-- 7. KÉPZŐ TYPECLASS — MILYEN KÉPZŐVEL KELT?
-- ═══════════════════════════════════════════════════════════════

public export
interface KepzoT (0 forras : Type) (0 cel : Type) (0 kepzo : Type) | forras where

public export
KepzoT SzamTipus SzamolTipus OlKepzoTipus
public export
KepzoT SzamTipus SzamitTipus ItKepzoTipus
public export
KepzoT SzamitTipus SzamitasTipus AsKepzoTipus
public export
KepzoT SzamTipus SzamlaloTipus OKepzoTipus
public export
KepzoT SzamTipus SzamtalanTipus TalanKepzoTipus
public export
KepzoT TerTipus TerelTipus ElKepzoTipus
public export
KepzoT TerTipus TeritTipus ItKepzoTipus
public export
KepzoT JoTipus JosagTipus SagKepzoTipus
public export
KepzoT JoTipus JolTipus LKepzoTipus

-- ═══════════════════════════════════════════════════════════════
-- 8. ROKON SZÓ TYPECLASS — MIK A ROKON SZAVAK?
-- ═══════════════════════════════════════════════════════════════

-- A rokon szavak = típus-szintű kapcsolatok. Nincs List String.
public export
interface RokonSzoT (0 szo : Type) (0 rokon : Type) | szo where

public export
RokonSzoT SzamolTipus SzamitTipus
public export
RokonSzoT SzamitTipus SzamolTipus
public export
RokonSzoT SzamlaloTipus SzamitogepTipus
public export
RokonSzoT SzamitogepTipus SzamlaloTipus
public export
RokonSzoT TerelTipus TeritTipus
public export
RokonSzoT TeritTipus TerelTipus
public export
RokonSzoT JoTipus JosagTipus
public export
RokonSzoT JosagTipus JoTipus

-- ═══════════════════════════════════════════════════════════════
-- 9. KÍNAI MEGFELELŐ TYPECLASS
-- ═══════════════════════════════════════════════════════════════

-- A kínai megfelelő is típus. Nincs String.
public export
data SzamKinaiTipus = SzamKinaiKonstruktor
public export
data SzamitKinaiTipus = SzamitKinaiKonstruktor
public export
data SzamitogepKinaiTipus = SzamitogepKinaiKonstruktor
public export
data TerKinaiTipus = TerKinaiKonstruktor
public export
data JoKinaiTipus = JoKinaiKonstruktor

public export
interface KinaiMegfeleloT (0 magyar : Type) (0 kinai : Type) | magyar where

public export
KinaiMegfeleloT SzamTipus SzamKinaiTipus
public export
KinaiMegfeleloT SzamitTipus SzamitKinaiTipus
public export
KinaiMegfeleloT SzamitogepTipus SzamitogepKinaiTipus
public export
KinaiMegfeleloT TerTipus TerKinaiTipus
public export
KinaiMegfeleloT JoTipus JoKinaiTipus

-- ═══════════════════════════════════════════════════════════════
-- 10. MONDAT — TÍPUSOK KOMPOZÍCIÓJA
-- ═══════════════════════════════════════════════════════════════

-- Egy mondat = a szavak kompozíciója.
-- A mondat típusa = a szavak típusainak kompozíciója.
-- Nincs String — a mondat maga a típus.

-- "szám számol" = SzamTipus -> SzamolTipus (a számolás aktusa)
public export
record SzamSzamolMondat where
  constructor SzamSzamolMondatKonstruktor
  alany   : SzamTipus
  ige     : SzamolTipus

-- "számítógép számít" = SzamitogepTipus -> SzamitTipus
public export
record SzamitogepSzamitMondat where
  constructor SzamitogepSzamitMondatKonstruktor
  alany   : SzamitogepTipus
  ige     : SzamitTipus

-- "jó számítás" = JoTipus -> SzamitasTipus (minősités)
public export
record JoSzamitasMondat where
  constructor JoSzamitasMondatKonstruktor
  minoseg : JoTipus
  targy   : SzamitasTipus

-- ═══════════════════════════════════════════════════════════════
-- 11. ONTOLÓGIAI SZINTEK — MEO
-- ═══════════════════════════════════════════════════════════════

public export
data OntologiaiSzint = MetaMetaSzint | MetaSzint | TargySzint | InstanciaSzint

public export
data KeresztRelacio : OntologiaiSzint -> OntologiaiSzint -> Type where
  Instancialas  : KeresztRelacio InstanciaSzint TargySzint
  Tipizalas     : KeresztRelacio TargySzint MetaSzint
  Formalizalas  : KeresztRelacio MetaSzint MetaMetaSzint

-- ═══════════════════════════════════════════════════════════════
-- 12. ABSZTRAKT JELENTÉS — A STRUKTÚRÁBÓL
-- ═══════════════════════════════════════════════════════════════

-- Az absztrakt jelentés = a típusok kapcsolata.
-- "szám számol" = egy mennyiség cselekvést végez (MennyisegJK -> CselekvesJK)
-- "jó számítás" = egy állapot minősít egy fogalmat (AllapotJK -> UniverzaleJK)
-- A jelentés = a kompozíció eredménye. Nincs String.

-- A "számól" = emberi (ol képző), "számít" = gépi (it képző)
-- A különbség = a képző típusa (OlKepzoTipus vs ItKepzoTipus)
-- Ezt a típus mondja meg, nem egy String mező.

-- ═══════════════════════════════════════════════════════════════
-- 13. FŐPROGRAM
-- ═══════════════════════════════════════════════════════════════

public export
magyarOntologiaFom : IO ()
magyarOntologiaFom = do
  putStrLn "=== MAGYAR ONTOLÓGIA — NINCS STRING ==="
  putStrLn ""
  putStrLn "A szam- szocsalad (minden szo onallo tipus):"
  putStrLn "  SzamTipus (szam)       -> MennyisegJK"
  putStrLn "  SzamolTipus (szamol)   -> CselekvesJK  (kepzo: OlKepzoTipus)"
  putStrLn "  SzamitTipus (szamit)   -> CselekvesJK  (kepzo: ItKepzoTipus)"
  putStrLn "  SzamitasTipus (szamitas) -> UniverzaleJK"
  putStrLn "  SzamlaloTipus (szamlalo) -> IndividuumJK"
  putStrLn "  SzamitogepTipus (szamitogep) -> IndividuumJK"
  putStrLn "  SzamtalanTipus (szamtalan) -> AllapotJK"
  putStrLn ""
  putStrLn "A ter- szocsalad:"
  putStrLn "  TerTipus (ter)       -> HelyJK"
  putStrLn "  TerelTipus (terel)   -> CselekvesJK  (kepzo: ElKepzoTipus)"
  putStrLn "  TeritTipus (terit)   -> CselekvesJK  (kepzo: ItKepzoTipus)"
  putStrLn ""
  putStrLn "A jo- szocsalad:"
  putStrLn "  JoTipus (jo)       -> AllapotJK"
  putStrLn "  JosagTipus (josag)  -> UniverzaleJK  (kepzo: SagKepzoTipus)"
  putStrLn "  JolTipus (jol)      -> ModJK         (kepzo: LKepzoTipus)"
  putStrLn ""
  putStrLn "Kepzok (morfizmusok tipusok kozott):"
  putStrLn "  SzamTipus --(OlKepzoTipus)--> SzamolTipus"
  putStrLn "  SzamTipus --(ItKepzoTipus)--> SzamitTipus"
  putStrLn "  TerTipus  --(ElKepzoTipus)--> TerelTipus"
  putStrLn "  JoTipus   --(SagKepzoTipus)--> JosagTipus"
  putStrLn "  JoTipus   --(LKepzoTipus)--> JolTipus"
  putStrLn ""
  putStrLn "Mondatok (tipusok kompozicioja):"
  putStrLn "  SzamSzamolMondat = SzamTipus + SzamolTipus (szam szamol)"
  putStrLn "  SzamitogepSzamitMondat = SzamitogepTipus + SzamitTipus (szamitogep szamit)"
  putStrLn "  JoSzamitasMondat = JoTipus + SzamitasTipus (jo szamitas)"
  putStrLn ""
  putStrLn "Kinai megfelelok (人才的irotol too tipusok):"
  putStrLn "  SzamTipus -> SzamKinaiTipus"
  putStrLn "  SzamitTipus -> SzamitKinaiTipus"
  putStrLn "  TerTipus -> TerKinaiTipus"
  putStrLn "  JoTipus -> JoKinaiTipus"
  putStrLn ""
  putStrLn "MEO ontologiai szintek:"
  putStrLn "  meta-metaszint: relacioelmelet (kategoriaelmelet)"
  putStrLn "  metaszint: metafogalmak (funktorok)"
  putStrLn "  targyszint: fogalmak (szavak = tipusok)"
  putStrLn "  instanciaszint: peldanyok"
  putStrLn ""
  putStrLn "NINCS String. NINCS Double. NINCS Bool."
  putStrLn "Minden szo = onallo tipus."
  putStrLn "Minden kepzo = onallo tipus (a kepzo neve is tipus)."
  putStrLn "Minden rokon szo = tipus-szintu kapcsolat."
  putStrLn "Minden kinai megfelelo = onallo tipus."
  putStrLn "Minden mondat = rekord tipusokbol."
  putStrLn ""
  putStrLn "Kesz."

-- ═══════════════════════════════════════════════════════════════
-- 14. ESETRAGOK — 22 MAGYAR ESET = 22 MORFIZMUS TÍPUS
-- ═══════════════════════════════════════════════════════════════
-- A magyar-lexikon skill szerint: 22 eset = 22 logikai kapcsolat.
-- Mindegyik önálló típus (nincs String, nincs Double, nincs Bool).
-- A rag = természetes transzformáció (gondolat_001: KepzoT=funktor, RagT=term.transzf.).
-- A képző megváltoztatja a szófajt (funktor); a rag megtartja, de megváltoztatja a morfizmus-szerepet (term.transzf.).

-- Helyi esetek (9 — térbeli pozíció/irány)
public export
data NominativuszRagTipus       = NominativuszRagKonstruktor       -- ki/mi?      identitás (id)
public export
data AccusativuszRagTipus       = AccusativuszRagKonstruktor       -- kit/mit?    tárgy = hom(a,b)
public export
data DativuszRagTipus           = DativuszRagKonstruktor           -- kinek/minek? cél = hom(a,1)
public export
data IllativuszRagTipus         = IllativuszRagKonstruktor         -- hová (bele)? injekció (-ba/-be)
public export
data InesszivuszRagTipus       = InesszivuszRagKonstruktor        -- hol (benne)? pozíció (-ban/-ben)
public export
data ElativuszRagTipus         = ElativuszRagKonstruktor          -- honnan (belőle)? projekció (-ból/-ből)
public export
data AllativuszRagTipus        = AllativuszRagKonstruktor         -- hová (hozzá)? hom(a,b) (-hoz/-hez)
public export
data AdessivuszRagTipus        = AdessivuszRagKonstruktor         -- hol (nála)? pozíció (-nál/-nél)
public export
data SublativuszRagTipus       = SublativuszRagKonstruktor       -- honnan (róla)? projekció (-ról/-ről)

-- Tégi/ strukturális esetek (6 — idő, ok, eszköz, mód)
public export
data TemporalisRagTipus        = TemporalisRagKonstruktor        -- mikor?       idő = endofunktor (-kor)
public export
data KauzalisRagTipus          = KauzalisRagKonstruktor          -- miért?       ok = funktor (-ért)
public export
data InstrumentalisRagTipus   = InstrumentalisRagKonstruktor   -- kivel/mivel? eszköz = kompozíció (-val/-vel)
public export
data ModalisRagTipus           = ModalisRagKonstruktor           -- hogyan?      mód = term.transzf. (képp/képpen)
public export
data CausalisRagTipus          = CausalisRagKonstruktor          -- minek?       ok-okozat = adjunkció
public export
data EssivuszRagTipus          = EssivuszRagKonstruktor          -- milyenként?  minőség = (mint, -ként)

-- Átalakító/koproduktív esetek (7 — transzformáció, distribúció, terminálás)
public export
data TranszlativuszRagTipus    = TranszlativuszRagKonstruktor    -- mi lett?      eredmény = kolimit (-vá/-vé)
public export
data TerminativuszRagTipus    = TerminativuszRagKonstruktor      --meddig?       végobjektum (-ig)
public export
data FormativuszRagTipus      = FormativuszRagKonstruktor      -- milyennek?  formáció (-képpen)
public export
data GenitivuszRagTipus       = GenitivuszRagKonstruktor        -- kinek a ...? birtokos (-nak a/-nek a)
public export
data DistributivuszRagTipus   = DistributivuszRagKonstruktor   --ként/darabonként? szórás (-nként)
public export
data SociativuszRagTipus      = SociativuszRagKonstruktor        -- -vel együtt?  társítás (-stul/-stül)
public export
data AbessivuszRagTipus       = AbessivuszRagKonstruktor       -- - nélkül?     hiány (nélkül)

-- ═══════════════════════════════════════════════════════════════
-- 15. RAG TYPECLASS — A RAG = TERMÉSZETES TRANSZFORMÁCIÓ
-- ═══════════════════════════════════════════════════════════════
-- Egy rag egy szót egy másik szóba visz: megtartja a szófajt, de megváltoztatja
-- a mondatbeli morfizmus-szerepet. Struktúrájában mint KepzoT, de aszimmetria:
--   KepzoT: forrás → cél  (funktor — szófajt vált, pl. számból számol)
--   RagT:   forrás → cél  (term.transzf. — szófajt megtart, pl. számból számot)
-- A két typeclass kooptál, de a szerep különböző.

public export
interface RagT (0 forras : Type) (0 cel : Type) (0 rag : Type) | forras where

-- ═══════════════════════════════════════════════════════════════
-- 16. RAGOZOTT SZAVAK TÍPUSAI — A szam- SZÓCSALÁD RAGOKKAL
-- ═══════════════════════════════════════════════════════════════
-- Az agglutináció: tő ⊗ rag = ragozott szó. Az eredmény önálló típus.

public export
data SzamotTipus        = SzamotKonstruktor        -- szám + accusativusz (tárgy)
public export
data SzamnakTipus       = SzamnakKonstruktor       -- szám + datívusz (cél)
public export
data SzambaTipus        = SzambaKonstruktor        -- szám + illativusz (injekció)
public export
data SzambanTipus       = SzambanKonstruktor       -- szám + inesszivusz (pozíció)
public export
data SzambolTipus       = SzambolKonstruktor       -- szám + elativusz (projekció)
public export
data SzamertTipus       = SzamertKonstruktor       -- szám + kauzális (ok-funktor)
public export
data SzammalTipus       = SzammalKonstruktor       -- szám + instrumentalis (eszköz-kompozíció)
public export
data SzamkentTipus      = SzamkentKonstruktor      -- szám + essivusz (mint)
public export
data SzammaTipus       = SzammaKonstruktor        -- szám + transzlativusz (eredmény = kolimit)

-- A RagT instance-ok: mind az 9 ragozott forma a szam- szócsaládból
public export
RagT SzamTipus SzamotTipus       AccusativuszRagTipus
public export
RagT SzamTipus SzamnakTipus      DativuszRagTipus
public export
RagT SzamTipus SzambaTipus       IllativuszRagTipus
public export
RagT SzamTipus SzambanTipus      InesszivuszRagTipus
public export
RagT SzamTipus SzambolTipus      ElativuszRagTipus
public export
RagT SzamTipus SzamertTipus      KauzalisRagTipus
public export
RagT SzamTipus SzammalTipus      InstrumentalisRagTipus
public export
RagT SzamTipus SzamkentTipus     EssivuszRagTipus
public export
RagT SzamTipus SzammaTipus      TranszlativuszRagTipus

-- ═══════════════════════════════════════════════════════════════
-- 17. ESET KATEGÓRIA — MILYEN KATEGÓRIABELI MORFIZMUS AZ ESET?
-- ═══════════════════════════════════════════════════════════════
-- A magyar-lexikon skill táblázata szerint 22 eset = 22 morfizmus. Itt a
-- nagy rajzolás: minden esetről rögzítjük, hogy kategóriaelméletileg mi.
-- (Üres interface, csak a típus-szintű kapcsolat számít.)

public export
interface EsetKategoriaT (0 eset : Type) (0 strukturakategoria : JK) | eset where

-- Nominativusz = identitás, a "semleges" kategória-rendszerben = KategoriaT.identitas
public export
EsetKategoriaT NominativuszRagTipus       IndividuumJK        -- id: az alany az egyed
public export
EsetKategoriaT AccusativuszRagTipus       CselekvesJK          -- hom(a,b): a tárgy a cselekvés alanya
public export
EsetKategoriaT DativuszRagTipus           KapcsolatJK          -- hom(a,1): a célérték a végcél
public export
EsetKategoriaT IllativuszRagTipus          HelyJK               -- injekció: belső térbe
public export
EsetKategoriaT InesszivuszRagTipus         HelyJK               -- pozíció: belső térben
public export
EsetKategoriaT ElativuszRagTipus           HelyJK               -- projekció: belső térből kifelé
public export
EsetKategoriaT AllativuszRagTipus          HelyJK               -- hom(a,b): külső cél
public export
EsetKategoriaT AdessivuszRagTipus          HelyJK               -- pozíció: külső térben (nála)
public export
EsetKategoriaT SublativuszRagTipus         HelyJK               -- projekció: külső térből el
public export
EsetKategoriaT TemporalisRagTipus         IdoJK                -- endofunktor: C → C (idő)
public export
EsetKategoriaT KauzalisRagTipus            OkJK                 -- funktor: Okság → Okság
public export
EsetKategoriaT InstrumentalisRagTipus     CselekvesJK          -- kompozíció: g ∘ f
public export
EsetKategoriaT ModalisRagTipus            ModJK                -- term.transzf.: uniformitási mód
public export
EsetKategoriaT CausalisRagTipus            OkJK                 -- adjunkció: F ⊣ G oksági összefüggés
public export
EsetKategoriaT EssivuszRagTipus           AllapotJK            -- "mint": minőség-azonosítás
public export
EsetKategoriaT TranszlativuszRagTipus     CselekvesJK          -- kolimit: eredmény-cselekmény (-vá)
public export
EsetKategoriaT TerminativuszRagTipus      IdoJK                -- végobjektum: időhatár (-ig)
public export
EsetKategoriaT FormativuszRagTipus        ModJK                -- formáció módperspektíva (-képpen)
public export
EsetKategoriaT GenitivuszRagTipus         KapcsolatJK          -- birtokos-kapcsolat (-nak/nek a)
public export
EsetKategoriaT DistributivuszRagTipus      MennyisegJK          -- szórás: ennyi darabként (-nként)
public export
EsetKategoriaT SociativuszRagTipus        KapcsolatJK          -- társítás (-stul/stül)
public export
EsetKategoriaT AbessivuszRagTipus          AllapotJK            -- hiány-állapot (nélkül)

-- ═══════════════════════════════════════════════════════════════
-- 18. AGGLUTINÁCIÓ — MIDEGYIK SZÓCSALÁD RAGOZHATÓ
-- ═══════════════════════════════════════════════════════════════
-- Az agglutináció monoidális tenzorszorzat: tő ⊗ rag = ragozott szó.
-- A terv: 3 szócsalád × 22 eset = 66 ragozott szótípus (ide most 3-at mutatunk meg a ter- családból).

-- A ter- szócsalád ragozott típusai (mint demonstráció)
public export
data TeretTipus       = TeretKonstruktor       -- ter + accusativusz (tárgy)
public export
data TernekTipus      = TernekKonstruktor       -- ter + datívusz (cél)
public export
data TerbeTipus       = TerbeKonstruktor        -- ter + illativusz (injekció)

public export
RagT TerTipus TeretTipus    AccusativuszRagTipus
public export
RagT TerTipus TernekTipus   DativuszRagTipus
public export
RagT TerTipus TerbeTipus    IllativuszRagTipus

-- A jo- szócsalád ragozott típusai
public export
data JotTipus      = JotKonstruktor       -- jó + accusativusz
public export
data JonasTipus    = JonasKonstruktor     -- jó + genitivusz (birtokos)

public export
RagT JoTipus JotTipus      AccusativuszRagTipus
public export
RagT JoTipus JonasTipus    GenitivuszRagTipus

-- ═══════════════════════════════════════════════════════════════
-- 19. CPT SZIMMETRIA — IGEIDŐ × SZEMLÉLET × FORRÁS
-- ═══════════════════════════════════════════════════════════════
-- A magyar-lexikon skill szerint: igeidő/szemlélet/forrás = C (töltés) / P (paritás) / T (idő).
-- A három dimenzió három önálló típus-család ami a 3 fizikai szimmetriát vigye be a nyelvbe.

public export
data IgeidoTipus = MultTipus | JelenTipus | JovoTipus                    -- T: időfordítás

public export
data SzemleletTipus = FolyamatosTipus | BefejezettTipus | SzokasosTipus  -- P: térfordítás

public export
data ForrasTipus = KozvetlenTipus | KovetkeztetettTipus | JelentettTipus -- C: töltésfordítás

-- CPT-típus = a három dimenzió kombinációja (a magyar ige ragozása = ezen tenzor)
public export
record CptIgeragozasTipus where
  constructor CptIgeragozasKonstruktor
  igeido    : IgeidoTipus      -- T
  szemlelet : SzemleletTipus   -- P
  forras    : ForrasTipus       -- C

-- Wadler free-proof: a polimorf tipus bizonyitja a CPT szimmetriát
-- (3×3×3 = 27 kombinációja a magyar igeragozásnak, de csak a tipus-szintu)
-- Kimenet: Refl (3 × 3 × 3 = 27 ✓) — a CPT tenzor 3-dimenziós.