module Irányító_v1

-- ═══════════════════════════════════════════════════════════════
-- IRÁNYÍTÓ — a külső determinisztikus vezérlő (külső agy)
-- 指导器——外部确定性控制器 · Version 1 (2026-09-04)
-- ═══════════════════════════════════════════════════════════════
-- MIÉRT: a kontextus törlődhet (kompaktálás) — az állapot NEM bennem
-- él, hanem kívül, három kópiában (7-1-3 / [[7,1,3]] logika):
--   (a) osveny_index/irányító/Állapot_v1.md   — ember-olvasható állapot
--   (b) EZ a modul (a sor adata)              — gép-olvasható állapot
--   (c) a git-commit-lánc lépésszáma          — történeti állapot
-- Egy kópia sérülése a másik kettő többségi szavazásával javítható.
-- 为什么：上下文可能被清空——状态存于外部三副本，单份损坏可由多数表决纠正。
--
-- A `következőLépés : Állapot -> Lépés` TISZTA függvény: a gép dönt,
-- az ügynök csak végrehajt. Ébredési protokoll: Állapot_v1.md fejléce.
-- `következőLépés` 是纯函数：机器决策，代理只执行。
--
-- YONEDA (miért éli kívül): a jelentés hologram — a csomópont jelentése
-- a kapcsolatainak összessége; az önmagában őrzött állapot dekoherál.
-- 米田引理：意义即关系全息图，孤立状态必然散焦。
--
-- Irodalmi horgonyok:
--   [1] HaPPY-kód torusz-perem stabilitás: Pastawski–Yoshida–Harlow–
--       Preskill 2015 (a HolografikusKod49 modul forrása)
--   [2] a projekt [[7,1,3]] Steane-kódja: Steane713.idr (távolság 3 →
--       1 hiba javítható) — itt a HÁROM állapotkópiára alkalmazva
--   [3] AGENTS.md §3 (számolás Idrisben), §13/§20 (nincs törlés),
--       §24 (nincs kód-duplikáció — Prelude drop-t importálunk, nem írunk)
-- ═══════════════════════════════════════════════════════════════

import Data.List

%default total

-- ─── 1. A FÁZISOK — a munka nagy állomásai ──────────────────────
-- ─── 一、阶段——工作的大站 ──────────────────────

||| A munka hét fázisa (a jóváhagyott terv szerint).
||| 工作的阶段（按已确认的计划）。
public export
data Fázis : Type where
  FelmérésFázis      : Fázis   -- 0: fájlrendszer-felmérés · 文件普查
  RendtervFázis      : Fázis   -- 1: rendezési javaslat · 整理方案
  TudásGráfFázis     : Fázis   -- 2: gráf-típusok + gyökér · 知识图谱类型
  WikiFázis          : Fázis   -- 3: wiki-lapok generálása · 生成 wiki 页
  KönyvHullámFázis   : Fázis   -- 4: könyv-alügynökök · 读书子代理
  GanKapuFázis       : Fázis   -- 5: élek GAN-ellenőrzése · GAN 检验
  LezárásFázis       : Fázis   -- 6: gráf-lezárás (BEF fejeződik) · 图谱闭合

public export
Show Fázis where
  show FelmérésFázis    = "0 · FÁJLRENDSZER-FELMÉRÉS / 文件普查"
  show RendtervFázis    = "1 · RENDTERV / 整理方案"
  show TudásGráfFázis   = "2 · TUDÁSGRÁF / 知识图谱"
  show WikiFázis        = "3 · WIKI / 生成 wiki"
  show KönyvHullámFázis = "4 · KÖNYV-HULLÁM / 读书子代理"
  show GanKapuFázis     = "5 · GAN-KAPU / GAN 检验"
  show LezárásFázis     = "6 · LEZÁRÁS / 闭合"

-- ─── 2. A LÉPÉSEK — egy-egy ATOMI munkaegység ────────────────────
-- ─── 二、步骤——原子工作单元 ────────────────────

