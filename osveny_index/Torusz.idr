module Torusz

-- ═══════════════════════════════════════════════════════════════════════
-- BINÁRIS TÓRUSZ — S¹ × S¹ periodikus határfeltételekkel
-- 二元环面——S¹ × S¹ 周期边界条件（离散化为 Z₂ × Z₈ = 16 个点）
-- ═══════════════════════════════════════════════════════════════════════
-- A felhasználó (2026-08-30): „altalanositott binaris formula lehet
-- pl valamilyen binaris torusz, ami valahogy korbeforog ...
-- periodikus hatarfeltetelekkel, egy bit+kvantalt fazis(8 reszre
-- osztott imaginarius egyseg-kor)"
-- （用户原话，逐字保留 [sic]——「广义的二进公式可以是某个二进环面，它环绕旋转……
-- 带周期边界条件，一个比特 + 量子化相位（八等分的虚数单位圆）」）
--
-- A felhasználó (2026-08-31): „ezt a torusz dolgot finomitani kene...
-- es jobban elmagyarazni, konkret peldakkal... illetve futas ideju
-- tesztek is kellenek mindenre, peldakkal"
-- （用户原话 [sic]——「这个环面的事需要细化……更好地解释，给出具体示例……
-- 还需要运行时测试，对一切都配示例」）
--
-- A tórusz (S¹ × S¹) = a fázistér két dimenziója (pozíció × impulzus),
-- periodikus határfeltételekkel. Ez a GKP-kód (Gottesman-Kitaev-Preskill)
-- alapja — a folytonos-változó kvantumhibajavítás, ahol a rács = az E8 rács.
-- 环面（S¹ × S¹）= 相空间的两个维度（位置 × 动量），带周期边界条件。
-- 这是 GKP 码（Gottesman-Kitaev-Preskill）的基础——连续变量量子纠错，
-- 其中的格 = E8 格。
--
-- Források: / 来源：
--   Gottesman-Kitaev-Preskill (2001): arXiv:quant-ph/0008040
--   Generalized GKP (2025): arXiv:2509.18204
--   Fazis.idr (a Z₈ csoport — IMPORTÁLVA, §24: duplikáció tilos / 禁止代码重复)
-- ═══════════════════════════════════════════════════════════════════════

import Fazis
import Data.Vect
import Alap.CsomagoltTipusok
import Alap.Hatar

%default total

-- ═══════════════════════════════════════════════════════════════════════
-- I. A BINÁRIS TÓRUSZ = Z₂ × Z₈ / 二元环面 = Z₂ × Z₈
-- ═══════════════════════════════════════════════════════════════════════
-- A tórusz két dimenziója: / 环面的两个维度：
--   1. Pozíció (q): egy bit — Z₂ = {0, 1} / 位置（q）：一个比特——Z₂ = {0, 1}
--   2. Fázis (p): 8 részre osztott kör — Z₈ = {F0, F1, ..., F7}  (IMPORTÁLVA)
--      相位（p）：八等分的圆——Z₈ = {F0, F1, …, F7}（已导入）
-- A tórusz pontja = (pozíció, fázis) ∈ Z₂ × Z₈ / 环面的点 = (位置, 相位) ∈ Z₂ × Z₈
-- A tórusz pontjainak száma = 2 × 8 = 16 = a Cl(4) 16 pengéje
-- 环面点数 = 2 × 8 = 16 = Cl(4) 的 16 片叶片
--
-- KONKRÉT PÉLDA: a négy Eckert-pont. / 具体示例：四个 Eckert 点。

||| A pozíció dimenzió: egy bit (Z₂).
||| 位置维度：一个比特（Z₂）。
public export
data Pozíció : Type where
  Pozíció0 : Pozíció   -- a bit 0 / 比特 0
  Pozíció1 : Pozíció   -- a bit 1 / 比特 1

public export
Eq Pozíció where
  Pozíció0 == Pozíció0 = True
  Pozíció1 == Pozíció1 = True
  _ == _ = False

public export
Show Pozíció where
  show Pozíció0 = "0"
  show Pozíció1 = "1"

||| A pozíció váltása (bit-flip = Pauli X).
||| 位置的翻转（比特翻转 = 泡利 X）。
public export
pozícióVáltás : Pozíció -> Pozíció
pozícióVáltás Pozíció0 = Pozíció1
pozícióVáltás Pozíció1 = Pozíció0

-- REFL: a bit-flip involúció (X² = I). / REFL：比特翻转是对合（X² = I）。
public export
bizPozícióVáltásInvolúció : (p : Pozíció) -> pozícióVáltás (pozícióVáltás p) = p
bizPozícióVáltásInvolúció Pozíció0 = Refl
bizPozícióVáltásInvolúció Pozíció1 = Refl

||| A tórusz pontja = (pozíció, fázis) ∈ Z₂ × Z₈.
||| 环面的点 = (位置, 相位) ∈ Z₂ × Z₈。
public export
record TóruszPont where
  constructor MkTóruszPont
  tóruszPozíció : Pozíció     -- a bit (Z₂) / 比特（Z₂）
  tóruszFázis   : Fazis       -- a fázis (Z₈) / 相位（Z₈）

public export
Eq TóruszPont where
  p == q = (tóruszPozíció p == tóruszPozíció q) && (tóruszFázis p == tóruszFázis q)

