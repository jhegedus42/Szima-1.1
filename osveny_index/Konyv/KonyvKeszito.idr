module Konyv.KonyvKeszito

import Alap.KategoriaT
import Data.String

-- ═══════════════════════════════════════════════════════════════
-- KÖNYVKÉSZÍTŐ — Idris program ami LaTeX könyvet generál
-- ═══════════════════════════════════════════════════════════════
-- Az Idris program közvetlenül írja a LaTeX fájlt.
-- Magyar bal oldalon, angol jobboldalon, TikZ diagramokkal.
-- Mind a 49 kategóriaelméleti struktúra (Awodey 39 + Mac Lane 10).
-- A nyelv = adattípusok + Show typeclass. A magyar nyelv szavai
-- = konstruktorok, a ragozás = funktor, a mondat = kompozíció.

-- ─── SEGÉDFÜGGVÉNYEK ───────────────────────────────────────

||| Egy strukturált bejegyzés: magyar név + angol név + leírás + diagram + kód.
public export
record KonyvBejegyzes where
  constructor BejegyzesKonstruktor
  sorszam : Nat
  magyarNev : String
  angolNev : String
  magyarLeiras : String
  angolLeiras : String
  diagram : String
  kodHivatkozas : String
  wikipediaLink : String

||| A 49 struktúra adatai.
public export
negyvenKilencStruktura : List KonyvBejegyzes
negyvenKilencStruktura = [
  -- SZINT 1: ALAPSTRUKTÚRÁK
  BejegyzesKonstruktor 1 "Kategória" "Category"
    "Objektumok + morfizmusok + kompozíció + identitás. Törvények: asszociativitás, bal/jobb egység. A 15 dimenzió: 15 objektum (7 emberi + 7 számítási + 1 perem)."
    "Objects + morphisms + composition + identity. Laws: associativity, left/right unit. The 15 dimensions: 15 objects (7 human + 7 computational + 1 boundary)."
    "\\begin{tikzcd} A \\arrow[r, \"f\"] \\arrow[dr, \"g \\circ f\"'] & B \\arrow[d, \"g\"] \\\\ & C \\end{tikzcd}"
    "Alap/KategoriaT.idr:23" "https://en.wikipedia.org/wiki/Category_(mathematics)",
  BejegyzesKonstruktor 28 "Félcsoport" "Semigroup"
    "Asszociatív bináris művelet, egységelem nélkül. A kompozíció egy objektumon = a monoidális tenzor."
    "Associative binary operation, no unit. Composition on one object = monoidal tensor."
    "\\begin{tikzcd} (a \\cdot b) \\cdot c \\arrow[r, equal] & a \\cdot (b \\cdot c) \\end{tikzcd}"
    "Alap/KategoriaT.idr:38" "https://en.wikipedia.org/wiki/Semigroup",
  BejegyzesKonstruktor 31 "Előrendezés" "Preorder"
    "Reflekszív + tranzitív reláció. Kategória legfeljebb egy nyíllal objektumok között. A 15 dimenzió rendezése: melyik dimenzióból melyikbe vezet út."
    "Reflexive + transitive relation. Category with at most one arrow between objects. Ordering of the 15 dimensions: which dimension leads to which."
    "\\begin{tikzcd} x \\arrow[r, leftrightarrow] & y \\arrow[r, leftrightarrow] & z \\end{tikzcd}"
    "Alap/KategoriaT.idr:47" "https://en.wikipedia.org/wiki/Preorder",
  BejegyzesKonstruktor 35 "Ellenkező kategória" "Opposite category"
    "C\\textsuperscript{op}: ugyanazok az objektumok, megfordított nyilak. A perem (Legendre) = C ↔ C\\textsuperscript{op} adjunkció."
    "C\\textsuperscript{op}: same objects, reversed arrows. The boundary (Legendre) = C ↔ C\\textsuperscript{op} adjunction."
    "\\begin{tikzcd} A \\arrow[r, \"f\"', from=op] & B \\arrow[l, \"f\\textsuperscript{op}\"', from=op] \\end{tikzcd}"
    "Alap/KategoriaT.idr:55" "https://en.wikipedia.org/wiki/Opposite_category",
  -- SZINT 2: FUNKTOROK
  BejegyzesKonstruktor 2 "Funktor" "Functor"
    "Kategória szerkezet megőrzése. Törvények: kompozíció megőrzése, identitás megőrzése. objKep paraméter, morfizmusKep metódus."
    "Preserves category structure. Laws: composition preservation, identity preservation. objKep is a parameter, morfizmusKep is a method."
    "\\begin{tikzcd} A \\arrow[r, \"f\"] \\arrow[d, \"F\"'] & B \\arrow[d, \"F\"] \\\\ F(A) \\arrow[r, \"F(f)\"'] & F(B) \\end{tikzcd}"
    "Alap/KategoriaT.idr:71" "https://en.wikipedia.org/wiki/Functor",
  BejegyzesKonstruktor 3 "Természetes transzformáció" "Natural transformation"
    "Két funktor (f1, f2 : C → D) között. Komponens α\\textsubscript{a} : f1(a) → f2(a). Természetesség: α\\textsubscript{b} ∘ F(f) = G(f) ∘ α\\textsubscript{a}."
    "Between two functors (f1, f2 : C → D). Component α\\textsubscript{a} : f1(a) → f2(a). Naturality: α\\textsubscript{b} ∘ F(f) = G(f) ∘ α\\textsubscript{a}."
    "\\begin{tikzcd} F(A) \\arrow[r, \"F(f)\"] \\arrow[d, \"\\alpha_A\"'] & F(B) \\arrow[d, \"\\alpha_B\"] \\\\ G(A) \\arrow[r, \"G(f)\"'] & G(B) \\end{tikzcd}"
    "Alap/KategoriaT.idr:85" "https://en.wikipedia.org/wiki/Natural_transformation",
  BejegyzesKonstruktor 5 "Természetes izomorfizmus" "Natural isomorphism"
    "Természetes transzformáció, aminek minden komponense izomorfizmus. α\\textsubscript{a} : F(a) ≅ G(a), inverzzel."
    "Natural transformation where every component is an isomorphism. α\\textsubscript{a} : F(a) ≅ G(a), with inverse."
    "\\begin{tikzcd} F(A) \\arrow[r, shift left, \"\\alpha_A\"] & G(A) \\arrow[l, shift left, \"\\alpha_A^{-1}\"'] \\end{tikzcd}"
    "Alap/KategoriaT.idr:97" "https://en.wikipedia.org/wiki/Natural_isomorphism",
  BejegyzesKonstruktor 4 "Funktor kategória" "Functor category"
    "Objektumok: funktorok, nyilak: természetes transzformációk. [C\\textsuperscript{op}, Set] = a presheaf kategória."
    "Objects: functors, arrows: natural transformations. [C\\textsuperscript{op}, Set] = the presheaf category."
    "\\begin{tikzcd} F \\arrow[r, \"\\alpha\"] & G \\end{tikzcd}"
    "Alap/KategoriaT.idr:106" "https://en.wikipedia.org/wiki/Functor_category",
  -- SZINT 3: ALGEBRAI STRUKTÚRÁK
  BejegyzesKonstruktor 27 "Monoid" "Monoid"
    "Félcsoport egységelemmel. A magyar agglutináció: tő ⊗ képző ⊗ rag = szó (monoidális tenzor)."
    "Semigroup with unit. Hungarian agglutination: stem ⊗ suffix ⊗ ending = word (monoidal tensor)."
    "\\begin{tikzcd} e \\otimes a \\arrow[r, equal] & a \\arrow[r, equal] & a \\otimes e \\end{tikzcd}"
    "Alap/KategoriaT.idr:117" "https://en.wikipedia.org/wiki/Monoid",
  BejegyzesKonstruktor 26 "Csoport" "Group"
    "Monoid inverzzel. A Pauli-csoport: X, Y, Z (mind involució: X² = Y² = Z² = I)."
    "Monoid with inverse. The Pauli group: X, Y, Z (all involutions: X² = Y² = Z² = I)."
    "\\begin{tikzcd} a \\arrow[r, \"\\cdot\"] & a \\cdot a^{-1} \\arrow[r, equal] & e \\end{tikzcd}"
    "Alap/KategoriaT.idr:123" "https://en.wikipedia.org/wiki/Group_(mathematics)",
  BejegyzesKonstruktor 30 "Részbenrendezett halmaz" "Poset"
    "Előrendezés antiszimmetriával. a ≤ b ∧ b ≤ a ⟹ a = b."
    "Preorder with antisymmetry. a ≤ b ∧ b ≤ a ⟹ a = b."
    "\\begin{tikzcd} a \\arrow[r, \"\\leq\"] & b \\arrow[r, \"\\leq\"'] & a \\arrow[r, equal] & a \\end{tikzcd}"
    "Alap/KategoriaT.idr:61" "https://en.wikipedia.org/wiki/Partially_ordered_set",
  BejegyzesKonstruktor 6 "Izomorfizmus" "Isomorphism"
    "Nyíl inverzzel: f ∘ g = id, g ∘ f = id. A [[15,1,3]] kód: kodol ∘ dekodol = id."
    "Arrow with inverse: f ∘ g = id, g ∘ f = id. The [[15,1,3]] code: encode ∘ decode = id."
    "\\begin{tikzcd} A \\arrow[r, shift left, \"f\"] & B \\arrow[l, shift left, \"f^{-1}\"'] \\end{tikzcd}"
    "Alap/KategoriaT.idr:131" "https://en.wikipedia.org/wiki/Isomorphism",
  BejegyzesKonstruktor 7 "Monomorfizmus" "Monomorphism"
    "Bal oldali törlés. f ∘ g = f ∘ h ⟹ g = h. Injektív leképezés."
    "Left cancellation. f ∘ g = f ∘ h ⟹ g = h. Injective map."
    "\\begin{tikzcd} C \\arrow[r, shift left, \"g\"] \\arrow[r, shift right, \"h\"'] & A \\arrow[r, \"f\"] & B \\end{tikzcd}"
    "Alap/KategoriaT.idr:137" "https://en.wikipedia.org/wiki/Monomorphism",
  BejegyzesKonstruktor 8 "Epimorfizmus" "Epimorphism"
    "Jobb oldali törlés. i ∘ f = j ∘ f ⟹ i = j. Szürjektív leképezés."
    "Right cancellation. i ∘ f = j ∘ f ⟹ i = j. Surjective map."
    "\\begin{tikzcd} A \\arrow[r, \"f\"] & B \\arrow[r, shift left, \"i\"] \\arrow[r, shift right, \"j\"'] & C \\end{tikzcd}"
    "Alap/KategoriaT.idr:143" "https://en.wikipedia.org/wiki/Epimorphism",
  -- SZINT 4: LIMITEK
  BejegyzesKonstruktor 9 "Kezdő objektum" "Initial object"
    "Egyedi nyíl minden objektumba. ∃! (0 → C). A üres halmaz a Set kezdő objektuma."
    "Unique arrow to every object. ∃! (0 → C). The empty set is initial in Set."
    "\\begin{tikzcd} 0 \\arrow[r] & A \\arrow[dr] & \\\\ 0 \\arrow[rr] & & B \\end{tikzcd}"
    "Alap/KategoriaT.idr:150" "https://en.wikipedia.org/wiki/Initial_and_terminal_objects",
  BejegyzesKonstruktor 10 "Végobjektum" "Terminal object"
    "Egyedi nyíl minden objektumból. ∃! (C → 1). Az egyelemű halmaz a Set végobjektuma."
    "Unique arrow from every object. ∃! (C → 1). The singleton set is terminal in Set."
    "\\begin{tikzcd} A \\arrow[r] & 1 \\\\ B \\arrow[ur] & \\end{tikzcd}"
    "Alap/KategoriaT.idr:157" "https://en.wikipedia.org/wiki/Initial_and_terminal_objects",
  BejegyzesKonstruktor 11 "Szorzat" "Product"
    "A×B + projekciók p₁, p₂ + párosítás ⟨f,g⟩. p₁∘⟨f,g⟩=f, p₂∘⟨f,g⟩=g. A 15 dimenzió = 15 szorzat."
    "A×B + projections p₁, p₂ + pairing ⟨f,g⟩. p₁∘⟨f,g⟩=f, p₂∘⟨f,g⟩=g. The 15 dimensions = 15 products."
    "\\begin{tikzcd} & Z \\arrow[dl, \"f\"'] \\arrow[d, \"\\langle f,g \\rangle\"] \\arrow[dr, \"g\"] & \\\\ A & A \\times B \\arrow[l, \"p_1\"] \\arrow[r, \"p_2\"'] & B \\end{tikzcd}"
    "Alap/KategoriaT.idr:164" "https://en.wikipedia.org/wiki/Product_(category_theory)",
  BejegyzesKonstruktor 12 "Koszorzat" "Coproduct"
    "A+B + injekciók i₁, i₂ + elágazás [f,g]. [f,g]∘i₁=f, [f,g]∘i₂=g. A szorzat duálisa."
    "A+B + injections i₁, i₂ + case [f,g]. [f,g]∘i₁=f, [f,g]∘i₂=g. Dual of product."
    "\\begin{tikzcd} A \\arrow[dr, \"i_1\"] & & B \\arrow[dl, \"i_2\"'] \\\\ & A + B \\arrow[r, \"[f,g]\"] & C \\\\ A \\arrow[ur, \"f\"'] & & B \\arrow[ul, \"g\"] \\end{tikzcd}"
    "Alap/KategoriaT.idr:174" "https://en.wikipedia.org/wiki/Coproduct",
  BejegyzesKonstruktor 13 "Kiegyenlítő" "Equalizer"
    "f∘e = g∘e + univerzális. Párhuzamos nyilak kiegyenlítése."
    "f∘e = g∘e + universal. Equalizing parallel arrows."
    "\\begin{tikzcd} E \\arrow[r, \"e\"] & A \\arrow[r, shift left, \"f\"] \\arrow[r, shift right, \"g\"'] & B \\end{tikzcd}"
    "Alap/KategoriaT.idr:185" "https://en.wikipedia.org/wiki/Equalizer_(mathematics)",
  BejegyzesKonstruktor 14 "Kokiegyenlítő" "Coequalizer"
    "q∘f = q∘g + univerzális. A kiegyenlítő duálisa."
    "q∘f = q∘g + universal. Dual of equalizer."
    "\\begin{tikzcd} A \\arrow[r, shift left, \"f\"] \\arrow[r, shift right, \"g\"'] & B \\arrow[r, \"q\"] & Q \\end{tikzcd}"
    "Alap/KategoriaT.idr:192" "https://en.wikipedia.org/wiki/Coequalizer",
  BejegyzesKonstruktor 15 "Visszahúzás" "Pullback"
    "A×\\textsubscript{C}B + projekciók + f∘p₁ = g∘p₂. Szorzat + kiegyenlítő kompozíciója."
    "A×\\textsubscript{C}B + projections + f∘p₁ = g∘p₂. Product + equalizer composition."
    "\\begin{tikzcd} P \\arrow[r, \"p_2\"] \\arrow[d, \"p_1\"'] & B \\arrow[d, \"g\"] \\\\ A \\arrow[r, \"f\"'] & C \\end{tikzcd}"
    "Alap/KategoriaT.idr:199" "https://en.wikipedia.org/wiki/Pullback_(category_theory)",
  BejegyzesKonstruktor 16 "Kitolás" "Pushout"
    "B+\\textsubscript{A}C + injekciók + j₁∘f = j₂∘g. A visszahúzás duálisa."
    "B+\\textsubscript{A}C + injections + j₁∘f = j₂∘g. Dual of pullback."
    "\\begin{tikzcd} A \\arrow[r, \"f\"] \\arrow[d, \"g\"'] & B \\arrow[d, \"j_1\"] \\\\ C \\arrow[r, \"j_2\"'] & Q \\end{tikzcd}"
    "Alap/KategoriaT.idr:208" "https://en.wikipedia.org/wiki/Pushout_(category_theory)",
  BejegyzesKonstruktor 17 "Limesz" "Limit"
    "Végső kúp. A limesz = optimum = nyerés. A játékban a nyerő stratégia = limesz a hasznosság kategóriájában."
    "Terminal cone. Limit = optimum = winning. In games, the winning strategy = limit in the utility category."
    "\\begin{tikzcd} \\lim D \\arrow[r, \"p_j\"] \\arrow[dr, \"p_i\"'] & D_j \\\\ D_i \\arrow[ur, \"D(\\alpha)\"'] & \\end{tikzcd}"
    "Alap/KategoriaT.idr:216" "https://en.wikipedia.org/wiki/Limit_(category_theory)",
  BejegyzesKonstruktor 18 "Kolimesz" "Colimit"
    "Kezdő kokúp. A limesz duálisa. A sportban a rekord = kolimesz a teljesítmény kategóriájában."
    "Initial cocone. Dual of limit. In sports, the record = colimit in the performance category."
    "\\begin{tikzcd} D_i \\arrow[r, \"i_i\"] \\arrow[dr] & \\text{colim} D \\\\ D_j \\arrow[ur] & \\end{tikzcd}"
    "Alap/KategoriaT.idr:223" "https://en.wikipedia.org/wiki/Limit_(category_theory)",
  -- SZINT 5: EXPOENCIÁL
  BejegyzesKonstruktor 19 "Exponenciál" "Exponential"
    "C\\textsuperscript{B} + kiértékelés ε + transzpozíció. ε ∘ (f̃ × 1\\textsubscript{B}) = f."
    "C\\textsuperscript{B} + evaluation ε + transpose. ε ∘ (f̃ × 1\\textsubscript{B}) = f."
    "\\begin{tikzcd} Z \\times B \\arrow[r, \"f\"] \\arrow[d, \"\\tilde{f} \\times 1\"'] & C \\\\ Z \\arrow[r, \"\\tilde{f}\"'] & C^B \\arrow[u, \"\\varepsilon\"'] \\end{tikzcd}"
    "Alap/KategoriaT.idr:232" "https://en.wikipedia.org/wiki/Exponential_object",
  BejegyzesKonstruktor 20 "Kartéziánusan zárt kategória" "Cartesian closed category"
    "Végobjektum + szorzatok + exponenciálok. A λ-kalkulusus modellje."
    "Terminal object + products + exponentials. Model of λ-calculus."
    "\\begin{tikzcd} 1 & A \\times B \\arrow[l] & B^A \\arrow[r] & C \\end{tikzcd}"
    "Alap/KategoriaT.idr:244" "https://en.wikipedia.org/wiki/Cartesian_closed_category",
  BejegyzesKonstruktor 21 "Heyting algebra" "Heyting algebra"
    "Poset exponenciállal: a ∧ b ≤ c ⟺ a ≤ b ⇒ c. Az intuicionista logika algebraja."
    "Poset with exponential: a ∧ b ≤ c ⟺ a ≤ b ⇒ c. Algebra of intuitionistic logic."
    "\\begin{tikzcd} a \\wedge b \\arrow[r, \"\\leq\"] & c \\\\ a \\arrow[r, \"\\leq\"'] & b \\Rightarrow c \\arrow[u, \"\\leq\"'] \\end{tikzcd}"
    "Alap/KategoriaT.idr:250" "https://en.wikipedia.org/wiki/Heyting_algebra",
  BejegyzesKonstruktor 22 "Boole algebra" "Boolean algebra"
    "Heyting algebra kiegészítve ¬¬a = a. A klasszikus logika algebraja."
    "Heyting algebra with ¬¬a = a. Algebra of classical logic."
    "\\begin{tikzcd} a \\arrow[r, \"\\neg\"] & \\neg a \\arrow[r, \"\\neg\"'] & a \\arrow[r, equal] & a \\end{tikzcd}"
    "Alap/KategoriaT.idr:257" "https://en.wikipedia.org/wiki/Boolean_algebra_(structure)",
  -- SZINT 6: ADJUNKCIÓ, MONÁD, KOMONÁD
  BejegyzesKonstruktor 23 "Adjunkció" "Adjunction"
    "F ⊣ G: Hom\\textsubscript{D}(F a, b) ≅ Hom\\textsubscript{C}(a, G b). A perem (Legendre) = adjunkció a kvantum és klasszikus között."
    "F ⊣ G: Hom\\textsubscript{D}(F a, b) ≅ Hom\\textsubscript{C}(a, G b). The boundary (Legendre) = adjunction between quantum and classical."
    "\\begin{tikzcd} \\mathcal{C} \\arrow[rr, bend left=30, \"F\"] & & \\mathcal{D} \\arrow[ll, bend left=30, \"G\"'] \\\\ & \\perp & \\end{tikzcd}"
    "Alap/KategoriaT.idr:270" "https://en.wikipedia.org/wiki/Adjoint_functors",
  BejegyzesKonstruktor 24 "Monád" "Monad"
    "Endofunktor T + η + μ. Törvények: μ∘μT = μ∘Tμ, μ∘ηT = id = μ∘Tη. A számítás hatása: IO, State, Either."
    "Endofunctor T + η + μ. Laws: μ∘μT = μ∘Tμ, μ∘ηT = id = μ∘Tη. Computational effect: IO, State, Either."
    "\\begin{tikzcd} T^2 A \\arrow[r, \"\\mu\"] \\arrow[dr, \"T\\eta\"'] & TA \\\\ & TA \\arrow[u, \"\\text{id}\"'] \\end{tikzcd}"
    "Alap/KategoriaT.idr:283" "https://en.wikipedia.org/wiki/Monad_(category_theory)",
  BejegyzesKonstruktor 25 "Komonád" "Comonad"
    "Endofunktor G + ε + δ. A monád duálisa. Kontextus kinyerése: Reader, Store, Trace."
    "Endofunctor G + ε + δ. Dual of monad. Context extraction: Reader, Store, Trace."
    "\\begin{tikzcd} GA \\arrow[r, \"\\delta\"] \\arrow[dr, \"\\varepsilon\"'] & G^2 A \\\\ & A \\end{tikzcd}"
    "Alap/KategoriaT.idr:290" "https://en.wikipedia.org/wiki/Comonad",
  -- SZINT 7: MONOIDÁLIS KATEGÓRIÁK
  BejegyzesKonstruktor 40 "Monoidális kategória" "Monoidal category"
    "Kategória + tenzor ⊗ + egység + asszociátor + λ/ρ. A magyar agglutináció: tő ⊗ képző ⊗ rag = szó."
    "Category + tensor ⊗ + unit + associator + λ/ρ. Hungarian agglutination: stem ⊗ suffix ⊗ ending = word."
    "\\begin{tikzcd} (A \\otimes B) \\otimes C \\arrow[r, \"\\alpha\"] \\arrow[dr, \"\\rho \\otimes 1\"'] & A \\otimes (B \\otimes C) \\arrow[d, \"1 \\otimes \\lambda\"] \\\\ & A \\otimes (B \\otimes C) \\end{tikzcd}"
    "Alap/KategoriaT.idr:300" "https://en.wikipedia.org/wiki/Monoidal_category",
  BejegyzesKonstruktor 41 "Fonott monoidális kategória" "Braided monoidal category"
    "Monoidális + fonás γ: a⊗b → b⊗a. Hexagon axiómák + Yang-Baxter."
    "Monoidal + braiding γ: a⊗b → b⊗a. Hexagon axioms + Yang-Baxter."
    "\\begin{tikzcd} A \\otimes B \\arrow[r, \"\\gamma\"] & B \\otimes A \\end{tikzcd}"
    "Alap/KategoriaT.idr:313" "https://en.wikipedia.org/wiki/Braided_monoidal_category",
  BejegyzesKonstruktor 42 "Szimmetrikus monoidális kategória" "Symmetric monoidal category"
    "Fonott + γ² = id (involúció). E8×E8: kommutatív tenzor → szimmetrikus."
    "Braided + γ² = id (involution). E8×E8: commutative tensor → symmetric."
    "\\begin{tikzcd} A \\otimes B \\arrow[r, \"\\gamma\"] & B \\otimes A \\arrow[r, \"\\gamma\"'] & A \\otimes B \\arrow[r, equal] & A \\otimes B \\end{tikzcd}"
    "Alap/KategoriaT.idr:320" "https://en.wikipedia.org/wiki/Symmetric_monoidal_category",
  BejegyzesKonstruktor 43 "Zárt kategória" "Closed category"
    "Szimmetrikus monoidális + belső Hom: V(a⊗b, c) ≅ V(a, c\\textsuperscript{b})."
    "Symmetric monoidal + internal hom: V(a⊗b, c) ≅ V(a, c\\textsuperscript{b})."
    "\\begin{tikzcd} a \\otimes b \\arrow[r] & c \\\\ a \\arrow[r] & c^b \\arrow[u] \\end{tikzcd}"
    "Alap/KategoriaT.idr:327" "https://en.wikipedia.org/wiki/Closed_category",
  -- SZINT 8: 2-KATEGÓRIÁK
  BejegyzesKonstruktor 44 "2-kategória" "2-category"
    "0-sejtek + 1-sejtek + 2-sejtek. Függőleges + vízszintes kompozíció + interchange."
    "0-cells + 1-cells + 2-cells. Vertical + horizontal composition + interchange."
    "\\begin{tikzcd} f \\arrow[r, Rightarrow, \"\\alpha\"] & g \\arrow[r, Rightarrow, \"\\beta\"'] & h \\end{tikzcd}"
    "Alap/KategoriaT.idr:338" "https://en.wikipedia.org/wiki/2-category",
  BejegyzesKonstruktor 45 "Bikategória" "Bicategory"
    "Gyenge 2-kategória: α, λ, ρ izomorfizmusok, nem egyenlőségek. A gyengeség = a természet."
    "Weak 2-category: α, λ, ρ are isomorphisms, not equalities. The weakness = the nature."
    "\\begin{tikzcd} (f \\circ g) \\circ h \\arrow[r, \"\\alpha\"] & f \\circ (g \\circ h) \\end{tikzcd}"
    "Alap/KategoriaT.idr:350" "https://en.wikipedia.org/wiki/Bicategory",
  -- SZINT 9: KITERJESZTÉSEK
  BejegyzesKonstruktor 46 "Kan kiterjesztés" "Kan extension"
    "Jobb Kan: Ran\\textsubscript{K} T + ε: R∘K ⇒ T. Bal Kan: Lan\\textsubscript{K} T + η: T ⇒ L∘K."
    "Right Kan: Ran\\textsubscript{K} T + ε: R∘K ⇒ T. Left Kan: Lan\\textsubscript{K} T + η: T ⇒ L∘K."
    "\\begin{tikzcd} M \\arrow[r, \"K\"] \\arrow[dr, \"T\"'] & C \\arrow[d, dashed, \"\\text{Ran}_K T\"'] \\\\ & A \\end{tikzcd}"
    "Alap/KategoriaT.idr:369" "https://en.wikipedia.org/wiki/Kan_extension",
  BejegyzesKonstruktor 47 "End / Vég" "End"
    "∫\\textsubscript{c} S(c,c) + dinaturális ék. A Nat(F, G) = ∫\\textsubscript{c} Hom(Fc, Gc)."
    "∫\\textsubscript{c} S(c,c) + dinatural wedge. Nat(F, G) = ∫\\textsubscript{c} Hom(Fc, Gc)."
    "\\begin{tikzcd} E \\arrow[r, \"\\omega_c\"] & S(c,c) \\end{tikzcd}"
    "Alap/KategoriaT.idr:378" "https://en.wikipedia.org/wiki/End_(category_theory)",
  BejegyzesKonstruktor 48 "Coend / Kövég" "Coend"
    "∫\\textsuperscript{c} S(c,c) + dinaturális ko-ék. A tenzor szorzat = coend: A ⊗\\textsubscript{R} B = ∫\\textsuperscript{r} A ⊗ B."
    "∫\\textsuperscript{c} S(c,c) + dinatural co-wedge. Tensor product = coend: A ⊗\\textsubscript{R} B = ∫\\textsuperscript{r} A ⊗ B."
    "\\begin{tikzcd} S(c,c) \\arrow[r, \"\\xi_c\"] & D \\end{tikzcd}"
    "Alap/KategoriaT.idr:385" "https://en.wikipedia.org/wiki/End_(category_theory)",
  -- SZINT 10: TOPOSZ
  BejegyzesKonstruktor 37 "Toposz" "Topos"
    "CCC + részobjektum-osztályozó Ω. A halmazok kategóriája = a prototipikus toposz."
    "CCC + subobject classifier Ω. The category of sets = the prototypical topos."
    "\\begin{tikzcd} M \\arrow[r, hook] & X \\arrow[r, \"\\chi_m\"] & \\Omega \\\\ 1 \\arrow[ur, \"\\text{true}\"'] & & \\end{tikzcd}"
    "Alap/KategoriaT.idr:396" "https://en.wikipedia.org/wiki/Topos",
  BejegyzesKonstruktor 32 "Részobjektum" "Subobject"
    "Monomorfizmus m: M ↣ X. A Sub\\textsubscript{C}(X) kategória objektumai a monok."
    "Monomorphism m: M ↣ X. Objects of Sub\\textsubscript{C}(X) are monos."
    "\\begin{tikzcd} M \\arrow[r, hook, \"m\"] & X \\end{tikzcd}"
    "Alap/KategoriaT.idr:406" "https://en.wikipedia.org/wiki/Subobject",
  BejegyzesKonstruktor 33 "Yoneda beágyazás" "Yoneda embedding"
    "y: C → [C\\textsuperscript{op}, Set]. Hom(-, a) presheaf. Yoneda lemma: Nat(Hom(-,a), F) ≅ F(a)."
    "y: C → [C\\textsuperscript{op}, Set]. Hom(-, a) presheaf. Yoneda lemma: Nat(Hom(-,a), F) ≅ F(a)."
    "\\begin{tikzcd} \\text{Hom}(-, A) \\arrow[r, dashed] \\arrow[dr, \"\\text{eval}_A\"'] & F \\\\ & F(A) \\end{tikzcd}"
    "Alap/KategoriaT.idr:413" "https://en.wikipedia.org/wiki/Yoneda_lemma",
  BejegyzesKonstruktor 34 "Kategóriák ekvivalenciája" "Equivalence of categories"
    "F: C→D, G: D→C, FG ≅ id, GF ≅ id (természetes izomorfizmus). Gyengébb mint izomorfizmus."
    "F: C→D, G: D→C, FG ≅ id, GF ≅ id (natural isomorphism). Weaker than isomorphism."
    "\\begin{tikzcd} \\mathcal{C} \\arrow[r, bend left, \"F\"] & \\mathcal{D} \\arrow[l, bend left, \"G\"'] \\end{tikzcd}"
    "Alap/KategoriaT.idr:423" "https://en.wikipedia.org/wiki/Equivalence_of_categories",
  BejegyzesKonstruktor 36 "Szelet kategória" "Slice category"
    "C/C: objektumok f: X→C, nyilak g: X→X' ha f'∘g = f."
    "C/C: objects f: X→C, arrows g: X→X' if f'∘g = f."
    "\\begin{tikzcd} X \\arrow[r, \"g\"] \\arrow[dr, \"f\"'] & X' \\arrow[d, \"f'\"] \\\\ & C \\end{tikzcd}"
    "Alap/KategoriaT.idr:434" "https://en.wikipedia.org/wiki/Overcategory",
  BejegyzesKonstruktor 38 "Szabad kategória" "Free category"
    "Irányított gráf → kategória (utak kompozíciója). A szabad monoid általánosítása."
    "Directed graph → category (path composition). Generalization of free monoid."
    "\\begin{tikzcd} v_1 \\arrow[r, \"e_1\"] & v_2 \\arrow[r, \"e_2\"] & v_3 \\end{tikzcd}"
    "Alap/KategoriaT.idr:443" "https://en.wikipedia.org/wiki/Free_category",
  BejegyzesKonstruktor 39 "Reprezentálható funktor" "Representable functor"
    "Hom(A, -): C → Set. Minden limeszt megőriz. A Yoneda beágyazás alapja."
    "Hom(A, -): C → Set. Preserves all limits. Foundation of Yoneda embedding."
    "\\begin{tikzcd} A \\arrow[r, \"f\"] & B \\arrow[r, mapsto] & \\text{Hom}(A, B) \\end{tikzcd}"
    "Alap/KategoriaT.idr:452" "https://en.wikipedia.org/wiki/Representable_functor",
  BejegyzesKonstruktor 29 "Csoport egy kategóriában" "Group in a category"
    "Objektum G + szorzás m: G×G→G + egység u + inverz i. Csoport objektum Sets-ben = csoport."
    "Object G + multiplication m: G×G→G + unit u + inverse i. Group object in Sets = group."
    "\\begin{tikzcd} G \\times G \\arrow[r, \"m\"] & G \\\\ 1 \\arrow[r, \"u\"'] & G \\\\ G \\arrow[r, \"i\"'] & G \\end{tikzcd}"
    "Alap/KategoriaT.idr:460" "https://en.wikipedia.org/wiki/Group_object"
 ]

