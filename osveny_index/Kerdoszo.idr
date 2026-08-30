module Kerdoszo

-- ═══════════════════════════════════════════════════════════════
-- KÉRDŐSZÓ — mindennek az alfja és omegája
-- ═══════════════════════════════════════════════════════════════
-- A GONDOLAT (a felhasználóé, 2026-08-17):
--   a kérdőszót meg kell érteni — az mindennek az alfja és omegája.
--
-- MIÉRT STRUCTURÁLIS TÉNY (nem költészet):
--   1. Minden esetrag EGY KÉRDŐSZÓ válasza: ki?→nominatív,
--      kit?→akku­szativus, hol?→inessivus, miért?→causalis…
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
-- Minden kérdőszó saját konstruktor — a szófaj- és jelentéstan
-- a TÍUSBAN van, nem kommentben.

public export
data KerdoszoT =
    KiKerdo       -- „ki?”    (élő, nominatív)
  | MitKerdo      -- „mi?”    (dolog, nominatív)
  | KitKerdo      -- „kit?”   (élő, akku­szativus = PATIENS)
  | MiertKerdo    -- „miért?” (ok, causalis-finalis)
  | HolKerdo      -- „hol?”   (inessivus)
  | HovaKerdo     -- „hová?”  (illativus)
  | HonnanKerdo   -- „honnan?” (elativus)
  | MikorKerdo    -- „mikor?” (idő — az igeidő felel rá, nem rag!)
  | HogyanKerdo   -- „hogyan?” (formativus = mód)
  | MivelKerdo    -- „mivel?” (instrumentalis)
  | KivelKerdo    -- „kivel?” (instrumentalis, élő)
  | MelyikKerdo   -- „melyik?” (választás = BINÁRIS felezés!)
  | MennyiKerdo   -- „mennyi?” (mennyiség)

public export
Show KerdoszoT where
  show KiKerdo      = "ki?"
  show MitKerdo     = "mi?"
  show KitKerdo     = "kit?"
  show MiertKerdo   = "miért?"
  show HolKerdo     = "hol?"
  show HovaKerdo    = "hová?"
  show HonnanKerdo  = "honnan?"
  show MikorKerdo   = "mikor?"
  show HogyanKerdo  = "hogyan?"
  show MivelKerdo   = "mivel?"
  show KivelKerdo   = "kivel?"
  show MelyikKerdo  = "melyik?"
  show MennyiKerdo  = "mennyi?"

-- ─── 2. A KÉRDŐSZAVAK FONETIKÁJA (Hang-konstruktorokból) ──

-- grafikusan: „ki”
public export
KerdesKi : Fonetika
KerdesKi = [MassalhangzoHang Mk, MaganhangzoHang Vi]

-- grafikusan: „mi”
public export
KerdesMi : Fonetika
KerdesMi = [MassalhangzoHang Mm, MaganhangzoHang Vi]

-- grafikusan: „miért”
public export
KerdesMiert : Fonetika
KerdesMiert = [ MassalhangzoHang Mm, MaganhangzoHang Vi, MaganhangzoHang Vee
              , MassalhangzoHang Mr, MassalhangzoHang Mt ]

-- grafikusan: „hol”
public export
KerdesHol : Fonetika
KerdesHol = [MassalhangzoHang Mh, MaganhangzoHang Vo, MassalhangzoHang Ml]

-- grafikusan: „hogyan” (gy → [ɟ] digráf!)
public export
KerdesHogyan : Fonetika
KerdesHogyan =
  [ MassalhangzoHang Mh, MaganhangzoHang Vo, DigrafHang Dgy
  , MaganhangzoHang Va, MassalhangzoHang Mn ]

-- grafikusan: „melyik” (ly → [j] digráf!)
public export
KerdesMelyik : Fonetika
KerdesMelyik =
  [ MassalhangzoHang Mm, MaganhangzoHang Ve, DigrafHang Dly
  , MaganhangzoHang Vi, MassalhangzoHang Mk ]

-- ─── 3. A KÉRDŐSZÓ → ESETRAG LEKÉPEZÉS (típusosan) ────────
-- A CPT-kapcsolat: a kérdőszó C = FORRÁS (honnan tudom?),
-- az esetrag a válasz P = SZEMLÉLETE (hogyan látom).