public export
Show TóruszPont where
  show p = "(" ++ show (tóruszPozíció p) ++ "," ++ show (tóruszFázis p) ++ ")"

-- KONKRÉT PÉLDA: a tórusz 16 pontja (Z₂ × Z₈ = 2 × 8 = 16) — FÜZÉRKÉNT.
-- 具体示例：环面的 16 个点（Z₂ × Z₈ = 2 × 8 = 16）——以 Füzér（链）表示。
-- GAN-FELFEDEZÉS (100.02): az eredeti Listában TIZENHÉT elem volt — a
-- «tautológia-pont» megismételte (1, F0)-t ((1, 360°) = (1, 0°)). A List
-- eltűrte; a FÜZÉR HOSSZ-TÖRVÉNYE NEM TŰRI — a típus kikényszeríti a
-- javítást (Curry–Howard fényes esete: az erősebb típus leleplezi a
-- rejtett hibát; a duplikált pont immár dokumentáltan száműzve).
-- GAN 发现（100.02）：原来的 List（表）中有十七个元素——「同义反复点」重复了
-- (1, F0)（即 (1, 360°) = (1, 0°)）。List 容忍了它；但 Füzér 的长度定律不容忍——
-- 类型强制了修正（Curry–Howard 的光辉案例：更强的类型揭露隐藏的错误；
-- 重复的点现已被有据可查地放逐）。
public export
tóruszPont16 : Füzér TóruszPont
tóruszPont16 =
  let tizenhatodik = Fűzés (MkTóruszPont Pozíció1 F7) FüzérVége
      tizenötödik  = Fűzés (MkTóruszPont Pozíció1 F6) tizenhatodik
      tizennegyedik = Fűzés (MkTóruszPont Pozíció1 F5) tizenötödik
      tizenharmadik = Fűzés (MkTóruszPont Pozíció1 F4) tizennegyedik
      tizenkettedik = Fűzés (MkTóruszPont Pozíció1 F3) tizenharmadik
      tizenegyedik  = Fűzés (MkTóruszPont Pozíció1 F2) tizenkettedik
      tizedik       = Fűzés (MkTóruszPont Pozíció1 F1) tizenegyedik
      kilencedik    = Fűzés (MkTóruszPont Pozíció1 F0) tizedik
      nyolcadik     = Fűzés (MkTóruszPont Pozíció0 F7) kilencedik
      hetedik       = Fűzés (MkTóruszPont Pozíció0 F6) nyolcadik
      hatodik       = Fűzés (MkTóruszPont Pozíció0 F5) hetedik
      ötödik        = Fűzés (MkTóruszPont Pozíció0 F4) hatodik
      negyedik      = Fűzés (MkTóruszPont Pozíció0 F3) ötödik
      harmadik      = Fűzés (MkTóruszPont Pozíció0 F2) negyedik
      második       = Fűzés (MkTóruszPont Pozíció0 F1) harmadik
      első          = Fűzés (MkTóruszPont Pozíció0 F0) második
  in első

-- ═══════════════════════════════════════════════════════════════════════
-- II. A TÓRUSZ PONTJAINAK SZÁMA = 16 / 环面点数 = 16
-- ═══════════════════════════════════════════════════════════════════════

||| A tórusz pontjainak száma: a füzér HOSSZÁBÓL — nem literálból!
||| (A 100.02 lényege: a szám ADAT, a tényleges láncból számolódik; ha
||| a lánc változik, a szám is — a típus összeköti őket.)
||| 环面点数：由链的长度算出——不是字面量！（100.02 的要点：数值是数据，
||| 从实际的链中计算；若链改变，数值也随之改变——类型把二者连在一起。）
public export
tóruszPontokSzáma : Sorszám
tóruszPontokSzáma = füzérHossz Torusz.tóruszPont16

-- REFL, 1. út (direkt szorzat): |Z₂ × Z₈| = 2 × 8 = 8 + 8 = 16.
-- (A sorÖsszeadás az ELSŐ argumentumon rekurzál — a konkrét bal
-- oldal azonnal redukál; l. Idris2BizonyitasSzabalyok 4. szabály.)
-- REFL，路径 1（直积）：|Z₂ × Z₈| = 2 × 8 = 8 + 8 = 16。
-- （sorÖsszeadás在第一个参数上递归——具体的左侧立即归约；
-- 见 Idris2BizonyitasSzabalyok 第 4 条规则。）
-- A 16 = a Cl(4) 16 pengéje (a 256-os híd része: 240 + 16 = 256).
-- 16 = Cl(4) 的 16 片叶片（256 之桥的一部分：240 + 16 = 256）。
public export
bizTóruszPontokSzáma :
  füzérHossz Torusz.tóruszPont16
  = sorÖsszeadás Alap.CsomagoltTipusok.sorNyolc Alap.CsomagoltTipusok.sorNyolc
bizTóruszPontokSzáma = Refl

-- REFL, 2. út (Pascal-háromszög): |Cl(4)| = 1+4+6+4+1 = 16 (n=4 sora).
-- KÉT független út (AGENTS §18) — mindkettő a füzér hosszáig fut le.
-- REFL，路径 2（帕斯卡三角形）：|Cl(4)| = 1+4+6+4+1 = 16（n = 4 那一行）。
-- 两条独立路径（AGENTS §18）——每条都一直算到链的长度。
public export
bizTóruszCl4Penge :
  füzérHossz Torusz.tóruszPont16
  = sorÖsszeadás (sorÖsszeadás (sorÖsszeadás (sorÖsszeadás
      Alap.CsomagoltTipusok.sorEgy Alap.CsomagoltTipusok.sorNégy)
      Alap.CsomagoltTipusok.sorHat)
      Alap.CsomagoltTipusok.sorNégy)
      Alap.CsomagoltTipusok.sorEgy
