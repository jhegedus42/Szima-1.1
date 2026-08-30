module SzintaxisMorfizmus_v1

-- ═══════════════════════════════════════════════════════════════
-- SZINTAXISMORFIZMUS v1 — a kompozíció typeclass-a: Fogalom → Fogalom
-- átmenet TÜKRÖZÉSEL (a 3 dimenziós nyelv harmadik emelete,
-- a terv 2. szakasza, W8)
-- SYNTAX MORPHISM v1 — the composition typeclass: concept → concept
-- transition by REFLECTION
-- 句法态射 v1 — 组合类型类：以镜射实现概念到概念的转移
-- SYNTAXMORPHISMUS v1 — die Typklasse der Komposition
-- מורפיזם תחביר v1 — מחלקת-הטיפוס של ההרכבה
-- ═══════════════════════════════════════════════════════════════
--
-- A TERV (docs/HaromDimenziosNyelv_Terv.md, 2.1–2.2 szakasz — W8):
--   SzintaxisMorfizmus typeclass: komponál (σ_α(β) tükrözés) és
--   ellenpont (β ↦ −β); a „mondat" = láncolt kompozíció:
--   Mondat = β₀ →ᵅ¹ β₁ →ᵅ² β₂ → … →ᵅⁿ βₙ (a mondat értelme a
--   végpont ÉS az út; az α₁…αₙ sorozat = a mondat szórendje).
--
-- A TÜKRÖZÉS FORRÁSA (§24 — IMPORT, NEM ÚJRAÍRÁS):
--   A projektben a tükrözés két, párhuzamos típusvonalon él:
--     - E8BelsoSzorzat.weylReflexio : E8Gyok → E8Gyok → E8Gyok
--       (ékezet nélküli vonal — a GyökSzó/Fogalom vonala; EZT
--       importáljuk: a GyökSzó.jel típusa E8Gyok);
--     - E8Tükrözések.weylTükrözés : E8Gyök → E8Gyök → E8Gyök
--       (ékezetes vonal — a fázis-átmenet-nézet; típusában nem
--       kompatibilis a GyökSzó-vonallal, ezért ide NEM importáljuk;
--       l. a terv §6.3 nyitott kérdését a kanonikus vonalról).
--   Mindkettő ugyanazt a Weyl-tükrözést valósítja meg (a 2-szeres
--   skálán σ_α(β) = β − (⟨α,β⟩/4)·α); a SzintaxisMorfizmus a
--   GyökSzó-vonal IMPORTÁLT tükrözésével számol — semmi új tükrözés
--   nem íródik ide.
--
-- A D8-PÁLYA ÉS A TÜKRÖZÉS (a Fogalom_v1 kutatási indoklása folytán):
--   A W(E8) a 240 gyökön EGY tranzitív pálya (a teljes pálya triviális
--   információ), a W(D8) = 2⁷·8! részcsoport KÉT pályát lát (112 egész
--   + 128 fél-egész; forrás: http://www.madore.org/~david/math/e8w.html,
--   https://en.wikipedia.org/wiki/E8_lattice). A W(E8)-tükrözés ezért
--   ÁTLÉP a két D8-pálya között — a pálya a fogalom mondatbeli
--   ÁLLAPOTA (bizPályaváltás alább demonstrálja), a kategória viszont
--   a fogalom identitása: a komponál MEGTARTJA (interface-törvény).
--
-- §24 (KÓD DUPLIKÁCIÓ TILOS): weylReflexio, gyokEllentett (E8Belso-
--   Szorzat), GyökSzó/szóOsztályMeghatároz/Példa*-konstansok (GyokSzo_v1),
--   Fogalom/pályaOsztályból/fogalommáEmel (Fogalom_v1), e8Gyokok
--   (E8Gyokok_v2) MIND IMPORTÁLVA. A where-lánc transzparenciája
--   miatt az E8BelsoSzorzat KÖZVETLEN importja kötelező (l. a
--   ProbeFogalomTavolsag tanulságát: transitív importnál a where-es
--   jelentésTávolság Refl-típusbeli normalizációja elakad).
-- §18 (KÉT FÜGGETLEN ÚT, EGY HÍD): az involúció-bizonyítások bal
--   oldala a KÉTSZERES tükrözés-kompozíció kifejtése (a kernel
--   végigszámolja: belső szorzat → egész osztás → koordináta-
--   aritmetika), a jobb oldal az EREDETI konstans; a pályaváltás-
--   bizonyítás bal oldala a tükrözés + pálya-újraszámolás, jobb
--   oldala a D8-osztály-konstans. Nincs X = X.
-- §13: EZ EGY ÚJ MODUL — minden korábbi modul érintetlenül marad.
-- ═══════════════════════════════════════════════════════════════

import Fogalom_v1      -- Fogalom, D8Pálya, pályaOsztályból, fogalommáEmel, fogalomTár (§24)
import GyokSzo_v1      -- GyökSzó, szóOsztály, szóOsztályMeghatároz, Példa*-konstansok (§24)
import E8BelsoSzorzat  -- weylReflexio, gyokEllentett, Eq E8Gyok (§24 — KÖZVETLEN: where-lánc!)
import E8Gyokok_v2     -- e8Gyokok (a futásidejű zártsági kimerítőhöz), E8GyokKonstruktor
import Kategoriak.MagyarOntologia -- IndividuumJK, CselekvesJK (§24 — KÖZVETLEN, a Refl-típushoz)
import Data.List       -- foldl, elem, filter, length (§24: standard, nem újraírva)

%default covering

-- ===============================================================
-- 1. A SZINTAXISMORFIZMUS TYPECLASS (terv §2.1)
--    The syntax-morphism typeclass · 句法态射类型类
--    Die Typklasse der Syntaxmorphismen · מחלקת-הטיפוס של מורפיזם התחביר
-- ===============================================================

||| A NYELV SZINTAXISA: a művelet, amellyel két jelből új jel keletkezik
||| (terv §2.1). Két művelet:
|||   komponál  α β = σ_α(β) — β tükrözése az α tengelyre
|||                 (a 2-szeres skálán β − (⟨α,β⟩/4)·α);
|||   ellenpont β  = −β — az ellentett jel (az e^{iπ}·β fázis-lépés).
||| A törvények (a terv §2.1 matematikai indoklása):
|||   ZÁRTSÁG: komponál α β ismét a nyelv jele (sosem vezet a
|||     nyelven kívülre — futásidejű kimerítő alább);
|||   INVERTÁLHATÓSÁG: komponál α (komponál α β) = β (involúció —
|||     kernel-Refl alább); minden mondat visszabontható;
|||   KATEGÓRIA-MEGTARTÁS: a komponál a kategóriát (a fogalom
|||     identitását) megtartja, csak a pályát (az állapotot) váltja.
||| 语言的句法：由两个符号生成新符号的运算（组合与对极）。
public export
interface SzintaxisMorfizmus (fogalomTípus : Type) where
  komponál : fogalomTípus -> fogalomTípus -> fogalomTípus
  ellenpont : fogalomTípus -> fogalomTípus

-- ===============================================================
-- 2. A GYÖKSZÓ-INSTANCE — A TÜKRÖZÉS IMPORTÁLVA (§24)
--    The GyökSzó instance · 词根词实例 · Die GyökSzó-Instanz
-- ===============================================================

||| A tükrözés a jel (GyökSzó) szintjén: az IMPORTÁLT weylReflexio
||| számol (E8BelsoSzorzat — §24); a szóosztályt az új jelből az
||| IMPORTÁLT szóOsztályMeghatároz határozza meg újra (a tükrözés
||| osztályt válthat! — kevert párok, terv §1.3).
||| 镜射在词根词层：用导入的 weylReflexio 计算。
public export
SzintaxisMorfizmus GyökSzó where
  komponál tengely tükrözöttSzó =
    GyökSzóKonstruktor (weylReflexio (jel tengely) (jel tükrözöttSzó))
                       (szóOsztályMeghatároz (weylReflexio (jel tengely) (jel tükrözöttSzó)))
  ellenpont tükrözöttSzó =
    GyökSzóKonstruktor (gyokEllentett (jel tükrözöttSzó))
                       (szóOsztályMeghatároz (gyokEllentett (jel tükrözöttSzó)))

-- ===============================================================
-- 3. A FOGALOM-INSTANCE — PÁLYA-FRISSÍTÉS, KATEGÓRIA-MEGTARTÁS
--    The concept instance · 概念实例 · Die Begriff-Instanz
-- ===============================================================

||| A tükrözés a fogalom szintjén: a szó a GyökSzó-instance-nal
||| tükröződik; a pálya ÚJRASZÁMÍTÓDIK az új jel osztályából
||| (pályaOsztályból-híd — a D8-pálya az állapot, és a W(E8)-
||| tükrözés átléphet a két osztály közt); a kategória MEGMARAD
||| (a fogalom identitása — a „ragozott alak" ugyanarról a fogalomról
||| szól, csak más pálya-állapotban; terv §3.2).
||| 镜射在概念层：轨道更新，范畴保持。
public export
SzintaxisMorfizmus Fogalom where
  komponál tengelyFogalom tükrözöttFogalom =
    FogalomKonstruktor (komponál (gyökSzó tengelyFogalom) (gyökSzó tükrözöttFogalom))
                       (pályaOsztályból (szóOsztály (komponál (gyökSzó tengelyFogalom) (gyökSzó tükrözöttFogalom))))
                       (kategória tükrözöttFogalom)
  ellenpont tükrözöttFogalom =
    FogalomKonstruktor (ellenpont (gyökSzó tükrözöttFogalom))
                       (pályaOsztályból (szóOsztály (ellenpont (gyökSzó tükrözöttFogalom))))
                       (kategória tükrözöttFogalom)

-- ===============================================================
-- 4. A MONDAT — LÁNCSOLT KOMPOZÍCIÓ (terv §2.2)
--    The sentence — chained composition · 句子——链式组合
--    Der Satz — verkettete Komposition · המשפט — הרכבה שרשרתית
-- ===============================================================

||| A MONDAT: kezdőfogalomból induló, tükrözések láncolta sor —
||| β₀ →ᵅ¹ β₁ → … →ᵅⁿ βₙ. A tükrözésSor a mondat SZÓRENDJE
||| (a tükrözési tengelyek jelekben); a mondat értelme a VÉGPONT
||| ÉS az út (terv §2.2). A CPT-időbélyeg és a Steane-védelem a
||| Mondat_v1 modul tárgya (terv §5.4) — itt a lánc típusa él.
||| 句子：以镜射链连接的序列——起点与词序。
public export
record Mondat where
  constructor MondatKonstruktor
  kezdőFogalom : Fogalom
  tükrözésSor  : List GyökSzó

||| A mondat VÉGPONTJA: a láncolt kompozíció kiszámítása — a
||| tükrözésSor minden tengelye (jel) fogalommá emelkedik (importált
||| fogalommáEmel — §24), és balról komponálódik (foldl).
||| A mondat értelmezése: a végpontfogalom pálya-állapota az egész
||| lánc eredménye. (DEFINÍCIÓ A HASZNÁLAT ELŐTT — a Show Mondat
||| alább hívja; magyar-matematika skill §3.)
||| 句子的终点：链式组合的计算（左折叠）。
public export
mondatVégpont : Mondat -> Fogalom
mondatVégpont (MondatKonstruktor kezdő tükrözésSor) =
  foldl (\tükrözöttFogalom, tengely =>
           komponál (fogalommáEmel tengely) tükrözöttFogalom)
        kezdő tükrözésSor

||| A mondat megjelenítése: kezdő, a tükrözések száma, végpont.
public export
Show Mondat where
  show (MondatKonstruktor kezdő tükrözésSor) =
    "Mondat ‹kezdő: " ++ show kezdő ++ "; "
      ++ show (List.length tükrözésSor) ++ " tükrözés; végpont: "
      ++ show (mondatVégpont (MondatKonstruktor kezdő tükrözésSor)) ++ "›"

-- ─── 4a. Példamondat (nagybetűs konstans — KisBetűsProjekcióCsapda) ──

||| A példamondat: PéldaEgészFogalomból indul, két tükrözés:
||| (1⁸)-tal (fél-egész tengely!) átível a másik D8-pályára:
|||   (2,2,0⁶) → σ_{(1⁸)} → (1,1,−1⁶)   [fél-egész pálya]
||| majd (2,2,0⁶)-tal vissza a fél-egész osztály BELSEJÉBEN:
|||   (1,1,−1⁶) → σ_{(2,2,0⁶)} → (−1)⁸  [fél-egész pálya marad].
||| A végpont (−1)⁸ — a pálya kétszer váltott, a kategória
||| (egyed) megmaradt: a mondat „ragozott alak"-ja.
public export
RövidMondatKonst : Mondat
RövidMondatKonst = MondatKonstruktor PéldaEgészFogalom [PéldaFélEgészSzó, PéldaEgészSzó]

-- ===============================================================
-- 5. BIZONYÍTÁSOK — KÉT FÜGGETLEN ÚT, EGY HÍD (§18)
--    Proofs — two independent paths, one bridge
--    证明——两条独立道路，一座桥 · Beweise — zwei Wege, eine Brücke
-- ===============================================================

-- ─── 5a. Az involúció: σ_α ∘ σ_α = identitás ────────────────────
--    A bal oldal a KÉTSZERES tükrözés kifejtése (a kernel a belső
--    szorzatot, az egész osztást és a koordináta-aritmetikát
--    végigszámolja), a jobb oldal az EREDETI konstans — két
--    fogalmilag különböző konstrukció kényszerített találkozása.

-- Kimenet: Refl — involúció a JELEN, β ≠ α esetre (nem triviális:
-- (2,2,0⁶) → (1,1,−1⁶) → (2,2,0⁶); az első lépés át is lép a
-- D8-pályán, a második visszahozza).
public export
bizInvolúcióSzón :
  komponál PéldaFélEgészSzó (komponál PéldaFélEgészSzó PéldaEgészSzó) = PéldaEgészSzó
bizInvolúcióSzón = Refl

-- Kimenet: Refl — involúció a FOGALOMON: a pálya kétszer vált
-- (egész → fél-egész → egész), a kategória sosem — a végpont az
-- ERREDETIVAL rekordonként azonos.
public export
bizInvolúcióFogalmon :
  komponál PéldaFélEgészFogalom (komponál PéldaFélEgészFogalom PéldaEgészFogalom)
    = PéldaEgészFogalom
bizInvolúcióFogalmon = Refl

-- ─── 5b. Az ellenpont: β ↦ −β ↦ β ───────────────────────────────

-- Kimenet: Refl — az ellenpont négyzete az identitás a fogalmon
-- (a szóosztály-újraszámolással együtt: (1⁸) → (−1)⁸ → (1⁸)).
public export
bizEllenpontNégyzet :
  ellenpont (ellenpont PéldaFélEgészFogalom) = PéldaFélEgészFogalom
bizEllenpontNégyzet = Refl

-- Kimenet: Refl — az ellenpont a D8-PÁLYÁT ŐRZI: (−1)⁸ nyolc
-- mínusszal — a mínusszám PÁROS marad (8 páros!), tehát a fél-egész
-- osztály belsejében marad. A bal oldal a pálya ÚJRASZÁMOLÁSA
-- (elem-keresés a típus-1 listán), a jobb oldal a D8-osztály-konstans.
public export
bizEllenpontPályaMegtartás :
  pálya (ellenpont PéldaFélEgészFogalom) = FélEgészGyökPálya
bizEllenpontPályaMegtartás = Refl

-- ─── 5c. A pályaváltás: a W(E8)-tükrözés átlép a D8-pályákon ──
--    (ez az oka, hogy a pálya a fogalom ÁLLAPOTA, nem invariánsa —
--    l. a Fogalom_v1 kutatási fejlécét: a W(D8) két pályát lát,
--    a W(E8) egyet; a teljes csoport tükrözése összekeveri őket).

-- Kimenet: Refl — PÁLYAVÁLTÁS: az egész fogalmat fél-egész tengellyel
-- tükrözve fél-egész pályára kerül: (2,2,0⁶) → (1,1,−1⁶).
-- Bal: a tükrözés + pálya-újraszámolás; jobb: a D8-osztály-konstans.
public export
bizPályaváltás :
  pálya (komponál PéldaFélEgészFogalom PéldaEgészFogalom) = FélEgészGyökPálya
bizPályaváltás = Refl

-- ─── 5d. A mondat végpontja: a lánc kifejtése ⟷ enumerált gyök ──

-- Kimenet: Refl — a példamondat végpontja (−1)⁸: a bal oldal a
-- KÉTLÉPCSŐS lánc kifejtése (át a másik pályán, vissza a fél-egész
-- osztály belsejébe), a jobb oldal a teljes kiírt fogalom-rekord
-- (az enumerált (−1)⁸ gyök — a tipus2Gyokok egy tagja — fél-egész
-- pályával, a kezdő fogalom kategóriájával: egyed).
public export
bizMondatVégpont :
  mondatVégpont RövidMondatKonst =
    FogalomKonstruktor
      (GyökSzóKonstruktor (E8GyokKonstruktor (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1)) FélEgészGyökSzó)
      FélEgészGyökPálya
      IndividuumJK
bizMondatVégpont = Refl

-- ===============================================================
-- 6. FUTÁSIDEJŰ KIMERÍTŐ ELLENŐRZÉSEK (GAUGE-elv, §18b)
--    Exhaustive runtime checks · 运行时穷举检查
--    Erschöpfende Laufzeitprüfungen · בדיקות ממצות בזמן ריצה
-- ===============================================================

||| ZÁRTSÁG a fogalom-szinten: mind a 240×240 = 57 600 komponálás
||| eredménye a NYELV jele-e (az új jel gyöke benne van-e az
||| IMPORTÁLT e8Gyokok 240-es listájában — §24). Az importált
||| zarasHibakSzama (E8BelsoSzorzat) a gyök-vonalon mérte ugyanezt;
||| ez itt a fogalom-vonalon FÜGGŐ UTASKÉNT ellenőrzi. Várt: 0.
||| 封闭性：全部 57 600 次组合的结果仍是语言的符号。
public export
komponálásZártságiHibákSzáma : Nat
komponálásZártságiHibákSzáma =
  length (filter not
    [ elem (jel (gyökSzó (komponál tengely tükrözött))) e8Gyokok
    | tengely <- fogalomTár, tükrözött <- fogalomTár ])

||| INVERTÁLHATÓSÁG globálisan: mind a 240×240 dupla komponálás
||| visszadja-e az EREDETI jelet (involúció — a kernel-Refl
||| bizInvolúció* konkrét eseteinek futásidejű teljese). Várt: 0.
||| 可逆性：所有双重组合都还原原符号（全局对合）。
public export
involúcióHibákSzáma : Nat
involúcióHibákSzáma =
  length (filter not
    [ jel (gyökSzó (komponál tengely (komponál tengely tükrözött)))
        == jel (gyökSzó tükrözött)
    | tengely <- fogalomTár, tükrözött <- fogalomTár ])

||| AZ ELLENPONT PÁLYA-ŐRZÉSE globálisan: mind a 240 ellenpontolt
||| fogalom pályája egyezik-e az eredetivel (a pálya ÚJRASZÁMOLT
||| az új jelből — nem a rekordból másolt, tehát ez a D8-pálya
||| ellentett-invarianciájának kimerítő mérése). Várt: 0.
||| 对极保持轨道（全局）：240 个概念的轨道在取对极后不变。
public export
ellenpontPályaHibákSzáma : Nat
ellenpontPályaHibákSzáma =
  length (filter (\fogalom => pálya (ellenpont fogalom) /= pálya fogalom) fogalomTár)

-- ===============================================================
-- 7. A MAIN — RÖVID MONDAT FELÉPÍTÉSE ÉS KIÍRÁSA (GAUGE-elv)
--    main — building and printing a short sentence
--    主函数——构建并输出一个短句 · Hauptprogramm — ein kurzer Satz
-- ===============================================================

main : IO ()
main = do
  putStrLn "═══ SZINTAXISMORFIZMUS v1 — komponál · ellenpont · Mondat (W8) ═══"
  putStrLn ""
  putStrLn "-- 1. A tükrözés: egy lépés átível a D8-pályákon (kernel-Refl, §18):"
  putStrLn ("   komponál (1⁸) (2,2,0⁶) = "
    ++ show (komponál PéldaFélEgészSzó PéldaEgészSzó)
    ++ "   [pálya: egész → fél-egész; Refl: bizPályaváltás]")
  putStrLn ("   ellenpont (1⁸)          = "
    ++ show (ellenpont PéldaFélEgészSzó)
    ++ "   [pálya marad; Refl: bizEllenpontPályaMegtartás]")
  putStrLn ""
  putStrLn "-- 2. Az involúció (σ∘σ = id — a mondat visszabontható):"
  putStrLn ("   komponál (1⁸) (komponál (1⁸) (2,2,0⁶)) = "
    ++ show (komponál PéldaFélEgészSzó (komponál PéldaFélEgészSzó PéldaEgészSzó))
    ++ "   [Refl: bizInvolúcióSzón]")
  putStrLn ("   fogalomon: komponál∘komponál visszaadja PéldaEgészFogalmat"
    ++ "   [Refl: bizInvolúcióFogalmon]")
  putStrLn ""
  putStrLn "-- 3. A példamondat (kezdő + 2 tükrözés):"
  putStrLn ("   " ++ show RövidMondatKonst)
  putStrLn "   A lánc: (2,2,0⁶) →σ(1⁸)→ (1,1,−1⁶) →σ(2,2)→ (−1)⁸"
  putStrLn ("   végpont pályája: " ++ show (pálya (mondatVégpont RövidMondatKonst))
    ++ "   [Refl: bizMondatVégpont; a kategória (egyed) megmaradt]")
  putStrLn ""
  putStrLn "-- 4. Kimerítő futásidejű ellenőrzések (GAUGE-elv):"
  putStrLn ("   zártságsértő komponálások (240×240):   "
    ++ show komponálásZártságiHibákSzáma ++ "   (várható: 0)")
  putStrLn ("   involúciósértések (240×240):           "
    ++ show involúcióHibákSzáma ++ "   (várható: 0)")
  putStrLn ("   ellenpont pályaváltásai (240):         "
    ++ show ellenpontPályaHibákSzáma ++ "   (várható: 0)")
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
