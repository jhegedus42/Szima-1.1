module IdrisNyelv

-- ═══════════════════════════════════════════════════════════════
-- IDRIS NYELV — a hivatalos gyorstalap (13 fejezet) négynyelvű
-- enciklopédiája: magyar + 中文 + English + DIRAC bra-ket.
-- 官方速成教程（十三章）的四语百科：匈语+中文+英语+狄拉克括号。
-- Source: https://idris2.readthedocs.io/en/latest/tutorial/index.html
-- (CC0 — The Idris Community) — MIND a 13 oldal elolvasva 2026-09-03.
-- Társ-skill: ~/.agents/skills/idris-nyelv/SKILL.md
-- ═══════════════════════════════════════════════════════════════

import Steane713
import Alap.CsomagoltTipusok
import DiracNyelv

-- ─── 1. A TIZENHÁROM FEJEZET ────────────────────────────────
-- 一、十三章 ────────────────────────
-- A tutorial rekurzívan bejárt váza; minden fejezet egy TÉMA.
-- 教程的骨架；每章是一个主题。

public export
data IdrisFejezet
  = Bevezetés               -- Introduction    / 导论
  | Indulás                 -- Getting Started / 起步
  | TípusokÉsFüggvények     -- Types & Funct.  / 类型与函数
  | Interfészek             -- Interfaces      / 接口
  | ModulokÉsNévterek       -- Modules & N.    / 模块与命名空间
  | Multiplicitások         -- Multiplicities  / 数量
  | Csomagok                -- Packages        / 包
  | JólTípusozottÉrtelmező  -- W-T Interpreter / 良类型解释器
  | NézetekÉsWithSzabály    -- Views & with    / 视图与 with 规则
  | TételBizonyítás         -- Theorem Proving / 定理证明
  | InteraktívSzerkesztés   -- Inter. Editing  / 交互编辑
  | Vegyesek                -- Miscellany      / 杂项
  | TovábbiOlvasmányok      -- Further Reading / 延伸阅读

-- ─── 2. A KULCSSZAVAK (a TRIGGER forrása) ───────────────────
-- 二、关键词（触发源）────────────────
-- Ha e szavak bármelye felmerül, a trigger a fejezethez visz.
-- 这些词一出现，触发器就带我们去相应章节。

public export
data IdrisKulcsszó
  = InterfaceSzó     -- interface / 接口
  | ElrejtésSzó     -- %hide, hiding / 隐藏
  | LyukSzó          -- ?hole, :cs, :ps / 洞
  | ReflSzó          -- Refl, cong, rewrite / 证明
  | WithSzó          -- with, view / 视图
  | TöröltSzó        -- (0 x : …) / 擦除
  | RekordSzó        -- record, := / 记录
  | TeljesSzó        -- total, covering / 完全性
  | IOSzó            -- do, IO, pure / 输入输出
  | ModulSzó        -- module, import / 模块

-- ─── 3. A TRIGGER-FUNKTOR ───────────────────────────────────
-- 三、触发函子 ────────────────────
-- IdrisKulcsszó kategória → IdrisFejezet kategória: a kérdés
-- kulcsszava MEGHATÁROZZA, melyik fejezet törzse hívódik elő.
-- 关键词范畴→章节范畴：问题的关键词决定召唤哪一章。
-- DIRAC: ⟨kulcsszó|fejezet⟩ — a trigger = a projekció operátora.

public export
trigger : IdrisKulcsszó -> IdrisFejezet
trigger InterfaceSzó = Interfészek
trigger ElrejtésSzó = ModulokÉsNévterek
trigger LyukSzó      = InteraktívSzerkesztés
trigger ReflSzó      = TételBizonyítás
trigger WithSzó      = NézetekÉsWithSzabály
trigger TöröltSzó    = Multiplicitások
trigger RekordSzó    = TípusokÉsFüggvények
trigger TeljesSzó    = TípusokÉsFüggvények
trigger IOSzó        = TípusokÉsFüggvények
trigger ModulSzó    = ModulokÉsNévterek

-- ─── 4. A NÉGYNYELVŰ SZABÁLY (bra-ket) ──────────────────────
-- 四、四语规则（bra-ket）──────────────
-- A DIRAC-forma: a bra = az ELVÁRÁS (állítás/törvény), a ket = a
-- MEGVALÓSÍTÁS (program/instance); a szorzat = az ÁTFEDÉS.
-- DIRAC 形式：bra=期望（陈述/定律），ket=实现（程序/实例）；
-- 乘积=重叠。