-- ─── LATEX GENERÁLÁS ───────────────────────────────────────

||| LaTeX fejléc.
latexFejlec : String
latexFejlec = unlines [
  "\\documentclass[11pt,a4paper,twocolumn]{article}",
  "\\usepackage[utf8]{inputenc}",
  "\\usepackage[T1]{fontenc}",
  "\\usepackage{amsmath,amssymb,amsthm}",
  "\\usepackage{hyperref}",
  "\\usepackage{geometry}",
  "\\usepackage{booktabs}",
  "\\usepackage{longtable}",
  "\\usepackage{tikz}",
  "\\usetikzlibrary{arrows.meta,positioning}",
  "\\geometry{margin=1.5cm}",
  "",
  "\\newtheorem{tetel}{Tétel}",
  "\\newtheorem{definicio}[tetel]{Definíció}",
  "\\newtheorem{struktura}[tetel]{Struktúra}",
  "",
  "\\title{49 Kategóriaelméleti Struktúra\\\\",
  "\\large Idris 2 Typeclass Hierarchia — Magyar $\\leftrightarrow$ English}",
  "\\author{Ko-tudat: Ember + AI}",
  "\\date{\\today}",
  "",
  "\\begin{document}",
  "\\maketitle",
  "",
  "\\begin{abstract}",
  "Ez a könyv 49 kategóriaelméleti struktúrát mutat be (39 Awodey + 10 Mac Lane),",
  "mindet Idris 2 typeclass-ként implementálva. Magyar bal oldalon, angol jobboldalon,",
  "TikZ commutative diagramokkal. A 15 dimenzió (7 emberi + 7 számítási + 1 perem = [[15,1,3]])",
  "alapján indexelve. A compiler a bíróság: ha fordul, igaz.",
  "\\end{abstract}",
  "",
  "\\tableofcontents",
  "\\newpage",
  "\\onecolumn",
  ""
 ]

