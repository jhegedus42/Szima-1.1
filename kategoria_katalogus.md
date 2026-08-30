# Kategorikus Katalógus — A matematikában szereplő kategóriák átfogó listája

Források: Wikipedia (Outline of category theory, Category (mathematics), Category of sets, Derived category, Topos, Homotopy category), nLab (category, Cat, Yoneda lemma, stb.), Mac Lane *Categories for the Working Mathematician*, Awodey *Category Theory*.

---

## I. ALGEBRA

### 1. Set — Halmazok kategóriája
- **Objektumok**: halmazok
- **Morfizmusok**: függvények halmazok között
- **Tulajdonságok**: teljes és ko-teljes (complete/cocomplete), kartéziánusan zárt (cartesian closed), elemi topos, lokálisan végesen prezentálható, **nem** abeli, **nem** additív, **nem** preadditív
- **Kezdő objektum**: üres halmaz; **Végobjektum**: egyetlen elemű halmaz (singleton); nincs zéró objektum
- **Epi**: szürjektív; **Mono**: injektív; **Izo**: bijektív
- **Résztárgy-osztályozó**: kételemű halmaz; **Hatványobjektum**: hatványhalmaz; **Exponenciális objektum**: B^A = A-ból B-be összes függvények halmaza
- **Tétel**: Set a Grothendieck topos archetípusa (a pont topológiai terén nyalábok kategóriája)

### 2. FinSet — Véges halmazok kategóriája
- **Objektumok**: véges halmazok
- **Morfizmusok**: függvények
- **Tulajdonságok**: kartéziánusan zárt, lokálisan végesen prezentálható, topos (de **nem** Grothendieck topos, mert nincs elegendő kolimit), teljes és ko-teljes
- **Kezdő objektum**: üres halmaz; **Végobjektum**: egyetlen elemű halmaz

### 3. Grp — Csoportok kategóriája
- **Objektumok**: csoportok
- **Morfizmusok**: csoport homomorfizmusok
- **Tulajdonságok**: teljes és ko-teljes, konkret kategória, **nem** abeli, **nem** additív, **nem** kartéziánusan zárt, **nem** topos
- **Kezdő objektum**: triviális csoport (egyetlen elemű); **Végobjektum**: triviális csoport (tehát **zéró objektum** van)
- **Epi**: szürjektív homomorfizmus; **Mono**: injektív homomorfizmus
- **Szorzat**: direkt szorzat; **Koprodukt**: szabad szorzat (free product)
- **Tétel**: Grp monadikus Set felett (a "szabad csoport" monád)

### 4. Ab — Abeli csoportok kategóriája
- **Objektumok**: abeli csoportok
- **Morfizmusok**: csoport homomorfizmusok
- **Tulajdonságok**: **abeli kategória** (az archetipikus példa), teljes és ko-teljes, preadditív, additív, monoidális (tenzorszorzattal)
- **Kezdő és végobjektum**: triviális csoport (zéró objektum)
- **Szorzat/Koprodukt**: direkt szorzat = direkt összeg (biproduktum)
- **Tétel**: Mitchell beágyazási tétele (Freyd-Mitchell) — minden kis abeli kategória beágyazható R-Mod-ba; Kígyó lemma (Snake lemma), Ötös lemma (Five lemma), Kilences lemma (Nine lemma)

### 5. Ring — Gyűrűk kategóriája
- **Objektumok**: gyűrűk (egység nélküli vagy egységes, attól függően)
- **Morfizmusok**: gyűrű homomorfizmusok
- **Tulajdonságok**: teljes és ko-teljes, konkret, **nem** abeli, **nem** additív, **nem** kartéziánusan zárt
- **Kezdő objektum**: Z (egész számok gyűrűje, egységes gyűrűk esetén); **Végobjektum**: zéró gyűrű
- **Epi**: szürjektív; **Mono**: injektív
- **Részkategória**: CRing (kommutatív gyűrűk), k-Alg (k-algebrák)

### 6. Field — Testek kategóriája
- **Objektumok**: testek
- **Morfizmusok**: test homomorfizmusok (mindig injektív)
- **Tulajdonságok**: **nem** teljes, **nem** ko-teljes (szorzat nem létezik általában), **nem** abeli, **nem** additív
- **Kezdő objektum**: Q (prím test karakterisztika 0); prímtestek p karakterisztikánál
- **Morfizmusok mindegyike mono** (test homomorfizmus injektív)
- **Figyelem**: Field **nem** algebrai kategória a szokásos értelemben

### 7. R-Mod — R-modulok kategóriája (fix gyűrű R felett)
- **Objektumok**: bal (vagy jobb) R-modulok
- **Morfizmusok**: R-modul homomorfizmusok
- **Tulajdonságok**: **abeli kategória** (R kommutatív esetén monoidális tenzorszorzattal), teljes és ko-teljes, preadditív, additív
- **Kezdő/végobjektum**: zéró modul (zéró objektum)
- **Szorzat/Koprodukt**: direkt szorzat / direkt összeg (biproduktum)
- **Tétel**: Mitchell beágyazási tétele; elegendő injektív/projektív (Grothendieck abeli kategória ha R noether); Ext és Tor functorok

### 8. Vect_K (K-Vect) — Vektorterek kategóriája K test felett
- **Objektumok**: vektorterek K felett
- **Morfizmusok**: K-lineáris leképezések
- **Tulajdonságok**: **abeli kategória**, teljes és ko-teljes, monoidális (tenzorszorzat), zárt monoidális (belső Hom = Hom_K(V,W) vektortér), szimmetrikus monoidális
- **Kezdő/végobjektum**: zéró térrész (zéró objektum)
- **Részkategória**: fdVect_K (véges dimenziós vektorterek) — **nem** teljes/ko-teljes, de abeli és monoidális
- **Tétel**: duálisan ekvivalens önmagával ( Vect_K^op ≃ Vect_K véges dimenzióban a duál via)

### 9. Rep_K(G) — G reprezentációinak kategóriája K felett
- **Objektumok**: G reprezentációk K felett (K-vektorterek G-val)
- **Morfizmusok**: ekvivalens leképezések (G-equivariant maps)
- **Tulajdonságok**: ekvivalens a K[G]-Mod kategóriával (csoportalgebra moduljai), tehát **abeli**, teljes, ko-teljes, monoidális (ha G kommutatív vagy koalgebra struktúra)
- **Tétel**: Maschke tétel (ha char(K) nem osztója |G|, akkor minden véges dimenziós reprezentáció felbontható); Tannaka-Krein dualitás

### 10. Mon — Monoidok kategóriája
- **Objektumok**: monoidok
- **Morfizmusok**: monoid homomorfizmusok
- **Tulajdonságok**: teljes és ko-teljes, konkret, **nem** abeli, **nem** additív, monoidális (közvetlen szorzat)
- **Kezdő objektum**: triviális monoid ({e}); **Végobjektum**: triviális monoid (zéró objektum)
- **Tétel**: Mon mint egyobjektumú kategóriák ekvivalenciája; monadikus Set felett (szabad monoid = lista monád)

### 11. Lat — Háló kategóriája (Rácsok)
- **Objektumok**: hálók (lattices)
- **Morfizmusok**: háló homomorfizmusok (megtartják ∨ és ∧)
- **Tulajdonságok**: teljes és ko-teljes, konkret, **nem** abeli, kartéziánusan zárt (ha Heyting háló)
- **Részkategóriák**: BoundedLat (korlátos hálók), DL (distributív hálók), CL (komplementumos hálók)

### 12. Bool — Boole-algebrák kategóriája
- **Objektumok**: Boole-algebrák
- **Morfizmusok**: Boole-homomorfizmusok
- **Tulajdonságok**: teljes és ko-teljes, konkret, **nem** abeli, **nem** kartéziánusan zárt (de a kategória maga monoidális)
- **Tétel**: Stone reprezentációs tétele — Bool duálisan ekvivalens a Stone-terek kategóriájával (Bool^op ≃ StoneSpaces); Boole-algebra = speciális Heyting algebra (klasszikus logika)

### 13. Heyt — Heyting-algebrák kategóriája
- **Objektumok**: Heyting-algebrák (distributív hálók maradékosztással)
- **Morfizmusok**: Heyting-homomorfizmusok
- **Tulajdonságok**: kartéziánusan zárt kategória (belül), teljes és ko-teljes
- **Tétel**: Heyting-algebrák = intuitív logika Lindenbaum-algebrái; minden elemi topos belső Heyting-algebra logikával rendelkezik; Bool ⊂ Heyt (Boole ⊂ Heyting)

### 14. Magma — Magmák kategóriája
- **Objektumok**: magmák (halmaz egy bináris művelettel, sem asszociativitás, sem egység nélkül)
- **Morfizmusok**: magma homomorfizmusok
- **Tulajdonságok**: teljes és ko-teljes, konkret, **nem** abeli, **nem** additív
- **Részkategóriák**: SGrp (félcsoportok), Mon (monoidok), Grp (csoportok) — mindegyik magmák speciális esete