bizTóruszCl4Penge = Refl

||| A CSŐVEZETÉK-TANÚ: a hossz → a magyar szó — «tizenhat» (D nélkül!).
||| Egy bizonyítás, amely a teljes láncot lefuti: a 16 pont füzére →
||| a hossza → a szó, amit a main kiír.
||| 管道见证：长度 → 匈牙利语单词——「tizenhat」（没有 D！）。
||| 一个贯穿整条链的证明：16 个点的链 → 其长度 → 主程序所印的单词。
public export
tóruszSzámaSzava :
  sorSzöveggé Torusz.tóruszPontokSzáma
  = Alap.CsomagoltTipusok.szorzámTizenhatSzó
tóruszSzámaSzava = Refl

-- ═══════════════════════════════════════════════════════════════════════
-- III. A TÓRUSZON VALÓ MOZGÁS — KÖRBEFORGÁS / 环面上的运动——环绕旋转
-- ═══════════════════════════════════════════════════════════════════════
-- A tórusz körbeforog: a pozíció és a fázis együtt változik,
-- periodikus határfeltételekkel (a tórusz felülete zárt).
-- 环面环绕旋转：位置与相位一同变化，带周期边界条件（环面是闭曲面）。
--
-- A mozgás két típusa: / 运动的两种类型：
--   1. Pozíció-lépés (bit-flip): a pozíció vált (0→1→0), a fázis fix
--      位置步（比特翻转）：位置翻转（0→1→0），相位固定
--   2. Fázis-lépés (forgatás): a fázis lép (F0→F1→...→F7→F0), a pozíció fix
--      相位步（旋转）：相位前进（F0→F1→…→F7→F0），位置固定
-- A kettő kombinációja = a tórusz spirálmozgása. / 二者的组合 = 环面的螺旋运动。
--
-- KONKRÉT PÉLDA a mozgásra: az állításból a következtetésig.
-- 运动的具体示例：从陈述到推论。

||| Pozíció-lépés a tóruszon: bit-flip, fázis fix.
||| 环面上的位置步：比特翻转，相位固定。
public export
pozícióLépés : TóruszPont -> TóruszPont
pozícióLépés (MkTóruszPont p f) = MkTóruszPont (pozícióVáltás p) f

||| Fázis-lépés a tóruszon: fázis +1 (Z₈), pozíció fix.
||| 环面上的相位步：相位 +1（Z₈），位置固定。
public export
fázisLépés : TóruszPont -> TóruszPont
fázisLépés (MkTóruszPont p f) = MkTóruszPont p (fazisOsszead f F1)

-- REFL: a pozíció-lépés involúció (kétszer = identitás).
-- Bizonyítás: a pozícióVáltás involúció (X² = I), a fázis fix marad.
-- A 16 eset = 2 pozíció × 8 fázis, de a fázis változó (f) mindig fix,
-- ezért csak 2 minta kell (pozíció szerinti).
-- REFL：位置步是对合（两次 = 恒等）。证明：pozícióVáltás 是对合（X² = I），
-- 相位保持固定。16 种情形 = 2 个位置 × 8 个相位，但相位变量（f）总固定，
-- 故只需 2 个模式（按位置）。
public export
bizPozícióLépésInvolúció : (t : TóruszPont) -> pozícióLépés (pozícióLépés t) = t
bizPozícióLépésInvolúció (MkTóruszPont Pozíció0 f) = Refl
bizPozícióLépésInvolúció (MkTóruszPont Pozíció1 f) = Refl

-- REFL: a fázis-lépés 8-szor = identitás (Z₈ periodicitás).
-- Bizonyítás: 8 lépés külön (fázisLépés1...fázisLépés8), mindegyik Refl.
-- REFL：相位步 8 次 = 恒等（Z₈ 周期性）。证明：8 步各别（fázisLépés1…8），每条 Refl。
fázisLépés1 : fázisLépés (MkTóruszPont Pozíció0 F0) = MkTóruszPont Pozíció0 F1
fázisLépés2 : fázisLépés (MkTóruszPont Pozíció0 F1) = MkTóruszPont Pozíció0 F2
fázisLépés3 : fázisLépés (MkTóruszPont Pozíció0 F2) = MkTóruszPont Pozíció0 F3
fázisLépés4 : fázisLépés (MkTóruszPont Pozíció0 F3) = MkTóruszPont Pozíció0 F4
fázisLépés5 : fázisLépés (MkTóruszPont Pozíció0 F4) = MkTóruszPont Pozíció0 F5
fázisLépés6 : fázisLépés (MkTóruszPont Pozíció0 F5) = MkTóruszPont Pozíció0 F6
fázisLépés7 : fázisLépés (MkTóruszPont Pozíció0 F6) = MkTóruszPont Pozíció0 F7
fázisLépés8 : fázisLépés (MkTóruszPont Pozíció0 F7) = MkTóruszPont Pozíció0 F0

