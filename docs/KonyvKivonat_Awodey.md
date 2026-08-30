# Awodey "Category Theory" (2006) — Kivonat a projekt bizonyítási rétegéhez

Forrás: `trail_index/books/awodey_category_theory.txt` (14444 soros OCR-szöveg).
Minden fogalom-hivatkozás (sor: A–B) alakban a txt-fájl soraira mutat.

---

## 1. Definíciók

### 1.1 Kategória (Definíció 1.1, sor: 646–681)

Egy kategória a következő adatokból áll:
- **Objektumok**: A, B, C, …
- **Nyilak**: f, g, h, …; minden f nyílhoz adott `dom(f)` és `cod(f)` (a tartomány és a képtartomány), jelölése `f : A → B` (sor: 649–657).
- **Kompozíció**: adott `f : A → B` és `g : B → C` (azaz `cod(f) = dom(g)`) esetén adott egy `g ◦ f : A → C` nyíl (sor: 658–664).
- **Identitás**: minden A objektumhoz adott `1_A : A → A` (sor: 665–667).

Törvények (sor: 673–681):
- **Asszociativitás**: `h ◦ (g ◦ f) = (h ◦ g) ◦ f` minden `f : A → B`, `g : B → C`, `h : C → D` esetén.
- **Egység**: `f ◦ 1_A = f = 1_B ◦ f` minden `f : A → B` esetén.

Awodey hangsúlya (sor: 682–687): az objektumoknak NEM kell halmaznak lenniük és a nyilaknak NEM kell függvénynek lenniük; a kategória "függvények absztrakt algebrája", a kompozíció művelete primitív. Szlogen (sor: 843–844): **"It's the arrows that really matter!"** — a nyilak számítanak igazán.

### 1.2 Funktor (Definíció 1.2, sor: 847–853)

`F : C → D` kategóriák közötti funktor = objektumok objektumokba, nyilak nyilakba való leképezése úgy, hogy:
- (a) `F(f : A → B) = F(f) : F(A) → F(B)`
- (b) `F(g ◦ f) = F(g) ◦ F(f)`
- (c) `F(1_A) = 1_{F(A)}`

A funktorok maguk is kategóriát alkotnak: **Cat**, a kategóriák és funktorok kategóriája (sor: 854–857).

### 1.3 Izomorfizmus (Definíció 1.3, sor: 956–963)

Egy `f : A → B` nyíl izomorfizmus, ha van olyan `g : B → A` nyíl, hogy `g ◦ f = 1_A` és `f ◦ g = 1_B`. Az inverz egyértelmű, jelölése `g = f^{−1}`; A izomorf B-vel, `A ≅ B`.
Megjegyzés (sor: 965–971): ez absztrakt, kategóriaelméleti definíció — minden kategóriában értelmes; Pos-ban a kategóriaelméleti definíció adja a HELYES fogalmat, mert van "bijektív homomorfizmus" nem izomorf posetek között.
Kapcsolódó (Definíció 1.4, sor: 972–973): egy **csoport** olyan monoid (egyobjektumú kategória), amelyben minden nyíl izomorfizmus.

### 1.4 Monomorfizmus és epimorfizmus (Definíció 2.1, sor: 1654–1682)

Egy `f : A → B` nyíl:
- **monomorfizmus** (mono), ha minden `g, h : C → A` esetén `f g = f h` maga után vonja `g = h` (balról törölhető);
- **epimorfizmus** (epi), ha minden `i, j : B → D` esetén `i f = j f` maga után vonja `i = j` (jobbról törölhető).

Jelölés: `f : A ↣ B` (mono), `f : A ↠ B` (epi).

