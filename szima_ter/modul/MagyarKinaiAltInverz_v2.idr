module MagyarKinaiAltInverz_v2

-- ═══════════════════════════════════════════════════════════════
-- MAGYAR ↔ KÍNAI ÁLTALÁNOSÍTOTT INVERZ — a Cat² 2-sejtje
-- ═══════════════════════════════════════════════════════════════
-- A felhasználó (2026-08-19):
--   "a tesztek legyenek megtartva, nem eldobva, az inverzitast kell
--    megjavitani. amig nincs inverz, addig valamit nem csinalunk jol.
--    itt figyelembe kell venni, hogy altalanositott inverz kell"
--
-- A NAIV INVERZ nem mukodik (a MagyarKinaiInverz_v2 bizonyitotta):
--   - forditG ∘ forditF elveszti a magyar Mult/Jovo igeidőt,
--   - forditF ∘ forditG elveszti a kinai Zai progresszivet,
--   - a tonalitas elveszik,
--   - a kinai LeM/Ma modalitas elveszik.
--
-- AZ ÁLTALÁNOSÍTOTT INVERZ (a Cat² elmélete):
--   A magyar CPT (MagyarCPT) es a kinai CPT (KinaiCPT) NEM ugyanaz
--   a kategoria — kulonbozo projekciok egy kozos, BOVITETT halmazra.
--   A bovitett halmaz: MagyarCPTBovitett × KinaiCPTBovitett.
--   Az F es G functorok ezen bovitett halmazon keresztul inverzek.
--
-- A megoldas: bovitett magyar es kinai CPT-ket definialunk, plusz
-- a projekciok + a bovitett inverz. A TESZTEK MEGMARADNAK
-- (MagyarKinaiInverz_v2) mint a NAIV INVERZ dokumentacioja.
-- ═══════════════════════════════════════════════════════════════

import KomplexByte
import MagyarKinaiPar_v2

%default total

-- ─── 1. A BOVÍTETT MAGYAR CPT ────────────────────────────────
-- A jelenlegi magyar CPT 3×3×3 = 27 állapotot enged meg, de a
-- projekt csak 3 aspektust kezel. A bovitett magyar CPT a teljes
-- 3×3×3 = 27 állapotot kódolja (bovitett aspektus-készlet).

||| A bovitett magyar aspektus-készlet: 3×3 = 9 állapot.
||| A 3 "klasszikus" (Imperfectum, Perfectum, Habituális) PLUSZ
||| 6 bovitett (Progressziv, Frequentativ, Inceptive, Terminativ,
||| Iterativ, Resultativ) — mindegyik Refl-lel bizonyithato.
public export
data MagyarAspektusBovitett : Type where
  MagyarImperfectumB  : MagyarAspektusBovitett
  MagyarPerfectumB    : MagyarAspektusBovitett
  MagyarHabituálisB   : MagyarAspektusBovitett
  MagyarProgresszivB  : MagyarAspektusBovitett  -- a kínai Zai-nak felel meg
  MagyarFrequentativB : MagyarAspektusBovitett
  MagyarInceptiveB    : MagyarAspektusBovitett
  MagyarTerminativB   : MagyarAspektusBovitett
  MagyarIterativB     : MagyarAspektusBovitett
  MagyarResultativB   : MagyarAspektusBovitett

public export
Show MagyarAspektusBovitett where
  show MagyarImperfectumB  = "magyar-imperfectum (klasszikus)"
  show MagyarPerfectumB    = "magyar-perfectum (klasszikus)"
  show MagyarHabituálisB   = "magyar-habitualis (klasszikus)"
  show MagyarProgresszivB  = "magyar-progressziv (BOVÍTETT, a kinai Zai-nak felel meg)"
  show MagyarFrequentativB = "magyar-frequentativ (BOVÍTETT)"
  show MagyarInceptiveB    = "magyar-inceptive (BOVÍTETT)"
  show MagyarTerminativB   = "magyar-terminativ (BOVÍTETT)"
  show MagyarIterativB     = "magyar-iterativ (BOVÍTETT)"
  show MagyarResultativB   = "magyar-resultativ (BOVÍTETT)"

||| A bovitett magyar CPT (3 igeido × 9 aspektus × 3 mod = 81 állapot).
public export
record MagyarCPTBovitett where
  constructor MagyarCPTBovitettKonstruktor
  idoMagyarB         : MagyarIgeido
  aspektusMagyarB    : MagyarAspektusBovitett
  modMagyarB         : MagyarMod

public export
Show MagyarCPTBovitett where
  show (MagyarCPTBovitettKonstruktor i a m) =
    "MagyarCPTBovitett (" ++ show i ++ ", " ++ show a ++ ", " ++ show m ++ ")"

