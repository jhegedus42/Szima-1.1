# Mac Lane: Categories for the Working Mathematician — Kivonat

**Forrás:** `/Users/joco/opencode/trail_index/books/maclane_categories.txt` (18642 sor, OCR — a diagramok töröttek, a definíciók szövege kinyerve).
**Cél:** pontos definíciók és törvények a projekt 2-kategória/adjunkció rétegéhez; a törvényeket az Idris-modulok Refl-bizonyításainak kell igazolnia.
**Jelölés:** a `∘` a függvénykompozíció (Mac Lane-nél egymás mellé írás: `gf` = "előbb f, aztán g"); `•` a természetes transzformációk vertikális kompozíciója (Mac Lane-nél teli pont, néha szóköz).

---

## 1. Definíciók

### 1.1 Kategória (metacategory, axiómás alak) — 887–939. sor

- **Metagraph** (894–902): objektumok `a, b, c, …`, nyilak `f, g, h, …`, két művelet: `dom f` (forrás) és `cod f` (cél), jelölve `f: a → b`.
- **Metacategory** (909–920): metagraph + két művelet:
  - **Identity:** minden `a` objektumhoz `id_a = 1_a : a → a` (910);
  - **Composition:** minden `⟨g, f⟩` párhoz, ahol `dom g = cod f`, egy `g ∘ f` kompozit, `g ∘ f : dom f → cod g` (911–913).
- **Asszociativitás-axióma** (922–926): a `a →f→ b →g→ c →k→ d` konfigurációra
  `k ∘ (g ∘ f) = (k ∘ g) ∘ f`  — az (1) egyenlet.
- **Egység-axióma** (957–964): minden `f: a → b` és `g: b → c` esetén
  `1_b ∘ f = f`  és  `g ∘ 1_b = g`  — a (2) egyenlet.
- **Egyértelműség** (979–982): `1_b` egyértelmű a (2) tulajdonságokkal; ezért az objektumokat azonosíthatjuk identitásnyilaikkal (`1_b = b = id_b`).
- **Csak-nyilak axiomatika** (1018–1035): komponálható párok + három axióma: (i) `(k g) f` definiált ⟺ `k (g f)` definiált, és akkor egyenlők; (ii) ha `kg` és `gf` definiált, akkor `k g f` is; (iii) minden `g` nyílhoz vannak `u, u'` identitások, hogy `u' g` és `g u` definiáltak. — Ekvivalens a fentivel.
- **Kommutatív diagram** (971–977): bármely két, azonos csúcsok közti irányított út kompozíciója egyenlő.

### 1.2 Kategória (halmazelméleti alak) — 1047–1105. sor

- Irányított gráf: `O` objektumhalmaz, `A` nyílhalmaz, `dom, cod : A ⇉ O` (1049–1057).
- Komponálható párok: `A ×_O A = {⟨g, f⟩ | dom g = cod f}` (1060–1064).
- Kategória = gráf + `c ↦ id_c : O → A` és `⟨g, f⟩ ↦ g ∘ f : A ×_O A → A` (1067–1082), ahol
  `dom(id_a) = a = cod(id_a)`,  `dom(g∘f) = dom f`,  `cod(g∘f) = cod g`  (1080–1084),
  és teljesülnek az (1.1)/(1.2) asszociativitás- és egység-axiómák (1087).
- **hom-halmaz:** `hom(b, c) = {f | dom f = b, cod f = c}` (1098).
- Példák: monoid = egyobjektumú kategória (1130–1135); csoport = egyobjektumú kategória, minden nyíl invertálható (1138–1139); preorder = bármely két objektum közt legfeljebb egy nyíl (1146–1156).

### 1.3 Funktor — 1216–1230. sor

A `T: C → B` funktor **két összeillő függvény**: az objektumfüggvény `c ↦ Tc` és a nyílfüggvény `f: c → c' ↦ Tf: Tc → Tc'`, úgy hogy
- **(1) egyenlet:** `T(g ∘ f) = Tg ∘ Tf` (1221–1226),
- és (csak-nyilak alakban) minden identitást identitásba visz: `T(1_c) = 1_{Tc}` (1227–1230).

- **full** (teljes): minden `g: Tc → Tc'`-höz van `f: c → c'`, hogy `g = Tf` (1310–1312); **faithful** (hű): `Tf₁ = Tf₂ ⟹ f₁ = f₂` párhuzamos nyilakra (1318–1321). Hom-halmazokon: `T_{c,c'}: hom(c, c') → hom(Tc, Tc')`; full = minden ilyen szürjektív, faithful = injektív (1323–1334).
- **Funktor-kompozíció** (1288–1303): `(S∘T)c = S(Tc)`, `(S∘T)f = S(Tf)`; asszociatív; `I_B : B → B` identitásfunktor. Az összes kategória metacategory-t alkot, az összes **kis** kategória a `Cat` kategóriát.

