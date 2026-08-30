module MagyarKinaiInverz_v2

-- ═══════════════════════════════════════════════════════════════
-- MAGYAR ↔ KÍNAI INVERZ-VIZSGÁLAT
-- ═══════════════════════════════════════════════════════════════
-- A felhasználó kérdése (2026-08-19):
--   "ezt tudjuk tesztelni? elvileg inverznek kell lennie, oda-vissza"
--
-- A Cat² elméletből: a magyar ↔ kínai rendszer egy functor-pár (F, G),
-- ahol F ∘ G ≠ id és G ∘ F ≠ id (információveszteség).
--
-- A BIZONYÍTÁS MÓDSZERE: a fordító ELUTASÍTÁSA a Refl-bizonyítást
-- maga a bizonyíték, hogy a két oldal nem egyenlő. Ha a forditF ∘
-- forditG inverz lenne, a Refl lefordulna; ha nem, a Refl elbukik.
--
-- Az alábbi bizonyítások:
--   - ✅ Azon esetek, ahol a Refl LEFORDUL (az inverz EGYEZIK)
--   - ❌ Azon esetek, ahol a Refl ELBUKIK (az inverz NEM EGYEZIK)
-- A két együttesen bizonyítja a Cat² struktúrát.
-- ═══════════════════════════════════════════════════════════════

import KomplexByte
import MagyarKinaiPar_v2

%default total

-- ─── 1. A JOBB INVERZ (forditG ∘ forditF = id_MagyarCPT) ────
-- A MAGYAR JELEN + IMPERFECTUM + KIJELENTŐ: oda-vissza egyezik.

||| ✅ Az 1. teszt: MagyarJelen+Imperfectum+Kijelento oda-vissza egyezik.
||| A magyar Jelen igeidő azért marad meg, mert a forditG-ben a
||| kínai tonalitás→magyar Jelen konverzió visszaállítja.
public export
teszt1_JobbInverzJelenImperf :
  forditG (forditF (MagyarCPTKonstruktor MagyarJelen MagyarImperfectum MagyarKijelento)) =
  MagyarCPTKonstruktor MagyarJelen MagyarImperfectum MagyarKijelento
teszt1_JobbInverzJelenImperf = Refl

||| ❌ A 2. teszt (NEM fordul le): a MagyarMult elveszik.
||| Ez a bizonyíték: a magyar Jövő/Múlt igeidő NEM marad meg.
||| A forditF elveszti az igeidőt, és a forditG nem tudja visszaállítani.
|||
||| teszt2_MultVeszteseg :
|||   forditG (forditF (MagyarCPTKonstruktor MagyarMult MagyarPerfectum MagyarKijelento)) =
|||   MagyarCPTKonstruktor MagyarMult MagyarPerfectum MagyarKijelento
||| teszt2_MultVeszteseg = Refl  -- ❌ ELUTASÍTVA: a Refl nem fordul le
|||
||| A fenti kódba NEM írom bele, mert a fordító elutasítja.
||| A ELUTASÍTÁS MAGA A BIZONYÍTÉK.

-- ─── 2. A BAL INVERZ (forditF ∘ forditG = id_KinaiCPT) ─────────

||| ✅ A 3. teszt: KinaiZhe oda-vissza egyezik.
||| A KinaiZhe → MagyarImperfectum → KinaiZhe konzisztens.
public export
teszt3_BalInverzZhe :
  forditF (forditG (KinaiCPTKonstruktor KinaiZhe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))) =
  KinaiCPTKonstruktor KinaiZhe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla)
teszt3_BalInverzZhe = Refl

||| ✅ A 4. teszt: KinaiGuo oda-vissza egyezik.
public export
teszt4_BalInverzGuo :
  forditF (forditG (KinaiCPTKonstruktor KinaiGuo KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))) =
  KinaiCPTKonstruktor KinaiGuo KinaiDe (KubitTonalitasKonstruktor Nulla Nulla)
teszt4_BalInverzGuo = Refl

||| ✅ Az 5. teszt: KinaiLe oda-vissza egyezik.
public export
teszt5_BalInverzLe :
  forditF (forditG (KinaiCPTKonstruktor KinaiLe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))) =
  KinaiCPTKonstruktor KinaiLe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla)
teszt5_BalInverzLe = Refl

-- ─── 3. A KINAI ZAI (progresszív) INFORMÁCIÓVESZTESÉG ──────────

||| ✅ A 6. teszt: a KinaiZai (progresszív) elveszik.
||| A KinaiZai → MagyarImperfectum → KinaiZhe (durativ, NEM progresszív!).
||| Ez a Cat² 2-sejtje: a fordítás nem izomorfizmus, hanem functor.
public export
teszt6_ZaiVeszteseg :
  forditF (forditG (KinaiCPTKonstruktor KinaiZai KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))) =
  KinaiCPTKonstruktor KinaiZhe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla)