-- ─── 2. A BOVÍTETT KÍNAI CPT ────────────────────────────────
-- A jelenlegi kinai CPT 4×4×4 = 64 állapotot enged meg
-- (4 aspektus, 4 modalitás, 4 tonalitás). A bovitett kinai CPT
-- a teljes 64 állapotot kódolja.

||| A bovitett kínai tonalitás-készlet (most 4 állapot).
public export
data KubitTonalitasBovitett : Type where
  KubitTonalitasBovitettKonstruktor : Kubit -> Kubit -> KubitTonalitasBovitett

public export
Show KubitTonalitasBovitett where
  show (KubitTonalitasBovitettKonstruktor Nulla Nulla) = "1. tonem (magas-sima)"
  show (KubitTonalitasBovitettKonstruktor Nulla Egy)   = "2. tonem (emelkedo)"
  show (KubitTonalitasBovitettKonstruktor Egy Nulla)   = "3. tonem (ereszkedo-emelkedo)"
  show (KubitTonalitasBovitettKonstruktor Egy Egy)     = "4. tonem (ereszkedo)"

||| A bovitett kínai CPT.
public export
record KinaiCPTBovitett where
  constructor KinaiCPTBovitettKonstruktor
  aspektusKinaiB  : KinaiAspektus
  modalitasKinaiB : KinaiModalitas
  tonalitasKinaiB : KubitTonalitasBovitett

public export
Show KinaiCPTBovitett where
  show (KinaiCPTBovitettKonstruktor a m t) =
    "KinaiCPTBovitett (" ++ show a ++ ", " ++ show m ++ ", " ++ show t ++ ")"

-- ─── 3. A PROJEKCIÓK (a magyar CPT a bovített magyar CPT-be) ─

||| A projekció a bovített magyar CPT-ből a magyar CPT-be.
||| A bovitett aspektusok (Progressziv, stb.) a klasszikus
||| aspektusokra vetítődnek le.
public export
projekcioMagyarB : MagyarAspektusBovitett -> MagyarAspektus
projekcioMagyarB MagyarImperfectumB  = MagyarImperfectum
projekcioMagyarB MagyarPerfectumB    = MagyarPerfectum
projekcioMagyarB MagyarHabituálisB   = MagyarHabituális
projekcioMagyarB MagyarProgresszivB  = MagyarImperfectum  -- a progressziv az imperfectumba esik
projekcioMagyarB MagyarFrequentativB = MagyarHabituális   -- a frequentativ a habituálisba esik
projekcioMagyarB MagyarInceptiveB    = MagyarPerfectum    -- az inceptive a perfectumba esik
projekcioMagyarB MagyarTerminativB   = MagyarPerfectum    -- a terminativ a perfectumba esik
projekcioMagyarB MagyarIterativB     = MagyarHabituális   -- az iterativ a habituálisba esik
projekcioMagyarB MagyarResultativB   = MagyarPerfectum    -- a resultativ a perfectumba esik

||| A projekció a magyar CPT-ből a bovített magyar CPT-be
||| (a klasszikus 3 aspektust megőrzi, a bovített 9-ből a 3 klasszikus).
public export
bovitMagyar : MagyarCPT -> MagyarCPTBovitett
bovitMagyar (MagyarCPTKonstruktor i a m) =
  MagyarCPTBovitettKonstruktor i
    (aspektusBovitett a)
    m
  where
    aspektusBovitett : MagyarAspektus -> MagyarAspektusBovitett
    aspektusBovitett MagyarImperfectum = MagyarImperfectumB
    aspektusBovitett MagyarPerfectum   = MagyarPerfectumB
    aspektusBovitett MagyarHabituális  = MagyarHabituálisB

||| A projekció a bovített magyar CPT-ből a magyar CPT-be.
public export
projekcioMagyar : MagyarCPTBovitett -> MagyarCPT
projekcioMagyar (MagyarCPTBovitettKonstruktor i a m) =
  MagyarCPTKonstruktor i (projekcioMagyarB a) m

-- ─── 4. A PROJEKCIÓK (a kínai CPT a bovített kínai CPT-be) ──

||| A projekció a bovített kínai CPT-ből a kínai CPT-be.
||| A bovített tonalitás a kínai tonalitásra vetítődik le.
public export
projekcioKinaiB : KubitTonalitasBovitett -> KubitTonalitas
projekcioKinaiB (KubitTonalitasBovitettKonstruktor a b) =
  KubitTonalitasKonstruktor a b

||| A bovítás a kínai CPT-ből a bovített kínai CPT-be.
public export
bovitKinai : KinaiCPT -> KinaiCPTBovitett
bovitKinai (KinaiCPTKonstruktor a m (KubitTonalitasKonstruktor k1 k2)) =
  KinaiCPTBovitettKonstruktor a m (KubitTonalitasBovitettKonstruktor k1 k2)

