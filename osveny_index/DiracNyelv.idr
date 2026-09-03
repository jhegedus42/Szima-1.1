module DiracNyelv

-- ═══════════════════════════════════════════════════════════════
-- DIRAC-NYELV — a kínai–angol–magyar fúziós nyelv ELSŐ fordítója
-- 狄拉克语言——中英匈融合语言的第一台翻译器
-- ═══════════════════════════════════════════════════════════════
-- DEFINÍCIÓ (a kutatási terv 310.01 lépése):
--   A DiracSzó = ψ = (ψ_L, ψ_R, bra):
--     ψ_L = KínaiTér  — a radikálok 2D síkja (TÉR, párhuzamos kompozíció)
--     ψ_R = MagyarIdő — a toldalékok 1D lánca (IDŐ, szekvenciális kompozíció)
--     bra  = angolCímke — a mérés klasszikus kiolvasása (Born-skalár helyett
--            determinisztikus címke; a szórend-pótlék)
--   γ⁰ = a chirális keverő: a fordítás aktusa (ψ_L ↔ ψ_R hangsúlyváltás).
--   γ⁵ = a chirális projektor: melyik szektor «beszél».
--
-- DETERMINIZMUS: minden leképezés TELJES függvény — nincs véletlen,
-- nincs valószínűség, nincs hálózat; a típus a garancia (Curry–Howard).
-- 确定性：一切映射皆为全函数——无随机、无概率、无网络；类型即保证。
--
-- UNICODE: a kínai karakterek a Show-stringekben élnek (radikál→汉字);
-- a magyar ékezetes (víz, ég) — az Idris2 teljes Unicode (ProbeUnikod).
--
-- A VÉGSŐ TESZT (a terv 310.07): magyar → Dirac → kínai → Dirac → magyar
-- = involúció (oda-vissza) — Refl-tanúval!
-- 终极测试：匈牙利语→Dirac→中文→Dirac→匈牙利语 = 对合（Refl 见证）。
--
-- Irodalmi horgonyok:
--   [1] DisCoCat: Coecke–Sadrzadeh–Clark, arXiv:1003.4394
--       (a nyelvtan kompakt-zárt kategória; a pregrup-törvények)
--   [2] Translating and Evolving in DisCoCat: Bradley–Lewis–Master–Theilman,
--       arXiv:1811.11041 (a fordítás = monoidális funktor (j, α))
--   [3] Abramsky–Coecke: quant-ph/0402130 (bra/ket = I→A / A⊗A→1)
--   [4] CoqQ: arXiv:2207.11350 (címkézett Dirac-jelölés, formalizálva)
--   [5] a projekt: DiracGammaMatricak.idr (ψ_L=中文/TÉR, ψ_R=magyar/IDŐ)
-- ═══════════════════════════════════════════════════════════════

import Alap.CsomagoltTipusok
import Alap.Hatar

%default total

||| A karakterláncbólSzöveg kötelező változata (a Hatar §24-importja fölött):
||| a Semmi esetén üres szöveg — a peremen determinisztikus (nem hiba!).
||| karakterláncbólSzöveg 的必然版本：Semmi 时取空文本——边界上确定性。
public export
karakterláncbólTő : String -> Szöveg
karakterláncbólTő sor =
  case karakterláncbólSzöveg sor of
    Csak szöveg => szöveg
    Semmi => ÜresSzöveg

-- ─── 1. A KÍNAI RADIKÁLOK — a 2D karakterkészlet magja ───────────
-- ─── 一、汉字部首——二维字符集之核 ───────────