### 1.4 Természetes transzformáció — 1370–1425. sor

Két `S, T: C → B` funktorra egy **természetes transzformáció** `τ: S ⇛ T` olyan függvény, amely minden `c ∈ C` objektumhoz egy `τ_c = τc : Sc → Tc` nyilat rendel (a **komponens**), úgy hogy minden `f: c → c'` nyílra az
```
      Sc ──τ_c──> Tc
      |            |
    Sf|            |Tf
      ↓            ↓
      Sc' ──τ_c'─> Tc'
```
**természetességi négyzet kommutatív**:  `τ_{c'} ∘ Sf = Tf ∘ τ_c`  (1372–1389, az (1) diagram). Ekkor `τ_c` **természetes c-ben** (1389).

- **Vertikális kompozíció** (II.4): `σ: S ⇛ T`, `τ: T ⇛ U` esetén `(τ • σ)_c = τ_c ∘ σ_c` (vö. 15623–15624).
- **Természetes izomorfizmus** (1422–1425): minden `τ_c` invertálható B-ben; az inverzek `τ⁻¹` komponensei.

### 1.5 Horizontális kompozíció és az interchange law — 2745–2886. sor (II.5)

`S, S': B → C`, `T, T': C → A` funktorokra és `τ: S ⇛ T`, `τ': S' ⇛ T'` transzformációkra a **horizontális kompozit** `τ' ∘ τ : S'S ⇛ T'T` komponensenként:
`(τ' ∘ τ)_c = τ'_{Tc} ∘ S'(τ_c) = T'(τ_c) ∘ τ'_{Sc}`  (2749, a (2) egyenlet).

**Interchange law** (2824–2838, az (5) egyenlet; 2880–2881 az általános definíció): négy transzformációra `τ, σ, τ', σ'`:
```
(τ' • σ') ∘ (τ • σ) = (τ' ∘ τ) • (σ' ∘ σ)
```
ahol a `•` vertikális, a `∘` horizontális kompozíció; az egyenlőség ott áll, ahol mindkét oldal definiált.

**Theorem 11.5.1** (2846–2853): a természetes transzformációk összessége két különböző kategória nyílrendszere két különböző kompozícióval (`•` és `∘`), amelyek kielégítik az interchange law-t; továbbá minden nyíl, amely identitás az egyik kompozícióra, identitás a másikra is.

**Double category** (2873–2876): olyan halmaz (mint a természetes transzformációké), amely két kompozíció nyílrendszere és kielégíti (5)-öt. **2-kategória** = olyan double category, amelyben az első kompozíció minden identitása a másodiknak is identitása (2874–2876).

### 1.6 Adjunkció — 4794–5093. sor (IV.1)

**Definíció** (4794–4801): A és X kategóriák. Egy **adjunkció X-ből A-ba** egy `(F, G, φ): X ⇀ A` hármas, ahol `F: X → A` és `G: A → X` funktorok, φ pedig minden `⟨x, a⟩ ∈ X × A` objektumpárhoz bijekciót rendel:
`φ = φ_{x,a} : A(Fx, a) ≅ X(x, Ga)`   — az (1) egyenlet —
amely **természetes x-ben és a-ban** (4801).

- A bal oldal az `X^op × A → Set` bifunktor, a jobb hasonló; **naturalitás** (4808–4835): minden `k: a → a'` és `h: x' → x` esetén a két diagram kommutatív:
  `φ ∘ k* = (Gk)* ∘ φ`  és  `φ ∘ (Fh)* = h* ∘ φ` — a (2) diagramok; itt `k* = A(Fx, k)`, `h* = X(h, Ga)` (4834–4835).
- **Nyíllal, hom-halmazok nélkül** (4838–4849): φ minden `f: Fx → a` nyílhoz a **jobb adjunkt** `φf = rad f : x → Ga` nyilat rendeli; a (2) naturalitás ekvivalens azzal, hogy φ⁻¹ is természetes, azaz (4):
  `φ⁻¹(g ∘ h) = φ⁻¹g ∘ Fh`,  `φ⁻¹(Gk ∘ g) = k ∘ φ⁻¹g`  — a (4) egyenletek (4847–4849).