### 15. SGrp — Félcsoportok kategóriája
- **Objektumok**: félcsoportok (asszociatív bináris művelet, egység nélkül)
- **Morfizmusok**: félcsoport homomorfizmusok
- **Tulajdonságok**: teljes és ko-teljes, konkret
- **Részkategória**: Mon (monoidok)

### 16. CRing — Kommutatív gyűrűk kategóriája
- **Objektumok**: kommutatív egységes gyűrűk
- **Morfizmusok**: gyűrű homomorfizmusok
- **Tulajdonságok**: teljes és ko-teljes, konkret, szimmetrikus monoidális (tenzorszorzat), **nem** abeli, **nem** additív
- **Tétel**: Affin sémák kategóriája duálisan ekvivalens CRing^op-tal (Spec funktor); anti-ekvivalencia: CRing^op ≃ AffSch

### 17. k-Alg — k-algebrák kategóriája
- **Objektumok**: k-algebrák (gyűrűk k-algebrai struktúrával)
- **Morfizmusok**: k-algebra homomorfizmusok
- **Tulajdonságok**: teljes és ko-teljes, monoidális (tenzorszorzat k felett), **nem** abeli
- **Részkategóriák**: CommAlg_k, AssAlg_k, LieAlg_k, HopfAlg_k

### 18. LieAlg — Lie-algebrák kategóriája
- **Objektumok**: Lie-algebrák egy test felett
- **Morfizmusok**: Lie-algebra homomorfizmusok (megtartják a Lie-zárójelet)
- **Tulajdonságok**: **nem** abeli (általában), teljes és ko-teljes, monoidális (direkt szorzat, de Lie-zárójelkülönbség), **nem** additív
- **Tétel**: Poincaré–Birkhoff–Witt tétel (univerzális burkoló algebra); Lie-féle harmadik tétel (Lie-algebrák és Lie-csoportok között); univerzális burkoló algebra U(g) — U funktor bal adjungált a felejtős funktorhoz (LieAlg → AssAlg)

### 19. HopfAlg — Hopf-algebrák kategóriája
- **Objektumok**: Hopf-algebrák (bialgebrák antipóddal)
- **Morfizmusok**: Hopf-algebra homomorfizmusok
- **Tulajdonságok**: monoidális, szimmetrikus (ha kommutatív/kokommutatív), **nem** abeli
- **Tétel**: Tannaka-Krein dualitás (kompakt csoportok és Hopf-algebrák között); kvantumcsoportok = deformált Hopf-algebrák (pl. U_q(g))

### 20. Grph — Irányított gráfok kategóriája
- **Objektumok**: gráfok
- **Morfizmusok**: gráf homomorfizmusok (csúcs→csúcs, él→él, szomszédságot megtart)
- **Tulajdonságok**: teljes és ko-teljes, konkret, **nem** abeli, **nem** additív, kartéziánusan zárt (bizonyos meghatározás szerint)
- **Tétel**: egy gráf mint kviver generál egy szabad kategóriát (free category)

---

## II. TOPOLOGIA / GEOMETRIA

### 21. Top — Topológiai terek kategóriája
- **Objektumok**: topológiai terek
- **Morfizmusok**: folytonos leképezések
- **Tulajdonságok**: teljes és ko-teljes, konkret, **nem** kartéziánusan zárt, **nem** abeli, **nem** topos
- **Kezdő objektum**: üres tér; **Végobjektum**: egyetlen pont (pontszerű tér)
- **Epi**: szürjektív folytonos; **Mono**: injektív folytonos (de **nem** minden mono topologikus beágyazás!)
- **Szorzat**: topologikus szorzat; **Koprodukt**: diszjunkt unió
- **Tétel**: Top **nem** konkretizálható hTop-pal (Freyd — a homotópia kategória nem konkret)

### 22. Top* — Pontosított topológiai terek kategóriája
- **Objektumok**: pontosított terek (X, x₀)
- **Morfizmusok**: bázispont-megtartó folytonos leképezések
- **Tulajdonságok**: teljes és ko-teljes, konkret, **nem** kartéziánusan zárt, **nem** abeli
- **Kezdő/végobjektum**: egyetlen pont (zéró objektum)
- **Szorzat**: pontszerű szorzat; **Koprodukt**: ék szorzat (wedge sum)
- **Felfüggesztés**: ΣX = S¹ ∧ X; **Huroktér**: ΩX
- **Tétel**: Σ ⊣ Ω adjungáltság ( [ΣX, Y] ≅ [X, ΩY] ); a felfüggesztés bal adjungált a huroktér funktorhoz

### 23. Man — Differenciálható sokaságok kategóriája
- **Objektumok**: sima sokaságok (C^∞)
- **Morfizmusok**: sima leképezések (p-szeresen differenciálható: Man_p)
- **Tulajdonságok**: **nem** teljes, **nem** ko-teljes (általános kolimit nem létezik!), konkret, kartéziánusan zárt (a locally convex differenciáltopológia egyes verzióiban)
- **Kezdő objektum**: R^0 (egy pont); **Végobjektum**: R^0
- **Szorzat**: direkt szorzat sokaság; **Koprodukt**: diszjunkt unió
- **Tétel**: Frobenius tétel, de Rham kohomológia funktor Man → DGA; nem léteznek általános ekvalizérok (pl. egyenletek megoldáshalmaza lehet nem-simas)

### 24. Man^∞ (Diff) — Végtelen-differenciálható sokaságok (Fréchet/Frolicher)
- **Objektumok**: Frölicher-sokaságok vagy kényelmes sokaságok
- **Morfizmusok**: sima leképezések
- **Tulajdonságok**: teljes és ko-teljes, kartéziánusan zárt (Frölicher-sokaságok esetén!)
- **Tétel**: kartéziánusan zárt a sokaságok kategóriája Frölicher-féle meghatározásban

### 25. Met — Metrikus terek kategóriája
- **Objektumok**: metrikus terek (X, d)
- **Morfizmusok**: rövid leképezések (short maps: kontraktív, d(f(x),f(y)) ≤ d(x,y))
- **Tulajdonságok**: teljes és ko-teljes, konkret, **nem** kartéziánusan zárt, **nem** abeli
- **Szorzat**: l∞-szorzat; **Koprodukt**: diszjunkt unió
- **Tétel**: Banach-féle fixpont tétel (a kategorikus adjungált interpretációban)

### 26. Meas — Mértékterek kategóriája
- **Objektumok**: mérhető terek (X, Σ)
- **Morfizmusok**: mérhető függvények
- **Tulajdonságok**: teljes és ko-teljes, konkret, **nem** abeli
- **Szorzat**: szorzat σ-algebra; **Koprodukt**: diszjunkt unió

### 27. Stoch — Markov-kernel kategória
- **Objektumok**: mérhető terek
- **Morfizmusok**: Markov-kernel (sztochasztikus leképezések)
- **Tulajdonságok**: **nem** konkret (a morfizmusok nem függvények!), monoidális (szorzat), **nem** abeli, **nem** kartéziánus
- **Tétel**: a kategória Kleisli-kategóriája a Giry-monádnak a Meas kategóriában; valószínűségi programozás szempontjából fontos

### 28. Sch — Sémák kategóriája
- **Objektumok**: sémák
- **Morfizmusok**: séma-morfizmusok
- **Tulajdonságok**: teljes és ko-teljes (sémák lokálisan gyűrűs terek), **nem** abeli, **nem** kartéziánus
- **Szorzat**: fiber szorzat (pullback); **Koprodukt**: diszjunkt unió
- **Tétel**: Affin sémák anti-ekvivalensek CRing^op-tal: AffSch ≃ CRing^op (Spec funktor); Grothendieck topológia és étale/fppf/Nisnevich helyeken nyalábok

### 29. AffSch — Affin sémák kategóriája
- **Objektumok**: affin sémák (Spec R)
- **Morfizmusok**: sémák morfizmusai
- **Tulajdonságok**: teljes és ko-teljes, **anti-ekvivalens** CRing^op-tal
- **Tétel**: Spec: CRing^op → AffSch anti-ekvivalencia; a globális szekciók funktor Γ: AffSch → CRing^op a bal adjungált

### 30. StoneSpaces — Stone-terek kategóriája (totálisan kompakt, összefüggés nélküli Hausdorff)
- **Objektumok**: Stone-terek (0-dimenziós kompakt Hausdorff terek)
- **Morfizmusok**: folytonos leképezések
- **Tulajdonságok**: teljes és ko-teljes, **nem** abeli, **nem** kartéziánus
- **Tétel**: Stone dualitás — StoneSpaces ≃ Bool^op (Boole-algebrák kategóriájának duálisa); Stone-reprezentációs tétel

### 31. Frm — Keretek kategóriája (Frames)
- **Objektumok**: keretek (komplett hálók ahol véges infimum disztributív tetszőleges szuprimummal)
- **Morfizmusok**: keret homomorfizmusok (megtartják ∨, ∧)
- **Tulajdonságok**: teljes és ko-teljes, **nem** abeli
- **Tétel**: Ponpointless topológia — keretek duálisan ekvivalensek locale-kkal (Loc = Frm^op); Spektrális terek és specktrális keretek közötti dualitás