||| Egy bejegyzés LaTeX-be konvertálása.
bejegyzesLatex : KonyvBejegyzes -> String
bejegyzesLatex b = unlines [
  "\\begin{struktura}[" ++ show (sorszam b) ++ ". " ++ magyarNev b ++ " / " ++ angolNev b ++ "]",
  "",
  "\\textbf{Magyar:} " ++ magyarLeiras b ++ "\\\\",
  "",
  "\\textbf{English:} " ++ angolLeiras b ++ "\\\\",
  "",
  "\\begin{center}",
  diagram b,
  "\\end{center}",
  "",
  "\\textbf{Kód:} \\texttt{" ++ kodHivatkozas b ++ "}\\\\",
  "\\textbf{Wikipedia:} \\url{" ++ wikipediaLink b ++ "}",
  "",
  "\\end{struktura}",
  "",
  "\\vspace{0.5cm}",
  ""
 ]

||| A 15 dimenzió szekció.
tizenotDimenzioSzekcio : String
tizenotDimenzioSzekcio = unlines [
  "\\section{A 15 Dimenzió}",
  "",
  "A 15 dimenzió = 7 emberi + 7 számítási + 1 perem = [[15,1,3]]:",
  "",
  "\\begin{center}",
  "\\begin{tikzcd}",
  "\\text{Emberi (7)} \\arrow[r, \"\\text{Legendre}\"] & \\text{Perem (1)} \\arrow[r, \"\\text{Legendre}\"'] & \\text{Számítási (7)}",
  "\\end{tikzcd}",
  "\\end{center}",
  "",
  "\\begin{tabular}{lll}",
  "\\toprule",
  "Emberi & Számítási & Perem \\\\",
  "\\midrule",
  "Ido & Utem & p$\\cdot\\dot{q}$ \\\\",
  "Oksag & Vezerles & Legendre \\\\",
  "Ter & Adat & Yoneda \\\\",
  "Szin & Tipus & adjunkció \\\\",
  "Hang & Kapcsolat & \\\\",
  "Fazis & Allapot & \\\\",
  "Mod & Utasitas & \\\\",
  "\\bottomrule",
  "\\end{tabular}",
  "",
  "\\vspace{0.5cm}",
  ""
 ]