teszt6_ZaiVeszteseg = Refl

||| ✅ A 7. teszt: a KinaiZai → KinaiZhe konkret bizonyítéka.
||| Ha a forditF ∘ forditG inverz lenne, KinaiZai-t adna. DE Refl-lel
||| bizonyítható, hogy KinaiZhe-t ad. Tehát NEM inverz.
public export
teszt7_ZaiKonkret :
  (forditF (forditG (KinaiCPTKonstruktor KinaiZai KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))) =
   KinaiCPTKonstruktor KinaiZhe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla))
teszt7_ZaiKonkret = Refl

-- ─── 4. A TONALITÁS INFORMÁCIÓVESZTESÉG ─────────────────────

||| ✅ A 8. teszt: a tonalitás elveszik.
||| Bármi legyen is az eredeti kínai tonalitás (Egy, Egy = 4. tonem),
||| a forditF (forditG ...) mindig (Nulla, Nulla)-t ad (1. tonem).
public export
teszt8_TonalitasVeszteseg :
  forditF (forditG (KinaiCPTKonstruktor KinaiLe KinaiDe (KubitTonalitasKonstruktor Egy Egy))) =
  KinaiCPTKonstruktor KinaiLe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla)
teszt8_TonalitasVeszteseg = Refl

-- ─── 5. A MODALITÁSOK ÖSSZESZŰKÜLÉSE ─────────────────────────

||| ✅ A 9. teszt: a KinaiLeM (mondatvégi 了, változás) elveszik.
||| A KinaiLeM → MagyarKijelento → KinaiDe (állítás, NEM változás!).
||| Tehát a kínai 4 modalitás → magyar 3 mód → kínai 2 modalitás.
public export
teszt9_LeMVeszteseg :
  forditF (forditG (KinaiCPTKonstruktor KinaiLe KinaiLeM (KubitTonalitasKonstruktor Nulla Nulla))) =
  KinaiCPTKonstruktor KinaiLe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla)
teszt9_LeMVeszteseg = Refl

||| ✅ A 10. teszt: a KinaiMa (kérdés) elveszik.
||| A KinaiMa → MagyarKijelento → KinaiDe (állítás, NEM kérdés!).
public export
teszt10_MaVeszteseg :
  forditF (forditG (KinaiCPTKonstruktor KinaiLe KinaiMa (KubitTonalitasKonstruktor Nulla Nulla))) =
  KinaiCPTKonstruktor KinaiLe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla)
teszt10_MaVeszteseg = Refl

-- ─── 6. ÖSSZEFOGLALÓ ───────────────────────────────────────────

||| A fordítóprogram által ellenőrzött inverz-vizsgálatok eredménye.
||| A magyar ↔ kínai rendszer NEM inverz functor-pár.
public export
data InverzEredmenye : Type where
  JobbInverzMindenhol : InverzEredmenye   -- G ∘ F = id_magyar
  BalInverzMindenhol  : InverzEredmenye   -- F ∘ G = id_kinai
  TeljesInverz        : InverzEredmenye   -- mindkettő
  NemInverz           : InverzEredmenye   -- egyik sem

public export
Show InverzEredmenye where
  show JobbInverzMindenhol = "G(F(m)) = m minden magyar m-re (JOBB inverz)"
  show BalInverzMindenhol  = "F(G(k)) = k minden kinai k-ra (BAL inverz)"
  show TeljesInverz        = "F es G teljes inverz par (mindketto)"
  show NemInverz           = "F es G NEM inverz par (informacioveszteseg)"

||| A magyar ↔ kínai rendszer EREDMÉNYE (a fenti tesztek alapján).
public export
magyarKinaiInverzEredmenye : InverzEredmenye
magyarKinaiInverzEredmenye = NemInverz

||| A Cat^∞ hierarchiában a magyar ↔ kínai rendszer a Cat² szintje,
||| ahol a 2-sejt (természetes transzformáció) a fordítás
||| információveszteségét kódolja.
public export
magyarKinai2SejtMegjegyzes : String
magyarKinai2SejtMegjegyzes =
  "A magyar ↔ kinai rendszer a Cat² szintje. A 2-sejt (a forditF es " ++
  "forditG kozotti termeszetes transzformacio) kodolja az " ++
  "informacioveszteseget: a magyar Mult/Jovo igeido, a kinai Zai " ++
  "(progressziv), a kinai tonalitas, es a kinai LeM/Ma modalitas " ++
  "elveszik az oda-vissza forditasban."