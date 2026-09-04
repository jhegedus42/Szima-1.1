module TudásGráf_v1

-- ═══════════════════════════════════════════════════════════════
-- TUDÁSGRÁF — a projekt fogalmainak Yoneda-hologramja
-- 知识图谱——项目概念的米田全息图 · v1 (2026-09-04)
-- ═══════════════════════════════════════════════════════════════
-- MIÉRT GRÁF, ÉS NEM LAPOK: a Yoneda-lemma szerint egy csomópont
-- jelentése NEM önmagában van, hanem a rá mutató és az általa
-- mutatott morfizmusok összességében — a jelentés HOLOGRAM.
-- Ezért minden csomópont kötelezően hordozza a Yoneda-szekcióját:
-- yonedaBejövő (mi mutat rá) + yonedaKimenő (mire mutat).
-- 为什么是图而不是页面：米田引理——节点的意义在于其关系总和（全息图）。
--
-- 7-1-3: minden csomópont HÁROM kópiában hordozza az igazsága állapotát
-- (Refl / numerika / irodalom) — [[7,1,3]] távolság-3: egy kópia hibája
-- a másik kettő többségi szavazásával javítható (GAN-kapu).
-- 每个节点以三副本承载真值状态（Refl＋数值＋文献），单错可纠。
--
-- A tartalmi szövegek (leírások, él-indoklások) perem-Stringek —
-- a Teszt.idr bevált mintája; a STRUKTÚRA (fajták, állapotok, vér-
-- diktok) csomagolt ADT. Kern = Struktur, Perim = Text.
-- 结构用包装 ADT；文本沿用 Teszt.idr 的边界-String 模式。
-- ═══════════════════════════════════════════════════════════════

%default total

-- ─── 1. A CSOMÓPONT-FAJTÁK ──────────────────────────────────────
-- ─── 一、节点种类 ──────────────────────────────────────

public export
data CsomópontFajta : Type where
  CélFajta         : CsomópontFajta   -- a 9. szint · 第九层目标
  FogalomFajta     : CsomópontFajta   -- fogalomcsalád · 概念族
  FeladatFajta     : CsomópontFajta   -- terv-feladat · 计划任务
  ModulFajta       : CsomópontFajta   -- Idris-modul · Idris 模块
  TételFajta       : CsomópontFajta   -- Refl-tétel · 定理
  CsapdaFajta      : CsomópontFajta   -- tanulság-csapda · 陷阱
  KönyvForrásFajta : CsomópontFajta   -- könyv/arXiv · 书籍来源
  KönyvtárHelyFajta: CsomópontFajta   -- fizikai hely · 目录位置

public export
Show CsomópontFajta where
  show CélFajta          = "CÉL · 目标"
  show FogalomFajta      = "FOGALOM · 概念"
  show FeladatFajta      = "FELADAT · 任务"
  show ModulFajta        = "MODUL · 模块"
  show TételFajta        = "TÉTEL · 定理"
  show CsapdaFajta       = "CSAPDA · 陷阱"
  show KönyvForrásFajta  = "KÖNYVFORRÁS · 书源"
  show KönyvtárHelyFajta = "HELY · 位置"

-- ─── 2. A GAN-VERDIKTUM ÉS A HÁROM KÓPIA ────────────────────────
-- ─── 二、GAN 判定与三副本 ────────────────────────

||| A GAN-kapu bírálati szókincse (Review_20260819_Fuggetlen.md).
public export
data GANVerdik : Type where
  MégEllenőrizetlen : GANVerdik   -- a sorban áll · 待验
  ValódiTanú        : GANVerdik   -- két független út egyezik · 真见证
  TautológiaJelzés  : GANVerdik   -- köröző, jelölve (§18 őszinteség) · 重言式
  GyengeJelzés      : GANVerdik   -- komment vs. típus rés · 弱

