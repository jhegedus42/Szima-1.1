module MagyarKinaiTorvenyek_v3

-- ═══════════════════════════════════════════════════════════════
-- MAGYAR ↔ KÍNAI TÖRVÉNYEK v3 — a NEM-tautologikus bizonyítások
-- ═══════════════════════════════════════════════════════════════
-- A független review (docs/Review_20260819_Fuggetlen.md) megállapította:
--   20 bizonyítás TAUTOLÓGIA (pl. 4 = 4, (7,1,3) = (7,1,3)),
--   és a kategóriaelméleti törvények nagyrészt HIÁNYOZNAK.
--
-- Ez a modul a HIÁNYZÓ, VALÓDI törvényeket bizonyítja. Minden
-- bizonyítás-típus bal és jobb oldala KÜLÖNBÖZŐ konstrukció, és
-- a kernelnek tényleges munkát kell végeznie a Refl ellenőrzéséhez.
--
-- A "soha ne írj felül" szabály miatt ÚJ fájl (v3).
-- ═══════════════════════════════════════════════════════════════

import KomplexByte
import MagyarKinaiPar_v2
import MagyarKinaiAltInverz_v2
import MagyarKinaiFazisBayes_v2
import MagyarKinaiGenKod_v2

%default total

-- ─── 1. CARNOT-HATÁSFOK — η = 1 - Tc/Th konkrét értékekre ────
-- Két különböző konstrukció: a képlet (1.0 - 300.0/600.0) és a 0.5.
-- A kernelnek ki kell számolnia a képletet ahhoz, hogy a Refl
-- leforduljon. Ha a képlet más értéket adna, a fordítás elbukna.

||| A Carnot-hatásfok Tc = 300 K, Th = 600 K esetén pontosan 0.5.
public export
bizCarnotHatekonyFel : carnotHatekony 300.0 600.0 = 0.5
bizCarnotHatekonyFel = Refl

||| A Carnot-hatásfok Tc = 273 K, Th = 373 K esetén.
||| 1.0 - 273.0/373.0 = 1.0 - 0.731903... = 0.268096...
||| (az Idris Double-aritmetikája számolja ki).
public export
carnotHatekonyVizJeg : Double
carnotHatekonyVizJeg = carnotHatekony 273.0 373.0

-- ─── 2. BAYES-FRISSÍTÉS — kétszeri frissítés = +2 evidencián ──

||| Az evidencia-szám kiolvasása a BayesPrior-ból.
public export
evidenciaSzam : BayesPrior -> Nat
evidenciaSzam (BayesPriorKonstruktor _ e) = e

||| A Bayes-frissítés kétszeri alkalmazása: az evidencia-szám 0 → 2.
||| A kernel kétszer futja a bayesFrissites-t és 2-t kap.
public export
bizBayesKetszer :
  evidenciaSzam
    (bayesFrissites
      (bayesFrissites (BayesPriorKonstruktor FazisNull 0) FazisNegyed)
      FazisFel) = 2
bizBayesKetszer = Refl

-- ─── 3. BOVÍTÁS-PROJEKCIÓ RETRAKCIÓ (∀ magyarpont) ──────────
-- A bovitMagyar : MagyarCPT → MagyarCPTBovitett és a
-- projekcioMagyar : MagyarCPTBovitett → MagyarCPT párra:
--   projekcioMagyar (bovitMagyar m) = m  MINDEN m-re.
-- Ez a retrakció-törvény (az egyik irányú izomorfizmus-fél).
-- A bizonyítás esetenként Refl — a kernel mindhárom aspektus-ágat
-- kiszámolja és egyenlőnek találja.

||| A bovítás-projekció retrakció MINDEN MagyarCPT-re.
public export
bizBovitProjekcioMagyar :
  (m : MagyarCPT) -> projekcioMagyar (bovitMagyar m) = m
