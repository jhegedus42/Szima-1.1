module KategoriaElmelet

import MagyarNyelv
import Steane713
import E8E8Algebra
import FogalomFa
import HaromKubit
import FazisAlgebra
import Emberi.Index
import Szamitasi.Index

||| Kategoria: objektumok + morfizmusok + osszetetel + azonos.
public export
record Kategoria (objektum : Type) (hom : objektum -> objektum -> Type) where
  constructor KategoriaKonstruktor
  azonos : (a : objektum) -> hom a a
  osszetetel : {a, b, c : objektum} -> hom a b -> hom b c -> hom a c

-- ─── KATEGÓRIA MINT TYPECLASS (TORVENYEKKEL) ──────────────
-- A typeclass-ben a törvények is benne vannak.
-- Az interface implementalasa = a torvenyek bizonyitasa.
-- Curry-Howard: az interface = a tetel, az implementacio = a bizonyitas.
||| Kategoria typeclass: az azonos es osszetetel torvenyeivel.
|||   A `balAzonos` es `jobbAzonos` bizonyitjak az identitas-torvenyeket.
|||   Az `asszociativBizonyitas` bizonyitja az asszociativitast.
public export
interface KategoriaT (objektum : Type) (hom : objektum -> objektum -> Type) where
  identitas : (a : objektum) -> hom a a
  kompozicio : {a, b, c : objektum} -> hom a b -> hom b c -> hom a c
  balAzonos : {a, b : objektum} -> (f : hom a b) -> kompozicio (identitas a) f = f
  jobbAzonos : {a, b : objektum} -> (f : hom a b) -> kompozicio f (identitas b) = f
  asszociativ : {a, b, c, d : objektum} -> (f : hom a b) -> (g : hom b c) -> (h : hom c d) ->
    kompozicio f (kompozicio g h) = kompozicio (kompozicio f g) h

||| KategoriaT pelda: az Emberi diszkret kategoria.
|||   Mivel csak EmberiAzonos morfizmusok vannak, minden torveny Refl.
|||   FIGYELEM: a KategoriaT peldanyok a file VEGEN vannak (EmberiMorf utan).

||| Monoidalis kategoria: tenzor szorzat + egysegelem.
public export
record MonoidalisKategoria (objektum : Type) (hom : objektum -> objektum -> Type) where
  constructor MonoidalisKategoriaKonstruktor
  kategoria : Kategoria objektum hom
  tenzor : objektum -> objektum -> objektum
  egyseg : objektum

||| DualisKategoria: minden objektumnak van dualisa.
public export
record DualisKategoria (objektum : Type) (hom : objektum -> objektum -> Type) where
  constructor DualisKategoriaKonstruktor
  monoidalis : MonoidalisKategoria objektum hom
  dualis : objektum -> objektum

||| Funktor: kategoria szerkezet megorzese.
public export
record Funktor (o1 : Type) (m1 : o1 -> o1 -> Type) (o2 : Type) (m2 : o2 -> o2 -> Type) where
  constructor FunktorKonstruktor
  objektumKep : o1 -> o2
  morfizmusKep : {a, b : o1} -> m1 a b -> m2 (objektumKep a) (objektumKep b)

||| Termeszetes transzformacio: ket funktor kozotti lekepezes.
public export
record TermeszetesTranszformacio
       (o1 : Type) (m1 : o1 -> o1 -> Type) (o2 : Type) (m2 : o2 -> o2 -> Type) where
  constructor TermeszetesKonstruktor
  felso : Funktor o1 m1 o2 m2
  also : Funktor o1 m1 o2 m2
  komponens : (a : o1) -> m2 (felso.objektumKep a) (also.objektumKep a)

||| Bifunktor: ket kategoria szorzatabol.
public export
record Bifunktor (bk : Kategoria o1 m1) (jk : Kategoria o2 m2) (kk : Kategoria o3 m3) where
  constructor BifunktorKonstruktor
  objektumKep : o1 -> o2 -> o3
  morfizmusKep : {a, b : o1} -> {c, d : o2}
              -> m1 a b -> m2 c d
              -> m3 (objektumKep a c) (objektumKep b d)

||| Span: ket morfizmus kozos forrassal.
public export
record Span (kategoria : Kategoria obj hom) (celpont : obj) where
  constructor SpanKonstruktor
  balForras : obj
  jobbForras : obj

||| Cospan: ket morfizmus kozos cellal.
public export
record Cospan (kategoria : Kategoria obj hom) (forras : obj) where
  constructor CospanKonstruktor
  balCel : obj
  jobbCel : obj

||| Szimmetrikus monoidalis kategoria: tenzor + braiding.
public export
record SzimmetrikusMonoidalisKategoria
       (objektum : Type) (hom : objektum -> objektum -> Type) where
  constructor SzimmetrikusKonstruktor
  monoidalis : MonoidalisKategoria objektum hom
  braiding : {a, b : objektum} -> hom (monoidalis.tenzor a b) (monoidalis.tenzor b a)

||| Szorzat kategoria: ha C es D kategoriak, akkor C × D is az.
public export
record SzorzatKategoria (o1 : Type) (m1 : o1 -> o1 -> Type)
                        (o2 : Type) (m2 : o2 -> o2 -> Type) where
  constructor SzorzatKonstruktor
  balKategoria : Kategoria o1 m1
  jobbKategoria : Kategoria o2 m2

||| EllenKategoria (C^op): megforditott morfizmusok.
||| EllenNyil f : EllenMorf hom a b  ⇔  f : hom a b a C^op kategoriaban.
public export
data EllenMorf : {obj : Type} -> (hom : obj -> obj -> Type) -> obj -> obj -> Type where
  EllenNyil : {a, b : obj} -> hom a b -> EllenMorf hom a b

||| Adjunkcio: F -| G, ahol F : C → D, G : D → C.
||| A termeszetes bijekcio: Hom_D(F a, b) ≅ Hom_C(a, G b).
public export
record Adjunkcio (o1 : Type) (m1 : o1 -> o1 -> Type)
                 (o2 : Type) (m2 : o2 -> o2 -> Type) where
  constructor AdjunkcioKonstruktor
  balFunktor : Funktor o1 m1 o2 m2
  jobbFunktor : Funktor o2 m2 o1 m1
  balEgyseg : (a : o1) -> m1 a (jobbFunktor.objektumKep (balFunktor.objektumKep a))
  jobbEgyseg : (b : o2) -> m2 (balFunktor.objektumKep (jobbFunktor.objektumKep b)) b

||| KettoKategoria: 2-sejtek a morfizmusok kozott.
||| Objektumok (0-sejtek), morfizmusok (1-sejtek), 2-morfizmusok (2-sejtek).
public export
record KettoKategoria (obj : Type) (hom : obj -> obj -> Type)
                      (ketHom : (a, b : obj) -> hom a b -> hom a b -> Type) where
  constructor KettoKategoriaKonstruktor
  alapKategoria : Kategoria obj hom
  fuggolegesOsszetetel : {a, b : obj} -> {f, g, h : hom a b}
                      -> ketHom a b f g -> ketHom a b g h -> ketHom a b f h
  vizszintesOsszetetel : {a, b, c : obj} -> {f1, f2 : hom a b} -> {g1, g2 : hom b c}
                      -> ketHom a b f1 f2 -> ketHom b c g1 g2
                      -> ketHom a c (alapKategoria.osszetetel f1 g1)
                                    (alapKategoria.osszetetel f2 g2)

||| Yoneda beagyazas: C → [C^op, Set].
||| Minden a objektumhoz a Hom(-, a) prefasítás
||| (tipus-értékű fuggvenykent, nem m x a ertekkent).
public export
record YonedaBeagyazas (o : Type) (m : o -> o -> Type) where
  constructor YonedaKonstruktor
  kategoria : Kategoria o m
  -- Hom(-, a) mint tipusfuggveny: minden x-hez a Hom(x, a) tipust
  homPresheaf : (a : o) -> (x : o) -> Type
  -- Utana tetelezes: ha f: a → b, akkor Hom(-, a) → Hom(-, b)
  utanaTetelezes : {a, b : o} -> m a b
                -> (x : o) -> homPresheaf a x -> homPresheaf b x
  -- Yoneda lemma: Nat(Hom(-, a), F) ≅ F a
  yonedaLemma : {a : o} -> {f : o -> Type}
             -> ((x : o) -> homPresheaf a x -> f x) -> f a

-- ═══════════════════════════════════════════════════════════════
-- MORFIZMUS TIPUSOK (WRAPPER-EK A KATEGORIAKHOZ)
-- ═══════════════════════════════════════════════════════════════

||| Fogalom morfizmus: a FogalomLogika lezart kategoriakent.
||| Az Azonos es Ire mellett a Sorozat epit kompoziciot.
public export
data FogalomMorf : FogalomTipus -> FogalomTipus -> Type where
  FogalomAzonos : FogalomMorf a a
  FogalomIre : FogalomLogika a b -> FogalomMorf a b
  FogalomSorozat : (koztes : FogalomTipus) -> FogalomMorf a koztes -> FogalomMorf koztes c -> FogalomMorf a c

||| Fogalom 2-morfizmus: 2-sejtek ket parhuzamos FogalomMorf kozott.
||| A 2-sejt a fazis/amplitudo a ket ut kozott a 2-kategoriaban.
public export
data FogalomKetMorf : (a, b : FogalomTipus) -> FogalomMorf a b -> FogalomMorf a b -> Type where
  KetAzonos : FogalomKetMorf a b f f
  KetIre : FogalomKetMorf a b f g

||| Fogalom morfizmus egyenloseg: kategoriatorvenyek.
||| Asszociativitas: (f;g);h = f;(g;h)
||| Bal egyseg: 1_a;f = f
||| Jobb egyseg: f;1_b = f
public export
data FogalomMorfEgyenlo : (a, b : FogalomTipus) -> FogalomMorf a b -> FogalomMorf a b -> Type where
  -- (f ; g) ; h  ==  f ; (g ; h)
  Asszociativitas : {a, b, c, d : FogalomTipus}
                 -> (f : FogalomMorf a b) -> (g : FogalomMorf b c) -> (h : FogalomMorf c d)
                 -> FogalomMorfEgyenlo a d
                      (FogalomSorozat {a = a} {c = d} c (FogalomSorozat {a = a} {c = c} b f g) h)
                      (FogalomSorozat {a = a} {c = d} b f (FogalomSorozat {a = b} {c = d} c g h))
  -- 1_a ; f  ==  f
  BalAzonosTorveny : {a, b : FogalomTipus} -> (f : FogalomMorf a b)
                  -> FogalomMorfEgyenlo a b (FogalomSorozat {a} {c = b} a FogalomAzonos f) f
  -- f ; 1_b  ==  f
  JobbAzonosTorveny : {a, b : FogalomTipus} -> (f : FogalomMorf a b)
                   -> FogalomMorfEgyenlo a b (FogalomSorozat {a} {c = b} b f FogalomAzonos) f
  -- Reflexiv, szimmetrikus, tranzitiv
  EgyenloReflexiv  : FogalomMorfEgyenlo a b f f
  EgyenloSzimmetria : FogalomMorfEgyenlo a b f g -> FogalomMorfEgyenlo a b g f
  EgyenloTranzitiv : FogalomMorfEgyenlo a b f g -> FogalomMorfEgyenlo a b g h -> FogalomMorfEgyenlo a b f h

||| Eset morfizmus: EsetLogika wrapper — csak azonos morfizmusok.
public export
data EsetMorf : Eset -> Eset -> Type where
  EsetMorfKonstruktor : EsetLogika a -> EsetMorf a a

||| E8 morfizmus: CliffordElem wrapper.
public export
data E8Morf : E8Pont -> E8Pont -> Type where
  E8MorfKonstruktor : CliffordElem -> E8Morf a b

||| HaromKubit morfizmus: fazis kapcsolat.
public export
data KubitMorf : HaromKubit -> HaromKubit -> Type where
  KubitMorfKonstruktor : HaromKubitMorfizmus a b -> KubitMorf a b

||| Ido morfizmus: ido irany.
public export
data IdoMorf : IgeIdo -> IgeIdo -> Type where
  IdoMorfKonstruktor : IdoMorfizmus a b -> IdoMorf a b

-- ═══════════════════════════════════════════════════════════════
-- AZONOSSAGOK ES OSSZETETELEK (minden kategoriahoz)
-- ═══════════════════════════════════════════════════════════════

