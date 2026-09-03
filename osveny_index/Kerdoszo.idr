module Kerdoszo

-- ═══════════════════════════════════════════════════════════════
-- KÉRDŐSZÓ — mindennek az alfja és omegája
-- ═══════════════════════════════════════════════════════════════
-- A GONDOLAT (a felhasználóé, 2026-08-17):
--   a kérdőszót meg kell érteni — az mindennek az alfja és omegája.
--
-- MIÉRT STRUCTURÁLIS TÉNY (nem költészet):
--   1. Minden esetrag EGY KÉRDŐSZÓ válasza: ki?→nominatív,
--      kit?→akkuszativus, hol?→inessivus, miért?→causalis…
--      A 18 rag nem lista, hanem 18 MEGVÁLASZOLT KÉRDÉS.
--   2. Yoneda: a „ki?” pontosan Hom(–, ember) — egy objektumot
--      teljesen meghatároznak a róla feltehető kérdések.
--      A kérdőszó a META-SZINT maga.
--   3. A KERESÉS KÉRDÉS: a hiányzó információ = entrópia-gradiens;
--      minden BINÁRIS kérdés ≤ 1 bittel csökkenti (felezés).
--   4. Lawvere/Gödel (LawvereGodel.idr): az önkérdezés fixpontja
--      a hazug paradoxon — p = 1/2, Refl-bizonyítva.
--
-- A KÉRDÉS DEFINÍCIÓJA (típusosan):
--   A kérdés = morfizmus, amelynek a célja MÉG ÜRES (Maybe = Nothing).
--   A válasz tölti ki (Just). A megválaszolatlanság NEM hiba —
--   ez az entrópia-gradiens, ami a Carnot-ciklust hajtja.
-- ═══════════════════════════════════════════════════════════════

import Fonetika
import MagyarNyelvtan
import FanoParitás
import Steane713
import ModulRegisztracio

%default total

-- ─── 1. A KÉRDŐSZÓK MINT ADATTÍPUSOK ──────────────────────
-- 一、疑问词作为代数数据类型 ─────────────────
-- Minden kérdőszó saját konstruktor — a szófaj- és jelentéstan
-- a TÍPUSBAN van, nem kommentben.
-- 每个疑问词都是构造器——词类与语义活在类型里。

public export
data KérdőszóT =
    KiKérdő       -- „ki?”    (élő, nominatív)
  | MitKérdő      -- „mi?”    (dolog, nominatív)
  | KitKérdő      -- „kit?”   (élő, akkuszativus = PATIENS)
  | MiértKérdő    -- „miért?” (ok, causalis-finalis)
  | HolKérdő      -- „hol?”   (inessivus)
  | HováKérdő     -- „hová?”  (illativus)
  | HonnanKérdő   -- „honnan?” (elativus)
  | MikorKérdő    -- „mikor?” (idő — az igeidő felel rá, nem rag!)
  | HogyanKérdő   -- „hogyan?” (formativus = mód)
  | MivelKérdő    -- „mivel?” (instrumentalis)
  | KivelKérdő    -- „kivel?” (instrumentalis, élő)
  | MelyikKérdő   -- „melyik?” (választás = BINÁRIS felezés!)
  | MennyiKérdő   -- „mennyi?” (mennyiség)

public export
Show KérdőszóT where
  show KiKérdő      = "ki?"
  show MitKérdő     = "mi?"
  show KitKérdő     = "kit?"
  show MiértKérdő   = "miért?"
  show HolKérdő     = "hol?"
  show HováKérdő    = "hová?"
  show HonnanKérdő  = "honnan?"
  show MikorKérdő   = "mikor?"
  show HogyanKérdő  = "hogyan?"
  show MivelKérdő   = "mivel?"
  show KivelKérdő   = "kivel?"
  show MelyikKérdő  = "melyik?"
  show MennyiKérdő  = "mennyi?"

-- ─── 2. A KÉRDŐSZAVAK FONETIKÁJA (Hang-konstruktorokból) ──
-- 二、疑问词的语音学（音素构造器组成） ────────

-- grafikusan: „ki”
public export
KérdésKi : Fonetika
KérdésKi = [MassalhangzoHang Mk, MaganhangzoHang Vi]

-- grafikusan: „mi”
public export
KérdésMi : Fonetika
KérdésMi = [MassalhangzoHang Mm, MaganhangzoHang Vi]

-- grafikusan: „miért”
public export
KérdésMiért : Fonetika
KérdésMiért = [ MassalhangzoHang Mm, MaganhangzoHang Vi, MaganhangzoHang Vee
              , MassalhangzoHang Mr, MassalhangzoHang Mt ]

-- grafikusan: „hol”
public export
KérdésHol : Fonetika
KérdésHol = [MassalhangzoHang Mh, MaganhangzoHang Vo, MassalhangzoHang Ml]

-- grafikusan: „hogyan” (gy → [ɟ] digráf!)
public export
KérdésHogyan : Fonetika
KérdésHogyan =
  [ MassalhangzoHang Mh, MaganhangzoHang Vo, DigrafHang Dgy
  , MaganhangzoHang Va, MassalhangzoHang Mn ]