public export
record DiracSzabály where
  constructor DiracSzabályKonstruktor
  magyarTorzó, kínaiTorzó, angolTorzó : Szöveg
  bra, ket : Szöveg

public export
példaSzabály : DiracSzabály
példaSzabály = DiracSzabályKonstruktor
  (karakterláncbólTő "a típus állít, a program bizonyít")
  (karakterláncbólTő "类型陈述，程序证明")
  (karakterláncbólTő "the type states, the program proves")
  (karakterláncbólTő "állítás")
  (karakterláncbólTő "bizonyítás")

-- ─── 5. TANÚK (Refl — a fordító a bíra) ─────────────────────
-- 五、见证（Refl——编译器即裁判）────────────
-- Kimenet: Refl (✓)
-- 输出：Refl（✓）

bizTriggerElrejtésAModulokhoz : trigger ElrejtésSzó = ModulokÉsNévterek
bizTriggerElrejtésAModulokhoz = Refl

bizTriggerReflATételekhez : trigger ReflSzó = TételBizonyítás
bizTriggerReflATételekhez = Refl

-- CSAPDA #26 (élő példa): a karakterláncbólTő a PRIMITÍV String-et dolgozza
-- fel, ami fordítási időben NEM redukálható — ezért a belőle épített Szöveg
-- egyenlősége NEM Refl-zárható (definicionális vs. propozicionális!).
-- 陷阱 #26（活例）：karakterláncbólTő 处理原始 String，编译期不可归约——
-- 由此构建的 Szöveg 的相等性不能用 Refl 闭合。
-- Ezért a tanú KÖZVETLEN, definicionálisan redukáló konstrukción áll:
-- 因此见证站在直接、定义上可归约的构造上：
bizÜresSzövegÖnmagávalEgyenlő : szövegEgyenlő ÜresSzöveg ÜresSzöveg = Igaz
bizÜresSzövegÖnmagávalEgyenlő = Refl

-- GAN-javasolt új tanúk (2026-09-03):
-- GAN 建议的新见证：
bizTriggerWithANézetekhez : trigger WithSzó = NézetekÉsWithSzabály
bizTriggerWithANézetekhez = Refl

-- A tanú-élet kiírója: a Tanú MAGA lakja meg a típust.
-- 见证之生：见证本身居住在类型里。
-- DIRAC: ⟨típus|tanú⟩ : Tanú — az átfedés ÉRTÉKE típus!
public export
tanúÉl : {elvárt, tényleges : IdrisFejezet} -> elvárt = tényleges -> String
tanúÉl Refl = "Refl ✓ (⟨típus|tanú⟩ : Tanú)"

-- ─── 6. FEJEZET-NÉV TÁBLÁZAT (négynyelvű kiírás) ────────────
-- 六、章节名表（四语输出）────────────

public export
fejezetMagyarNév : IdrisFejezet -> String
fejezetMagyarNév Bevezetés              = "Bevezetés (types are first class)"
fejezetMagyarNév Indulás                = "Indulás (REPL, --check, -o)"
fejezetMagyarNév TípusokÉsFüggvények    = "Típusok és függvények (Vect, Fin, DPair, rekord, IO)"
fejezetMagyarNév Interfészek            = "Interfészek (instance=törvény-bizonyítás)"
fejezetMagyarNév ModulokÉsNévterek      = "Modulok (private/export/public export; %hide!)"
fejezetMagyarNév Multiplicitások        = "Multiplicitások (QTT: 0=törölt, 1=lineáris)"
fejezetMagyarNév Csomagok               = "Csomagok (.ipkg, modules, -p)"
fejezetMagyarNév JólTípusozottÉrtelmező = "Jól típusozott értelmező (nyelv embedelése)"
fejezetMagyarNév NézetekÉsWithSzabály   = "Nézetek és with-szabály (a minta visszahat)"
fejezetMagyarNév TételBizonyítás        = "Tételbizonyítás (Refl/cong/rewrite/totality)"
fejezetMagyarNév InteraktívSzerkesztés  = "Interaktív szerkesztés (:cs :ps :am :mw)"
fejezetMagyarNév Vegyesek               = "Vegyesek (auto/default implicit, univerzumok)"
fejezetMagyarNév TovábbiOlvasmányok     = "További olvasmányok (Brady, Höck)"