- **Bal/jobb adjunkt** (4853–4857): `F` a `G` bal adjunktja, `G` a jobb adjunktja (`F ⊣ G`).
- **Egység (unit)** (4858–4887): `a = Fx`-et véve `η_x = φ(1_{Fx}) : x → GFx`; Yoneda (Prop. III.2.1) miatt univerzális nyíl x-ből G-hez; `η: I_X ⇛ GF` természetes.
- **Az (5) képlet** (4893–4905): `φ(f) = Gf ∘ η_x` minden `f: Fx → a`-ra; bizonyítás: `φ(f) = φ(f ∘ 1_{Fx}) = Gf ∘ φ(1_{Fx}) = Gf ∘ η_x`.
- **Kegység (counit)** (4935–4945): `x = Ga`-t véve `ε_a = φ⁻¹(1_{Ga}) : FGa → a`; univerzális nyíl F-ből a-hoz; `ε: FG ⇛ I_A` természetes.
- **Inverz képlet** (4947–4951): `φ⁻¹(g) = ε_a ∘ Fg` minden `g: x → Ga`-ra.

**Theorem 1** (4965–4979): az adjunkció meghatározza (i) `η: I_X ⇛ GF`-et, `η_x` univerzális G-hez, `φf = Gf ∘ η_x` (a (6) képlet); (ii) `ε: FG ⇛ I_A`-t, `ε_a` univerzális, `φ⁻¹g = ε_a ∘ Fg` (a (7) képlet); és mindkét kompozit identitás (a (8) képletek):
```
G ──ηG──> GFG ──Gε──> G  =  id_G
F ──Fη──> FGF ──εF──> F  =  id_F
```
(4974–4979: "both the following composites are the identities (of G, resp. F)").

**Theorem 2** (4990–5003): az adjunkciót teljesen meghatározza az alábbi listák bármelyike: (i) F, G és η, minden η_x univerzális — φ a (6)-tal adott; (ii) G és minden x-hez egy univerzális `η_x: x → GF₀x` — F-et a `GFh ∘ η_x = η_{x'} ∘ h` egyenlet definiálja nyilakon; (iii) F, G és ε, minden ε_a univerzális — φ⁻¹ a (7)-tel adott; (iv) duálisan; **(v) F, G és η, ε, amelyekre a (8) háromszög-kompozitok identitások** — φ-t (6), φ⁻¹-et (7) definiálja (5001–5003).

**Háromszög-azonosságok** (5083–5092): az (v)-beli két azonosság a (9) egyenlet; a szöveg neve: "triangular identities"; "make no explicit use of the objects … and so are easy to manipulate".

**Corollary 1** (5093–5100): G bármely két bal adjunktja természetesen izomorf (univerzális nyilak egyértelműsége miatt).

### 1.7 Monád — 8051–8135. sor (VI.1)

**Definíció** (8051–8061): Egy **monád** `T = ⟨T, η, μ⟩` X-ben: `T: X → X` endofunktor és két természetes transzformáció
`η: I_X ⇛ T`,  `μ: T² ⇛ T`   — az (1) egyenletek —
amelyekre a (2) diagramok kommutatívak; szavakban (8078–8080): az első diagram az **asszociativitás**, a második és harmadik a **bal és jobb egységtörvény**:
`μ ∘ Tμ = μ ∘ μT`,  `μ ∘ ηT = 1_T = μ ∘ Tη`.
Itt `η` az **egység**, `μ` a **szorzás** (8077–8078). "A monád X-ben pontosan monoid az X endofunktorainak kategóriájában, szorzással a funktorkompozíció, egységgel az identitásfunktor" (8081–8083).

**Monád adjunkcióból** (8091–8135): minden `(F, G, η, ε): X ⇀ A` adjunkcióból `T = GF`, `η` az adjunkció egysége, `μ = GεF : GFGF ⇛ GF`. A `μ` asszociativitása abból jön, hogy `εε = ε • (FGε) = ε • (εFG)` (az **interchange law** a horizontális kompozícióra, 8118–8121); az egységtörvények a két háromszög-azonosságból (8122–8134).

**Komónád** (8139–8154): duálisan `L: A → A`, `ε: L ⇛ I`, `δ: L ⇛ L²`; adjunkcióból `⟨FG, ε, FηG⟩`.

**T-algebra** (8192–8222): ha `T = ⟨T, η, μ⟩` monád X-ben, egy **T-algebra** `⟨x, h⟩`: `x ∈ X` + `h: Tx → x` struktúranyíl, hogy
`h ∘ μ_x = h ∘ Th`  (asszociativitás),  `h ∘ η_x = 1_x`  (egység)  — az (1) diagramok;
algebra-morfizmus `f: ⟨x,h⟩ → ⟨x',h'⟩`: `f: x → x'` és `f ∘ h = h' ∘ Tf` — a (2) diagram.

### 1.8 Yoneda-lemma — 3733–3789. sor (III.2)