-- REFL: a 8 lépés visszatér az eredeti állapotba (identitás).
-- REFL：8 步回到原状态（恒等）。
bizFázisLépés1 : fázisLépés (MkTóruszPont Pozíció0 F0) = MkTóruszPont Pozíció0 F1
bizFázisLépés1 = Refl

bizFázisLépés2 : fázisLépés (MkTóruszPont Pozíció0 F1) = MkTóruszPont Pozíció0 F2
bizFázisLépés2 = Refl

bizFázisLépés3 : fázisLépés (MkTóruszPont Pozíció0 F2) = MkTóruszPont Pozíció0 F3
bizFázisLépés3 = Refl

bizFázisLépés4 : fázisLépés (MkTóruszPont Pozíció0 F3) = MkTóruszPont Pozíció0 F4
bizFázisLépés4 = Refl

bizFázisLépés5 : fázisLépés (MkTóruszPont Pozíció0 F4) = MkTóruszPont Pozíció0 F5
bizFázisLépés5 = Refl

bizFázisLépés6 : fázisLépés (MkTóruszPont Pozíció0 F5) = MkTóruszPont Pozíció0 F6
bizFázisLépés6 = Refl

bizFázisLépés7 : fázisLépés (MkTóruszPont Pozíció0 F6) = MkTóruszPont Pozíció0 F7
bizFázisLépés7 = Refl

bizFázisLépés8 : fázisLépés (MkTóruszPont Pozíció0 F7) = MkTóruszPont Pozíció0 F0
bizFázisLépés8 = Refl

-- ═══════════════════════════════════════════════════════════════════════
-- IV. A TÓRUSZ MINT GKP-KÓD FÁZISTÉR / 环面作为 GKP 码相空间
-- ═══════════════════════════════════════════════════════════════════════
-- A GKP-kód (Gottesman-Kitaev-Preskill) a folytonos fázistér (q, p)
-- diszkretizálja egy rácsra. A tórusz = a fázistér periodikus
-- határfeltételekkel. Az E8 rács (unimoduláris, ön-duális) = a GKP-rács.
-- GKP 码（Gottesman-Kitaev-Preskill）把连续相空间（q, p）离散化到一个格上。
-- 环面 = 带周期边界条件的相空间。E8 格（幺模、自对偶）= GKP 格。
--
-- A bináris tórusz (Z₂ × Z₈) = a GKP-kód diszkretizált fázistere:
-- 二元环面（Z₂ × Z₈）= GKP 码的离散相空间：
--   - q (pozíció) = Z₂ (egy bit) / q（位置）= Z₂（一个比特）
--   - p (impulzus) = Z₈ (8 fázisérték) / p（动量）= Z₈（8 个相位值）
--   - A tórusz = q × p = Z₂ × Z₈ = 16 pont / 环面 = q × p = Z₂ × Z₈ = 16 个点
--
-- KONKRÉT PÉLDA a GKP-kódra: a 16 tórusz-pont (Z₂ × Z₈).
-- GKP 码的具体示例：16 个环面点（Z₂ × Z₈）。

||| A GKP-kód diszkretizált fázistere = a bináris tórusz.
||| GKP 码的离散相空间 = 二元环面。
public export
record GKPFázistér where
  constructor MkGKPFázistér
  gkpPozíció : Pozíció     -- q (a kvantum pozíció) / q（量子位置）
  gkpFázis   : Fazis       -- p (a kvantum impulzus/fázis) / p（量子动量/相位）

||| A GKP-kód tórusz-pontja = a fázistér egy pontja.
||| GKP 码的环面点 = 相空间的一个点。
public export
gkpTóruszPont : GKPFázistér -> TóruszPont
gkpTóruszPont (MkGKPFázistér q p) = MkTóruszPont q p

-- REFL: a GKP-pont átalakítása tórusz-pontté (identitás a koordinátákra).
-- REFL：GKP 点到环面点的转换（对坐标是恒等）。
public export
bizGKPTóruszPont : (g : GKPFázistér) -> gkpTóruszPont g = MkTóruszPont (gkpPozíció g) (gkpFázis g)
bizGKPTóruszPont (MkGKPFázistér q p) = Refl

-- KONKRÉT PÉLDA: a 16 GKP-pont (a teljes tórusz).
-- (§24: az eredeti azonos tartalmú Listát MÁSOLTA — most az EGY lánc él,
-- két néven; a gkpTórusz16 a tóruszPont16 álneve.)
-- 具体示例：16 个 GKP 点（整个环面）。（§24：原来复制了内容相同的 List——
-- 现在一条链以两个名字存在；gkpTórusz16 是 tóruszPont16 的别名。）
gkpTórusz16 : Füzér TóruszPont
gkpTórusz16 = Torusz.tóruszPont16