||| Élet domainek szekció (Clifford fokozatok).
eletDomainSzekcio : String
eletDomainSzekcio = unlines [
  "\\section{Élet Domainek — Clifford Fokozatok}",
  "",
  "A 15 dimenzió külső szorzatai (wedge products) = élet domainek:",
  "",
  "\\begin{itemize}",
  "\\item Grade 1: 15 alap-dimenzió",
  "\\item Grade 2: bináris kapcsolatok (ok-okozat, tér-idő)",
  "\\item Grade 3: ternáris domainek:",
  "  \\begin{itemize}",
  "  \\item Tudomány = Okság $\\wedge$ Adat $\\wedge$ Tipus",
  "  \\item Művészet = Szín $\\wedge$ Hang $\\wedge$ Mod",
  "  \\item Tánc = Tér $\\wedge$ Ido $\\wedge$ Hang $\\wedge$ Mod",
  "  \\item Játék = Vezerles $\\wedge$ Utasitas $\\wedge$ Allapot",
  "  \\item Sport = Tér $\\wedge$ Utem $\\wedge$ Ero",
  "  \\end{itemize}",
  "\\end{itemize}",
  "",
  "\\vspace{0.5cm}",
  ""
 ]

||| Steane [[7,1,3]] szekció.
steaneSzekcio : String
steaneSzekcio = unlines [
  "\\section{[[7,1,3]] Steane Kód}",
  "",
  "\\begin{tikzcd}",
  "|0\\rangle \\arrow[r, \"\\text{kodol}\"] & |0000000\\rangle \\arrow[r, \"\\text{hiba}\"] & |0001000\\rangle \\arrow[r, \"\\text{javitas}\"] & |0000000\\rangle \\arrow[r, \"\\text{dekodol}\"] & |0\\rangle",
  "\\end{tikzcd}",
  "",
  "A 7 bit: [idő, okság, tér, szín, hang, fázis, mód].",
  "Távolság 3 → 1 hiba javítható.",
  "Noether-tétel: szimmetria = megmaradás. Refl bizonyítva.",
  "",
  "\\vspace{0.5cm}",
  ""
 ]