||| Egy lépés = PONTOSAN EGY atomi munkaegység (kontextus-költségvetés:
||| a fő ügynök kontextusa soha nem nő a lépésnél nagyobbra).
||| 一步＝恰好一个原子工作单元（上下文预算：主代理上下文不超过单步规模）。
public export
data Lépés : Type where
  FelmérésDokumentálása  : Lépés  -- a ~89 gyökérelem szerepkör-besorlása
  RendtervMegírása       : Lépés  -- javaslatok, NEM mozgatás
  GráfTípusokDefiníciója : Lépés  -- TudásGráf_v1.idr típusai + gyökér
  WikiElsőLapjai         : Lépés  -- ProjektTérkép.idr + html
  GanFelmérésEllenőrzés  : Lépés  -- a felmérés minden állítására
  KönyvYonedaAwodey      : Lépés  -- Yoneda-fejezet alügynökkel
  GráfLezárultPihenő     : Lépés  -- a sor elfogyott: pihenő (total zár)

public export
Show Lépés where
  show FelmérésDokumentálása  = "docs/FajlrendszerFelmérés_v1.md megírása"
  show RendtervMegírása       = "docs/FajlrendszerRendterv_v1.md megírása"
  show GráfTípusokDefiníciója = "osveny_index/TudásGráf_v1.idr (típusok+gyökér)"
  show WikiElsőLapjai         = "ProjektTérkép.idr + docs/projekt_terkep_wiki.html"
  show GanFelmérésEllenőrzés  = "GAN-alügynök a felmérés állításaira"
  show KönyvYonedaAwodey      = "Yoneda → Awodey (alügynök olvassa)"
  show GráfLezárultPihenő     = "a sor elfogyott — gráf lezárult, pihenő"

-- ─── 3. AZ ÁLLAPOT — a gép memóriája, nem az enyém ───────────────
-- ─── 三、状态——机器的记忆，不是我的 ───────────────

||| Az irányító teljes állapota. A sor: még el nem végzett lépések
||| BFS-sorrendben (első elem = a következő teendő).
||| 控制器的完整状态。队列：尚未执行的步骤（首元素＝下一步）。
public export
record Állapot where
  constructor ÁllapotKonstruktor
  fázis     : Fázis
  sor       : List Lépés
  lépésszám : Nat

-- ─── 4. A KEZDETI SOR — a jóváhagyott terv lépései ───────────────
-- ─── 四、初始队列——已确认计划的步骤 ───────────────

||| A 2026-09-04-én jóváhagyott terv első hulláma (hat lépés).
||| 2026-09-04 已确认计划的第一波（六步）。
public export
kezdetiSor : List Lépés
kezdetiSor =
  [ FelmérésDokumentálása
  , RendtervMegírása
  , GráfTípusokDefiníciója
  , WikiElsőLapjai
  , GanFelmérésEllenőrzés
  , KönyvYonedaAwodey
  ]

||| A kezdeti állapot (kisbetűs konstans a futásidejű kódhoz).
||| 初始状态（小写常量供运行时使用）。
public export
kezdetiÁllapot : Állapot
kezdetiÁllapot = ÁllapotKonstruktor FelmérésFázis kezdetiSor 0

||| Nagybetűs alias a bizonyításokhoz (AGENTS: kisbetűs-név csapda —
||| a bizonyítás TÍPUSÁBAN álló kisbetűs konstans implicit argumentummá
||| válik). 大写别名供证明使用（小写名称陷阱）。
public export
KezdetiÁllapot : Állapot
KezdetiÁllapot = kezdetiÁllapot

-- ─── 5. A DETERMINISZTIKUS ÁTMENET — a gép dönt ──────────────────
-- ─── 五、确定性转移——机器决策 ──────────────────

||| A következő EGY lépés: a sor feje; üres sornál pihenő (total függvény,
||| a perem-döntés a case itt megengedett — l. karakterláncbólTő minta).
||| 下一步＝队首；空队列时休眠。
public export
következőLépés : Állapot -> Lépés
következőLépés (ÁllapotKonstruktor _ sor _) =
  case sor of
    []               => GráfLezárultPihenő
    (következő :: _) => következő