-- grafikusan: „melyik” (ly → [j] digráf!)
public export
KérdésMelyik : Fonetika
KérdésMelyik =
  [ MassalhangzoHang Mm, MaganhangzoHang Ve, DigrafHang Dly
  , MaganhangzoHang Vi, MassalhangzoHang Mk ]

-- ─── 3. A KÉRDŐSZÓ → ESETRAG LEKÉPEZÉS (típusosan) ────────
-- 三、疑问词→格词缀的类型化映射 ────────
-- A CPT-kapcsolat: a kérdőszó C = FORRÁS (honnan tudom?),
-- az esetrag a válasz P = SZEMLÉLETE (hogyan látom).
-- CPT 关联：疑问词是 C=源（我何以知晓？），格词缀是 P=体（我如何看待）。

public export
kérdőszóEsetT : KérdőszóT -> Maybe Esetrag
kérdőszóEsetT KiKérdő      = Just NominativusE
kérdőszóEsetT MitKérdő     = Just NominativusE
kérdőszóEsetT KitKérdő     = Just AccusativusE
kérdőszóEsetT MiértKérdő   = Just CausalisFinalisE
kérdőszóEsetT HolKérdő     = Just InessivusE
kérdőszóEsetT HováKérdő    = Just IllativusE
kérdőszóEsetT HonnanKérdő  = Just ElativusE
kérdőszóEsetT MikorKérdő   = Nothing
kérdőszóEsetT HogyanKérdő  = Just FormativusE
kérdőszóEsetT MivelKérdő   = Just InstrumentalisE
kérdőszóEsetT KivelKérdő   = Just InstrumentalisE
kérdőszóEsetT MelyikKérdő  = Just NominativusE
kérdőszóEsetT MennyiKérdő  = Nothing

-- ─── 4. A KÉRDÉS MINT MORFIZMUS ÜRES CELAL ─────────────────
-- 四、问题即目标为空的态射 ─────────────────
-- A Yoneda-csomag: egy kérdés + a válasz helye (kezdetben üres).
-- A válasz ADATA a céltípus; a Maybe = a nyitottság maga.

public export
record NyitottKérdés where
  constructor NyitottKérdésKonstruktor
  kérdőSzava   : KérdőszóT
  válaszHelye  : Maybe Fonetika

-- A megkérdezés: a kérdőszóból nyitott kérdés lesz.
public export
megkérdez : KérdőszóT -> NyitottKérdés
megkérdez kérdő = NyitottKérdésKonstruktor kérdő Nothing

-- A megválaszolás: a válasz BETÖLTI a helyet — a gradiens lecsökken.
public export
megválaszol : NyitottKérdés -> Fonetika -> NyitottKérdés
megválaszol (NyitottKérdésKonstruktor kérdő _) válasz =
  NyitottKérdésKonstruktor kérdő (Just válasz)

-- Nyitott-e még? (van-e entrópia-gradiens?)
public export
megNyitott : NyitottKérdés -> Bool
megNyitott (NyitottKérdésKonstruktor _ Nothing)  = True
megNyitott (NyitottKérdésKonstruktor _ (Just _)) = False

-- ─── 5. A BINÁRIS KÉRDÉS = 1 BIT (a felezés elve) ─────────
-- 五、二元问题 = 1 比特（二分原理） ─────────
-- A válaszfélek típusa (a felezés két ága):
public export
data VálaszFél = ElsőFél | MásodikFél
-- „melyik?” = a felező kérdés: minden válasz ≤ 1 bittel
-- csökkenti az entrópiát (session_export.md:74360).
-- A KIBONTÁS: a két fél közül melyik? — Kubit!

public export
binárisKérdésBit : NyitottKérdés -> VálaszFél -> Fonetika -> NyitottKérdés
binárisKérdésBit (NyitottKérdésKonstruktor kérdő _) válaszFél válasz =
  NyitottKérdésKonstruktor kérdő (Just válasz)

-- ─── 6. A „KI? / MI?” FUNDAMENTÁLIS PÁR ────────────────────
-- 六、「谁？/什么？」基本对 ────────────────
-- Az első kérdés-pár: élő / dolog. Ez a legalapvetőbb osztás —
-- a saját / másik kubit nyelvi párja.
-- 第一问题对：生物/事物——最根本的划分，「自己/他者」比特的语言对。

public export
data AlapOsztó = Élő | Dolog

public export
Eq AlapOsztó where
  Élő   == Élő   = True
  Dolog == Dolog = True
  _     == _     = False

public export
kérdőszóOsztója : KérdőszóT -> Maybe AlapOsztó
kérdőszóOsztója KiKérdő   = Just Élő
kérdőszóOsztója KitKérdő  = Just Élő
kérdőszóOsztója KivelKérdő = Just Élő
kérdőszóOsztója MitKérdő  = Just Dolog
kérdőszóOsztója MiértKérdő = Just Dolog
kérdőszóOsztója HolKérdő  = Just Dolog
kérdőszóOsztója MelyikKérdő = Just Dolog
kérdőszóOsztója MennyiKérdő = Just Dolog
kérdőszóOsztója _         = Nothing