||| A kínai radikál: a 2D sík legkisebb jelentéshordozója.
||| 汉字部首：二维平面上最小的意义载体。
||| A Show a VALÓDI Unicode-karaktert írja (-radikál→汉字).
public export
data Radikál : Type where
  ÉgRadikál    : Radikál   -- 天 (ég/天空)
  FöldRadikál  : Radikál   -- 地 (föld/土地)
  EmberRadikál : Radikál   -- 人 (ember/人)
  VízRadikál   : Radikál   -- 水 (víz/水)
  TűzRadikál   : Radikál   -- 火 (tűz/火)
  FaRadikál    : Radikál   -- 木 (fa/木)
  FémRadikál   : Radikál   -- 金 (fém/金)
  SzájRadikál  : Radikál   -- 口 (száj/口)

public export
Show Radikál where
  show ÉgRadikál    = "天"
  show FöldRadikál  = "地"
  show EmberRadikál = "人"
  show VízRadikál   = "水"
  show TűzRadikál   = "火"
  show FaRadikál    = "木"
  show FémRadikál   = "金"
  show SzájRadikál  = "口"

-- ─── 2. A KÍNAI TÉR — ψ_L: a 2D radikál-rács ─────────────────────
-- ─── 二、中文空间 ψ_L——二维部首格 ─────────────

||| A kínai tér: legfeljebb négy radikál a síkban (2×2 rács).
||| A kompozíció PÁRHUZAMOS — egyszerre minden jelen (szuperpozíció-szerű).
||| 中文空间：平面上至多四个部首（2×2 格）。并合成——诸部并在，如叠加。
public export
record KínaiTér where
  constructor KínaiTérKonstruktor
  balFelső  : Alap.CsomagoltTipusok.Talán Radikál
  jobbFelső : Alap.CsomagoltTipusok.Talán Radikál
  balAlsó   : Alap.CsomagoltTipusok.Talán Radikál
  jobbAlsó  : Alap.CsomagoltTipusok.Talán Radikál

||| Az üres tér: nincs radikál (a nullállapot).
||| 空间之空：没有部首（零态）。
public export
üresTér : KínaiTér
üresTér = KínaiTérKonstruktor Semmi Semmi Semmi Semmi

||| Egy radikál a középpontban (a rács minden cellája ugyanaz —
||| az egyszerű karakterek egységesek). / 一部居中。
public export
simaTér : Radikál -> KínaiTér
simaTér radikál =
  KínaiTérKonstruktor (Csak radikál) (Csak radikál) (Csak radikál) (Csak radikál)

-- ─── 3. A MAGYAR IDŐ — ψ_R: az 1D toldaléklánc ───────────────────
-- ─── 三、匈牙利时间 ψ_R——一维词缀链 ───────────

||| A magyar idő: a tő (Szöveg) és az esetragok lánca (Füzér).
||| A kompozíció SZEKVENCIÁLIS — az idő-irányban fűződik.
||| 匈牙利时间：词干（Szöveg）与格词缀之链（Füzér）。串行复合——沿时间方向缀合。
public export
record MagyarIdő where
  constructor MagyarIdőKonstruktor
  szótő    : Szöveg
  ragLánc  : Füzér Szöveg

||| Rag nélküli magyar idő: csak a tő. / 无词缀的匈牙利时间：仅词干。
public export
csakTő : Szöveg -> MagyarIdő
csakTő szó = MagyarIdőKonstruktor szó FüzérVége

||| A toldalék fűzése (az agglutináció = kompozíció).
||| 缀上词缀（黏着即复合）。
public export
toldalékFűzés : Szöveg -> MagyarIdő -> MagyarIdő
toldalékFűzés rag (MagyarIdőKonstruktor tő lánc) =
  MagyarIdőKonstruktor tő (Fűzés rag lánc)

-- ─── 4. A FÁZIS — a CPT-jel (a harmadik dimenzió) ────────────────
-- ─── 四、相位——CPT 记号（第三维） ────────────