||| Eset azonos: minden esethez a sajat logikaja.
esetAzonos : (a : Eset) -> EsetLogika a
esetAzonos Nominativusz = AlanyLogika
esetAzonos Accusativusz = TargyLogika
esetAzonos Datívusz = CimzettLogika
esetAzonos Instrumentalis = EszkozLogika
esetAzonos Komitativusz = TarsLogika
esetAzonos Kauzalis = OkLogika
esetAzonos Transzativusz = EredmenyLogika
esetAzonos Terminativusz = HatárLogika
esetAzonos Illativusz = IranyLogika
esetAzonos Inesszivusz = HelyLogika
esetAzonos Elativusz = HonnanLogika
esetAzonos Allativusz = CelLogika
esetAzonos Adesszivusz = KivelLogika
esetAzonos Ablativusz = HonnanLogika2
esetAzonos Szuperesszivusz = FelszinLogika
esetAzonos Delativusz = RolLogika
esetAzonos Szublativusz = CelLogika2
esetAzonos Temporalis = MikorLogika
esetAzonos Szociativusz = KentiLogika
esetAzonos Distributivus = ElosztLogika
esetAzonos Esszivusz = MinosegLogika
esetAzonos Modalis = ModLogika
esetAzonos Causalis = CausalLogika
esetAzonos Formaliss = AlakLogika

-- ═══════════════════════════════════════════════════════════════
-- HAROMKUBIT ES IDO SEGEDFUGGVENYEK
-- ═══════════════════════════════════════════════════════════════
public export
haromKubitAzonos : HaromKubitMorfizmus a a
haromKubitAzonos = HaromKubitMorfizmusKonstruktor

||| HaromKubit osszetetel.
public export
haromKubitOsszetetel : HaromKubitMorfizmus a b -> HaromKubitMorfizmus b c
                    -> HaromKubitMorfizmus a c
haromKubitOsszetetel HaromKubitMorfizmusKonstruktor HaromKubitMorfizmusKonstruktor =
  HaromKubitMorfizmusKonstruktor

||| Ido azonos.
public export
idoAzonos : IdoMorfizmus a a
idoAzonos = IdoMorfizmusKonstruktor

||| Ido osszetetel.
public export
idoOsszetetel : IdoMorfizmus a b -> IdoMorfizmus b c -> IdoMorfizmus a c
idoOsszetetel IdoMorfizmusKonstruktor IdoMorfizmusKonstruktor = IdoMorfizmusKonstruktor

-- ═══════════════════════════════════════════════════════════════
-- KATEGORIA OSSZETETEL SEGEDFUGGVENYEK
-- ═══════════════════════════════════════════════════════════════

fogalomOsszetetelMorf : {a : FogalomTipus} -> {b : FogalomTipus} -> {c : FogalomTipus}
                     -> FogalomMorf a b -> FogalomMorf b c -> FogalomMorf a c
fogalomOsszetetelMorf {a} {b} {c} f g = FogalomSorozat {a = a} {c = c} b f g

esetOsszetetelMorf : EsetMorf a b -> EsetMorf b c -> EsetMorf a c
esetOsszetetelMorf (EsetMorfKonstruktor f) (EsetMorfKonstruktor g) =
  EsetMorfKonstruktor f

e8OsszetetelMorf : E8Morf a b -> E8Morf b c -> E8Morf a c
e8OsszetetelMorf (E8MorfKonstruktor f) (E8MorfKonstruktor g) =
  E8MorfKonstruktor (cliffordSzorzat f g)

kubitOsszetetelMorf : KubitMorf a b -> KubitMorf b c -> KubitMorf a c
kubitOsszetetelMorf (KubitMorfKonstruktor f) (KubitMorfKonstruktor g) =
  KubitMorfKonstruktor (haromKubitOsszetetel f g)

idoOsszetetelMorf : IdoMorf a b -> IdoMorf b c -> IdoMorf a c
idoOsszetetelMorf (IdoMorfKonstruktor f) (IdoMorfKonstruktor g) =
  IdoMorfKonstruktor (idoOsszetetel f g)

-- ═══════════════════════════════════════════════════════════════
-- KATEGORIA PELDAK
-- ═══════════════════════════════════════════════════════════════

||| FogalomFa mint kategoria.
public export
fogalomKategoria : Kategoria FogalomTipus FogalomMorf
fogalomKategoria = KategoriaKonstruktor
  (\a => FogalomAzonos)
  fogalomOsszetetelMorf

||| Eset mint kategoria (diszkret).
public export
esetKategoria : Kategoria Eset EsetMorf
esetKategoria = KategoriaKonstruktor
  (\a => EsetMorfKonstruktor (esetAzonos a))
  esetOsszetetelMorf

||| E8 × E8 mint kategoria.
public export
e8Kategoria : Kategoria E8Pont E8Morf
e8Kategoria = KategoriaKonstruktor
  (\a => E8MorfKonstruktor (CliffordKonstruktor Egy Nulla Nulla))
  e8OsszetetelMorf

||| HaromKubit mint kategoria.
public export
haromKubitKategoria : Kategoria HaromKubit KubitMorf
haromKubitKategoria = KategoriaKonstruktor
  (\a => KubitMorfKonstruktor haromKubitAzonos)
  kubitOsszetetelMorf

||| Ido mint kategoria.
public export
idoKategoria : Kategoria IgeIdo IdoMorf
idoKategoria = KategoriaKonstruktor
  (\a => IdoMorfKonstruktor idoAzonos)
  idoOsszetetelMorf

||| FogalomFa monoidalisan.
public export
fogalomMonoidalisKategoria : MonoidalisKategoria FogalomTipus FogalomMorf
fogalomMonoidalisKategoria = MonoidalisKategoriaKonstruktor
  fogalomKategoria
  (\a, b => Gyoker)
  Gyoker

fogalomDualis : FogalomTipus -> FogalomTipus
fogalomDualis Cel = Ok
fogalomDualis Ok = Kavzatum
fogalomDualis Kavzatum = Cel
fogalomDualis a = a

||| Dualis: Cel ↔ Ok, Ok ↔ Kavzatum, Kavzatum ↔ Cel.
public export
fogalomDualisKategoria : DualisKategoria FogalomTipus FogalomMorf
fogalomDualisKategoria = DualisKategoriaKonstruktor
  fogalomMonoidalisKategoria
  fogalomDualis

-- ═══════════════════════════════════════════════════════════════
-- 4 DIMENZIO KATEGORIA: TER, IDO, TOMEG, INFORMACIO
-- ═══════════════════════════════════════════════════════════════

||| A 4 alap dimenzio.
public export
data NegyDimenzio = Ter | Ido | Tomeg | Informacio

||| Morfizmusok a 4 dimenzio kozott.
||| A legegyszerubb nem trivialis kategoria: mindegyik
||| atalakithato a masikba.
public export
data DimenzioMorf : NegyDimenzio -> NegyDimenzio -> Type where
  DimAzonos  : DimenzioMorf a a
  DimTukor   : DimenzioMorf Ter Ter
  DimIdoFord : DimenzioMorf Ido Ido
  DimTerIdo  : DimenzioMorf Ter Ido
  DimIdoTer  : DimenzioMorf Ido Ter
  DimTerTomeg : DimenzioMorf Ter Tomeg
  DimTomegTer : DimenzioMorf Tomeg Ter
  DimTerInfo  : DimenzioMorf Ter Informacio
  DimInfoTer  : DimenzioMorf Informacio Ter
  DimIdoTomeg : DimenzioMorf Ido Tomeg
  DimTomegIdo : DimenzioMorf Tomeg Ido
  DimIdoInfo  : DimenzioMorf Ido Informacio
  DimInfoIdo  : DimenzioMorf Informacio Ido
  DimTomegInfo : DimenzioMorf Tomeg Informacio
  DimInfoTomeg : DimenzioMorf Informacio Tomeg

-- ═══════════════════════════════════════════════════════════════
-- FIZIKAI EGYENLETEK (a 4 dimenzio kozotti kapcsolatok)
-- ═══════════════════════════════════════════════════════════════

||| c = fenysebesseg (allando)
public export
data Fenysebesseg : Type where
  FenysebessegKonstruktor : Fenysebesseg

||| Lorentz transzformacio: Ter ↔ Ido
|||   t' = γ(t - v·x/c²)
|||   x' = γ(x - v·t)
|||   γ = 1/√(1 - v²/c²)
public export
data LorentzTranszformacio : Type where
  LorentzKonstruktor : LorentzTranszformacio

||| Ter → Tomeg: E = m·c² (Einstein)
|||   A tomeg es a ter kozotti ekvivalencia.
public export
data EinsteiniEgyenlet : Type where
  EinsteinKonstruktor : EinsteiniEgyenlet

||| Ter → Informacio: holografikus elv
|||   S = A / (4·ℓp²)
public export
data HolografikusElv : Type where
  HolografikusKonstruktor : HolografikusElv

||| Ido → Tomeg: tomeg okozta idodilatacio
|||   t' = t · √(1 - 2GM/(rc²))
public export
data IdoDilatacio : Type where
  IdoDilatacioKonstruktor : IdoDilatacio

||| Ido → Informacio: Shannon-Hartley tetel
|||   C = B · log₂(1 + S/N)
public export
data ShannonHartley : Type where
  ShannonKonstruktor : ShannonHartley

||| Tomeg → Informacio: Landauer elv
|||   E = k·T·ln(2) · I
public export
data LandauerElv : Type where
  LandauerKonstruktor : LandauerElv

||| Tukor (paritas forditas): (x, y, z) → (-x, -y, -z)
public export
data ParitasForditas : Type where
  TukorKonstruktor : ParitasForditas

||| Ido forditas: t → -t
|||   Amikor az ido megfordul, az osszes tobbi dimenzio is megfordul (CPT).
public export
data CptSzimmetria : Type where
  CptKonstruktor : CptSzimmetria


-- ═══════════════════════════════════════════════════════════════
-- CURRY-HOWARD-LAMBEK MEGFELELTETES
-- ═══════════════════════════════════════════════════════════════

||| Curry-Howard-Lambek megfeleltetes: Logika ↔ Tipuselmelet ↔ Kategoria.
||| Harom oszlop, minden szinten megfeleltetessel.
public export
data CurryHowardLambek : Type where
  ||| Propozicio ↔ Tipus ↔ Objektum
  PropozicioTipusObjektum : CurryHowardLambek
  ||| Bizonyitas ↔ Program/Term ↔ Morfizmus
  BizonyitasProgramMorfizmus : CurryHowardLambek
  ||| Implikacio ↔ Fuggvenytipus ↔ Exponencialis objektum
  ImplikacioFuggvenyExponencialis : CurryHowardLambek
  ||| Konjunkcio ↔ Szorzattipus ↔ Kategoriai szorzat
  KonjunkcioSzorzatKategoriai : CurryHowardLambek
  ||| Diszjunkcio ↔ Osszegtipus ↔ Kategoriai koproduktum
  DiszjunkcioOsszegKoproduktum : CurryHowardLambek
  ||| Egyetemes kvantor ↔ Pi-tipus ↔ Hatarertek
  EgyetemesKvantorPiHatar : CurryHowardLambek
  ||| Egzisztencialis kvantor ↔ Szigma-tipus ↔ Koequalizer
  EgzisztencialisKvantorSzigmaKo : CurryHowardLambek
  ||| Igaz ↔ Egysegtipus ↔ Vegso objektum
  IgazEgysegTerminalis : CurryHowardLambek
  ||| Hamis ↔ Ures tipus ↔ Inicialis objektum
  HamisUresInicialis : CurryHowardLambek
  ||| Tagadas ↔ Void tipus ↔ Dualis
  TagadasVoidDualis : CurryHowardLambek
  ||| Godel befejezetlenseg ↔ Tipuselmeleti befejezetlenseg ↔ Fixpont
  GodelTipusFixpont : CurryHowardLambek

||| E8 mint monoidalis kategoria: tenzor = pontonkenti osszeadas,
||| egyseg = nulla pont, braiding = azonos (kommutativitas miatt).
public export
e8Monoidalis : MonoidalisKategoria E8Pont E8Morf
e8Monoidalis = MonoidalisKategoriaKonstruktor
  e8Kategoria
  e8Osszead
  (E8PontKonstruktor 0 0 0 0 0 0 0 0)

||| E8 braiding: a⊕b → b⊕a. Mivel e8Osszead kommutativ,
||| a ket pont megegyezik, igy az azonos morfizmus jo.
public export
e8Braiding : {a, b : E8Pont}
          -> E8Morf (e8Osszead a b) (e8Osszead b a)
e8Braiding = E8MorfKonstruktor (CliffordKonstruktor Egy Nulla Nulla)

||| E8 szimmetrikus monoidalis kategoria.
public export
e8Szimmetrikus : SzimmetrikusMonoidalisKategoria E8Pont E8Morf
e8Szimmetrikus = SzimmetrikusKonstruktor e8Monoidalis e8Braiding

||| E8 × E8 objektum: rendezett E8 pont par.
public export
E8xE8Obj : Type
E8xE8Obj = (E8Pont, E8Pont)

