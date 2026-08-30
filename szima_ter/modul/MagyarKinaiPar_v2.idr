module MagyarKinaiPar_v2

-- ═══════════════════════════════════════════════════════════════
-- MAGYAR ↔ KÍNAI PARTIKULA-PÁR — a Cat² szintje
-- ═══════════════════════════════════════════════════════════════
-- A felhasználó (2026-08-19):
--   "a magyar a szintaxis, a kínai a szemantika — 2-kategória elég"
--
-- Ez a modul a magyar ↔ kínai partikula-párt definiálja, Refl-bizonyításokkal:
--   - magyar toldalék → kínai partikula  (F functor)
--   - kínai partikula → magyar toldalék  (G functor)
--   - a kettő közötti természetes transzformáció (2-sejt)
--
-- A komplex bájt (KomplexByte.idr) a "cat" objektum: a fordítás
-- ezen KERESZTÜL történik (a Cat³ szintje).
--
-- A "soha ne írj felül" szabály (AGENTS.md §13) mi est ÚJ fájl.
-- ═══════════════════════════════════════════════════════════════

import KomplexByte

%default total

-- ─── 0. A CAT^∞ HELYZET (a keretrendszer) ────────────────────

||| A Cat^∞ hierarchia szintjei (saját Cat³ projekt).
public export
data CatSzint : Type where
  Cat0Set : CatSzint  -- halmazok
  Cat1Cat : CatSzint  -- kategoriak (a magyar CPT es a kinai CPT)
  Cat2Cat : CatSzint  -- functor-kategoriak (a magyar ↔ kinai)
  Cat3Cat : CatSzint  -- 2-funktor-kategoriak
  CatN    : CatSzint  -- ∞-kategoria

public export
Show CatSzint where
  show Cat0Set = "Cat^0 = Set"
  show Cat1Cat = "Cat^1 = Cat"
  show Cat2Cat = "Cat^2 = Cat^Cat (magyar ↔ kinai)"
  show Cat3Cat = "Cat^3 = Cat^Cat^Cat"
  show CatN    = "Cat^∞ = ∞-kategoria"

||| A magyar ↔ kínai rendszer a Cat^2 szintje.
public export
magyarKinaiRendszerSzintje : CatSzint
magyarKinaiRendszerSzintje = Cat2Cat

-- ─── 1. A MAGYAR OLDAL — a toldalékok (szintaxis) ─────────────

||| A magyar igeidők (a CPT idő-dimenziója).
public export
data MagyarIgeido = MagyarJelen | MagyarMult | MagyarJovo

public export
Show MagyarIgeido where
  show MagyarJelen = "jelen"
  show MagyarMult  = "mult"
  show MagyarJovo  = "jovo"

||| A magyar aspektus (a CPT szemlélet-dimenziója).
public export
data MagyarAspektus = MagyarImperfectum | MagyarPerfectum | MagyarHabituális

public export
Show MagyarAspektus where
  show MagyarImperfectum = "imperfectum"
  show MagyarPerfectum   = "perfectum"
  show MagyarHabituális  = "habitualis"

||| A magyar mód (a CPT forrás-dimenziója).
public export
data MagyarMod = MagyarKijelento | MagyarFelteteles | MagyarFelszolito

public export
Show MagyarMod where
  show MagyarKijelento  = "kijelento"
  show MagyarFelteteles = "felteteles"
  show MagyarFelszolito = "felszolito"

||| A magyar CPT együttesen.
public export
record MagyarCPT where
  constructor MagyarCPTKonstruktor
  idoMagyar : MagyarIgeido
  aspektusMagyar : MagyarAspektus
  modMagyar : MagyarMod

public export
Show MagyarCPT where
  show (MagyarCPTKonstruktor i a m) =
    "MagyarCPT (" ++ show i ++ ", " ++ show a ++ ", " ++ show m ++ ")"

-- ─── 2. A KÍNAI OLDAL — a partikulák (szemantika) ────────────