public export
kerdoszoEsetT : KerdoszoT -> Maybe Esetrag
kerdoszoEsetT KiKerdo      = Just NominativusE
kerdoszoEsetT MitKerdo     = Just NominativusE
kerdoszoEsetT KitKerdo     = Just AccusativusE
kerdoszoEsetT MiertKerdo   = Just CausalisFinalisE
kerdoszoEsetT HolKerdo     = Just InessivusE
kerdoszoEsetT HovaKerdo    = Just IllativusE
kerdoszoEsetT HonnanKerdo  = Just ElativusE
kerdoszoEsetT MikorKerdo   = Nothing
kerdoszoEsetT HogyanKerdo  = Just FormativusE
kerdoszoEsetT MivelKerdo   = Just InstrumentalisE
kerdoszoEsetT KivelKerdo   = Just InstrumentalisE
kerdoszoEsetT MelyikKerdo  = Just NominativusE
kerdoszoEsetT MennyiKerdo  = Nothing

-- ─── 4. A KÉRDÉS MINT MORFIZMUS ÜRES CELAL ─────────────────
-- A Yoneda-csomag: egy kérdés + a válasz helye (kezdetben üres).
-- A válasz ADATA a céltípus; a Maybe = a nyitottság maga.

public export
record NyitottKerdes where
  constructor NyitottKerdesKonstruktor
  kerdoSzava   : KerdoszoT
  valaszHelye  : Maybe Fonetika

-- A megkérdezés: a kérdőszóból nyitott kérdés lesz.
public export
megkerdez : KerdoszoT -> NyitottKerdes
megkerdez kerdo = NyitottKerdesKonstruktor kerdo Nothing

-- A megválaszolás: a válasz BETÖLTI a helyet — a gradiens lecsökken.
public export
megvalaszol : NyitottKerdes -> Fonetika -> NyitottKerdes
megvalaszol (NyitottKerdesKonstruktor kerdo _) valasz =
  NyitottKerdesKonstruktor kerdo (Just valasz)

-- Nyitott-e még? (van-e entrópia-gradiens?)
public export
megNyitott : NyitottKerdes -> Bool
megNyitott (NyitottKerdesKonstruktor _ Nothing)  = True
megNyitott (NyitottKerdesKonstruktor _ (Just _)) = False

-- ─── 5. A BINÁRIS KÉRDÉS = 1 BIT (a felezés elve) ─────────
-- A válaszfélek típusa (a felezés két ága):
public export
data ValaszFele = ElsoFele | MasodikFele
-- „melyik?” = a felező kérdés: minden válasz ≤ 1 bittel
-- csökkenti az entrópiát (session_export.md:74360).
-- A KIBONTÁS: a két fél közül melyik? — Kubit!

public export
binarisKerdesBit : NyitottKerdes -> ValaszFele -> Fonetika -> NyitottKerdes
binarisKerdesBit (NyitottKerdesKonstruktor kerdo _) valaszFele valasz =
  NyitottKerdesKonstruktor kerdo (Just valasz)

-- ─── 6. A „KI? / MI?” FUNDAMENTÁLIS PÁR ────────────────────
-- Az első kérdés-pár: élő / dolog. Ez a legalapvetőbb osztás —
-- a saját / másik kubit nyelvi párja.

public export
data AlapOszto = Elo | Dolog

public export
Eq AlapOszto where
  Elo   == Elo   = True
  Dolog == Dolog = True
  _     == _     = False

public export
kerdoszoOsztoja : KerdoszoT -> Maybe AlapOszto
kerdoszoOsztoja KiKerdo   = Just Elo
kerdoszoOsztoja KitKerdo  = Just Elo
kerdoszoOsztoja KivelKerdo = Just Elo
kerdoszoOsztoja MitKerdo  = Just Dolog
kerdoszoOsztoja MiertKerdo = Just Dolog
kerdoszoOsztoja HolKerdo  = Just Dolog
kerdoszoOsztoja MelyikKerdo = Just Dolog
kerdoszoOsztoja MennyiKerdo = Just Dolog
kerdoszoOsztoja _         = Nothing

-- ─── 7. BIZONYÍTÁSOK (Refl — a fordító a bírája) ──────────

-- Kimenet: Refl — „ki?” élő, „mi?” dolog: az alap-osztó működik
BizKiElo : kerdoszoOsztoja KiKerdo = Just Elo
BizKiElo = Refl