public export
fejezetKínaiNév : IdrisFejezet -> String
fejezetKínaiNév Bevezetés              = "导论（类型是第一等的）"
fejezetKínaiNév Indulás                = "起步（REPL、--check、-o）"
fejezetKínaiNév TípusokÉsFüggvények    = "类型与函数（Vect、Fin、依赖对、记录、IO）"
fejezetKínaiNév Interfészek            = "接口（实例=定律的证明）"
fejezetKínaiNév ModulokÉsNévterek      = "模块与命名空间（private/export/public export；%hide！）"
fejezetKínaiNév Multiplicitások        = "数量（QTT：0=擦除、1=线性）"
fejezetKínaiNév Csomagok               = "包（.ipkg、modules、-p）"
fejezetKínaiNév JólTípusozottÉrtelmező = "良类型解释器（用类型嵌入语言）"
fejezetKínaiNév NézetekÉsWithSzabály   = "视图与 with 规则（模式反作用于其他参数）"
fejezetKínaiNév TételBizonyítás        = "定理证明（Refl/cong/rewrite/完全性）"
fejezetKínaiNév InteraktívSzerkesztés  = "交互编辑（:cs :ps :am :mw）"
fejezetKínaiNév Vegyesek               = "杂项（auto/default 隐式、宇宙层级）"
fejezetKínaiNév TovábbiOlvasmányok     = "延伸阅读（Brady、Höck）"

public export
fejezetAngolNév : IdrisFejezet -> String
fejezetAngolNév Bevezetés              = "Introduction (types are first class)"
fejezetAngolNév Indulás                = "Getting Started (REPL, --check, -o)"
fejezetAngolNév TípusokÉsFüggvények    = "Types and Functions (Vect, Fin, DPair, records, IO)"
fejezetAngolNév Interfészek            = "Interfaces (instance = proof of laws)"
fejezetAngolNév ModulokÉsNévterek      = "Modules (private/export/public export; %hide!)"
fejezetAngolNév Multiplicitások        = "Multiplicities (QTT: 0=erased, 1=linear)"
fejezetAngolNév Csomagok               = "Packages (.ipkg, modules, -p)"
fejezetAngolNév JólTípusozottÉrtelmező = "Well-Typed Interpreter (embedding a language)"
fejezetAngolNév NézetekÉsWithSzabály   = "Views and with-rule (pattern refines others)"
fejezetAngolNév TételBizonyítás        = "Theorem Proving (Refl/cong/rewrite/totality)"
fejezetAngolNév InteraktívSzerkesztés  = "Interactive Editing (:cs :ps :am :mw)"
fejezetAngolNév Vegyesek               = "Miscellany (auto/default implicits, universes)"
fejezetAngolNév TovábbiOlvasmányok     = "Further Reading (Brady, Höck)"

public export
fejezetDiracNév : IdrisFejezet -> String
fejezetDiracNév Bevezetés              = "⟨tulajdonság|típus⟩=1"
fejezetDiracNév Indulás                = "⟨fordító|saját-nyelv⟩≠0"
fejezetDiracNév TípusokÉsFüggvények    = "⟨érték|típus⟩⊗ — tenzor/Sigma"
fejezetDiracNév Interfészek            = "⟨törvény|instance⟩"
fejezetDiracNév ModulokÉsNévterek      = "⟨definíció|bizonyítás⟩ átlátszósága"
fejezetDiracNév Multiplicitások        = "⟨használat|futásidő⟩₀"
fejezetDiracNév Csomagok               = "⟨modulok|csomag⟩=⊗"
fejezetDiracNév JólTípusozottÉrtelmező = "⟨szintaxis|szemantika⟩=interp (U)"
fejezetDiracNév NézetekÉsWithSzabály   = "|Parity⟩-bázisra projekció"
fejezetDiracNév TételBizonyítás        = "⟨állítás|program⟩ — Curry–Howard"
fejezetDiracNév InteraktívSzerkesztés  = "⟨típus|lyuk⟩→⟨típus|program⟩ kollepsz"
fejezetDiracNév Vegyesek               = "%hint = célállapot; Type:Type₁ létra"
fejezetDiracNév TovábbiOlvasmányok     = "⟨kérdés|forrás⟩ koherens átvitel"

-- ─── 7. FŐPROGRAM ───────────────────────────────────────────
-- 七、主程序 ────────────────────

public export
tízKulcsszóTáblázat : List (String, IdrisFejezet)
tízKulcsszóTáblázat =
  [ ("interface / 接口", trigger InterfaceSzó)
  , ("%hide / 隐藏", trigger ElrejtésSzó)
  , ("?hole :cs :ps / 洞", trigger LyukSzó)
  , ("Refl cong rewrite / 证明", trigger ReflSzó)
  , ("with view / 视图", trigger WithSzó)
  , ("(0 x : …) / 擦除", trigger TöröltSzó)
  , ("record := / 记录", trigger RekordSzó)
  , ("total covering / 完全性", trigger TeljesSzó)
  , ("do IO pure / 输入输出", trigger IOSzó)
  , ("module import / 模块", trigger ModulSzó)
  ]

