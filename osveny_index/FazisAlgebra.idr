module FazisAlgebra

import Steane713
import HaromKubit
import E8E8Algebra
import Alap.CsomagoltTipusok

||| Fázis-algebra — a redundancia detektálásának alapja.
||| 相位代数——冗余检测的基础。
|||
||| Gondolat: a világ tele van redundanciával.
||| 洞见：世界充满冗余。
||| Ugyanazt a gondolatot többször is elmondjuk.
||| 同一个思想我们会说多遍。同一个错误我们会犯多次。
||| Ugyanazt a hibát többször is elkövetjük.
||| Ugyanaz a fogalom több helyen is megjelenik.
||| 同一个概念出现在多处。
|||
||| A redundancia detektálásához a fázist használjuk.
||| 检测冗余要用相位。相位是 [[7,1,3]] 码的第 5 位——「相位」位置。
||| A fázis a [[7,1,3]] kód 5. bitje — a „fázis" pozíció.
|||
||| Két fogalom azonos fázisban van → redundáns → eldobható.
||| 两个概念同相位 → 冗余 → 可丢弃。这维持相干性。
|||   Ez tartja fenn a koherenciát.
||| Két fogalom ellentétes fázisban van → információátvitel.
||| 两个概念反相位 → 信息传递。这创造新信息。
|||   Ez teremti az új információt.
||| Két fogalom kvantált fázisban van → kvantum-összefonódás.
||| 两个概念处于量子化相位 → 量子纠缠。这是语言隐喻与联想的基础。
|||   Ez a nyelvi metaforák, asszociációk alapja.

||| Fázisérték a Clifford-algebrában.
||| Clifford 代数中的相位值。
||| Azonos: a két kódszó ugyanabban a fázisban rezeg.
||| 同相（Azonos）：两个码字在同一相位共振 → 冗余，可丢弃。
|||   → redundáns, eldobható.
||| Ellentétes: a két kódszó ellentétes fázisban rezeg.
||| 反相（Ellentetes）：两个码字在相反相位共振 → 信息传递，保留。
|||   → információátvitel, megtartandó.
||| Kvantált: a két kódszó összefonódott állapotban van.
||| 量子化（Kvantalt）：两个码字处于纠缠态 → 量子联系（隐喻、联想）。
|||   → kvantum-kapcsolat (metafora, asszociáció).
||| Ismeretlen: a fázis nem állapítható meg egyértelműen.
||| 未知（Ismeretlen）：相位无法唯一确定 → 需进一步考察。
|||   → további vizsgálat szükséges.
public export
data Fazis = Azonos | Ellentetes | Kvantalt | Ismeretlen

public export
Eq Fazis where
  (==) Azonos Azonos = True
  (==) Ellentetes Ellentetes = True
  (==) Kvantalt Kvantalt = True
  (==) Ismeretlen Ismeretlen = True
  (==) _ _ = False
  (/=) a b = not (a == b)

||| Két kódszó fázis-összehasonlítása。两个码字的相位比较。按 Clifford 重叠判定：
||| A Clifford-átfedés alapján döntünk:
||| >0.9 → Azonos（几乎相同）
||| <0.1 → Ellentetes（完全不同）
||| >0.5 → Kvantalt（部分重叠）
||| 否则 → Ismeretlen（未知）
public export
fazisOsszehasonlit : E8E8KodSzo -> E8E8KodSzo -> Fazis
fazisOsszehasonlit a b =
  let balAtfedes = atfedes (CliffordKonstruktor a.balE8.x1 a.balE8.x2 Steane713.Nulla)
                           (CliffordKonstruktor b.balE8.x1 b.balE8.x2 Steane713.Nulla)
      jobbAtfedes = atfedes (CliffordKonstruktor a.jobbE8.x1 a.jobbE8.x2 Steane713.Nulla)
                            (CliffordKonstruktor b.jobbE8.x1 b.jobbE8.x2 Steane713.Nulla)
  in if balAtfedes > 0.9 && jobbAtfedes > 0.9 then Azonos
  else if balAtfedes < 0.1 && jobbAtfedes < 0.1 then Ellentetes
  else if balAtfedes > 0.5 || jobbAtfedes > 0.5 then Kvantalt
  else Ismeretlen