||| A kínai tonalitás (4 tonem, 2 kubit). A KinaiCPT ELŐTT definiálva.
public export
data KubitTonalitas = KubitTonalitasKonstruktor Kubit Kubit

public export
Show KubitTonalitas where
  show (KubitTonalitasKonstruktor Nulla Nulla) = "1. tonem (magas-sima)"
  show (KubitTonalitasKonstruktor Nulla Egy)   = "2. tonem (emelkedo)"
  show (KubitTonalitasKonstruktor Egy Nulla)   = "3. tonem (ereszkedo-emelkedo)"
  show (KubitTonalitasKonstruktor Egy Egy)     = "4. tonem (ereszkedo)"

||| A kínai aspektus-partikulák (4 állapot, a magyar 3-mal szemben).
public export
data KinaiAspektus = KinaiLe  -- 了: perfectiv (befejezett)
                    | KinaiGuo -- 过: experiential (tapasztalati)
                    | KinaiZhe -- 着: durativ (folyamatos)
                    | KinaiZai -- 在: progressziv (folyamatban levo)

public export
Show KinaiAspektus where
  show KinaiLe  = "le (了, perfectiv)"
  show KinaiGuo = "guo (过, experiential)"
  show KinaiZhe = "zhe (着, durativ)"
  show KinaiZai = "zai (在, progressziv)"

||| A kínai modalitás-partikulák (mondatvégi).
public export
data KinaiModalitas = KinaiDe  -- 的: allitas/megerosites
                     | KinaiLeM -- 了: valtozas/uj allapot
                     | KinaiMa  -- 吗: kerdes
                     | KinaiBa  -- 吧: javaslat

public export
Show KinaiModalitas where
  show KinaiDe  = "de (的, allitas)"
  show KinaiLeM = "le mondatvegen (了, valtozas)"
  show KinaiMa  = "ma (吗, kerdes)"
  show KinaiBa  = "ba (吧, javaslat)"

||| A kínai CPT (a funkcio-trinás: aspektus + modalitás + tonalitás).
public export
record KinaiCPT where
  constructor KinaiCPTKonstruktor
  aspektusKinai : KinaiAspektus
  modalitasKinai : KinaiModalitas
  tonalitasKinai : KubitTonalitas

public export
Show KinaiCPT where
  show (KinaiCPTKonstruktor a m t) =
    "KinaiCPT (" ++ show a ++ ", " ++ show m ++ ", " ++ show t ++ ")"

-- ─── 3. A FORDÍTÓ-FUNKTOROK (1-sejtek a Cat²-ben) ────────────

||| Az F functor: MagyarCPT → KinaiCPT.
||| A magyar 3 aspektust a kínai 4 aspektusra képezi le.
public export
magyarAspektusToKinai : MagyarAspektus -> KinaiAspektus
magyarAspektusToKinai MagyarImperfectum = KinaiZhe   -- -ó/-ő → 着 (folyamatos)
magyarAspektusToKinai MagyarPerfectum   = KinaiLe    -- -t → 了 (befejezett)
magyarAspektusToKinai MagyarHabituális  = KinaiGuo   -- szokott → 过 (tapasztalati)

||| A magyar módot a kínai modalitásra.
public export
magyarModToKinaiModalitas : MagyarMod -> KinaiModalitas
magyarModToKinaiModalitas MagyarKijelento  = KinaiDe   -- kijelento → 的
magyarModToKinaiModalitas MagyarFelteteles = KinaiBa   -- felteteles → 吧
magyarModToKinaiModalitas MagyarFelszolito = KinaiBa   -- felszolito → 吧

||| Az F functor (MagyarCPT → KinaiCPT): minden dimenziót leképez.
public export
forditF : MagyarCPT -> KinaiCPT
forditF (MagyarCPTKonstruktor i a m) =
  KinaiCPTKonstruktor
    (magyarAspektusToKinai a)
    (magyarModToKinaiModalitas m)
    (KubitTonalitasKonstruktor Nulla Nulla)