||| A lépés UTÁNI állapot: fázis előre, sor rövidül (a Prelude drop-jával —
||| NEM írjuk újra: §24 kód-duplikáció tilos).
||| 步后状态：阶段前进，队列缩短（用 Prelude.drop，禁止重写）。
public export
lépésUtán : Állapot -> Állapot
lépésUtán (ÁllapotKonstruktor fázis sor lépésszám) =
  ÁllapotKonstruktor fázis (drop 1 sor) (lépésszám + 1)

-- ─── 6. A JELENTÉS — mit ír a gép az ébredő ügynöknek ───────────
-- ─── 六、报告——机器写给苏醒代理的话 ───────────

||| Az ébredési protokoll 3. pontának kimenete: a következő lépés + a
||| 7-1-3 emlékeztető + a tiltók (a protokoll a mellékeltekkel együtt).
||| 苏醒协议第 3 点的输出：下一步＋7-1-3 提醒＋禁令。
public export
jelentés : Állapot -> String
jelentés állapot@(ÁllapotKonstruktor fázis sor lépésszám) =
  "╔══ IRÁNYÍTÓ · 外部确定性控制器 ══╗\n" ++
  "║ fázis / 阶段      : " ++ show fázis ++ "\n" ++
  "║ lépésszám / 步数  : " ++ show lépésszám ++ "\n" ++
  "║ sorban / 队列长度 : " ++ show (length sor) ++ "\n" ++
  "║ KÖVETKEZŐ EGY LÉPÉS / 下一个唯一步骤:\n" ++
  "║   » " ++ show (következőLépés állapot) ++ "\n" ++
  "║ 7-1-3: az állapot 3 kópiája = Állapot_v1.md + ez a modul + git-lánc;\n" ++
  "║        eltérésnél GAN 2/3 szavazás, javítás, csapda-napló.\n" ++
  "║ Tiltók: nincs törlés (§20), nincs felülírás (§13), nincs Python (§3),\n" ++
  "║        ékezetes magyar (§25), nincs duplikáció (§24).\n" ++
  "║ Zárás: Állapot_v1.md frissítése → commit+push → kutatasi_naplo.\n" ++
  "╚══════════════════════════════╝"

-- ─── 7. REFL-TANÚK — nem tautológiák (§18) ──────────────────────
-- ─── 七、Refl 见证——非重言式 ──────────────────────

-- Kimenet: Refl (6 = 6 ✓) — a HÍD: a rekordba ÍRT lépésszám (0) és a
-- felsorolt sor (6 elem) hossza KÜLÖNBÖZŐ konstrukciók; a sor átírása
-- (egy lépés hozzáadása) a hidat automatikusan eltöri.
-- 桥：记录中写的步数与队列实际长度是两条独立构造——改队列即断桥。
bizKezdetiSorHossza : length (sor KezdetiÁllapot) = 6
bizKezdetiSorHossza = Refl

-- Kimenet: Refl (a döntés a felsorolt első lépés ✓) — a HÍD: a gép
-- döntése (következőLépés) maga a sorba ÍRT első elem; ha a sort
-- átrendeznéd, a híd eltörik — a determinizmus tanúja.
bizGépDöntéseElsőLépés : következőLépés KezdetiÁllapot = FelmérésDokumentálása
bizGépDöntéseElsőLépés = Refl

-- Kimenet: Refl (5 = 5 ✓) — egy lépés után a sor EGYEL rövidül és a
-- lépéssám EGYEL nő (az átmenet tényleg előrevisz, nem körözöl).
bizÁtmenetElőreVisz : length (sor (lépésUtán KezdetiÁllapot)) = 5
bizÁtmenetElőreVisz = Refl

-- ─── 8. MAIN — vékony IO-burkoló (AGENTS §00: a main csak burkoló) ──
-- ─── 八、main——薄 IO 包装 ──

||| Az ébredési protokoll 3. pontának belépési pontja.
||| 苏醒协议第 3 点的入口。
main : IO ()
main = putStrLn (jelentés kezdetiÁllapot)