- Állítás 2.2 (sor: 1683–1697): Sets-ben a monók pontosan az injektív függvények.
- Példa 2.3 (sor: 1698–1713): strukturált halmazok kategóriáiban (monoidok, csoportok, gyűrűk, vektorterek, posetek) a monók pontosan az injektív homomorfizmusok — ez a szabad objektumok (pl. a szabad monoid `M(*)`) univerzális tulajdonságából következik.
- Példa 2.5 (sor: 1719–1744): **Mon-ban az `N ↪ Z` beágyazás epi is,** pedig nem szürjektív — tehát epi ≠ szürjektív általában. A bizonyítás a `f(−n) = f(−1)^n` felbontással megy.
- Állítás 2.6 (sor: 1748–1768): **minden izo egyszerre mono és epi**; a megfordítás Sets-ben igaz, általában NEM (monoidok ellenpélda).
- Felhasított (split) mono/epi (Definíció 2.13, sor: 2060): bal (jobb) oldali inverzzel rendelkező nyíl.

### 1.5 Kezdeti és végobjektum (Definíció 2.7, sor: 1779–1783)

- **0 kezdeti**, ha minden C objektumhoz pontosan egy `0 → C` nyíl van;
- **1 végobjektum** (terminális), ha minden C objektumhoz pontosan egy `C → 1` nyíl van.

Állítás 2.8 (sor: 1789–1816): a kezdeti (vég-) objektumok izomorfizmus erejéig egyértelműek — az egyértelműség a két nyíl kompozíciójának az identitással való összehasonlításából jön.
Példák (sor: 1817–1832): Sets-ben az üres halmaz kezdeti, a szingletonok végobjektumok; Cat-ben a 0 kategória kezdeti, az 1 kategória végobjektum.

### 1.6 Szorzat — univerzális leképezési tulajdonsággal (Definíció 2.16, sor: 2194–2244)

A és B **szorzatdiagramja**: egy P objektum és `p₁ : A ← P`, `p₂ : P → B` nyilak úgy, hogy minden `x₁ : A ← X`, `x₂ : X → B` diagramhoz létezik **egyetlen** `u : X → P`, amelyre a diagram kommutál: `x₁ = p₁ u` és `x₂ = p₂ u`.
A két rész (Megjegyzés 2.17, sor: 2242–2244):
- **Egzisztencia**: van ilyen u.
- **Egyértelműség**: ha `p₁ v = x₁` és `p₂ v = x₂`, akkor `v = u`.

Állítás 2.18 (sor: 2245–2274): a szorzatok izomorfizmus erejéig egyértelműek. Megjegyzés (sor: 2291): egy párnak sok különböző szorzatdiagramja lehet, de mind izomorf.

### 1.7 Exponenciális (Definíció 6.1, sor: 6134–6188)

Legyen C kategória bináris szorzatokkal. B és C **exponenciálisa**: egy `C^B` objektum és egy `ε : C^B × B → C` nyíl (a **kiértékelés**, evaluation) úgy, hogy minden Z objektumhoz és `f : Z × B → C` nyílhoz létezik **egyetlen** `f̃ : Z → C^B` (az **exponenciális transzponált**), amelyre:

`ε ◦ (f̃ × 1_B) = f`

A transzponálás oda-vissza az identitás: `g̃̄ = g`, `f̃̄ = f` (sor: 6175–6184), így izomorfizmus:

`Hom_C(Z × B, C) ≅ Hom_C(Z, C^B)`  (sor: 6185–6188)

Sets-beli motiváció (sor: 6085–6087): `Hom_Sets(A × B, C) ≅ Hom_Sets(A, C^B)` — a kétváltozós függvény = paraméterezett függvénycsalád (currying).

### 1.8 Karteziánus zárt kategória (Definíció 6.2, sor: 6190–6191)

Egy kategória **karteziánus zárt**, ha minden véges szorzata ÉS minden exponenciálisa létezik.
Példák: Sets, Sets_fin (sor: 6192–6196); **Pos** (sor: 6197–6258) — a `Q^P` exponenciális a monoton függvények halmaza pontonkénti rendezéssel; ωCPO (sor: 6259–6268).
Állítás 6.6 (sor: 6299–6301): karteziánus zárt kategóriában rögzített A-ra `(−)^A : C → C` funktor (`f ↦ f^A`, ahol `f^A(g) = f ◦ g`).