||| Redundancia-ellenőrzés：若某码字与任一已有码字同相，
||| 则冗余——可丢弃。 冗余检验。
||| Ez a koherencia megőrzésének alapja。这是保持相干性的基础。
public export
redundans : E8E8KodSzo -> List E8E8KodSzo -> Bool
redundans kod kodok = any (\k => fazisOsszehasonlit kod k == Azonos) kodok

||| Szűrés：保留相位与其余不同的码字。筛选。
||| 同相者被丢弃后，所得集合是相干的——无冗余。
||| 这样维持相干性。
|||
||| A szűrés algoritmusa（筛选算法）：
|||   lista elejetol haladunk
|||   否则保留并继续。

public export
szurd : List E8E8KodSzo -> List E8E8KodSzo
szurd [] = []
szurd (x :: xs) =
  if redundans x xs
    then szurd xs
    else x :: szurd xs

||| ToltesParitasIdo: a CPT szimmetria magyarul.
||| ToltesParitasIdo：CPT 对称的匈牙利语表述。
||| CPT:
|||   C (toltes) = saját tudat — a rendszer önreferenciája
|||   C（töltés）= 自我意识——系统的自参照
|||   P (paritas) = másik fel — a külső bemenet
|||   P（paritás）= 另一方——外部输入
|||   T (ido) = kapcsolat fázisa — a kettő dinamikája
|||   T（idő）= 联系的相位——二者的动力学
|||
||| A ToltesParitasIdo három HaromKubitot tartalmaz,
||| minden irányhoz egyet. Ez a teljes CPT szimmetria
||| a három kubit világában.
||| ToltesParitasIdo 含三个 HaromKubit——每个方向一个。
||| 这就是三比特世界中的完整 CPT 对称。
|||
||| Miért nem „CPT" a rekord neve?
||| Mert a rövidítések tiltva vannak.
||| A „CPT" kivétel (standard fizikai terminus),
||| de itt a teljes magyar nevet használjuk a típusra.
||| 为何记录名不是「CPT」？因为缩写被禁止。「CPT」是例外
||| （标准物理术语），但这里对类型使用完整的匈牙利语名称。
public export
record ToltesParitasIdo where
  constructor ToltesParitasIdoKonstruktor
  toltes  : HaromKubit  -- C: sajat tudat (ki vagyok en)
  paritas : HaromKubit  -- P: masik fel (ki vagy te)
  ido     : HaromKubit  -- T: kapcsolat fazisa (hogyan kapcsolodunk)

||| ToltesParitasIdo igazság-érték (100.01: a meztelen Bool → Igazság):
||| ha a toltes és a paritas fázisa megegyezik, akkor a rendszer saját
||| tudata rezonanciában van a külsővel — nincs információvesztés.
||| ToltesParitasIdo 的真值（100.01：裸 Bool → Igazság）：
||| 若 toltes 与 paritas 的相位一致，则系统的自我意识与外部共振——无信息损失。
public export
toltesParitasIdoKoherens : ToltesParitasIdo -> Igazság
toltesParitasIdoKoherens tpi =
  azonosFázis tpi.toltes tpi.paritas

||| ToltesParitasIdo irány: a toltes és paritas között.
||| Ha a toltes irányul a paritas felé, akkor
||| a rendszer aktív (információt küld).
||| Ha a paritas irányul a toltes felé, akkor
||| a rendszer passzív (információt fogad).
||| ToltesParitasIdo 的方向：在 toltes 与 paritas 之间。
||| toltes 指向 paritas → 系统主动（发送信息）；
||| paritas 指向 toltes → 系统被动（接收信息）。
public export
toltesParitasIdoIrany : ToltesParitasIdo -> Irány
toltesParitasIdoIrany tpi = irány tpi.toltes tpi.paritas