||| A G functor (KinaiCPT → MagyarCPT): visszafelé.
public export
kinaiAspektusToMagyar : KinaiAspektus -> MagyarAspektus
kinaiAspektusToMagyar KinaiLe  = MagyarPerfectum    -- 了 → -t (befejezett)
kinaiAspektusToMagyar KinaiGuo = MagyarHabituális   -- 过 → szokott
kinaiAspektusToMagyar KinaiZhe = MagyarImperfectum  -- 着 → -ó/-ő
kinaiAspektusToMagyar KinaiZai = MagyarImperfectum  -- 在 → -ó/-ő (folyamatban)

||| A kínai modalitást magyar módra.
public export
kinaiModalitasToMagyarMod : KinaiModalitas -> MagyarMod
kinaiModalitasToMagyarMod KinaiDe  = MagyarKijelento   -- 的 → kijelento
kinaiModalitasToMagyarMod KinaiLeM = MagyarKijelento   -- 了 (mondatveg) → kijelento
kinaiModalitasToMagyarMod KinaiMa  = MagyarKijelento   -- 吗 → kijelento (kerdes)
kinaiModalitasToMagyarMod KinaiBa  = MagyarFelszolito  -- 吧 → felszolito

||| A G functor (KinaiCPT → MagyarCPT).
public export
forditG : KinaiCPT -> MagyarCPT
forditG (KinaiCPTKonstruktor a m t) =
  MagyarCPTKonstruktor
    MagyarJelen  -- a kínai tonalitás nem kódol igeidot
    (kinaiAspektusToMagyar a)
    (kinaiModalitasToMagyarMod m)

-- ─── 4. A TERMÉSZETES TRANSZFORMÁCIÓ (2-sejt a Cat²-ben) ────

||| A F és G functorok közötti természetes transzformáció.
||| Nem egymás inverzei (az információ részben elveszik).
public export
record TermeszetesTranszformacio where
  constructor TermeszetesTranszformacioKonstruktor
  magyarOldal : MagyarCPT
  kinaiOldal  : KinaiCPT
  egyenloseg  : forditF magyarOldal = kinaiOldal

public export
Show TermeszetesTranszformacio where
  show (TermeszetesTranszformacioKonstruktor m k _) =
    "eta: " ++ show m ++ " ↦ " ++ show k

-- ─── 5. A CAT² POZÍCIÓ (a Cat^Cat szintje) ──────────────────

||| A magyar ↔ kínai rendszer a Cat²-ben:
|||   0-sejt: MagyarCPT (magyar), KinaiCPT (kínai)
|||   1-sejt: forditF (F functor), forditG (G functor)
|||   2-sejt: TermeszetesTranszformacio (eta)
public export
data Cat2Sint : Type where
  Cat2Magyar : MagyarCPT -> Cat2Sint
  Cat2Kinai  : KinaiCPT -> Cat2Sint
  Cat2Functor : Cat2Sint -> Cat2Sint -> Cat2Sint  -- 1-sejt
  Cat2Termeszetes : Cat2Sint -> Cat2Sint -> Cat2Sint -> Cat2Sint  -- 2-sejt

public export
Show Cat2Sint where
  show (Cat2Magyar m) = "MagyarCPT: " ++ show m
  show (Cat2Kinai k)  = "KinaiCPT: "  ++ show k
  show (Cat2Functor a b) = "Functor: " ++ show a ++ " → " ++ show b
  show (Cat2Termeszetes a b c) =
    "TermTransz: " ++ show a ++ " ⇒ " ++ show b ++ " (in " ++ show c ++ ")"

-- ─── 6. BIZONYÍTÁSOK (Refl, a fordító ellenőrizte) ────────────

||| A magyar aspektus-értékek száma = 3 (teljes lista).
public export
magyarAspektusLista : List MagyarAspektus
magyarAspektusLista =
  [MagyarImperfectum, MagyarPerfectum, MagyarHabituális]

||| Nagybetus alias a magyarAspektusLista-ra (a bizonyításokhoz).
public export
MagyarAspektusListaKonst : List MagyarAspektus
MagyarAspektusListaKonst = magyarAspektusLista