**Lemma (Yoneda)** (3733–3741): ha `K: D → Set` funktor és `r ∈ D` (D-nek kis hom-halmazai vannak), akkor bijekció
`y : Nat(D(r, −), K) ≅ Kr`   — a (4) egyenlet —
amely minden `α: D(r, −) ⇛ K` transzformációhoz az `α_r(1_r) ∈ Kr` elemet (az identitás képét) rendeli (3740–3741).

**Következmény** (3754–3755): minden `D(r, −) ⇛ D(s, −)` transzformáció `D(h, −)` alakú, egyértelmű `h: s → r` nyíllal.

**Yoneda-funktor** (3768–3772): `r ↦ D(r, −)`, `(f: s → r) ↦ D(f, −)` **teljes és hű** funktor. Dualitás: `Y': D → Set^{D^op}` (3778–3785). Az y leképezés **természetes K-ban és r-ben** (3756–3767).

### 1.9 Limit és colimit — 4065–4194. sor (III.3–4)

- **Diagonális funktor** (4067–4072): `Δ: C → C^J`; `Δc` konstans funktor, `Δf` konstans természetes transzformáció.
- **Colimit** (4073–4108): `F: J → C`-re a colimit egy univerzális nyíl `⟨r, u⟩` **F-ből Δ-ba**: `r = Colim F` és `u: F ⇛ Δr` univerzális a `λ: F ⇛ Δc` transzformációk közt. Egy ilyen `λ: F ⇛ c` = **kúp F bázissal, c csúccsal** (4095–4098): `λ_i: Fi → c` nyilak, `λ_j ∘ Fu = λ_i` minden `u: i → j`-re. Univerzalitás: minden kúphoz egyértelmű `t': Colim F → c`, hogy `λ_i = t' ∘ μ_i` (4105–4108).
- **Limit** (4141–4155): a colimit duálisa; univerzális nyíl `⟨r, v⟩` **Δ-ból F-be**: `r = Lim F` + `v: Δr ⇛ F` univerzális. **Kúp** `τ: c ⇛ F` (csúcs `c`, bázis `F`): `τ_i: c → Fi`, és minden `u: i → j`-re `τ_j = Fu ∘ τ_i` (4149–4152). Univerzalitás: minden kúphoz egyértelmű `t: c → Lim F`, hogy `τ_i = v_i ∘ t` minden i-re (4153–4155).
- Egyértelműség: `Lim F` és `v` izomorfia erejéig egyértelmű (4181–4188).
- **Adjunkciós olvasat** (IV.1, 5057–5073): a szorzat `a × b` jobb adjunktja Δ-nak: `φ: (C × C)(Δc, ⟨a, b⟩) ≅ C(c, a × b)`, tehát `C(c, a) × C(c, b) ≅ C(c, a × b)`; a koproduktum `a ∐ b` bal adjunktja Δ-nak: `C(a ∐ b, c) ≅ (C × C)(⟨a, b⟩, Δc)`.

### 1.10 2-kategória — 15614–15888. sor (XII.3)

Alapötlet (15616–15617): 2-sejtek rendszere, amely **két különböző, de egymással kommutáló** kategorikus módon komponálható.

- **2-sejt** (15683–15699): `α: f ⇒ g : a → b`, ahol `f, g` párhuzamos 1-sejtek (nyilak) a C alapszintű kategóriában; `f` a domain, `g` a codomain.
- **Horizontális kompozíció** (15700–15715): `α: f ⇒ g: a → b` és `α': f' ⇒ g': b → c` esetén `α' ∘ α : f'∘f ⇒ g'∘g : a → c` (a (4) kompozit). **Követelmény:** a 2-sejtek **kategóriát alkotnak** a horizontális kompozíció alatt; minden `b`-hez van `1: 1_b ⇒ 1_b : b → b` identitás-2-sejt (15715–15716); a "domain" `α ↦ f` és "codomain" `α ↦ g` **funktorok** a horizontális kategóriából a nyilak kategóriájába (15717–15718).
- **Vertikális kompozíció** (15719–15758): minden `⟨a, b⟩` párra a 2-sejtek egy kategória nyilai a `•` kompozícióval (teli pont); vertikális identitások `1_f: f ⇒ f` (15757–15758).
- **A (6) axióma** (15760–15765): két vertikális identitás horizontális kompozitja ismét vertikális identitás: `1_{f'} ∘ 1_f = 1_{f'∘f}`.
- **A (9) axióma — "middle four exchange" (csere-törvény)** (15767–15799): az `α: f ⇒ g: a → b`, `α': f' ⇒ g': b → c`, `β: g ⇒ h: a → b`, `β': g' ⇒ h': b → c` 2-sejtekre:
  `(β' • α') ∘ (β • α) = (β' ∘ β) • (α' ∘ α) : f'∘f ⇒ h'∘h : a → c`
  A neve onnan: a négy 2-sejt `β', β, α', α` sorozatában a középső kettőt cseréli fel (15798–15799).