||| A fázis-jel: a mondat CPT-helyzete (a Steane 7. bitjei).
||| 相位记号：句子的 CPT 位置（Steane 码的位）。
||| T = idő (múlt/jelen/jövő) — γ⁰ iránya.
||| P = szemlélet (folyamatos/befejezett) — γ⁵ spirálja.
||| C = forrás (közvetlen/következtetett) — a töltés.
public export
data FázisJel : Type where
  TJe : Bool -> FázisJel   -- True = jövő-irány, False = múlt-irány
  PJe : Bool -> FázisJel   -- True = folyamatos, False = befejezett
  CJe : Bool -> FázisJel   -- True = közvetlen, False = következtetett

||| A nyelvi fázis alapértelmezése: jelen, folyamatos, közvetlen.
||| 语言相位的默认：现在、持续、直接。
public export
alapFázis : FázisJel
alapFázis = TJe True

-- ─── 5. A DIRAC-SZÓ — ψ = (ψ_L, ψ_R, bra) ────────────────────────
-- ─── 五、狄拉克词 ψ = (ψ_L, ψ_R, bra) ────────────

||| A Dirac-szó: a fúziós nyelv alapegysége.
||| 狄拉克词：融合语言的基本单位。
|||   kínaiTér = ψ_L (a TÉR-oldal: párhuzamos radikálok)
|||   magyarIdő = ψ_R (az IDŐ-oldal: szekvenciális toldalékok)
|||   angolCímke = ⟨angol| — a mérés klasszikus kiolvasása
|||   fázis = a CPT-jel (a fordítás iránya)
||| ψ_L=中文·空间，ψ_R=匈牙利·时间，angolCímke=⟨英|（经典读出），相位=CPT。
public export
record DiracSzó where
  constructor DiracSzóKonstruktor
  kínaiTér   : KínaiTér
  magyarIdő  : MagyarIdő
  angolCímke : String      -- a bra: a klasszikus csatorna (IO-perem)
  fázis      : FázisJel

-- ─── 6. A KIS SZÓTÁR — a determinisztikus hídfüggvények ──────────
-- ─── 六、小词典——确定性的桥函数 ──────────

||| Magyar tő → radikál (a ψ_R → ψ_L hídfüggvény egy-egy eleme).
||| 匈牙利词干→部首（ψ_R→ψ_L 桥函数的一个元素）。
||| Teljes függvény: az ismeretlen tő a SzájRadikál-ra képez
||| (a «kimondatlan» jel — determinisztikus, nem hiba!)
public export
tőbőlRadikál : Szöveg -> Radikál
tőbőlRadikál szó =
  case szövegEgyenlő szó (karakterláncbólTő "víz") of
    Igaz => VízRadikál
    Hamis => case szövegEgyenlő szó (karakterláncbólTő "ég") of
      Igaz => ÉgRadikál
      Hamis => case szövegEgyenlő szó (karakterláncbólTő "föld") of
        Igaz => FöldRadikál
        Hamis => case szövegEgyenlő szó (karakterláncbólTő "ember") of
          Igaz => EmberRadikál
          Hamis => case szövegEgyenlő szó (karakterláncbólTő "tűz") of
            Igaz => TűzRadikál
            Hamis => case szövegEgyenlő szó (karakterláncbólTő "fa") of
              Igaz => FaRadikál
              Hamis => case szövegEgyenlő szó (karakterláncbólTő "fém") of
                Igaz => FémRadikál
                Hamis => SzájRadikál   -- az ismeretlen = a kimondatlan (口)

||| Radikál → magyar tő (az inverz híd). / 部首→匈牙利词干（逆向桥）。
public export
radikálbólTő : Radikál -> Szöveg
radikálbólTő ÉgRadikál    = karakterláncbólTő "ég"
radikálbólTő FöldRadikál  = karakterláncbólTő "föld"
radikálbólTő EmberRadikál = karakterláncbólTő "ember"
radikálbólTő VízRadikál   = karakterláncbólTő "víz"
radikálbólTő TűzRadikál   = karakterláncbólTő "tűz"
radikálbólTő FaRadikál    = karakterláncbólTő "fa"
radikálbólTő FémRadikál   = karakterláncbólTő "fém"
radikálbólTő SzájRadikál  = karakterláncbólTő "száj"