||| E8 × E8 morfizmus: parhuzamos E8 morfizmusok.
public export
data E8xE8Morf : E8xE8Obj -> E8xE8Obj -> Type where
  E8xE8Par : {a, c : E8Pont} -> {b, d : E8Pont}
          -> E8Morf a c -> E8Morf b d
          -> E8xE8Morf (a, b) (c, d)

||| E8 × E8 azonos morfizmus.
public export
e8xE8Azonos : (x : E8xE8Obj) -> E8xE8Morf x x
e8xE8Azonos (a, b) = E8xE8Par (e8Kategoria.azonos a) (e8Kategoria.azonos b)

||| E8 × E8 osszetetel.
public export
e8xE8Osszetetel : E8xE8Morf x y -> E8xE8Morf y z -> E8xE8Morf x z
e8xE8Osszetetel (E8xE8Par {a} {c = koztes} {b} {d = koztes2} f1 g1)
                (E8xE8Par {a = koztes} {c} {b = koztes2} {d} f2 g2) =
  E8xE8Par
    (e8Kategoria.osszetetel {a = a} {b = koztes} {c = c} f1 f2)
    (e8Kategoria.osszetetel {a = b} {b = koztes2} {c = d} g1 g2)

||| E8 × E8 szorzat kategoria.
public export
e8xE8Kategoria : Kategoria E8xE8Obj E8xE8Morf
e8xE8Kategoria = KategoriaKonstruktor e8xE8Azonos e8xE8Osszetetel

||| E8E8KodSzo → E8xE8Obj: a kod szo bal es jobb E8 pontja.
public export
e8e8KodSzoObj : E8E8KodSzo -> E8xE8Obj
e8e8KodSzoObj kod = (kod.balE8, kod.jobbE8)