- **Whiskering** (15800–15839): egy 2-sejt horizontális kompozíciója egy 1-sejttel = a 2-sejt kompozíciója az 1-sejt vertikális identitásával, bármely oldalon: `f' ∘ α` (a (10) képlet).
- **Hom-kategóriás leírás** (15843–15874): `T(a, b)` a vertikális kategória a, b felett; a (9) csere és a (6) identitásszabály együtt épp azt mondja, hogy a horizontális kompozíció **bifunktor**:
  `K_{a,b,c} : T(b, c) × T(a, b) → T(a, c)`   — a (12) képlet —
  és `V_a : 1 → T(a, a)` funktor (az identitásnyíl kiválasztása) — a (13) képlet. Az adatok: (i) objektumok halmaza; (ii) minden `⟨a,b⟩`-hez egy `T(a,b)` kategória; (iii) minden hármashoz a (12) kompozíció-bifunktor; (iv) minden a-hoz `V_a` — az asszociativitási törvénnyel és azzal, hogy `V_a` kétoldali egység (15861–15874).
- **Dúsított olvasat** (15875–15888): a 2-kategória = CAT-ban dúsított kategória (hom-**objektumok** `T(a,b) ∈ CAT`, nem hom-halmazok).
- **Példák** (15841–15842; 15618–15659): CAT (kis kategóriák, funktorok, természetes transzformációk); Top homotópia-osztályokkal mint 2-sejtek (a naiv homotópia-kompozíció nem asszociatív — osztályok kellenek, 15660–15679).
- **n-kategória** (16242–16247): n darab, egymással kommutáló kategóriastruktúra; ω-kategória: i = 0, 1, 2, ….

### 1.11 Adjunkció 2-kategóriában — 15890–15921. sor (XII.4)

Egy 2-kategóriában két, ellentétes irányú 1-sejt `f: a ⇄ b: g` **adjunkt pár** (`f` bal adjunkt, `g` jobb adjunkt), ha vannak 2-sejtek ("unit" és "counit")
`η : 1_a ⇒ gf : a → a`,  `ε : fg ⇒ 1_b : b → b`   — az (1) egyenletek —
amelyekre a két egyenlet teljesül:
```
(εf) • (fη) = 1_f : f ⇒ fgf ⇒ f : a → b      (a (2) egyenlet)
(gε) • (ηg) = 1_g : g ⇒ gfg ⇒ g : b → a      (a (3) egyenlet)
```
(15893–15917). Itt `εf` a `ε ∘ 1_f` whiskering rövidítése (15919–15923). **CAT-ban e két egyenlet pontosan a IV.1(9) háromszög-törvényeket mondja** az egységre és kegységre (15919–15921).

### 1.12 Bicategory — 16253–16573. sor (XII.6–7)

Motiváció (16255–16257): ha a kompozíció csak **izomorfia erejéig** asszociatív — "a would-be category is not associative, but only associative up to an isomorphism".

- **Adatok** (16258–16284): **0-sejtek** `a, b, c, …`; **1-sejtek** `f, g, …: a → b`; **2-sejtek** `ρ, σ, …` párhuzamos (koterminális) 1-sejtek közt. Minden `⟨a, b⟩` párhoz egy **közönséges kategória** `B(a, b)`: objektumai az `a → b` 1-sejtek, nyilai a 2-sejtek; a **vertikális kompozíció** itt szigorúan asszociatív, minden `f`-hez `1_f: f ⇒ f` identitással (16279–16284).
- **Horizontális kompozíció** (16285–16293): minden `⟨a, b, c⟩` hármashoz bifunktor
  `* : B(b, c) × B(a, b) → B(a, c)`   — a (2) képlet —
  amely az 1-sejteken `g * f`, a 2-sejteken `σ * ρ` (a (3) kompozitok).
- **Egység 1-sejtek** (16321–16322): minden `a`-hoz `I_a: a → a` — de "not quite a real identity" (csak izomorfia erejéig egység).
- **Asszociátor α** (16323–16342): a `*` nem szigorúan asszociatív, hanem egy `α` **természetes izomorfizmus** erejéig az iterált kompozitfunktorok közt (a (4) diagram); természetessége a (5) kommutatív négyzetet adja (16343–16359):
  `α : (h * g) * f ⇒ h * (g * f)`.
- **Egység-izomorfizmusok** (16361–16368): `f ∈ B(a, b)`-re természetes izomorfizmusok
  `ρ_{a,b} : f * I_a ⇒ f`,  `λ_{a,b} : I_b * f ⇒ f`   — a (6) képletek.