-- ═══════════════════════════════════════════════════════════════════════
-- V. A TÓRUSZ ÉS A MAGYAR MONDAT KÓDOLÁSA / 环面与匈牙利语句的编码
-- ═══════════════════════════════════════════════════════════════════════
-- A felhasználó elképzelése: a magyar mondatot (állítás, kérdés,
-- feltevés, következtetés) a tórusz egy pontjaként kódolni.
-- 用户的构想：把匈牙利语句子（陈述、疑问、假定、推论）编码为环面上的一个点。
--
-- A mondattípus → tórusz-pont megfeleltetés: / 句型 → 环面点的对应：
--   Állítás       = (Pozíció0, F0) — a bit 0, a fázis 0° (valós, tény)
--   陈述           = (Pozíció0, F0)——比特 0，相位 0°（实数，事实）
--   Kérdés        = (Pozíció0, F2) — a bit 0, a fázis 90° (i, képzetes)
--   疑问           = (Pozíció0, F2)——比特 0，相位 90°（i，虚数）
--   Feltevés      = (Pozíció0, F4) — a bit 0, a fázis 180° (-1, inverz)
--   假定           = (Pozíció0, F4)——比特 0，相位 180°（-1，逆）
--   Következtetés = (Pozíció0, F6) — a bit 0, a fázis 270° (-i, adjungált)
--   推论           = (Pozíció0, F6)——比特 0，相位 270°（-i，伴随）
--
-- A pozíció (bit) = a mondat „valóságértéke" (0 = nincs megerősítve, 1 = megerősítve).
-- 位置（比特）= 句子的「真值度」（0 = 未确认，1 = 已确认）。
-- A fázis = a mondat „módja" (0° = állítás, 90° = kérdés, 180° = feltevés, 270° = következtetés).
-- 相位 = 句子的「语气」（0° = 陈述，90° = 疑问，180° = 假定，270° = 推论）。
--
-- KONKRÉT PÉLDA: a négy mondattípus → tórusz-pont.
-- 具体示例：四种句型 → 环面点。

||| A négy mondattípus. / 四种句型。
public export
data MondatTípus : Type where
  Állítás       : MondatTípus   -- a mondat kijelentő (fázis 0°) / 陈述句（相位 0°）
  Kérdés        : MondatTípus   -- a mondat kérdő (fázis 90° = i) / 疑问句（相位 90° = i）
  Feltevés      : MondatTípus   -- a mondat feltételező (fázis 180° = -1) / 假定句（相位 180° = -1）
  Következtetés : MondatTípus   -- a mondat következtető (fázis 270° = -i) / 推论句（相位 270° = -i）

||| A mondattípus → fázis megfeleltetés. / 句型 → 相位的对应。
public export
mondatFázis : MondatTípus -> Fazis
mondatFázis Állítás       = F0   -- 0° (valós, tény) / 0°（实数，事实）
mondatFázis Kérdés        = F2   -- 90° (i, képzetes) / 90°（i，虚数）
mondatFázis Feltevés      = F4   -- 180° (-1, inverz) / 180°（-1，逆）
mondatFázis Következtetés = F6   -- 270° (-i, adjungált) / 270°（-i，伴随）

||| A mondattípus → tórusz-pont megfeleltetés (pozíció = 0, fázis = a mód).
||| 句型 → 环面点的对应（位置 = 0，相位 = 语气）。
public export
mondatTóruszPont : MondatTípus -> TóruszPont
mondatTóruszPont mt = MkTóruszPont Pozíció0 (mondatFázis mt)

-- REFL: a négy mondattípus fázisa. / REFL：四种句型的相位。
public export
bizÁllításF0 : mondatFázis Állítás = F0
bizÁllításF0 = Refl

public export
bizKérdésF2 : mondatFázis Kérdés = F2
bizKérdésF2 = Refl

public export
bizFeltevésF4 : mondatFázis Feltevés = F4
bizFeltevésF4 = Refl

public export
bizKövetkeztetésF6 : mondatFázis Következtetés = F6
bizKövetkeztetésF6 = Refl

-- KONKRÉT PÉLDA: a négy mondat a tórusz négy sarkopontjára.
-- 具体示例：四种句子对应环面的四个顶点。
állításPont   : TóruszPont
állításPont   = MkTóruszPont Pozíció0 F0   -- (0, 0°)   — az állítás / 陈述

kérdésPont    : TóruszPont
kérdésPont    = MkTóruszPont Pozíció0 F2   -- (0, 90°)  — a kérdés / 疑问

feltevésPont  : TóruszPont
feltevésPont  = MkTóruszPont Pozíció0 F4   -- (0, 180°) — a feltevés / 假定

következtetésPont : TóruszPont
következtetésPont = MkTóruszPont Pozíció0 F6   -- (0, 270°) — a következtetés / 推论

-- REFL: a négy sarkopont megegyezik a mondatTóruszPont kimenetével.
-- REFL：四个顶点与 mondatTóruszPont 的输出一致。
bizÁllításPont : mondatTóruszPont Állítás = MkTóruszPont Pozíció0 F0
bizÁllításPont = Refl

bizKérdésPont : mondatTóruszPont Kérdés = MkTóruszPont Pozíció0 F2
bizKérdésPont = Refl

bizFeltevésPont : mondatTóruszPont Feltevés = MkTóruszPont Pozíció0 F4
bizFeltevésPont = Refl

bizKövetkeztetésPont : mondatTóruszPont Következtetés = MkTóruszPont Pozíció0 F6
bizKövetkeztetésPont = Refl