### 1.9 Természetes transzformáció (Definíció 7.6, sor: 7445–7468)

F, G : C → D funktorok közötti **természetes transzformáció** `ϑ : F → G` = D-beli nyilak családja:

`(ϑ_C : F C → G C)_{C ∈ C₀}`

úgy, hogy minden `f : C → C′` nyílra a **természetességi négyzet kommutál**:

`ϑ_C′ ◦ F(f) = G(f) ◦ ϑ_C`

Szöveges diagram-leírás (sor: 7451–7465): a négyzet felső éle `ϑ_C : F C → G C`, alsó éle `ϑ_C′ : F C′ → G C′`, bal oldala `F f`, jobb oldala `G f`; a négyzet mindkét útja egyenlő. A `ϑ_C` nyíl a ϑ **komponense** C-nél. Képszerű magyarázat (sor: 7469–7471): ha F a C "képe" D-ben, akkor ϑ egy "henger" a két kép között.

Motiváció (sor: 7386–7429): az `(A × B) × C ≅ A × (B × C)` izomorfizmus NEM függ az A, B, C konkrét objektumoktól — ez `(− × B) × C ≅ − × (B × C)` funktor-izomorfizmus.

### 1.10 Funktorkategória, természetes izomorfizmus (Definíció 7.9–7.10, sor: 7570–7583)

- **Fun(C, D)**: objektumok = funktorok, nyilak = természetes transzformációk; az identitás komponensei `(1_F)_C = 1_{FC}`, a kompozíció komponensei `(φ ◦ ϑ)_C = φ_C ◦ ϑ_C`.
- **Természetes izomorfizmus**: Fun(C, D)-beli izomorfizmus.
- Lemma 7.11 (sor: 7589–7591): ϑ természetes izomorfizmus ⟺ MINDEN komponense izomorfizmus.

### 1.11 Yoneda-beágyazás (Definíció 8.1, sor: 8752–8761)

Az `y : C → Sets^{C^op}` funktor:
- `yC = Hom_C(−, C) : C^op → Sets` (reprezentálható funktor, "presheaf");
- `yf = Hom_C(−, f) : Hom_C(−, C) → Hom_C(−, D)` (a komponens: prekompozíció `f`-fel: `(h : C′ → C) ↦ (f ◦ h : C′ → D)`).

Hasonlatok (sor: 8765–8809): a Cayley-reprezentáció (`G ↣ Aut(|G|)`) és a poset-leképezés `↓ : P ↣ Low(P)` általánosítása; a Yoneda-beágyazás azért "jobb", mert TELJES (full): minden `ϑ : yC → yD` egy egyértelmű `h : C → D`-ből jön, mint `ϑ = yh`.

### 1.12 Yoneda-lemma (Lemma 8.2, sor: 8811–8816)

Legyen C lokálisan kicsi. Minden C ∈ C objektumhoz és `F ∈ Sets^{C^op}` funktorhoz izomorfizmus van:

`Hom(yC, F) ≅ F C`

ami természetes mind F-ben, mind C-ben.
Bizonyítás (sor: 8853–8988):
- `η_{C,F}(ϑ) = ϑ_C(1_C)` (az identitás "próba");
- fordítva: `a ∈ F C`-hez a `ϑ_a` természetes transzformáció, amelynek komponense `(ϑ_a)_{C′}(h) = F(h)(a)` a `h : C′ → C` nyílon;
- `ϑ_{xϑ} = ϑ` és `x_{ϑa} = a` — a két irány egymás inverze;
- a természetesség a két négyzet (sor: 8819–8847) kommutativitása.