- **Pentagon-koherencia** (16370–16384): `α, λ, ρ` a monoidális kategóriákból (§VII.1.(5)) átvett **ötszög** kommutativitását kötelesek teljesíteni `f, g, h, k` 1-sejtekre (a (7) diagram).
- **Egység-koherencia** (16386–16393): a `λ` és `ρ` közti háromszög (a (8) diagram, §VII.1.(7) mintája): `(g * I_b) * f` → `g * f` két úton egyenlő.
- **Két duális** (16395–16404): egy bicategorynek (és 2-kategóriának) két oppozíciója van: a nyilak megfordítása, és a 2-sejteké — függetlenül.
- **Gyenge 2-kategória** (16570–16573): "A bicategory is also called a 'weak 2-category'"; gyenge n-kategóriák: Baez et al. [1995, 1996].
- **Példák** (16410–16569): (a) minden **monoidális kategória** = egy 0-sejtes bicategory (1-sejtek = objektumok, kompozíció = tenzorszorzat; α, λ, ρ ugyanazok); megfordítva, egy egy-0-sejtes bicategory monoidális kategória (16410–16417); (b) **bimodulok**: 0-sejtek = gyűrűk, 1-sejtek = bimodulok, kompozíció = tenzorszorzat gyűrű felett, 2-sejtek = bimodul-homomorfizmusok (16418–16429); (c) **Span(C)**: 0-sejtek = C objektumai, 1-sejtek = spanek, kompozíció = pullback (ezért csak izomorfia erejéig asszociatív!), 2-sejtek = a háromszögeket kommutatívvá tevő középső nyilak (16430–16569).

---

## 2. Törvények listája (az Idris-bizonyítások célpontjai)

Minden tétel után a forrás-sorok. A projekt 2-kategória/adjunkció rétege ezeket kell Refl-fel/azonossággal igazolja.

### Kategória-axiómák
1. **Asszociativitás:** `k ∘ (g ∘ f) = (k ∘ g) ∘ f` — 922–926 (1.1).
2. **Bal egység:** `1_b ∘ f = f`; **jobb egység:** `g ∘ 1_b = g` — 957–964 (1.2).
3. **Az identitásnyíl egyértelmű** az egységtörvényekkel — 979–982.
4. **Arrows-only ekvivalencia:** az (i)–(iii) axiómák ⟺ az objektumos axiómák — 1018–1039.

### Funktor-törvények
5. **Kompozíció-megőrzés:** `T(g ∘ f) = Tg ∘ Tf` — 1221–1226 (a (1) egyenlet).
6. **Identitás-megőrzés:** `T(1_c) = 1_{Tc}` — 1227–1230 (arrows-only alak).
7. **Funktor-kompozíció asszociatív**, `I_B` kétoldali egység — 1288–1303.

### Természetes transzformáció
8. **Természetességi négyzet:** `τ_{c'} ∘ Sf = Tf ∘ τ_c` minden `f: c → c'`-re — 1372–1389.
9. **Természetes izomorfizmus inverze természetes:** `τ⁻¹: T ⇛ S`, `τ⁻¹ ∘ τ = 1_S`, `τ ∘ τ⁻¹ = 1_T` — 1422–1425.
10. **Horizontális kompozíció definíciója:** `(τ' ∘ τ)_c = τ'_{Tc} ∘ S'(τ_c) = T'(τ_c) ∘ τ'_{Sc}` — 2749; átírás: `τ' ∘ τ = (T'τ) • (τ'S) = (τ'T) • (S'τ)` — 2812–2814 (a (3) egyenlet).
11. **INTERCHANGE LAW:** `(τ' • σ') ∘ (τ • σ) = (τ' ∘ τ) • (σ' ∘ σ)` — 2824–2838 (az (5) egyenlet); általánosan 2880–2881.
12. **Theorem 11.5.1:** `•` és `∘` két kategóriastruktúra; az egyik identitásai a másikéi is — 2846–2853.