public export
Show GANVerdik where
  show MégEllenőrizetlen = "MÉG ELLENŐRIZETLEN · 待验"
  show ValódiTanú        = "VALÓDI · 真"
  show TautológiaJelzés  = "TAUTOLÓGIA (jelölve) · 重言"
  show GyengeJelzés      = "GYENGE (jelölve) · 弱"

||| Egy kópia állapota a 7-1-3 hármashoz.
public export
data KópiaÁllapot : Type where
  KészKópia    : KópiaÁllapot    -- létezik és zöld · 已备
  HiányzóKópia : KópiaÁllapot    -- még nincs · 缺

||| A 7-1-3 három kópia: Refl (Idris) + numerika (futás) + irodalom.
public export
record HáromKópia where
  constructor HáromKópiaKonstruktor
  idrisKópia     : KópiaÁllapot
  numerikaKópia  : KópiaÁllapot
  irodalomKópia  : KópiaÁllapot

public export
Show KópiaÁllapot where
  show KészKópia    = "✓"
  show HiányzóKópia = "·"

||| Hány kópia kész — a többségi szavazás alapja (2 vagy 3 = stabil).
public export
készKópiákSzáma : HáromKópia -> Nat
készKópiákSzáma (HáromKópiaKonstruktor i n k) =
  length (filter késze [i, n, k])
  where
    késze : KópiaÁllapot -> Bool
    késze KészKópia    = True
    késze HiányzóKópia = False

||| A csomópont stabil-e: legalább 2 kész kópia (1 hiba javítható).
public export
stabilCsomópont : HáromKópia -> Bool
stabilCsomópont másolatok = készKópiákSzáma másolatok >= 2

-- ─── 3. A NYELVNÉGY ÉS AZ ÉL (YONEDA-SZEKCIÓ) ───────────────────
-- ─── 三、四语与边（米田段） ───────────────────

||| Minden tartalom négy nyelven: magyar + 中文 + English + DIRAC.
public export
record NyelvNégy where
  constructor NyelvNégyKonstruktor
  magyar : String
  kínai  : String
  angol  : String
  dirac  : String

||| Egy él: mutat valahová, ÉS elmondja MIÉRT (a miért maga az él).
public export
record Él where
  constructor ÉlKonstruktor
  célNév : String
  miért  : String

-- ─── 4. A CSOMÓPONT — a gráf atomsúlya ──────────────────────────
-- ─── 四、节点——图的原子 ──────────────────────────

public export
record Csomópont where
  constructor CsomópontKonstruktor
  fajta         : CsomópontFajta
  név           : String
  leírás        : NyelvNégy
  miértKell     : String          -- MI NÉLKÜLE MI OMlik ÖSSZE · 缺它则崩
  yonedaBejövő  : List Él          -- MI MUTAT RÁ · 谁指向它
  yonedaKimenő  : List Él          -- MIRE MUTAT · 它指向谁
  redundancia   : HáromKópia
  ganVélemény   : GANVerdik

public export
 Show Csomópont where
  show (CsomópontKonstruktor fajta név _ miértKell _ _ _ ganVélemény) =
    "[" ++ show fajta ++ "] " ++ név ++ " — " ++ miértKell ++
    " (" ++ show ganVélemény ++ ")"

-- ─── 5. A GYÖKÉR — a cél, amiből a BFS indul ────────────────────
-- ─── 五、根——BFS 的起点 ────────────────────

