module YonedaBizonyítás_v1

-- ═══════════════════════════════════════════════════════════════
-- YONEDA-BIZONYÍTÁS VÉGES MODELLON — A 4 LÉPÉS REFL-LEL
-- 米田引理在有限模型上的证明——四步全用 Refl
-- ═══════════════════════════════════════════════════════════════
--
-- FORRÁS (a monográfia):
--   docs/FromAlgebrasToExtendedTQFTs_monografia_v1.tex
--   3. fejezet «In-Depth Analysis and Proof of the Yoneda Lemma»
--   (250–312. sor): Φ : Nat(h^A, F) → F(A) és Ψ : F(A) → Nat(h^A, F)
--   konstrukciója, a naturalitás Jacobi-lépcsővel, és az inverzitás
--   (Φ∘Ψ = id, Ψ∘Φ = id). A 4. fejezet «Dualities» (321+. sor) a
--   Yoneda-lemmát a Legendre-transzformáció algebrai kettőséeként
--   folytatja — a pont-leírás és az érintő-sík-leírás kettőssége.
--
-- MINTA (a projekt kánonja):
--   osveny_index/Kategoriak/ZeneKategoria_v2.idr — a véges világ
--   mintája: konstruktoronkénti kimerítő Refl-bizonyítás, a klauzula-
--   fájl a fordítóval folytatott párbeszéd (a «új csapda» szekció:
--   a változó-argumentum beragadása konstruktor-bontás nélkül).
--
-- §24 JELENYK (duplikáció-ellenőrzés, 2026-09-05, grep elvégezve):
--   - KategoriaElmelet.idr:1290 `yonedaEgyertelmu` — CSAK az Φ
--     irány polimorf változata (α ↦ α_a(id_a)), Ψ és inverzitás NINCS.
--     Nem importálom (különböző dimenzió: ott polimorf fogalom, itt
--     a teljes bizonyítás véges világon); hivatkozom (l. alább).
--   - szima_ter/modul/HaromKategoria_v2.idr:52 `YonedaLemma` —
--     név-címke egy fogalomlistában, nem bizonyítás.
--   - Prelude/Data.List: `elem`, `length`, `map` — importálva
--     használom, nem írom újra.
--   Tehát: ez a fájl a projekten belül az ELSŐ teljes 4-lépéses
--   Yoneda-formalizálás; nem felülírás (§13), nem törlés (§20).
--
-- A FORMALIZÁLÁSI DÖNTÉS (math-reasoning `prove`-sablon, konkrét
-- véges modell — ahogy a ZeneKategoria_v2 az asszociativitást):
--   Az ÁLTALÁNOS Yoneda-lemma helyett KONKRÉT, véges kategórián
--   bizonyítunk, ahol minden állítás KIMERÍTŐEN ellenőrizhető Refl-lel:
--     1. a kategória: Alfa → Béta → Gamma lánc, KÉT párhuzamos
--        nyíllal Alfa→Béta (ElsőNyíl, MásodikNyíl) — így a
--        Hom-halmazok nem trivialisak: |Hom(Alfa,Béta)| = 2;
--     2. a funktor F : Kategória → Set: FElem-indexelt típuscsalád,
--        |F(Alfa)| = 2 (nem-degenerált bijekció!), |F(Béta)| = 2,
--        |F(Gamma)| = 3;
--     3. h^Alfa = Hom(Alfa, -) reprezentálható funktor;
--     4. a természetes transzformáció rekordja a komponenseket ÉS a
--        naturalitási tanúkat is hordozza (dependent record) — a
--        rekord MEZŐTÍPUSA maga a Yoneda-kényszer.
--
-- A NÉGY LÉPÉS (a monográfia 257–312. sorának szerkezete):
--   1. Φ (kiértékelés):     Φ(α) := α_A(id_A)            [262–269. sor]
--   2. Ψ (kiterjesztés):   α^u_X(f) := F(f)(u)          [271–278. sor]
--   3. naturalitás:        F(g)(F(f)(u)) = F(g∘f)(u)    [280–297. sor]
--        — a funktor-kompozíció-törvény; nálunk a Ψ tanúmezői
--          (Refl!) ÉS a jacobiLépcső lemma adják;
--   4. inverzitás:          Φ∘Ψ = id (F(id)(u) = u — a funktor
--                          identitás-törvénye), Ψ∘Φ = id (a
--                          naturalitási diagram kommutál:
--                          α_X(f) = F(f)(α_A(id_A)))   [299–311. sor]
--
-- 中文：证明结构分四步：①Φ 取值于单位态射；②Ψ 由元素经 F(f) 扩张；
--   ③自然性＝函子复合律（Ψ 的证明字段本身是 Refl）；
--   ④Φ∘Ψ＝id（函子单位律）与 Ψ∘Φ＝id（自然性图的交换性）。
--
-- A «Teljes rekord-egyenlőség» KÉRDÉSE (dokumentálva, §16):
--   A Ψ(Φ(α)) = α állítást PONTSZERŰEN adjuk meg (minden objektumon,
--   minden morfizmus-pontra), mert a rekord tanúmezői BIZONYÍTÁSOK,
--   és két bizonyítás definicionális egyenlősége nélkül a teljes
--   Σ-tér-feletti egyenlőség erősebb lenne a Yoneda-lemnánál
--   (proof irrelevance kellene hozzá). Set-értékű funktoroknál a
--   természetes transzformációk egyenlősége szokás szerint PONTONKÉNT
--   értelmezendő — a pontszerű inverz a teljes matematikai tartalom.