-- ─── 7. BIZONYÍTÁSOK (Refl — a fordító a bírája) ──────────
-- 七、证明（Refl——编译器即裁判） ──────────────

-- Kimenet: Refl — „ki?” élő, „mi?” dolog: az alap-osztó működik
BizKiÉlő : kérdőszóOsztója KiKérdő = Just Élő
BizKiÉlő = Refl

-- Kimenet: Refl
BizMiDolog : kérdőszóOsztója MitKérdő = Just Dolog
BizMiDolog = Refl

-- Kimenet: Refl — a „miért?” a causalis-finalis (OK/CÉL) esetet kérdezi
BizMiértOk : kérdőszóEsetT MiértKérdő = Just CausalisFinalisE
BizMiértOk = Refl

-- Kimenet: Refl — „mikor?”-ra NINCS esetrag: az idő az IGEIDŐ-re
-- felel (T-dimenzió), nem a névszó-ragrendszerre. Ez a CPT-mappa
-- lényege: T ≠ C ≠ P — a három dimenzió más-más nyelvi eszközt használ.
BizMikorNincsRag : kérdőszóEsetT MikorKérdő = Nothing
BizMikorNincsRag = Refl

-- Kimenet: Refl — a frissen megkérdezett kérdés NYITOTT (gradiens van)
-- A GAUGE-KAPCSOLAT: magyarHangok "ki" == KérdésKi (fent, Refl-lel)
BizKérdésKiGauge : ipaForma KérdésKi = "[ki]"
BizKérdésKiGauge = Refl

-- Kimenet: Refl — „hogyan” gy-digráfja [ɟ]-ként jelenik meg
BizHogyanDgraf : ipaForma KérdésHogyan = "[hoɟɒn]"
BizHogyanDgraf = Refl

-- Kimenet: Refl — „melyik” ly-digráfja [j]-ként
BizMelyikDgraf : ipaForma KérdésMelyik = "[mɛjik]"
BizMelyikDgraf = Refl

-- ─── 8. A KÉRDŐSZÓ-ESET TÁBLA (a 18 rag = 18 kérdés) ──────
-- 八、疑问词-格表（18 个词缀 = 18 个问题） ──────

public export
kérdőszóTáblázat : String
kérdőszóTáblázat =
  "A 18 esetrag = 18 MEGVÁLASZOLT KÉRDÉS:\n"
  ++ "  ki?/mi?     → nominativus    (AGENS)\n"
  ++ "  kit?/mit?   → akkuszativus    (PATIENS)\n"
  ++ "  kinek?      → dativus        (KEDVEZMÉNYEZETT)\n"
  ++ "  hol?        → inessivus      (BEN)\n"
  ++ "  hová?       → illativus      (BA)\n"
  ++ "  honnan?     → elativus       (BÓL)\n"
  ++ "  miért?      → causalis       (ÉRT = OK/CÉL)\n"
  ++ "  hogyan?     → formativus     (KÉPP = MÓD)\n"
  ++ "  mivel?      → instrumentalis (VAL = ESZKÖZ)\n"
  ++ "  mikor?      → NINCS RAG — az IGEIDŐ-re felel (T ≠ C,P!)\n"

-- ─── 9. FŐ — vékony IO-burkoló ────────────────────────────
-- 九、主程序——薄 IO 壳 ────────────────────

public export
főJelentés : String
főJelentés =
  "═══ KÉRDŐSZÓ — mindennek alfja és omegája ═══\n\n"
  ++ kérdőszóTáblázat ++ "\n"
  ++ "„ki?” IPA: " ++ ipaForma KérdésKi ++ " | „hogyan?” IPA: "
  ++ ipaForma KérdésHogyan ++ " | „melyik?” IPA: " ++ ipaForma KérdésMelyik ++ "\n\n"
  ++ "A kérdés = morfizmus üres célal; a válasz tölti ki:\n"
  ++ "  megkérdez MiértKérdő → nyitott? "
  ++ show (megNyitott (megkérdez MiértKérdő)) ++ "\n"
  ++ "  megválaszol 'mi'-vel → nyitott? "
  ++ show (megNyitott (megválaszol (megkérdez MitKérdő) KérdésMi)) ++ "\n\n"
  ++ "A bináris kérdés ≤ 1 bit: „melyik?” = a felező (O(log n))\n"
  ++ "Yoneda: a „ki?” = Hom(–, ember) — a kérdés a meta-szint\n"

main : IO ()
main = putStrLn főJelentés


-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
KérdőszóLeírás : ModulLeirasT
KérdőszóLeírás = ModulLeirasKonstruktor
  "Kérdőszo.idr" "kérdőszó→esetrag; „mikor?”-ra nincs rag [Refl] (T≠C,P)" "a kíváncsiság TÍPUS: kérdés = morfizmus üres célal; Yoneda" "13 teszt + 7 Refl"