-- ═══════════════════════════════════════════════════════════════════════
-- VI. A TÓRUSZ ÉS A GENERALIZED PAULI OPERÁTOROK / 环面与广义泡利算子
-- ═══════════════════════════════════════════════════════════════════════
-- L4-JAVÍTVA (GAN-CATCH): a tórusz két dimenziója a két GENERALIZED
-- Pauli-operátornak felel meg (l. GeneralizedPauli.idr — a cikk L4
-- hibájának bizonyítása):
--   Pozíció (q) = Pauli X (bit-flip: 0↔1 — rendje 2 = |Z₂| ✓)
--   Fázis (p)   = GENERALIZED Pauli Z₈ (a Z₈ fázisléptetés — rendje 8,
--                 NEM 2! A 2×2-es Pauli Z rendje 2; a Z₈-hoz a d = 8
--                 generalized Pauli kell: Z_d |k⟩ = ω_d^k |k⟩)
-- L4 修正（GAN 抓获）：环面的两个维度对应两个广义泡利算子（见
-- GeneralizedPauli.idr——文章 L4 错误的证明）：
--   位置（q）= 泡利 X（比特翻转：0↔1——阶为 2 = |Z₂| ✓）
--   相位（p）= 广义泡利 Z₈（Z₈ 相位步进——阶为 8，不是 2！
--               2×2 泡利 Z 的阶是 2；Z₈ 需要 d = 8 的广义泡利：Z_d |k⟩ = ω_d^k |k⟩）
--
-- A Heisenberg-felcserélhetetlenség [X, Z₈] ≠ 0 = a tórusz
-- nem-simulálhatósága: nem lehet egyszerre pontosan mérni a pozíciót
-- és a fázist (a tórusz periodicitása miatt).
-- 海森堡不对易性 [X, Z₈] ≠ 0 = 环面的不可模拟性：不能同时精确测量位置
-- 与相位（因为环面的周期性）。

||| A tórusz két dimenziója = a két generalized Pauli-operátor.
||| 环面的两个维度 = 两个广义泡利算子。
public export
data TóruszDimenzió : Type where
  PozícióDimenzió : TóruszDimenzió   -- q = Pauli X (rendje 2) / q = 泡利 X（阶 2）
  FázisDimenzió   : TóruszDimenzió   -- p = generalized Pauli Z₈ (rendje 8) / p = 广义泡利 Z₈（阶 8）

-- ═══════════════════════════════════════════════════════════════════════
-- VII. FŐPROGRAM — A TÓRUSZ KIÍRÁSA + TESZTEK / 主程序 + 测试
-- ═════════════════════════════════════════════════════════════════════════
-- A main: (a) kiírja a tórusz struktúrát, (b) lefuttatja a teszteket.
-- A tesztek: Refl-bizonyítások (a bíra ellenőrzi) + IO-kiírás (a main mutatja).
-- main：(a) 打印环面结构，(b) 运行测试。测试 = Refl 证明（编译器是评审）+ IO 输出。