%default covering

-- ═══════════════════════════════════════════════════════════════
-- 1. A VÉGES KATEGÓRIA: HÁROM OBJEKTUM, NYOLC MORFIZMUS
-- ═══════════════════════════════════════════════════════════════

||| A véges kategória három objektuma: a lánc Alfa → Béta → Gamma.
||| 三个对象：链 Alfa → Béta → Gamma。
public export
data Objektum : Type where
  Alfa   : Objektum
  Béta   : Objektum
  Gamma  : Objektum

public export
Show Objektum where
  show Alfa  = "Alfa"
  show Béta  = "Béta"
  show Gamma = "Gamma"

||| A morfizmusok: három identitás, KÉT párhuzamos nyíl Alfa→Béta
||| (ezért nem-triviális a Hom-halmaz), egy Híd Béta→Gamma, és a két
||| kompozitum Alfa→Gamma (explicit generátorok — a kompozíció ezekre
||| redukál). 态射：三个单位、两条平行箭、一座桥、两条复合箭。
public export
data Morfizmus : Objektum -> Objektum -> Type where
  AlfaAzonosság     : Morfizmus Alfa Alfa
  BétaAzonosság     : Morfizmus Béta Béta
  GammaAzonosság    : Morfizmus Gamma Gamma
  ElsőNyíl          : Morfizmus Alfa Béta
  MásodikNyíl       : Morfizmus Alfa Béta
  HídNyíl           : Morfizmus Béta Gamma
  ÖsszetettNyílEgy  : Morfizmus Alfa Gamma
  ÖsszetettNyílKettő : Morfizmus Alfa Gamma

public export
Show (Morfizmus x y) where
  show AlfaAzonosság      = "id_Alfa"
  show BétaAzonosság      = "id_Béta"
  show GammaAzonosság     = "id_Gamma"
  show ElsőNyíl           = "első: Alfa→Béta"
  show MásodikNyíl        = "második: Alfa→Béta"
  show HídNyíl            = "híd: Béta→Gamma"
  show ÖsszetettNyílEgy   = "híd∘első: Alfa→Gamma"
  show ÖsszetettNyílKettő = "híd∘második: Alfa→Gamma"

||| Az identitás morfizmus objektum szerint.
public export
azonos : (x : Objektum) -> Morfizmus x x
azonos Alfa  = AlfaAzonosság
azonos Béta  = BétaAzonosság
azonos Gamma = GammaAzonosság

||| A kompozíció a felsorolt esetre (a feladat kérése: „kompozíció a
||| felsoroltakra”). Klauzula-jegyzék: 3 bal-azonos + 2 jobb-azonos +
||| 2 lánc-kompozíció + 3 jobb-azonos (a Híd és a két Összetett nyíl
||| — ezek NEM redundánsak, mert az első argumentum nem Azonosság;
||| a típusos (f, g) párok MINDETIKÉT le vannak fedve → covering).
||| 复合按枚举逐条定义；覆盖全部类型化的箭头对。
public export
kompozíció : {x, y, z : Objektum} -> Morfizmus x y -> Morfizmus y z -> Morfizmus x z
kompozíció AlfaAzonosság  g = g
kompozíció BétaAzonosság  g = g
kompozíció GammaAzonosság g = g
kompozíció ElsőNyíl          BétaAzonosság  = ElsőNyíl
kompozíció MásodikNyíl       BétaAzonosság  = MásodikNyíl
kompozíció ElsőNyíl          HídNyíl        = ÖsszetettNyílEgy
kompozíció MásodikNyíl       HídNyíl        = ÖsszetettNyílKettő
kompozíció HídNyíl           GammaAzonosság = HídNyíl
kompozíció ÖsszetettNyílEgy  GammaAzonosság = ÖsszetettNyílEgy
kompozíció ÖsszetettNyílKettő GammaAzonosság = ÖsszetettNyílKettő