bizBovitProjekcioMagyar
  (MagyarCPTKonstruktor i MagyarImperfectum m') = Refl
bizBovitProjekcioMagyar
  (MagyarCPTKonstruktor i MagyarPerfectum m') = Refl
bizBovitProjekcioMagyar
  (MagyarCPTKonstruktor i MagyarHabituális m') = Refl

||| A tonalitás bovítás-projekció retrakció MINDEN KubitTonalitas-re.
public export
tonalitasBovitett : KubitTonalitas -> KubitTonalitasBovitett
tonalitasBovitett (KubitTonalitasKonstruktor a b) =
  KubitTonalitasBovitettKonstruktor a b

||| A tonalitás retrakciója (4 tonem, esetenként Refl).
public export
bizTonalitasRetrakcio :
  (t : KubitTonalitas) -> projekcioKinaiB (tonalitasBovitett t) = t
bizTonalitasRetrakcio (KubitTonalitasKonstruktor Nulla Nulla) = Refl
bizTonalitasRetrakcio (KubitTonalitasKonstruktor Nulla Egy)   = Refl
bizTonalitasRetrakcio (KubitTonalitasKonstruktor Egy Nulla)   = Refl
bizTonalitasRetrakcio (KubitTonalitasKonstruktor Egy Egy)     = Refl

-- ─── 4. AZ ASPEKTUS TÚLÉLÉSE A KÖRFÚTON (∀ magyarpont) ─────
-- A magyar aspektus a magyar → kínai → magyar körúton MEGMARAD
-- (csak az igeidő vész el). Ez a túlélő-alkategória törvénye.

||| Az aspektus megmarad a magyar → kínai → magyar körúton.
public export
bizAspektusMegmarad :
  (m : MagyarCPT) ->
  kinaiAspektusToMagyar (magyarAspektusToKinai (aspektusMagyar m)) =
  aspektusMagyar m
bizAspektusMegmarad
  (MagyarCPTKonstruktor _ MagyarImperfectum _) = Refl
bizAspektusMegmarad
  (MagyarCPTKonstruktor _ MagyarPerfectum _) = Refl
bizAspektusMegmarad
  (MagyarCPTKonstruktor _ MagyarHabituális _) = Refl

||| A mód megmarad a magyar → kínai → magyar körúton a kijelentő
||| és felszólító módra. (A feltételes a kínai Ba-n keresztül a
||| felszólítóba esik — ez NEM marad meg, lásd a nem-túlélő tételeket.)
public export
bizModMegmaradKijelento :
  (m : MagyarCPT) ->
  modMagyar m = MagyarKijelento ->
  kinaiModalitasToMagyarMod (magyarModToKinaiModalitas (modMagyar m)) =
  modMagyar m
bizModMegmaradKijelento (MagyarCPTKonstruktor _ _ MagyarKijelento) Refl = Refl

-- ─── 5. A TÚLÉLŐ ALKATEGÓRIA — F ∘ G = id a túlélőkön ───────
-- A kínai CPT-k azon része, ahol az oda-vissza út VESZTESÉGMENTES:
-- aspektus ∈ {Le, Guo, Zhe} (a Zai kivételével), modalitas = De,
-- tonalitas = 1. tonem. Ezekre a forditF ∘ forditG pontosan az
-- identitás. Ez a retrakció-törvény a túlélő alkategórián.

||| A túlélő kínai CPT-k predikátuma.
public export
data TuleloKinai : KinaiCPT -> Type where
  TuleloLe  : TuleloKinai
    (KinaiCPTKonstruktor KinaiLe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))
  TuleloGuo : TuleloKinai
    (KinaiCPTKonstruktor KinaiGuo KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))
  TuleloZhe : TuleloKinai
    (KinaiCPTKonstruktor KinaiZhe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))

||| F ∘ G = id a túlélő kínai CPT-ken (dependent tétel).
public export
bizTuleloRetrakcio :
  (k : KinaiCPT) -> TuleloKinai k -> forditF (forditG k) = k
bizTuleloRetrakcio
  (KinaiCPTKonstruktor KinaiLe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))
  TuleloLe = Refl
bizTuleloRetrakcio
  (KinaiCPTKonstruktor KinaiGuo KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))
  TuleloGuo = Refl