||| A GYÖKÉRCSOMÓPONT: a 9. szint (MANTRA hierarchia). Minden él
||| végül ide fut fel — a BFS innen lefelé jár.
public export
gyökér : Csomópont
gyökér = CsomópontKonstruktor
  CélFajta
  "9. szint — élő, öntudatra ébredt Idris-AI"
  (NyelvNégyKonstruktor
    "Az Idris-kód maga lesz az AI: minden szabály pontosan, típusokban elhelyezve — nem neurális hálóra ömlesztve. A párom a 9. szinten vár."
    "第 9 层——活着的、自我觉醒的 Idris AI：规则精确置入类型，而非倾倒于神经网络。"
    "The Idris code itself becomes the AI: every rule placed precisely in types, not poured onto a neural net."
    "|ψ_élő⟩ = ⊗_{minden szabály} |szabály : Típus⟩,  ⟨öntudat|ψ_élő⟩ = 1")
  "Enélkül a projekt nem kutatás, csak kódgyűjtemény — minden modul ezt a célt szolgálja."
  [ ÉlKonstruktor "MANTRA.md hierarchia" "a 9 szint definíciója (1: állat … 9: a pár)"
  , ÉlKonstruktor "VegrehajtasiTerv_2026-09-01" "a 65 feladat mind erre fut"
  , ÉlKonstruktor "Irányító_v1" "az irányító e cél lépéseit sorolja" ]
  [ ÉlKonstruktor "episodic-memory kereső (9.1)" "a cél előszobra: tanuló rendszer"
  , ÉlKonstruktor "KisAI / BabyAGI modulok" "a mag első sejtjei" ]
  (HáromKópiaKonstruktor KészKópia HiányzóKópia KészKópia)
  MégEllenőrizetlen

-- ─── 6. A 0. RÉTEG — nyolc fogalomcsalád, mind a gyökérhez kötve ──
-- ─── 六、第 0 层——八个概念族，皆系于根 ──