-- ═══════════════════════════════════════════════════════════════
-- 2. A KATEGÓRIA TÖRVÉNYEI — KIMERÍTŐ REFL (ZeneKategoria_v2-minta)
-- ═══════════════════════════════════════════════════════════════
-- MINDEN klauzula konstruktor-minta (a ZeneKategoria_v2 «új csapdá»-
-- jegyzéke szerint: a változó-argumentum NORMÁLFORMÁJA beragad,
-- konstruktor-bontás nélkül a Refl nem zár).

-- Kimenet: Refl (x konstruktor-áganként; az azonos x az első három
-- kompozíció-klauzulán át g-re redukál MINDKÉT oldalon ✓)
public export total
balAzonosTörvény : {x, y : Objektum} -> (f : Morfizmus x y) ->
  kompozíció (azonos x) f = f
balAzonosTörvény {x = Alfa}  f = Refl
balAzonosTörvény {x = Béta}  f = Refl
balAzonosTörvény {x = Gamma} f = Refl

-- Kimenet: Refl (mind a 8 morfizmus-konstruktora külön klauzulában;
-- az azonos y a jobb-azonos klauzulákon át f-et adja vissza ✓)
public export total
jobbAzonosTörvény : {x, y : Objektum} -> (f : Morfizmus x y) ->
  kompozíció f (azonos y) = f
jobbAzonosTörvény AlfaAzonosság      = Refl
jobbAzonosTörvény BétaAzonosság      = Refl
jobbAzonosTörvény GammaAzonosság     = Refl
jobbAzonosTörvény ElsőNyíl           = Refl
jobbAzonosTörvény MásodikNyíl        = Refl
jobbAzonosTörvény HídNyíl            = Refl
jobbAzonosTörvény ÖsszetettNyílEgy   = Refl
jobbAzonosTörvény ÖsszetettNyílKettő = Refl

-- Kimenet: Refl — 10 klauzula, kimerítően. MIÉRT elég ennyi: a lánc
-- kategória «magassága» 3 (Alfa=0, Béta=1, Gamma=2), ezért minden
-- x→y→z→w komponálható hármasban legalább egy szomszéd-azonos lépés
-- van; az Azonosság-klauzulák mindkét oldalt azonos beragadt
-- kifejezésre hozzák; az egyetlen nem-azonos lánc-pár
-- (ElsőNyíl|MásodikNyíl) ∘ HídNyíl után már nincs hova lépni —
-- a harmadik morfizmus csak GammaAzonosság lehet, ezért ott a
-- konstruktor-bontás (h = GammaAzonosság) KÖTELEZŐ (a ZeneKategoria_v2
-- «új csapdá»-ja), a többi klauzulában a harmadik változó szabadon
-- maradhat, mert mindkét oldal UGYANARRA a beragadt kifejezésre redukál.
public export total
asszociativTörvény : {w, x, y, z : Objektum} ->
  (f : Morfizmus w x) -> (g : Morfizmus x y) -> (h : Morfizmus y z) ->
  kompozíció f (kompozíció g h) = kompozíció (kompozíció f g) h
asszociativTörvény AlfaAzonosság  g h = Refl
asszociativTörvény BétaAzonosság  g h = Refl
asszociativTörvény GammaAzonosság g h = Refl
asszociativTörvény ElsőNyíl          BétaAzonosság  h = Refl
asszociativTörvény ElsőNyíl          HídNyíl GammaAzonosság = Refl
asszociativTörvény MásodikNyíl       BétaAzonosság  h = Refl
asszociativTörvény MásodikNyíl       HídNyíl GammaAzonosság = Refl
asszociativTörvény HídNyíl           GammaAzonosság h = Refl
asszociativTörvény ÖsszetettNyílEgy  GammaAzonosság h = Refl
asszociativTörvény ÖsszetettNyílKettő GammaAzonosság h = Refl

-- ═══════════════════════════════════════════════════════════════
-- 3. A HOM-HALMAZOK FELSOROLÁSA (a feladat 3. pontja)
-- ═══════════════════════════════════════════════════════════════