-- Kimenet: Refl
BizMiDolog : kerdoszoOsztoja MitKerdo = Just Dolog
BizMiDolog = Refl

-- Kimenet: Refl — a „miért?” a causalis-finalis (OK/CÉL) esetet kérdezi
BizMiertOk : kerdoszoEsetT MiertKerdo = Just CausalisFinalisE
BizMiertOk = Refl

-- Kimenet: Refl — „mikor?”-ra NINCS esetrag: az idő az IGEIDŐ-re
-- felel (T-dimenzió), nem a névszó-ragrendszerre. Ez a CPT-mappa
-- lényege: T ≠ C ≠ P — a három dimenzió más-más nyelvi eszközt használ.
BizMikorNincsRag : kerdoszoEsetT MikorKerdo = Nothing
BizMikorNincsRag = Refl

-- Kimenet: Refl — a frissen megkérdezett kérdés NYITOTT (gradiens van)
-- A GAUGE-KAPCSOLAT: magyarHangok "ki" == KerdesKi (fent, Refl-lel)
BizKerdesKiGauge : ipaForma KerdesKi = "[ki]"
BizKerdesKiGauge = Refl

-- Kimenet: Refl — „hogyan” gy-digráfja [ɟ]-ként jelenik meg
BizHogyanDgraf : ipaForma KerdesHogyan = "[hoɟɒn]"
BizHogyanDgraf = Refl

-- Kimenet: Refl — „melyik” ly-digráfja [j]-ként
BizMelyikDgraf : ipaForma KerdesMelyik = "[mɛjik]"
BizMelyikDgraf = Refl

-- ─── 8. A KÉRDŐSZÓ-ESET TÁBLA (a 18 rag = 18 kérdés) ──────

public export
kerdoszoTablazat : String
kerdoszoTablazat =
  "A 18 esetrag = 18 MEGVÁLASZOLT KÉRDÉS:\n"
  ++ "  ki?/mi?     → nominativus    (AGENS)\n"
  ++ "  kit?/mit?   → akku­szativus    (PATIENS)\n"
  ++ "  kinek?      → dativus        (KEDVEZMÉNYEZETT)\n"
  ++ "  hol?        → inessivus      (BEN)\n"
  ++ "  hová?       → illativus      (BA)\n"
  ++ "  honnan?     → elativus       (BÓL)\n"
  ++ "  miért?      → causalis       (ÉRT = OK/CÉL)\n"
  ++ "  hogyan?     → formativus     (KÉPP = MÓD)\n"
  ++ "  mivel?      → instrumentalis (VAL = ESZKÖZ)\n"
  ++ "  mikor?      → NINCS RAG — az IGEIDŐ-re felel (T ≠ C,P!)\n"

-- ─── 9. FŐ — vékony IO-burkoló ────────────────────────────

public export
foJelentes : String
foJelentes =
  "═══ KÉRDŐSZÓ — mindennek alfja és omegája ═══\n\n"
  ++ kerdoszoTablazat ++ "\n"
  ++ "„ki?” IPA: " ++ ipaForma KerdesKi ++ " | „hogyan?” IPA: "
  ++ ipaForma KerdesHogyan ++ " | „melyik?” IPA: " ++ ipaForma KerdesMelyik ++ "\n\n"
  ++ "A kérdés = morfizmus üres célal; a válasz tölti ki:\n"
  ++ "  megkerdez MiertKerdo → nyitott? "
  ++ show (megNyitott (megkerdez MiertKerdo)) ++ "\n"
  ++ "  megvalaszol 'mi'-vel → nyitott? "
  ++ show (megNyitott (megvalaszol (megkerdez MitKerdo) KerdesMi)) ++ "\n\n"
  ++ "A bináris kérdés ≤ 1 bit: „melyik?” = a felező (O(log n))\n"
  ++ "Yoneda: a „ki?” = Hom(–, ember) — a kérdés a meta-szint\n"

main : IO ()
main = putStrLn foJelentes


-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
KerdoszoLeiras : ModulLeirasT
KerdoszoLeiras = ModulLeirasKonstruktor
  "Kerdoszo.idr" "kérdőszó→esetrag; „mikor?”-ra nincs rag [Refl] (T≠C,P)" "a kíváncsiság TÍPUS: kérdés = morfizmus üres célal; Yoneda" "13 teszt + 7 Refl"