### 32. Loc — Locale-k kategóriája
- **Objektumok**: locale-ok (= keretek duálisan, azaz keret kategória morfizmusai megfordítva)
- **Morfizmusok**: locale morfizmusok (= keret homomorfizmusok ellentett irányban)
- **Tulajdonságok**: teljes és ko-teljes, **nem** abeli
- **Tétel**: Loc ≃ Frm^op; "ponpointless topology"; minden topologikus tér megfelel egy locale-nak (de nem injektív)

### 33. Ho(Top) — Homotópia kategória
- **Objektumok**: topologikus terek
- **Morfizmusok**: homotópia osztályok [X, Y] (naiv) vagy gyenge homotópia ekvivalencia szerint lokalizált (Quillen)
- **Tulajdonságok**: **nem** teljes, **nem** ko-teljes, **nem** konkret (Freyd), **nem** abeli
- **Tétel**: Whitehead tétele (gyenge homotópia ekvivalencia = homotópia ekvivalencia CW-komplexekre); Ho(Top) ekvivalens a CW-komplexek naiv homotópia kategóriájával; Eilenberg-MacLane terek K(A,n) reprezentálják a kohomológiát H^n(-, A)

### 34. sSet — Szimpliciális halmazok kategóriája
- **Objektumok**: szimpliciális halmazok (funktorok Δ^op → Set)
- **Morfizmusok**: természetes transzformációk
- **Tulajdonságok**: teljes és ko-teljes, kartéziánusan zárt, **toos** (elemi topos), monoidális (Kan-féle szorzat)
- **Tétel**: Homotópia hipotézis (Grothendieck): Ho(sSet) ≃ Ho(Top) (a szimpliciális halmazok a "kombinatorikus" topológia); Quillen modellkategória; Kan-komplexek = ∞-groupoidok

### 35. Ch(R) / Kom(R) — Lánckomplexusok kategóriája R-modulok felett
- **Objektumok**: (ko)lánckomplexusok R-modulokban: ... → X^{-1} → X^0 → X^1 → ...
- **Morfizmusok**: lánctérképek (kommutáló diferenciállal)
- **Tulajdonságok**: **abeli** (ha R-Mod abeli), teljes és ko-teljes, preadditív, additív, monoidális (tenzorszorzat komplexusok), zárt monoidális (belső Hom komplexus)
- **Tétel**: Kígyó lemma, a homológia funktor H^n: Ch(R) → R-Mod; kvázi-izomorfizmusok lokalizálva → D(R) derivált kategória

### 36. K(R) — Homotópia kategória lánckomplexusok felett
- **Objektumok**: lánckomplexusok R-modulok felett
- **Morfizmusok**: lánchomotópia ekvivalencia osztályok
- **Tulajdonságok**: **triangulált** kategória, additív, **nem** abeli, **nem** teljes/ko-teljes
- **Tétel**: K(R) egy Verdier-triangulált kategória; a kvázi-izomorfizmusok multipikatív rendszert alkotnak

### 37. D(R) — Derivált kategória R felett
- **Objektumok**: lánckomplexusok R-modulokban (kvázi-izomorfizmusok szerint lokalizálva)
- **Morfizmusok**: "tetők" (roofs) — (s, f) ahol s kvázi-izomorfizmus, f lánctérkép
- **Tulajdonságok**: **triangulált** kategória, additív, **nem** abeli (általában), **nem** teljes/ko-teljes (általában)
- **Részkategóriák**: D^+(R) (alulról korlátos), D^-(R) (felülről korlátos), D^b(R) (korlátos)
- **Tétel**: Hom_{D(R)}(X, Y[j]) = Ext^j_R(X, Y); Verdier lokalizáció; Riemann-Hilbert korrespondencia (D-modulok); spektrális sorozatok; a homológiai algebra keretrendszere

### 38. Spec — Spektrumok kategóriája (stabil homotópia)
- **Objektumok**: spektrumok (szekvenciális vagy szimmetrikus)
- **Morfizmusok**: spektrum-térképek
- **Tulajdonságok**: stabil modellkategória, **nem** abeli, triangulált a homotópia kategóriában, szimmetrikus monoidális (smash product)
- **Tétel**: Stabil homotópia kategória = Ho(Spec); Brown reprezentábilitási tétele (minden általános kohomológiai elmélet spektrum által reprezentálva); Spanier-Whitehead dualitás

### 39. SmCat — Sima sémák kategóriája / Stacks
- **Objektumok**: sima sémák (vagy algebrai stack-ek, Deligne-Mumford stack-ek)
- **Morfizmusok**: sima morfizmusok (étale, fppf, stb.)
- **Tulajdonságok**: 2-kategória (stack-ek esetén), fibrált kategóriák Grothendieck topológián
- **Tétel**: Artin reprezentábilitási tétel; étale kohomológia és Galois reprezentációk; anabeli geometria

---

## III. LOGIKA / SZÁMÍTÁSTUDOMÁNY

### 40. Cat — Kis kategóriák kategóriája
- **Objektumok**: kis kategóriák
- **Morfizmusok**: funktorok
- **Tulajdonságok**: teljes és ko-teljes (kis kategóriákra korlátozva), **2-kategória** (morfizmusok = funktorok, 2-morfizmusok = természetes transzformációk), kartéziánusan zárt (a belső Hom = funktor kategória), monoidális (direkt szorzat)
- **Kezdő objektum**: üres kategória; **Végobjektum**: terminális kategória (egy objektum, egy morfizmus)
- **Tétel**: Yoneda lemma — minden lokálisan kis C-re, C → [C^op, Set] (Yoneda beágyazás, teljes és hű); Cat maga egy (szigorú) 2-kategória; a Cat-beli ekvivalencia = ekvivalencia a funktorok teljes+hű+esszenciálisan szürjektív

### 41. CAT — Nagy kategóriák "kategóriája" (ha létezik — megfelelő alapozás kell)
- **Objektumok**: lokálisan kis kategóriák
- **Morfizmusok**: funktorok
- **Tulajdonságok**: **nem** lokálisan kis (alapozási kérdések); 2-kategória; **nem** teljes szigorú értelemben (univerzum kérdések)
- **Tétel**: Yoneda minden lokálisan kis kategóriára; CAT a Cat kibővítése nagy kategóriákra; alapozás: Grothendieck univerzum vagy NBG

### 42. Fun(C, D) = [C, D] — Funktor kategória
- **Objektumok**: funktorok C → D
- **Morfizmusok**: természetes transzformációk
- **Tulajdonságok**: ha D teljes → Fun(C,D) teljes; ha D ko-teljes → Fun(C,D) ko-teljes; ha D abeli → Fun(C,D) abeli; ha D kartéziánusan zárt és C kis → Fun(C,D) kartéziánusan zárt
- **Tétel**: a funktor kategória mindig létezik C kis esetén; a kiértékelési funktor ev: C × [C, D] → D; Kan-kiterjesztések ebben a keretben; limit/colimit pontonként számítható

### 43. Set^C^op = PSh(C) — Pre-nyalábok kategóriája C-n
- **Objektumok**: kontravariáns funktorok C → Set (pre-nyalábok)
- **Morfizmusok**: természetes transzformációk
- **Tulajdonságok**: **Grothendieck topos** (mindig!), teljes és ko-teljes, kartéziánusan zárt, elemi topos, lokálisan kis, résztárgy-osztályozó = Yoneda beágyazás által
- **Tétel**: **Yoneda lemma**: Hom_{PSh(C)}(y(c), F) ≅ F(c), ahol y: C → PSh(C) a Yoneda beágyazás; minden Grothendieck topos egy ilyen PSh(C) sheafifikált részkategóriája; presheaf = szabad kolimit-bővítés

### 44. Sh(X) = Sh(C, J) — Nyalábok kategóriája (Grothendieck topos)
- **Objektumok**: nyalábok egy Grothendieck topológián (site-on) (C, J)
- **Morfizmusok**: nyaláb-morfizmusok (természetes transzformációk, ragasztási axiómát kielégítő)
- **Tulajdonságok**: **Grothendieck topos**, teljes és ko-teljes, kartéziánusan zárt, **elemi topos** (résztárgy-osztályozóval), lokálisan kis
- **Tétel**: Giraud tétele (ekvivalens karakterizációk: nyalábok egy helyen, kis kolimit + disjoint sums + effektív ekvivalencia relációk); sheafifikáció funktor a: PSh(C) → Sh(C, J) bal adjungált az inclúzióhoz; kohomológia és de Rham

### 45. Topos (elemi / Grothendieck)
- **Objektumok**: "kategória, ami úgy viselkedik, mint a Set"
- **Morfizmusok**: funktorok (geometriai morfizmusok topoi-k között: adjungált pár (f^*, f_*), ahol f^* véges limiteket megtart)
- **Tulajdonságok**: kartéziánusan zárt, elemi topos (résztárgy-osztályozóval), teljes (Grothendieck esetén), lokálisan kis
- **Példák**: Set, Sh(X), PSh(C), G-Set (csoport hatásai), effektív epimorfizmus-topoi
- **Tétel**: Giraud axiómák; geometriai morfizmusok; pont-topos = Set; minden elemi topos belső logikája intuitionistic; Lawvere-Tierney topológiák; a Boole topoi = klasszikus logika