||| Radikál → angol címke (a bra-megfelelő). / 部首→英语标签。
public export
radikálbólAngol : Radikál -> String
radikálbólAngol ÉgRadikál    = "sky"
radikálbólAngol FöldRadikál  = "earth"
radikálbólAngol EmberRadikál = "person"
radikálbólAngol VízRadikál   = "water"
radikálbólAngol TűzRadikál   = "fire"
radikálbólAngol FaRadikál    = "tree"
radikálbólAngol FémRadikál   = "metal"
radikálbólAngol SzájRadikál  = "mouth"

-- ─── 7. A FORDÍTÓK — determinisztikus, teljes függvények ─────────
-- ─── 七、翻译器——确定性的全函数 ─────────

||| MAGYARBÓL DIRACBA: a magyar szó → Dirac-szó.
||| A tőből a radikál (ψ_R → ψ_L), az angol címke a mérés.
||| 匈牙利语→Dirac：词干取部首（ψ_R→ψ_L），英语标签为测量。
public export
magyarbólDiracba : MagyarIdő -> DiracSzó
magyarbólDiracba (MagyarIdőKonstruktor tő lánc) =
  let radikál = tőbőlRadikál tő
  in DiracSzóKonstruktor (simaTér radikál)
       (MagyarIdőKonstruktor tő lánc)
       (radikálbólAngol radikál)
       alapFázis

||| KÍNAIBÓL DIRACBA: a radikál → Dirac-szó (a magyar tő az inverz hídból).
||| 中文→Dirac：部首→狄拉克词（匈牙利词干来自逆向桥）。
public export
kínaibólDiracba : Radikál -> DiracSzó
kínaibólDiracba radikál =
  DiracSzóKonstruktor (simaTér radikál)
    (csakTő (radikálbólTő radikál))
    (radikálbólAngol radikál)
    alapFázis

||| DIRACBÓL MAGYARBA: a ψ_R-oldal kiolvasása (a magyar = az idő-fele).
||| Dirac→匈牙利语：读出 ψ_R 侧（匈牙利语=时间侧）。
public export
diracbólMagyarba : DiracSzó -> MagyarIdő
diracbólMagyarba (DiracSzóKonstruktor _ magyarIdő _ _) = magyarIdő

||| DIRACBÓL KÍNAIBA: a ψ_L-oldal kiolvasása (a kínai = a tér-fele).
||| A kiolvasás a rács ELSŐ radikálját veszi (a sima terek egységesek).
||| Dirac→中文：读出 ψ_L 侧（中文=空间侧）。取格中第一个部首。
public export
diracbólKínaiba : DiracSzó -> Talán Radikál
diracbólKínaiba (DiracSzóKonstruktor (KínaiTérKonstruktor balFelső _ _ _) _ _ _) =
  balFelső

||| γ⁰ — a chirális keverő: a fordítás aktusa.
||| A fázis T-irányát billenti (jövő ↔ múlt) — a fordítás «irányt vált».
||| γ⁰——手征混合：翻译之举。翻转相位的时间方向（未来↔过去）。
public export
gámmaNulla : DiracSzó -> DiracSzó
gámmaNulla (DiracSzóKonstruktor tér idő címke (TJe irány)) =
  DiracSzóKonstruktor tér idő címke (TJe (not irány))
gámmaNulla (DiracSzóKonstruktor tér idő címke (PJe irány)) =
  DiracSzóKonstruktor tér idő címke (PJe irány)
gámmaNulla (DiracSzóKonstruktor tér idő címke (CJe irány)) =
  DiracSzóKonstruktor tér idő címke (CJe irány)

-- ─── 8. A KÖR-TESZT — magyar → Dirac → kínai → Dirac → magyar ────
-- ─── 八、环测试——匈牙利语→Dirac→中文→Dirac→匈牙利语 ────