||| LaTeX lábléc.
latexLablec : String
latexLablec = unlines [
  "\\section{Összefoglalás}",
  "",
  "\\textbf{49 kategóriaelméleti struktúra} (39 Awodey + 10 Mac Lane), mind typeclass.\\\\",
  "\\textbf{15 dimenzió} (7 emberi + 7 számítási + 1 perem = [[15,1,3]]).\\\\",
  "\\textbf{A compiler a bíróság:} ha fordul, igaz.",
  "",
  "\\end{document}"
 ]

||| A teljes LaTeX dokumentum generálása.
latexDokumentum : String
latexDokumentum =
  latexFejlec ++
  tizenotDimenzioSzekcio ++
  eletDomainSzekcio ++
  steaneSzekcio ++
  "\\section{A 49 Struktúra}\\n\\onecolumn\\n" ++
  concat (map bejegyzesLatex negyvenKilencStruktura) ++
  latexLablec

-- ─── FŐPROGRAM ─────────────────────────────────────────────

||| A könyvet a konyv.tex fájlba írja.
konyvFajlbaIr : IO ()
konyvFajlbaIr = do
  putStrLn "Konyv generalasa..."
  putStrLn ("Bejegyzesek szama: " ++ show (length negyvenKilencStruktura))
  -- A LaTeX tartalom kiírása a kimenetre
  -- (a bash script atiranyitja a fajlba)
  putStr latexDokumentum
  putStrLn ""
  putStrLn "Kesz."

||| Főprogram: generálja a LaTeX fájlt.
main : IO ()
main = konyvFajlbaIr