Következmények:
- **Tétel 8.3** (sor: 8990–9004): a Yoneda-beágyazás teljes és hű (full and faithful).
- **Következmény 8.5** (sor: 9047–9052): lokálisan kicsi C-ben `A ≅ B` ⟺ `yA ≅ yB` — az izomorfizmus-bizonyítás "Yoneda-útja".
- **Példa** (sor: 9053–9071): karteziánus zárt kategóriában `(A^B)^C ≅ A^{(B×C)}` — a bonyolult közvetlen bizonyítás helyett elég a Hom-izomorfizmus-lánc: `Hom(X, (A^B)^C) ≅ Hom(X×C, A^B) ≅ Hom((X×C)×B, A) ≅ Hom(X×(B×C), A) ≅ Hom(X, A^{(B×C)})`.
- **Állítás 8.6** (sor: 9073–9091): karteziánus zárt + koproduktok ⇒ disztributivitás: `(A × B) + (A × C) ≅ A × (B + C)`.
- **Logikai példa** (sor: 9092–9094): `ϕ ⊣⊢ ψ` bizonyításához elég, hogy minden ϑ formulára `ϑ ⊢ ϕ` ⟺ `ϑ ⊢ ψ`.
- **"Ideális elemek"** (sor: 9096–9110): `Sets^{C^op}` teljes, koteljes, karteziánus zárt — "magasabb rendű" eszközökkel lehet benne számolni, és a `yA → yB` alakú eredmény egyértelmű `A → B` nyílból jön; ez olyan, mint a komplex számokra áttérés a valós egyenletek megoldásához, vagy magasabb típusok hozzáadása egy logikai elmélethez.

### 1.13 Adjunkció — előzetes definíció (Definíció 9.1, sor: 9858–9889)

Egy **adjunkció** C és D kategóriák között:
- funktorok `F : C ⇄ D : U` és
- egy természetes transzformáció `η : 1_C → U ◦ F` (az **egység**, unit)
- a (*) tulajdonsággal (**az egység univerzális tulajdonsága**): minden C ∈ C, D ∈ D és `f : C → U(D)` nyílhoz létezik egyetlen `g : F C → D`, amelyre:

`f = U(g) ◦ η_C`

Szóhasználat: F a **bal adjunkt**, U a **jobb adjunkt**, jelölése `F ⊣ U`. A (*) állítás maga a η egység univerzális leképezési tulajdonsága.

Motiváló példa — szabad monoid (sor: 9805–9853): a `φ : Hom_Mon(F(X), M) → Hom_Sets(X, U(M))`, `g ↦ U(g) ◦ i_X` leképezés izomorfizmus: `Hom_Mon(F(X), M) ≅ Hom_Sets(X, U(M))` — kétszabályos alakban: felső nyíl `F(X) → M`, alsó nyíl `X → U(M)`, egyikből a másik egyértelmű.

### 1.14 Adjunkció — Hom-halmaz definíció (Definíció 9.6 "hivatalos", sor: 10249–10260)

Egy adjunkció: funktorok `F : C ⇄ D : U` és egy **természetes izomorfizmus**:

`φ : Hom_D(F C, D) ≅ Hom_C(C, U D) : ψ`

Az egység és a koegység (counit) ebből:

`η_C = φ(1_{F C})`, `ε_D = ψ(1_{U D})`

Állítás 9.4 (sor: 10019–10044): az egység-univerzális-tulajdonságos alak EKVIVALENS a Hom-halmaz izomorfizmussal, az összekötő képletek: `φ(g) = U(g) ◦ η_C`, `η_C = φ(1_{F C})`.
Következmény 9.5 (sor: 10203–10245): a duális alak — a `ε : F ◦ U → 1_D` koegység univerzális tulajdonsága: minden `g : F(C) → D`-hez egyetlen `f : C → U D`, hogy `g = ε_D ◦ F(f)`; összekötő képletek `ψ(f) = ε_D ◦ F(f)`, `ε_D = ψ(1_{U D})`.

### 1.15 Háromszög-azonosságok (sor: 12426–12487)

Adott `F : C ⇄ D : U` adjunkció `η : 1_C → U F` egységgel és `ε : F U → 1_D` koegységgel. A `φ(ε_D) = U(ε_D) ◦ η_{U D}` és `φ^{−1}(η_C) = ε_{F C} ◦ F(η_C)` számításokból a két diagram kommutativitása:

`U ε ◦ η U = 1_U`   (10.1)

`ε F ◦ F η = 1_F`   (10.2)

Állítás 10.1 (sor: 12488–12528): `F ⊣ U` η egységgel és ε koegységgel ⟺ a két háromszög-azonosság teljesül. A bizonyítás a két `φ(f) = U(f) ◦ η_C`, `ϑ(g) = ε_D ◦ F(g)` leképezés kölcsönös inverzségét ellenőrzi (a természetességi négyzetek felhasználásával). A háromszög-azonosságok "teljesen algebraiak": nincs bennük kvantor, határérték, Hom-halmaz, végtelen feltétel — bármi, amit adjunkció definiál, egyenletekkel definiálható (sor: 12529–12533).

### 1.16 Monád (Definíció 10.2, sor: 12681–12687)

Egy **monád** a C kategórián: egy endofunktor `T : C → C`, és természetes transzformációk `η : 1_C → T`, `µ : T² → T`, amelyekre:

`µ ◦ µT = µ ◦ Tµ`          (asszociativitás)

`µ ◦ ηT = 1 = µ ◦ Tη`      (egységtörvények)

A formai analógia a monoidegységgel nyilvánvaló (sor: 12686–12687).

Állítás 10.3 (sor: 12695–12702): **minden** `F ⊣ U` adjunkció (`η`, `ε`) monádot ad C-n: `T = U ◦ F : C → C`, `η` az egység, `µ = U ε F : T² → T`.
Állítás 10.6 (sor: 12767–12776): **minden** monád adjunkcióból jön: a `C^T` Eilenberg–Moore-kategória (objektumok: T-algebrák `(A, α : T A → A)`), `F : C ⇄ C^T : U`, `T = U ◦ F`, `µ = U ε F`.

Példák:
- Poseten a monád = infláció + idempotencia = **lezárási operátor** `T p = p̄`; példa a modális logika "lehetőség" operátora `◊p` (sor: 12703–12708).
- A hatványhalmaz-funktor `P : Sets → Sets` monád: `η_X(x) = {x}` (szingleton), `µ_X(α) = ∪α` (unió) (sor: 12743–12754).

---

## 2. Törvények listája

| # | Törvény | Képlet | Hely (sor) |
|---|---------|--------|------------|
| 1 | Kompozíció asszociativitása | `h ◦ (g ◦ f) = (h ◦ g) ◦ f` | 676 |
| 2 | Egységtörvény | `f ◦ 1_A = f = 1_B ◦ f` | 680 |
| 3 | Funktor megőrzi a kompozíciót | `F(g ◦ f) = F(g) ◦ F(f)` | 852 |
| 4 | Funktor megőrzi az identitást | `F(1_A) = 1_{F(A)}` | 853 |
| 5 | Izomorfizmus | `g ◦ f = 1_A` és `f ◦ g = 1_B` | 958–960 |
| 6 | Mono (bal törlés) | `f g = f h ⇒ g = h` | 1657 |
| 7 | Epi (jobb törlés) | `i f = j f ⇒ i = j` | 1667 |
| 8 | Kezdeti/végobjektum egyértelműsége | egyértelmű izo | 1789–1816 |
| 9 | Szorzat univerzális tulajdonsága | `x₁ = p₁ u` és `x₂ = p₂ u`, u egyértelmű | 2208–2241 |
| 10 | Exponenciális univerzális tulajdonsága | `ε ◦ (f̃ × 1_B) = f` | 6144 |
| 11 | Transzponálás oda-vissza | `g̃̄ = g`, `f̃̄ = f`; Hom-izo | 6175–6188 |
| 12 | Természetességi négyzet | `ϑ_C′ ◦ F(f) = G(f) ◦ ϑ_C` | 7449 |
| 13 | Funktorkategória-kompozíció | `(φ ◦ ϑ)_C = φ_C ◦ ϑ_C` | 7580 |
| 14 | Természetes izo ⟺ komponensenként izo | minden `ϑ_C` izo | 7589–7591 |
| 15 | Yoneda-izomorfizmus | `Hom(yC, F) ≅ F C` | 8814 |
| 16 | Yoneda-inverzek | `xϑ = ϑ_C(1_C)`; `(ϑ_a)_C′(h) = F(h)(a)` | 8859–8928 |
| 17 | Adjunkció (egység-ump) | `f = U(g) ◦ η_C`, g egyértelmű | 9866 |
| 18 | Adjunkció (Hom-halmaz) | `φ : Hom_D(F C, D) ≅ Hom_C(C, U D)` természetes | 10254 |
| 19 | Egység/koegység Hom-ból | `η_C = φ(1_{F C})`; `ε_D = ψ(1_{U D})` | 10259–10260 |
| 20 | Koegység-ump | `g = ε_D ◦ F(f)`, f egyértelmű | 10220 |
| 21 | Háromszög-azonosság 1 | `U ε ◦ η U = 1_U` | 12479 |
| 22 | Háromszög-azonosság 2 | `ε F ◦ F η = 1_F` | 12483 |
| 23 | Monád-asszociativitás | `µ ◦ µT = µ ◦ Tµ` | 12684 |
| 24 | Monád-egység | `µ ◦ ηT = 1 = µ ◦ Tη` | 12685 |
| 25 | Adjunkcióból monád | `T = U ◦ F`, `µ = U ε F` | 12697–12702 |