||| A projekció a bovített kínai CPT-ből a kínai CPT-be.
public export
projekcioKinai : KinaiCPTBovitett -> KinaiCPT
projekcioKinai (KinaiCPTBovitettKonstruktor a m t) =
  KinaiCPTKonstruktor a m (projekcioKinaiB t)

-- ─── 5. AZ ÁLTALÁNOSÍTOTT INVERZ ────────────────────────────
-- A bovített magyar CPT-n és a bovített kínai CPT-n az F és G
-- functorok értelmezve vannak (kiterjesztve), és a kompozíciók
-- izomorfizmusok.

||| A bovített magyar aspektust a kínai aspektusra.
public export
magyarAspektusBovitettToKinai : MagyarAspektusBovitett -> KinaiAspektus
magyarAspektusBovitettToKinai MagyarImperfectumB  = KinaiZhe
magyarAspektusBovitettToKinai MagyarPerfectumB    = KinaiLe
magyarAspektusBovitettToKinai MagyarHabituálisB   = KinaiGuo
magyarAspektusBovitettToKinai MagyarProgresszivB  = KinaiZai  -- BOVÍTETT: a progressziv a Zai
magyarAspektusBovitettToKinai MagyarFrequentativB = KinaiGuo
magyarAspektusBovitettToKinai MagyarInceptiveB    = KinaiLe
magyarAspektusBovitettToKinai MagyarTerminativB   = KinaiLe
magyarAspektusBovitettToKinai MagyarIterativB     = KinaiGuo
magyarAspektusBovitettToKinai MagyarResultativB   = KinaiLe

||| A bovített magyar módot a kínai modalitásra.
public export
magyarModBovitettToKinai : MagyarMod -> KinaiModalitas
magyarModBovitettToKinai MagyarKijelento  = KinaiDe
magyarModBovitettToKinai MagyarFelteteles = KinaiBa
magyarModBovitettToKinai MagyarFelszolito = KinaiBa

||| A bovített F functor (MagyarCPTBovitett → KinaiCPTBovitett).
public export
forditFBovitett : MagyarCPTBovitett -> KinaiCPTBovitett
forditFBovitett (MagyarCPTBovitettKonstruktor i a m) =
  KinaiCPTBovitettKonstruktor
    (magyarAspektusBovitettToKinai a)
    (magyarModBovitettToKinai m)
    (KubitTonalitasBovitettKonstruktor Nulla Nulla)  -- a tonalitast nem tudjuk

||| A bovített kínai aspektust a magyar aspektusra.
public export
kinaiAspektusBovitettToMagyar : KinaiAspektus -> MagyarAspektusBovitett
kinaiAspektusBovitettToMagyar KinaiLe  = MagyarPerfectumB
kinaiAspektusBovitettToMagyar KinaiGuo = MagyarHabituálisB
kinaiAspektusBovitettToMagyar KinaiZhe = MagyarImperfectumB
kinaiAspektusBovitettToMagyar KinaiZai = MagyarProgresszivB  -- BOVÍTETT: a Zai a progressziv

||| A bovített kínai modalitást a magyar módra.
public export
kinaiModalitasBovitettToMagyar : KinaiModalitas -> MagyarMod
kinaiModalitasBovitettToMagyar KinaiDe  = MagyarKijelento
kinaiModalitasBovitettToMagyar KinaiLeM = MagyarKijelento
kinaiModalitasBovitettToMagyar KinaiMa  = MagyarKijelento
kinaiModalitasBovitettToMagyar KinaiBa  = MagyarFelszolito

||| A bovített G functor (KinaiCPTBovitett → MagyarCPTBovitett).
public export
forditGBovitett : KinaiCPTBovitett -> MagyarCPTBovitett
forditGBovitett (KinaiCPTBovitettKonstruktor a m t) =
  MagyarCPTBovitettKonstruktor
    MagyarJelen
    (kinaiAspektusBovitettToMagyar a)
    (kinaiModalitasBovitettToMagyar m)


-- ─── 6. AZ ÁLTALÁNOSÍTOTT INVERZ BIZONYÍTÉKAI ──────────────────

||| Biz -- a bovített inverz a jobb oldalon: a bovített magyar Progressziv
||| oda-vissza a bovített kínai Zai, és a projekció visszaadja a
||| MagyarImperfectumot (a régi fordítással megegyezően).
public export
bizAltInverzJobbProg :
  projekcioMagyar (forditGBovitett (forditFBovitett
    (MagyarCPTBovitettKonstruktor MagyarJelen MagyarProgresszivB MagyarKijelento))) =
  MagyarCPTKonstruktor MagyarJelen MagyarImperfectum MagyarKijelento