### Adjunkció
13. **Naturalitás (2 diagram):** `φ(k∘f) = Gk ∘ φf` és `φ(f ∘ Fh) = φf ∘ h` — 4808–4835 (a (2) diagramok).
14. **Inverz naturalitása:** `φ⁻¹(g ∘ h) = φ⁻¹g ∘ Fh`, `φ⁻¹(Gk ∘ g) = k ∘ φ⁻¹g` — 4847–4849 (a (4) egyenletek).
15. **Egység:** `η_x = φ(1_{Fx}) : x → GFx`, `η: I_X ⇛ GF` természetes — 4858–4887.
16. **φ képlete η-val:** `φ(f) = Gf ∘ η_x` — 4893–4905 (a (5) képlet).
17. **Kegység:** `ε_a = φ⁻¹(1_{Ga}) : FGa → a`, `ε: FG ⇛ I_A` természetes — 4935–4945.
18. **φ⁻¹ képlete ε-nal:** `φ⁻¹(g) = ε_a ∘ Fg` — 4947–4951.
19. **Theorem 1 (8)-kompozitok:** `Gε ∘ ηG = 1_G` és `εF ∘ Fη = 1_F` — 4974–4979.
20. **HÁROMSZÖG-AZONOSSÁGOK (Theorem 2(v), a (9) egyenlet):** `Gε_a ∘ η_{Ga} = 1_{Ga}` és `ε_{Fx} ∘ Fη_x = 1_{Fx}` — 4990–5003, 5083–5092.
21. **Theorem 2 ekvivalenciái:** (i)–(v) mindegyike meghatározza az adjunkciót — 4990–5003.
22. **A bal adjunkt egyértelmű izomorfia erejéig** — 5093–5100.

### Monád
23. **Asszociativitás:** `μ ∘ Tμ = μ ∘ μT : T³ ⇛ T` — 8051–8061, 8078–8080.
24. **Egységtörvények:** `μ ∘ ηT = 1_T`, `μ ∘ Tη = 1_T` — 8078–8080.
25. **Adjunkció → monád:** `⟨GF, η, GεF⟩` monád; `μ` asszociativitása az interchange law-ból (`εε = ε•(FGε) = ε•(εFG)`); az egységtörvények a háromszög-azonosságokból — 8091–8135.
26. **T-algebra törvények:** `h ∘ μ_x = h ∘ Th`, `h ∘ η_x = 1_x` — 8192–8222.

### Yoneda
27. **Yoneda-bijekció:** `y : Nat(D(r, −), K) ≅ Kr`, `α ↦ α_r(1_r)` — 3733–3741.
28. **Következmény:** minden `D(r,−) ⇛ D(s,−)` = `D(h,−)` egyértelmű `h: s → r`-rel — 3754–3755.
29. **Yoneda-funktor teljes és hű** — 3768–3772.
30. **y természetes K-ban és r-ben** — 3756–3767.

### Limit / colimit
31. **Kúp-feltétel (limit):** `τ_j = Fu ∘ τ_i` minden `u: i → j`-re — 4149–4152.
32. **Univerzalitás:** minden `τ: c ⇛ F` kúphoz egyértelmű `t: c → Lim F`, `τ_i = v_i ∘ t` — 4153–4155.
33. **Lim egyértelmű izomorfia erejéig** — 4181–4188.
34. **Δ ⊣ Lim, Colim ⊣ Δ:** `C(c, a × b) ≅ C(c, a) × C(c, b)`; `C(a ∐ b, c) ≅ (C × C)(⟨a, b⟩, Δc)` — 5057–5073.

### 2-kategória
35. **Horizontális kompozíció funktorialitása:** dom/cod funktorok; a 2-sejtek kategóriát alkotnak `∘` alatt — 15715–15718.
36. **Vertikális kategória:** minden `⟨a, b⟩`-re a 2-sejtek kategóriát alkotnak `•` alatt, `1_f: f ⇒ f` — 15719–15758.
37. **Identitások illesztése:** `1_{f'} ∘ 1_f = 1_{f'∘f}` — 15760–15765 (a (6) egyenlet).
38. **MIDDLE FOUR EXCHANGE (csere-törvény a 2-kategóriában):** `(β' • α') ∘ (β • α) = (β' ∘ β) • (α' ∘ α) : f'∘f ⇒ h'∘h` — 15767–15799 (a (9) egyenlet).
39. **Whiskering:** `f' ∘ α` mint `1_{f'} ∘ α` — 15800–15839.
40. **Bifunktor-ekvivalens alak:** a (9)+(6) ⟺ `K_{a,b,c}: T(b,c) × T(a,b) → T(a,c)` bifunktor + `V_a: 1 → T(a,a)` asszociatív egységgel — 15843–15874.
41. **Adjunkció 2-kategóriában:** `(εf) • (fη) = 1_f`, `(gε) • (ηg) = 1_g` — 15893–15917; CAT-ban ≡ IV.1(9) — 15919–15921.

### Bicategory
42. **A horizontális kompozíció asszociativitása csak α-ig:** `α: (h * g) * f ⇒ h * (g * f)` természetes izomorfizmus — 16323–16359.
43. **Egységek csak ρ, λ-ig:** `ρ: f * I_a ⇒ f`, `λ: I_b * f ⇒ f` — 16361–16368.
44. **Pentagon-koherencia** — 16370–16384.
45. **Háromszög (egység)-koherencia λ és ρ közt** — 16386–16393.
46. **Egy-0-sejtes bicategory ⟺ monoidális kategória** — 16410–16417.
47. **Span(C) nem szigorúan asszociatív** (pullback-egyértelműség csak izomorfia erejéig adja α-t) — 16490–16549.