### 46. Klini-kategória (Kleisli) — Kleisli(C, T)
- **Objektumok**: mint C-ben
- **Morfizmusok**: Kleisli-morfizmusok: A → T(B) (ahol T monád C-n)
- **Tulajdonságok**: a monád algebrai struktúráját kódolja; **nem** teljes általában; ekvivalens a szabad T-algebra kategóriával
- **Tétel**: Kleisli(C,T) és Eilenberg-Moore(C,T) közrefogják C-t; a Kleisli a "szabad" algebrák, az Eilenberg-Moore az "összes" algebrák; példa: Set + List monad → nem-determinisztikus funktor

### 47. Eilenberg-Moore(C, T) — Eilenberg-Moore kategória
- **Objektumok**: T-algebrák (X, h: T(X) → X) monád T felett
- **Morfizmusok**: algebra homomorfizmusok
- **Tulajdonságok**: teljes és ko-teljes ha C az; **nem** abeli általában; a felejtős funktor U: EM(C,T) → C monadikus
- **Tétel**: Beck monadikusitási tétele (feltételek arra, hogy U: D → C monadikus legyen); monadikus adjungáltság (minden adjungáltság monádot generál, és a kompozíció Eilenberg-Moore)

### 48. Rel — Relációk kategóriája
- **Objektumok**: halmazok
- **Morfizmusok**: bináris relációk R ⊆ A × B (kompozíció: reláció kompozíció)
- **Tulajdonságok**: **nem** konkret (morfizmusok nem függvények!), kartéziánus (^op ekvivalens önmagával), allegory (Freyd), **nem** abeli, **nem** teljes a szokásos módon
- **Tétel**: Rel = Set allegory; allegóriák = "kategóriák relációkkal" (Freyd-Scedrov); a kategóriák és relációk közötti alapozás

### 49. Span(C) — Spán-ok kategóriája
- **Objektumok**: mint C-ben
- **Morfizmusok**: spánok A ← X → B (kompozíció: pullback)
- **Tulajdonságok**: bikategória (2-kategória gyengén); ha C ko-teljes pullback-kel → bikategória; szimmetrikus monoidális (ha C ko-teljes)
- **Tétel**: bicategorical pullback; a Span(Top) a korrespondencia-topológia; Span(C) és Cospan(C) adjungáltak

### 50. Cospan(C) — Koszpánok kategóriája
- **Objektumok**: mint C-ben
- **Morfizmusok**: koszpánok A → X ← B (kompozíció: pushout)
- **Tulajdonságok**: bikategória; ha C teljes pushout-tal → bikategória; szimmetrikus monoidális (ha C teljes)
- **Tétel**: Cospan(C) = Span(C^op)^op; a reaktív rendszer-elmélet (process algebra) alapja; dekorated cospan-ok (Fong-Spivak-Tuyéras)

### 51. C/A — Szelet kategória (slice, overcategory)
- **Objektumok**: nyilak X → A C-ben ("objektumok A felett")
- **Morfizmusok**: kommutáló háromszögek X → Y, X → A, Y → A
- **Tulajdonságok**: ha C teljes → C/A teljes; ha C ko-teljes és A kis → C/A ko-teljes; ha C kartéziánusan zárt → C/A is; ha C topos → C/A topos
- **Tétel**: a forgetful functor C/A → C kreálja a limiteket; lokalizáció, fölé-hely; a fundamentál csoportoid szelet; C/A szimmetrikus monoidális ha C az

### 52. A/C — Koszelet kategória (coslice, undercategory)
- **Objektumok**: nyilak A → X C-ben
- **Morfizmusok**: kommutáló háromszögek
- **Tulajdonságok**: ha C ko-teljes → A/C ko-teljes; duális a szelet kategóriának
- **Tétel**: A/C = (C^op/A)^op; koszelet objektumok mint "pointed objects"; a ko-homotópia kategória szelet/ko-szelet módon

### 53. (F ↓ G) — Comma kategória (F, G funktorok)
- **Objektumok**: (x, y, α: F(x) → G(y)) ahol x ∈ dom(F), y ∈ dom(G)
- **Morfizmusok**: (f, g) kommutáló: G(g) ∘ α = β ∘ F(f)
- **Tulajdonságok**: általánosítja a slice/coslice-t; ha F = id_C, G = id_C: comma kategória = nyíl kategória
- **Tétel**: a comma kategória univerzális konstrukció; szabad adjungáltság; Kan-kiterjesztések comma kategóriákon

### 54. C^op — Ellentétes kategória (opposite)
- **Objektumok**: mint C-ben
- **Morfizmusok**: C^op(A,B) = C(B,A) (megfordított irány)
- **Tulajdonságok**: (C^op)^op = C; ha C teljes → C^op ko-teljes és fordítva; ha C abeli → C^op abeli; ha C topos → C^op **nem** topos (általában)
- **Tétel**: a duálitás elve — minden állítás C-re vonatkozóan egy duális állítás C^op-ra; Galois-kapcsolatok = adjungáltságok Pos-ban és Pos^op-ban

### 55. C × D — Termékkategória
- **Objektumok**: párok (c, d), c ∈ C, d ∈ D
- **Morfizmusok**: párok (f, g) komponensenként komponálva
- **Tulajdonságok**: ha C, D teljes → C×D teljes; ha C, D abeli → C×D abeli; monoidális (ha C, D monoidális és a megfelelő kompatibilitás)
- **Tétel**: a projekció funktorok; a termékkategória az egyidejű vizualizáció eszköze

### 56. Quotient category — Hányados kategória
- **Objektumok**: mint C-ben
- **Morfizmusok**: C morfizmusok modulo egy kongruencia reláció
- **Tulajdonságok**: lokalizáció speciális esete; az univerzális tulajdonság szerint: funktor C → C/∼ amely minden ekvivalens morfizmust azonosít
- **Tétel**: Serre hányados kategória abeli kategóriákban (Serre részkategória); a Gabriel-Zisman lokalizáció általánosítja

### 57. Localization C[S^{-1}] — Lokalizáció
- **Objektumok**: mint C-ben
- **Morfizmusok**: C morfizmusok + formálisan hozzáadott inverzek S-beli morfizmusokhoz
- **Tulajdonságok**: univerzális tulajdonság: minden funktor C → D amely S-t izomorfizmusokra visz, egyedi módon faktorál C[S^{-1}] → D; Gabriel-Zisman tető reprezentáció; ha S multiplikatív rendszer → szimplex morfizmusok (roofs)
- **Tétel**: Verdier lokalizáció triangulált kategóriákban (K(A) → D(A)); a derivált kategória lokalizáció a kvázi-izomorfizmusoknál

### 58. Free category — Szabad kategória (kviver/gráf alapján)
- **Objektumok**: a gráf csúcsai
- **Morfizmusok**: utak a gráfban (kompozíció = konkatenáció)
- **Tulajdonságok**: univerzális tulajdonság: minden funktor a gráf (kviver) kategóriából C-be egyedi módon kiterjed a szabad kategóriából C-be
- **Tétel**: szabad-konstruktív: Free(Graph) = path category; szabad monoid kategória = egy objektumú szabad kategória; a szabad kategória bal adjungált a forgetful funktorhoz Cat → Quiver

### 59. MonCat — Monoidális kategóriák kategóriája
- **Objektumok**: monoidális kategóriák (C, ⊗, I, associator, unitor)
- **Morfizmusok**: monoidális funktorok (megtartják a tenzorszorzatot és egységet)
- **Tulajdonságok**: **3-kategória** (morfizmusok = monoidális funktorok, 2-morfizmusok = monoidális természetes transzformációk, 3-morfizmusok = módosítások)
- **Tétel**: Mac Lane koherencia-tétele (minden monoidális kategória ekvivalens egy szigorú monoidális kategóriával); a szimmetrikus monoidális struktúrák szorzata

### 60. 2-Cat — 2-kategóriák kategóriája (szigorú)
- **Objektumok**: (szigorú) 2-kategóriák
- **Morfizmusok**: 2-funktorok
- **Tulajdonságok**: maga egy 2-kategória (vagy 3-kategória); teljes és ko-teljes (szigorú esetben)
- **Tétel**: Cat mint 2-kategória; a 2-kategória-elmélet a "kategória + természetes transzformációk" formalizmusa; lax/oplax funktorok

### 61. Bicat — Bicategory-k kategóriája (gyenge 2-kategória)
- **Objektumok**: bikategóriák (gyenge 2-kategória, asszociativitás és egység legfeljebb izomorfizmusig)
- **Morfizmusok**: szigorú/pseudo/lax/oplax funktorok
- **Tulajdonságok**: 3-kategória; **nem** ekvivalens a szigorú 2-kategóriákkal minden esetben (de minden bikategória szigorúan ekvivalens egy 2-kategóriával a coherence theorem szerint)
- **Tétel**: Mac Lane-Pare koherencia bicategóriákra; Span(C) bicategory; profunctorok (Dist) bikategória