---

## 3. Példák a magyar/kínai nyelvi modellre átvihetően

### 3.1 Szintaxis–szemantika adjunkció (a szabad monoid mintájára)

Awodey két logikai/nyelvi kategóriapéldája:
- **Levezetési rendszer kategóriája** (sor: 886–895): objektumok = formulák, nyilak = levezetések (egy formulából a másikba); UGYANAZOK a formulák között SOK nyíl lehet, mert sok bizonyítás lehet. A kompozíció a levezetések összefűzése.
- **Programnyelv kategóriája** (sor: 896–918): objektumok = adattípusok, nyilak = programok; a **denotációs szemantika** egy `S : C(L) → D` FUNKTOR (Scott-domainekbe) — a szemantika tehát funktor a szintaxis kategóriájából.

Átvitel a magyar/kínai modellre: a szabad monoid adjunkció `F ⊣ U` (sor: 9805–9853) a generatív nyelvtan formája: `Hom_Mon(F(X), M) ≅ Hom_Sets(X, U(M))` — **"a szavak füzéréből (szabad szó-monoid) minden 'jelentés-struktúrába' való leképezést pontosan meghatároz az, hogy mit tesz a generátor-szavakkal."** A szabad konstrukció = a nyelvtan (szintaxis), az U felejtő funktor = a "jelentés nélküli betűhalmaz", az egység `η_X : X → U F(X)` = a generátorok beillesztése. A magyar agglutináció (tő + toldalékok = típuskompozíció) pontosan ilyen: a toldalék-kompozíció asszociatív monoid, a szótő = generátor.

### 3.2 Kvantorok mint adjunktok — a kötött változók elmélete

(sor: 10542–10618) Lawvere felismerése: `∃ ⊣ ∗ ⊣ ∀`, azaz
```
  ∃y.ψ(x̄,y) ⊢ φ(x̄)
  ================
  ψ(x̄,y) ⊢ ∗φ(x̄)
```
és a másik irány:
```
  ∗φ(x̄) ⊢ ψ(x̄,y)
  ================
  φ(x̄) ⊢ ∀y.ψ(x̄,y)
```
A `∗` a "változó-hanyagolás" funktor (`Form(x̄) → Form(x̄, y)`), a koegység maga a ∀-elimináció axióma: `∀y.ψ(x̄,y) ⊢ ψ(x̄,y)`, az egység az ∃-bevezetés: `ψ(x̄,y) ⊢ ∃y.ψ(x̄,y)`. A szokásos bevezetési/eliminációs szabályok HELYETTESÍTHETŐK az adjunkt kétszabályokkal, és tipikus predikátumlogikai törvények pusztán adjunkt-manipulációk (sor: 10600–10618).

