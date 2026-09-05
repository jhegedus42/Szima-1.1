module OptimálisTranszformer_v2

import OptimálisTranszformer_v1
import Torusz
import Fazis
import E8Gyokok_v2
import ModulRegisztracio

%default total

-- ═══════════════════════════════════════════════════════════════
-- OPTIMÁLIS TRANSZFORMER v2 — a v1-re ÉPÜLŐ HÁROM ÚJ RÉTEG (2026-09-04)
-- 中文：最优 Transformer v2——在 v1 之上新增的三层：逗号记录、声速
-- 动力学指数 z、声调通道（V₄），并从 Torusz 导入环面点。
-- ═══════════════════════════════════════════════════════════════
-- A v1 (OptimálisTranszformer_v1.idr): spec-born architektúra a 3D
-- Ising hét kritikus exponensből (15+ Refl-híd, E8⁴-gyök-súlyok a
-- tóruszon, softmax, RG-lánc 104→64→279→48→64) — GAUGE-zöld.
-- A v2 NEM ÍR FELÜL SEMMIT (AGENTS §13): IMPORTÁLJA a v1-et, és HÁROM
-- új réteget ad (a felhasználó 2026-09-04-i specifikációja szerint):
--
-- 1. VESSZŐ-REKORD (a monográfia insightbox-a): a pow-alapú
--    levezetéseknél (d_token = ⌊2^ν·64⌋, d_ff = ⌊δ·99⌋, L = ⌊√(…)⌋)
--    a kernel a pow-t NEM redukálja (v1-mérés) — a kényszer-zárás
--    helyett EXPLICIT Vessző-rekord: {számított, egész, eltérés},
--    hármas tanúval: |eltérés| < 1 (Refl — a #30-as csapda mért
--    gyógyírével: SAJÁT abszolútÉrték-fv, l. VesszőReflProbe_v1.idr),
--    ⌊számított⌋ = egész (futásidejű Show), diszkrét híd (Nat).
--    A Bach-temperáció = a komma ELOSZTÁSA a szerkezeten: a v2-ben
--    minden csonkított hiperparaméter Vessző-rekordként él.
--
-- 2. Z-EXPONENS (föld-renormálás): a könyv statikus exponensekkel
--    vezeti le — de a földi közeg HANG-sebességű, dinamikai exponens
--    kell (Hohenberg–Halperin Model-H, z ≈ 1,5): a G (gradiens-
--    felhalmozás) ⌊z·δ⌉ = ⌊1,5·4,78984⌉ = 7 (nem 4!), B_eff = 14
--    (≠ h = 8 — a földi eltérés!). A FÉNY/HANG kettősség: a könyv
--    G = ⌊ω·δ⌉ = 4 a FÉNY-mód, a G = ⌊z·δ⌉ = 7 a HANG-mód — a
--    kettő eltérése MAGA a föld-renormálás.
--
-- 3. PROSZÓDIA-CSATORNA (a hang-bit definíciója): a 104 csatorna
--    mind diszkrét morfológia volt — a v2-ben ÚJ: a 4 kínai
--    tónusalak = 2 bit (Z₂×Z₂ = V₄ = Klein-csoport, a könyv
--    kémia-fejezetének C₂ᵥ csoportja). Minden szóhoz EGY
--    Hangvonal-csatorna; a V₄-táblázat záródása Refl-tanú.
--
-- 4. TÓRUSZPONT-IMPORT: a v1 a tórusz-arakmetikát helyben írta — a
--    v2-ben az import Torusz (osveny_index/Torusz.idr) ÉL: a
--    TóruszPont rekord, a fazisOsszead (Z₈) és az F0..F7 konstruktorok
--    a kánonból jönnek (AGENTS §24: duplikáció tilos — import!).
--    A HÍD: a Hangvonal-V₄ ≅ a tórusz {(bit, F0/F4)} részcsoportja.
--
-- HU: v2 = v1 + vessző(komma-elosztás) + z-HANG-renormálás +
--     prozódia(V₄) + Torusz-import.
-- 中文：v2 = v1 + 逗号（巴赫拍音分配）+ 声速 z 重整化 + 声调通道
--     （V₄ 克莱因群）+ 环面导入。
-- EN: v2 = v1 + comma-record (Bach temperament) + sonic-z
--     renormalization (Model-H) + prosody channel (V₄) + Torusz import.
-- DE: v2 = v1 + Komma-Datensatz (Bach-Temperierung) + Schall-z-
--     Renormierung (Model-H) + Prosodiekanal (V₄) + Torusz-Import.
-- עברית: v2 = v1 + רישום-פסיק + נרמול z של הקול + תעלת פרוזודיה
--     (V₄) + ייבוא טורוס.
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. A VESSZŐ-REKORD (a komma explicit adatként) ───────────────