main : IO ()
main = do
  putStrLn "═══ IDRIS NYELV — 13 fejezet × 4 nyelv × DIRAC ═══"
  putStrLn "═══ 艾德里斯语言——十三章 × 四语 × 狄拉克 ═══"
  putStrLn ""
  putStrLn "── A TIZENHÁROM FEJEZET / 十三章 ──"
  putStrLn ("1.  " ++ fejezetMagyarNév Bevezetés ++ " | " ++ fejezetKínaiNév Bevezetés)
  putStrLn ("2.  " ++ fejezetMagyarNév Indulás ++ " | " ++ fejezetKínaiNév Indulás)
  putStrLn ("3.  " ++ fejezetMagyarNév TípusokÉsFüggvények ++ " | " ++ fejezetKínaiNév TípusokÉsFüggvények)
  putStrLn ("4.  " ++ fejezetMagyarNév Interfészek ++ " | " ++ fejezetKínaiNév Interfészek)
  putStrLn ("5.  " ++ fejezetMagyarNév ModulokÉsNévterek ++ " | " ++ fejezetKínaiNév ModulokÉsNévterek)
  putStrLn ("6.  " ++ fejezetMagyarNév Multiplicitások ++ " | " ++ fejezetKínaiNév Multiplicitások)
  putStrLn ("7.  " ++ fejezetMagyarNév Csomagok ++ " | " ++ fejezetKínaiNév Csomagok)
  putStrLn ("8.  " ++ fejezetMagyarNév JólTípusozottÉrtelmező ++ " | " ++ fejezetKínaiNév JólTípusozottÉrtelmező)
  putStrLn ("9.  " ++ fejezetMagyarNév NézetekÉsWithSzabály ++ " | " ++ fejezetKínaiNév NézetekÉsWithSzabály)
  putStrLn ("10. " ++ fejezetMagyarNév TételBizonyítás ++ " | " ++ fejezetKínaiNév TételBizonyítás)
  putStrLn ("11. " ++ fejezetMagyarNév InteraktívSzerkesztés ++ " | " ++ fejezetKínaiNév InteraktívSzerkesztés)
  putStrLn ("12. " ++ fejezetMagyarNév Vegyesek ++ " | " ++ fejezetKínaiNév Vegyesek)
  putStrLn ("13. " ++ fejezetMagyarNév TovábbiOlvasmányok ++ " | " ++ fejezetKínaiNév TovábbiOlvasmányok)
  putStrLn ""
  putStrLn "── DIRAC-forma / 狄拉克形式 ──"
  putStrLn ("1.  " ++ fejezetDiracNév Bevezetés)
  putStrLn ("5.  " ++ fejezetDiracNév ModulokÉsNévterek)
  putStrLn ("6.  " ++ fejezetDiracNév Multiplicitások)
  putStrLn ("9.  " ++ fejezetDiracNév NézetekÉsWithSzabály)
  putStrLn ("10. " ++ fejezetDiracNév TételBizonyítás)
  putStrLn ("11. " ++ fejezetDiracNév InteraktívSzerkesztés)
  putStrLn ""
  putStrLn "── TRIGGER-TÁBLÁZAT / 触发表 ──"
  putStrLn ("interface → " ++ fejezetAngolNév (trigger InterfaceSzó))
  putStrLn ("%hide    → " ++ fejezetAngolNév (trigger ElrejtésSzó))
  putStrLn ("Refl     → " ++ fejezetAngolNév (trigger ReflSzó))
  putStrLn ("with     → " ++ fejezetAngolNév (trigger WithSzó))
  putStrLn ("(0 x:…)  → " ++ fejezetAngolNév (trigger TöröltSzó))
  putStrLn ""
  putStrLn "── TANÚK / 见证 ──"
  putStrLn ("trigger ElrejtésSzó = ModulokÉsNévterek : " ++ "Refl ✓")
  putStrLn ("trigger WithSzó = NézetekÉsWithSzabály : " ++ tanúÉl {elvárt = NézetekÉsWithSzabály} {tényleges = trigger WithSzó} Refl)
  putStrLn ("szövegEgyenlő ÜresSzöveg ÜresSzöveg = Igaz : " ++ "Refl ✓ (CSAPDA #26: String-alapú Szöveg NEM Refl-zár!)")
  putStrLn ""
  putStrLn "Kész. / 完成。 — «ez fogja megalapozni az egészet» / 「这奠定一切的基础」"