### 62. ∞-Cat / ∞-groupoid — Magasabb kategóriák
- **Objektumok**: (∞, n)-kategóriák vagy ∞-groupoidok
- **Morfizmusok**: magasabb morfizmusok (a megfelelő szinteken)
- **Tulajdonságok**: ∞-kategória = gyenge magasabb kategória; ∞-groupoid = Kan komplex (sSet); **∞-topos** = ∞-kategória ami ∞-groupoid-dal értékelődik
- **Tétel**: Homotópia hipotézis (Grothendieck): ∞-groupoidok ekvivalensek a topologikus terek homotópia típusaival; Joyal-Lurie modellkategória keret; (∞, 1)-kategória = quasi-category

### 63. Simplicial category (Δ) — Simplex kategória
- **Objektumok**: standard szimplexek [n] = {0, 1, ..., n} (n ≥ 0)
- **Morfizmusok**: nem-csökkenő függvények [m] → [n]
- **Tulajdonságok**: kis kategória; skeletálisan generálja a szimpliciális objektumokat; **nem** teljes, **nem** abeli; szigorú monoidális (ordinális összeg)
- **Tétel**: minden szimpliciális objektum = funktor Δ^op → C; a simplex kategória a geometriai realizáció alapja; Cisinski modellkategória

### 64. Ord — Részben rendezett halmazok kategóriája (preordered sets)
- **Objektumok**: preordered sets (P, ≤)
- **Morfizmusok**: monoton növekvő függvények (order-preserving)
- **Tulajdonságok**: teljes és ko-teljes, konkret, kartéziánusan zárt (a belső Hom = rendezett halmaz a pont-féle rendezéssel), **nem** abeli; monoidális (direkt szorzat)
- **Kezdő objektum**: üres preordering; **Végobjektum**: egyetlen elemű preordering
- **Tétel**: Ord mint véges-korlátos preorders = "truth values" egy topos-ban; Galois-kapcsolatok = adjungált funktorok Ord-ben és Ord^op-ben

### 65. Poset — Részben rendezett halmazok (antiszimmetrikus)
- **Objektumok**: részben rendezett halmazok (P, ≤) antiszimmetrikus
- **Morfizmusok**: monoton függvények
- **Tulajdonságok**: teljes és ko-teljes, konkret, kartéziánusan zárt
- **Részkategória**: teljes hálók (CL), distributív hálók (DL), Boole-algebrák (Bool)
- **Tétel**: minden poset egy vékony (thin) kategória (legfeljebb egy morfizmus objektumok között); Haase-diagram kategorikus megfelelője

### 66. Cat_thin — Vékony kategóriák (preorder = vékony kategória)
- **Objektumok**: a preorder elemei
- **Morfizmusok**: x → y ha x ≤ y (legfeljebb egy morfizmus)
- **Tulajdonságok**: antiszimmetrikus → poset; szimmetrikus → ekvivalencia reláció = groupoid egy objektumon
- **Tétel**: preorder = (kis) kategória legfeljebb egy morfizmussal minden pár között; vékony kategória = poset

### 67. G-Set — G-halmazok kategóriája (csoport hatásai)
- **Objektumok**: bal G-halmazok (halmazok G-balhatással)
- **Morfizmusok**: G-equivariant függvények (hatás-megtartó)
- **Tulajdonságok**: **Grothendieck topos** (ekvivalens a BG topos-szal, ahol BG egy egyobjektumú csoport-kategória); teljes és ko-teljes, kartéziánusan zárt, elemi topos
- **Tétel**: G-Set ≃ Sh(BG) (nyalábok a "csoport helyen"); Burnside-tétel; a G-halmazok kohomológiája = csoport kohomológia

### 68. Rep(G) — G-reprezentációk kategóriája (kész)
- **Objektumok**: G reprezentációk (mint a Rep_K(G) fent)
- **Morfizmusok**: G-equivariant lineáris leképezések
- **Tulajdonságok**: ekvivalens K[G]-Mod-dal; **abeli**; monoidális (ha G kommutatív vagy koalgebra)
- **Tétel**: Tannaka dualitás: a kommutatív Hopf-monoid rekonstrukció a monoidális kategóriából; a neutrally charged monoidal functor rekonstrukció

### 69. Adj — Adjungáltságok kategóriája (2-kategorikus)
- **Objektumok**: kategóriák
- **Morfizmusok**: adjungált funktor pár (F, G, η, ε)
- **Tulajdonságok**: 2-kategória (Cat-ben); az adjungáltság természetes transzformációk szerint 2-morfizmus
- **Tétel**: az adjungáltság egyenértékű: (i) hom-set izomorfizmus Hom_D(FX,Y) ≅ Hom_C(X,GY), (ii) unit/counit (η, ε) kielégíti a trianguláris identitásokat, (iii) F bal adjungált = bal Kan kiterjesztés az Yoneda szerint; minden monád adjungáltságból származik

### 70. AlgT — Egyszerű típusok / Egyszerű típuselmélet kategóriája
- **Objektumok**: egyszerű típuselmélet típusai és kifejezései
- **Morfizmusok**: típus-megtartó leképezések
- **Tulajdonságok**: kartéziánusan zárt kategória (CCC) = a lambda-kalkulus modellje
- **Tétel**: Curry-Howard izomorfizmus: egyszerű típusos lambda-kalkulus ↔ intuitionistic propositional logic; a CCC = a típuselmélet kategória-modellje

### 71. CCC — Kartéziánusan zárt kategóriák (általános)
- **Objektumok**: kategóriák végobjektummal, szorzattal, exponenciális objektumokkal
- **Morfizmusok**: struktúra-megtartó funktorok
- **Tulajdonságok**: a CCC a egyszerű típusos lambda-kalkulus modellje; **kartéziánusan zárt**
- **Tétel**: Lawvere-féle korrespondencia: CCC ↔ egyszerű típuselmélet; a belső Hom = exponenciális objektum B^A

### 72. Pred — Predikátumok kategóriája / Effektus kategóriák
- **Objektumok**: "igazságértékek objektumai" (a topos-ban Ω)
- **Morfizmusok**: predikátum transzformációk
- **Tulajdonságok**: Heyting algebra objektum a topos-ban; belső logika
- **Tétel**: Lawvere-Tierney topológia = monoidális zárt operátor Ω-on; a topos-ban az "igazság" objektum Ω = résztárgy-osztályozó; az intuitionistic logika belső

### 73. Eff — Effektus kategóriák (Effectus theory)
- **Objektumok**: "kvantum" és "klasszikus" együttes (Klini kategória a valószínűségi monádon)
- **Morfizmusok**: effektus-térképek (többértékű, összeg-objektumokkal)
- **Tulajdonságok**: **nem** teljes, **nem** ko-teljes, "partial" sum, **nem** kartéziánus
- **Tétel**: Jacobs effektus-elmélet; kombinálja a valószínűségszámítást, kvantumot és nem-determinizmust; Kleisli kategória a valószínűségi monádon = effektus kategória

### 74. Qubits / Hilb_fd — Véges dimenziós Hilbert-terek kategóriája
- **Objektumok**: véges dimenziós komplex Hilbert-terek
- **Morfizmusok**: lineáris leképezések (általában adjungált-tal rendelkezők = †-kategória)
- **Tulajdonságok**: †-szimmetrikus monoidális (kompakt zárt kategória); **nem** abeli (általában); **nem** komplett topológiailag; (fd) kompakt zárt
- **Tétel**: kvantum-információ kategorikus alapozása (Abramsky-Coecke); a †-kompakt szerkezet kódolja a kvantum protokollokat; a kvantum-hibajavító kód = alter objektum a Hilbert-térben; teleportáció = †-kompakt kategória morfizmus

### 75. Hilb — Hilbert-terek kategóriája (végtelen dimenzió is)
- **Objektumok**: komplex Hilbert-terek (minden dimenzió)
- **Morfizmusok**: korlátos lineáris operátorok
- **Tulajdonságok**: †-kategória, szimmetrikus monoidális, **nem** kompakt zárt (végtelen dimenzió miatt)
- **Tétel**: Gelfand-Naimark-Segal; a †-struktúra adjungált operátorok; kvantum mechanika kategorikus kerete (Baez-Stay)

### 76. Quantale — Kvantál kategóriája
- **Objektumok**: kvantálok (monoidális zárt, teljes sup-semilattice)
- **Morfizmusok**: kvantál homomorfizmusok
- **Tulajdonságok**: **nem** abeli; szimmetrikus monoidális zárt; teljes
- **Tétel**: a kvantál = "lineáris logika" modell (Girard); *-autonóm kategóriák = lineáris logika modell; a "linear" viselkedés

### 77. Chu(C) — Chu-konstrukció
- **Objektumok**: (A, X, r: A ⊗ X → I) hármasok (objektum + duális + párosítás)
- **Morfizmusok**: kompatibilis párok
- **Tulajdonságok**: *-autonóm; szimmetrikus monoidális; lineáris logika modell
- **Tétel**: Barr *-autonóm kategóriák; a Chu-konstrukció minden szimmetrikus monoidális zárt C-re *-autonóm kategóriát ad; lineáris logika