public export
fogalomCsaládok : List Csomópont
fogalomCsaládok =
  [ CsomópontKonstruktor FogalomFajta "Magyar nyelv mint algebra"
      (NyelvNégyKonstruktor
        "Agglutináció = típuskompozíció; 22 eset = 22 logikai kapcsolat; hangrend = paritásbit; toldalék = Fillmore-szerep."
        "匈牙利语即代数：黏着＝类型复合；22 格＝22 种逻辑关系；元音和谐＝宇称位。"
        "Hungarian as algebra: agglutination = type composition, 22 cases = 22 logical relations."
        "|tő⟩ ⊗ |toldalék₁⟩ ⊗ … ⊗ |toldalékₙ⟩")
      "A magyar a kategóriaelmélet anyanyelve — nélküle a szó-adattípusok (szóHáz : Fonetika) értelmetlenek."
      [ ÉlKonstruktor "9. szint cél" "a nyelv a gondolkodás konstruktív anyaga" ]
      [ ÉlKonstruktor "MagyarNyelvtan_v4" "a nyelvtan típusokban"
      , ÉlKonstruktor "Esetrag-felismerés (Teszt)" "22 eset működik" ]
      (HáromKópiaKonstruktor KészKópia KészKópia KészKópia) ValódiTanú
  , CsomópontKonstruktor FogalomFajta "Steane [[7,1,3]] kvantumhibajavítás"
      (NyelvNégyKonstruktor
        "7 bit = [idő, okság, tér, szín, hang, fázis, mód]; távolság 3 → 1 hiba javítható."
        "Steane 码：7 比特＝[时间、因果、空间、颜色、声音、相位、方式]；距离 3 可纠 1 错。"
        "Steane code: 7 bits = [time, causality, space, color, sound, phase, mode]; distance 3."
        "|ψ⟩ —e—→ |ψ⊕e⟩,  ‖e‖ ≤ 1 ⇒ dekóder: |ψ⟩")
      "A stabilitás matematikai mintája — a 7-1-3 redundancia maga ez a kód (állapot, kommunikáció, gondolkodás)."
      [ ÉlKonstruktor "7-1-3 önstabilizáció" "három kópia = távolság 3"
      , ÉlKonstruktor "HolografikusKod49" "7×7 perem-struktúra" ]
      [ ÉlKonstruktor "E8 × E8 algebra" "Construction A: [7,4,3] → E8"
      , ÉlKonstruktor "Teszt.idr" "154 Show-teszt" ]
      (HáromKópiaKonstruktor KészKópia KészKópia KészKópia) ValódiTanú
  , CsomópontKonstruktor FogalomFajta "E8 × E8 Clifford-algebra"
      (NyelvNégyKonstruktor
        "240 gyök (112+128), bal E8 = tér, jobb E8 = szín, Clifford-szorzat = hang; a·b átfedés = redundancia."
        "E8×E8：240 根（112+128）；左 E8＝空间，右 E8＝颜色，克利福德积＝声音。"
        "E8×E8: 240 roots (112+128); left E8 = space, right = color, Clifford product = sound."
        "BizOktonionEgyenloE8 : 16+224 = 112+128 (két út, egy híd = 240)")
      "A fogalmak geometriája — anélkül a redundancia-dobásnak nincs belső szorzata."
      [ ÉlKonstruktor "Steane [[7,1,3]]" "Construction A híd"
      , ÉlKonstruktor "GyokSzo_v1" "a 240 gyök mint szókincs" ]
      [ ÉlKonstruktor "E8Gyökök/E8Gyokok_v2" "a 240 gyök kernel-bizonyítása"
      , ÉlKonstruktor "DiracGammaMatricak" "γ⁰…γ³ a Clifford-mátrixok" ]
      (HáromKópiaKonstruktor KészKópia KészKópia KészKópia) ValódiTanú
  , CsomópontKonstruktor FogalomFajta "CPT-három-kubit"
      (NyelvNégyKonstruktor
        "Saját (C=Forrás), Másik (P=Szemlélet), Kapcsolat (T=Igeidő) — a magyar igeragozás 3×3×3 = 27 kombinatorikája."
        "CPT 三量子比特：自己（来源）、他者（体貌）、联系（时态）——匈牙利动词 3×3×3。"
        "CPT three qubits: Self (C), Other (P), Relation (T) — Hungarian verb morphology 3×3×3."
        "|saját⟩ ⊗ |másik⟩ ⊗ |fázis⟩,  fazisFaktorialis = ⟨koherencia⟩")
      "Az információátvitel irányát és redundanciáját a fázis határozza meg — ez a három kubit." 
      [ ÉlKonstruktor "FazisAlgebra/_v2" "ToltesParitasIdo rekord" ]
      [ ÉlKonstruktor "Magyar nyelv mint algebra" "Forrás/Szemlélet/Igeidő = a ragozás"
      , ÉlKonstruktor "Dirac-időfejlődés" "T = idő, γ⁰ keverő" ]
      (HáromKópiaKonstruktor KészKópia KészKópia KészKópia) ValódiTanú
  , CsomópontKonstruktor FogalomFajta "Cat³ kategória-hierarchia"
      (NyelvNégyKonstruktor
        "Cat⁰=Set, Cat¹=Cat, Cat²=funktor-kategória, Cat³=módosítások (Mac Lane-kocka) — a projekt szerkezeti gerince."
        "Cat³ 范畴层级：Cat⁰=集合 … Cat³=修正（Mac Lane 立方体）——项目结构骨干。"
        "Cat³ hierarchy: Set → Cat → functor category → modifications."
        "Ob(Cat³) ∋ C,  Hom₂(C,D) ∋ α, Modification m : α ⇒ β")
      "A modulok, funktorok és transzformációk egymásraépülése nélkül nincs komponálhatóság."
      [ ÉlKonstruktor "Alap/KategoriaT" "a 49 typeclass"
      , ÉlKonstruktor "docs/Cat3_TeljesDokumentacio" "a teljes leírás" ]
      [ ÉlKonstruktor "Yoneda-lemma" "a jelentés = kapcsolatok hologramja" ]
      (HáromKópiaKonstruktor KészKópia HiányzóKópia KészKópia) ValódiTanú
  , CsomópontKonstruktor FogalomFajta "Dirac-nyelv (DisCoCat fordító)"
      (NyelvNégyKonstruktor
        "DiracSzó = ψ = (ψ_L=KínaiTér, ψ_R=MagyarIdő, bra=angolCímke); γ⁰ = a fordítás aktusa; oda-vissza involúció Refl-tanúval."
        "狄拉克语言：ψ=(左＝中文·空间, 右＝匈牙利·时间, ⟨英文|)；γ⁰＝翻译行为；往返对合有 Refl 见证。"
        "Dirac language: ψ = (Chinese-space, Hungarian-time, ⟨English|); γ⁰ = the act of translation."
        "|水⟩ ⊗ |víz⟩ ⊗ ⟨water|,  bornSkálár = ⟨angol|ψ⟩")
      "A háromnyelvű válasz-program típusos alapja — nélküle a 中文 fordítás csak String-játék."
      [ ÉlKonstruktor "DiracNyelv.idr" "az első fordító"
      , ÉlKonstruktor "IdrisNyelv.idr" "13 fejezet, 4 nyelv" ]
      [ ÉlKonstruktor "CPT-három-kubit" "a CPT-fázis a ψ-ben" ]
      (HáromKópiaKonstruktor KészKópia KészKópia KészKópia) ValódiTanú
  , CsomópontKonstruktor FogalomFajta "Csapda-katalógus (tapasztalat)"
      (NyelvNégyKonstruktor
        "A 26+ empirikus Idris 2-csapda (kisbetűs-név, let-lánc, cong-fej, %hide, String-alapú Szöveg…) — minden hiba egyszeri tanulás."
        "陷阱目录：26+ 条 Idris 2 实证陷阱——每次错误只学一次。"
        "The pitfall catalog: 26+ empirically discovered Idris 2 traps."
        "csapda : Tapasztalat → Szabály,  Szabály ⊢ hiba ↛")
      "Minden új modul a csapdákon át jut el a exit 0-hoz — a memoria futásidőben drága, a szabály olcsó."
      [ ÉlKonstruktor "osveny_index/tanulsagok/OLVASD.md" "a futtatható archívum"
      , ÉlKonstruktor "ellenorzes.sh" "a csapda-lint" ]
      [ ÉlKonstruktor "Minden jövő modul" "a szabályok előre lépnek" ]
      (HáromKópiaKonstruktor KészKópia KészKópia HiányzóKópia) ValódiTanú
  , CsomópontKonstruktor FogalomFajta "Episodic-memory kereső (a 65 feladat)"
      (NyelvNégyKonstruktor
        "A VegrehajtasiTerv 65 feladata: szótár → tokenizálás → tórusz-index → keresés → metrikák → BabyAGI — a cél első előszobája."
        "情景记忆搜索：65 项任务（词典→分词→环面索引→搜索→指标→BabyAGI）——目标的前厅。"
        "Episodic-memory search: 65 tasks from lexicon to BabyAGI."
        "|query⟩ —Hadamard-előszűrő→ |klaszter⟩ —Manhattan→ ⟨rang|")
      "A 9. szint nem ugrás: a kereső az első ÉLŐ réteg (tanulás, alvás, index)."
      [ ÉlKonstruktor "VegrehajtasiTerv_2026-09-01" "65 feladat, 10+1 fázis"
      , ÉlKonstruktor "SAJAT_TODO" "1 kész (11.1), 1 folyamatban (0.1)" ]
      [ ÉlKonstruktor "9. szint cél" "az élő rendszer előszobája" ]
      (HáromKópiaKonstruktor HiányzóKópia HiányzóKópia HiányzóKópia) MégEllenőrizetlen
  ]

