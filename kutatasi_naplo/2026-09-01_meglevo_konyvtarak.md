# Kutatási napló — 2026-09-01 — a meglévő kategóriaelméleti könyvtárak (Coq, Agda, Lean)

## A felhasználó kérdése (szó szerint, §N5)

„ha kell hasznalhatunk coq-ot, agda-t, lean-t is, keressunk meglevo konyvtarakat"

## A §N12 (keress a neten — MCP: brave-search + exa) eredménye — 6 könyvtár

### 1. agda-categories (Agda — a LEGÉRETTEBB)
- URL: https://github.com/agda/agda-categories
- Szerzők: Hu & Carette (CPP 2021, arXiv:2005.07059)
- 404 csillag, 78 fork, MIT licenc
- Tartalom: Adjoint, Object, Morphism, Diagram, Functor, Kan, Yoneda + Enriched, Bicategories, Bifunctors + Complete, Cocomplete, Closed, Cartesian, CartesianClosed, Discrete, Finite, Monoidal, Product, Slice, Topos, WithFamilies
- Különlegesség: proof-relevant (nem proof-irrelevant), Setoid-enriched (a bicategory ízek), --without-K és --safe

### 2. agda-unimath (Agda — a LEGÁTFOGÓBB)
- URL: https://unimath.github.io/agda-unimath/SUMMARY.html
- Tartalom: Adjunctions (precategories, large categories), Algebras over monads, Anafunctors, Coalgebras over comonads, Codensity monads, Colimits, Left/Right Kan extensions, Limits, Monads, Monomorphisms, Yoneda lemma (categories + precategories), Categories of functors/natural transformations, The augmented simplex category, The category of simplicial sets
- Különlegesség: Univalent Foundations (UniMath) — a univalencia axióma

### 3. Cat_on_Coq (Coq)
- URL: https://github.com/mathink/Cat_on_Coq.git
- Tartalom: Base/ (Setoid, Category, Functor, Natural Transformation), Cons/ (Initial/Terminal, Products/Coproducts, Equalizers/Coequalizers, Exponentials), Limit/ (Limits, Colimits), Adj/ (Adjunctions, Product-Exponential Adjunction), KanExt/ (Left/Right Kan Extensions, Connection to Limits/Colimits), Rep/ (Yoneda Lemma), CCC/ (Cartesian closed categories), Monad/ (Monads, Connection to Adjunctions)
- Különlegesség: setoid-alapú (konstruktív), Coq universe polymorphism

### 4. amintimany/Categories (Coq)
- URL: https://github.com/amintimany/Categories
- Tartalom: Adjunction, Algebras, Category, Functor, KanExt, Limits, Monad, NatTrans, PreSheaf, Topos, Yoneda

### 5. Mathlib (Lean 4) — a Lean standard könyvtár
- URL: https://leanprover-community.github.io/mathlib4_docs/Mathlib/CategoryTheory/Adjunction/Basic.html
- Tartalom: CategoryTheory.Adjunction (mk', mkOfHomEquiv, compYonedaIso, compCoyonedaIso, leftAdjointOfEquiv, rightAdjointOfEquiv, Equivalence.toAdjunction) + CategoryTheory.Monad.Adjunction + Limits (a bal-adjunktusok kolimit-eket, a jobb-adjunktusok limit-eket megőriznek)
- Különlegesség: a Lean Mathlib hivatalos része, a legnagyobb matematikai könyvtár

### 6. catagi (Lean 4) — Categories for AGI! (a LEGKÖZELEBB a projekt céljához)
- URL: https://github.com/sridharmahadevan/catagi
- Szerző: Sridhar Mahadevan (UMass, „Categories for AGI")
- Tartalom (25 modul): BasicCategory, Functors, AdjointFunctors (RAPL/LAPC), Diagrams (Limits, Kan extensions), MonoidalEnriched, YonedaAttention (az attention mint enriched Yoneda — strukturális analógia!), ToposCausal (topos-ok és ok-okozati modellek), CausalFunctors (Kan extensions via yoneda.lan, Heyting implication on sieves), CausalDensity (Radon-Nikodym / Kan duality), LearnCategory (quotient types), TransformerCategory (Transformer & LLM categories), UniversalDecision (UDMs, information fields, Witsenhausen), GrothendieckSite (sieves, Grothendieck topologies, subobject-classifier semantics)
- Különlegesség: EZ A LEGKÖZELEBB a projekt céljához — a kategóriaelmélet AGI-re történő alkalmazása!

### Bónusz: fredefox/cat (Cubical Agda)
- URL: https://github.com/fredefox/cat
- Tartalom: kategóriaelmélet Cubical Agda-ban (univalenciával)

## A lefedettség elemzése

A 50 kategóriaelméleti fogalom (a GrafKeretrendszerTerv XIII. fejezete szerint) lefedettsége:

| Fogalomcsalád | agda-categories | agda-unimath | Cat_on_Coq | amintimany | Mathlib | catagi |
|---|---|---|---|---|---|---|
| Kategória, Funktor, NatTransz | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Adjunkció | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Yoneda | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ (attention!) |
| Kan-kiterjesztés | ✓ | ✓ (L/R) | ✓ | ✓ | ✓ | ✓ (causal!) |
| Monad | ✓ | ✓ | ✓ | ✓ | ✓ | (coalgebra) |
| Comonad | (enriched) | ✓ | (coalgebra) | — | — | ✓ |
| Limit/Kolimit | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ (finite limits) |
| Toposz | ✓ | — | ✓ (CCC) | ✓ | — | ✓ (causal!) |
| Bikategória | ✓ | — | — | — | — | — |
| Dagger/Kompakt zárt | — | — | — | — | — | — |

A dagger/kompakt zárt kategóriák (a CPT/E8×E8×E8/Fano kapcsolat!) NINCSSENEK egyetlen könyvtárban sem — ezeket a projekt SAJÁT magának kell implementálnia.

## A döntés

A projekt Idris2-ben van (a hard rule szerint). A meglévő könyvtárak KONCEPCIÓIT és BIZONYÍTÁS-STRUKTÚRÁIT adaptáljuk:
- az agda-categories proof-relevant Setoid-enriched megközelítése (a KategoriaElmelet.idr-hez)
- a catagi YonedaAttention + ToposCausal koncepciói (a gráf kutatási keretrendszerhez — EZ A LEGINSPIRÁLÓBB)
- a Cat_on_Coq setoid-alapú limit/kolimit/adjunction/KanExt/Yoneda struktúrája (a 34 hiányzó fogalomhoz)

A dagger/kompakt zárt kategóriákat (a CPT/E8×E8×E8/Fano kapcsolat!) a projekt SAJÁT magának implementálja — ez a projekt EREDETI hozzájárulása.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★