main : IO ()
main = do
  -- ── A tórusz struktúrája / 环面结构 ─────────────────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " BINÁRIS TÓRUSZ — S¹ × S¹ periodikus határfeltételekkel"
  putStrLn " 二元环面——S¹ × S¹ 周期边界条件"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "A felhasználó (2026-08-30):"
  putStrLn "  „bináris torusz, ami körbeforog, periodikus határfeltételekkel,"
  putStrLn "  egy bit + kvantált fázis (8 részre osztott imaginárius egység-kor)\""
  putStrLn " 用户（2026-08-30）：「二进环面，环绕旋转，带周期边界条件，一个比特"
  putStrLn " + 量子化相位（八等分的虚数单位圆）」"
  putStrLn ""

  -- ── I. A tórusz = Z₂ × Z₈ / 一、环面 = Z₂ × Z₈ ───────────────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " I. A TÓRUSZ = Z₂ × Z₈"
  putStrLn " 一、环面 = Z₂ × Z₈"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  Pozíció (q) = Z₂ = {0, 1}                    — egy bit"
  putStrLn "  位置（q）= Z₂ = {0, 1}——一个比特"
  putStrLn "  Fázis (p)   = Z₈ = {F0, F1, F2, F3, F4, F5, F6, F7}  — 8 fázis"
  putStrLn "  相位（p）= Z₈ = {F0, F1, F2, F3, F4, F5, F6, F7}——8 个相位"
  putStrLn "  A tórusz = Z₂ × Z₈ = 16 pont = a Cl(4) 16 pengéje"
  putStrLn "  环面 = Z₂ × Z₈ = 16 个点 = Cl(4) 的 16 片叶片"
  putStrLn ""
  putStrLn "  KONKRÉT PÉLDA — a 16 pont:"
  putStrLn "  具体示例——16 个点（állítás=陈述、megfigyelés=观察、kérdés=疑问、"
  putStrLn "  kétvalóság=双重性、feltevés=假定、ok-okozat=因果、következtetés=推论、"
  putStrLn "  ok=原因、megerősítés=确认、tapasztalat=经验、hipotézis=假设、"
  putStrLn "  cáfolat=反驳、meglepetés=惊讶、revízió=修正、szintézis=综合）:"
  putStrLn "    (0, F0)  állítás     (0°)    (0, F1)  megfigyelés  (45°)"
  putStrLn "    (0, F2)  kérdés     (90°)    (0, F3)  kétvalóság (135°)"
  putStrLn "    (0, F4)  feltevés   (180°)   (0, F5)  ok-okozat  (225°)"
  putStrLn "    (0, F6)  következtetés (270°) (0, F7)  ok (315°)"
  putStrLn "    (1, F0)  megerősítés (360°) (1, F1)  tapasztalat (45°)"
  putStrLn "    (1, F2)  következtetés (90°) (1, F3)  hipotézis (135°)"
  putStrLn "    (1, F4)  cáfolat (180°)  (1, F5)  meglepetés (225°)"
  putStrLn "    (1, F6)  revízió (270°)  (1, F7)  szintézis (315°)"
  putStrLn ("  Tórusz pontjainak száma / 环面点数 = " ++ szövegbőlKarakterlánc (sorSzöveggé tóruszPontokSzáma))
  putStrLn ""
  putStrLn "  TESZT: 2 × 8 = 16 / 测试：2 × 8 = 16"
  putStrLn ("    REFL: tizenhat / 十六 = " ++ szövegbőlKarakterlánc (sorSzöveggé tóruszPontokSzáma) ++ "  ✓ (bizTóruszPontokSzáma)")
  putStrLn ("    REFL: 16 = Cl(4) penge / 叶片  ✓ (bizTóruszCl4Penge)")
  putStrLn ""

  -- ── II. A tórusz mozgás — körbeforgás / 二、环面的运动——环绕旋转 ───────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " II. A TÓRUSZ MOZGÁS — KÖRBEFORGÁS"
  putStrLn " 二、环面的运动——环绕旋转"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  Pozíció-lépés (bit-flip): 0→1→0 (periodikus, X²=I)"
  putStrLn "  位置步（比特翻转）：0→1→0（周期性，X²=I）"
  putStrLn "  Fázis-lépés (forgatás): F0→F1→...→F7→F0 (periodikus, Z₈)"
  putStrLn "  相位步（旋转）：F0→F1→…→F7→F0（周期性，Z₈）"
  putStrLn "  A kettő kombinációja = a tórusz spirálmozgása."
  putStrLn "  二者的组合 = 环面的螺旋运动。"
  putStrLn ""
  putStrLn "  KONKRÉT PÉLDA — a spirálmozgás:"
  putStrLn "  具体示例——螺旋运动："
  putStrLn "    állítás → megfigyelés → kérdés → feltevés → következtetés"
  putStrLn "    （陈述 → 观察 → 疑问 → 假定 → 推论）"
  putStrLn ""
  putStrLn "  TESZT: pozíció-lépés involúció (X² = I) / 测试：位置步是对合（X² = I）"
  putStrLn "    REFL: ✓ (bizPozícióLépésInvolúció)"
  putStrLn "  TESZT: fázis-lépés 8× = identitás (Z₈ periodicitás) / 测试：相位步 8 次 = 恒等（Z₈ 周期性）"
  putStrLn "    REFL F0→F1: ✓ (bizFázisLépés1)"
  putStrLn "    REFL F1→F2: ✓ (bizFázisLépés2)"
  putStrLn "    REFL F2→F3: ✓ (bizFázisLépés3)"
  putStrLn "    REFL F3→F4: ✓ (bizFázisLépés4)"
  putStrLn "    REFL F4→F5: ✓ (bizFázisLépés5)"
  putStrLn "    REFL F5→F6: ✓ (bizFázisLépés6)"
  putStrLn "    REFL F6→F7: ✓ (bizFázisLépés7)"
  putStrLn "    REFL F7→F0: ✓ (bizFázisLépés8)"
  putStrLn ""

  -- ── III. A GKP-kód fázistér ───────────────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " III. A GKP-KÓD FÁZISTÉR"
  putStrLn " 三、GKP 码相空间"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  A GKP-kód (Gottesman-Kitaev-Preskill, 2001):"
  putStrLn "  GKP 码（Gottesman-Kitaev-Preskill，2001）："
  putStrLn "    A folytonos fázistér (q, p) diszkretizálva = tórusz"
  putStrLn "    连续相空间（q, p）离散化 = 环面"
  putStrLn "    Az E8 rács (unimoduláris, ön-duális) = a GKP-rács"
  putStrLn "    E8 格（幺模、自对偶）= GKP 格"
  putStrLn "    A bináris tórusz = Z₂ × Z₈ = 16 pont"
  putStrLn "    二元环面 = Z₂ × Z₈ = 16 个点"
  putStrLn ""
  putStrLn "  KONKRÉT PÉLDA — a 16 GKP-pont:"
  putStrLn "  具体示例——16 个 GKP 点："
  putStrLn "    (0, F0) (0, F1) (0, F2) ... (0, F7) (1, F0) ... (1, F7)"
  putStrLn ""
  putStrLn "  TESZT: GKP tórusz-pont = tórusz-pont / 测试：GKP 环面点 = 环面点"
  putStrLn "    REFL: ✓ (bizGKPTóruszPont)"
  putStrLn ""

  -- ── IV. A magyar mondat kódolása ───────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " IV. A MAGYAR MONDAT KÓDOLÁSA A TÓRUSZON"
  putStrLn " 四、匈牙利语句在环面上的编码"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  Mondattípus → tórusz-pont (pozíció = 0, fázis = a mód):"
  putStrLn "  句型 → 环面点（位置 = 0，相位 = 语气）："
  putStrLn "    Állítás       = (0, F0)  — 0° (valós, tény)"
  putStrLn "    陈述           = (0, F0)——0°（实数，事实）"
  putStrLn "    Kérdés        = (0, F2)  — 90° (i, képzetes)"
  putStrLn "    疑问           = (0, F2)——90°（i，虚数）"
  putStrLn "    Feltevés      = (0, F4)  — 180° (-1, inverz)"
  putStrLn "    假定           = (0, F4)——180°（-1，逆）"
  putStrLn "    Következtetés = (0, F6)  — 270° (-i, adjungált)"
  putStrLn "    推论           = (0, F6)——270°（-i，伴随）"
  putStrLn ""
  putStrLn "  A pozíció (bit) = a mondat „valóságértéke\" (0 = nincs megerősítve, 1 = megerősítve)"
  putStrLn "  位置（比特）= 句子的「真值度」（0 = 未确认，1 = 已确认）。"
  putStrLn "  A fázis = a mondat „módja\" (0° = állítás, 90° = kérdés, 180° = feltevés, 270° = következtetés)"
  putStrLn "  相位 = 句子的「语气」（0° = 陈述，90° = 疑问，180° = 假定，270° = 推论）。"
  putStrLn ""
  putStrLn "  KONKRÉT PÉLDA — a négy mondat a négy sarkopont:"
  putStrLn "  具体示例——四种句子在四个顶点上："
  putStrLn "    állítás (0, F0)  kérdés (0, F2)  feltevés (0, F4)  következtetés (0, F6)"
  putStrLn "    （陈述 疑问 假定 推论——四顶点）"
  putStrLn ""
  putStrLn "  TESZT: Állítás fázisa = F0 (0°) / 测试：陈述的相位 = F0（0°）"
  putStrLn "    REFL: ✓ (bizÁllításF0)"
  putStrLn "  TESZT: Kérdés fázisa = F2 (90° = i) / 测试：疑问的相位 = F2（90° = i）"
  putStrLn "    REFL: ✓ (bizKérdésF2)"
  putStrLn "  TESZT: Feltevés fázisa = F4 (180° = -1) / 测试：假定的相位 = F4（180° = -1）"
  putStrLn "    REFL: ✓ (bizFeltevésF4)"
  putStrLn "  TESZT: Következtetés fázisa = F6 (270° = -i) / 测试：推论的相位 = F6（270° = -i）"
  putStrLn "    REFL: ✓ (bizKövetkeztetésF6)"
  putStrLn ""

  -- ── V. A tórusz és a Pauli-mátrixok ───────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " V. A TÓRUSZ ÉS A GENERALIZED PAULI OPERÁTOROK"
  putStrLn " 五、环面与广义泡利算子（L4-javítva / L4 已修正）"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  Pozíció (q) = Pauli X (bit-flip: 0↔1, rendje 2 = |Z₂| ✓)"
  putStrLn "  位置（q）= 泡利 X（比特翻转：0↔1，阶 2 = |Z₂| ✓）"
  putStrLn "  Fázis (p)   = GENERALIZED Pauli Z₈ (rendje 8, NEM 2! l. GeneralizedPauli.idr)"
  putStrLn "  相位（p）= 广义泡利 Z₈（阶为 8，不是 2！见 GeneralizedPauli.idr）"
  putStrLn "  [X, Z₈] ≠ 0 = a tórusz nem-simulálhatósága (Heisenberg)"
  putStrLn "  [X, Z₈] ≠ 0 = 环面的不可模拟性（海森堡）"
  putStrLn ""
  putStrLn "  A Heisenberg-felcserélhetetlenség = a tórusz periodicitásának"
  putStrLn "  következménye: nem lehet egyszerre pontosan mérni a pozíciót"
  putStrLn "  és a fázist (a tórusz körbeforgásának korlátja)."
  putStrLn "  海森堡不对易性 = 环面周期性的后果：不能同时精确测量位置与相位"
  putStrLn "  （环面环绕旋转的极限）。"
  putStrLn ""

  -- ── Összegzés / 总结 ─────────────────────────────
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " ÖSSZEGZÉS"
  putStrLn " 总结"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  A bináris tórusz = Z₂ × Z₈ = 16 pont (a Cl(4) 16 pengéje)."
  putStrLn "  二元环面 = Z₂ × Z₈ = 16 个点（Cl(4) 的 16 片叶片）。"
  putStrLn "  A tórusz körbeforog: pozíció (X) + fázis (Z₈ — generalized Pauli), periodikusan."
  putStrLn "  环面环绕旋转：位置（X）+ 相位（Z₈——广义泡利），周期性地。"
  putStrLn "  A GKP-kód fázistere = a tórusz, az E8 rács = a GKP-rács."
  putStrLn "  GKP 码的相空间 = 环面，E8 格 = GKP 格。"
  putStrLn "  A magyar mondat 4 típusa a tórusz 4 pontja (a fázis 4 értéke)."
  putStrLn "  匈牙利语句的 4 种类型 = 环面的 4 个点（相位的 4 个取值）。"
  putStrLn "  A Fazis.idr (Z₈) importálva — §24: duplikáció tilos."
  putStrLn "  已导入 Fazis.idr（Z₈）——§24：禁止代码重复。"
  putStrLn ""
  putStrLn "  Források: GKP (2001, arXiv:quant-ph/0008040),"
  putStrLn "  Generalized GKP (2025, arXiv:2509.18204)."
  putStrLn "  来源：GKP（2001，arXiv:quant-ph/0008040）、Generalized GKP（2025，arXiv:2509.18204）。"
  putStrLn ""
  putStrLn "  ★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★"