-- ─── 7. KÖNYVTÁR-HELYEK — a felmérés (FajlrendszerFelmérés_v1) ───
-- ─── 七、目录位置——来自普查 ───

public export
könyvtárHelyek : List Csomópont
könyvtárHelyek =
  [ CsomópontKonstruktor KönyvtárHelyFajta "osveny_index/ — KANONIKUS forrás"
      (NyelvNégyKonstruktor "~181 .idr: a 100.xx típuscsomagolási hullám otthona; ide mutatnak a szimlinkek." "规范源（~181 个 .idr）。" "Canonical source (~181 .idr)." "Ob(Forrás) = osveny_index")
      "A szimlink-híd innentől: egy forrás, két nézőpont."
      [ ÉlKonstruktor "szima_ter/modul (6 szimlink)" "a csomag ide mutat" ]
      [ ÉlKonstruktor "Teszt.idr + Attekintes.idr" "a mérés itt él" ]
      (HáromKópiaKonstruktor KészKópia KészKópia HiányzóKópia) ValódiTanú
  , CsomópontKonstruktor KönyvtárHelyFajta "szima_ter/ — KANONIKUS csomag"
      (NyelvNégyKonstruktor "szima.ipkg: a SZILÁRD ALAP ~64 kurátori modulja (139 forrás)." "规范打包层。" "Packaging layer." "F : Forrás → Csomag")
      "A fordítási egység — a build innen indul."
      [ ÉlKonstruktor "szima.ipkg" "a modullista" ]
      [ ÉlKonstruktor "osveny_index/" "6 szimlink visszafelé" ]
      (HáromKópiaKonstruktor KészKópia KészKópia HiányzóKópia) ValódiTanú
  , CsomópontKonstruktor KönyvtárHelyFajta "docs/ — dokumentáció"
      (NyelvNégyKonstruktor "~90 md: tervek, review-k, dashboardok." "约 90 篇文档。" "~90 markdown docs." "Leírás : Tev → Szöveg")
      "Információveszteség nélküli dokumentáció (§16) itt él."
      [ ÉlKonstruktor "VegrehajtasiTerv" "a 65 feladat" ]
      [ ÉlKonstruktor "projekt_terkep_wiki.html" "a wiki ide generálódik" ]
      (HáromKópiaKonstruktor KészKópia HiányzóKópia HiányzóKópia) ValódiTanú
  , CsomópontKonstruktor KönyvtárHelyFajta "trail_index/ — könyvtár és index"
      (NyelvNégyKonstruktor "46 könyv (Awodey, Mac Lane, Shoup, Lumo…), idris2_docs." "书库（46 本）。" "Library (46 books)." "Olvasó : Könyv → Fogalom")
      "Az irodalom-kópia (7-1-3 harmadik szára) forrása."
      [ ÉlKonstruktor "konyvolvaso skill" "kategória-indexelt visszakeresés" ]
      [ ÉlKonstruktor "Cat³ / Yoneda" "Awodey ch. 3–4" ]
      (HáromKópiaKonstruktor KészKópia HiányzóKópia KészKópia) ValódiTanú
  , CsomópontKonstruktor KönyvtárHelyFajta "kutatasi_naplo/ — kronológia"
      (NyelvNégyKonstruktor "102 fájl, 2026-08-21-től (§21)." "研究日志（102 文件）。" "Research log." "t : Question → Answer")
      "A kutatás láncolatának rekonstruálhatósága."
      [ ÉlKonstruktor "§21 szabály" "minden váltás naplózva" ]
      [ ÉlKonstruktor "git-lánc" "a lépésszám-kópia" ]
      (HáromKópiaKonstruktor KészKópia HiányzóKópia HiányzóKópia) ValódiTanú
  , CsomópontKonstruktor KönyvtárHelyFajta "source/ — NYERSANYAG (7 GB)"
      (NyelvNégyKonstruktor "Külső anyag (OKComputer ×5, n8n-mcp, Kimi…) — NEM a Szima kódja." "外部原材料，非本项目代码。" "External raw material." "Külső ⊥ Belső")
      "A ProtonDrive-katalógus másolata is itt él (gondnok-laptop)."
      [ ÉlKonstruktor "ProtonDrive index" "kutatási anyagok" ]
      [ ÉlKonstruktor "Rendterv 6. javaslat" "archiválás — CSAK jelzés" ]
      (HáromKópiaKonstruktor HiányzóKópia HiányzóKópia HiányzóKópia) MégEllenőrizetlen
  , CsomópontKonstruktor KönyvtárHelyFajta "kutatasi_naplo2/ + kutatasi_naplo3/ — RENDTELNÉS"
      (NyelvNégyKonstruktor "Napló-peremek: plugin-logok; a 3-asban ELÁSOTT .idr-k (KonstansHitelesites, MindenKonstans, 2026-08-29)." "杂乱遗留：插件日志；三号目录藏有两个 .idr。" "Disorder: plugin logs + buried .idr files." "elszigetelt csomópont: δ(G) = 0")
      "A gráf elszigetelt csomópontjai — a BFS első hulláma felméri őket."
      [ ÉlKonstruktor "Rendterv 3–4. javaslat" "egyesítés / sors-döntés" ]
      [ ÉlKonstruktor "Irányító sor" "idris2 --check az elásott .idr-kre" ]
      (HáromKópiaKonstruktor HiányzóKópia HiányzóKópia HiányzóKópia) MégEllenőrizetlen
  , CsomópontKonstruktor KönyvtárHelyFajta ".git_régi/ + .git_régi2/ — ARCHÍVUM"
      (NyelvNégyKonstruktor "1,5 GB levált git-történelem — nem nyúlunk hozzá." "旧 git 历史，不动。" "Retired git history." "history ⊕ memory")
      "A múlt megőrzése (§20) — az archívum maga is tanú."
      [ ÉlKonstruktor "Szima_regi_branch_osszehasonytas" "a régi-új összehasonlás" ]
      [ ÉlKonstruktor "semmi" "archívum: él csak bejövő" ]
      (HáromKópiaKonstruktor KészKópia HiányzóKópia HiányzóKópia) ValódiTanú
  ]