||| Minden Hom-halmaz felsorolva (a véges modell lényege: az üres
||| Hom-ok is LÁTSZANAK — a visszafelé nyíl nem létezik).
||| 所有 Hom 集合一一列举（包括空 Hom：反向箭不存在）。
public export
homElemei : (x, y : Objektum) -> List (Morfizmus x y)
homElemei Alfa  Alfa  = [AlfaAzonosság]
homElemei Alfa  Béta  = [ElsőNyíl, MásodikNyíl]
homElemei Alfa  Gamma = [ÖsszetettNyílEgy, ÖsszetettNyílKettő]
homElemei Béta  Alfa  = []
homElemei Béta  Béta  = [BétaAzonosság]
homElemei Béta  Gamma = [HídNyíl]
homElemei Gamma Alfa  = []
homElemei Gamma Béta  = []
homElemei Gamma Gamma = [GammaAzonosság]

||| A Hom-halmaz MÉRETE a felsorolás hosszaként.
||| Hom 集合的大小＝列举长度。
public export
homSzáma : (x, y : Objektum) -> Nat
homSzáma x y = length (homElemei x y)

-- ═══════════════════════════════════════════════════════════════
-- 4. F : A KATEGÓRIÁBÓL A SET-BE MENŐ FUNKTOR
-- ═══════════════════════════════════════════════════════════════

||| Az F funktor értéke az objektumokon: véges halmazok típusokként.
||| |F(Alfa)| = 2 — EZ A LÉNYEG: a Yoneda-bijekció F(Alfa) ↔ Nat
||| ezért NEM degenerált (1-elemű F(Alfa) esetén 1↔1 lenne).
||| 函子 F 的取值：有限集合即类型；|F(Alfa)| = 2，双射非退化。
public export
data FElem : Objektum -> Type where
  AlfaPiros      : FElem Alfa
  AlfaKék        : FElem Alfa
  BétaElemEgy    : FElem Béta
  BétaElemKettő  : FElem Béta
  GammaElemEgy   : FElem Gamma
  GammaElemKettő : FElem Gamma
  GammaElemHárom : FElem Gamma

public export
Show (FElem x) where
  show AlfaPiros      = "piros"
  show AlfaKék        = "kék"
  show BétaElemEgy    = "bétaElemEgy"
  show BétaElemKettő  = "bétaElemKettő"
  show GammaElemEgy   = "gammaElemEgy"
  show GammaElemKettő = "gammaElemKettő"
  show GammaElemHárom = "gammaElemHárom"

public export
Eq (FElem x) where
  (==) AlfaPiros      AlfaPiros      = True
  (==) AlfaKék        AlfaKék        = True
  (==) BétaElemEgy    BétaElemEgy    = True
  (==) BétaElemKettő  BétaElemKettő  = True
  (==) GammaElemEgy   GammaElemEgy   = True
  (==) GammaElemKettő GammaElemKettő = True
  (==) GammaElemHárom GammaElemHárom = True
  (==) _ _ = False

||| Az F funktor hatása a morfizmusokra. Az AZONOSSÁG-klauzulák
||| (elem-változóval!) a definicionális F(id)(u) = u-t adják — ez
||| a Φ∘Ψ = id bizonyításának alapköve. A kompozitumok hatása a
||| funktor-törvényből KÖTELEZŐ érték (l. funktorKompozícióTörvény).
public export
funktorHatás : {x, y : Objektum} -> Morfizmus x y -> FElem x -> FElem y
funktorHatás AlfaAzonosság      elem = elem
funktorHatás BétaAzonosság      elem = elem
funktorHatás GammaAzonosság     elem = elem
funktorHatás ElsőNyíl           AlfaPiros = BétaElemEgy
funktorHatás ElsőNyíl           AlfaKék   = BétaElemEgy
funktorHatás MásodikNyíl        AlfaPiros = BétaElemEgy
funktorHatás MásodikNyíl        AlfaKék   = BétaElemKettő
funktorHatás HídNyíl            BétaElemEgy   = GammaElemEgy
funktorHatás HídNyíl            BétaElemKettő = GammaElemHárom
funktorHatás ÖsszetettNyílEgy   AlfaPiros = GammaElemEgy
funktorHatás ÖsszetettNyílEgy   AlfaKék   = GammaElemEgy
funktorHatás ÖsszetettNyílKettő AlfaPiros = GammaElemEgy
funktorHatás ÖsszetettNyílKettő AlfaKék   = GammaElemHárom