### 78. Topos_C — Egy topos-ban lévő objektumok (internal)
- **Objektumok**: egy fix topos E-beli objektumok
- **Morfizmusok**: E-beli morfizmusok
- **Tulajdonságok**: maga a topos; belső kategória-elmélet (E-kategóriák)
- **Tétel**: a topos "belső nyelv" = intuitionistic set theory; belső funktorok, nyalábok, stb.; a "matematika topos-on belül"

---

## IV. KATEGÓRIA-KONSTRUKCIÓK ÉS SPECIÁLIS KATEGÓRIÁK

### 79. Discrete category — Diszkrét kategória
- **Objektumok**: egy I halmaz elemei
- **Morfizmusok**: csak identitás morfizmusok
- **Tulajdonságok**: ekvivalens egy halmazzal (Set részkategóriájaként felfogva); minden diszkrét kategória kis ha I halmaz
- **Tétel**: a diszkrét kategória egy halmaz kategorikus megfelelője; egy halmaz = 0-kategória

### 80. Monoid mint kategória — Egy objektumú kategória
- **Objektumok**: egyetlen objektum *
- **Morfizmusok**: a monoid elemei (kompozíció = monoid szorzás)
- **Tulajdonságok**: kis kategória; ha a monoid csoport → groupoid egy objektumon
- **Tétel**: Monoidok ekvivalensek az egy objektumú kategóriákkal (mint 1-kategóriák); a funktor = monoid homomorfizmus

### 81. Groupoid — Groupoid (minden morfizmus izomorfizmus)
- **Objektumok**: tetszőleges objektumok
- **Morfizmusok**: minden morfizmus invertálható
- **Tulajdonságok**: **nem** teljes, **nem** ko-teljes (általában), **nem** abeli (általában); kategória ahol minden morfizmus iso
- **Tétel**: a fundamentál groupoid Π₁(X) egy topologikus tér X-nek; a groupoid mint "csoport sok objektumon"; Lie-groupoid és Lie-algebroid kapcsolat; a Haefliger groupoid

### 82. n-Groupoid / ∞-groupoid — Magasabb groupoidok
- **Objektumok**: magasabb groupoidok (∞-kategória ahol minden n-morfizmus invertálható)
- **Morfizmusok**: minden szinten invertálható
- **Tulajdonságok**: Kan komplex (sSet-ben); homotópia típus (Grothendieck hipotézis)
- **Tétel**: homotópia hipotézis: ∞-groupoidok ≃ homotópia típusok (CW-komplexek); Grothendieck-Gal kapcsolat (fundamentál groupoid)

### 83. Model category — Modell kategóriák (Quillen)
- **Objektumok**: egy kategória C objektumai
- **Morfizmusok**: C morfizmusok három megkülönböztetett osztállyal: fibrációk, ko-fibrációk, gyenge ekvivalenciák
- **Tulajdonságok**: axiómák (2/3, retorsion, faktorizáció); a gyenge ekvivalenciák szerinti lokalizáció = homotópia kategória Ho(C)
- **Tétel**: Quillen ekvivalencia (szigorúbb mint a kategória ekvivalencia); kis objektum argumentum; cofibrantly generated model structure

### 84. Triangulated category — Triangulált kategória
- **Objektumok**: egy additív kategória objektumai
- **Morfizmusok**: additív kategória morfizmusok + megkülönböztetett háromszögek (distinguished triangles)
- **Tulajdonságok**: **nem** abeli (általában); additív; shift funktor [1]; a triangulált struktúra formalizálja a "számszerű" homológiai viselkedést
- **Tétel**: Verdier lokalizáció; D(A) derivált kategória = triangulált; a homotópia kategória K(A) = triangulált; stabil homotópia kategória = triangulált; octahedral axiom

### 85. Stable ∞-category — Stabil ∞-kategória
- **Objektumok**: "spektrum-szerű" ∞-kategória objektumok
- **Morfizmusok**: stabil ∞-kategória morfizmusok
- **Tulajdonságok**: a stabil ∞-kategória = ∞-kategória ahol a felfüggesztés invertálható; triangulált a ho-kategóriában; szimmetrikus monoidális (általában)
- **Tétel**: Lurie: stabil ∞-kategóriák = spektrum-kategóriák (Sp); a derivált ∞-kategória D(A) stabil; a stabil ∞-kategóriák a magasabb algebra alapjai

### 86. (∞, 1)-category / quasi-category
- **Objektumok**: (∞, 1)-kategória objektumok (Kan-komplex dúsítva)
- **Morfizmusok**: magasabb morfizmusok, de csak az 1-morfizmusok szintjén izomorfizmusig
- **Tulajdonságok**: gyenge ∞-kategória; Boardman-Vogt; Joyal modellkategória sSet-en; ∞-topos = ∞-(∞, 1)-kategória ami ∞-groupoidokkal értékelődik
- **Tétel**: Joyal-Lurie; a (∞, 1)-kategória = quasi-category; a magasabb kategória-elmélet kerete; Lurie "Higher Topos Theory"

### 87. Enriched category V-Cat — Dúsított kategóriák
- **Objektumok**: objektumok egy monoidális kategória V feletti dúsítással (hom = V objektum)
- **Morfizmusok**: V-morfizmusok (a hom-okban)
- **Tulajdonságok**: ha V szimmetrikus monoidális zárt → V-Cat monoidális és kartéziánusan zárt (általában)
- **Tétel**: V = Set → Cat (szokásos kategóriák); V = Ab → preadditív kategóriák; V = Cat → 2-kategóriák; V = sSet → szimpliciálisan dúsított (∞, 1)-kategóriák; V = Met → metrikusan dúsított kategóriák

### 88. Internal category Cat(C) — Belső kategóriák
- **Objektumok**: objektum-pár (C_0, C_1) egy C kategóriában forrás/cél/kompozíció struktúrával
- **Morfizmusok**: belső funktorok
- **Tulajdonságok**: ha C pullback-kel teljes → Cat(C) 2-kategória; ha C teljes és ko-teljes → Cat(C) teljes
- **Tétel**: Cat(Top) = topologikus kategóriák; Cat(Sch) = sémák feletti csoportoid (stack-ek alapja); Lie groupoidok = Cat(Man)

### 89. Prof(C, D) = Dist(C, D) — Profunktorok kategóriája
- **Objektumok**: kategóriák
- **Morfizmusok**: profunktorok (distrubutors) = funktorok D^op × C → Set (vagy V-be)
- **Tulajdonságok**: bikategória; Prof(C, D) = [D^op × C, Set]; **nem** 1-kategória a szokásos módon; a Prof bikategória
- **Tétel**: profunktorok mint "generalizált funktorok"; a collimit-weighted konstrukció; a coend és end kalkulus; Yoneda profunktor; egy funktor indukál profunktor (Yoneda beágyazás profunktor-éa)

### 90. Spec (Spektrum) — Spektrum kategória (stabil homotópia)
- **Objektumok**: spektrumok (szekvenciális, szimmetrikus, orthogonális, stb.)
- **Morfizmusok**: spektrum-térképek
- **Tulajdonságok**: stabil modellkategória; szimmetrikus monoidális (smash product); a homotópia kategória = stabil homotópia kategória
- **Tétel**: Brown reprezentábilitás (minden általános kohomológia spektrum); Adams sorsorozat; stab. homotópia kategória = triangulált; a spectra = "stabil terek"

### 91. Spec(R) — R spektrum (gyűrű spektrum)
- **Objektumok**: R modulusok spektrumok (kommutatív R gyűrű felett), azaz prím ideálok
- **Morfizmusok**: R-algebra struktúra (lokalizáció, kontrakció)
- **Tulajdonságok**: affin séma; zariski topológia; **nem** teljes kategória (általában)
- **Tétel**: Spec: CRing^op → AffSch anti-ekvivalencia; az affin spektrum a kommutatív algebra geometriai megfelelője; Hilbert Nullstellensatz specifikus eset

### 92. DGA(R) — Differenciális gradált algebrák
- **Objektumok**: DG-algebrák R felett (gradált algebrák differenciállal)
- **Morfizmusok**: DG-algebra homomorfizmusok
- **Tulajdonságok**: monoidális (tenzorszorzat); **nem** abeli; modelkategória (gyenge ekvivalenciák = kvázi-izomorfizmusok)
- **Tétel**: a derivált algebrai geometria alapja; a DGA derivált kategóriája = D(R) derivált kategória (ha megfelelő); a dg-algebra = "linearizált topologikus tér"

### 93. L∞-algebra — Homotopikus Lie-algebrák
- **Objektumok**: L∞-algebrák (gyenge Lie-algebrák magasabb strukturákkal)
- **Morfizmusok**: L∞-morfizmusok
- **Tulajdonságok**: ∞-kategória; gyenge (nem szigorú); a Lie-algebra homotopikus általánosítása
- **Tétel**: Maurer-Cartan egyenlet; deformáció-elmélet (Deligne-Getzler); a szimpliciális Lie-algebra és az L∞-algebra ekvivalensek (Hinich)