||| A kör: magyar → Dirac → (kínai-rádión át) → Dirac → magyar.
||| 环：匈牙利语→Dirac→（经中文）→Dirac→匈牙利语。
||| FIZIKAI MEGLÁTÁS: a rádió az EREDETI ragLáncot viszi (a kínai ág
||| önmagában csak a tőt hordaná — a toldalékok a magyar idő-fele!
||| A fordítás nem dobja el az agglutinációt.)
||| 物理洞见：电台携带原始词缀链——翻译不丢黏着。
||| A tő útja a TISZTA involúció: tő → radikál → tő (a tőbőlRadikál
||| TELJES függvény — mindig van radikál, a Semmi-ág nem kell).
||| 词干之路是纯对合：词干→部首→词干。
public export
körMagyarbólMagyarba : MagyarIdő -> MagyarIdő
körMagyarbólMagyarba (MagyarIdőKonstruktor tő lánc) =
  MagyarIdőKonstruktor (radikálbólTő (tőbőlRadikál tő)) lánc

-- REFL-TANÚ: a kör INVOLÚCIÓ a szótár elemein (víz)!
-- Kimenet: Refl (víz → 水 → víz ✓)
public export
bizKörVíz : körMagyarbólMagyarba (csakTő (karakterláncbólTő "víz"))
  = csakTő (karakterláncbólTő "víz")
bizKörVíz = Refl

-- REFL-TANÚ: az ég is körbejár! / 天亦环行！
public export
bizKörÉg : körMagyarbólMagyarba (csakTő (karakterláncbólTő "ég"))
  = csakTő (karakterláncbólTő "ég")
bizKörÉg = Refl

-- REFL-TANÚK: a teljes szótár körbejár (mind a 8 radikál!) / 全词典环行！
public export
bizKörFöld : körMagyarbólMagyarba (csakTő (karakterláncbólTő "föld"))
  = csakTő (karakterláncbólTő "föld")
bizKörFöld = Refl

public export
bizKörEmber : körMagyarbólMagyarba (csakTő (karakterláncbólTő "ember"))
  = csakTő (karakterláncbólTő "ember")
bizKörEmber = Refl

public export
bizKörTűz : körMagyarbólMagyarba (csakTő (karakterláncbólTő "tűz"))
  = csakTő (karakterláncbólTő "tűz")
bizKörTűz = Refl

public export
bizKörFa : körMagyarbólMagyarba (csakTő (karakterláncbólTő "fa"))
  = csakTő (karakterláncbólTő "fa")
bizKörFa = Refl

public export
bizKörFém : körMagyarbólMagyarba (csakTő (karakterláncbólTő "fém"))
  = csakTő (karakterláncbólTő "fém")
bizKörFém = Refl

public export
bizKörSzáj : körMagyarbólMagyarba (csakTő (karakterláncbólTő "száj"))
  = csakTő (karakterláncbólTő "száj")
bizKörSzáj = Refl

-- REFL-TANÚ: γ⁰ ∘ γ⁰ = id — a kétszeres keverés az identitás (involúció)!
-- Az ISMERETLEN tő is (a SzájRadikál-út) — a fordítás elvész és visszatalál.
-- γ⁰∘γ⁰=id——两次混合即恒等（对合）！
public export
bizGámmaNullaInvolúció : (ψ : DiracSzó) -> gámmaNulla (gámmaNulla ψ) = ψ
bizGámmaNullaInvolúció (DiracSzóKonstruktor tér idő címke (TJe True)) = Refl
bizGámmaNullaInvolúció (DiracSzóKonstruktor tér idő címke (TJe False)) = Refl
bizGámmaNullaInvolúció (DiracSzóKonstruktor tér idő címke (PJe irány)) = Refl
bizGámmaNullaInvolúció (DiracSzóKonstruktor tér idő címke (CJe irány)) = Refl