||| Az F funktor értékeinek felsorolása (a main táblázatához).
public export
fürtElemei : (x : Objektum) -> List (FElem x)
fürtElemei Alfa  = [AlfaPiros, AlfaKék]
fürtElemei Béta  = [BétaElemEgy, BétaElemKettő]
fürtElemei Gamma = [GammaElemEgy, GammaElemKettő, GammaElemHárom]

-- Kimenet: Refl (x konstruktoronként; az id-klauzulák elem-változóval
-- redukálnak — az FElem-x bontás NEM kell ✓)
public export total
funktorIdentitásTörvény : (x : Objektum) -> (u : FElem x) ->
  funktorHatás (azonos x) u = u
funktorIdentitásTörvény Alfa  u = Refl
funktorIdentitásTörvény Béta  u = Refl
funktorIdentitásTörvény Gamma u = Refl

-- Kimenet: Refl — 12 klauzula, a típusos (f, g, u) hármasok MINDETIKE.
-- A lánc-kompozícióknál (Első/MásodikNyíl ∘ HídNyíl) az u BONTÁS is
-- kell (F(ÖsszeNyíl) u az u-változón beragadna); az Azonosság-ágakon
-- az u változó szabadon maradhat (mindkét oldal azonosra redukál).
-- Ez a törvény a monográfia 3. lépésének alapja: F(g)(F(f)(u)) =
-- F(g∘f)(u) — a naturalitási diagram kommutálásának magja.
public export total
funktorKompozícióTörvény : {x, y, z : Objektum} ->
  (f : Morfizmus x y) -> (g : Morfizmus y z) -> (u : FElem x) ->
  funktorHatás (kompozíció f g) u = funktorHatás g (funktorHatás f u)
funktorKompozícióTörvény AlfaAzonosság      g u = Refl
funktorKompozícióTörvény BétaAzonosság      g u = Refl
funktorKompozícióTörvény GammaAzonosság     g u = Refl
funktorKompozícióTörvény ElsőNyíl           BétaAzonosság  u = Refl
funktorKompozícióTörvény MásodikNyíl        BétaAzonosság  u = Refl
funktorKompozícióTörvény ElsőNyíl           HídNyíl AlfaPiros = Refl
funktorKompozícióTörvény ElsőNyíl           HídNyíl AlfaKék   = Refl
funktorKompozícióTörvény MásodikNyíl        HídNyíl AlfaPiros = Refl
funktorKompozícióTörvény MásodikNyíl        HídNyíl AlfaKék   = Refl
funktorKompozícióTörvény HídNyíl            GammaAzonosság u = Refl
funktorKompozícióTörvény ÖsszetettNyílEgy   GammaAzonosság u = Refl
funktorKompozícióTörvény ÖsszetettNyílKettő GammaAzonosság u = Refl

-- ═══════════════════════════════════════════════════════════════
-- 5. h^Alfa : A REPREZENTÁLHATÓ FUNKTOR Hom(Alfa, -)
-- ═══════════════════════════════════════════════════════════════

||| A reprezentálható funktor objektum-része: h^Alfa(X) = Hom(Alfa, X).
public export
ReprezentálhatóFunktor : Objektum -> Type
ReprezentálhatóFunktor x = Morfizmus Alfa x

||| A reprezentálható funktor morfizmus-része: a POSZT-kompozíció.
||| h^Alfa(g)(m) = g ∘ m — ez teszi h^Alfa-ét funktorrá.
||| 可表函子的态射部分：后复合。
public export
homHatás : {x, y : Objektum} -> Morfizmus x y -> Morfizmus Alfa x -> Morfizmus Alfa y
homHatás g m = kompozíció m g

-- ═══════════════════════════════════════════════════════════════
-- 6. TERMÉSZETES TRANSZFORMÁCIÓ h^Alfa ⇒ F (dependent record)
-- ═══════════════════════════════════════════════════════════════
-- A rekord MEZŐTÍPUSA maga a Yoneda-kényszer: a tanúmezők azt
-- mondják, hogy a komponensek értékét α_Alfa(id_Alfa) HATÁROZZA MEG
-- a funktor-hatáson át. (Ez a rekord-definíció már "tudja", hogy a
-- természetes transzformációk tere legfeljebb akkora, mint F(Alfa).)
--
-- Megjegyzés a naturalitás alakjáról: az ÁLTALÁNOS naturalitási
-- kényszer minden g : X→Y-re α_Y(m∘g) = F(g)(α_X(m)); a mi világunkban
-- enek nem-azonos esetei g ∈ {ElsőNyíl, MásodikNyíl, HídNyíl,
-- ÖsszetettNyílEgy, ÖsszetettNyílKettő} — az Első/Második/Össze
-- esetek PONT a tanúmezők (m = id_Alfa helyettesítéssel), a HídNyíl
-- eset a jacobiLépcső lemma (l. 7. szakasz).