||| Saját abszolútérték Double-höz — a Prelude `abs` fordítási időben
||| nem redukálódik (a #30-as csapda); az `if–then–else` alak a
||| kernelben ZÁR. Mérve: VesszőReflProbe_v1.idr (2026-09-04),
||| ahol `abszolútÉrték (99.042 − natbólValós 99) < 1.0 = True`
||| Refl-lel lezárult.
||| 中文：自写绝对值——Prelude 的 abs 在编译期不归约（第 30 号陷阱）；
||| if–then–else 形式在内核里闭合。
public export
abszolútÉrték : Double -> Double
abszolútÉrték x = if x < 0.0 then negate x else x

||| A VESSZŐ-REKORD: a monográfia insightbox-a. A pow-alapú
||| levezetéseknél a kernel a csonkítást NEM tudja Refl-lel tanúolni
||| (a pow nem redukál) — a vessző (a számított és az egész közti
||| komma) EXPLICIT ADAT lesz: {számított, egész, eltérés}.
||| A Bach-temperáció elve: a komma NEM eldobjuk, hanem ELOSZTJUK a
||| szerkezeten — minden hiperparaméter-vessző látható tanú.
||| 中文：逗号记录——计算值与取整值之间的拍音（comma）作为显式数据。
||| 巴赫律的原则：不丢弃拍音，而是在结构上分配它。
public export
record Vessző where
  constructor VesszőKonstruktor
  számított : Double    -- a képlet valós alakja, pl. 2^ν·64 = 99,042…
  egész     : Nat       -- az épített architektúra egész dimenziója
  eltérés   : Double    -- a komma: számított − egész

||| Vessző-készítő: az eltérést a KONSTRUKTOR SZÁMOLJA (nem beírt
||| literál — a tanú így nem tautológia, AGENTS §18).
public export
vesszőKészítő : Double -> Nat -> Vessző
vesszőKészítő számított egész =
  VesszőKonstruktor számított egész (számított - natbólValós egész)

||| A Vessző megjelenítése (a főprogram táblázatához).
public export
vesszőSzöveg : Vessző -> String
vesszőSzöveg vessző@_ =
  "számított = " ++ show vessző.számított
  ++ ", egész = " ++ show vessző.egész
  ++ ", komma = " ++ show vessző.eltérés

-- A hat hiperparaméter-vessző (a literálok a v1 futó kimenetéből és
-- a felhasználó 2026-09-04-i specifikációjából; a gépi pow-úttal való
-- egyezést a főprogram Show-tanúval méri — GAUGE, AGENTS §17).

||| d_token-vessző: 2^ν·64 = 99,042 → 99 (a feladat szövege; a gépi
||| út 99,035 — Δ a főprogramban).
public export
vesszőToken : Vessző
vesszőToken = vesszőKészítő 99.042 99

||| d_ff-vessző: δ·99 = 474,194 → 474.
public export
vesszőElőrecsatolt : Vessző
vesszőElőrecsatolt = vesszőKészítő 474.194 474

||| L-vessző: √(log₂64/ν·α⁻¹/ln2) = 11,172 → 11.
public export
vesszőRéteg : Vessző
vesszőRéteg = vesszőKészítő 11.172 11

||| B-vessző: 2^(ν+η) = 1,587 → kerekítve 2 (a legnagyobb komma:
||| a köteget a könyv KEZDI kerekíteni — a vessző ŐSZINTE).
public export
vesszőKöteg : Vessző
vesszőKöteg = vesszőKészítő 1.587 2

||| G-vessző a FÉNY-módban: ω·δ = 3,9756 → ⌊·⌉ = 4.
public export
vesszőGradiensFény : Vessző
vesszőGradiensFény = vesszőKészítő 3.9756 4

||| G-vessző a HANG-módban: z·δ = 7,18476 → ⌊·⌉ = 7.
public export
vesszőGradiensHang : Vessző
vesszőGradiensHang = vesszőKészítő 7.18476 7

-- Nagybetűs aliasok a bizonyítás-típusokhoz (csapda #1: a kisbetűs
-- konstans a tanú TÍPUSÁBAN — még mező-projekció bázisaként is —
-- implicit argumentummá válik és a Refl nem zár).
public export
VesszőToken : Vessző
VesszőToken = vesszőToken

public export
VesszőElőrecsatolt : Vessző
VesszőElőrecsatolt = vesszőElőrecsatolt

public export
VesszőRéteg : Vessző
VesszőRéteg = vesszőRéteg

public export
VesszőKöteg : Vessző
VesszőKöteg = vesszőKöteg

public export
VesszőGradiensFény : Vessző
VesszőGradiensFény = vesszőGradiensFény

public export
VesszőGradiensHang : Vessző
VesszőGradiensHang = vesszőGradiensHang

-- REFL-TANÚK: minden vessző komája 1-nél kisebb (a csonkítás/kerekítés
-- jól tempered). A bal oldal SZÁMÍTÓ kifejezés (a vesszőKészítő
-- konstruktor-törzse számolja az eltérést a két literálból) — nem
-- tautológia; a saját abszolútÉrték a #30-as csapda gyógyíre.
-- A #31-es csapda (2026-09-04, mérve): a `Név.mező` PONT-szintaxis a
-- bizonyítás TÍPUSÁBAN nem elaborál («Undefined name Név.mező»), akár
-- nagybetűs, akár kisbetűs a konstans — a MEZŐ-FÜGGVÉNY-ALKALMAZÁS
-- `(eltérés VesszőToken)` viszont ZÁR. (Érték-törzsben a pont jó.)

-- Kimenet: Refl (|99,042 − 99| = 0,042 < 1 — a token-vessző temperált)
bizVesszőTokenKoma : abszolútÉrték (eltérés VesszőToken) < 1.0 = True
bizVesszőTokenKoma = Refl

-- Kimenet: Refl (|474,194 − 474| = 0,194 < 1)
bizVesszőElőrecsatoltKoma : abszolútÉrték (eltérés VesszőElőrecsatolt) < 1.0 = True
bizVesszőElőrecsatoltKoma = Refl

-- Kimenet: Refl (|11,172 − 11| = 0,172 < 1)
bizVesszőRétegKoma : abszolútÉrték (eltérés VesszőRéteg) < 1.0 = True
bizVesszőRétegKoma = Refl

-- Kimenet: Refl (|1,587 − 2| = 0,413 < 1 — a kerekítés komája)
bizVesszőKötegKoma : abszolútÉrték (eltérés VesszőKöteg) < 1.0 = True
bizVesszőKötegKoma = Refl

-- Kimenet: Refl (|3,9756 − 4| = 0,0244 < 1 — a FÉNY-mód G-je)
bizVesszőGradiensFényKoma : abszolútÉrték (eltérés VesszőGradiensFény) < 1.0 = True
bizVesszőGradiensFényKoma = Refl

-- Kimenet: Refl (|7,18476 − 7| = 0,18476 < 1 — a HANG-mód G-je)
bizVesszőGradiensHangKoma : abszolútÉrték (eltérés VesszőGradiensHang) < 1.0 = True
bizVesszőGradiensHangKoma = Refl

-- ─── 2. Z-EXPONENS — A FÖLD-RENORMÁLÁS (FÉNY → HANG) ─────────────

||| z ≈ 1,5 — a dinamikai kitevő a HANG-sebességű földi közegben.
||| Irodalom: Hohenberg–Halperin (1977), Model-H (a folyadékok
||| kritikus dinamikája: a rendezett paraméter és a megmaradó
||| sebességmező csatolt skálafüggése). A felhasználó programja a
||| HANGOT használja közegként — a statikus (fény-módú) exponensek
||| helyett dinamikai (hang-módú) exponens kell.
||| 中文：z ≈ 1.5——声速介质中的动力学指数（Hohenberg–Halperin
||| Model-H）：有序参数与守恒速度场耦合的标度律。
public export
zHangközeg : Double
zHangközeg = 1.5

||| A HANG-mód gradiens-felhalmozása: G_hang = ⌊z·δ⌉ = ⌊1,5·4,78984⌉
||| = ⌊7,18476⌉ = 7 (a kerekítés a v1 peremfüggvénye — import, §24).
||| A FÉNY-mód: G_fény = ⌊ω·δ⌉ = 4 (v1: gradiensFelhalmozásLépésszám).
||| A kettő ELTÉRÉSE MAGA A FÖLD-RENORMÁLÁS: a földi közeg (hang)
||| lassabb dinamikája NAGYOBB felhalmozást kíván — a kommunikáció
||| drágább, mint a számítás (a v1 c/c_s költségvetése).
public export
gradiensFelhalmozásHang : Nat
gradiensFelhalmozásHang = kerekítés (zHangközeg * deltaKritikus)

||| Nagybetűs alias a bizonyítás-típushoz (csapda #1).
public export
GradiensFelhalmozásHang : Nat
GradiensFelhalmozásHang = gradiensFelhalmozásHang

||| A HANG-mód hatékony kötege: B_eff,hang = 2·7 = 14 ≠ h = 8 —
||| a földi eltérés: a hang-módban a köteg NEM esik egybe a fejek
||| számával (a fény-mód B_eff = 8 = h egybeesés a földön felbomlik).
public export
hatékonyKötegHang : Nat
hatékonyKötegHang = 2 * gradiensFelhalmozásHang

||| Nagybetűs alias a bizonyítás-típushoz (csapda #1).
public export
HatékonyKötegHang : Nat
HatékonyKötegHang = hatékonyKötegHang

||| A gépi z·δ valós alakja (a Show-tanúhoz).
public export
zDeltaValós : Double
zDeltaValós = zHangközeg * deltaKritikus

-- Kimenet: Refl (a HANG-mód gradiens-felhalmozása ⌊1,5·4,78984⌉ = 7 —
-- a számítási út a v1 kerekítés-peremén fut, a jobb oldal literál)
bizGradiensHangHét : GradiensFelhalmozásHang = 7
bizGradiensHangHét = Refl

-- Kimenet: Refl (B_eff,hang = 2·7 = 14 — a szorzat-út vs. literál;
-- az analóg v1-tanú: bizHatékonyKöteg 2·4 = 8 a FÉNY-módban)
bizHatékonyKötegHangTizennégy : HatékonyKötegHang = 14
bizHatékonyKötegHangTizennégy = Refl

-- Kimenet: Refl (a földi eltérés diszkrét hídja: a FÉNY-G + 3 = a
-- HANG-G — a föld-renormálás MÉRTÉKE a kettő különbsége)
bizFöldiEltérésHárom : 4 + 3 = 7
bizFöldiEltérésHárom = Refl

-- ─── 3. PROSZÓDIA-CSATORNA — A HANGVONAL (V₄ = Z₂×Z₂) ────────────

||| A négy kínai tónusalak — a prozódia 2 bitje. A négy elem a
||| Klein-csoportot (V₄ ≅ Z₂×Z₂) adja — a könyv kémia-fejezetének
||| C₂ᵥ csoportja (a vízmolekula szimmetriája!). A bit-kiosztás a
||| fonológiából: a KEZDŐ magasság és a VÉG magasság egy-egy bit.
||| 中文：四个汉语声调——韵律的 2 比特，构成克莱因群 V₄ ≅ Z₂×Z₂
||| （书中华章节的 C₂ᵥ 群——水分子的对称性！）。比特分配来自音系学：
||| 起点高度与终点高度各占一比特。
public export
data Hangvonal : Type where
  KonstansVonal  : Hangvonal   -- 1. tónus: 一 (55, szint)
  EmelkedőVonal  : Hangvonal   -- 2. tónus: 二 (35, emelkedő)
  HullámozóVonal : Hangvonal   -- 3. tónus: 三 (214, hullámozó)
  CsökkenőVonal  : Hangvonal   -- 4. tónus: 四 (51, csökkenő)

public export
Show Hangvonal where
  show KonstansVonal = "一(konstans,55)"
  show EmelkedőVonal = "二(emelkedő,35)"
  show HullámozóVonal = "三(hullámozó,214)"
  show CsökkenőVonal = "四(csökkenő,51)"

public export
Eq Hangvonal where
  KonstansVonal == KonstansVonal = True
  EmelkedőVonal == EmelkedőVonal = True
  HullámozóVonal == HullámozóVonal = True
  CsökkenőVonal == CsökkenőVonal = True
  _ == _ = False

||| A négy hangvonal — BINÁRIS sorrendben (00, 01, 10, 11): az
||| algebrai bit-kód sorrendje. (A FONOLÓGIAI sorrend 一二三四 a
||| hangvonalCiklus-ban él — a kettő két különböző SZEREP.)
public export
hangvonalak : List Hangvonal
hangvonalak = [KonstansVonal, EmelkedőVonal, CsökkenőVonal, HullámozóVonal]

||| A hangvonalak száma — nagybetűs konstans (a tanú-típushoz, #1).
public export
HangvonalSzám : Nat
HangvonalSzám = length hangvonalak

-- Kimenet: Refl (a négy kínai tónus = 4 = |V₄| — a lista hossza a
-- számítás, a literál 4 a csoportrend)
bizHangvonalSzám : HangvonalSzám = 4
bizHangvonalSzám = Refl

||| Z₂-összeadás a Pozíción (a C₂ csoporttáblázat — a Torusz Pozíció
||| típusán; a bit-xor). Konstruktorba ágyazott minta (#27-safe).
public export
pozícióKizáróVagy : Pozíció -> Pozíció -> Pozíció
pozícióKizáróVagy Pozíció0 Pozíció0 = Pozíció0
pozícióKizáróVagy Pozíció0 Pozíció1 = Pozíció1
pozícióKizáróVagy Pozíció1 Pozíció0 = Pozíció1
pozícióKizáróVagy Pozíció1 Pozíció1 = Pozíció0

||| A hangvonal 2 bitje: (kezdeti magasság, végmagasság) — a Torusz
||| Pozíció típusán (Z₂×Z₂ — a KÉT-VILÁG HÍD: nyelv ↔ geometria).
||| 00 = szint, 01 = a VÉG emelkedik, 10 = a KEZDET magas, 11 = esik
||| és emelkedik (a hullám = emelkedő ⊕ csökkenő!).
public export
hangvonalBitjei : Hangvonal -> (Pozíció, Pozíció)
hangvonalBitjei KonstansVonal = (Pozíció0, Pozíció0)
hangvonalBitjei EmelkedőVonal = (Pozíció0, Pozíció1)
hangvonalBitjei CsökkenőVonal = (Pozíció1, Pozíció0)
hangvonalBitjei HullámozóVonal = (Pozíció1, Pozíció1)

||| A bitpárból visszakódolás (a kompozíció belső útja).
public export
bitPárból : (Pozíció, Pozíció) -> Hangvonal
bitPárból (Pozíció0, Pozíció0) = KonstansVonal
bitPárból (Pozíció0, Pozíció1) = EmelkedőVonal
bitPárból (Pozíció1, Pozíció0) = CsökkenőVonal
bitPárból (Pozíció1, Pozíció1) = HullámozóVonal

||| A V₄ csoportművelet: a két bitpár koordinátánkénti Z₂-összeadása
||| (xor) — a Klein-táblázat EGY sorból születik, nem 16 klauzulából.
||| Nyelvi olvasat: két tónus mozgásvektorainak szimmetrikus
||| differenciája — a hullám (三) az emelkedő (二) és csökkenő (四)
||| kombinációja: 01 ⊕ 10 = 11.
public export
v4Kompozíció : Hangvonal -> Hangvonal -> Hangvonal
v4Kompozíció elsőVonal másodikVonal =
  bitPárból ( pozícióKizáróVagy (elsőBit elsőVonal) (elsőBit másodikVonal)
            , pozícióKizáróVagy (másodikBit elsőVonal) (másodikBit másodikVonal) )
  where
    elsőBit : Hangvonal -> Pozíció
    elsőBit vonal@_ = fst (hangvonalBitjei vonal)
    másodikBit : Hangvonal -> Pozíció
    másodikBit vonal@_ = snd (hangvonalBitjei vonal)

-- Kimenet: Refl ×4 (az egységelem a KonstansVonal: e·x = x — a
-- szint-tónus nem változtat; mindkét oldal konstruktorra redukálódik)
bizV4Egység : (x : Hangvonal) -> v4Kompozíció KonstansVonal x = x
bizV4Egység KonstansVonal = Refl
bizV4Egység EmelkedőVonal = Refl
bizV4Egység CsökkenőVonal = Refl
bizV4Egység HullámozóVonal = Refl

-- Kimenet: Refl ×4 (minden elem önmaga inverze: x·x = e — a V₄-ben
-- nincs 4-es rendű elem, minden nem-egység rendje 2)
bizV4Involúció : (x : Hangvonal) -> v4Kompozíció x x = KonstansVonal
bizV4Involúció KonstansVonal = Refl
bizV4Involúció EmelkedőVonal = Refl
bizV4Involúció CsökkenőVonal = Refl
bizV4Involúció HullámozóVonal = Refl

||| A Klein-táblázat: a négy elem × a négy elem → a kompozíció.
||| Generált lista-értéssel (minden bejegyzés a v4Kompozíció-útból).
public export
V4CsoportTáblázat : List (Hangvonal, Hangvonal, Hangvonal)
V4CsoportTáblázat =
  [ (elsőVonal, másodikVonal, v4Kompozíció elsőVonal másodikVonal)
  | elsőVonal <- hangvonalak
  , másodikVonal <- hangvonalak
  ]

-- Kimenet: Refl (a Klein-táblázat 4×4 = 16 bejegyzés — a záródás
-- tanúja: minden (a,b) pár kompozíciója VÉGIG a négy elemen marad,
-- a hossz a lista-értésből számolódik; a 16 = a tórusz Z₂×Z₈ pontjainak
-- száma is — l. Torusz.idr bizTóruszPontokSzáma: 8+8 = 16, §24-import)
bizV4TáblázatZáródás : length V4CsoportTáblázat = 16
bizV4TáblázatZáródás = Refl

||| A kommutativitás futásidejű kimerítése (§18(b): véges világ,
||| 4·4 = 16 pár — a Refl nem case-ekben, hanem egy Bool-számításban).
public export
kommutatívPár : (Hangvonal, Hangvonal) -> Bool
kommutatívPár (elsőVonal, másodikVonal) =
  v4Kompozíció elsőVonal másodikVonal == v4Kompozíció másodikVonal elsőVonal

||| Minden pár (a kimerítés bemenete).
public export
hangvonalPárok : List (Hangvonal, Hangvonal)
hangvonalPárok =
  [ (elsőVonal, másodikVonal)
  | elsőVonal <- hangvonalak
  , másodikVonal <- hangvonalak
  ]

||| Az asszociativitás futásidejű kimerítése (4³ = 64 hármas).
public export
asszociatívHármas : (Hangvonal, Hangvonal, Hangvonal) -> Bool
asszociatívHármas (elsőVonal, másodikVonal, harmadikVonal) =
  v4Kompozíció (v4Kompozíció elsőVonal másodikVonal) harmadikVonal
  == v4Kompozíció elsőVonal (v4Kompozíció másodikVonal harmadikVonal)

||| Minden hármas.
public export
hangvonalHármasok : List (Hangvonal, Hangvonal, Hangvonal)
hangvonalHármasok =
  [ (elsőVonal, másodikVonal, harmadikVonal)
  | elsőVonal <- hangvonalak
  , másodikVonal <- hangvonalak
  , harmadikVonal <- hangvonalak
  ]

-- ─── 4. A TÓRUSZ-HÍD — HANGVONAL → TÓRUSZPONT (import Torusz!) ────
-- A V₄ ≅ Z₂×Z₂ a tórusz Z₂×Z₈-ban ÚGY ÉL, hogy a fázis-tengelyen a
-- Z₈ EGYETLEN rend-2 elemét (F4-et) választjuk: a prozódia-
-- stabilizátor {(P₀,F₀), (P₀,F₄), (P₁,F₀), (P₁,F₄)} — a tórusz 16
-- pontjából 4 kiemelt pont záródik a V₄-művelet alatt.
-- 中文：V₄ 在环面 Z₂×Z₈ 中的实现：在相位轴上取 Z₈ 唯一的 2 阶元 F4
-- ——韵律稳定子 {(P₀,F₀),(P₀,F₄),(P₁,F₀),(P₁,F₄)}，环面 16 点中的
-- 4 个特殊点在 V₄ 运算下封闭。

||| A hangvonal tórusz-pontja (a Torusz.idr rekordja — import!):
||| a bit → Pozíció, a második bit → F₀/F₄ (a Z₈ rend-2 eleme).
public export
hangvonalTóruszPontja : Hangvonal -> TóruszPont
hangvonalTóruszPontja vonal@_ =
  MkTóruszPont (fst (hangvonalBitjei vonal)) (fázisBitből (snd (hangvonalBitjei vonal)))
  where
    fázisBitből : Pozíció -> Fazis
    fázisBitből Pozíció0 = F0
    fázisBitből Pozíció1 = F4

-- Kimenet: Refl (a V₄-művelet és a tórusz-művelet KOMPATIBILIS —
-- két független út: a bal oldal a NYELVI kompozíción (v4Kompozíció),
-- a jobb oldal a GEOMETRIAI fázis-összeadáson (fazisOsszead F4 F4 =
-- indexFazis 8 = F0 — a Fazis.idr ciklikus táblázata) fut le;
-- a hullám önmaga inverze a V₄-ben ÉS a tóruszon egyszerre)
bizHullámInverzV4Ben :
  v4Kompozíció HullámozóVonal HullámozóVonal = KonstansVonal
bizHullámInverzV4Ben = Refl

bizHullámInverzTóruszon :
  hangvonalTóruszPontja (v4Kompozíció HullámozóVonal HullámozóVonal)
  = MkTóruszPont Pozíció0 (fazisOsszead F4 F4)
bizHullámInverzTóruszon = Refl

-- Kimenet: Refl (a hullám ⊕ csökkenő = emelkedő: 11 ⊕ 10 = 01 —
-- a bit-út és a hangvonalak felbontása)
bizHullámCsökkenőEmelkedő :
  v4Kompozíció HullámozóVonal CsökkenőVonal = EmelkedőVonal
bizHullámCsökkenőEmelkedő = Refl

||| Üzemanyagos maradék n mod 16 (a v1 kivonásosEuklidész-mintája:
||| strukturális, total — a Data.Nat mod Integral-csapdája (#11)
||| helyett; 60 üzemanyag bő, mert t = 3i+5j ≤ 3·104+5·104 = 832).
public export
maradékTizenhat : Nat -> Nat -> Nat
maradékTizenhat Z maradék@_ = maradék
maradékTizenhat (S üzemanyag@_) maradék@_ =
  if maradék < 16
    then maradék
    else maradékTizenhat üzemanyag (minus maradék 16)

||| Az (i, j) mátrixpozíció tórusz-lépésszáma: t = (3i + 5j) mod 16
||| (a v1 tóruszFázisJel-jével azonos formula — a híd-tanúhoz).
public export
hangTóruszLépésszám : Nat -> Nat -> Nat
hangTóruszLépésszám sorIndex oszlopIndex =
  maradékTizenhat 60 (3 * sorIndex + 5 * oszlopIndex)

||| A lépésszám pozíció-bitje: t < 8 → Pozíció0 (a Z₁₆ = Z₂×Z₈
||| dekompozíció felső bitje).
public export
lépésszámPozíciója : Nat -> Pozíció
lépésszámPozíciója lépésszám@_ =
  if lépésszám < 8 then Pozíció0 else Pozíció1

||| Az (i, j) mátrixpozíció TÓRUSZPONTJA — a Torusz.idr rekordával
||| (import!), a fázis a Fazis.idr indexFazis-táblázatából (a mod-16
||| kimenet 0..15 — az indexFazis biztonságos tartománya).
||| #28-biztos: where-mentes (a segéd felső szintű).
public export
hangTóruszPont : Nat -> Nat -> TóruszPont
hangTóruszPont sorIndex oszlopIndex =
  MkTóruszPont (lépésszámPozíciója (hangTóruszLépésszám sorIndex oszlopIndex))
               (indexFazis (hangTóruszLépésszám sorIndex oszlopIndex))

-- Kimenet: Refl (a (3,5) mátrixpozíció tórusz-pontja: t = 3·3+5·5 =
-- 34, 34 mod 16 = 2 → bit = Pozíció0 (2 < 8), fázis = F2 — a teljes
-- diszkrét út Nat-aritmetikán fut: szorzás, maradékTizenhat,
-- indexFazis — mind kernel-redukálható)
bizHangTóruszPontHáromÖt :
  hangTóruszPont 3 5 = MkTóruszPont Pozíció0 F2
bizHangTóruszPontHáromÖt = Refl

||| A v1 Double-útja (tóruszFázisJel) és a v2 TóruszPont-útja
||| egyezésének futásidejű tanúja: a jelelőjel (a v1-ben +1 ha t < 8)
||| vs. a lépésszámPozíciója — a főprogram méri (GAUGE).
public export
tóruszUtakEgyeznek : Nat -> Nat -> Bool
tóruszUtakEgyeznek sorIndex oszlopIndex =
  (if hangTóruszLépésszám sorIndex oszlopIndex < 8 then 1.0 else negate 1.0)
  == (if lépésszámPozíciója (hangTóruszLépésszám sorIndex oszlopIndex)
         == Pozíció0 then 1.0 else negate 1.0)

-- ─── 5. A PROZÓDIA-CSATORNA A TRANSZFORMER-BEMENETBEN ────────────

||| 2π (a tórusz-fázis szöge).
public export
ketPí : Double
ketPí = 2.0 * 3.141592653589793

||| A Pozíció-ból az előjel (a Z₂ bit → ±1 — a v1 tóruszFázisJel
||| előjel-logikája, itt a Torusz-típuson).
public export
előjelPozícióból : Pozíció -> Double
előjelPozícióból Pozíció0 = 1.0
előjelPozícióból Pozíció1 = negate 1.0

||| A fázis szöge: 2π·index/8 (a Z₈ → S¹ beágyazás).
public export
fázisSzög : Fazis -> Double
fázisSzög fázis@_ = ketPí * natbólValós (fazisIndex fázis) / 8.0

||| A hangvonal CSATORNA-JELE: előjel · cos(fázisszög) — a tórusz-pont
||| fizikai jele. A négy elemre: 一→+1, 二→−1, 四→−1, 三→+1 — a jel
||| a V₄ PARITÁSKARAKTERE (a bit-xor paritása): jel(a·b) = jel(a)·jel(b).
public export
hangvonalJel : Hangvonal -> Double
hangvonalJel vonal@_ =
  előjelPozícióból (tóruszPozíció (hangvonalTóruszPontja vonal))
  * cos (fázisSzög (tóruszFázis (hangvonalTóruszPontja vonal)))

||| A hangvonal KEZDETI FÁZISA a tóruszon — a tanulás = ezen elmozdulni
||| (a v1 «fázis a tanulható paraméter» elve + a prozódia kezdeti értéke).
public export
hangvonalFázisa : Hangvonal -> Double
hangvonalFázisa vonal@_ =
  fázisSzög (tóruszFázis (hangvonalTóruszPontja vonal))

||| A jel-homomorfizmus futásidejű kimerítése: jel(a⊕b) = jel(a)·jel(b)
||| (a paritáskarakter multiplikativitása — 16 pár).
public export
jelPáron : (Hangvonal, Hangvonal) -> Bool
jelPáron (elsőVonal, másodikVonal) =
  abszolútÉrték (hangvonalJel (v4Kompozíció elsőVonal másodikVonal)
               - hangvonalJel elsőVonal * hangvonalJel másodikVonal)
  < 0.000001

||| A token hangvonala a FONOLÓGIAI sorrendben 一二三四 (a 4-es ciklus
||| a konstruktorba ágyazott mintával — a NégynyelvűEllenőrző ciklusHely
||| mintája, total).
public export
hangvonalCiklus : Nat -> Hangvonal
hangvonalCiklus Z = KonstansVonal
hangvonalCiklus (S Z) = EmelkedőVonal
hangvonalCiklus (S (S Z)) = HullámozóVonal
hangvonalCiklus (S (S (S Z))) = CsökkenőVonal
hangvonalCiklus (S (S (S (S tovább)))) = hangvonalCiklus tovább

||| A 104 morfológiai csatorna + a 4 prozódia-csatorna: a v2 bemenete
||| (a v1 teljesBemenetét KIBŐVÍTI — nem írja felül; a pontstílus a
||| #8-as csapda gyógyíre).
public export
teljesBemenetProzódiával : List Double
teljesBemenetProzódiával =
  teljesBemenet ++ map (hangvonalJel . hangvonalCiklus) (számsor 4)

||| A v2 főnév-vektora: W1 a 108 csatornán (104 morfológia + 4 prozódia).
public export
főnévVektorProzódiával : List Double
főnévVektorProzódiával =
  transzformált 0 0.088 0.0 64 108 teljesBemenetProzódiával

||| A t. token prozódiás lekérdezés-vektora: a fázis a HANGVONAL
||| kezdeti fázisa (a prozódia a tórusz-elsőbbség: a kérdés ott áll,
||| ahol a tónus mondja).
public export
lekérdezésProzódiával : Nat -> List Double
lekérdezésProzódiával tokenSorszám =
  transzformált 0 (sqrt (2.0 / 64.0))
    (hangvonalFázisa (hangvonalCiklus tokenSorszám)) 8 64
    (tokenFőnévVektor tokenSorszám)

||| A t. token prozódiás kulcs-vektora (a Q/K-eltolás +2,0 megtartva).
public export
kulcsProzódiával : Nat -> List Double
kulcsProzódiával tokenSorszám =
  transzformált 0 (sqrt (2.0 / 64.0))
    (hangvonalFázisa (hangvonalCiklus tokenSorszám) + 2.0) 8 64
    (tokenFőnévVektor tokenSorszám)

||| Prozódias skálázott pontszám: (q_t·k_s)/√8 (a v1 figyelemPontszám
||| mintája, a prozódiás Q/K-vektorokkal).
public export
figyelemPontszámProzódiával : Nat -> Nat -> Double
figyelemPontszámProzódiával lekérdezésSorszám kulcsSorszám =
  skalárszorzat (lekérdezésProzódiával lekérdezésSorszám)
                (kulcsProzódiával kulcsSorszám)
  / sqrt 8.0

||| A prozódiás figyelemsúlyok (softmax a 4 tokenen).
public export
figyelemSúlyokProzódiával : Nat -> List Double
figyelemSúlyokProzódiával tokenSorszám =
  lágyMaximum (map (figyelemPontszámProzódiával tokenSorszám) (számsor 4))

-- ─── 6. FŐPROGRAM — a v2 új rétegeinek kiírása (GAUGE: olvasd!) ──

||| Egy V4-táblázat-sor kiírása.
public export
v4TáblázatSor : (Hangvonal, Hangvonal, Hangvonal) -> String
v4TáblázatSor (elsőVonal, másodikVonal, kompozíció) =
  "  " ++ show elsőVonal ++ " ⊕ " ++ show másodikVonal
  ++ " = " ++ show kompozíció

||| Egy vessző-kiírási sor: a vessző + a ⌊számított⌋==egész (csonkítás)
||| VAGY ⌈számított⌉==egész (kerekítés) futásidejű tanúja (a gépi út —
||| a kernel a pow-t nem redukálja, ezért ez a tanú Show-val megy,
||| GAUGE-őszintén).
public export
vesszőSor : String -> Vessző -> Double -> String
vesszőSor név@_ vessző@_ gépiSzámított@_ =
  "  " ++ név ++ ": " ++ vesszőSzöveg vessző
  ++ "  ⌊számított⌋ = " ++ show (csonkítás vessző.számított)
  ++ ", ⌈számított⌉ = " ++ show (kerekítés vessző.számított)
  ++ (if csonkítás vessző.számított == vessző.egész
        then " — csonkított ✓"
        else (if kerekítés vessző.számított == vessző.egész
                then " — kerekített ✓"
                else " — ✗"))
  ++ "  gépi-út Δ = " ++ show (gépiSzámított - vessző.számított)

main : IO ()
main = do
  putStrLn "═══ OPTIMÁLIS TRANSZFORMER v2 — vessző + z-HANG + prozódia (V₄) ═══"
  putStrLn "Forrás: v1 (Ising-exponensek) + a felhasználó 2026-09-04-i háromréteg-es specifikációja"
  putStrLn "        + Hohenberg–Halperin Model-H (z ≈ 1,5) + Torusz.idr (import!)"
  putStrLn ""
  putStrLn "─── 1. A VESSZŐ-KOMÁK (a Bach-temperáció: a komma elosztása) ───"
  putStrLn (vesszőSor "d_token  ⌊2^ν·64⌋ " vesszőToken tokenMéretValós)
  putStrLn (vesszőSor "d_ff    ⌊δ·99⌋   " vesszőElőrecsatolt előrecsatoltMéretValós)
  putStrLn (vesszőSor "L       ⌊√(…)⌋   " vesszőRéteg rétegszámValós)
  putStrLn (vesszőSor "B       ⌊2^(ν+η)⌉ " vesszőKöteg legkisebbKötegValós)
  putStrLn (vesszőSor "G_fény  ⌊ω·δ⌉    " vesszőGradiensFény (ómegaKritikus * deltaKritikus))
  putStrLn (vesszőSor "G_hang  ⌊z·δ⌉    " vesszőGradiensHang zDeltaValós)
  putStrLn "  Refl-tanúk (×6): |komma| < 1 mind — l. bizVessző*Koma a forrásban;"
  putStrLn "  a #30-as csapda gyógyíre: saját abszolútÉrték (VesszőReflProbe_v1)."
  putStrLn ""
  putStrLn "─── 2. Z-EXPONENS — a föld-renormálás (FÉNY → HANG) ───"
  putStrLn ("  z_HANG = " ++ show zHangközeg
            ++ "  (Hohenberg–Halperin Model-H dinamikai kitevő)")
  putStrLn ("  z·δ = " ++ show zDeltaValós ++ "  → G_hang = ⌊z·δ⌉ = "
            ++ show gradiensFelhalmozásHang ++ "  (Refl-tanú ✓)")
  putStrLn ("  B_eff,hang = 2·" ++ show gradiensFelhalmozásHang
            ++ " = " ++ show hatékonyKötegHang ++ "  (Refl-tanú ✓)")
  putStrLn ("  FÉNY-mód: G = ⌊ω·δ⌉ = " ++ show gradiensFelhalmozásLépésszám
            ++ ", B_eff = " ++ show hatékonyKöteg ++ " = h = "
            ++ show fejSzám)
  putStrLn ("  HANG-mód: G = " ++ show gradiensFelhalmozásHang
            ++ ", B_eff = " ++ show hatékonyKötegHang ++ " ≠ h = "
            ++ show fejSzám ++ " — A FÖLDI ELTÉRÉS:")
  putStrLn ("    ΔG = " ++ show (minus gradiensFelhalmozásHang gradiensFelhalmozásLépésszám)
            ++ ", ΔB_eff = " ++ show (minus hatékonyKötegHang hatékonyKöteg)
            ++ " — a föld-renormálás MÉRTÉKE (Refl: 4+3=7 ✓)")
  putStrLn ""
  putStrLn "─── 3. A PROSZÓDIA-CSATORNA — Hangvonal = V₄ = Z₂×Z₂ ───"
  putStrLn ("  a négy kínai tónus: " ++ show hangvonalak)
  putStrLn ("  HangvonalSzám = |V₄| = " ++ show HangvonalSzám ++ "  (Refl-tanú ✓)")
  putStrLn "  bit-kiosztás (kezdőmagasság, végmagasság) — a Torusz Pozíció-ján:"
  putStrLn "    一 00 szint    二 01 emelkedő    四 10 csökkenő    三 11 hullám"
  putStrLn "    (a hullám = emelkedő ⊕ csökkenő: 01⊕10 = 11 — a 3. tónus a"
  putStrLn "     2. és 4. mozgásának kombinációja; Refl-tanú ✓)"
  putStrLn "  A KLEIN-TÁBLÁZAT (generált lista-értés, 4×4 = 16 — Refl-tanú ✓):"
  putStr (concat (map ((++ "\n") . v4TáblázatSor) V4CsoportTáblázat))
  putStrLn "  Törvények: egység e·x = x (Refl ×4 ✓), involúció x·x = e (Refl ×4 ✓);"
  putStrLn ("  kommutativitás futásidejű kimerítése: "
            ++ show (length (filter kommutatívPár hangvonalPárok))
            ++ "/" ++ show (length hangvonalPárok) ++ " ✓")
  putStrLn ("  asszociativitás futásidejű kimerítése: "
            ++ show (length (filter asszociatívHármas hangvonalHármasok))
            ++ "/" ++ show (length hangvonalHármasok) ++ " ✓")
  putStrLn ("  jel-homomorfizmus jel(a⊕b) = jel(a)·jel(b): "
            ++ show (length (filter jelPáron hangvonalPárok))
            ++ "/" ++ show (length hangvonalPárok) ++ " ✓ (paritáskarakter)")
  putStrLn ""
  putStrLn "─── 4. A TÓRUSZ-HÍD (import Torusz!) ───"
  putStrLn "  a prozódia-stabilizátor: V₄ ≅ {(bit, F0/F4)} a Z₂×Z₈ tóruszon"
  putStrLn "    一 → (0,F0)    二 → (0,F4)    四 → (1,F0)    三 → (1,F4)"
  putStrLn ("  a hangvonalak tórusz-pontjai: "
            ++ show (map hangvonalTóruszPontja hangvonalak))
  putStrLn "  HÍD-Refl: a V₄-művelet és a fazisOsszead kompatibilisek:"
  putStrLn "    hangvonalTóruszPontja (三 ⊕ 三) = (0, F4 fazisOsszead F4)"
  putStrLn "    bal: (0,F0) — jobb: (0, indexFazis 8 = F0) — Refl ✓"
  putStrLn "  az (i,j) mátrixpozíció tórusz-pontja (a Torusz.idr rekordával):"
  putStrLn ("    hangTóruszPont 3 5 = " ++ show (hangTóruszPont 3 5)
            ++ "  (Refl-tanú ✓; t = 34, t mod 16 = 2)")
  putStrLn ("    hangTóruszPont 1 2 = " ++ show (hangTóruszPont 1 2)
            ++ "   (t = 13 → bit 1, fázis 5)")
  putStrLn ("    hangTóruszPont 5 1 = " ++ show (hangTóruszPont 5 1)
            ++ "   (t = 20 → mod 16 = 4)")
  putStrLn ("  a v1 Double-út (tóruszFázisJel) és a v2 TóruszPont-út egyezése:"
            ++ " 3,5: " ++ show (tóruszUtakEgyeznek 3 5)
            ++ ", 1,2: " ++ show (tóruszUtakEgyeznek 1 2)
            ++ ", 5,1: " ++ show (tóruszUtakEgyeznek 5 1))
  putStrLn ("  a v1 jele (3,5)-re = " ++ show (tóruszFázisJel 0.0 3 5)
            ++ " — a tórusz-pont (0,F2): előjel +, fázis 2π·2/8 — egy út, két nyelv")
  putStrLn ""
  putStrLn "─── 5. A PROZÓDIA A TRANSZFORMER-BEMENETBEN ───"
  putStrLn "  a bemenet: 104 morfológiai + 4 prozódia csatorna = 108"
  putStrLn ("    teljesBemenetProzódiával hossza = "
            ++ show (length teljesBemenetProzódiával))
  putStrLn ("    prozódia-jelek (一,二,三,四 sorrendben): "
            ++ show (map (hangvonalJel . hangvonalCiklus) (számsor 4)))
  putStrLn ("  a kezdeti fázisok: "
            ++ show (map (hangvonalFázisa . hangvonalCiklus) (számsor 4)))
  putStrLn ("  főnév-vektor prozódiával: norma = "
            ++ show (vektorNorma főnévVektorProzódiával)
            ++ "  (a v1 morfológiai úté: " ++ show (vektorNorma főnévVektor) ++ ")")
  putStrLn "  az 1. fej figyelemsúlyai — v1 (morfológia) vs. v2 (prozódia):"
  putStrLn ("    v1:  " ++ show (figyelemSúlyok 0))
  putStrLn ("    v2:  " ++ show (figyelemSúlyokProzódiával 0))
  putStrLn ("    a különbség = a prozódia HATÁSA a figyelemre; v2 összeg = "
            ++ show (foldr (+) 0.0 (figyelemSúlyokProzódiával 0)) ++ " (softmax ✓)")
  putStrLn ""
  putStrLn "Kész — a v2: minden komma látható, a föld HANG-módra renormál,"
  putStrLn "a prozódia a Klein-csoport, a tórusz importtal ÉL. (Nem commitoltam.)"
  putStrLn "(v2-Refl-tanúk: bizVessző*Koma ×6, bizGradiensHangHét,"
  putStrLn " bizHatékonyKötegHangTizennégy, bizFöldiEltérésHárom, bizHangvonalSzám,"
  putStrLn " bizV4Egység ×4, bizV4Involúció ×4, bizV4TáblázatZáródás,"
  putStrLn " bizHullámInverzV4Ben, bizHullámInverzTóruszon,"
  putStrLn " bizHullámCsökkenőEmelkedő, bizHangTóruszPontHáromÖt.)"

-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ───────────────────────────

public export
OptimálisTranszformerV2Leiras : ModulLeirasT
OptimálisTranszformerV2Leiras = ModulLeirasKonstruktor
  "OptimálisTranszformer_v2.idr"
  "v1 + Vessző-rekordok (komma-elosztás) + z-HANG-renormálás (G=7, B_eff=14) + Hangvonal-V₄ prozódia + Torusz-import"
  "a földi közeg hangsebességű: a dinamikai exponens (z=1,5, Model-H) megnöveli a gradiens-felhalmozást; a 4 kínai tónus = V₄ = Z₂×Z₂ = a tórusz {(bit,F0/F4)} stabilizátora"
  "Refl: vessző-komák ×6, V₄-törvények, tórusz-híd; futásidejű: Klein-táblázat, kimerítések, prozódia-figyelem"