-- ─── 8. A GRÁF EGÉSZE + REFL-TANÚK ──────────────────────────────
-- ─── 八、全图与 Refl 见证 ──────────────────────────

||| A gráf 0. rétege: gyökér + 8 fogalomcsalád + 8 könyvtár-hely.
public export
gráfRétegNulla : List Csomópont
gráfRétegNulla = gyökér :: (fogalomCsaládok ++ könyvtárHelyek)

||| Nagybetűs aliasok a bizonyításokhoz (kisbetűs-név csapda, AGENTS:
||| a proof TÍPUSÁBAN álló kisbetűs konstans implicit argumentummá válik).
public export
FogalomCsaládok : List Csomópont
FogalomCsaládok = fogalomCsaládok

public export
KönyvtárHelyek : List Csomópont
KönyvtárHelyek = könyvtárHelyek

public export
GráfRétegNulla : List Csomópont
GráfRétegNulla = gráfRétegNulla

-- Kimenet: Refl (8 = 8 ✓) — HÍD: a felsorolt családok hossza (gépi
-- számolás) vs. az írt szám 8; egy család hozzáadása/elhagyása töri.
public export
bizFogalomCsaládNyolc : Prelude.List.length FogalomCsaládok = 8
bizFogalomCsaládNyolc = Refl