---

## 3. A 2-kategória és a bicategory különbsége

| | **2-kategória** | **Bicategory** |
|---|---|---|
| Horizontális kompozíció | **szigorúan** asszociatív | csak **α-ig** asszociatív: `α: (h*g)*f ⇒ h*(g*f)` természetes izomorfizmus (16323–16359) |
| Egység | `V_a` valódi egység: `1_{1_a} ∘ α = α` stb. (15851–15874) | `I_a` csak `ρ, λ` izomorfizmusok erejéig egység: "not quite a real identity" (16321–16322, 16361–16368) |
| Extra koherenciák | nincsenek | **pentagon** + **háromszög** az α, λ, ρ-ra (16370–16393) |
| Hom-objektumok | `T(a,b)` kategóriák; CAT-dúsítás (15875–15888) | `B(a,b)` kategóriák ugyanígy (16279–16284) |
| Vertikális kompozíció | szigorú kategória `•` (15719–15758) | ugyanaz, szigorú (16279–16284) |
| Másik neve | double category + identitás-illesztés (2874–2876) | "**weak 2-category**" (16570–16571) |
| Mikor keletkezik | CAT, Top homotópiaosztályok (15841–15842) | bimodulok, Span(C) — ahol a kompozíció eredendően csak izomorfia erejéig asszociatív (16418–16569) |

**A lényeg (Mac Lane 16255–16257):** a bicategory olyan struktúra, "mint a 2-kategória, de a nyilak kompozíciója csak egy alkalmas 2-sejt által adott izomorfia erejéig asszociatív". A gyengeség pontosan az asszociativitásban és az egységben van; a vertikális struktúra mindkettőben szigorú. Minden 2-kategória bicategory triviális α, λ, ρ-val; a Span(C) példa (16490–16549) mutatja, hogy a pullback-kompozíció miért **nem lehet** szigorú.

---

## 4. Sor-hivatkozások (forrástérkép)

| Tartalom | Sorok |
|---|---|
| Metacategory axiómák (asszociativitás 1.1, egység 1.2) | 887–939 |
| Egységtörvény, kommutatív diagram definíció | 940–982 |
| Csak-nyilak axiomatika | 1016–1039 |
| Kategória mint gráf + kompozíció; hom-halmaz | 1045–1105 |
| Funktor definíció, full/faithful | 1213–1347 |
| Természetes transzformáció, természetességi négyzet | 1368–1425 |
| Functor category; horizontális kompozíció (2); (3); interchange law (5); Theorem 11.5.1; double category / 2-category | 2745–2886 |
| Reprezentáció, univerzális nyíl | 3680–3729 |
| **Yoneda-lemma** + következmény + Yoneda-funktor | 3733–3789 |
| Colimit mint univerzális nyíl, kúp | 4065–4108 |
| Limit mint univerzális nyíl, kúp, egyértelműség | 4141–4194 |
| **Adjunkció definíció** (F, G, φ) | 4794–4835 |
| Adjunkció nyilakkal, (3)–(4) | 4838–4857 |
| Unit η_x, φ = Gf∘η (5) | 4858–4933 |
| Counit ε_a, φ⁻¹ = ε∘Fg (7) | 4935–4951 |
| **Theorem 1** (η, ε, (8) kompozitok) | 4963–4979 |
| **Theorem 2** ((i)–(v), (9) háromszög-azonosságok), Corollary 1 | 4989–5100 |
| Δ ⊣ (a×b), (a∐b) ⊣ Δ | 5055–5077 |
| **Monád definíció**, asszociativitás + egységtörvények | 8043–8083 |
| Adjunkció → monád (μ = GεF; interchange law szerepe) | 8091–8135 |
| Komónád | 8139–8154 |
| T-algebra és morfizmusai | 8192–8239 |
| **2-kategória: 2-sejtek, vízszintes/függőleges kompozíció** | 15614–15758 |
| **A (6) és (9) axióma (middle four exchange)** | 15759–15799 |
| Whiskering | 15800–15841 |
| Hom-kategóriás (bifunktoros) leírás, CAT-dúsítás | 15843–15888 |
| **Adjunkció 2-kategóriában ((2), (3) háromszögek)** | 15890–15921 |
| n-kategória, ω-kategória | 16242–16247 |
| **Bicategory definíció**: 0/1/2-sejtek, *, α, λ, ρ | 16253–16368 |
| **Pentagon + egység-koherencia** | 16370–16393 |
| Két duális; "weak 2-category" | 16395–16407, 16570–16573 |
| Példák: monoidális kategória, bimodulok, Span(C) | 16408–16569 |