Geometriai alak (sor: 10619–10642): `∗ = π⁻¹` (a vetítés ősképe) és `∃ = im(π)` (a vetítés képe) — `P(M) ⇄ P(M × M)`.
Átvitel: a magyar toldalékolás úgy viselkedik, mint a kvantor-kötés: egy toldalék "köti" a tő változóját, és a `∗`-funktor a "hallgatólagos argumentum" bevezetése. A `∃ ⊣ ∗ ⊣ ∀` lánc = a határozott/hallgató alany háromféle kezelése: kimondva (∃), hallgatólagosan (∗), általános alanyként (∀).

### 3.3 Exponenciális = a szó "jelentés-típusa" (−×A ⊣ (−)^A)

(sor: 10262–10305) A szorzatfunktor jobb adjunktja az exponenciális: `− × A ⊣ (−)^A`, a koegység maga a kiértékelés `ε : Y^A × A → Y` (sor: 10288–10305). Hom-halmaz alakban: `Hom(X × A, Y) ≅ Hom(X, Y^A)` — **"egy X-szel és A-val társított Y érvényes kifejezés = egy X-ből az 'A → Y' jelentés-függvények halmazába menő leképezés."**
Átvitel: A = egy toldalék (vagy egy szomszédos szó argumentumhelye), `Y^A` = az összes lehetséges "jelentés-kiértékelés" típusa. A magyar vonzatkeret (valencia) ilyen exponenciális: `Y^A × A → Y` a kiértékelés = a toldalékolt alak jelentésének kiszámítása. A karteziánus zárt kategória (sor: 6190–6191) a "nyelv mint típusos elmélet" teljes követelménye: szorzatok (szintagmák) + exponenciálisok (vonzatkeretek).

### 3.4 Yoneda = a jelentés a kontextusokban van

(sor: 8811–8816) `Hom(yC, F) ≅ F C` — nyelvi olvasatban: **"egy szó (struktúra) jelentését teljesen meghatározza az összes lehetséges kontextus, amelyben előfordulhat."** `yC = Hom(−, C)` = a C szó "kontextus-profilja"; a lemma szerint a kontextus-profilra ható természetes transzformációk pontosan a szó saját adatai. A Tétel 8.3 (sor: 8990–9004): ha két szó kontextus-profilja izomorf, akkor maguk a szavak izomorfak (jelentés-azonosság). Az "ideális elemek" megjegyzés (sor: 9096–9110): a lexikon `Sets^{C^op}`-beli kiterjesztése "magasabb rendű" műveleteket enged (mint a komplex számok), és az eredmény egyértelműen visszavetíthető a nyelvre — ez a projekt lexikon-építő rétegének (magyar-lexikon skill) matematikai magja.

### 3.5 Monád = a jelentés lezárása

(sor: 12703–12708) Poseten a monád lezárási operátor, példája a modális `◊` (lehetőség) operátor. A hatványhalmaz-monád `η_X(x) = {x}`, `µ_X(α) = ∪α` (sor: 12743–12754) a "jelentés-halmazok" modellje: a szó → a lehetséges jelentések halmaza (`η` = a konkrét jelentés), a jelentéshalmazok halmazának uniója (`µ`) = a lezárás. A monád törvényei (sor: 12684–12685) pontosan azt mondják ki, hogy a "jelentés-lezárás" idempotens és egységes — a projekt fázis-alapú redundancia-szabálya (azonos fázisú fogalmak eldobása) lezárási operátorként fogalmazható meg.

### 3.6 Epis/monos — a fonetika iránya