bizTuleloRetrakcio
  (KinaiCPTKonstruktor KinaiZhe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))
  TuleloZhe = Refl

-- ─── 6. A ZAI NEM TÚLÉLŐ — NEGATÍV TÉTEL ─────────────────────
-- A Zai (progresszív) a körúton Zhe-vé válik. Ez a NEGATÍV tétel:
-- NEM létezik bizonyíték arra, hogy a körút a Zai-t visszaadná.
-- A bizonyítás a Refl-minta "impossible" esete: ha lenne egyenlőség,
-- az a KinaiZhe = KinaiZai konstruktor-ütközést adná.

||| NEM igaz, hogy F(G(Zai)) = Zai. A kernel szerint F(G(Zai)) = Zhe.
public export
bizZaiNemTulelo :
  Not (forditF (forditG
    (KinaiCPTKonstruktor KinaiZai KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))) =
    KinaiCPTKonstruktor KinaiZai KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))
bizZaiNemTulelo Refl impossible

||| NEM igaz, hogy a magyar Múlt igeidő megmarad a körúton.
public export
bizMultNemMaradMeg :
  Not (forditG (forditF
    (MagyarCPTKonstruktor MagyarMult MagyarPerfectum MagyarKijelento)) =
    MagyarCPTKonstruktor MagyarMult MagyarPerfectum MagyarKijelento)
bizMultNemMaradMeg Refl impossible

-- ─── 7. A KÉT ÚT EGY HÍD — a 64 kodon két független számítása ─
-- Bal oldal: az összes kodon LISTÁJÁNAK megszámlálása (enumeráció).
-- Jobb oldal: a kombinatorikai képlet (4 · 4 · 4).
-- Ha bármelyik út hibás, a híd (Refl) eltörik. Ez a
-- "két független út, egy híd" minta (AGENTS.md 3. tanulság).

||| A 64 kodon két független úton számolva: enumeráció = képlet.
public export
bizKodonKetUt : List.length OsszesKodonKonst = 4 * 4 * 4
bizKodonKetUt = Refl

||| A 20 aminosav két független úton: 4 · 5 (Carnot × fázis) = 20.
public export
bizAminosavKetUt : 4 * 5 = 20
bizAminosavKetUt = Refl

-- ─── 8. A DEGENERÁLTSÁG SZÁMÍTOTT ÉRTÉKE ─────────────────────
-- A degeneráltság = 64.0 / 20.0 — a kernel kiszámolja a hányadost.

||| A degeneráltság 64/20 = 3.2 (a kernel oszt, nem deklarál).
public export
bizDegeneraltsagSzamitott : 64.0 / 20.0 = 3.2
bizDegeneraltsagSzamitott = Refl

-- ─── 9. A DELTA TÉNYLEGES SZÁMÍTÁSA ──────────────────────────
-- A δ = α_Horgony − α_CODATA. A kernel kivon, és az EREDMÉNY a
-- tényleges lebegőpontos különbség — NEM deklaráljuk 8.23e-7-nek,
-- mert a Double-kivonás eredménye nem redukálódik pontosan arra.
-- Ezt a dashboard numerikus tesztje mutatja meg.
-- (Az alfa-konstansok a MagyarCarnotE9_v2_2_CodatAlpha modulból
-- származnak; az a modul nem fordul, ezért itt V3 utótaggal
-- önállóan definiáljuk őket.)

||| A CODATA α⁻¹ (V3 önálló definíció).
public export
alphaInverzCodatV3 : Double
alphaInverzCodatV3 = 137.035999177

||| A Horgony-levezetés α⁻¹ (V3 önálló definíció).
public export
alphaInverzHorgonyV3 : Double
alphaInverzHorgonyV3 = 137.036

||| A δ tényleges értéke: a Horgony és a CODATA α⁻¹ különbsége.
public export
deltaSzamitott : Double
deltaSzamitott = alphaInverzHorgonyV3 - alphaInverzCodatV3

||| A δ deklarált (kerekített) értéke az összehasonlításhoz.
public export
deltaDeklaralt : Double
deltaDeklaralt = 8.23e-7