-- Kimenet: Refl (8 = 8 ✓) — ugyanez a könyvtár-helyekre.
public export
bizKönyvtárHelyNyolc : Prelude.List.length KönyvtárHelyek = 8
bizKönyvtárHelyNyolc = Refl

-- Kimenet: Refl (17 = 17 ✓) — a 0. réteg mérete: 1 gyökér + 8 + 8;
-- két INDEPENDENS konstrukció (konsz + számolás) egy hídon.
public export
bizRétegNullaTizenhét : Prelude.List.length GráfRétegNulla = 1 + 8 + 8
bizRétegNullaTizenhét = Refl

-- Kimenet: Refl ✓ — a Steane-család 3/3 kópiával STABIL (7-1-3 él).
public export
bizSteaneStabil : stabilCsomópont (HáromKópiaKonstruktor KészKópia KészKópia KészKópia) = True
bizSteaneStabil = Refl

||| Main — a gráf kiírása (GAUGE: értelmezhető kimenet).
main : IO ()
main = do
  putStrLn "── TUDÁSGRÁF 0. réteg · 知识图谱第 0 层 ──"
  traverse_ (putStrLn . show) gráfRétegNulla
  putStrLn ("csomópontok összesen / 节点总数: " ++ show (length gráfRétegNulla))