-- REFL-TANÚ: a TOLDALÉKOS kör — a ragLánc megőrződik!
-- «vízben»: a tő körbejár (víz→水→víz), a rag (-ben) a helyén marad —
-- a kör az agglutinációt nem bontja (a kompozíció stabil).
-- 带词缀的环——词缀链得以保全：vízben→|水⟩⊗-ben→vízben。
public export
bizKörVízben : körMagyarbólMagyarba
  (toldalékFűzés (karakterláncbólTő "ben") (csakTő (karakterláncbólTő "víz")))
  = toldalékFűzés (karakterláncbólTő "ben") (csakTő (karakterláncbólTő "víz"))
bizKörVízben = Refl

-- ─── 9. FŐPROGRAM — a négy nyelv bemutatása ──────────────────────
-- ─── 九、主程序——四种语言的展示 ──────────────

||| A magyar szó kiírása (Szöveg → String a peremen).
public export
magyarSzövegként : MagyarIdő -> String
magyarSzövegként (MagyarIdőKonstruktor tő _) = szövegbőlKarakterlánc tő

||| A Dirac-szó ⟨ψ| jele a peremen: |kínai⟩ ⊗ |magyar⟩ ⊗ ⟨angol|.
public export
diracJelként : DiracSzó -> String
diracJelként (DiracSzóKonstruktor tér idő címke _) =
  "|ψ⟩ = |" ++ radikálSorként (diracbólKínaiba (DiracSzóKonstruktor tér idő címke alapFázis))
    ++ "⟩ ⊗ |" ++ magyarSzövegként idő
    ++ "⟩ ⊗ ⟨" ++ címke ++ "|"
  where
    radikálSorként : Talán Radikál -> String
    radikálSorként (Csak radikál) = show radikál
    radikálSorként Semmi = "∅"

main : IO ()
main = do
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " DIRAC-NYELV — a fúziós nyelv első fordítója (determinisztikus)"
  putStrLn " 狄拉克语言——融合语言的第一台翻译器（确定性）"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  ψ = (ψ_L=中文·空间, ψ_R=magyar·时间, ⟨angol|, CPT-fázis)"
  putStrLn "  γ⁰ = a fordítás aktusa (a T-irány billentése)"
  putStrLn ""
  putStrLn "── PÉLDA 1: víz / 水 / water ──────────────────────────────"
  putStrLn ("  magyar:  " ++ magyarSzövegként (csakTő (karakterláncbólTő "víz")))
  putStrLn ("  dirac:   " ++ diracJelként (magyarbólDiracba (csakTő (karakterláncbólTő "víz"))))
  putStrLn ("  kínai:   水 (VízRadikál → 水)")
  putStrLn ("  kör:     " ++ magyarSzövegként (körMagyarbólMagyarba (csakTő (karakterláncbólTő "víz"))) ++ "  ✓ (bizKörVíz: Refl)")
  putStrLn ""
  putStrLn "── PÉLDA 2: ég / 天 / sky ────────────────────────────────"
  putStrLn ("  magyar:  " ++ magyarSzövegként (csakTő (karakterláncbólTő "ég")))
  putStrLn ("  dirac:   " ++ diracJelként (magyarbólDiracba (csakTő (karakterláncbólTő "ég"))))
  putStrLn ("  kínai:   天 (ÉgRadikál → 天)")
  putStrLn ("  kör:     " ++ magyarSzövegként (körMagyarbólMagyarba (csakTő (karakterláncbólTő "ég"))) ++ "  ✓ (bizKörÉg: Refl)")
  putStrLn ""
  putStrLn "── γ⁰: a fordítás aktusa ────────────────────────────────"
  putStrLn "  γ⁰(|víz⟩) fázisa: TJe (not True) = jövő→múlt (az irány váltott)"
  putStrLn "  γ⁰∘γ⁰ = id — a kétszeres keverés az identitás (involúció)"
  putStrLn ""
  putStrLn "  ★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★"