### 94. A∞-category — A∞-kategóriák (gyenge asszociativitású)
- **Objektumok**: A∞-kategória objektumok
- **Morfizmusok**: magasabb műveletek m_n: hom⊗n → hom (homotópikus asszociativitás)
- **Tulajdonságok**: ∞-kategória; a homotópia kategória triangulált (általában); modelkategória keret
- **Tétel**: Fukaya-kategória (szimplektikus geometria); a mirror symmetry "A-oldala"; az A∞-kategória a homotópikus algebrai kategória

### 95. Stack — Stack-ek (Grothendieck)
- **Objektumok**: stack-ek egy Grothendieck topológián (vagy ∞-topos-ban)
- **Morfizmusok**: 1-morfizmusok (funktorok) + 2-morfizmusok (természetes transzformációk)
- **Tulajdonságok**: gyenge 2-functor; fibrált kategória; **nem** teljes/ko-teljes (általában 2-kategória)
- **Tétel**: a stack = "nyaláb a kategóriákban"; Deligne-Mumford stack = algebrai stack étale topológián; Artin stack = fppf topológián; a moduli tér általánosítása

### 96. ∞-Topos — Magasabb topos
- **Objektumok**: ∞-kategóriák amelyek ∞-groupoid-dal értékelődnek és megfelelő axiómákat kielégítenek
- **Morfizmusok**: geometriai morfizmusok (∞-adjungált pár)
- **Tulajdonságok**: ∞-kategória; teljes és ko-teljes (megfelelő ∞-értelemben); lokálisan kis; ∞-groupoid értékesített
- **Tétel**: Lurie "Higher Topos Theory"; a Grothendieck-Lurie axiómák; a ∞-topos a magasabb geometria alapja; a Shv(X) ∞-topos; a modelkategória és a ∞-topos megfeleltetés

### 97. TensorCat — Tenzor-kategóriák kategóriája
- **Objektumok**: monoidális kategóriák (vagy szimmetrikus monoidális, vagy braided)
- **Morfizmusok**: monoidális funktorok
- **Tulajdonságok**: 2-kategória (vagy 3-kategória); szimmetrikus monoidális strukturával
- **Tétel**: Mac Lane koherencia (minden monoidális kategória ekvivalens szigorú monoidális kategóriával); Tannaka-Krein dualitás (szimmetrikus monoidális kategória → kommutatív Hopf-monoid rekonstrukció)

### 98. BraidedCat — Braided monoidális kategóriák
- **Objektumok**: braided monoidális kategóriák (C, ⊗, I, braiding c_{A,B}: A⊗B → B⊗A)
- **Morfizmusok**: braided monoidális funktorok
- **Tulajdonságok**: 3-kategória; a braiding kielégíti a Yang-Baxter egyenletet
- **Tétel**: a braided monoidális kategória = a kvantumcsoport reprezentáció kategóriája; a kvantum-invariánsok (Jones-polinóm, HOMFLY); a szimmetrikus monoidális a braided speciális esete (c^2 = id)

### 99. RibbonCat — Ribbon kategóriák (szalag kategóriák)
- **Objektumok**: szimmetrikus/bradied monoidális + †-struktúra + twist
- **Morfizmusok**: struktúra-megtartó funktorok
- **Tulajdonságok**: braided + bal/jobb duál + twist; †-kompakt (gyenge)
- **Tétel**: a kvantum-csomó-invariánsok (Reshetikhin-Turaev); a szalag kategória = a topológiai kvantum-térelmélet modellje; az †-kompakt kategóriák (fd Hilbert) ribbon-k

### 100. QuantumGroup — Kvantumcsoportok kategóriája
- **Objektumok**: kvantumcsoportok (Hopf-algebrák deformációi: U_q(g), q-Hecke, stb.)
- **Morfizmusok**: Hopf-algebra homomorfizmusok (q-deformált)
- **Tulajdonságok**: monoidális (modul kategóriák); **nem** abeli; braided monoidális (a reprezentációk)
- **Tétel**: Drinfeld-Jimbo kvantumcsoport U_q(g); a Jones-polinóm a U_q(sl_2) reprezentációból; Tannaka-Krein rekonstrukció; a kódolt topológia és a kvantum-invariánsok

### 101. ModT — T-modul kategóriák (monád T felett)
- **Objektumok**: T-modul objektumok egy monoidális kategóriában (a monád algebrái)
- **Morfizmusok**: T-algebra homomorfizmusok
- **Tulajdonságok**: ha a bázis kategória C monoidális zárt és T erős monoidális monád → ModT monoidális
- **Tétel**: a Eilenberg-Moore kategória monoidális; a Tannaka-Krein dualitás monadikus keretben; a "functor kategória" + monadikus = operadikus algebra

### 102. SpecTr — Speciális functor kategóriák
- **Objektumok**: funktorok C → D egy speciális tulajdonsággal (pl. additív, pontos, konzervatív)
- **Morfizmusok**: természetes transzformációk
- **Tulajdonságok**: részkategóriája a teljes funktor kategóriának; ha a feltétel zárt kompozícióra → részkategória
- **Tétel**: a pontos funktorok reflexív részkategóriát alkotnak; a konzervatív funktorok a "Galois" megfelelői

### 103. AdjCat — Adjungált kategóriák / Galois-kapcsolatok
- **Objektumok**: Galois-kapcsolatok (f: P → Q, g: Q → P preorders között, adjungált)
- **Morfizmusok**: kompatibilis párok
- **Tulajdonságok**: a Pos-on belüli adjungáltságok = Galois-kapcsolatok
- **Tétel**: minden Galois-kapcsolat adjungáltság; a zárt halmazok közötti dualitás; a Hahn-Banach kategorikus formája

### 104. End(C) — Endofunktor kategória
- **Objektumok**: endofunktorok C → C
- **Morfizmusok**: természetes transzformációk
- **Tulajdonságok**: szigorú monoidális kategória (kompozícióval); a monoid objektumai = **monádok**
- **Tétel**: a monád = End(C)-beli monoid objektum; a monadikus algebra kategorikus alapja; a "kategória-művelet" = endofunktor + nat. transzformáció

### 105. Monad(C) — Monadok C-n
- **Objektumok**: monadok (T, η, μ) egy kategórián C
- **Morfizmusok**: monad-morfizmusok
- **Tulajdonságok**: 2-kategória; a monadok mint "kategória-elméleti monoidok"; End(C)-beli monoid objektumok
- **Tétel**: minden adjungáltság monádot generál; Eilenberg-Moore és Kleisli kettős konstrukció; Beck monadicity; a "szabad-forgetful" adjungáltság monádikus

### 106. Profunctor — Profunktorok (Dist)
- **Objektumok**: kategóriák
- **Morfizmusok**: profunktorok H: C^op × D → Set (vagy V)
- **Tulajdonságok**: bikategória; a profunktor = "kolimit-weighted" funktor; Prof(C,D) = [C^op × D, Set]
- **Tétel**: profunktorok mint "kategorikus relációk"; Rel ≃ Prof(Set) egy objektumon; a collimit-weighted kategorikus formalizmus; a coend és a profunktor (Yoneda: C^op × C → Set, Hom_C)

### 107. Operad — Operádok kategóriája
- **Objektumok**: operádok (multi-kategóriák: O(n), kompozícióval)
- **Morfizmusok**: operád-morfizmusok
- **Tulajdonságok**: monoidális; **nem** abeli; szimmetrikus/nem-szimmetrikus, színezett
- **Tétel**: az A∞-operád (asszociativitás gyenge); az E_n operád (kompakt zárt magasabb dimenzió); a kis objektumok kategóriája és az operadikus algebra; a May-féle felismerési elv

### 108. Props — PROPs kategóriája
- **Objektumok**: PROPs (PROduct and Progress categories): monoidális kategóriák szimmetrikus csoportobjektummal
- **Morfizmusok**: szigorú monoidális funktorok
- **Tulajdonságok**: monoidális; **nem** abeli; generálják az operádokat
- **Tétel**: a PROP = "szimmetrikus multi-kategória egy objektumon"; a tangle-k kategóriája = egy PROP; a diagrammatikus algebra (Penrose diagrammatic)

### 109. Lawvere theory — Lawvere-elméletek
- **Objektumok**: kis kategóriák véges szorzattal és "szorzat-példányozással"
- **Morfizmusok**: szorzat-megtartó funktorok
- **Tulajdonságok**: teljes és ko-teljes; a modellek Set-ben = funktorok; a szorzat-kategorikus algebrai elmélet
- **Tétel**: Lawvere elméletek = "algebrai elméletek kategorikusan"; Grp, Ring, Mod mint Lawvere-elmélet modellek; Gabriel-Ulmer dualitás (lokálisan végesen prezentálható kategóriák dualitása a Lawvere-elméletekkel)

### 110. Sketch — Vázlatok (sketch-ek)
- **Objektumok**: kategóriák vázlatai (kis kategória + megengedett kolimit-ek/limit-ek)
- **Morfizmusok**: vázlat-morfizmusok
- **Tulajdonságok**: a modellek = funktorok a megengedett limit/colimit-et megtartó; teljes és ko-teljes (a modellek)
- **Tétel**: a szokásos (szorzat/kolimit) algebrai kategóriák = Lawvere-elmélet modellek; az általánosabb (pl. topologikus, mező) kategóriák = vázlat-modellek; az Ess-geometriai elmélet