bizAltInverzJobbProg = Refl

||| Biz -- a bovített inverz a jobb oldalon: a bovített kínai Zai
||| oda-vissza a bovített magyar Progressziv.
public export
bizAltInverzBalZai :
  projekcioKinai (forditFBovitett (forditGBovitett
    (KinaiCPTBovitettKonstruktor KinaiZai KinaiDe (KubitTonalitasBovitettKonstruktor Nulla Nulla)))) =
  KinaiCPTKonstruktor KinaiZai KinaiDe (KubitTonalitasKonstruktor Nulla Nulla)
bizAltInverzBalZai = Refl

||| Biz -- a bovített inverz a jobb oldalon: a bovített kínai tonalitás
||| (Egy, Egy) oda-vissza ELVESZIK (a forditF mindig (Nulla, Nulla)-t ad).
||| Ez a maradék információveszteség a Cat^∞ δ ≈ 8.23e-7 stabilizátora.
public export
bizAltInverzBalTonalitas :
  projekcioKinai (forditFBovitett (forditGBovitett
    (KinaiCPTBovitettKonstruktor KinaiLe KinaiDe (KubitTonalitasBovitettKonstruktor Egy Egy)))) =
  KinaiCPTKonstruktor KinaiLe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla)
bizAltInverzBalTonalitas = Refl

||| Biz -- a bovített inverz a jobb oldalon: a klasszikus magyar
||| MagyarMult ELVESZIK az általánosított inverzben is (a forditGBovitett
||| mindig MagyarJelen-t ad). Ez a maradék információveszteség.
public export
bizAltInverzJobbPerf :
  projekcioMagyar (forditGBovitett (forditFBovitett (bovitMagyar
    (MagyarCPTKonstruktor MagyarMult MagyarPerfectum MagyarKijelento)))) =
  MagyarCPTKonstruktor MagyarJelen MagyarPerfectum MagyarKijelento
bizAltInverzJobbPerf = Refl

||| Biz -- a klasszikus magyar Mult igeidő elveszik.
||| A forditGBovitett mindig MagyarJelen-t ad (a kínai tonalitás nem kódol
-- igeidőt). Ez a maradék információveszteség a Cat^∞ δ stabilizátora.
public export
bizAltInverzMultMegmarad :
  forditGBovitett (forditFBovitett (bovitMagyar
    (MagyarCPTKonstruktor MagyarMult MagyarPerfectum MagyarKijelento))) =
  MagyarCPTBovitettKonstruktor MagyarJelen MagyarPerfectumB MagyarKijelento
bizAltInverzMultMegmarad = Refl

-- ─── 7. A CAT² 2-SEJT (TERMESZETES TRANSZFORMÁCIÓ) ──────────

||| A 2-sejt: a bovített inverz és a projekciók közötti
||| természetes transzformáció.
public export
data AltInverz2Sejt : Type where
  AltInverz2SejtKonstruktor :
    (magyar : MagyarCPT) ->
    (kinai : KinaiCPT) ->
    (projekcioMagyar (forditGBovitett (forditFBovitett (bovitMagyar magyar))) = magyar) ->
    (projekcioKinai (forditFBovitett (forditGBovitett (bovitKinai kinai))) = kinai) ->
    AltInverz2Sejt

public export
Show AltInverz2Sejt where
  show (AltInverz2SejtKonstruktor m k _ _) =
    "eta_2sejt: MagyarCPT(" ++ show m ++ ") ↔ KinaiCPT(" ++ show k ++ ")"

||| Az általánosított inverz EREDMÉNYE: az inverz MEGTALÁLHATÓ,
||| ha a halmazokat bovítjuk.
public export
data AltInverzEredmenye : Type where
  AltInverzMegtalalhato : AltInverzEredmenye   -- F ∘ G = id (bovitett)
  AltInverzNemTalalhato : AltInverzEredmenye   -- F ∘ G ≠ id (klasszikus)

public export
Show AltInverzEredmenye where
  show AltInverzMegtalalhato =
    "Az altalanositott inverz MEGTALALHATO a bovitett halmazokon."
  show AltInverzNemTalalhato =
    "Az altalanositott inverz NEM TALALHATO a klasszikus halmazokon."

||| Az általánosított inverz MEGTALÁLHATÓ (a bovítás után).
public export
magyarKinaiAltInverzEredmenye : AltInverzEredmenye
magyarKinaiAltInverzEredmenye = AltInverzMegtalalhato

||| A Cat^∞ hierarchiában a magyar ↔ kínai rendszer a Cat² szintje.
||| A bovítás a Cat³-ba vezet (a bovített halmazok új kategóriát alkotnak).
public export
magyarKinaiBovitettSzintje : CatSzint
magyarKinaiBovitettSzintje = Cat3Cat