||| Fázis-faktoriális: egy ToltesParitasIdo fázismértéket
||| számol a HaromKubitok összefedéséből.
||| Ez az „általános koherencia" mértéke.
||| 相位阶乘：由 HaromKubit 的重叠计算 ToltesParitasIdo 的相位测度。
||| 这是「广义相干性」的度量。
public export
fazisFaktorialis : ToltesParitasIdo -> Double
fazisFaktorialis tpi =
  let ct = azonosFázis tpi.toltes tpi.ido
      pt = azonosFázis tpi.paritas tpi.ido
  in case (ct, pt) of
    (Igaz, Igaz) => 1.0
    (Igaz, Hamis) => 0.5
    (Hamis, Igaz) => 0.5
    (Hamis, Hamis) => 0.0

-- ─── FÁZISHATÁR = LEGENDRE-PEREM ──────────────────────────
-- 相变边界 = 勒让德边界
-- A fázishatár az a felület, ahol két fázis találkozik.
-- 相变边界是两个相相遇的面。
-- A fizikában: szilárd/folyékony, folyékony/gáz, kvantum/klasszikus.
-- 物理中：固/液、液/气、量子/经典。
-- A mi keretrendszerünkben: a fázishatár = a Legendre-perem.
-- 在我们的框架中：相变边界 = 勒让德边界。
--   A peremen átlépve a rendszer egyik fázisból a másikba megy át:
--   跨过边界，系统从一个相进入另一个相：
--     komplex (kvantum) → fázishatár (perem, p·q̇) → valós (klasszikus)
--     复（量子）→ 相变边界（边界，p·q̇）→ 实（经典）
--     folytonos (∫) → fázishatár (perem) → diszkrét (Σ)
--     连续（∫）→ 边界 → 离散（Σ）
--     emberi (L) → fázishatár (perem) → számítási (H)
--     人的（L）→ 边界 → 计算的（H）
--     gondolat → fázishatár (száj) → beszéd
--     思想 → 相变边界（口）→ 言语
--
-- A fázishatár a [[7,1,3]] kódban a 6. bit (fázis-pozíció).
-- A fázis bit dönti el, hogy a kód melyik fázisban van.
-- 相变边界在 [[7,1,3]] 码中是第 6 位（相位位置）。相位位决定码处于哪个相。
-- A fázishatár átlépése = a Legendre-transzformáció = a mérés aktusa.
-- 跨越相变边界 = 勒让德变换 = 测量的行为。

||| Fázishatár: két fázis közti átmenet.
|||   A fázishatár a perem — ahol a rendszer egyik állapotból
|||   a másikba vált. A Legendre-transzformáció = a fázishatár átlépése.
||| 相变边界：两个相之间的转变。边界是系统从一个态跃迁到另一个态之处。
||| 勒让德变换 = 跨越相变边界。
public export
record FazisHatar where
  constructor FazisHatarKonstruktor
  balFazis  : Fazis   -- a fázishatár ELŐTTI állapot / 相变边界之前的态
  jobbFazis : Fazis   -- a fázishatár UTÁNI állapot / 相变边界之后的态
  peremErtek : Double  -- a fázishatár értéke (p·q̇ = Legendre-perem) / 边界值（p·q̇ = 勒让德边界）

||| Fázisátalakulás a fázishatáron keresztül.
|||   Azonos → Ellentétes: a redundáns információ átadódik.
|||   Kvantalt → Azonos: az összefonódás feloldódik.
|||   Ismeretlen → Kvantalt: az ismeretlenből tudás lesz.
||| 穿越相变边界的相变。同相 → 反相：冗余信息被传递；
||| 量子化 → 同相：纠缠解开；未知 → 量子化：未知成为知识。
public export
fazisAtlepes : FazisHatar -> Fazis
fazisAtlepes (FazisHatarKonstruktor _ jobb _) = jobb

||| A fázishatár mint a Clifford-szorzat.
|||   a·b (átfedés) → fázishatár (ha magas, redundáns) → eldobás
|||   a∧b (újdonság) → fázishatár (ha magas, információ) → megtartás
|||   A fázishatár = az átfedés és az újdonság közti választás.
||| 相变边界作为 Clifford 乘积。a·b（重叠）→ 高则冗余 → 丢弃；
||| a∧b（新颖）→ 高则信息 → 保留。相变边界 = 重叠与新颖之间的抉择。
public export
fazisHatarClifford : Double -> Double -> Fazis
fazisHatarClifford atfedes ujdonsag =
  if atfedes > ujdonsag then Azonos else Kvantalt