---

## V. FONTOS TÉTELEK ÖSSZEFOGLALÓ

### Yoneda lemma
Minden lokálisan kis C-re és F: C^op → Set funktorra:
```
Hom_{PSh(C)}(y(c), F) ≅ F(c)
```
ahol y: C → PSh(C) a Yoneda beágyazás. Az "azonos" állítás: Hom_C(c, -) ≅ F(c) természetes izomorfizmus. Ez a kategória-elmélet legmélyebb egyszerű tétele.

### Mitchell (Freyd-Mitchell) beágyazási tétel
Minden kis abeli kategória beágyazható egy R-modulok kategóriájába (teljes és pontos funktorral). Ez biztosítja, hogy a diagram-vadászat az R-Mod-ban legitim.

### Adjungált functor tétel (Freyd)
Egy funktor G: D → C bal adjungálttal rendelkezik ha és csak ha: (i) megőrzi a limiteket, és (ii) megfelel a "megoldási halmaz feltételnek" (solution set condition). Speciális eset: ha C teljes és lokálisan kis, és D teljes és megfelelő kis objektum feltételeknek.

### Monadicity tétel (Beck)
Egy adjungáltság F ⊣ G monadikus (azaz a kompozíció D → C a monád Eilenberg-Moore kategóriája) ha G: (i) kreálja G-exakt koekvalizátor-párokat, és (ii) konzervatív (reflexív). Speciális: ha G pontos és konzervatív, és reflexív koekvalizátor-párokat kreál.

### Grothendieck-konstrukció
Minden pszeudo-funktor F: C^op → Cat (indexed category) számára létezik egy "Grothendieck konstrukció" ∫F (az integrál kategória), amely objektumai (c, x) ahol c ∈ C, x ∈ F(c), és morfizmusok (f, α): (c, x) → (d, y) ahol f: c → d C-ben és α: F(f)(y) → x F(c)-ban. A Grothendieck konstr. bal adjungált az "indexelt kategória" konstrukcióhoz.

### Gabriel-Ulmer dualitás
A lokálisan végesen prezentálható kategóriák dualitása a Lawvere-elméletekkel: (Lex[C, Set])^op ≃ a véges limiteket megőrző funktorok kategóriája dualisan ekvivalens C-vel.

### Tannaka dualitás
Minden "jó" szimmetrikus monoidális kategória V egy kódolt Hopf-monoid H rekonstruálható: V ≃ Rep(H). Speciális: ha V = Rep(G) egy kompakt csoport, akkor G rekonstruálható a V monoidális struktúrájából (fibers functorral).

### Brown reprezentábilitás
Minden kovariáns funktor a CW-komplexek homotópia kategóriájáról Set-be amely (i) Mayer-Vietoris-t kielégí és (ii) "stabilizálható", reprezentálható egy spektrum által. Az általános kohomológia spektrum-reprezentáció alapja.

### Homotópia hipotézis (Grothendieck)
Az ∞-groupoidok kategóriája ekvivalens a topologikus terek homotópia kategóriájával (∞-groupoidok ≃ homotópia típusok). A magasabb kategória-elmélet legmélyebb hipotézise (a kvázi-kategória keretben igazolva, Lurie).

### Kígyó lemma (Snake lemma)
Minden abeli kategóriában, egy kommutatív diagram a rövid pontos sorozatokkal:
```
0 → A' → A → A'' → 0
↓    ↓    ↓
0 → B' → B → B'' → 0
```
eredményezi a "kígyó" pontos sorozatot: ker(f') → ker(f) → ker(f'') → coker(f') → coker(f) → coker(f''). A homológiai algebra alapvető eszköze.

### Ötös lemma (Five lemma)
Egy kommutatív 5-tagú diagram pontos sorozatokkal:
```
A' → A → A'' → A''' → A'''' → 0
↓f' ↓f ↓f'' ↓f''' ↓f''''
B' → B → B'' → B''' → B'''' → 0
```
Ha f' és f'' epi (vagy iso), f''' és f'''' mono (vagy iso), akkor f iso. A homológiai algebra eszköze.

### Whitehead tétele
Egy gyenge homotópia ekvivalencia CW-komplexek között homotópia ekvivalencia. Tehát a "gyenge" és "szigorú" homotópia ekvivalencia megegyezik CW-komplexeken. A Ho(Top) ekvivalens a CW-komplexek naiv homotópia kategóriájával.

### Mac Lane koherencia tétel
Minden monoidális kategória ekvivalens egy szigorú monoidális kategóriával (ahol az asszociátor és az egység szigorú egyenlőség). Tehát a "gyenge" asszociativitás átvihető szigorúra.

### Verdier lokalizáció
Minden triangulált kategóriában T és egy "nullával kompatibilis" részkategória N (thick subcategory) esetén a Verdier lokalizáció T/N egy új triangulált kategória. Speciális: K(A) → D(A) a kvázi-izomorfizmusok szerinti lokalizáció.

### Stone dualitás
A Boole-algebrák kategóriája duálisan ekvivalens a Stone-terek kategóriájával: Bool^op ≃ StoneSpaces. A Boole-algebra = a kompakt összefüggés nélküli terek (Stone terek) belső "nyelv"-e. A klasszikus logika és a topológia kapcsolata.

### Gelfand-Naimark dualitás
A kommutatív C*-algebrák kategóriája duálisan ekvivalens a kompakt Hausdorff terek kategóriájával: CommCStar^op ≃ CompHaus. A nem-kommutatív geometria alapja (Connes).

### Serre dualitás / Grothendieck-Riemann-Roch
A kohomológia és a geometriai struktúra kapcsolata. Speciális: a projekciós sokaság kohomológiája és a kanonikus nyaláb között. A Kohomológia funktor és a K-elmélet kapcsolata.

### Isbell dualitás
A [C^op, Set] (pre-nyaláb) és a [C, Set]^op (ko-pre-nyaláb) közötti dualitás. A "geometriai" és "algebrai" dualitás (algebra = kohomológia, geometria = homológia).

---

## VI. STATISZTIKA / SZERVEZET

Ez a katalógus **110+ nevezett kategóriát** tartalmaz, szervezve a következő területek szerint:

| Terület | Kategóriák száma | Példák |
|---------|-----------------|--------|
| **Algebra** | 20 | Set, FinSet, Grp, Ab, Ring, Field, R-Mod, Vect_K, Rep, Mon, Lat, Bool, Heyt, Magma, SGrp, CRing, k-Alg, LieAlg, HopfAlg, Grph |
| **Topológia/Geometria** | 19 | Top, Top*, Man, Met, Meas, Stoch, Sch, AffSch, StoneSpaces, Frm, Loc, Ho(Top), sSet, Ch(R), K(R), D(R), Spec, SmCat, Fréchet |
| **Logika/Számítástudomány** | 26 | Cat, CAT, Fun, PSh, Sh, Topos, Kleisli, EM, Rel, Span, Cospan, Slice, Coslice, Comma, Opposite, Product, Quotient, Localization, Free, MonCat, 2-Cat, Bicat, ∞-Cat, Δ, Ord, Poset, ThinCat |
| **Kvantum/Fizika** | 6 | Hilb_fd, Hilb, Quantale, Chu, Qubits, RibbonCat |
| **Kategória-konstrukciók** | 17 | Discrete, Monoid-as-cat, Groupoid, nGroupoid, ModelCat, Triangulated, Stable∞, (∞,1)-Cat, V-Cat, InternalCat, Prof, Spec, DGA, L∞, A∞, Stack, ∞-Topos |
| **Monoidális/Higher** | 13 | TensorCat, BraidedCat, RibbonCat, QuantumGroup, ModT, SpecTr, AdjCat, End(C), Monad, Profunctor, Operad, Prop, Lawvere, Sketch |
| **Tételek** | 15+ | Yoneda, Mitchell, AdjFunctorTheorem, Beck, Grothendieck, Gabriel-Ulmer, Tannaka, Brown, HomotopyHypothesis, Snake, Five, Whitehead, MacLane, Verdier, Stone, Gelfand-Naimark, Serre, Isbell |

---

## VII. KATEGÓRIA-TÍPUSOK RENDSZERE (klasszifikáció)

```
Topos (Grothendieck) ⊃ Elemi Topos ⊃ CCC ⊃ Monoidális
                                                          ⊃ Additív ⊃ Preadditív
Abeli ⊃ Pre-abeli ⊃ Pre-additív
Complete/Cocomplete (független)
Cartesian Closed (CCC) — a sima típuselmélet modellje
Symmetric Monoidal Closed — lineáris logika modellje
*-Autonomous — lineáris logika (Chu, Quantale)
†-Compact — kvantum-információ (Hilb_fd)
Model category — homotópia elmélet
Triangulated — homológiai algebra
Stable ∞-category — magasabb algebra
```

---

*Katalógus összeállítva: Wikipedia, nLab, Mac Lane, Awodey alapján. 2026.07.30.*