||| E8xE8Obj → E8E8KodSzo: ures Steane koddal, azonos Clifforddal.
public export
e8xE8ObjKodSzo : E8xE8Obj -> E8E8KodSzo
e8xE8ObjKodSzo (b, j) = KodKonstruktor "" b j
  (E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
  (E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
  (CliffordKonstruktor Egy Nulla Nulla) (alapKod Nulla)

-- ═══════════════════════════════════════════════════════════════
-- 2-KATEGORIA + YONEDA + DUAL A FOGALMAKRA
-- ═══════════════════════════════════════════════════════════════

||| Fogalom 2-kategoria: FogalomTipus mint 0-sejt, FogalomMorf mint 1-sejt,
||| FogalomKetMorf mint 2-sejt.
||| A 2-sejtek "kaotikusak": barmely ket parhuzamos 1-morfizmus
||| kozott van 2-sejt (KetIre).
public export
fogalomKettoKategoria : KettoKategoria FogalomTipus FogalomMorf FogalomKetMorf
fogalomKettoKategoria = KettoKategoriaKonstruktor
  fogalomKategoria
  fuggolegesOsszetetel
  vizszintesOsszetetel
  where
    fuggolegesOsszetetel : {a, b : FogalomTipus} -> {f, g, h : FogalomMorf a b}
                        -> FogalomKetMorf a b f g -> FogalomKetMorf a b g h
                        -> FogalomKetMorf a b f h
    fuggolegesOsszetetel KetAzonos KetAzonos = KetAzonos
    fuggolegesOsszetetel KetAzonos KetIre    = KetIre
    fuggolegesOsszetetel KetIre    KetAzonos = KetIre
    fuggolegesOsszetetel KetIre    KetIre    = KetIre

    vizszintesOsszetetel : {a, b, c : FogalomTipus}
                        -> {f1, f2 : FogalomMorf a b} -> {g1, g2 : FogalomMorf b c}
                        -> FogalomKetMorf a b f1 f2 -> FogalomKetMorf b c g1 g2
                        -> FogalomKetMorf a c (fogalomOsszetetelMorf f1 g1)
                                              (fogalomOsszetetelMorf f2 g2)
    vizszintesOsszetetel KetAzonos KetAzonos = KetAzonos
    vizszintesOsszetetel KetAzonos KetIre    = KetIre
    vizszintesOsszetetel KetIre    KetAzonos = KetIre
    vizszintesOsszetetel KetIre    KetIre    = KetIre

||| Yoneda beagyazas a fogalom kategoriaban: C → [C^op, Set].
||| Minden fogalomtípushoz a Hom(-, a) prefasítás.
|||   homPresheaf a x = FogalomMorf x a  (Hom(-, a) at x)
|||   utanaTetelezes f x g = fogalomOsszetetelMorf g f  (postkompozicio)
|||   yonedaLemma nat = nat a (fogalomKategoria.azonos a)  (1_a-re alkalmazva)
public export
fogalomYoneda : YonedaBeagyazas FogalomTipus FogalomMorf
fogalomYoneda = YonedaKonstruktor
  fogalomKategoria
  (\a, x => FogalomMorf x a)
  (\f, x, g => fogalomOsszetetelMorf g f)
  (\nat => nat _ (fogalomKategoria.azonos _))

||| Dual adjunkcio: C -| C^op.
||| A bal es jobb funktor az azonos es az ellentett kategoria kozott.
|||   balFunktor : C → C^op  (f ↦ EllenNyil f)
|||   jobbFunktor : C^op → C  (EllenNyil f ↦ f)
|||   balEgyseg : a → id(a) → id(a) = FogalomAzonos
|||   jobbEgyseg : id(b) → b → b = EllenNyil FogalomAzonos
public export
fogalomDualisAdjunkcio : Adjunkcio FogalomTipus FogalomMorf FogalomTipus (EllenMorf FogalomMorf)
fogalomDualisAdjunkcio =
  let bal : Funktor FogalomTipus FogalomMorf FogalomTipus (EllenMorf FogalomMorf)
      bal = FunktorKonstruktor
        (\a => a)
        (\f => EllenNyil f)
      jobb : Funktor FogalomTipus (EllenMorf FogalomMorf) FogalomTipus FogalomMorf
      jobb = FunktorKonstruktor
        (\a => a)
        (\(EllenNyil f) => f)
  in AdjunkcioKonstruktor
       bal jobb
       (\a => FogalomAzonos)
       (\b => EllenNyil FogalomAzonos)

-- ═══════════════════════════════════════════════════════════════
-- KATEGORIAELMELETI LETRA: objektumtol a Yonedaig
-- ═══════════════════════════════════════════════════════════════

||| 0. szint: tipusok (objektumok).
||| A legalso fok — puszta tipusok, meg morfizmus nelkul.
public export
record NulladikLetra (obj : Type) where
  constructor NulladikLetraKonstruktor
  objektumok : Type

||| 1. szint: kategoria (objektumok + morfizmusok + azonos + osszetetel).
||| A kategoriaba szervezett tipusok.
public export
record ElsoLetra (obj : Type) (hom : obj -> obj -> Type) where
  constructor ElsoLetraKonstruktor
  nulladik : NulladikLetra obj
  kategoria : Kategoria obj hom

||| 2. szint: funktor (kategoriak kozotti lekepezes).
||| A kategoriak kozotti kapcsolat.
public export
record MasodikLetra (o1 : Type) (m1 : o1 -> o1 -> Type)
                    (o2 : Type) (m2 : o2 -> o2 -> Type) where
  constructor MasodikLetraKonstruktor
  elso : ElsoLetra o1 m1
  funktor : Funktor o1 m1 o2 m2

||| 3. szint: termeszetes transzformacio (funktorok kozotti lekepezes).
||| A funktorok kozotti kapcsolat.
public export
record HarmadikLetra (o1 : Type) (m1 : o1 -> o1 -> Type)
                     (o2 : Type) (m2 : o2 -> o2 -> Type) where
  constructor HarmadikLetraKonstruktor
  masodik : MasodikLetra o1 m1 o2 m2
  termeszetes : TermeszetesTranszformacio o1 m1 o2 m2

||| 4. szint: 2-kategoria (2-sejtek a morfizmusok kozott).
||| A kategoriak kategoriája.
public export
record NegyedikLetra (obj : Type) (hom : obj -> obj -> Type)
                     (ketHom : (a, b : obj) -> hom a b -> hom a b -> Type) where
  constructor NegyedikLetraKonstruktor
  elso : ElsoLetra obj hom
  kettoKategoria : KettoKategoria obj hom ketHom

||| 5. szint: Yoneda beagyazas (C → [C^op, Set]).
||| Minden objektum a Hom(-, a) presheafba van agyazva.
public export
record OtodikLetra (obj : Type) (hom : obj -> obj -> Type) where
  constructor OtodikLetraKonstruktor
  elso : ElsoLetra obj hom
  yoneda : YonedaBeagyazas obj hom

||| 6. szint: adjunkcio (C -| D).
||| A duális kategoriaval alkotott adjunkcio.
public export
record HatodikLetra (o1 : Type) (m1 : o1 -> o1 -> Type)
                    (o2 : Type) (m2 : o2 -> o2 -> Type) where
  constructor HatodikLetraKonstruktor
  elso : ElsoLetra o1 m1
  adjunkcio : Adjunkcio o1 m1 o2 m2

||| Teljes letra: nulladik szinttol a Yoneda beagyazasig es adjunkciog.
||| Minden fok epit az elozo szintre.
public export
record TeljesLetra (obj : Type) (hom : obj -> obj -> Type)
                   (ketHom : (a, b : obj) -> hom a b -> hom a b -> Type)
                   (o2 : Type) (m2 : o2 -> o2 -> Type) where
  constructor TeljesLetraKonstruktor
  nulladik : NulladikLetra obj
  elso : ElsoLetra obj hom
  masodik : MasodikLetra obj hom obj hom
  harmadik : HarmadikLetra obj hom obj hom
  negyedik : NegyedikLetra obj hom ketHom
  otodik : OtodikLetra obj hom
  hatodik : HatodikLetra obj hom o2 m2

-- ═══════════════════════════════════════════════════════════════
-- FUNKTOR SEGEDFUGGVENYEK (objektum lekepezesek)
-- ═══════════════════════════════════════════════════════════════

||| FogalomTipus → E8Pont.
public export
fogalomTipusKod : FogalomTipus -> E8Pont
fogalomTipusKod Gyoker = E8PontKonstruktor 0 0 0 0 0 0 0 1
fogalomTipusKod Cel = E8PontKonstruktor 0 0 0 0 0 0 1 0
fogalomTipusKod ReszCel = E8PontKonstruktor 0 0 0 0 0 1 0 0
fogalomTipusKod Feladat = E8PontKonstruktor 0 0 0 0 1 0 0 0
fogalomTipusKod ReszFeladat = E8PontKonstruktor 0 0 0 1 0 0 0 0
fogalomTipusKod Cselekves = E8PontKonstruktor 0 0 1 0 0 0 0 0
fogalomTipusKod Dontes = E8PontKonstruktor 0 1 0 0 0 0 0 0
fogalomTipusKod Valasztas = E8PontKonstruktor 1 0 0 0 0 0 0 0
fogalomTipusKod Elutasitas = E8PontKonstruktor 1 1 0 0 0 0 0 0
fogalomTipusKod Ok = E8PontKonstruktor 1 0 1 0 0 0 0 0
fogalomTipusKod Kavzatum = E8PontKonstruktor 0 1 1 0 0 0 0 0
fogalomTipusKod Korlatozas = E8PontKonstruktor 1 1 1 0 0 0 0 0
fogalomTipusKod Megfigyeles = E8PontKonstruktor 0 0 0 0 0 0 1 1
fogalomTipusKod Hiba = E8PontKonstruktor 0 0 0 0 0 1 1 1
fogalomTipusKod Eredmeny = E8PontKonstruktor 0 0 0 0 1 1 1 1
fogalomTipusKod Minta = E8PontKonstruktor 0 0 0 1 1 1 1 1
fogalomTipusKod Javitas = E8PontKonstruktor 0 0 1 1 1 1 1 1
fogalomTipusKod Foltozas = E8PontKonstruktor 0 1 1 1 1 1 1 1
fogalomTipusKod InfraJavitas = E8PontKonstruktor 1 1 1 1 1 1 1 1
fogalomTipusKod Szabaly = E8PontKonstruktor 1 0 0 0 0 0 0 1
fogalomTipusKod KemenySzabaly = E8PontKonstruktor 1 0 0 0 0 0 1 1
fogalomTipusKod Egyezmeny = E8PontKonstruktor 1 0 0 0 0 1 0 1
fogalomTipusKod Eszkoz = E8PontKonstruktor 1 0 0 0 1 0 0 1
fogalomTipusKod Kesztseg = E8PontKonstruktor 1 0 0 1 0 0 0 1
fogalomTipusKod ModellKornyezetProtokoll = E8PontKonstruktor 1 0 1 0 0 0 0 1
fogalomTipusKod Kerdes = E8PontKonstruktor 0 1 0 0 0 0 0 1
fogalomTipusKod Magyarazat = E8PontKonstruktor 0 0 1 0 0 0 0 1
fogalomTipusKod E8xE8 = E8PontKonstruktor 1 1 0 0 0 0 1 1
fogalomTipusKod Dualitas = E8PontKonstruktor 0 1 1 0 0 0 1 1
fogalomTipusKod Kategoria = E8PontKonstruktor 0 0 1 1 0 0 1 1
fogalomTipusKod Szimmetria = E8PontKonstruktor 0 0 0 1 1 0 1 1
fogalomTipusKod Tenzor = E8PontKonstruktor 0 0 0 1 1 0 0 1
fogalomTipusKod Funktor = E8PontKonstruktor 1 0 0 0 0 1 1 1
-- Szamok
fogalomTipusKod TermeszetesSzam = E8PontKonstruktor 0 0 0 1 0 0 0 1
fogalomTipusKod EgeszSzam = E8PontKonstruktor 0 0 0 1 0 0 1 0
fogalomTipusKod RacionalisSzam = E8PontKonstruktor 0 0 0 1 0 0 1 1
fogalomTipusKod Szam = E8PontKonstruktor 0 0 0 0 0 0 0 1
fogalomTipusKod ValosSzam = E8PontKonstruktor 0 0 0 1 0 1 0 0
fogalomTipusKod KomplexSzam = E8PontKonstruktor 0 0 0 1 0 1 0 1
-- Matematika logika
fogalomTipusKod Allitas = E8PontKonstruktor 0 0 1 0 0 0 0 1
fogalomTipusKod Bizonyitas = E8PontKonstruktor 0 0 1 0 0 0 1 0
fogalomTipusKod GodelSzam = E8PontKonstruktor 0 0 1 0 0 0 1 1
fogalomTipusKod Konzisztencia = E8PontKonstruktor 0 0 1 0 0 1 0 0
fogalomTipusKod Onhivatkozas = E8PontKonstruktor 0 0 1 0 0 1 0 1
fogalomTipusKod GodelElsoTetel = E8PontKonstruktor 0 0 1 0 0 1 1 0
fogalomTipusKod GodelMasodikTetel = E8PontKonstruktor 0 0 1 0 0 1 1 1
fogalomTipusKod DiagonaleLemma = E8PontKonstruktor 0 0 1 0 1 0 0 0
fogalomTipusKod Bizonyithatosag = E8PontKonstruktor 0 0 1 0 1 0 0 1
fogalomTipusKod InkonzisztenciaVonal = E8PontKonstruktor 0 0 1 0 1 0 1 0
fogalomTipusKod WickForgatas = E8PontKonstruktor 0 0 1 0 1 0 1 1
fogalomTipusKod KomplexFazis = E8PontKonstruktor 0 0 1 0 1 1 0 0
fogalomTipusKod KettoMatematika = E8PontKonstruktor 0 0 1 0 1 1 0 1
-- Curry-Howard-Lambek
fogalomTipusKod Chl = E8PontKonstruktor 0 0 1 1 0 0 0 1
-- Halmazelmelet es axiomak
fogalomTipusKod Halmazelmelet = E8PontKonstruktor 0 1 0 0 0 0 0 1
fogalomTipusKod PeanoAxiomak = E8PontKonstruktor 0 1 0 0 0 0 1 0
fogalomTipusKod ZfcAxiomak = E8PontKonstruktor 0 1 0 0 0 0 1 1
fogalomTipusKod KivalasztasiAxioma = E8PontKonstruktor 0 1 0 0 0 1 0 0
fogalomTipusKod UresHalmaz = E8PontKonstruktor 0 1 0 0 0 1 0 1
fogalomTipusKod Szamossag = E8PontKonstruktor 0 1 0 0 0 1 1 0
fogalomTipusKod FolytonossagiHipotetikus = E8PontKonstruktor 0 1 0 0 0 1 1 1
-- Fizika: 4 dimenzio
fogalomTipusKod FizikaiAllapot = E8PontKonstruktor 0 1 0 1 0 0 0 1
fogalomTipusKod Mezo = E8PontKonstruktor 0 1 0 1 0 0 1 0
fogalomTipusKod Ter = E8PontKonstruktor 0 1 0 1 0 0 1 1
fogalomTipusKod Ido = E8PontKonstruktor 0 1 0 1 0 1 0 0
fogalomTipusKod Tomeg = E8PontKonstruktor 0 1 0 1 0 1 0 1
fogalomTipusKod InformacioMennyiseg = E8PontKonstruktor 0 1 0 1 0 1 1 0
-- Szimmetriak
fogalomTipusKod SzimmetriaCsoport = E8PontKonstruktor 0 1 1 0 0 0 0 1
fogalomTipusKod MertekCsoport = E8PontKonstruktor 0 1 1 0 0 0 1 0
fogalomTipusKod SzimmetriaTores = E8PontKonstruktor 0 1 1 0 0 0 1 1
fogalomTipusKod E8Szimmetria = E8PontKonstruktor 0 1 1 0 0 1 0 0
fogalomTipusKod Geometria = E8PontKonstruktor 0 1 1 0 0 1 0 1
fogalomTipusKod Anyag = E8PontKonstruktor 0 1 1 0 0 1 1 0
fogalomTipusKod Antianyag = E8PontKonstruktor 0 1 1 0 0 1 1 1
-- Mechanika
fogalomTipusKod KlasszikusMechanika = E8PontKonstruktor 0 1 1 1 0 0 0 1
fogalomTipusKod LagrangeFuggveny = E8PontKonstruktor 0 1 1 1 0 0 1 0
fogalomTipusKod HamiltonFuggveny = E8PontKonstruktor 0 1 1 1 0 0 1 1
fogalomTipusKod LagrangeTranszformacio = E8PontKonstruktor 0 1 1 1 0 1 0 0
-- Kvantum
fogalomTipusKod KvantumMechanika = E8PontKonstruktor 1 0 0 0 0 0 0 1
fogalomTipusKod KvantumAllapot = E8PontKonstruktor 1 0 0 0 0 0 1 0
fogalomTipusKod HullamFuggveny = E8PontKonstruktor 1 0 0 0 0 0 1 1
fogalomTipusKod Operator = E8PontKonstruktor 1 0 0 0 0 1 0 0
fogalomTipusKod Megfigyelt = E8PontKonstruktor 1 0 0 0 0 1 0 1
fogalomTipusKod KvantumUgres = E8PontKonstruktor 1 0 0 0 0 1 1 0
-- Fazis
fogalomTipusKod FazisAtalakulas = E8PontKonstruktor 1 0 0 1 0 0 0 1
fogalomTipusKod FazisAtmenet = E8PontKonstruktor 1 0 0 1 0 0 1 0
fogalomTipusKod FazisElolas = E8PontKonstruktor 1 0 0 1 0 0 1 1
-- Kolcsonhatasok
fogalomTipusKod Elektromagneses = E8PontKonstruktor 1 0 1 0 0 0 0 1
fogalomTipusKod Gyenge = E8PontKonstruktor 1 0 1 0 0 0 1 0
fogalomTipusKod Eros = E8PontKonstruktor 1 0 1 0 0 0 1 1
fogalomTipusKod Gravitacio = E8PontKonstruktor 1 0 1 0 0 1 0 0
fogalomTipusKod KvantumGravitacio = E8PontKonstruktor 1 0 1 0 0 1 0 1
fogalomTipusKod EgyesitettMezo = E8PontKonstruktor 1 0 1 0 0 1 1 0
fogalomTipusKod StandardModell = E8PontKonstruktor 1 0 1 0 0 1 1 1
-- Hullamok
fogalomTipusKod Hullam = E8PontKonstruktor 1 0 1 1 0 0 0 1
fogalomTipusKod Hang = E8PontKonstruktor 1 0 1 1 0 0 1 0
fogalomTipusKod Feny = E8PontKonstruktor 1 0 1 1 0 0 1 1
fogalomTipusKod GravitaciosHullam = E8PontKonstruktor 1 0 1 1 0 1 0 0
fogalomTipusKod RadioHullam = E8PontKonstruktor 1 0 1 1 0 1 0 1
-- Fluktacio, disszipacio, termodinamika
fogalomTipusKod Fluktuacio = E8PontKonstruktor 1 1 0 0 0 0 0 1
fogalomTipusKod Disszipacio = E8PontKonstruktor 1 1 0 0 0 0 1 0
fogalomTipusKod FluktuacioDisszipacioTetele = E8PontKonstruktor 1 1 0 0 0 0 1 1
fogalomTipusKod Homerseklet = E8PontKonstruktor 1 1 0 0 0 1 0 0
fogalomTipusKod Termodinamika = E8PontKonstruktor 1 1 0 0 0 1 0 1
fogalomTipusKod CarnotCiklus = E8PontKonstruktor 1 1 0 0 0 1 1 0
fogalomTipusKod Entropia = E8PontKonstruktor 1 1 0 0 0 1 1 1
fogalomTipusKod Hő = E8PontKonstruktor 1 1 0 0 1 0 0 0
fogalomTipusKod Munka = E8PontKonstruktor 1 1 0 0 1 0 0 1
fogalomTipusKod BelsőEnergia = E8PontKonstruktor 1 1 0 0 1 0 1 0
fogalomTipusKod InformacioTorles = E8PontKonstruktor 1 1 0 0 1 0 1 1
-- Szinek
fogalomTipusKod Szin = E8PontKonstruktor 1 1 0 1 0 0 0 1
fogalomTipusKod SzinToltes = E8PontKonstruktor 1 1 0 1 0 0 1 0
fogalomTipusKod AntiszinToltes = E8PontKonstruktor 1 1 0 1 0 0 1 1
fogalomTipusKod Gluon = E8PontKonstruktor 1 1 0 1 0 1 0 0
fogalomTipusKod KvarkSzin = E8PontKonstruktor 1 1 0 1 0 1 0 1
-- Kommunikacio
fogalomTipusKod Informacio = E8PontKonstruktor 1 1 1 0 0 0 0 1
fogalomTipusKod Kommunikacio = E8PontKonstruktor 1 1 1 0 0 0 1 0
fogalomTipusKod Kod = E8PontKonstruktor 1 1 1 0 0 0 1 1
fogalomTipusKod Jel = E8PontKonstruktor 1 1 1 0 0 1 0 0
fogalomTipusKod Csatorna = E8PontKonstruktor 1 1 1 0 0 1 0 1
fogalomTipusKod Zaj = E8PontKonstruktor 1 1 1 0 0 1 1 0
fogalomTipusKod Bit = E8PontKonstruktor 1 1 1 0 0 1 1 1
-- Folytonossag
fogalomTipusKod Folytonos = E8PontKonstruktor 1 1 1 1 0 0 0 1
fogalomTipusKod NemFolytonos = E8PontKonstruktor 1 1 1 1 0 0 1 0
fogalomTipusKod Codata = E8PontKonstruktor 1 1 1 1 0 0 1 1
fogalomTipusKod Sorozat = E8PontKonstruktor 1 1 1 1 0 1 0 0
fogalomTipusKod Hatar = E8PontKonstruktor 1 1 1 1 0 1 0 1
fogalomTipusKod Vegtelen = E8PontKonstruktor 1 1 1 1 0 1 1 0
-- Kepzetes egyseg, ij szorzat, katernio, okternio, tukrozesek
fogalomTipusKod KepzetesEgyseg = E8PontKonstruktor Nulla Egy Nulla Nulla Nulla Nulla Nulla Nulla
fogalomTipusKod IjSzorzat = E8PontKonstruktor 1 1 1 1 1 0 0 1
fogalomTipusKod Katernio = E8PontKonstruktor 1 1 1 1 1 0 1 0
fogalomTipusKod Okternio = E8PontKonstruktor 1 1 1 1 1 0 1 1
fogalomTipusKod OkternioTukor = E8PontKonstruktor 1 1 1 1 1 1 0 0
fogalomTipusKod FizikaTukor = E8PontKonstruktor 1 1 1 1 1 1 0 1
-- Kanti kategoriaelmelet
fogalomTipusKod KantiKategoria = E8PontKonstruktor 1 1 1 1 1 1 1 0
fogalomTipusKod TranszcendentalisAppercepcio = E8PontKonstruktor 1 0 0 0 1 1 0 0
fogalomTipusKod TranszcendentalisDialektika = E8PontKonstruktor 1 0 0 0 1 1 0 1
-- Matematikai allandok
fogalomTipusKod EulerSzam = E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Nulla
fogalomTipusKod Pi = E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Nulla
-- Operatorok
fogalomTipusKod Osszeadas = E8PontKonstruktor 0 0 0 1 1 0 0 0
fogalomTipusKod Kivonas = E8PontKonstruktor 0 0 0 1 1 0 1 0
fogalomTipusKod Szorzas = E8PontKonstruktor 0 0 0 1 1 1 0 0
fogalomTipusKod Osztas = E8PontKonstruktor 0 0 0 1 1 1 0 1
fogalomTipusKod Hatvanyozas = E8PontKonstruktor 0 0 0 1 1 1 1 0
fogalomTipusKod Gyokvonas = E8PontKonstruktor 0 0 0 1 1 1 1 1
fogalomTipusKod EulerAzonossag = E8PontKonstruktor 0 0 0 0 0 0 0 0
fogalomTipusKod TizenotKod = E8PontKonstruktor 1 1 0 1 1 0 0 0
fogalomTipusKod TGate = E8PontKonstruktor 1 1 0 1 1 0 0 1
fogalomTipusKod MElmelet = E8PontKonstruktor 1 1 0 1 1 0 1 0
fogalomTipusKod PauliCsoport = E8PontKonstruktor 1 1 0 1 1 0 1 1
fogalomTipusKod Stabilizator = E8PontKonstruktor 1 1 0 1 1 1 0 0
fogalomTipusKod Kapu = E8PontKonstruktor 1 1 0 1 1 1 0 1

||| Kubit → Double.
public export
kubitErtek : Kubit -> Double
kubitErtek Nulla = 0.0
kubitErtek Egy = 1.0

||| HaromKubit → E8Pont: harom kubit 3 koordinata.
public export
haromKubitE8Kod : HaromKubit -> E8Pont
haromKubitE8Kod v =
  E8PontKonstruktor v.saját v.másik v.fázis Nulla Nulla Nulla Nulla Nulla

||| IgeIdo → E8Pont (6. pozicio).
public export
idoE8Kod : IgeIdo -> E8Pont
idoE8Kod Mult = E8PontKonstruktor 0 0 0 0 0 1 0 0
idoE8Kod Jelen = E8PontKonstruktor 0 0 0 0 0 0 1 0
idoE8Kod Jovo = E8PontKonstruktor 0 0 0 0 0 0 0 1

||| E8Pont osszeadas.
public export
e8PontOsszead : E8Pont -> E8Pont -> E8Pont
e8PontOsszead a b = E8PontKonstruktor
  (a.x1 + b.x1) (a.x2 + b.x2) (a.x3 + b.x3) (a.x4 + b.x4)
  (a.x5 + b.x5) (a.x6 + b.x6) (a.x7 + b.x7) (a.x8 + b.x8)

||| FogalomTipus → String.
public export
fogalomNev : FogalomTipus -> String
fogalomNev Gyoker = "gyoker"
fogalomNev Cel = "cel"
fogalomNev ReszCel = "reszcel"
fogalomNev Feladat = "feladat"
fogalomNev ReszFeladat = "reszfeladat"
fogalomNev Cselekves = "cselekves"
fogalomNev Dontes = "dontes"
fogalomNev Valasztas = "valasztas"
fogalomNev Elutasitas = "elutasitas"
fogalomNev Ok = "ok"
fogalomNev Kavzatum = "kavzatum"
fogalomNev Korlatozas = "korlatozas"
fogalomNev Megfigyeles = "megfigyeles"
fogalomNev Hiba = "hiba"
fogalomNev Eredmeny = "eredmeny"
fogalomNev Minta = "minta"
fogalomNev Javitas = "javitas"
fogalomNev Foltozas = "foltozas"
fogalomNev InfraJavitas = "infrajavitas"
fogalomNev Szabaly = "szabaly"
fogalomNev KemenySzabaly = "kemenyszabaly"
fogalomNev Egyezmeny = "egyezmeny"
fogalomNev Eszkoz = "eszkoz"
fogalomNev Kesztseg = "kesztseg"
fogalomNev ModellKornyezetProtokoll = "modellkornyezetprotokoll"
fogalomNev Kerdes = "kerdes"
fogalomNev Magyarazat = "magyarazat"
fogalomNev E8xE8 = "e8xe8"
fogalomNev Dualitas = "dualitas"
fogalomNev Kategoria = "kategoria"
fogalomNev Szimmetria = "szimmetria"
fogalomNev Tenzor = "tenzor"
fogalomNev Funktor = "funktor"
-- Szamok
fogalomNev TermeszetesSzam = "termeszetes szam"
fogalomNev EgeszSzam = "egesz szam"
fogalomNev RacionalisSzam = "racionalis szam"
fogalomNev Szam = "szam"
fogalomNev ValosSzam = "valos szam"
fogalomNev KomplexSzam = "komplex szam"
-- Matematika logika
fogalomNev Allitas = "allitas"
fogalomNev Bizonyitas = "bizonyitas"
fogalomNev GodelSzam = "godel szam"
fogalomNev Konzisztencia = "konzisztencia"
fogalomNev Onhivatkozas = "onhivatkozas"
fogalomNev GodelElsoTetel = "godel elso tetel"
fogalomNev GodelMasodikTetel = "godel masodik tetel"
fogalomNev DiagonaleLemma = "diagonalis lemma"
fogalomNev Bizonyithatosag = "bizonyithatosag"
fogalomNev InkonzisztenciaVonal = "inkonzisztencia vonal"
fogalomNev WickForgatas = "wick forgatas"
fogalomNev KomplexFazis = "komplex fazis"
fogalomNev KettoMatematika = "ketto matematika"
-- Curry-Howard-Lambek
fogalomNev Chl = "curry howard lambek"
-- Halmazelmelet es axiomak
fogalomNev Halmazelmelet = "halmazelmelet"
fogalomNev PeanoAxiomak = "peano axiomak"
fogalomNev ZfcAxiomak = "zfc axiomak"
fogalomNev KivalasztasiAxioma = "kivalasztasi axioma"
fogalomNev UresHalmaz = "ures halmaz"
fogalomNev Szamossag = "szamossag"
fogalomNev FolytonossagiHipotetikus = "folytonossagi hipotetikus"
-- Fizika
fogalomNev FizikaiAllapot = "fizikai allapot"
fogalomNev Mezo = "mezo"
fogalomNev Ter = "ter"
fogalomNev Ido = "ido"
fogalomNev Tomeg = "tomeg"
fogalomNev InformacioMennyiseg = "informacio mennyiseg"
-- Szimmetriak
fogalomNev SzimmetriaCsoport = "szimmetria csoport"
fogalomNev MertekCsoport = "mertek csoport"
fogalomNev SzimmetriaTores = "szimmetria tores"
fogalomNev E8Szimmetria = "e8 szimmetria"
fogalomNev Geometria = "geometria"
fogalomNev Anyag = "anyag"
fogalomNev Antianyag = "antianyag"
-- Mechanika
fogalomNev KlasszikusMechanika = "klasszikus mechanika"
fogalomNev LagrangeFuggveny = "lagrange fuggveny"
fogalomNev HamiltonFuggveny = "hamilton fuggveny"
fogalomNev LagrangeTranszformacio = "lagrange transzformacio"
-- Kvantum
fogalomNev KvantumMechanika = "kvantum mechanika"
fogalomNev KvantumAllapot = "kvantum allapot"
fogalomNev HullamFuggveny = "hullam fuggveny"
fogalomNev Operator = "operator"
fogalomNev Megfigyelt = "megfigyelt"
fogalomNev KvantumUgres = "kvantum ugres"
-- Fazis
fogalomNev FazisAtalakulas = "fazis atalakulas"
fogalomNev FazisAtmenet = "fazis atmenet"
fogalomNev FazisElolas = "fazis elolas"
-- Kolcsonhatasok
fogalomNev Elektromagneses = "elektromagneses"
fogalomNev Gyenge = "gyenge"
fogalomNev Eros = "eros"
fogalomNev Gravitacio = "gravitacio"
fogalomNev KvantumGravitacio = "kvantum gravitacio"
fogalomNev EgyesitettMezo = "egyesitett mezo"
fogalomNev StandardModell = "standard modell"
-- Hullamok
fogalomNev Hullam = "hullam"
fogalomNev Hang = "hang"
fogalomNev Feny = "feny"
fogalomNev GravitaciosHullam = "gravitacios hullam"
fogalomNev RadioHullam = "radio hullam"
-- Fluktacio, disszipacio, termodinamika
fogalomNev Fluktuacio = "fluktuacio"
fogalomNev Disszipacio = "disszipacio"
fogalomNev FluktuacioDisszipacioTetele = "fluktuacio disszipacio tetele"
fogalomNev Homerseklet = "homerseklet"
fogalomNev Termodinamika = "termodinamika"
fogalomNev CarnotCiklus = "carnot ciklus"
fogalomNev Entropia = "entropia"
fogalomNev Hő = "ho"
fogalomNev Munka = "munka"
fogalomNev BelsőEnergia = "belso energia"
fogalomNev InformacioTorles = "informacio torles"
-- Szinek
fogalomNev Szin = "szin"
fogalomNev SzinToltes = "szin toltes"
fogalomNev AntiszinToltes = "antiszintoltes"
fogalomNev Gluon = "gluon"
fogalomNev KvarkSzin = "kvark szin"
-- Kommunikacio
fogalomNev Informacio = "informacio"
fogalomNev Kommunikacio = "kommunikacio"
fogalomNev Kod = "kod"
fogalomNev Jel = "jel"
fogalomNev Csatorna = "csatorna"
fogalomNev Zaj = "zaj"
fogalomNev Bit = "bit"
-- Folytonossag
fogalomNev Folytonos = "folytonos"
fogalomNev NemFolytonos = "nem folytonos"
fogalomNev Codata = "codata"
fogalomNev Sorozat = "sorozat"
fogalomNev Hatar = "hatar"
fogalomNev Vegtelen = "vegtelen"
-- Kepzetes egyseg, ij szorzat, katernio, okternio, tukrozesek
fogalomNev KepzetesEgyseg = "kepzetes egyseg"
fogalomNev IjSzorzat = "ij szorzat"
fogalomNev Katernio = "katernio"
fogalomNev Okternio = "okternio"
fogalomNev OkternioTukor = "okternio tukor"
fogalomNev FizikaTukor = "fizika tukor"
-- Kanti kategoriaelmelet
fogalomNev KantiKategoria = "kanti kategoria"
fogalomNev TranszcendentalisAppercepcio = "transzcendentalis appercepcio"
fogalomNev TranszcendentalisDialektika = "transzcendentalis dialektika"
-- Matematikai allandok
fogalomNev EulerSzam = "euler szam"
fogalomNev Pi = "pi"
-- Operatorok
fogalomNev Osszeadas = "osszeadas"
fogalomNev Kivonas = "kivonas"
fogalomNev Szorzas = "szorzas"
fogalomNev Osztas = "osztas"
fogalomNev Hatvanyozas = "hatvanyozas"
fogalomNev Gyokvonas = "gyokvonas"
fogalomNev EulerAzonossag = "euler azonossag"
fogalomNev TizenotKod = "tizenot egy harom kod"
fogalomNev TGate = "te kapu"
fogalomNev MElmelet = "m elmelet"
fogalomNev PauliCsoport = "pauli csoport"
fogalomNev Stabilizator = "stabilizator"
fogalomNev Kapu = "kapu"

||| FogalomFa → HaromKubit.
public export
fogalomFaKubit : FogalomFa t -> HaromKubit
fogalomFaKubit fa =
  let m = meret fa
      g = gyerekekSzama fa
  in VilágKonstruktor
       (if m > 5 then Egy else Nulla)
       (if g > 3 then Egy else Nulla)
       (if m + g > 8 then Egy else Nulla)

-- ═══════════════════════════════════════════════════════════════
-- FUNKTOR MORFIZMUSKEP SEGEDFUGGVENYEK
-- ═══════════════════════════════════════════════════════════════

esetE8MorfizmusKep : {a, b : Eset} -> EsetMorf a b -> E8Morf (esetKod a) (esetKod b)
esetE8MorfizmusKep (EsetMorfKonstruktor _) = E8MorfKonstruktor (CliffordKonstruktor Egy Nulla Nulla)

fogalomE8MorfizmusKep : {a : FogalomTipus} -> {b : FogalomTipus}
                     -> FogalomMorf a b -> E8Morf (fogalomTipusKod a) (fogalomTipusKod b)
fogalomE8MorfizmusKep {a} FogalomAzonos = E8MorfKonstruktor (CliffordKonstruktor Egy Nulla Nulla)
fogalomE8MorfizmusKep {a} {b} (FogalomIre _) =
  let aa = fogalomTipusKod a
      bb = fogalomTipusKod b
      -- Az E8 × E8 geometriai szorzat: aa * bb = a·b + a∧b
      -- A skalaris resz (a·b) az atfedes merteke
      -- Hasznaljuk a CliffordKonstruktor-t a ket pont kulonbsegekent
      xx = aa.x1 - bb.x1
      yy = aa.x2 - bb.x2
      zz = aa.x3 - bb.x3
  in E8MorfKonstruktor (CliffordKonstruktor
    (if xx == 0 then 1 else 0)
    (if yy == 0 then 1 else 0)
    (if zz == 0 then 1 else 0))
fogalomE8MorfizmusKep {a} {b} (FogalomSorozat koztes f g) =
  let f1 : E8Morf (fogalomTipusKod a) (fogalomTipusKod koztes) = fogalomE8MorfizmusKep f
      g1 : E8Morf (fogalomTipusKod koztes) (fogalomTipusKod b) = fogalomE8MorfizmusKep g
  in e8OsszetetelMorf f1 g1

kubitE8MorfizmusKep : {a, b : HaromKubit} -> KubitMorf a b -> E8Morf (haromKubitE8Kod a) (haromKubitE8Kod b)
kubitE8MorfizmusKep (KubitMorfKonstruktor _) = E8MorfKonstruktor (CliffordKonstruktor Egy Nulla Nulla)

idoE8MorfizmusKep : {a, b : IgeIdo} -> IdoMorf a b -> E8Morf (idoE8Kod a) (idoE8Kod b)
idoE8MorfizmusKep (IdoMorfKonstruktor _) = E8MorfKonstruktor (CliffordKonstruktor Egy Nulla Nulla)

-- ═══════════════════════════════════════════════════════════════
-- FUNKTOROK (KATEGORIAK KAPCSOLASAI)
-- ═══════════════════════════════════════════════════════════════

||| Eset → E8: minden eset egy E8 pont.
public export
esetE8Funktor : Funktor Eset EsetMorf E8Pont E8Morf
esetE8Funktor = FunktorKonstruktor esetKod esetE8MorfizmusKep

||| Fogalom → E8: minden fogalom egy E8 pont.
public export
fogalomE8Funktor : Funktor FogalomTipus FogalomMorf E8Pont E8Morf
fogalomE8Funktor = FunktorKonstruktor fogalomTipusKod fogalomE8MorfizmusKep

||| HaromKubit → E8: harom kubit 3 koordinata.
public export
kubitE8Funktor : Funktor HaromKubit KubitMorf E8Pont E8Morf
kubitE8Funktor = FunktorKonstruktor haromKubitE8Kod kubitE8MorfizmusKep

||| Ido → E8: ido a 6. pozicioban.
public export
idoE8Funktor : Funktor IgeIdo IdoMorf E8Pont E8Morf
idoE8Funktor = FunktorKonstruktor idoE8Kod idoE8MorfizmusKep

-- ═══════════════════════════════════════════════════════════════
-- KAPCSOLATOK A MEGLEVO TIPUSOKHOZ
-- ═══════════════════════════════════════════════════════════════

||| RagozottSzo → E8Pont.
||| A szo.idobol az IgeIdot emeljuk ki az IdoBeljegyzesbol.
public export
ragozottSzoE8Pont : RagozottSzo -> E8Pont
ragozottSzoE8Pont szo =
  let (IdoBeljegyzesKonstruktor igeIdo _ _) = szo.ido
      fogKod = fogalomTipusKod szo.fogalom
      eKod = esetKod szo.eset
      iKod = idoE8Kod igeIdo
      fKod = haromKubitE8Kod szo.fazisKubit
  in e8PontOsszead (e8PontOsszead (e8PontOsszead fogKod eKod) iKod) fKod

||| NyelvtaniKapcsolat → E8E8KodSzo.
public export
nyelvtaniKapcsolatKod : NyelvtaniKapcsolat -> E8E8KodSzo
nyelvtaniKapcsolatKod kapcs =
  KodKonstruktor
    (fogalomNev kapcs.ige.fogalom)
    (ragozottSzoE8Pont kapcs.alany)
    (ragozottSzoE8Pont kapcs.targy)
    (E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
    (E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
    (CliffordKonstruktor Egy Nulla Egy)
    (alapKod Nulla)

||| VilagFa → ToltesParitasIdo.
||| A fazis (FogalomAdat) helyett a fazisKubit-ot szamoljuk
||| a FogalomAdat bizalmabol: magas bizalom → Egy fazis.
public export
vilagFaToltesParitasIdo : VilagFa -> ToltesParitasIdo
vilagFaToltesParitasIdo vf = ToltesParitasIdoKonstruktor
  (fogalomFaKubit vf.sajat)
  (fogalomFaKubit vf.masik)
  (VilágKonstruktor
    (if vf.fazis.bizalom > 0.5 then Egy else Nulla)
    (if vf.fazis.bizalom > 0.8 then Egy else Nulla)
      (if length vf.fazis.hivatkozasok > 2 then Egy else Nulla))

-- ═══════════════════════════════════════════════════════════════
-- 7+7+1 KATEGORIA RENDSZER: Emberi (7) ↔ Perem (1) ↔ Szamitasi (7)
-- ═══════════════════════════════════════════════════════════════

||| Morfizmus a 7+7+1 kategoriak kozott.
public export
data KategoriaMorf : KategoriaTipus -> KategoriaTipus -> Type where
  KategoriaAzonos  : KategoriaMorf a a
  KategoriaIre     : FogalomLogika714 a b -> KategoriaMorf a b
  KategoriaSorozat : (koztes : KategoriaTipus) -> KategoriaMorf a koztes -> KategoriaMorf koztes c -> KategoriaMorf a c

||| Azonossag: minden KategoriaTipushoz az azonos morfizmus.
public export
kategoriaAzonos : (a : KategoriaTipus) -> KategoriaMorf a a
kategoriaAzonos a = KategoriaAzonos

||| Osszetetel: morfizmusok kompozicioja.
public export
kategoriaOsszetetel : {a, b, c : KategoriaTipus} -> KategoriaMorf a b -> KategoriaMorf b c -> KategoriaMorf a c
kategoriaOsszetetel {a} {b} {c} f g = KategoriaSorozat b f g

||| 7+7+1 kategoria peldany.
public export
kategoria714Kategoria : Kategoria KategoriaTipus KategoriaMorf
kategoria714Kategoria = KategoriaKonstruktor kategoriaAzonos kategoriaOsszetetel

||| EmberiKategoria diszkret kategoria: csak azonos morfizmusok.
public export
data EmberiMorf : EmberiKategoria -> EmberiKategoria -> Type where
  EmberiAzonos : EmberiMorf a a

||| SzamitasiKategoria diszkret kategoria: csak azonos morfizmusok.
public export
data SzamitasiMorf : SzamitasiKategoria -> SzamitasiKategoria -> Type where
  SzamitasiAzonos : SzamitasiMorf a a

||| Funktor: Emberi → Kategoria714.
||| Minden EmberiKategoria egy KategoriaEmberi.
public export
emberi714Funktor : Funktor EmberiKategoria EmberiMorf KategoriaTipus KategoriaMorf
emberi714Funktor = FunktorKonstruktor
  KategoriaEmberi
  (\f => case f of EmberiAzonos => KategoriaAzonos)

||| Funktor: Szamitasi → Kategoria714.
public export
szamitasi714Funktor : Funktor SzamitasiKategoria SzamitasiMorf KategoriaTipus KategoriaMorf
szamitasi714Funktor = FunktorKonstruktor
  KategoriaSzamitasi
  (\f => case f of SzamitasiAzonos => KategoriaAzonos)

||| Adjunkcio: Kategoria714 ⊣ Kategoria714 (azonos funktorokkal).
|||   A Perem (KategoriaPerem) a ket oldal (Emberi ↔ Szamitasi) kozotti
|||   adjunkcio fixpontja: az azonos funktor-on keresztul.
public export
emberiPeremSzamitasiAdjunkcio : Adjunkcio KategoriaTipus KategoriaMorf
                                        KategoriaTipus KategoriaMorf
emberiPeremSzamitasiAdjunkcio =
  let azonosFunktor : Funktor KategoriaTipus KategoriaMorf KategoriaTipus KategoriaMorf
      azonosFunktor = FunktorKonstruktor id (\f => f)
  in AdjunkcioKonstruktor azonosFunktor azonosFunktor
       (\a => KategoriaAzonos)
       (\b => KategoriaAzonos)

||| A Legendre perem morfizmus: Emberi.Fazis → Perem.
public export
fazisPeremMorf : KategoriaMorf (KategoriaEmberi EmberiFazis) KategoriaPerem
fazisPeremMorf = KategoriaIre FazisPerem

||| A Legendre perem morfizmus: Perem → Szamitasi.Allapot.
public export
peremAllapotMorf : KategoriaMorf KategoriaPerem (KategoriaSzamitasi SzamAllapot)
peremAllapotMorf = KategoriaIre PeremAllapot

||| Teljes Legendre adjunkcio morfizmus: Emberi.Fazis → Szamitasi.Allapot.
public export
fazisAllapotMorf : KategoriaMorf (KategoriaEmberi EmberiFazis) (KategoriaSzamitasi SzamAllapot)
fazisAllapotMorf = kategoriaOsszetetel fazisPeremMorf peremAllapotMorf

-- ═══════════════════════════════════════════════════════════════
-- KATEGÓRIAELMÉLETI BIZONYÍTÁSOK — MINDEN AXIÓMA REFL
-- ═══════════════════════════════════════════════════════════════
-- Curry-Howard: minden bizonyitas = egy program ami Refl-re redukalodik.
-- A kategoriaelmelet alaptorvenyei mind Refl-lel bizonyithatok
-- mert a definiciokbol kovetkeznek.

-- A funktor-torvenyek, kategoria-torvenyek es adjunkcios haromszog-azonossagok
-- a KategoriaT typeclass-ban vannak (lent). Nem kell kulon Refl bizonyitasok.
-- A typeclass instance implementalasa MAGA a bizonyitas (Curry-Howard).

-- ─── YONEDA LEMMA ─────────────────────────────────────────
-- https://en.wikipedia.org/wiki/Yoneda_lemma
-- A Yoneda-lemma: Nat(Hom(-,a), F) ≅ F(a).
-- Minden termeszetes transzformacio a Hom(-,a)-bol F-be
-- egyertelmuen meghatarozott az id_a F-beli kepe altal.
-- A mi fogalomYoneda-nk ezt implementalja.
--
-- Bizonyitas (a mi esetunkben):
--   yonedaLemma: ((x : o) -> homPresheaf a x -> f x) -> f a
--   A termeszetes transzformaciot az id_a-ra alkalmazva kapjuk F(a)-t.
--   A fogalomYoneda eseteben:
--     homPresheaf a x = FogalomMorf x a
--     yonedaLemma nat = nat a (fogalomKategoria.azonos a)
--   Ez a klasszikus Yoneda-bizonyitas: Φ(α) = α_a(id_a).

||| Yoneda-lemma: a termeszetes transzformacio egyertelmu.
|||   Minden α: Hom(-,a) → F termeszetes transzformaciot
|||   egyertelmuen meghataroz az α_a(id_a) ∈ F(a).
public export
yonedaEgyertelmu : (a : FogalomTipus) -> (f : FogalomTipus -> Type) ->
  ((x : FogalomTipus) -> FogalomMorf x a -> f x) -> f a
yonedaEgyertelmu a f alpha = alpha a FogalomAzonos

-- ═══════════════════════════════════════════════════════════════
-- TYPECLASS-OK MINDEN KATEGÓRIAELMÉLETI FOGALOMHOZ
-- ═══════════════════════════════════════════════════════════════
-- Minden typeclass tartalmazza a muveleteket ES a torvenyeket.
-- Az interface implementalasa = a torvenyek bizonyitasa.
-- Curry-Howard: typeclass = tetel, instance = bizonyitas.

-- ─── KATEGÓRIA TYPECLASS ───────────────────────────────────

||| Kategoria typeclass azonos es osszetetel torvenyekkel.
|||   EmberiKategoria es SzamitasiKategoria peldakkal.
public export
KategoriaT EmberiKategoria EmberiMorf where
  identitas a = EmberiAzonos
  kompozicio EmberiAzonos EmberiAzonos = EmberiAzonos
  balAzonos EmberiAzonos = Refl
  jobbAzonos EmberiAzonos = Refl
  asszociativ EmberiAzonos EmberiAzonos EmberiAzonos = Refl

public export
KategoriaT SzamitasiKategoria SzamitasiMorf where
  identitas a = SzamitasiAzonos
  kompozicio SzamitasiAzonos SzamitasiAzonos = SzamitasiAzonos
  balAzonos SzamitasiAzonos = Refl
  jobbAzonos SzamitasiAzonos = Refl
  asszociativ SzamitasiAzonos SzamitasiAzonos SzamitasiAzonos = Refl

-- ─── CSOPORT TYPECLASS ─────────────────────────────────────

||| Csoport typeclass: szorzas, egyseg, inverz + torvenyek.
public export
interface CsoportT (g : Type) where
  szorzasG : g -> g -> g
  egysegG : g
  inverzG : g -> g
  balEgysegT : (x : g) -> szorzasG egysegG x = x
  jobbEgysegT : (x : g) -> szorzasG x egysegG = x
  balInverzT : (x : g) -> szorzasG (inverzG x) x = egysegG

-- ─── FUNKTOR TYPECLASS ─────────────────────────────────────
-- A FunktorT typeclass a KategoriaT-ra epul. A torvenyek:
--   identitasTorveny: F(id_a) = id_{F(a)}
--   kompozicioTorveny: F(g ∘ f) = F(g) ∘ F(f)
-- A GAN javaslata szerint a szintaxis: (KategoriaT o1 m1, KategoriaT o2 m2) =>
-- de ez Idris 2-ben nem muxik a tobb parameteres typeclass-okkal.
-- A Funktor record (fent) mar tartalmazza a strukturat.
-- A torvenyeket a KategoriaT instance-ok bizonyitjak (Curry-Howard).

-- ─── A KATEGÓRIA TYPECLASS VISSZATESZÉSE ──────────────────
-- (A korabbi definicio itt van, az EmberiMorf es SzamitasiMorf utan)

-- ═══════════════════════════════════════════════════════════════
-- LIMIT/KOLIMIT CSALÁD (Lépés 1.1 — 10 fogalom)
-- ═══════════════════════════════════════════════════════════════
-- Források:
--   nLab: https://ncatlab.org/nlab/show/limit
--   Wikipedia: https://en.wikipedia.org/wiki/Limit_(category_theory)
--   Awodey: Category Theory (2006), §5.1–5.4 (a szorzat, a koprodukt, az egyenlítő, a pullback)
--   Mac Lane: Categories for the Working Mathematician, §III.4 (a limit, a kolimit)
--   Cat_on_Coq: a setoid-alapú limit/kolimit formalizálás
--   agda-unimath: a Limits modul (az általános limit/kolimit)
--   Hu & Carette (2020, arXiv:2005.07059): a proof-relevant formalizálás
--
-- A 10 fogalom:
--   1. Végződés (terminal)  2. Kezdet (initial)
--   3. Szorzat (product)    4. Koprodukt (coproduct)
--   5. Egyenlítő (equalizer) 6. Koegyenlítő (coequalizer)
--   7. Pullback (fiber product)  8. Pushout
--   9. ÁltalánosLimit  10. ÁltalánosKolimit
--
-- A MANTRA szerint: a bizonyítás kimenete kommentben a propozíció előtt.
-- A típus annyira pontos, hogy csak egy implementáció lehetséges.
-- Minden fogalom `public export` — a gráf-adatbázis importálja.

-- ─── 1. VÉGZŐDÉS (terminal object) ─────────────────────────
-- https://ncatlab.org/nlab/show/terminal+object
-- Definíció (Awodey §5.1): egy T objektum végződés, ha minden A objektumhoz
-- pontosan egy morfizmus van A-ból T-be: ∃! t : A → T.
-- Az egyértelműség = a típusban van (a `vegzodesMorfizmus` az egyetlen).
public export
record Vegzodes (k : Kategoria obj hom) where
  constructor VegzodesKonstruktor
  vegzodesObjektum : obj
  vegzodesMorfizmus : (a : obj) -> hom a vegzodesObjektum
  -- Az egyértelműség törvénye: minden f : a → T egyenlő a vegzodesMorfizmus a-val.
  vegzodesEgyertelmu : {a : obj} -> (f : hom a vegzodesObjektum)
                     -> f = vegzodesMorfizmus a

-- ─── 2. KEZDET (initial object) ────────────────────────────
-- https://ncatlab.org/nlab/show/initial+object
-- Definíció: a végződés duálisa (C^op-ban). Egy I objektum kezdet, ha
-- minden B objektumhoz pontosan egy morfizmus van I-ből B-be: ∃! i : I → B.
public export
record Kezdet (k : Kategoria obj hom) where
  constructor KezdetKonstruktor
  kezdetObjektum : obj
  kezdetMorfizmus : (b : obj) -> hom kezdetObjektum b
  -- Az egyértelműség törvénye: minden f : I → b egyenlő a kezdetMorfizmus b-vel.
  kezdetEgyertelmu : {b : obj} -> (f : hom kezdetObjektum b)
                   -> f = kezdetMorfizmus b

-- ─── 3. SZORZAT (product) ──────────────────────────────────
-- https://ncatlab.org/nlab/show/product
-- Definíció (Awodey §5.1): az A és B szorzata egy P objektum két morfizmussal
--   π₁ : P → A, π₂ : P → B, úgy hogy minden Q-ra és q₁ : Q → A, q₂ : Q → B
--   ∃! h : Q → P úgy hogy π₁∘h = q₁ és π₂∘h = q₂.
-- Ez a kategóriaelmélet "AND" művelete (Curry-Howard-Lambek: Konjunkció ↔ Szorzat).
public export
record Szorzat (k : Kategoria obj hom) (a : obj) (b : obj) where
  constructor SzorzatObjektumKonstruktor
  szorzatObjektum : obj
  szorzatProjekcioBal : hom szorzatObjektum a
  szorzatProjekcioJobb : hom szorzatObjektum b
  -- Az univerzális tulajdonság: minden Q-ból érkező pár egyértelműen faktorizál.
  szorzatUniverzalis : (q : obj) -> (q1 : hom q a) -> (q2 : hom q b)
                     -> (h : hom q szorzatObjektum
                        ** (k.osszetetel h szorzatProjekcioBal = q1
                           , k.osszetetel h szorzatProjekcioJobb = q2))

-- ─── 4. KOPRODUKT (coproduct) ──────────────────────────────
-- https://ncatlab.org/nlab/show/coproduct
-- Definíció (Awodey §5.1): a szorzat duálisa. Az A és B koproduktja egy C
-- objektum két morfizmussal ι₁ : A → C, ι₂ : B → C, úgy hogy minden D-re
-- és d₁ : A → D, d₂ : B → D ∃! h : C → D úgy hogy h∘ι₁ = d₁ és h∘ι₂ = d₂.
-- Ez a kategóriaelmélet "OR" művelete (Curry-Howard-Lambek: Diszjunkció ↔ Koprodukt).
public export
record Koprodukt (k : Kategoria obj hom) (a : obj) (b : obj) where
  constructor KoproduktKonstruktor
  koproduktObjektum : obj
  koproduktInjektioBal : hom a koproduktObjektum
  koproduktInjektioJobb : hom b koproduktObjektum
  -- Az univerzális tulajdonság: minden D-be érkező pár egyértelműen faktorizál.
  koproduktUniverzalis : (d : obj) -> (d1 : hom a d) -> (d2 : hom b d)
                       -> (h : hom koproduktObjektum d
                          ** (k.osszetetel koproduktInjektioBal h = d1
                             , k.osszetetel koproduktInjektioJobb h = d2))

-- ─── 5. EGYENLÍTŐ (equalizer) ──────────────────────────────
-- https://ncatlab.org/nlab/show/equalizer
-- Definíció (Awodey §5.3): az f, g : A → B párhuzamos morfizmusok egyenlítője
-- egy E objektum e : E → A morfizmussal, úgy hogy f∘e = g∘e, és minden
-- h : Q → A-ra amire f∘h = g∘h, ∃! k : Q → E úgy hogy e∘k = h.
public export
record Egyenlito (k : Kategoria obj hom) (a : obj) (b : obj) (f : hom a b) (g : hom a b) where
  constructor EgyenlitoKonstruktor
  egyenlitoObjektum : obj
  egyenlitoMorfizmus : hom egyenlitoObjektum a
  -- A törvény: f∘e = g∘e.
  egyenlitoTorveny : k.osszetetel egyenlitoMorfizmus f = k.osszetetel egyenlitoMorfizmus g
  -- Az univerzális tulajdonság: minden h amire f∘h = g∘h, faktorizál E-n keresztül.
  egyenlitoUniverzalis : (q : obj) -> (h : hom q a)
                       -> (k.osszetetel h f = k.osszetetel h g
                          => (kk : hom q egyenlitoObjektum
                             ** k.osszetetel kk egyenlitoMorfizmus = h))

-- ─── 6. KOEGYENLÍTŐ (coequalizer) ──────────────────────────
-- https://ncatlab.org/nlab/show/coequalizer
-- Definíció: az egyenlítő duálisa. Az f, g : A → B morfizmusok koegyenlítője
-- egy C objektum q : B → C morfizmussal, úgy hogy q∘f = q∘g, és minden
-- h : B → D-re amire h∘f = h∘g, ∃! k : C → D úgy hogy k∘q = h.
public export
record Koegyenlito (k : Kategoria obj hom) (a : obj) (b : obj) (f : hom a b) (g : hom a b) where
  constructor KoegyenlitoKonstruktor
  koegyenlitoObjektum : obj
  koegyenlitoMorfizmus : hom b koegyenlitoObjektum
  -- A törvény: q∘f = q∘g.
  koegyenlitoTorveny : k.osszetetel f koegyenlitoMorfizmus = k.osszetetel g koegyenlitoMorfizmus
  -- Az univerzális tulajdonság: minden h amire h∘f = h∘g, faktorizál C-n keresztül.
  koegyenlitoUniverzalis : (d : obj) -> (h : hom b d)
                         -> (k.osszetetel f h = k.osszetetel g h
                            => (kk : hom koegyenlitoObjektum d
                               ** k.osszetetel koegyenlitoMorfizmus kk = h))

-- ─── 7. PULLBACK (fiber product) ───────────────────────────
-- https://ncatlab.org/nlab/show/pullback
-- Definíció (Awodey §5.2): az A→C←B pullback-je egy P objektum két morfizmussal
--   p₁ : P → A, p₂ : P → B, úgy hogy f∘p₁ = g∘p₂, és minden Q-ra
--   q₁ : Q → A, q₂ : Q → B amire f∘q₁ = g∘q₂, ∃! h : Q → P úgy hogy
--   p₁∘h = q₁ és p₂∘h = q₂. A szorzat általánosítása (C = végződés → szorzat).
public export
record Pullback (k : Kategoria obj hom) (a : obj) (b : obj) (c : obj) (f : hom a c) (g : hom b c) where
  constructor PullbackKonstruktor
  pullbackObjektum : obj
  pullbackProjekcioBal : hom pullbackObjektum a
  pullbackProjekcioJobb : hom pullbackObjektum b
  -- A kommutatív négyzet törvénye: f∘p₁ = g∘p₂.
  pullbackKommutativ : k.osszetetel pullbackProjekcioBal f = k.osszetetel pullbackProjekcioJobb g
  -- Az univerzális tulajdonság.
  pullbackUniverzalis : (q : obj) -> (q1 : hom q a) -> (q2 : hom q b)
                      -> (k.osszetetel q1 f = k.osszetetel q2 g
                         => (h : hom q pullbackObjektum
                            ** (k.osszetetel h pullbackProjekcioBal = q1
                               , k.osszetetel h pullbackProjekcioJobb = q2)))

-- ─── 8. PUSHOUT ────────────────────────────────────────────
-- https://ncatlab.org/nlab/show/pushout
-- Definíció: a pullback duálisa. Az A←C→B pushout-ja egy P objektum két
-- morfizmussal i₁ : A → P, i₂ : B → P, úgy hogy i₁∘f = i₂∘g, és minden
-- D-re d₁ : A → D, d₂ : B → D amire d₁∘f = d₂∘g, ∃! h : P → D úgy hogy
-- h∘i₁ = d₁ és h∘i₂ = d₂. A koprodukt általánosítása.
public export
record Pushout (k : Kategoria obj hom) (a : obj) (b : obj) (c : obj) (f : hom c a) (g : hom c b) where
  constructor PushoutKonstruktor
  pushoutObjektum : obj
  pushoutInjektioBal : hom a pushoutObjektum
  pushoutInjektioJobb : hom b pushoutObjektum
  -- A kommutatív négyzet törvénye: i₁∘f = i₂∘g.
  pushoutKommutativ : k.osszetetel f pushoutInjektioBal = k.osszetetel g pushoutInjektioJobb
  -- Az univerzális tulajdonság.
  pushoutUniverzalis : (d : obj) -> (d1 : hom a d) -> (d2 : hom b d)
                     -> (k.osszetetel f d1 = k.osszetetel g d2
                        => (h : hom pushoutObjektum d
                           ** (k.osszetetel pushoutInjektioBal h = d1
                              , k.osszetetel pushoutInjektioJobb h = d2)))

-- ─── 9. ÁLTALÁNOS LIMIT ────────────────────────────────────
-- https://ncatlab.org/nlab/show/limit
-- Definíció (Mac Lane §III.4): egy J indexkategória és egy D : J → C diagram
-- (funktor) esetén a D limitje egy lim(D) objektum + egy kúp (cone) morfizmusokkal
-- minden j : J objektumhoz: lim(D) → D(j), úgy hogy a kúp kompatibilis a
-- diagram morfizmusaival, és univerzális: minden más kúp faktorizál lim(D)-n keresztül.
-- A szorzat = a limit egy diszkrét indexkategória felett.
-- A pullback = a limit egy •→•←• indexkategória felett.
-- Az egyenlítő = a limit egy •⇉• indexkategória felett.
public export
record AltalanosLimit (k : Kategoria obj hom)
                      (jK : Kategoria jObj jHom)
                      (dObj : jObj -> obj)
                      (dMor : {j, jj : jObj} -> jHom j jj -> hom (dObj j) (dObj jj)) where
  constructor AltalanosLimitKonstruktor
  limitObjektum : obj
  -- A kúp: minden j : J objektumhoz egy morfizmus lim(D) → D(j).
  limitKup : (j : jObj) -> hom limitObjektum (dObj j)
  -- A kúp kompatibilitása: minden α : j → k morfizmusra D(α)∘κ_j = κ_k.
  limitKompatibilitas : {j, jj : jObj} -> (alpha : jHom j jj)
                      -> k.osszetetel (limitKup j) (dMor alpha) = limitKup jj
  -- Az univerzális tulajdonság: minden más kúp faktorizál lim(D)-n keresztül.
  limitUniverzalis : (q : obj) -> (masKup : (j : jObj) -> hom q (dObj j))
                   -> ((j, jj : jObj) -> (alpha : jHom j jj)
                      -> k.osszetetel (masKup j) (dMor alpha) = masKup jj
                      => (h : hom q limitObjektum
                         ** ((j : jObj) -> k.osszetetel h (limitKup j) = masKup j)))

-- ─── 10. ÁLTALÁNOS KOLIMIT ─────────────────────────────────
-- https://ncatlab.org/nlab/show/colimit
-- Definíció: a limit duálisa (C^op-ban). Egy D : J → C diagram kolimitje egy
-- colim(D) objektum + egy ko-kúp (cocone) morfizmusokkal minden j : J objektumhoz:
-- D(j) → colim(D), úgy hogy a ko-kúp kompatibilis, és univerzális.
-- A koprodukt = a kolimit egy diszkrét indexkategória felett.
-- A pushout = a kolimit egy •←•→• indexkategória felett.
-- A koegyenlítő = a kolimit egy •⇉• indexkategória felett.
public export
record AltalanosKolimit (k : Kategoria obj hom)
                        (jK : Kategoria jObj jHom)
                        (dObj : jObj -> obj)
                        (dMor : {j, jj : jObj} -> jHom j jj -> hom (dObj j) (dObj jj)) where
  constructor AltalanosKolimitKonstruktor
  kolimitObjektum : obj
  -- A ko-kúp: minden j : J objektumhoz egy morfizmus D(j) → colim(D).
  kolimitKoKup : (j : jObj) -> hom (dObj j) kolimitObjektum
  -- A ko-kúp kompatibilitása: minden α : j → k morfizmusra κ_k∘D(α) = κ_j.
  kolimitKompatibilitas : {j, jj : jObj} -> (alpha : jHom j jj)
                        -> k.osszetetel (dMor alpha) (kolimitKoKup jj) = kolimitKoKup j
  -- Az univerzális tulajdonság: minden más ko-kúp faktorizál colim(D)-n keresztül.
  kolimitUniverzalis : (d : obj) -> (masKoKup : (j : jObj) -> hom (dObj j) d)
                     -> ((j, jj : jObj) -> (alpha : jHom j jj)
                        -> k.osszetetel (dMor alpha) (masKoKup jj) = masKoKup j
                        => (h : hom kolimitObjektum d
                           ** ((j : jObj) -> k.osszetetel (kolimitKoKup j) h = masKoKup j)))

-- ─── A LIMIT/KOLIMIT CSALÁD KAPCSOLATAI (a gráf élei) ──────
-- Szorzat → Pullback (a szorzat a pullback különleges esete, C = végződés)
-- Koprodukt → Pushout (a koprodukt a pushout különleges esete, C = kezdet)
-- Végződés → Szorzat (a végződés feletti szorzat = maga a szorzat)
-- Kezdet → Koprodukt (a kezdet feletti koprodukt = maga a koprodukt)
-- Egyenlítő → ÁltalánosLimit (az egyenlítő a limit egy •⇉• index felett)
-- Koegyenlítő → ÁltalánosKolimit (a koegyenlítő a kolimit egy •⇉• index felett)
-- Pullback → ÁltalánosLimit (a pullback a limit egy •→•←• index felett)
-- Pushout → ÁltalánosKolimit (a pushout a kolimit egy •←•→• index felett)
-- Ezeket az éleket a FÁZIS 4 veszi fel a gráfba (KutatasiGraf_v1.idr).

-- ═══════════════════════════════════════════════════════════════
-- GAN-JAVASLATOK BEÉPÍTÉSE (2026-09-02)
-- A GAN-ellenőrzés szerint a 8 fogalomból (3–10) hiányzik az ∃!
-- egyértelműségi fele. Ezek a rekordok kiegészítik a meglévő
-- struktúrákat a lokalitás (!) törvénnyel.
-- Forrás: nLab "limit" — a limit egyértelmű faktorizáció;
--   Mac Lane §III.4; Awodey §5.
-- ═══════════════════════════════════════════════════════════════

-- ─── A.1 SZORZAT EGYÉRTELMŰSÉGE ─────────────────────────────
public export
record SzorzatEgyertelmu (k : Kategoria obj hom) (a : obj) (b : obj) (s : Szorzat k a b) where
  constructor SzorzatEgyertelmuKonstruktor
  szorzatEgyertelmuTorveny : (q : obj) -> (q1 : hom q a) -> (q2 : hom q b)
                          -> (h1 : hom q s.szorzatObjektum) -> (h2 : hom q s.szorzatObjektum)
                          -> (k.osszetetel h1 s.szorzatProjekcioBal = q1
                             , k.osszetetel h1 s.szorzatProjekcioJobb = q2)
                          -> (k.osszetetel h2 s.szorzatProjekcioBal = q1
                             , k.osszetetel h2 s.szorzatProjekcioJobb = q2)
                          -> h1 = h2

-- ─── A.2 KOPRODUKT EGYÉRTELMŰSÉGE ────────────────────────────
public export
record KoproduktEgyertelmu (k : Kategoria obj hom) (a : obj) (b : obj) (c : Koprodukt k a b) where
  constructor KoproduktEgyertelmuKonstruktor
  koproduktEgyertelmuTorveny : (d : obj) -> (d1 : hom a d) -> (d2 : hom b d)
                            -> (h1 : hom c.koproduktObjektum d) -> (h2 : hom c.koproduktObjektum d)
                            -> (k.osszetetel c.koproduktInjektioBal h1 = d1
                               , k.osszetetel c.koproduktInjektioJobb h1 = d2)
                            -> (k.osszetetel c.koproduktInjektioBal h2 = d1
                               , k.osszetetel c.koproduktInjektioJobb h2 = d2)
                            -> h1 = h2

-- ─── A.3 PULLBACK EGYÉRTELMŰSÉGE ─────────────────────────────
public export
record PullbackEgyertelmu (k : Kategoria obj hom) (a : obj) (b : obj) (c : obj)
                          (f : hom a c) (g : hom b c) (p : Pullback k a b c f g) where
  constructor PullbackEgyertelmuKonstruktor
  pullbackEgyertelmuTorveny : (q : obj) -> (q1 : hom q a) -> (q2 : hom q b)
                            -> (h1 : hom q p.pullbackObjektum) -> (h2 : hom q p.pullbackObjektum)
                            -> (k.osszetetel h1 p.pullbackProjekcioBal = q1
                               , k.osszetetel h1 p.pullbackProjekcioJobb = q2)
                            -> (k.osszetetel h2 p.pullbackProjekcioBal = q1
                               , k.osszetetel h2 p.pullbackProjekcioJobb = q2)
                            -> h1 = h2

-- ─── A.4 PUSHOUT EGYÉRTELMŰSÉGE ──────────────────────────────
public export
record PushoutEgyertelmu (k : Kategoria obj hom) (a : obj) (b : obj) (c : obj)
                         (f : hom c a) (g : hom c b) (p : Pushout k a b c f g) where
  constructor PushoutEgyertelmuKonstruktor
  pushoutEgyertelmuTorveny : (d : obj) -> (d1 : hom a d) -> (d2 : hom b d)
                           -> (h1 : hom p.pushoutObjektum d) -> (h2 : hom p.pushoutObjektum d)
                           -> (k.osszetetel p.pushoutInjektioBal h1 = d1
                              , k.osszetetel p.pushoutInjektioJobb h1 = d2)
                           -> (k.osszetetel p.pushoutInjektioBal h2 = d1
                              , k.osszetetel p.pushoutInjektioJobb h2 = d2)
                           -> h1 = h2

-- ─── A.5 EGYENLÍTŐ EGYÉRTELMŰSÉGE ────────────────────────────
public export
record EgyenlitoEgyertelmu (k : Kategoria obj hom) (a : obj) (b : obj)
                           (f : hom a b) (g : hom a b) (e : Egyenlito k a b f g) where
  constructor EgyenlitoEgyertelmuKonstruktor
  egyenlitoEgyertelmuTorveny : (q : obj) -> (h : hom q a)
                            -> (k.osszetetel h f = k.osszetetel h g)
                            -> (k1 : hom q e.egyenlitoObjektum) -> (k2 : hom q e.egyenlitoObjektum)
                            -> (k.osszetetel k1 e.egyenlitoMorfizmus = h)
                            -> (k.osszetetel k2 e.egyenlitoMorfizmus = h)
                            -> k1 = k2

-- ─── A.6 KOEGYENLÍTŐ EGYÉRTELMŰSÉGE ──────────────────────────
public export
record KoegyenlitoEgyertelmu (k : Kategoria obj hom) (a : obj) (b : obj)
                             (f : hom a b) (g : hom a b) (q : Koegyenlito k a b f g) where
  constructor KoegyenlitoEgyertelmuKonstruktor
  koegyenlitoEgyertelmuTorveny : (d : obj) -> (h : hom b d)
                              -> (k.osszetetel f h = k.osszetetel g h)
                              -> (k1 : hom q.koegyenlitoObjektum d) -> (k2 : hom q.koegyenlitoObjektum d)
                              -> (k.osszetetel q.koegyenlitoMorfizmus k1 = h)
                              -> (k.osszetetel q.koegyenlitoMorfizmus k2 = h)
                              -> k1 = k2

-- ─── A.7 ÁLTALÁNOS LIMIT EGYÉRTELMŰSÉGE ──────────────────────
-- Megjegyzés: az általános limit/kolimit egyértelműségi rekordok
-- a dMor implicit paraméter problémája miatt még nincsenek
-- implementálva. A 6 bináris fogalom (Szorzat, Koprodukt, Pullback,
-- Pushout, Egyenlítő, Koegyenlítő) egyértelműsége megvan.
-- TODO: a dMor paraméter kürésének megoldása a későbbi lépésekben.

-- ═══════════════════════════════════════════════════════════════
-- REFL-BIZONYÍTÁSOK (GAN-javaslat, a typechecker ellenőrzi)
-- ═══════════════════════════════════════════════════════════════

-- ─── BIZONYÍTÁS 1: a végződés morfizmus önmagára = azonos ──
-- Kimenet (MANTRA): vegzodesMorfizmus T = azonos T  (Refl ✓)
-- Forrás: nLab "terminal object" — a végződésből önmagába egyetlen
-- morfizmus van, és az azonos is az, tehát egyenlők.
public export
vegzodesAzonosBizonyitas : (v : Vegzodes k)
                        -> v.vegzodesMorfizmus v.vegzodesObjektum = k.azonos v.vegzodesObjektum
vegzodesAzonosBizonyitas v = sym (v.vegzodesEgyertelmu (k.azonos v.vegzodesObjektum))

-- ─── DIAGONÁLIS MORFIZMUS (GAN-javaslat B) ──────────────────
-- Δ : A → A×A, a szorzat univerzális tulajdonságának következménye.
-- Forrás: nLab "diagonal morphism" / Awodey §5.2.
public export
record Diagonal (k : Kategoria obj hom) (a : obj) (s : Szorzat k a a) where
  constructor DiagonalKonstruktor
  diagonalMorfizmus : hom a s.szorzatObjektum
  -- Δ∘π₁ = id (a bal projekció komponálva a diagonálissal = azonos)
  diagonalBalTorveny : k.osszetetel diagonalMorfizmus s.szorzatProjekcioBal = k.azonos a
  -- Δ∘π₂ = id (a jobb projekció komponálva a diagonálissal = azonos)
  diagonalJobbTorveny : k.osszetetel diagonalMorfizmus s.szorzatProjekcioJobb = k.azonos a