||| Biz -- a magyar aspektus-lista hossza = 3.
public export
bizMagyarAspektusHarom : length MagyarAspektusListaKonst = 3
bizMagyarAspektusHarom = Refl

||| A kínai aspektus-értékek száma = 4 (teljes lista).
public export
kinaiAspektusLista : List KinaiAspektus
kinaiAspektusLista =
  [KinaiLe, KinaiGuo, KinaiZhe, KinaiZai]

||| Nagybetus alias a kinaiAspektusLista-ra (a bizonyításokhoz).
public export
KinaiAspektusListaKonst : List KinaiAspektus
KinaiAspektusListaKonst = kinaiAspektusLista

||| Biz -- a kínai aspektus-lista hossza = 4.
public export
bizKinaiAspektusNegy : length KinaiAspektusListaKonst = 4
bizKinaiAspektusNegy = Refl

||| Az F functor a magyar aspektus-halmazt a kínai aspektus-halmazba képezi.
public export
magyarAspektusToKinaiLista : List KinaiAspektus
magyarAspektusToKinaiLista = map magyarAspektusToKinai magyarAspektusLista

||| Biz -- az F functor a magyar lista harom eleme (a lista konkret elemein).
public export
bizFListaMeret :
  List.length (magyarAspektusToKinai MagyarImperfectum ::
               magyarAspektusToKinai MagyarPerfectum ::
               magyarAspektusToKinai MagyarHabituális ::
               []) = 3
bizFListaMeret = Refl

||| Biz -- a magyar Habituális → kínai Guo (tapasztalati).
public export
bizMagyarHabituToKinaiGuo :
  magyarAspektusToKinai MagyarHabituális = KinaiGuo
bizMagyarHabituToKinaiGuo = Refl

||| Biz -- a magyar Imperfectum → kínai Zhe (durativ).
public export
bizMagyarImperfToKinaiZhe :
  magyarAspektusToKinai MagyarImperfectum = KinaiZhe
bizMagyarImperfToKinaiZhe = Refl

||| Biz -- a magyar Perfectum → kínai Le (perfectiv).
public export
bizMagyarPerfToKinaiLe :
  magyarAspektusToKinai MagyarPerfectum = KinaiLe
bizMagyarPerfToKinaiLe = Refl

||| Biz -- a kínai Le → magyar Perfectum.
public export
bizKinaiLeToMagyarPerf :
  kinaiAspektusToMagyar KinaiLe = MagyarPerfectum
bizKinaiLeToMagyarPerf = Refl

||| Biz -- a kínai Zai → magyar Imperfectum (a 在 a progressziv).
public export
bizKinaiZaiToMagyarImperf :
  kinaiAspektusToMagyar KinaiZai = MagyarImperfectum
bizKinaiZaiToMagyarImperf = Refl

||| Biz -- a magyar Kijelento → kínai De (allitas).
public export
bizMagyarKijToKinaiDe :
  magyarModToKinaiModalitas MagyarKijelento = KinaiDe
bizMagyarKijToKinaiDe = Refl

||| Biz -- a magyar Felszolito → kínai Ba (javaslat).
public export
bizMagyarFelszToKinaiBa :
  magyarModToKinaiModalitas MagyarFelszolito = KinaiBa
bizMagyarFelszToKinaiBa = Refl

||| Biz -- az F functor egy konkrét elemen (MagyarCPT).
public export
bizForditFPelder :
  forditF (MagyarCPTKonstruktor MagyarJelen MagyarHabituális MagyarKijelento) =
  KinaiCPTKonstruktor KinaiGuo KinaiDe (KubitTonalitasKonstruktor Nulla Nulla)
bizForditFPelder = Refl

||| Biz -- a G functor egy konkrét elemen (KinaiCPT).
public export
bizForditGPelder :
  forditG (KinaiCPTKonstruktor KinaiLe KinaiMa (KubitTonalitasKonstruktor Nulla Nulla)) =
  MagyarCPTKonstruktor MagyarJelen MagyarPerfectum MagyarKijelento
bizForditGPelder = Refl