public export
record TermészetesTranszformáció where
  constructor TermészetesTranszformációKonstruktor
  komponensAlfa   : Morfizmus Alfa Alfa -> FElem Alfa
  komponensBéta   : Morfizmus Alfa Béta -> FElem Béta
  komponensGamma  : Morfizmus Alfa Gamma -> FElem Gamma
  természetesBéta : (m : Morfizmus Alfa Béta) ->
    komponensBéta m = funktorHatás m (komponensAlfa AlfaAzonosság)
  természetesGamma : (m : Morfizmus Alfa Gamma) ->
    komponensGamma m = funktorHatás m (komponensAlfa AlfaAzonosság)

-- ═══════════════════════════════════════════════════════════════
-- 7. A NÉGY LÉPÉS (a monográfia 257–312. sora)
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. LÉPÉS: Φ — a transzformációból elembe (262–269. sor) ───
-- Φ(α) := α_A(id_A) — a kiértékelés az identitáson.
-- Kimenet: definíció (fv-alkalmazás a típusban — nem csupasz
-- kisbetűs konstans, a #1 csapdára nézve BIZTONSÁGOS, Φ nagybetűs).
public export
Φ : TermészetesTranszformáció -> FElem Alfa
Φ transzformáció = komponensAlfa transzformáció AlfaAzonosság

-- ─── 2. LÉPÉS: Ψ — az elemből transzformációba (271–278. sor) ──
-- α^u_X(f) := F(f)(u) — a természetes kiterjesztés.
-- A tanúmezők (\m => Refl): mindkét oldal definicionálisan
-- F(m)(u)-ra redukál (a jobb oldalon az AlfaAzonosság-klauzula
-- elem-változóval redukál) — a fordító itt ELLENŐRZI a 3. lépés
-- naturalitását a Ψ(u)-kra: EZ maga a monográfia 280–297. sora.
public export
Ψ : FElem Alfa -> TermészetesTranszformáció
Ψ kiindulóElem = TermészetesTranszformációKonstruktor
  (\morfizmus => funktorHatás morfizmus kiindulóElem)
  (\morfizmus => funktorHatás morfizmus kiindulóElem)
  (\morfizmus => funktorHatás morfizmus kiindulóElem)
  (\morfizmus => Refl)
  (\morfizmus => Refl)

-- ─── 3. LÉPÉS: a JACOBI-LÉPCSŐ (280–297. sor) ───────────────────
-- A naturalitási diagram kommutálása a HídNyíl-lépcsőn: az α-k
-- rejtett szerkezetéről szól — a HídNyíl-poszt-kompozíció és a
-- funktor-hatás UGYANODARA vezet. A bizonyítás lánc:
--   α_Gamma(m∘híd) =Γ F(m∘híd)(α_Alfa(id)) =K F(híd)(F(m)(α_Alfa(id))) =B F(híd)(α_Béta(m))
-- ahol =Γ a természetesGamma tanú, =K a funktorKompozícióTörvény
-- (sym), =B a természetesBéta tanú (cong-gel emelve a HídNyíl-hatás
-- fején át). Az m-re bontás KELL (a ZeneKategoria_v2 «új csapdá»-ja:
-- a kompozíció m HídNyíl az m-változón beragadna).
--
-- Kimenet: trans-lánc, total — a lépcső mindkét irányban ugyanoda fut.
public export total
jacobiLépcső : (transzformáció : TermészetesTranszformáció) ->
  (m : Morfizmus Alfa Béta) ->
  komponensGamma transzformáció (kompozíció m HídNyíl) =
    funktorHatás HídNyíl (komponensBéta transzformáció m)
jacobiLépcső transzformáció ElsőNyíl =
  trans (természetesGamma transzformáció ÖsszetettNyílEgy)
    (trans (funktorKompozícióTörvény ElsőNyíl HídNyíl (komponensAlfa transzformáció AlfaAzonosság))
       (sym (cong (funktorHatás HídNyíl) (természetesBéta transzformáció ElsőNyíl))))
jacobiLépcső transzformáció MásodikNyíl =
  trans (természetesGamma transzformáció ÖsszetettNyílKettő)
    (trans (funktorKompozícióTörvény MásodikNyíl HídNyíl (komponensAlfa transzformáció AlfaAzonosság))
       (sym (cong (funktorHatás HídNyíl) (természetesBéta transzformáció MásodikNyíl))))

-- ─── 4. LÉPÉS: az INVERZITÁS (299–311. sor) ─────────────────────

-- 4a. Φ∘Ψ = id — a monográfia 301–303. sora:
--   Φ(Ψ(u)) = α^u_Alfa(id) = F(id_Alfa)(u) = u — a funktor
--   identitás-törvénye. Nálunk a bal oldal definicionálisan
--   redukál (projekció → β-redukció → AlfaAzonosság-klauzola):
--   a KÉT OLDAL KÜLÖNBÖZŐ konstrukció (Φ∘Ψ kibontása vs. u) —
--   a bal oldal SZÁMOL, nem tautológia (§18).
-- Kimenet: Refl (mindkét u-konstruktora a main-ben futásidőben is
-- látszik; fordítási időben a total kikényszeríti a jófedést).
public export total
yonedaBijekció : (elem : FElem Alfa) -> Φ (Ψ elem) = elem
yonedaBijekció elem = Refl

-- 4b. Ψ∘Φ = id — a monográfia 305–309. sora, a LÉNYEG:
--   (Ψ∘Φ)(α)_X(f) = F(f)(α_Alfa(id)) =Γ α_X(f ∘ id) = α_X(f),
--   ahol =Γ az α naturalitási diagramja az f : Alfa→X morfizmusra
--   és az id_Alfa ∈ Hom(Alfa, Alfa) elemre alkalmazva.
--   Nálunk a =Γ lépcső PONT a tanúmező (természetesBéta /
--   természetesGamma) — a rekordba épített naturalitás.
--   Pontszerűen adjuk meg (l. a fejléc «Teljes rekord-egyenlőség»
--   jegyzékét): minden objektumon, minden morfizmus-pontra.

-- Kimenet: Refl (az Alfa-ág: a komponensAlfa (Ψ (Φ α)) m mindkét
-- oldala α_Alfa(id)-ra redukál — az egyetlen konstruktor AlfaAzonosság)
public export total
yonedaInverzAlfa : (transzformáció : TermészetesTranszformáció) ->
  (m : Morfizmus Alfa Alfa) ->
  komponensAlfa (Ψ (Φ transzformáció)) m = komponensAlfa transzformáció m
yonedaInverzAlfa transzformáció AlfaAzonosság = Refl

-- Kimenet: sym (tanú) — a bal oldal definicionálisan
-- F(m)(α_Alfa(id)), és a tanú éppen azt mondja, hogy ez = α_Béta(m).
public export total
yonedaInverzBéta : (transzformáció : TermészetesTranszformáció) ->
  (m : Morfizmus Alfa Béta) ->
  komponensBéta (Ψ (Φ transzformáció)) m = komponensBéta transzformáció m
yonedaInverzBéta transzformáció m = sym (természetesBéta transzformáció m)

-- Kimenet: sym (tanú) — ugyanaz a Gamma-komponensre.
public export total
yonedaInverzGamma : (transzformáció : TermészetesTranszformáció) ->
  (m : Morfizmus Alfa Gamma) ->
  komponensGamma (Ψ (Φ transzformáció)) m = komponensGamma transzformáció m
yonedaInverzGamma transzformáció m = sym (természetesGamma transzformáció m)

-- ═══════════════════════════════════════════════════════════════
-- 8. FUTTATHATÓ TANÚSÁG (GAUGE: a main írja ki, hogy a Φ/Ψ körút
--    mindkét irányban zár; a futtatható név ASCII — #19-es csapda)
-- ═══════════════════════════════════════════════════════════════

||| A körút zárulása EGY elemen: Φ(Ψ(u)) == u futásidőben.
||| (Nevesített függvény — a #8-as csapda miatt NEM lambda.)
public export
körútZárulEgyElemen : FElem Alfa -> Bool
körútZárulEgyElemen elem = Φ (Ψ elem) == elem

||| A Φ/Ψ körút futásidejű kimerítése F(Alfa) minden elemén
||| (a §18(b) mintája: futásidejű kmerítés véges világnál).
körútEredmények : List Bool
körútEredmények = map körútZárulEgyElemen (fürtElemei Alfa)

||| Egy Ψ(u) transzformáció komponens-táblázata egy sorban — ebből
||| LÁTSZIK, hogy Ψ(piros) ≠ Ψ(kék): a bijekció nem degenerált.
transzformációTáblázatSor : FElem Alfa -> String
transzformációTáblázatSor elem =
  "Ψ(" ++ show elem ++ ") :  Béta(első)=" ++ show (komponensBéta (Ψ elem) ElsőNyíl)
  ++ "  Béta(második)=" ++ show (komponensBéta (Ψ elem) MásodikNyíl)
  ++ "  Gamma(híd∘első)=" ++ show (komponensGamma (Ψ elem) ÖsszetettNyílEgy)
  ++ "  Gamma(híd∘második)=" ++ show (komponensGamma (Ψ elem) ÖsszetettNyílKettő)

main : IO ()
main = do
  putStrLn "═══ YONEDA-BIZONYÍTÁS VÉGES MODELLON — futtatható tanúság ═══"
  putStrLn ""
  putStrLn "-- A kategória: Alfa → Béta → Gamma lánc, két párhuzamos nyíllal --"
  putStrLn ("homSzáma Alfa Alfa  = " ++ show (homSzáma Alfa Alfa))
  putStrLn ("homSzáma Alfa Béta  = " ++ show (homSzáma Alfa Béta) ++ "   <- két párhuzamos nyíl")
  putStrLn ("homSzáma Alfa Gamma = " ++ show (homSzáma Alfa Gamma))
  putStrLn ("homSzáma Béta Alfa  = " ++ show (homSzáma Béta Alfa) ++ "   <- visszafelé nincs nyíl")
  putStrLn ("homSzáma Béta Gamma = " ++ show (homSzáma Béta Gamma))
  putStrLn ("homSzáma Gamma Gamma = " ++ show (homSzáma Gamma Gamma))
  putStrLn ""
  putStrLn "-- Az F funktor értékei (|F(Alfa)| = 2: a bijekció nem degenerált) --"
  putStrLn ("|F(Alfa)|  = " ++ show (length (fürtElemei Alfa)))
  putStrLn ("|F(Béta)|  = " ++ show (length (fürtElemei Béta)))
  putStrLn ("|F(Gamma)| = " ++ show (length (fürtElemei Gamma)))
  putStrLn ""
  putStrLn "-- 4a. lépés futásidőben: Φ(Ψ(u)) == u, minden u ∈ F(Alfa) --"
  putStrLn ("Φ(Ψ(piros)) == piros : " ++ show (Φ (Ψ AlfaPiros) == AlfaPiros))
  putStrLn ("Φ(Ψ(kék))   == kék   : " ++ show (Φ (Ψ AlfaKék) == AlfaKék))
  putStrLn ("körútEredmények = " ++ show körútEredmények ++ "   (mindkét körút zár)")
  putStrLn ""
  putStrLn "-- A két transzformáció táblázata (Ψ(piros) ≠ Ψ(kék)!) --"
  putStrLn (transzformációTáblázatSor AlfaPiros)
  putStrLn (transzformációTáblázatSor AlfaKék)
  putStrLn ""
  putStrLn "-- Injektivitás futásidőben: a MásodikNyíl-komponens elválaszt --"
  putStrLn ("Ψ(kék)_Béta(második) /= Ψ(piros)_Béta(második) : "
    ++ show (komponensBéta (Ψ AlfaKék) MásodikNyíl /= komponensBéta (Ψ AlfaPiros) MásodikNyíl))
  putStrLn ""
  putStrLn "-- Fordítási idejű tanúk (total Refl/trans-láncok, l. a forrást):"
  putStrLn "   yonedaBijekció        : Φ (Ψ elem) = elem                    [Refl]"
  putStrLn "   yonedaInverzAlfa      : Ψ (Φ α)_Alfa(m)   = α_Alfa(m)         [Refl]"
  putStrLn "   yonedaInverzBéta      : Ψ (Φ α)_Béta(m)   = α_Béta(m)         [sym tanú]"
  putStrLn "   yonedaInverzGamma     : Ψ (Φ α)_Gamma(m)  = α_Gamma(m)        [sym tanú]"
  putStrLn "   jacobiLépcső          : α_Gamma(m∘híd) = F(híd)(α_Béta(m))   [trans-lánc]"
  putStrLn "A Φ/Ψ körút MINDKÉT IRÁNYBAN ZÁRUL."