(sor: 1654–1682) Mono = balról törölhető = **egyértelmű visszafejtés** (a fonetikus átíratból egyértelmű a betűzés); epi = jobbról törölhető = **teljes kifejezhetőség**. A monoid-beli `N ↪ Z` epi-példa (sor: 1719–1744) azt mutatja, hogy "kevés adatból" is rekonstruálható lehet a teljes struktúra — ez a toldalékolt alakokból a ragozási paradigma rekonstrukciójának analógiája. Minden izo mono és epi (sor: 1748–1768), de nem fordítva: a nyelvben az "oda-vissza meghatározott" (izo) alakok ritkák, a mono-epi alakok gyakoriak.

### 3.7 A deduktív kategória és a bizonyítási réteg

(sor: 886–895) A formulák kategóriája, ahol az azonos formulák között SOK nyíl van (több bizonyítás), és a kompozíció a levezetések összefűzése — ez a projekt Idris-bizonyításainak (Refl, trans, cong, rewrite) kategóriaelméleti megfelelője: a típusok = formulák, a függvények = levezetések. Awodey megjegyzi (sor: 893–895), hogy ez a kategória "nagyon gazdag struktúrájú", és a λ-kalkulussal kapcsolatos — azaz a karteziánus zárt kategóriákkal (sor: 916–918).

---

## 4. Sor-hivatkozások (témakörönként)

| Témakör | Sorok a txt-fájlban |
|---------|---------------------|
| Kategória definíció + törvények (Def. 1.1) | 645–687 |
| Példák: Sets, Pos, Rel, véges kategóriák, monoidok | 689–949 |
| Funktor (Def. 1.2) + Cat | 845–857 |
| Logikai (deduktív) kategória | 886–895 |
| Programnyelv kategória, denotációs szemantika | 896–918 |
| Izomorfizmus (Def. 1.3) | 955–963 |
| Szabad monoid univerzális tulajdonsága (Áll. 1.9) | 1293–1330 |
| Epis és monos (Def. 2.1, Áll. 2.2, Példák 2.3–2.5, Áll. 2.6) | 1649–1770 |
| Kezdeti és végobjektum (Def. 2.7, Áll. 2.8, Példa 2.9) | 1776–1832 |
| Felhasított mono/epi (Def. 2.13) | 2060 |
| Szorzat univerzális tulajdonsággal (Def. 2.16, Áll. 2.18) | 2132–2274 |
| Exponenciális (Def. 6.1, transzponálás) | 6059–6188 |
| Karteziánus zárt kategória (Def. 6.2, Példák 6.3–6.5) | 6189–6268 |
| Exponenciálás mint funktor (Áll. 6.6) | 6299–6301 |
| Természetes transzformáció (Def. 7.6) | 7381–7471 |
| Példák: szabad monoid egység, csavarás (Példa 7.7–7.8) | 7490–7568 |
| Funktorkategória, természetes izo (Def. 7.9–7.10, Lemma 7.11) | 7570–7591 |
| Yoneda-beágyazás (Def. 8.1, Cayley/Low-analógiák) | 8725–8809 |
| Yoneda-lemma (Lemma 8.2, teljes bizonyítás) | 8810–8988 |
| Yoneda teljes-hű (Tétel 8.3, Köv. 8.5) | 8989–9052 |
| Yoneda-alkalmazások: CCC-izók, disztributivitás, logika, ideális elemek | 9053–9110 |
| Adjunkció előzetes definíció (Def. 9.1, szabad monoid példa) | 9804–10015 |
| Hom-halmaz definíció (Áll. 9.4, Köv. 9.5, Def. 9.6) | 10016–10260 |
| Adjunkció példák: −×A ⊣ (−)^A, ! ⊣ végobjektum | 10261–10321 |
| Kvantorok mint adjunktok (∃ ⊣ ∗ ⊣ ∀) | 10542–10651 |
| Háromszög-azonosságok (Áll. 10.1) | 12426–12533 |
| Monádok és adjunkciók (Áll. 10.3, lezárási és hatványhalmaz példák) | 12534–12764 |
| Minden monád adjunkcióból (Áll. 10.6, Eilenberg–Moore) | 12766–12785 |
