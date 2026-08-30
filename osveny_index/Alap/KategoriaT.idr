module Alap.KategoriaT

-- ═══════════════════════════════════════════════════════════════
-- 49 KATEGÓRIAELMÉLETI STRUKTÚRA — MIND TYPECLASS-KÉNT
-- ═══════════════════════════════════════════════════════════════
-- Awodey 39 + Mac Lane 10 = 49 struktúra.
-- Minden struktúra egy typeclass (interface).
-- A typeclass instance = a törvények bizonyítása (Curry-Howard).
--
-- MINTA: Idris interface-ek NEM hozzák automatikusan a szuperosztály
-- metódusait a hatókörbe. Ezért:
--   - Az interface-ek CSAK primitív metódusokat tartalmaznak.
--   - A törvények, amik szuperosztály metódusaira hivatkoznak,
--     külön top-level függvények, explicit constraint-ekkel.

-- ═══════════════════════════════════════════════════════════════
-- SZINT 1: ALAPSTRUKTÚRÁK
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. KATEGÓRIA (#1) ──────────────────────────────────────
-- https://en.wikipedia.org/wiki/Category_(mathematics)
-- identitas, kompozicio + 3 torveny (asszociativ, bal/jobb egység).
-- A torvenyek itt benne vannak, mert csak sajat metodusokra hivatkoznak.
public export
interface KategoriaT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  identitas : (a : objektum) -> hom a a
  kompozicio : {a, b, c : objektum} -> hom a b -> hom b c -> hom a c
  balAzonos : {a, b : objektum} -> (f : hom a b) -> kompozicio (identitas a) f = f
  jobbAzonos : {a, b : objektum} -> (f : hom a b) -> kompozicio f (identitas b) = f
  asszociativ : {a, b, c, d : objektum} -> (f : hom a b) -> (g : hom b c) -> (h : hom c d) ->
    kompozicio f (kompozicio g h) = kompozicio (kompozicio f g) h

-- ─── 28. FÉLCSOPORT / SEMIGROUP (#28) ────────────────────────
-- https://en.wikipedia.org/wiki/Semigroup
public export
interface FelcsoportT (m : Type) where
  muvelet : m -> m -> m
  felcsoportAsszociativ : (a, b, c : m) -> muvelet (muvelet a b) c = muvelet a (muvelet b c)

-- ─── 31. ELŐRENDEZÉS / PREORDER (#31) ────────────────────────
-- https://en.wikipedia.org/wiki/Preorder
public export
interface ElorerendezesT (a : Type) where
  kisebbVagyEgyenlo : a -> a -> Type
  refleksiv : (x : a) -> kisebbVagyEgyenlo x x
  tranzitiv : (x, y, z : a) -> kisebbVagyEgyenlo x y -> kisebbVagyEgyenlo y z -> kisebbVagyEgyenlo x z

-- ─── 35. ELLENKEZŐ KATEGÓRIA / OPPOSITE (#35) ────────────────
-- https://en.wikipedia.org/wiki/Opposite_category
public export
interface KategoriaT objektum hom => EllenkezoKategoriaT objektum hom where
  forditottNyil : {a, b : objektum} -> hom a b -> hom b a

-- ─── 30. RÉSZBENRENDEZETT HALMAZ / POSET (#30) ──────────────
-- https://en.wikipedia.org/wiki/Partially_ordered_set
public export
interface ElorerendezesT a => ReszbenrendezettHalmazT (a : Type) where
  antiszimmetria : (x, y : a) -> kisebbVagyEgyenlo x y -> kisebbVagyEgyenlo y x -> x = y

-- ═══════════════════════════════════════════════════════════════
-- SZINT 2: FUNKTOROK ÉS TERMÉSZETES TRANSZFORMÁCIÓK
-- ═══════════════════════════════════════════════════════════════

-- ─── 2. FUNKTOR / FUNCTOR (#2) ──────────────────────────────
-- https://en.wikipedia.org/wiki/Functor
-- objKep parameterkent, mert morfizmusKep hivatkozik ra.
public export
interface (KategoriaT o1 m1, KategoriaT o2 m2) =>
  FunktorT (o1 : Type) (m1 : o1 -> o1 -> Type)
           (o2 : Type) (m2 : o2 -> o2 -> Type)
           (objKep : o1 -> o2) | o1 where
  morfizmusKep : {a, b : o1} -> m1 a b -> m2 (objKep a) (objKep b)

-- ─── 3. TERMÉSZETES TRANSZFORMÁCIÓ (#3) ──────────────────────
-- https://en.wikipedia.org/wiki/Natural_transformation
public export
interface (KategoriaT o1 m1, KategoriaT o2 m2) =>
  TermeszetesTranszformacioT (o1 : Type) (m1 : o1 -> o1 -> Type)
                              (o2 : Type) (m2 : o2 -> o2 -> Type)
                              (f1 : o1 -> o2) (f2 : o1 -> o2) | o1 where
  komponens : (a : o1) -> m2 (f1 a) (f2 a)

-- ─── 5. TERMÉSZETES IZOMORFIZMUS (#5) ───────────────────────
-- https://en.wikipedia.org/wiki/Natural_isomorphism
public export
interface (TermeszetesTranszformacioT o1 m1 o2 m2 f1 f2, KategoriaT o2 m2) =>
  TermeszetesIzomorfizmusT (o1 : Type) (m1 : o1 -> o1 -> Type)
                           (o2 : Type) (m2 : o2 -> o2 -> Type)
                           (f1 : o1 -> o2) (f2 : o1 -> o2) | o1 where
  termeszetesIzoInverz : (a : o1) -> m2 (f2 a) (f1 a)

-- ─── 4. FUNKTOR KATEGÓRIA (#4) ─────────────────────────────
-- https://en.wikipedia.org/wiki/Functor_category
public export
interface (KategoriaT o1 m1, KategoriaT o2 m2) =>
  FunktorKategoriaT (o1 : Type) (m1 : o1 -> o1 -> Type)
                    (o2 : Type) (m2 : o2 -> o2 -> Type) | o1 where
  funktorKategoriaObjektum : (o1 -> o2) -> Type

-- ═══════════════════════════════════════════════════════════════
-- SZINT 3: ALGEBRAI STRUKTÚRÁK
-- ═══════════════════════════════════════════════════════════════

-- ─── 27. MONOID (#27) ──────────────────────────────────────
-- https://en.wikipedia.org/wiki/Monoid
public export
interface FelcsoportT m => MonoidT (m : Type) where
  egysegelem : m

-- ─── 26. CSOPORT / GROUP (#26) ──────────────────────────────
-- https://en.wikipedia.org/wiki/Group_(mathematics)
public export
interface MonoidT g => CsoportT (g : Type) where
  inverz : g -> g

-- ─── 6. IZOMORFIZMUS (#6) ──────────────────────────────────
-- https://en.wikipedia.org/wiki/Isomorphism
public export
interface KategoriaT objektum hom => IzomorfizmusT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  izomorfizmusNyil : {a, b : objektum} -> hom a b
  izomorfizmusInverz : {a, b : objektum} -> hom b a

-- ─── 7. MONOMORFIZMUS (#7) ──────────────────────────────────
-- https://en.wikipedia.org/wiki/Monomorphism
public export
interface KategoriaT objektum hom => MonomorfizmusT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  monomorfizmusNyil : {a, b : objektum} -> hom a b

-- ─── 8. EPIMORFIZMUS (#8) ──────────────────────────────────
-- https://en.wikipedia.org/wiki/Epimorphism
public export
interface KategoriaT objektum hom => EpimorfizmusT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  epimorfizmusNyil : {a, b : objektum} -> hom a b

-- ═══════════════════════════════════════════════════════════════
-- SZINT 4: LIMITEK ÉS KOLIMITEK
-- ═══════════════════════════════════════════════════════════════

-- ─── 9. KEZDŐ OBJEKTUM / INITIAL (#9) ────────────────────────
-- https://en.wikipedia.org/wiki/Initial_and_terminal_objects
public export
interface KategoriaT objektum hom => KezdoObjektumT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  kezdoObjektum : objektum
  kezdoNyil : (a : objektum) -> hom kezdoObjektum a

-- ─── 10. VÉGOBJEKTUM / TERMINAL (#10) ───────────────────────
-- https://en.wikipedia.org/wiki/Initial_and_terminal_objects
public export
interface KategoriaT objektum hom => VegobjektumT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  vegobjektum : objektum
  vegNyil : (a : objektum) -> hom a vegobjektum

-- ─── 11. SZORZAT / PRODUCT (#11) ────────────────────────────
-- https://en.wikipedia.org/wiki/Product_(category_theory)
public export
interface KategoriaT objektum hom => SzorzatT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  szorzatObjektum : objektum -> objektum -> objektum
  elsoProjekcio : {a, b : objektum} -> hom (szorzatObjektum a b) a
  masodikProjekcio : {a, b : objektum} -> hom (szorzatObjektum a b) b
  parositass : {z, a, b : objektum} -> hom z a -> hom z b -> hom z (szorzatObjektum a b)

-- ─── 12. KOSZORZAT / COPRODUCT (#12) ────────────────────────
-- https://en.wikipedia.org/wiki/Coproduct
public export
interface KategoriaT objektum hom => KoszorzatT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  koszorzatObjektum : objektum -> objektum -> objektum
  elsoInjekcio : {a, b : objektum} -> hom a (koszorzatObjektum a b)
  masodikInjekcio : {a, b : objektum} -> hom b (koszorzatObjektum a b)
  elagazass : {z, a, b : objektum} -> hom a z -> hom b z -> hom (koszorzatObjektum a b) z

-- ─── 13. KIEGYENLÍTŐ / EQUALIZER (#13) ──────────────────────
-- https://en.wikipedia.org/wiki/Equalizer_(mathematics)
public export
interface KategoriaT objektum hom => KiegyenlitoT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  kiegyenlitoObjektum : {a, b : objektum} -> (f, g : hom a b) -> objektum
  kiegyenlitoNyil : {a, b : objektum} -> (f, g : hom a b) -> hom (kiegyenlitoObjektum f g) a

-- ─── 14. KOKIEGYENLÍTŐ / COEQUALIZER (#14) ──────────────────
-- https://en.wikipedia.org/wiki/Coequalizer
public export
interface KategoriaT objektum hom => KokiegyenlitoT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  kokiegyenlitoObjektum : {a, b : objektum} -> (f, g : hom a b) -> objektum
  kokiegyenlitoNyil : {a, b : objektum} -> (f, g : hom a b) -> hom b (kokiegyenlitoObjektum f g)

-- ─── 15. VISSZAHÚZÁS / PULLBACK (#15) ───────────────────────
-- https://en.wikipedia.org/wiki/Pullback_(category_theory)
public export
interface KategoriaT objektum hom => VisszahuzasT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  visszahuzasObjektum : {a, b, c : objektum} -> (f : hom a c) -> (g : hom b c) -> objektum
  visszahuzasElsoProjekcio : {a, b, c : objektum} -> (f : hom a c) -> (g : hom b c) -> hom (visszahuzasObjektum f g) a
  visszahuzasMasodikProjekcio : {a, b, c : objektum} -> (f : hom a c) -> (g : hom b c) -> hom (visszahuzasObjektum f g) b

-- ─── 16. KITOLÁS / PUSHOUT (#16) ────────────────────────────
-- https://en.wikipedia.org/wiki/Pushout_(category_theory)
public export
interface KategoriaT objektum hom => KitolasT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  kitolasObjektum : {a, b, c : objektum} -> (f : hom a b) -> (g : hom a c) -> objektum
  kitolasElsoInjekcio : {a, b, c : objektum} -> (f : hom a b) -> (g : hom a c) -> hom b (kitolasObjektum f g)
  kitolasMasodikInjekcio : {a, b, c : objektum} -> (f : hom a b) -> (g : hom a c) -> hom c (kitolasObjektum f g)

-- ─── 17. LIMESZ / LIMIT (#17) ───────────────────────────────
-- https://en.wikipedia.org/wiki/Limit_(category_theory)
public export
interface KategoriaT objektum hom => LimeszT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  limeszObjektum : (alakzat : Type) -> (diagram : alakzat -> objektum) -> objektum
  limeszProjekcio : (alakzat : Type) -> (diagram : alakzat -> objektum) -> (j : alakzat) ->
    hom (limeszObjektum alakzat diagram) (diagram j)

-- ─── 18. KOLIMESZ / COLIMIT (#18) ───────────────────────────
-- https://en.wikipedia.org/wiki/Limit_(category_theory)
public export
interface KategoriaT objektum hom => KolimeszT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  kolimeszObjektum : (alakzat : Type) -> (diagram : alakzat -> objektum) -> objektum
  kolimeszInjekcio : (alakzat : Type) -> (diagram : alakzat -> objektum) -> (j : alakzat) ->
    hom (diagram j) (kolimeszObjektum alakzat diagram)

-- ═══════════════════════════════════════════════════════════════
-- SZINT 5: EXPOENCIÁL ÉS ZÁRT KATEGÓRIÁK
-- ═══════════════════════════════════════════════════════════════

-- ─── 19. EXPOENCIÁL / EXPONENTIAL (#19) ─────────────────────
-- https://en.wikipedia.org/wiki/Exponential_object
public export
interface (KategoriaT objektum hom, SzorzatT objektum hom) =>
  ExponencialT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  exponencialisObjektum : objektum -> objektum -> objektum
  kiertekelt : {b, c : objektum} -> hom (szorzatObjektum (exponencialisObjektum b c) b) c
  transzpozicio : {z, b, c : objektum} -> hom (szorzatObjektum z b) c -> hom z (exponencialisObjektum b c)

-- ─── 20. KARTÉZIÁNUSAN ZÁRT KATEGÓRIA / CCC (#20) ───────────
-- https://en.wikipedia.org/wiki/Cartesian_closed_category
public export
interface (VegobjektumT objektum hom, SzorzatT objektum hom, ExponencialT objektum hom) =>
  KartezianusZartKategoriaT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where

-- ─── 21. HEYTING ALGEBRA (#21) ──────────────────────────────
-- https://en.wikipedia.org/wiki/Heyting_algebra
public export
interface (ReszbenrendezettHalmazT a, FelcsoportT a) =>
  HeytingAlgebraT (a : Type) where
  kovetes : a -> a -> a

-- ─── 22. BOOLE ALGEBRA (#22) ────────────────────────────────
-- https://en.wikipedia.org/wiki/Boolean_algebra_(structure)
public export
interface HeytingAlgebraT a => BooleAlgebraT (a : Type) where
  komplementum : a -> a

-- ═══════════════════════════════════════════════════════════════
-- SZINT 6: ADJUNKCIÓ, MONÁD, KOMONÁD
-- ═══════════════════════════════════════════════════════════════

-- ─── 23. ADJUNKCIÓ / ADJUNCTION (#23) ───────────────────────
-- https://en.wikipedia.org/wiki/Adjoint_functors
-- F ⊣ G: Hom_D(F a, b) ≅ Hom_C(a, G b).
-- A perem (Legendre) = adjunkció a kvantum és klasszikus között.
public export
interface (FunktorT o1 m1 o2 m2 f1, FunktorT o2 m2 o1 m1 g1) =>
  AdjunkcioT (o1 : Type) (m1 : o1 -> o1 -> Type)
             (o2 : Type) (m2 : o2 -> o2 -> Type)
             (f1 : o1 -> o2) (g1 : o2 -> o1) | o1 where
  adjunkcioEgyseg : (a : o1) -> m1 a (g1 (f1 a))
  adjunkcioKoegysseg : (b : o2) -> m2 (f1 (g1 b)) b

-- ─── 24. MONÁD / MONAD (#24) ───────────────────────────────
-- https://en.wikipedia.org/wiki/Monad_(category_theory)
public export
interface FunktorT o m o m endo => MonadT (o : Type) (m : o -> o -> Type) (endo : o -> o) | o where
  monadEgyseg : (a : o) -> m a (endo a)
  monadSzorzas : (a : o) -> m (endo (endo a)) (endo a)

-- ─── 25. KOMONÁD / COMONAD (#25) ────────────────────────────
-- https://en.wikipedia.org/wiki/Comonad
public export
interface FunktorT o m o m endo => KomonadT (o : Type) (m : o -> o -> Type) (endo : o -> o) | o where
  komonadKoegysseg : (a : o) -> m (endo a) a
  komonadKomultiplikacio : (a : o) -> m (endo a) (endo (endo a))

-- ═══════════════════════════════════════════════════════════════
-- SZINT 7: MONOIDÁLIS KATEGÓRIÁK (Mac Lane)
-- ═══════════════════════════════════════════════════════════════

-- ─── 40. MONOIDÁLIS KATEGÓRIA (#40) ─────────────────────────
-- https://en.wikipedia.org/wiki/Monoidal_category
-- A magyar agglutináció: tő ⊗ képző ⊗ rag = szó.
public export
interface KategoriaT objektum hom =>
  MonoidalisKategoriaT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  tenzor : objektum -> objektum -> objektum
  monoidalisEgyseg : objektum
  asszociator : {a, b, c : objektum} -> hom (tenzor a (tenzor b c)) (tenzor (tenzor a b) c)
  balEgysegIzomorfizmus : {a : objektum} -> hom (tenzor monoidalisEgyseg a) a
  jobbEgysegIzomorfizmus : {a : objektum} -> hom (tenzor a monoidalisEgyseg) a

-- ─── 41. FONOTT MONOIDÁLIS KATEGÓRIA / BRAIDED (#41) ────────
-- https://en.wikipedia.org/wiki/Braided_monoidal_category
public export
interface MonoidalisKategoriaT objektum hom =>
  FonottMonoidalisKategoriaT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  fonas : {a, b : objektum} -> hom (tenzor a b) (tenzor b a)

-- ─── 42. SZIMMETRIKUS MONOIDÁLIS KATEGÓRIA (#42) ─────────────
-- https://en.wikipedia.org/wiki/Symmetric_monoidal_category
public export
interface FonottMonoidalisKategoriaT objektum hom =>
  SzimmetrikusMonoidalisKategoriaT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where

-- ─── 43. ZÁRT KATEGÓRIA / CLOSED (#43) ──────────────────────
-- https://en.wikipedia.org/wiki/Closed_category
public export
interface SzimmetrikusMonoidalisKategoriaT objektum hom =>
  ZartKategoriaT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  belsoHom : objektum -> objektum -> objektum
  zartAdjunkcio : {a, b, c : objektum} -> hom (tenzor a b) c -> hom a (belsoHom b c)

-- ═══════════════════════════════════════════════════════════════
-- SZINT 8: 2-KATEGÓRIÁK
-- ═══════════════════════════════════════════════════════════════

-- ─── 44. 2-KATEGÓRIA / 2-CATEGORY (#44) ────────────────────
-- https://en.wikipedia.org/wiki/2-category
public export
interface KategoriaT objektum hom =>
  KettoKategoriaT (objektum : Type) (hom : objektum -> objektum -> Type)
                   (ketHom : (a, b : objektum) -> hom a b -> hom a b -> Type) | objektum where
  fuggolegesOsszetetel : {a, b : objektum} -> {f, g, h : hom a b} ->
    ketHom a b f g -> ketHom a b g h -> ketHom a b f h
  vizszintesOsszetetel : {a, b, c : objektum} -> {f1, f2 : hom a b} -> {g1, g2 : hom b c} ->
    ketHom a b f1 f2 -> ketHom b c g1 g2 ->
    ketHom a c (kompozicio {a=a} {b=b} {c=c} f1 g1) (kompozicio {a=a} {b=b} {c=c} f2 g2)

-- ─── 45. BIKATEGÓRIA / BICATEGORY (#45) ────────────────────
-- https://en.wikipedia.org/wiki/Bicategory
public export
interface KategoriaT objektum hom =>
  BikategoriaT (objektum : Type) (hom : objektum -> objektum -> Type)
                (ketHom : (a, b : objektum) -> hom a b -> hom a b -> Type) | objektum where
  bikategoriaAsszociator : {a, b, c, d : objektum} -> {f : hom a b} -> {g : hom b c} -> {h : hom c d} ->
    ketHom a d (kompozicio {a=a} {b=c} {c=d} (kompozicio {a=a} {b=b} {c=c} f g) h)
               (kompozicio {a=a} {b=b} {c=d} f (kompozicio {a=b} {b=c} {c=d} g h))
  bikategoriaBalEgyseg : {a, b : objektum} -> {f : hom a b} ->
    ketHom a b (kompozicio {a=a} {b=a} {c=b} (identitas a) f) f
  bikategoriaJobbEgyseg : {a, b : objektum} -> {f : hom a b} ->
    ketHom a b (kompozicio {a=a} {b=b} {c=b} f (identitas b)) f

-- ═══════════════════════════════════════════════════════════════
-- SZINT 9: KITERJESZTÉSEK (Kan, End, Coend)
-- ═══════════════════════════════════════════════════════════════

-- ─── 46. KAN KITERJESZTÉS (#46) ─────────────────────────────
-- https://en.wikipedia.org/wiki/Kan_extension
public export
interface (FunktorT o1 m1 o2 m2 f1, FunktorT o2 m2 o1 m1 g1) =>
  KanKiterjesztesT (o1 : Type) (m1 : o1 -> o1 -> Type)
                    (o2 : Type) (m2 : o2 -> o2 -> Type)
                    (f1 : o1 -> o2) (g1 : o2 -> o1) | o1 where
  jobbKan : (k : o1) -> o2 -> o2
  balKan : (k : o1) -> o2 -> o2

-- ─── 47. END / VÉG (#47) ───────────────────────────────────
-- https://en.wikipedia.org/wiki/End_(category_theory)
public export
interface KategoriaT objektum hom => EndT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  vegObjektum : {x : Type} -> (s : x -> x -> objektum) -> objektum
  vegErosites : {x : Type} -> (s : x -> x -> objektum) -> (c : x) -> hom (vegObjektum s) (s c c)

-- ─── 48. COEND / KÖVÉG (#48) ────────────────────────────────
-- https://en.wikipedia.org/wiki/End_(category_theory)
public export
interface KategoriaT objektum hom => KoendT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  kovegObjektum : {x : Type} -> (s : x -> x -> objektum) -> objektum
  kovegErosites : {x : Type} -> (s : x -> x -> objektum) -> (c : x) -> hom (s c c) (kovegObjektum s)

-- ═══════════════════════════════════════════════════════════════
-- SZINT 10: TOPOSZ ÉS SPECIÁLIS STRUKTÚRÁK
-- ═══════════════════════════════════════════════════════════════

-- ─── 37. TOPOSZ / TOPOS (#37) ──────────────────────────────
-- https://en.wikipedia.org/wiki/Topos
public export
interface (KartezianusZartKategoriaT objektum hom, LimeszT objektum hom) =>
  ToposzT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  reszobjektumOsztalyozo : objektum
  igazNyil : (a : objektum) -> hom a reszobjektumOsztalyozo
  karakterisztikusNyil : {a : objektum} -> hom a reszobjektumOsztalyozo

-- ─── 32. RÉSZOBJEKTUM / SUBOBJECT (#32) ────────────────────
-- https://en.wikipedia.org/wiki/Subobject
public export
interface (KategoriaT objektum hom, MonomorfizmusT objektum hom) =>
  ReszobjektumT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  reszobjektumNyil : {m, x : objektum} -> hom m x

-- ─── 33. YONEDA BEÁGYAZÁS (#33) ────────────────────────────
-- https://en.wikipedia.org/wiki/Yoneda_lemma
public export
interface (KategoriaT o1 m1, KategoriaT o2 m2) =>
  YonedaBeagyazasT (o1 : Type) (m1 : o1 -> o1 -> Type)
                    (o2 : Type) (m2 : o2 -> o2 -> Type) | o1 where
  yonedaObjektumKep : o1 -> o2

-- ─── 34. KATEGÓRIÁK EKVIVALENCIÁJA (#34) ────────────────────
-- https://en.wikipedia.org/wiki/Equivalence_of_categories
public export
interface (FunktorT o1 m1 o2 m2 f1, FunktorT o2 m2 o1 m1 g1) =>
  KategoriakEkvivalenciajaT (o1 : Type) (m1 : o1 -> o1 -> Type)
                            (o2 : Type) (m2 : o2 -> o2 -> Type)
                            (f1 : o1 -> o2) (g1 : o2 -> o1) | o1 where
  ekvivalenciaElso : (a : o1) -> m1 a (g1 (f1 a))
  ekvivalenciaMasodik : (b : o2) -> m2 (f1 (g1 b)) b

-- ─── 36. SZELT KATEGÓRIA / SLICE (#36) ─────────────────────
-- https://en.wikipedia.org/wiki/Overcategory
public export
interface KategoriaT objektum hom => SzeletKategoriaT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  szeletAlap : objektum
  szeletObjektum : (x : objektum) -> hom x szeletAlap
  szeletNyil : {x, y : objektum} -> (fx : hom x szeletAlap) -> (fy : hom y szeletAlap) -> hom x y

-- ─── 38. SZABAD KATEGÓRIA / FREE (#38) ──────────────────────
-- https://en.wikipedia.org/wiki/Free_category
public export
interface KategoriaT objektum hom => SzabadKategoriaT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  szabadGrafCsucs : Type
  szabadGrafEl : szabadGrafCsucs -> szabadGrafCsucs -> Type
  szabadBeagyazas : szabadGrafCsucs -> objektum

-- ─── 39. REPREZENTÁLHATÓ FUNKTOR (#39) ─────────────────────
-- https://en.wikipedia.org/wiki/Representable_functor
public export
interface FunktorT o1 m1 o2 m2 objKep => ReprezentalhatoFunktorT (o1 : Type) (m1 : o1 -> o1 -> Type)
                                                          (o2 : Type) (m2 : o2 -> o2 -> Type)
                                                          (objKep : o1 -> o2) | o1 where
  reprezentaloObjektum : o1

-- ─── 29. CSOPORT EGY KATEGÓRIÁBAN (#29) ────────────────────
-- https://en.wikipedia.org/wiki/Group_object
public export
interface (KategoriaT objektum hom, SzorzatT objektum hom, VegobjektumT objektum hom) =>
  CsoportKategoriabanT (objektum : Type) (hom : objektum -> objektum -> Type) | objektum where
  csoportObjektum : objektum
  csoportSzorzas : hom (szorzatObjektum csoportObjektum csoportObjektum) csoportObjektum
  csoportEgyseg : hom csoportObjektum csoportObjektum
  csoportInverz : hom csoportObjektum csoportObjektum