-- ─── ELSŐRENDŰ FÁZISÁTMENET ───────────────────────────────
-- 一阶相变
-- https://en.wikipedia.org/wiki/Phase_transition
-- Elsőrendű fázisátmenet: a szabadenergia ELSŐ deriváltja
-- (entrópia vagy térfogat) ugrik a fázishatáron.
-- 一阶相变：自由能的一阶导数（熵或体积）在相变边界处跳变。
-- Másodrendű: a MÁSODIK derivált ugrik (pl. fajhő).
-- 二阶：二阶导数跳变（如比热）。
--
-- A Legendre-transzformáció mint elsőrendű fázisátmenet:
-- 勒让德变换作为一阶相变：
--   U(S,V) → F(T,V): S → T csere. Az entrópia S = -∂F/∂T
--   ugrik a fázishatáron (a látens hő).
--   U(S,V) → F(T,V)：S → T 交换。熵 S = -∂F/∂T 在边界处跳变（潜热）。
--   A perem p·q̇ = az ugrás mértéke.
--   边界 p·q̇ = 跳变的量度。
--
-- Példa: víz fagyása 0 °C-on.
--   F_folyadék(T) ≠ F_jég(T) a fázishatáron.
--   A különbség = a látens hő = a perem.
--   例：水在 0 °C 结冰。液相与固相的自由能在边界处不等。
--   其差 = 潜热 = 边界。

||| Elsőrendű fázisátmenet: a potenciál első deriváltja ugrik.
|||   A Legendre-perem a két fázis közti különbség.
|||   dF = -S·dT - p·dV → az entrópia (S) az első derivált.
||| 一阶相变：势函数的一阶导数跳变。勒让德边界 = 两相之差。
public export
elsoRenduFazisAtmenet : Double -> Double -> Double
elsoRenduFazisAtmenet f1 f2 = f2 - f1  -- a kulonbseg = a perem

-- ─── ELSŐRENDŰ LOGIKA (CURRY-HOWARD) ─────────────────────
-- 一阶逻辑（Curry–Howard）
-- Elsőrendű logika: ∀ (minden) és ∃ (létezik) kvantorok.
-- 一阶逻辑：∀（一切）与 ∃（存在）量词。
-- Curry-Howard: ∀ = Pi-típus (függő szorzat), ∃ = Szigma-típus (függő összeg).
-- Curry–Howard：∀ = Pi 类型（依变乘积），∃ = Szigma 类型（依变求和）。
-- Idris-ben: (x : A) -> B x a ∀, és (x : A ** B x) a ∃.
-- A [[7,1,3]] Steane-kód: ∀ k : Kubit. steaneDekodol(javitas(alapKod k, hiba)) = k.
-- Ez a Noether-tétel mint elsőrendű logikai állítás.
-- 这就是作为一阶逻辑命题的诺特定理。

||| Univerzális kvantor (∀) mint Pi-típus.
|||   Curry-Howard: ∀x.P(x) = (x : A) -> P(x).
|||   A típus a bizonyítás: minden x-re P(x) teljesül.
|||   A Steane-kódban: ∀ k, ∀ hiba. dekodol(javit(kodol(k), hiba)) = k.
||| 全称量词（∀）作为 Pi 类型。类型即证明：对一切 x，P(x) 成立。
||| 在 Steane 码中：∀ k，∀ hiba。dekodol(javit(kodol(k), hiba)) = k。
public export
minden : (a : Type) -> (p : a -> Type) -> Type
minden a p = (x : a) -> p x

||| Egzisztenciális kvantor (∃) mint Szigma-típus.
|||   Curry-Howard: ∃x.P(x) = (x : a ** P(x)).
|||   A tanú (witness) x és a bizonyítás P(x).
||| 存在量词（∃）作为 Szigma 类型。见证者（witness）x 与证明 P(x)。
public export
letezik : (a : Type) -> (p : a -> Type) -> Type
letezik a p = (x : a ** p x)
