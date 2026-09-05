# 64-Noun Stabilizer Code — szerkezeti index / 结构索引

**Készült:** 2026-09-05  **|**  **Generátor:** `64noun_index_generator.awk` (awk, a kandel_index_generator.awk mintájára)  **|**  **Forrás:** `source/deepseekPage/paper/chapters/` (ch1-3 … ch16-18, 11 120 sor)

**Magyar:** A «The 64-Noun Stabilizer Code» könyv hat LaTeX-fejezetfájljának
teljes szerkezeti indexe: fejezet-jelölők, szakaszok, alszakaszok, tételek,
definíciók, lemmák, következmények, propozíciók, táblázatok, címkés egyenletek,
összefoglaló-dobozok és bizonyítások — egy Markdown-táblázatban, fájlonként és
sorszámmonként rendezve. A «Címke» oszlop a `\label{...}` tartalmát hordozza,
ezért az index grep-pel szűrhető az előtagok szerint (thm, def, eq, tab, sec,
lem, cor, prop — kettőponttal a sorokban).

**中文：** 本书（《64-名词稳定子码》）六个 LaTeX 章节文件的结构索引：章节标记、
小节、定理、定义、引理、推论、命题、表格、带标签的公式、总结框与证明，
按文件与行号排序，可用 grep 按标签前缀过滤。

**Deutsch:** Struktureller Index der sechs LaTeX-Kapiteldateien des Buches
«The 64-Noun Stabilizer Code»: Kapitelmarkierungen, Abschnitte, Theoreme,
Definitionen, Lemmata, Korollare, Propositionen, Tabellen, bezeichnete
Gleichungen, Zusammenfassungsboxen und Beweise — per grep nach Präfix filterbar.

**עברית:** מפתח מבני של ששת קובצי הפרקים ב-LaTeX של הספר: סימוני פרקים, סעיפים,
משפטים, הגדרות, למות, מסקנות, טבלאות, משוואות מתויגות והוכחות — ניתן לסינון ב-grep.

Példa szűrés: `grep 'eq:' 64noun_index.md` → az összes címkés egyenlet.

| Fájl | Sor | Típus | Címke | Tartalom |
|------|----:|-------|-------|----------|
| ch1-3.tex | 15 | fejezet |  | CHAPTER 1: THE 64-NOUN STABILIZER CODE |
| ch1-3.tex | 18 | szakasz | sec:ch1 | The 64-Noun Stabilizer Code: Hungarian Grammar as a Quantum Error-Correcting Cod… |
| ch1-3.tex | 21 | alszakasz |  | Introduction |
| ch1-3.tex | 37 | alszakasz |  | The 6 Morphological Features as Binary Observables |
| ch1-3.tex | 59 | táblázat | tab:features | The six morphological features and their binary values. |
| ch1-3.tex | 67 | egyenlet | eq:state | \/ = \/v,d,n,t,m,p, v,d,n,t,m,p 0,1 |
| ch1-3.tex | 75 | alszakasz |  | The Steane 7,1,3 Code |
| ch1-3.tex | 89 | egyenlet | eq:pauli | I = 1 & 0 0 & 1 , X = 0 & 1 1 & 0 , Z = 1 & 0 0 & -1 , Y = iXZ = 0 & -i i & 0 |
| ch1-3.tex | 104 | egyenlet | eq:generators | g_1 &= I I I I X X X & (IIIIXXX) g_2 &= I I X X I I X & (IIXXIIX) g_3 &= I X I X… |
| ch1-3.tex | 110 | egyenlet | eq:stabilizer | S = g_1, g_2, g_3, g_4, g_5, g_6 |
| ch1-3.tex | 120 | egyenlet | eq:codespace | C = \/ H : g_i \/ = \/,; i = 1,,6 |
| ch1-3.tex | 126 | alszakasz |  | Algebraic Structure of the Stabilizer Group |
| ch1-3.tex | 132 | egyenlet | eq:z2six | S Z_2^6 |
| ch1-3.tex | 138 | egyenlet | eq:commute | P Q = (-1)^(P,Q) Q P, (P,Q) 0,1 |
| ch1-3.tex | 147 | egyenlet | eq:normalizer | N(S) = P P_7 : P S P^ = S |
| ch1-3.tex | 152 | alszakasz |  | Functorial Mapping: Hungarian Morphology to Hilbert Space |
| ch1-3.tex | 158 | egyenlet | eq:functor | F: HungarianMorph Hilb |
| ch1-3.tex | 167 | egyenlet | eq:functor_obj | F(stem) = (C^2)^ 7 |
| ch1-3.tex | 180 | egyenlet | eq:functor_morph | F(v = 1) &= X_1 (front vowel) F(d = 1) &= X_2 (definite) F(n = 1) &= X_3 (plural… |
| ch1-3.tex | 187 | alszakasz |  | The 64 Morphological States as Stabilizer Elements |
| ch1-3.tex | 196 | egyenlet | eq:stab_element | S(v,d,n,t,m,p) = g_1^v g_2^d g_3^n g_4^t g_5^m g_6^p |
| ch1-3.tex | 213 | alszakasz |  | Pauli Matrices and their Grammatical Semantics |
| ch1-3.tex | 237 | alszakasz |  | Agglutination as Function Composition |
| ch1-3.tex | 250 | egyenlet | eq:comp | w = _k _k-1 _1 (s) |
| ch1-3.tex | 268 | táblázat | tab:slots | The Hungarian noun agglutination template (4 morpheme slots). |
| ch1-3.tex | 274 | egyenlet | eq:example | h'az-a-i-k-ban = INESSIVE PLURAL POSS.3PL (STEM_back) |
| ch1-3.tex | 283 | egyenlet | eq:functor_comp | F(_k _1(s)) = F(_k) F(_1) \/_s |
| ch1-3.tex | 288 | alszakasz |  | The 18 Noun Cases as Spatial Relations |
| ch1-3.tex | 324 | táblázat | tab:cases | The 18 Hungarian noun cases, grouped by spatial triad. |
| ch1-3.tex | 332 | alszakasz |  | Definite vs. Indefinite Conjugation: Two Parallel Tracks |
| ch1-3.tex | 355 | táblázat | tab:defconj | Definite vs. indefinite conjugation of l'at (to see), present tense. |
| ch1-3.tex | 366 | egyenlet | eq:ortho | \/_indef \/_def in the second tensor factor |
| ch1-3.tex | 375 | alszakasz |  | The Cognitive Error-Correction Hypothesis |
| ch1-3.tex | 400 | alszakasz |  | Formal Proof: The Stabilizer Algebra of Hungarian Morphology |
| ch1-3.tex | 411 | egyenlet | eq:logical | \/0_L = 18 _x C_0 \/x, \/1_L = 18 _x C_1 \/x |
| ch1-3.tex | 423 | egyenlet | eq:css_map | \/v,d,n,t,m,p \/x where x satisfies all 6 parity checks |
| ch1-3.tex | 432 | bizonyítás |  | The 6-feature system forms a CSS stabilizer code. |
| ch1-3.tex | 441 | egyenlet | eq:logical_ops | X &= X^ 7 (bitwise flip on all 7 qubits) Z &= Z^ 7 (phase flip on all 7 qubits) |
| ch1-3.tex | 447 | alszakasz |  | The Bloch Sphere of a Hungarian Noun |
| ch1-3.tex | 453 | egyenlet | eq:bloch | \/ = 2 \/0 + e^i 2 \/1 |
| ch1-3.tex | 470 | alszakasz |  | Summary of Chapter 1 |
| ch1-3.tex | 493 | fejezet |  | CHAPTER 2: CATEGORY THEORY FOUNDATIONS |
| ch1-3.tex | 496 | szakasz | sec:ch2 | Category Theory Foundations for the Hungarian Stabilizer Code |
| ch1-3.tex | 499 | alszakasz |  | Introduction: Why Category Theory? |
| ch1-3.tex | 518 | alszakasz |  | The 34 Fundamental Concepts |
| ch1-3.tex | 611 | alszakasz |  | 9 Dual Pairs and 16 Self-Dual Concepts |
| ch1-3.tex | 636 | táblázat | tab:dual_pairs | The 9 dual pairs of category-theoretic concepts. |
| ch1-3.tex | 645 | alszakasz |  | Dual Involution: Proof that dual(dual(c)) = c for All 34 Concepts |
| ch1-3.tex | 652 | tétel |  | Dual Involution |
| ch1-3.tex | 730 | bizonyítás |  | Case 1: Self-dual concepts (16 cases). For any self-dual concept c, we have dual… |
| ch1-3.tex | 732 | alszakasz |  | The Free Cofree Adjunction |
| ch1-3.tex | 740 | egyenlet | eq:free_forget | Free_k: Set Vect_k : U |
| ch1-3.tex | 762 | egyenlet | eq:triangle | _Free_k(X) Free_k(_X) &= id_Free_k(X) U(_V) _U(V) &= id_U(V) |
| ch1-3.tex | 773 | bizonyítás |  | Proof of triangle identities |
| ch1-3.tex | 785 | egyenlet | eq:monad1 | _X _T(X) = id_T(X) |
| ch1-3.tex | 791 | egyenlet | eq:monad2 | _X T(_X) = id_T(X) |
| ch1-3.tex | 797 | egyenlet | eq:monad3 | _X T(_X) = _X _T(X) |
| ch1-3.tex | 806 | bizonyítás |  | Proof of Monad Law 1 (Left Unit) |
| ch1-3.tex | 816 | bizonyítás |  | Proof of Monad Law 2 (Right Unit) |
| ch1-3.tex | 830 | bizonyítás |  | Proof of Monad Law 3 (Associativity) |
| ch1-3.tex | 832 | alszakasz |  | Comonad Laws (Dual) |
| ch1-3.tex | 841 | egyenlet | eq:comonad1 | _W(V) _V = id_W(V) |
| ch1-3.tex | 847 | egyenlet | eq:comonad2 | W(_V) _V = id_W(V) |
| ch1-3.tex | 853 | egyenlet | eq:comonad3 | _W(V) _V = W(_V) _V |
| ch1-3.tex | 858 | alszakasz |  | The Steane Code in Categorical Language |
| ch1-3.tex | 877 | egyenlet | eq:logical_count | \/L\/ = \/N(S)\/ - \/S\/ = 256 - 64 = 192 |
| ch1-3.tex | 890 | egyenlet | eq:pauli_group | \/P_7\/ = 4 4^7 = 4^8 = 65536 |
| ch1-3.tex | 902 | alszakasz |  | The Cubic Structure: 7^3 = 343 |
| ch1-3.tex | 918 | egyenlet | eq:343_minus_64 | 343 - 64 = 279 |
| ch1-3.tex | 933 | alszakasz |  | PSL(2,7): The Simple Group of Order 168 |
| ch1-3.tex | 943 | egyenlet | eq:psl_order | \/PSL(2,7)\/ = (7^2-1)(7^2-7)(7-1) (2,7-1) = 48 426 1 = 20166 12 = 168 |
| ch1-3.tex | 949 | egyenlet | eq:168_factor | 168 = 2^3 3 7 |
| ch1-3.tex | 963 | alszakasz |  | The E8 Root System: \/E_8\/ = 240 |
| ch1-3.tex | 971 | egyenlet | eq:e8 | \/E_8 roots\/ = 240 = 2^4 3 5 |
| ch1-3.tex | 982 | egyenlet | eq:containment | PSL(2,7) Sp(6,2) SO(7) E_8 |
| ch1-3.tex | 987 | alszakasz |  | Compact Closed Category of Hungarian Morphology |
| ch1-3.tex | 998 | egyenlet | eq:compact_closed | _A &: I A^* A (cup / unit) _A &: A A^* I (cap / counit) |
| ch1-3.tex | 1014 | tétel |  | Snake Involution |
| ch1-3.tex | 1022 | egyenlet | eq:compact_adj | C(A B, C) C(B, A^* C) |
| ch1-3.tex | 1027 | egyenlet | eq:double_dual | A A^** |
| ch1-3.tex | 1033 | bizonyítás |  | In a compact closed category C, the dual A^* is both a left and right dual of A.… |
| ch1-3.tex | 1055 | alszakasz |  | The Yoneda Lemma |
| ch1-3.tex | 1064 | egyenlet | eq:yoneda | Nat(Hom_C(-, A), F) F(A) |
| ch1-3.tex | 1066 | tétel |  | Yoneda Lemma |
| ch1-3.tex | 1089 | bizonyítás |  | Yoneda Lemma (homHasId, yonedaNonEmpty) |
| ch1-3.tex | 1099 | alszakasz |  | Summary of Chapter 2 |
| ch1-3.tex | 1126 | fejezet |  | CHAPTER 3: 2D TIME AND THE MANHATTAN PROJECT MARTIANS |
| ch1-3.tex | 1129 | szakasz | sec:ch3 | 2D Time and the Manhattan Project Martians: The Grammar of Genius |
| ch1-3.tex | 1132 | alszakasz |  | Introduction: The Fermi Paradox in Miniature |
| ch1-3.tex | 1152 | alszakasz |  | 1D Time: The English Grammatical Model |
| ch1-3.tex | 1160 | egyenlet | eq:1d_time | Past Present Future |
| ch1-3.tex | 1176 | alszakasz |  | 2D Time: The Hungarian Grammatical Model |
| ch1-3.tex | 1198 | táblázat | tab:2d_time | The 2D time-plane of Hungarian grammar: 4 quadrants. |
| ch1-3.tex | 1219 | alszakasz |  | Percolation Theory and the 2D Advantage |
| ch1-3.tex | 1229 | egyenlet | eq:percolation | p_c(1D) = 1, p_c(2D) 0.5 |
| ch1-3.tex | 1252 | alszakasz |  | The Martians: Four Case Studies |
| ch1-3.tex | 1343 | alszakasz |  | The Complete List of Hungarian Nobel Laureates and Notable Scientists |
| ch1-3.tex | 1375 | táblázat | tab:nobel | Hungarian Nobel laureates and notable scientists. |
| ch1-3.tex | 1410 | alszakasz |  | Fermi's Joke and Its Mathematical Content |
| ch1-3.tex | 1433 | alszakasz |  | Hungarian = A Stabilizer Computer Bootstrapped from Age 2 |
| ch1-3.tex | 1481 | alszakasz |  | Formal Model: The Hungarian Stabilizer Computer |
| ch1-3.tex | 1496 | definíció |  | Hungarian Stabilizer Computer (HSC) |
| ch1-3.tex | 1512 | alszakasz |  | Connections to Other Grammatical Features |
| ch1-3.tex | 1536 | alszakasz |  | Empirical Predictions |
| ch1-3.tex | 1570 | alszakasz |  | Objections and Limitations |
| ch1-3.tex | 1612 | alszakasz |  | Conclusion: The Grammar of Genius |
| ch4-6.tex | 9 | fejezet |  | CHAPTER 4: CRITICAL EXPONENTS AND AI ARCHITECTURE |
| ch4-6.tex | 12 | szakasz |  | Critical Exponents and AI Architecture |
| ch4-6.tex | 14 | alszakasz |  | Introduction: The Renormalisation Group as a Design Principle |
| ch4-6.tex | 35 | alszakasz |  | The 3D Ising Critical Exponents at Six Sigma |
| ch4-6.tex | 71 | alszakasz |  | Verification of Scaling Relations |
| ch4-6.tex | 151 | alszakasz |  | Derivation of AI Architecture Parameters |
| ch4-6.tex | 334 | alszakasz |  | Weight Matrix Architecture |
| ch4-6.tex | 439 | alszakasz |  | Theoretical Minimum Loss |
| ch4-6.tex | 620 | alszakasz |  | The Hungarian Vowel Harmony Connection |
| ch4-6.tex | 657 | alszakasz |  | The Group PSL(2,7) and the Architecture |
| ch4-6.tex | 678 | alszakasz |  | Summary: Architecture Without Training |
| ch4-6.tex | 705 | táblázat | tab:arch_params | Architecture parameters derived from critical exponents |
| ch4-6.tex | 725 | összefoglaló-doboz |  | The 3D Ising critical exponents measured at six-sigma precision (=0.11008(1), =0… |
| ch4-6.tex | 783 | fejezet |  | CHAPTER 5: KANT, CONSCIOUSNESS, AND THE 7x7 FREE CATEGORY |
| ch4-6.tex | 786 | szakasz |  | Kant, Consciousness, and the 7 7 Free Category |
| ch4-6.tex | 788 | alszakasz |  | Introduction: Kant's Architectonic as a Generative Grammar |
| ch4-6.tex | 805 | alszakasz |  | The Twelve Categories of the Understanding |
| ch4-6.tex | 832 | alszakasz |  | From 12 Categories to 6 Generators |
| ch4-6.tex | 880 | alszakasz |  | The Table of Judgments: Before the Categories |
| ch4-6.tex | 905 | alszakasz |  | Transcendental Aesthetic: Space and Time |
| ch4-6.tex | 940 | alszakasz |  | The Threefold Synthesis |
| ch4-6.tex | 970 | alszakasz |  | The Five Concept Levels and Horgony S0--S6 |
| ch4-6.tex | 996 | alszakasz |  | Cogito Ergo Sum: The Identity Stabiliser |
| ch4-6.tex | 1033 | alszakasz |  | The Free Category on the Fano Plane |
| ch4-6.tex | 1082 | alszakasz |  | CP Violation and Time-Asymmetric Agglutination |
| ch4-6.tex | 1118 | alszakasz |  | Mac Lane, nLab, and the Category Theory Connection |
| ch4-6.tex | 1181 | alszakasz |  | The 49th = Cogito as the Accompaniment |
| ch4-6.tex | 1202 | alszakasz |  | CP Violation in Detail |
| ch4-6.tex | 1224 | alszakasz |  | Summary: Kant Meets Category Theory |
| ch4-6.tex | 1249 | összefoglaló-doboz |  | Kant's 12 categories of understanding (Quantity, Quality, Relation, Modality, ea… |
| ch4-6.tex | 1308 | fejezet |  | CHAPTER 6: GUT FIXED POINT, CPT SYMMETRY, AND PERCOLATION |
| ch4-6.tex | 1311 | szakasz |  | GUT Fixed Point, CPT Symmetry, and Percolation |
| ch4-6.tex | 1313 | alszakasz |  | Introduction: Unification at the Critical Point |
| ch4-6.tex | 1333 | alszakasz |  | The SU(5) Grand Unified Theory |
| ch4-6.tex | 1358 | alszakasz |  | Mapping the 6 Generators to the Gauge Group |
| ch4-6.tex | 1403 | alszakasz |  | The Higgs Mechanism as the Tense Generator |
| ch4-6.tex | 1432 | alszakasz |  | The GUT Fixed Point: Equal-Weight Generators |
| ch4-6.tex | 1456 | alszakasz |  | CPT Theorem: C, P, T as Bit-Flips |
| ch4-6.tex | 1577 | alszakasz |  | Percolation Theory and Time Structure |
| ch4-6.tex | 1614 | alszakasz |  | 2D Ising Exact Solution and Hungarian Time-Plane Exponents |
| ch4-6.tex | 1647 | alszakasz |  | Algebra Duality: Self-Dual Operations and Time Reversal |
| ch4-6.tex | 1679 | alszakasz |  | Information Flow: Creation and Compression |
| ch4-6.tex | 1707 | alszakasz |  | Minimum Description Length and Algorithmic Information |
| ch4-6.tex | 1729 | alszakasz |  | Entropy Duality: From Big Bang to Heat Death |
| ch4-6.tex | 1773 | alszakasz |  | First-Order Phase Transition Through a (d-1) Fixed Point |
| ch4-6.tex | 1794 | alszakasz |  | Explosion and Contraction: The Free Category Duality |
| ch4-6.tex | 1815 | alszakasz |  | The Goldstone Mode: Identity Verb to Noun |
| ch4-6.tex | 1847 | alszakasz | sec:ccc | Penrose Conformal Cyclic Cosmology |
| ch4-6.tex | 1874 | alszakasz |  | The Gauge Coupling Unification Details |
| ch4-6.tex | 1913 | alszakasz |  | Summary: The Unification of All Forces at the GUT Fixed Point |
| ch4-6.tex | 1952 | összefoglaló-doboz |  | The six Horgony generators g_1,,g_6 map to the gauge group of the Standard Model… |
| ch7-9.tex | 9 | fejezet |  | CHAPTER 7: UNIT QUATERNION EXTENSION AND DIMENSIONAL REDUCTION |
| ch7-9.tex | 12 | szakasz | sec:quaternion-extension | Unit Quaternion Extension and Dimensional Reduction |
| ch7-9.tex | 15 | alszakasz |  | Motivations and Historical Context |
| ch7-9.tex | 91 | alszakasz |  | Quaternion Algebra: Formal Definitions |
| ch7-9.tex | 139 | alszakasz |  | The Unit Quaternion Group SU(2) and the Double Cover of SO(3) |
| ch7-9.tex | 168 | egyenlet | eq:exp-map | q = 2 + 2,n, |
| ch7-9.tex | 201 | alszakasz |  | Mean Field Theory and the Upper Critical Dimension |
| ch7-9.tex | 219 | egyenlet | eq:self-consistency | m = ( J z m). |
| ch7-9.tex | 243 | egyenlet | eq:ginzburg | ( m)^2 m^2 1 ^4-d const. |
| ch7-9.tex | 292 | alszakasz |  | Dimensional Reduction as Spontaneous Symmetry Breaking |
| ch7-9.tex | 300 | egyenlet | eq:state-pre-ssb | State count (pre-SSB) = 2^6 = 64. |
| ch7-9.tex | 331 | egyenlet | eq:state-post-ssb | State count (post-SSB) = 3^7 = 3 3 3 3 3 3 3 = 2187. |
| ch7-9.tex | 367 | alszakasz |  | The Quaternion Multiplication Table as Verb Composition |
| ch7-9.tex | 415 | alszakasz |  | O(4) O(3) Symmetry Breaking and the Higgs Mechanism |
| ch7-9.tex | 471 | alszakasz |  | Krausz Ferenc and the Attosecond Z-Eigenvalue |
| ch7-9.tex | 522 | alszakasz |  | The Quaternion State Machine and Discourse Trajectories |
| ch7-9.tex | 550 | alszakasz |  | Summary and Physical Interpretation of Chapter 7 |
| ch7-9.tex | 579 | fejezet |  | CHAPTER 8: THREE-LANGUAGE GRAMMAR COLLAPSE AND SU(3) SYMMETRY |
| ch7-9.tex | 582 | szakasz | sec:grammar-collapse | Three-Language Grammar Collapse and SU(3) Symmetry |
| ch7-9.tex | 585 | alszakasz |  | Three Languages as Three Colors of SU(3) |
| ch7-9.tex | 629 | alszakasz |  | The Stabilizer Code: Universality of the 64-Noun Core |
| ch7-9.tex | 663 | alszakasz |  | Hungarian: Red, the Dense Agglutinative Matrix |
| ch7-9.tex | 747 | alszakasz |  | Chinese: Green, the Sparse Mixture-of-Experts Architecture |
| ch7-9.tex | 804 | alszakasz |  | English: Blue, the Curved One-Dimensional Manifold |
| ch7-9.tex | 862 | alszakasz |  | Comparative Grammar Architecture Table |
| ch7-9.tex | 918 | táblázat | tab:grammar-comparison | Three-Language Grammar Architecture Comparison |
| ch7-9.tex | 920 | alszakasz |  | 2D Time vs. 1D Time: Cognitive Implications |
| ch7-9.tex | 952 | alszakasz |  | The Grammatical Core Is Identical: Evidence from Translation |
| ch7-9.tex | 982 | alszakasz |  | Cognitive Signatures and the Sapir-Whorf Hypothesis Revisited |
| ch7-9.tex | 1017 | alszakasz |  | Summary and Synthesis of Chapter 8 |
| ch7-9.tex | 1041 | fejezet |  | CHAPTER 9: THE HUNGARIAN NOBEL LAUREATES |
| ch7-9.tex | 1044 | szakasz | sec:nobel-laureates | The Hungarian Nobel Laureates: Complete Biographical Analysis |
| ch7-9.tex | 1047 | alszakasz |  | Introduction: The Hungarian Puzzle |
| ch7-9.tex | 1079 | táblázat | tab:nobel-per-capita | Per-Capita Nobel Prize Rankings |
| ch7-9.tex | 1098 | alszakasz |  | The Fasori Lutheran Gymnasium and the Budapest Miracle |
| ch7-9.tex | 1123 | alszakasz |  | Complete Biographical Profiles of the Nobel Laureates |
| ch7-9.tex | 1432 | alszakasz |  | Non-Nobel Hungarians of Nobel Calibre |
| ch7-9.tex | 1553 | alszakasz |  | The Budapest Ecosystem: Why Hungary? |
| ch7-9.tex | 1586 | alszakasz |  | Field Distribution and Statistical Analysis |
| ch7-9.tex | 1599 | alszakasz |  | Grammatical Feature to Nobel Mapping |
| ch7-9.tex | 1659 | táblázat | tab:grammar-nobel | Grammatical Feature to Nobel Prize Mapping |
| ch7-9.tex | 1661 | alszakasz |  | Implications for Cognitive Science and Education |
| ch7-9.tex | 1680 | alszakasz |  | Summary and Tripartite Integration |
| ch10-12.tex | 1 | szakasz |  | Idris Formal Proofs — Converted to Mathematical Notation |
| ch10-12.tex | 3 | alszakasz |  | DUAL INVOLUTION (34 Proofs) |
| ch10-12.tex | 11 | definíció |  | Let = Category, Functor, NatTrans, Adjunction, Monoidal, Dagger, CompactClosed, … |
| ch10-12.tex | 15 | tétel | thm:dual-cat | Dual Involution — Category |
| ch10-12.tex | 21 | bizonyítás |  | (Category) = Category^ reverses all arrows. A single category considered as a co… |
| ch10-12.tex | 25 | tétel | thm:dual-functor | Dual Involution — Functor |
| ch10-12.tex | 31 | bizonyítás |  | A functor F: induces a functor F^: ^ ^. Applying duality twice returns the origi… |
| ch10-12.tex | 35 | tétel | thm:dual-nat | Dual Involution — Natural Transformation |
| ch10-12.tex | 41 | bizonyítás |  | A natural transformation : F G between functors F,G: has a dual ^: G^ F^ between… |
| ch10-12.tex | 45 | tétel | thm:dual-adj | Dual Involution — Adjunction |
| ch10-12.tex | 51 | bizonyítás |  | An adjunction F G with F: , G: dualizes to G^ F^ with G^: ^ ^, F^: ^ ^. The unit… |
| ch10-12.tex | 55 | tétel | thm:dual-monoidal | Dual Involution — Monoidal |
| ch10-12.tex | 61 | bizonyítás |  | A monoidal category (, , I, , , ) dualizes to (^, ^, I, ^-1, ^-1, ^-1) which is … |
| ch10-12.tex | 65 | tétel | thm:dual-dagger | Dual Involution — Dagger |
| ch10-12.tex | 71 | bizonyítás |  | A dagger category has an involution : ^ that is identity on objects. Duality sen… |
| ch10-12.tex | 75 | tétel | thm:dual-cc | Dual Involution — CompactClosed |
| ch10-12.tex | 81 | bizonyítás |  | In a compact closed category, every object A has a dual A^* with unit _A: I A^* … |
| ch10-12.tex | 85 | tétel | thm:dual-ncat | Dual Involution — 2Category, 3Category, NCategory |
| ch10-12.tex | 91 | bizonyítás |  | A 2-category has objects, 1-morphisms, and 2-morphisms. Duality reverses k-morph… |
| ch10-12.tex | 95 | tétel | thm:dual-cob | Dual Involution — Cobordism |
| ch10-12.tex | 101 | bizonyítás |  | The cobordism category nCob has (n-1)-manifolds as objects and n-cobordisms as m… |
| ch10-12.tex | 105 | tétel | thm:dual-tqft | Dual Involution — TQFT |
| ch10-12.tex | 111 | bizonyítás |  | A TQFT is a symmetric monoidal functor Z: nCob . Its dual Z^: nCob^ ^ (since is … |
| ch10-12.tex | 115 | tétel | thm:dual-string | Dual Involution — StringDiagram |
| ch10-12.tex | 121 | bizonyítás |  | String diagrams in a monoidal category are invariant under topological deformati… |
| ch10-12.tex | 125 | tétel | thm:dual-limcolim | Dual Involution — Limit Colimit |
| ch10-12.tex | 131 | bizonyítás |  | A limit of a diagram D: is a terminal object in the category of cones over D. In… |
| ch10-12.tex | 135 | tétel | thm:dual-moncom | Dual Involution — Monad Comonad |
| ch10-12.tex | 141 | bizonyítás |  | A monad (T, , ) on consists of T: , : 1_ T, : T^2 T. In ^, the directions revers… |
| ch10-12.tex | 145 | tétel | thm:dual-kan | Dual Involution — KanExtension Lift |
| ch10-12.tex | 151 | bizonyítás |  | A left Kan extension of F: along K: is a functor Lan_K F: with a universal natur… |
| ch10-12.tex | 155 | tétel | thm:dual-prod | Dual Involution — Product Coproduct |
| ch10-12.tex | 161 | bizonyítás |  | A product A B in is characterized by projections _A: A B A, _B: A B B. In ^, the… |
| ch10-12.tex | 165 | tétel | thm:dual-exp | Dual Involution — Exponential InternalHom |
| ch10-12.tex | 171 | bizonyítás |  | In a cartesian closed category, the exponential B^A satisfies _(C A, B) _(C, B^A… |
| ch10-12.tex | 175 | tétel | thm:dual-init | Dual Involution — Initial Terminal |
| ch10-12.tex | 181 | bizonyítás |  | An initial object 0 has a unique morphism to every object. In ^, this becomes a … |
| ch10-12.tex | 185 | tétel | thm:dual-presheaf | Dual Involution — Presheaf Sheaf (via Site) |
| ch10-12.tex | 191 | bizonyítás |  | A presheaf on is a functor ^ . A sheaf is a presheaf satisfying a gluing conditi… |
| ch10-12.tex | 195 | tétel | thm:dual-yoneda | Dual Involution — Yoneda |
| ch10-12.tex | 201 | bizonyítás |  | The Yoneda embedding y: ^, sends A _(-, A). Under duality, y^: ^ , ^ is the co-Y… |
| ch10-12.tex | 205 | tétel | thm:dual-quot | Dual Involution — Quotient |
| ch10-12.tex | 211 | bizonyítás |  | A quotient object is the dual of a subobject. However, the concept Quotient itse… |
| ch10-12.tex | 215 | tétel | thm:dual-sub | Dual Involution — Subobject |
| ch10-12.tex | 221 | bizonyítás |  | A subobject is an equivalence class of monomorphisms into an object. Dually, a q… |
| ch10-12.tex | 225 | tétel | thm:dual-duality | Dual Involution — Duality |
| ch10-12.tex | 231 | bizonyítás |  | The concept Duality itself represents the operation of taking duals. Applying du… |
| ch10-12.tex | 235 | tétel | thm:dual-site | Dual Involution — Site |
| ch10-12.tex | 241 | bizonyítás |  | A site (, J) consists of a category and a Grothendieck topology. The dual site i… |
| ch10-12.tex | 245 | tétel | thm:dual-topos | Dual Involution — Topos |
| ch10-12.tex | 251 | bizonyítás |  | A topos is a cartesian closed category with a subobject classifier. The dual of … |
| ch10-12.tex | 255 | tétel | thm:dual-rep | Dual Involution — Representable |
| ch10-12.tex | 261 | bizonyítás |  | A representable functor F: ^ is naturally isomorphic to _(-, A) for some A. Unde… |
| ch10-12.tex | 265 | tétel | thm:dual-summary | Summary of Dual Involution Proofs |
| ch10-12.tex | 266 | alszakasz |  | ARITHMETIC (4 Proofs) |
| ch10-12.tex | 270 | tétel | thm:arith-64 | Binary Power — 64 = 2^6 |
| ch10-12.tex | 276 | bizonyítás |  | 2^6 = 64. This is the number of states in a 6-bit register. 64 = 2^6 |
| ch10-12.tex | 280 | tétel | thm:arith-279 | Cubic Difference — 279 = 7^3 - 2^6 |
| ch10-12.tex | 286 | bizonyítás |  | 7^3 = 343, 2^6 = 64, 343 - 64 = 279. 279 = 7^3 - 2^6 |
| ch10-12.tex | 290 | tétel | thm:arith-verb | Verb Space Dimension |
| ch10-12.tex | 296 | bizonyítás |  | The verb space encodes transitions between 64 noun states. 279 = 7^3 - 2^6 = 343… |
| ch10-12.tex | 300 | tétel | thm:arith-108 | Factorized Product |
| ch10-12.tex | 306 | bizonyítás |  | 2 6 3 3 = 108. Encodes: 2 (duality), 6 (register), 3 (time modes), 3 (logic mode… |
| ch10-12.tex | 308 | alszakasz |  | FREE COFREE ADJUNCTION (8 Proofs) |
| ch10-12.tex | 312 | definíció |  | Let be a category and U: a forgetful functor. A free functor F: is left adjoint … |
| ch10-12.tex | 319 | tétel | thm:free-left | Free Functor is Left Adjoint |
| ch10-12.tex | 325 | bizonyítás |  | We establish _Frame(E(N), F) _Noun(N, U(F)) naturally in N and F. The Extract fu… |
| ch10-12.tex | 332 | tétel | thm:cofree-right | Cofree Functor is Right Adjoint |
| ch10-12.tex | 338 | bizonyítás |  | _Agent(I(A), M) _Frame(A, C(M)). Consciousness cofreely generates the maximal ag… |
| ch10-12.tex | 342 | tétel | thm:tri1 | Triangle Identity I |
| ch10-12.tex | 348 | bizonyítás |  | For the adjunction E U, the left triangle identity: U U UFU U U = _U. Concretely… |
| ch10-12.tex | 352 | tétel | thm:tri2 | Triangle Identity II |
| ch10-12.tex | 358 | bizonyítás |  | The dual triangle identity: F F FUF F F = _F post-composed with U. Starting with… |
| ch10-12.tex | 362 | tétel | thm:monad1 | Monad Law I — Left Unit |
| ch10-12.tex | 368 | bizonyítás |  | _X T(_X) = U(_E(X)) U(E(_X)) = U(_E(X) E(_X)) = U(_E(X)) = _T(X), using Theorem … |
| ch10-12.tex | 372 | tétel | thm:monad2 | Monad Law II — Associativity |
| ch10-12.tex | 378 | bizonyítás |  | Both sides equal U( EU)E. Naturality of gives EU = EU, which after applying U le… |
| ch10-12.tex | 382 | tétel | thm:monad3 | Monad Law III — Right Unit |
| ch10-12.tex | 388 | bizonyítás |  | _X _T(X) = U(_E(X)) _U(E(X)) = _U(E(X)) = _T(X), using Theorem . T = _T |
| ch10-12.tex | 394 | alszakasz |  | COMPACT CLOSED SNAKE (3 Proofs) |
| ch10-12.tex | 398 | definíció |  | A compact closed category is a symmetric monoidal category (, , I) where every o… |
| ch10-12.tex | 402 | tétel | thm:snake-left | Left Snake Equation |
| ch10-12.tex | 408 | bizonyítás |  | In string diagram notation, a cap followed by a cup on the same wire equals the … |
| ch10-12.tex | 412 | tétel | thm:snake-right | Right Snake Equation |
| ch10-12.tex | 418 | bizonyítás |  | Since A^** A, the right snake for A is the left snake for A^*. The string diagra… |
| ch10-12.tex | 422 | tétel | thm:snake-inv | Snake Involution |
| ch10-12.tex | 428 | bizonyítás |  | Both paths represent the same topological deformation in string calculus. Natura… |
| ch10-12.tex | 434 | alszakasz |  | STEANE 7,1,3 CODE (8 Proofs) |
| ch10-12.tex | 446 | definíció |  | Steane Code Parameters |
| ch10-12.tex | 459 | tétel | thm:steane-gen | Stabilizer Generators |
| ch10-12.tex | 465 | bizonyítás |  | Each g_i is a tensor product of Pauli matrices. X and Z anticommute, but the ove… |
| ch10-12.tex | 469 | tétel | thm:steane-nrk | Code Parameters — n=7, r=6, k=1 |
| ch10-12.tex | 475 | bizonyítás |  | By construction, there are 7 physical qubits and 6 independent stabilizer genera… |
| ch10-12.tex | 479 | tétel | thm:steane-d | Code Distance — d=3 |
| ch10-12.tex | 485 | bizonyítás |  | The distance d is the minimum weight of a Pauli operator that preserves the code… |
| ch10-12.tex | 496 | tétel | thm:steane-ham | Hamming Bound — Classical |
| ch10-12.tex | 502 | bizonyítás |  | There are 70 = 1 zero-error case, and 71 = 7 single-qubit locations, each with 3… |
| ch10-12.tex | 510 | tétel | thm:steane-qham | Quantum Hamming Bound |
| ch10-12.tex | 516 | bizonyítás |  | The quantum Hamming bound states that the total dimension of the space spanned b… |
| ch10-12.tex | 520 | tétel | thm:steane-dim | Total Hilbert Space Dimension |
| ch10-12.tex | 526 | bizonyítás |  | 7 physical qubits yield 2^7 = 128 basis states. The stabilizer group S partition… |
| ch10-12.tex | 530 | tétel | thm:steane-cap | Error Correction Capability |
| ch10-12.tex | 536 | bizonyítás |  | Each of the 6 stabilizer generators yields a 1 measurement, giving 2^6 = 64 poss… |
| ch10-12.tex | 542 | alszakasz |  | PSL(2,7) GROUP (3 Proofs) |
| ch10-12.tex | 546 | definíció |  | (2,7) is the projective special linear group of 2 2 matrices over the finite fie… |
| ch10-12.tex | 550 | tétel | thm:psl-order | Order of (2,7) |
| ch10-12.tex | 560 | bizonyítás |  | The general formula for \/(2,q)\/ = q(q^2-1) and \/(2,q)\/ = q(q^2-1)/(2,q-1). F… |
| ch10-12.tex | 564 | tétel | thm:psl-iso | Isomorphisms of (2,7) |
| ch10-12.tex | 570 | bizonyítás |  | (3,2) is the group of invertible 3 3 matrices over _2. Its order: (2^3-1)(2^3-2)… |
| ch10-12.tex | 574 | tétel | thm:fano-struct | Fano Plane — Combinatorial Structure |
| ch10-12.tex | 580 | bizonyítás |  | The Fano plane is the projective plane of order 2, denoted (2,2). It can be cons… |
| ch10-12.tex | 586 | alszakasz |  | E8 ROOT SYSTEM (2 Proofs) |
| ch10-12.tex | 593 | definíció |  | The E_8 root system is the unique largest exceptional irreducible root system, o… |
| ch10-12.tex | 597 | tétel | thm:e8-roots | Number of Roots in E_8 |
| ch10-12.tex | 603 | bizonyítás |  | The E_8 lattice can be constructed as the set of vectors (x_1,,x_8) ^8 where all… |
| ch10-12.tex | 607 | tétel | thm:e8-cox | Coxeter Number and Root Companions |
| ch10-12.tex | 613 | bizonyítás |  | The Coxeter number h is the order of a Coxeter element (product of simple reflec… |
| ch10-12.tex | 619 | alszakasz |  | CRITICAL EXPONENTS (4 Scaling Relations) |
| ch10-12.tex | 631 | definíció |  | For the 3D Ising model universality class, the critical exponents characterize t… |
| ch10-12.tex | 635 | tétel | thm:rushbrooke | Rushbrooke Scaling Relation |
| ch10-12.tex | 647 | bizonyítás |  | The Rushbrooke inequality, derived from thermodynamic considerations, becomes an… |
| ch10-12.tex | 651 | tétel | thm:widom | Widom Scaling Relation |
| ch10-12.tex | 663 | bizonyítás |  | The Widom relation follows from the scaling form of the equation of state: h = M… |
| ch10-12.tex | 667 | tétel | thm:fisher | Fisher Scaling Relation |
| ch10-12.tex | 679 | bizonyítás |  | The Fisher relation connects the susceptibility exponent to the correlation leng… |
| ch10-12.tex | 683 | tétel | thm:josephson | Josephson Scaling Relation |
| ch10-12.tex | 694 | bizonyítás |  | The Josephson hyperscaling relation d = 2 - for d=3 gives 3 = 2 - . This is a di… |
| ch10-12.tex | 700 | alszakasz |  | AI ARCHITECTURE DERIVATION (5 Proofs) |
| ch10-12.tex | 704 | tétel | thm:ai-heads | Number of Attention Heads |
| ch10-12.tex | 716 | bizonyítás |  | The number 168 (order of (2,7)) encodes the group of symmetries of the 7-qubit s… |
| ch10-12.tex | 720 | tétel | thm:ai-headdim | Head Dimension |
| ch10-12.tex | 726 | bizonyítás |  | The total model dimension (before splitting into heads) is anchored at 64 (the 6… |
| ch10-12.tex | 730 | tétel | thm:ai-layers | Number of Transformer Layers |
| ch10-12.tex | 741 | bizonyítás |  | The layer count is determined by the geometric mean of renormalization group dec… |
| ch10-12.tex | 745 | tétel | thm:ai-tokendim | Token Dimension |
| ch10-12.tex | 757 | bizonyítás |  | The token embedding dimension is derived from the combinatorial structure of the… |
| ch10-12.tex | 761 | tétel | thm:ai-ffdim | Feed-Forward Dimension |
| ch10-12.tex | 777 | bizonyítás |  | The feed-forward network dimension expands the token representation for intermed… |
| ch10-12.tex | 791 | alszakasz |  | KANT MAPPING (1 Proof with 3 Sub-Lemmas) |
| ch10-12.tex | 801 | definíció |  | Kant's 12 categories of understanding are organized into 4 groups of 3: label=(*… |
| ch10-12.tex | 805 | lemma | lem:kant-gen | Generator Counting for Kant Groups |
| ch10-12.tex | 808 | bizonyítás |  | In each group of 3 categories, the third is the synthesis of the first two (thes… |
| ch10-12.tex | 812 | lemma | lem:kant-overlap | Generator Overlap |
| ch10-12.tex | 815 | bizonyítás |  | The two overlaps are: (1) Unity (Quantity) is equivalent to Reality (Quality) in… |
| ch10-12.tex | 819 | lemma | lem:kant-synth | Synthesis Decomposition |
| ch10-12.tex | 822 | bizonyítás |  | Kant identifies 3 syntheses of the transcendental imagination: (1) Synthesis of … |
| ch10-12.tex | 826 | tétel | thm:kant-bit | Kant-Bit Correspondence |
| ch10-12.tex | 841 | bizonyítás |  | From Lemma and Lemma , the 12 categories are generated by exactly 6 independent … |
| ch10-12.tex | 843 | alszakasz |  | 77 FREE CATEGORY (1 Proof) |
| ch10-12.tex | 847 | definíció |  | Let = (P, L) be the Fano plane with P = p_1,,p_7 and L = _1,,_7. Define the inci… |
| ch10-12.tex | 851 | tétel | thm:fano-free | Arrows in the Free Fano Category |
| ch10-12.tex | 881 | bizonyítás |  | Step 1: Count generators. In , each point lies on exactly 3 lines, and each line… |
| ch10-12.tex | 887 | alszakasz |  | CPT MASK (1 Proof) |
| ch10-12.tex | 897 | definíció |  | Define the generator masks g_1, g_2, g_3, g_4, g_5, g_6 as basis vectors in 0,1^… |
| ch10-12.tex | 901 | tétel | thm:cpt | CPT Involution |
| ch10-12.tex | 915 | bizonyítás |  | Compute the value: CPT = 32 + 4 + 1 = 37 In binary: 37_10 = 100101_2, with bits … |
| ch10-12.tex | 921 | alszakasz |  | ALGEBRA DUAL (1 Proof) |
| ch10-12.tex | 928 | definíció |  | Define an algebra of three operations *, ;, + on the space of linguistic types, … |
| ch10-12.tex | 932 | tétel | thm:alg-dual | Algebraic Dual Involution |
| ch10-12.tex | 944 | bizonyítás |  | Verify each element: T^2(*) &= T(T(*)) = T(;) = * T^2(;) &= T(T(;)) = T(*) = ; T… |
| ch10-12.tex | 950 | alszakasz |  | OBJECT META ADJUNCTION (1 Proof with Cases) |
| ch10-12.tex | 968 | definíció |  | Define a hierarchy of semantic layers L_0, L_1, , L_6 where: L_0: atomic symbols… |
| ch10-12.tex | 977 | tétel | thm:obj-meta | Object-Meta Adjunction Structure |
| ch10-12.tex | 993 | bizonyítás |  | Case (i): Interior fixed points, k 0,1,2,3,4,5. For any layer L_k with k < 6, me… |
| ch10-12.tex | 999 | alszakasz |  | QUATERNION STATE SPACE (2 Proofs) |
| ch10-12.tex | 1003 | tétel | thm:quat-trit | Dimension of the Quaternion Trit Space |
| ch10-12.tex | 1019 | bizonyítás |  | A quaternion trit is a choice among 3 values, corresponding to the 3 imaginary q… |
| ch10-12.tex | 1023 | tétel | thm:quat-ratio | Quaternion-to-Binary Expressivity Ratio |
| ch10-12.tex | 1037 | bizonyítás |  | The 6-bit binary register has 2^6 = 64 states (the spatial noun register). The 7… |
| ch10-12.tex | 1043 | szakasz |  | The Abductive Algorithm --- The 7th Bit |
| ch10-12.tex | 1045 | alszakasz |  | Three Types of Logic (C.S. Peirce) |
| ch10-12.tex | 1051 | definíció |  | Knowledge State |
| ch10-12.tex | 1062 | definíció |  | Deduction --- Modus Ponens |
| ch10-12.tex | 1074 | definíció |  | Induction --- Statistical Generalization |
| ch10-12.tex | 1082 | definíció |  | Abduction --- Explanation Generation |
| ch10-12.tex | 1094 | alszakasz |  | The Abductive Algorithm in the 64-Noun Space |
| ch10-12.tex | 1106 | definíció |  | Abductive Search Problem |
| ch10-12.tex | 1150 | tétel | thm:abduction-complete | Abductive Search Completeness |
| ch10-12.tex | 1156 | bizonyítás |  | The algorithm enumerates the finite set 0,1^6 of 64 hypotheses. At each relaxati… |
| ch10-12.tex | 1158 | alszakasz |  | The 7th Bit = Temporal Closure |
| ch10-12.tex | 1169 | tétel | thm:seventh-temporal | Temporal Nature of the 7th Bit |
| ch10-12.tex | 1179 | bizonyítás |  | (i) The 6-bit register R = (b_1,,b_6) encodes spatial structure: the 64 noun-con… |
| ch10-12.tex | 1183 | következmény | cor:128 | The 128-State Interpretation |
| ch10-12.tex | 1185 | alszakasz |  | Exchange: TIME Reason Algorithm Skill Saved TIME |
| ch10-12.tex | 1194 | definíció |  | Intelligence as Time Efficiency |
| ch10-12.tex | 1198 | tétel | thm:intelligence-cycle | Intelligence Growth Cycle |
| ch10-12.tex | 1212 | bizonyítás |  | Phase 1: TIME Reason. Time is spent running the abductive search algorithm over … |
| ch10-12.tex | 1218 | alszakasz |  | WWJS --- What Would Joco Say: The Abduction Skill |
| ch10-12.tex | 1228 | definíció |  | WWJS Decision Framework |
| ch10-12.tex | 1244 | tétel | thm:wwjs-optimal | WWJS Optimality |
| ch10-12.tex | 1254 | bizonyítás |  | The expected future search cost for explanation h is: EFutureCost(h) = P(reuse h… |
| ch10-12.tex | 1256 | alszakasz |  | Abduction in Hungarian Grammar |
| ch10-12.tex | 1267 | tétel | thm:hungarian-abduction | Hungarian Moods as Abductive Operators |
| ch10-12.tex | 1279 | bizonyítás |  | Indicative as Deduction: The Hungarian indicative mood marks statements as factu… |
| ch10-12.tex | 1285 | alszakasz |  | Abductive Closure and Symmetry |
| ch10-12.tex | 1289 | tétel | thm:forced-closure | Forced Closure by Symmetry |
| ch10-12.tex | 1307 | bizonyítás |  | Let R be a 6-bit state. Define C(R) = h 0,1^6 : T h O and h aligns with all 6 ax… |
| ch10-12.tex | 1317 | alszakasz |  | Idris as the Trust Layer |
| ch10-12.tex | 1329 | definíció |  | Verification-Trust Boundary |
| ch10-12.tex | 1333 | tétel | thm:idris-trust | Idris as Proof of 6-Bit Structure |
| ch10-12.tex | 1355 | bizonyítás |  | The 71 theorems of Chapter 10 establish: The duality operator is an involution o… |
| ch10-12.tex | 1357 | alszakasz |  | Summary: The Logic of Intelligence |
| ch10-12.tex | 1381 | szakasz |  | Developmental Horgony Architecture (S0--S7) |
| ch10-12.tex | 1383 | alszakasz |  | Philosophy of Developmental Learning |
| ch10-12.tex | 1410 | alszakasz |  | Parameter Switching Protocol |
| ch10-12.tex | 1433 | definíció |  | Parameter Switch Operations |
| ch10-12.tex | 1437 | tétel | thm:net2net | Function-Preserving Growth |
| ch10-12.tex | 1443 | bizonyítás |  | By construction, the expanded parameters satisfy f(; ') = f(; ) pointwise. There… |
| ch10-12.tex | 1445 | alszakasz |  | Architecture Overview |
| ch10-12.tex | 1465 | alszakasz |  | The Hungarian 104-Channel Input |
| ch10-12.tex | 1477 | tétel | thm:104-channels | 104-Channel Decomposition |
| ch10-12.tex | 1491 | bizonyítás |  | (i) 8 Position Channels. Hungarian has up to 18+ grammatical cases, but the 7 co… |
| ch10-12.tex | 1493 | alszakasz |  | Stage S0: Atoms (Characters and Tokens) |
| ch10-12.tex | 1497 | definíció |  | S0: The Atomic Stage |
| ch10-12.tex | 1520 | alszakasz |  | Stage S1: Basic Facts |
| ch10-12.tex | 1524 | definíció |  | S1: The Factual Stage |
| ch10-12.tex | 1545 | alszakasz |  | Stage S2: Grammar and Composition |
| ch10-12.tex | 1569 | alszakasz |  | Stage S3: Time and Causality |
| ch10-12.tex | 1592 | alszakasz |  | Stage S4: Tools and Code |
| ch10-12.tex | 1615 | alszakasz |  | Stage S5: Lab Memory |
| ch10-12.tex | 1639 | alszakasz |  | Stage S6: Abstraction |
| ch10-12.tex | 1661 | alszakasz |  | Stage S7: Deployment |
| ch10-12.tex | 1694 | alszakasz |  | Required Symmetries (Formalized) |
| ch10-12.tex | 1704 | definíció | def:sym-rename | Symmetry 1: Entity Rename Equivariance |
| ch10-12.tex | 1712 | definíció | def:sym-order | Symmetry 2: Evidence Order Invariance |
| ch10-12.tex | 1721 | definíció | def:sym-time | Symmetry 3: Time-Shift Equivariance |
| ch10-12.tex | 1730 | definíció | def:sym-factor | Symmetry 4: Object-Action-State Factorization |
| ch10-12.tex | 1739 | definíció | def:sym-premise | Symmetry 5: Causal-Premise Convergence |
| ch10-12.tex | 1747 | definíció | def:sym-safety | Symmetry 6: Safety Monotonicity |
| ch10-12.tex | 1755 | definíció | def:sym-resource | Symmetry 7: Resource Conservation |
| ch10-12.tex | 1764 | definíció | def:sym-bilingual | Symmetry 8: Bilingual Semantic Consistency |
| ch10-12.tex | 1767 | alszakasz |  | Training Curriculum Table |
| ch10-12.tex | 1786 | alszakasz |  | Training Signals and Loss Functions |
| ch10-12.tex | 1807 | alszakasz |  | Centrality as the Quality Signal |
| ch10-12.tex | 1817 | definíció |  | Removal-Impact Centrality |
| ch10-12.tex | 1825 | definíció |  | Graph Disruption |
| ch10-12.tex | 1833 | definíció |  | Premise Convergence Depth |
| ch10-12.tex | 1840 | tétel | thm:centrality-compress | Centrality as an Upper Bound on Compressibility |
| ch10-12.tex | 1846 | bizonyítás |  | Removing a node v changes the graph entropy by exactly C(v) = H(G) - H(G v). If … |
| ch10-12.tex | 1852 | alszakasz |  | Comparison to Standard Approaches |
| ch10-12.tex | 1876 | alszakasz |  | Conclusion: The Developmental Path |
| ch13-15-app.tex | 44 | fejezet |  | CHAPTER 13 |
| ch13-15-app.tex | 46 | szakasz | sec:meta-levels | Hierarchy of 7 Meta-Levels: Language as Error Correction |
| ch13-15-app.tex | 49 | alszakasz | sec:ladder | The Ladder of Linguistic Abstraction |
| ch13-15-app.tex | 84 | egyenlet | eq:127 | _k=0^6 2^k = 2^7 - 1 = 127. |
| ch13-15-app.tex | 85 | definíció | def:hierarchy | Meta-Level Hierarchy |
| ch13-15-app.tex | 93 | definíció | def:transcendental | Transcendental Level L_7 |
| ch13-15-app.tex | 99 | lemma | lem:doubling | The Doubling Law |
| ch13-15-app.tex | 106 | bizonyítás |  | Each meta-level adds one binary distinction. At L_0 there is one entity. At L_1 … |
| ch13-15-app.tex | 115 | alszakasz | sec:detailed-levels | Detailed Structure of Each Meta-Level |
| ch13-15-app.tex | 230 | alszakasz | sec:parity | Meta-Encoding as Parity Protection |
| ch13-15-app.tex | 243 | tétel | thm:parity | Meta-Level Parity Check Isomorphism |
| ch13-15-app.tex | 267 | bizonyítás |  | Proof sketch |
| ch13-15-app.tex | 278 | következmény | cor:grammar-correction | Error Correction as Grammar |
| ch13-15-app.tex | 307 | alszakasz | sec:tarski | Tarski's Undefinability and the Meta-Hierarchy |
| ch13-15-app.tex | 327 | tétel | thm:tarski | Tarski, 1933 --- Undefinability of Truth |
| ch13-15-app.tex | 336 | tétel | thm:meta-finite | Meta-Level Finiteness Theorem |
| ch13-15-app.tex | 346 | bizonyítás |  | The Steane 7,1,3 code encodes 1 logical qubit into 7 physical qubits using n-k =… |
| ch13-15-app.tex | 360 | alszakasz | sec:adjunction | The Object--Meta Adjunction |
| ch13-15-app.tex | 392 | definíció | def:obj-meta-functors | The Object and Meta Functors |
| ch13-15-app.tex | 415 | tétel | thm:interior-closure | Interior and Closure Properties |
| ch13-15-app.tex | 428 | bizonyítás |  | Direct computation from Definition . For k < 6: (L_k) = L_k+1, then (L_k+1) = L_… |
| ch13-15-app.tex | 446 | alszakasz | sec:galois-chain | The Galois Connection Chain |
| ch13-15-app.tex | 467 | propozíció | prop:galois-algebra | Galois Connection Algebra |
| ch13-15-app.tex | 477 | bizonyítás |  | We verify on each L_k. (((L_0))) = ((L_0)) = (L_1) = L_0 = (L_0). For 1 k 5: (L_… |
| ch13-15-app.tex | 489 | alszakasz | sec:visible-hidden | Visible and Hidden States |
| ch13-15-app.tex | 500 | tétel | thm:visible-hidden | Visible--Hidden State Decomposition |
| ch13-15-app.tex | 510 | bizonyítás |  | The visible states are the 2^6 = 64 noun-space states at L_6, which are directly… |
| ch13-15-app.tex | 531 | alszakasz | sec:language-ec | Language as Error Correction: The Full Analogy |
| ch13-15-app.tex | 554 | tétel | thm:lang-qec | Language--QEC Isomorphism |
| ch13-15-app.tex | 583 | bizonyítás |  | Proof of the Isomorphism |
| ch13-15-app.tex | 607 | következmény | cor:semantic-stability | The Semantic Stability Corollary |
| ch13-15-app.tex | 610 | fejezet |  | CHAPTER 14 |
| ch13-15-app.tex | 612 | szakasz | sec:entropy-time | Entropy, Time, and the Goldstone Mode |
| ch13-15-app.tex | 615 | alszakasz | sec:entropy-duality | Entropy Duality |
| ch13-15-app.tex | 636 | definíció | def:entropy-dual | Entropy Duality |
| ch13-15-app.tex | 648 | tétel | thm:arrow | Arrow of Time as Entropy Gradient |
| ch13-15-app.tex | 659 | bizonyítás |  | Explanation |
| ch13-15-app.tex | 662 | alszakasz | sec:black-hole | Black Hole Thermodynamics |
| ch13-15-app.tex | 671 | egyenlet | eq:bh-entropy | _BH = A4G = A4^2, |
| ch13-15-app.tex | 675 | tétel | thm:bekenstein-hawking | Bekenstein--Hawking Entropy, 1973--1974 |
| ch13-15-app.tex | 683 | egyenlet | eq:hawking-temp | T_BH = c^38 G M k_B = c^28 M k_B, |
| ch13-15-app.tex | 689 | egyenlet | eq:evap-time | t_evap G^2 M^3 c^4 M^3. |
| ch13-15-app.tex | 693 | tétel | thm:hawking | Hawking Radiation, 1974 |
| ch13-15-app.tex | 704 | bizonyítás |  | Qualitative sketch |
| ch13-15-app.tex | 707 | alszakasz | sec:mass-info-algo | The Mass--Information--Algorithm Chain |
| ch13-15-app.tex | 728 | tétel | thm:mia-chain | Mass--Information--Algorithm Conversion Chain |
| ch13-15-app.tex | 741 | alszakasz | sec:ccc | Penrose's Conformal Cyclic Cosmology (CCC) |
| ch13-15-app.tex | 752 | egyenlet | eq:conformal | g_ab = ^2 g_ab, at the aeon boundary, |
| ch13-15-app.tex | 757 | tétel | thm:penrose-ccc | Penrose, 2010 --- Conformal Cyclic Cosmology |
| ch13-15-app.tex | 776 | bizonyítás |  | Arguments for CCC |
| ch13-15-app.tex | 793 | alszakasz | sec:goldstone | Goldstone's Theorem |
| ch13-15-app.tex | 806 | egyenlet | eq:ngb | n_GB = (G/H) = (G) - (H). |
| ch13-15-app.tex | 807 | tétel | thm:goldstone | Goldstone, 1961 --- Goldstone's Theorem |
| ch13-15-app.tex | 825 | bizonyítás |  | Sketch for a simple scalar model |
| ch13-15-app.tex | 835 | alszakasz | sec:present-goldstone | The Present Tense as Goldstone Mode in Hungarian |
| ch13-15-app.tex | 845 | tétel | thm:present-goldstone | Present Tense = Goldstone Boson of Broken Time Symmetry |
| ch13-15-app.tex | 864 | bizonyítás |  | Linguistic Phenomenology |
| ch13-15-app.tex | 874 | következmény | cor:verb-space | The Verb Space Decomposition |
| ch13-15-app.tex | 877 | alszakasz | sec:verb-flip | The Verb Flip: Time Reversal of the Goldstone Mode |
| ch13-15-app.tex | 887 | tétel | thm:verb-flip | Verb Flip as Time Reversal |
| ch13-15-app.tex | 907 | bizonyítás |  | Categorical interpretation |
| ch13-15-app.tex | 921 | alszakasz | sec:lenni-higgs | Hungarian ``To Be'' as the Higgs Mechanism |
| ch13-15-app.tex | 929 | tétel | thm:lenni-higgs | The Verb ``Lenni'' as the Higgs Field |
| ch13-15-app.tex | 958 | bizonyítás |  | The two eigenstates of existence: van (is) &= \/+ (the +1 eigenstate of the exis… |
| ch13-15-app.tex | 961 | alszakasz | sec:hu-scientists | Hungarian Scientists and the Goldstone Mode |
| ch13-15-app.tex | 1017 | alszakasz | sec:thermo-cycle | The Complete Thermodynamic--Grammatical Cycle |
| ch13-15-app.tex | 1036 | tétel | thm:cycle | The Cosmological--Linguistic Cycle |
| ch13-15-app.tex | 1046 | bizonyítás |  | Cycle Duality |
| ch13-15-app.tex | 1049 | alszakasz | sec:time-reversal | The Time-Reversal Involution in Grammar |
| ch13-15-app.tex | 1063 | definíció | def:gram-time-rev | Grammatical Time Reversal |
| ch13-15-app.tex | 1072 | tétel | thm:goldstone-fixed | Goldstone Fixed-Point Theorem for Tense |
| ch13-15-app.tex | 1075 | fejezet |  | CHAPTER 15 |
| ch13-15-app.tex | 1077 | szakasz | sec:beyond | Beyond: The Free Category, Dual Worlds, and Future Directions |
| ch13-15-app.tex | 1080 | alszakasz | sec:free-cat-fano | The Free Category on the Fano Plane |
| ch13-15-app.tex | 1096 | definíció | def:fano | The Fano Plane P^2(_2) |
| ch13-15-app.tex | 1118 | definíció | def:free-cat | The Free Category _7 |
| ch13-15-app.tex | 1131 | lemma | lem:arrow-count | Counting the Arrows |
| ch13-15-app.tex | 1143 | bizonyítás |  | Each point p lies on 3 Fano lines. Each line contains 2 other points besides p. … |
| ch13-15-app.tex | 1161 | alszakasz | sec:dual-free | The Dual Free Category: Forward and Reverse Worlds |
| ch13-15-app.tex | 1177 | definíció | def:dual-cat | The Dual Free Category Construction |
| ch13-15-app.tex | 1187 | egyenlet | eq:162 | _conscious = 64_noun stabilizer ;+; 49_^fwd ;+; 49_^rev = 162 = 2 81 = 2 3^4. |
| ch13-15-app.tex | 1193 | tétel | thm:conscious-field | Dimensional Count of the Conscious Field |
| ch13-15-app.tex | 1201 | bizonyítás |  | The noun stabilizer space has dimension 2^6 = 64 (the number of distinct syndrom… |
| ch13-15-app.tex | 1217 | következmény | cor:consciousness-rep | Consciousness as a 162-Dimensional Representation |
| ch13-15-app.tex | 1220 | alszakasz | sec:verb-flip-arrow | The Verb That Flips: The A_Time Arrow |
| ch13-15-app.tex | 1234 | definíció | def:atime | The A_Time Generating Arrow |
| ch13-15-app.tex | 1252 | tétel | thm:arrow-reversal | Verb Flip as Arrow Reversal |
| ch13-15-app.tex | 1255 | alszakasz | sec:7-principles | The Complete Theory in 7 Principles |
| ch13-15-app.tex | 1397 | alszakasz | sec:future | Future Research Directions |
| ch13-15-app.tex | 1486 | alszakasz | sec:connections | Connections to Other Domains |
| ch13-15-app.tex | 1560 | tétel | thm:final-identity | The Fundamental Identity |
| ch13-15-app.tex | 1576 | szakasz |  | Appendix A: Complete Idris Source Code (Selected Proofs) |
| ch13-15-app.tex | 1584 | alszakasz |  | A.1 Dual Involution: dualInvolution |
| ch13-15-app.tex | 1595 | alszakasz |  | A.2 Free--Cofree Adjunction |
| ch13-15-app.tex | 1607 | alszakasz |  | A.3 Triangle Identities |
| ch13-15-app.tex | 1621 | alszakasz |  | A.4 Snake Identities |
| ch13-15-app.tex | 1637 | alszakasz |  | A.5 Steane Code K-Matrix: steaneKIs1 |
| ch13-15-app.tex | 1648 | alszakasz |  | A.6 Hamming Code Sum: hammingSumIs29 |
| ch13-15-app.tex | 1662 | alszakasz |  | A.7 Factorisation Proofs: pslFactorization, e8Factorization |
| ch13-15-app.tex | 1673 | alszakasz |  | A.8 Critical Exponent Relations: Rush, Widom, Fisher, Josephson |
| ch13-15-app.tex | 1691 | alszakasz |  | A.9 Adjunction Properties: Interior, Top Leak, Bottom Stick |
| ch13-15-app.tex | 1701 | alszakasz |  | A.10 Time Involution and Algorithmic Chain |
| ch13-15-app.tex | 1718 | szakasz |  | Appendix B: All Numbers and Their Derivation |
| ch13-15-app.tex | 1724 | alszakasz |  | B.1 Quantum Code Parameters |
| ch13-15-app.tex | 1740 | alszakasz |  | B.2 Hungarian Grammar Constants |
| ch13-15-app.tex | 1758 | alszakasz |  | B.3 Group Theory Constants |
| ch13-15-app.tex | 1783 | alszakasz |  | B.4 Physical Constants |
| ch13-15-app.tex | 1802 | alszakasz |  | B.5 3D Ising Critical Exponents |
| ch13-15-app.tex | 1823 | alszakasz |  | B.6 Derived Numerical Constants |
| ch13-15-app.tex | 1835 | alszakasz |  | B.7 Nobel Prizes and Population |
| ch13-15-app.tex | 1865 | szakasz |  | Appendix C: Author Information |
| ch13-15-app.tex | 1868 | alszakasz |  | Lead Author |
| ch13-15-app.tex | 1875 | alszakasz |  | Co-Authors and Roles |
| ch13-15-app.tex | 1892 | alszakasz |  | Verification |
| ch13-15-app.tex | 1905 | alszakasz |  | Production |
| ch13-15-app.tex | 1918 | alszakasz |  | Repository and Contact |
| ch16-18.tex | 2 | fejezet |  | CHAPTERS 16--18: The Stabilizer Code Framework |
| ch16-18.tex | 10 | szakasz | sec:chemistry-periodic | Chemistry --- The Periodic Table as a Stabilizer Code |
| ch16-18.tex | 15 | alszakasz | sec:periodic-6bit | The Periodic Table as a 6-Bit Encoding |
| ch16-18.tex | 46 | táblázat | tab:period-lengths | Period lengths of the periodic table. The sum 2+8+8+18+18+32+32 = 118 matches th… |
| ch16-18.tex | 72 | egyenlet | eq:chem-stabilizer-generators | S = g_n, g_, g_m_, g_m_s , g_i, g_j = 0 ; i,j. |
| ch16-18.tex | 81 | egyenlet | eq:stabilizer-constraint | g_i _Z = +1 _Z, i n,,m_,m_s, occupied orbitals. |
| ch16-18.tex | 95 | egyenlet | eq:2n2 | (H_n) = 2 (angular momentum subspace at level n) = 2n^2, |
| ch16-18.tex | 106 | egyenlet | eq:sum-of-dimensions | _=0^n-1 (2+1) = n^2. |
| ch16-18.tex | 114 | alszakasz | sec:bonding-pauli | Chemical Bonding as Pauli Operations |
| ch16-18.tex | 131 | egyenlet | eq:ionic-x | XNa(3s^1) Cl(3p^5) = Na^+(2p^6) Cl^-(3p^6). |
| ch16-18.tex | 143 | egyenlet | eq:born-lande | U = -N_A M z^+ z^- e^24_0 r_0(1 - 1n), |
| ch16-18.tex | 160 | egyenlet | eq:singlet | ^- = 12 ( - ). |
| ch16-18.tex | 171 | egyenlet | eq:bond-gap | E_bond = E_antibonding - E_bonding = 2 (exchange integral), |
| ch16-18.tex | 183 | egyenlet | eq:bond-order | Bond Order = n_bonding - n_antibonding2. |
| ch16-18.tex | 199 | egyenlet | eq:metal-superposition | _metal = 1N _i=1^N electron at site i, |
| ch16-18.tex | 221 | egyenlet | eq:h-bond | D!-!H A. |
| ch16-18.tex | 229 | egyenlet | eq:h-bond-hamiltonian | H_H-bond = -J Z_H Z_A, |
| ch16-18.tex | 245 | egyenlet | eq:vdw | V_vdW(r) = -C_6r^6, |
| ch16-18.tex | 253 | alszakasz | sec:point-groups | Molecular Symmetries and Point Groups |
| ch16-18.tex | 279 | táblázat | tab:point-groups | Symmetry groups of selected molecules. The register size in bits is the Shannon … |
| ch16-18.tex | 321 | egyenlet | eq:character-expectation | (R) = Tr, (R) = _i _i R _i, |
| ch16-18.tex | 342 | egyenlet | eq:vib-rep | _vib = _3N _trans _rot, |
| ch16-18.tex | 358 | egyenlet | eq:ir-selection | Hom_G(V_vib V_dipole, C) 0 IR active. |
| ch16-18.tex | 360 | alszakasz | sec:elements-noun-states | Chemical Elements as Noun States |
| ch16-18.tex | 376 | egyenlet | eq:118-encoding | 118 = 2 64 - 10 = 128 - 10, |
| ch16-18.tex | 384 | egyenlet | eq:94-encoding | 94 = 64 + 30 = 2^6 + 30, |
| ch16-18.tex | 407 | egyenlet | eq:noble-gas-configs | He&: 1s^2 (Period 1) Ne&: 2s^2 2p^6 (Period 2) Ar&: 3s^2 3p^6 (Period 3) Kr&: 4s… |
| ch16-18.tex | 428 | egyenlet | eq:halogen-flip | X halogen(p^5) = noble gas(p^6). |
| ch16-18.tex | 445 | egyenlet | eq:alkali-flip | alkali(s^1) X noble gas(p^6), |
| ch16-18.tex | 469 | alszakasz | sec:nuclear-stability | Nuclear Stability and the Valley of Stability |
| ch16-18.tex | 484 | egyenlet | eq:valley-stability | N_stable(Z) = Z + k Z^5/3, |
| ch16-18.tex | 493 | egyenlet | eq:bethe-weizsacker | B(Z,A) = a_V A - a_S A^2/3 - a_C Z(Z-1)A^1/3 - a_A (A-2Z)^2A + (A,Z). |
| ch16-18.tex | 515 | egyenlet | eq:magic-numbers | Magic numbers: 2, 8, 20, 28, 50, 82, 126. |
| ch16-18.tex | 535 | alszakasz | sec:64-codons-bridge | The 64 Codons --- Bridge to Biology |
| ch16-18.tex | 547 | egyenlet | eq:codon-6bit | codon A,U,G,C^3, \/codon\/ = (2^2)^3 = 2^2 3 = 2^6 = 64. |
| ch16-18.tex | 560 | egyenlet | eq:genetic-functor | G: Codon AminoAcid, |
| ch16-18.tex | 592 | szakasz | sec:genetics-codon | Genetics and Molecular Biology --- The 64-Codon Stabilizer Code |
| ch16-18.tex | 597 | alszakasz | sec:dna-qecc | DNA as a Quantum Error-Correcting Code |
| ch16-18.tex | 615 | egyenlet | eq:base-2bit | A, T, G, C 00, 01, 10, 11, |
| ch16-18.tex | 626 | egyenlet | eq:base-encoding | A & 00 (adenine --- purine, 2-ring) T & 01 (thymine --- pyrimidine, 1-ring) G & … |
| ch16-18.tex | 639 | egyenlet | eq:at-bell | A-T = 12(00_A 01_T + 01_T 00_A), |
| ch16-18.tex | 656 | egyenlet | eq:wallace | T_m = 2^C (n_A + n_T) + 4^C (n_G + n_C), |
| ch16-18.tex | 668 | egyenlet | eq:bp-energy | H _G-C = -J_GC(Z_1 Z_2), H _A-T = -J_AT(Z_1 Z_2), |
| ch16-18.tex | 686 | egyenlet | eq:mmr-circuit | Diagram omitted |
| ch16-18.tex | 723 | alszakasz | sec:full-genetic-code | The Genetic Code Table --- Full 64-Codon Mapping |
| ch16-18.tex | 844 | táblázat | tab:genetic-code-full | The complete genetic code table, with category-theoretic interpretations. The 64… |
| ch16-18.tex | 880 | alszakasz | sec:aa-properties-category | Amino Acid Properties as Category Elements |
| ch16-18.tex | 917 | táblázat | tab:aa-properties | The 20 standard amino acids, classified by hydropathy (Kyte--Doolittle scale), c… |
| ch16-18.tex | 929 | egyenlet | eq:aa-property-map | : A,U,G,C^3 R^k, |
| ch16-18.tex | 937 | alszakasz | sec:protein-folding | Protein Folding as Gradient Descent |
| ch16-18.tex | 955 | egyenlet | eq:folding-gradient | dxdt = - F(x) + (t), |
| ch16-18.tex | 964 | egyenlet | eq:folding-funnel | F(x) = E(x) - T S(x), |
| ch16-18.tex | 1022 | egyenlet | eq:msa-covariance | C_ij = Cov(M_*i, M_*j), |
| ch16-18.tex | 1029 | alszakasz | sec:molecular-evolution | Evolution at the Molecular Level |
| ch16-18.tex | 1042 | egyenlet | eq:point-mutation | M_i: c c e_i, |
| ch16-18.tex | 1071 | egyenlet | eq:frameshift-probability | P_stop in frame = 1 - (1 - 364)^n, |
| ch16-18.tex | 1090 | egyenlet | eq:mscd | MSCD = 164 9 _codons c _mutations m ^2(a(c), a(m(c))), |
| ch16-18.tex | 1109 | egyenlet | eq:hgt-entanglement | _combined = U_HGT _A _B, |
| ch16-18.tex | 1115 | alszakasz | sec:central-dogma-functor | The Central Dogma as Functorial Composition |
| ch16-18.tex | 1124 | egyenlet | eq:central-dogma | DNA RNA Protein. |
| ch16-18.tex | 1134 | egyenlet | eq:central-dogma-functor-diagram | Diagram omitted |
| ch16-18.tex | 1149 | egyenlet | eq:rt-adjunction | Hom_RNA(T(D), R^*) Hom_DNA(D, R(R^*)), |
| ch16-18.tex | 1161 | egyenlet | eq:full-flow | Diagram omitted |
| ch16-18.tex | 1171 | szakasz | sec:evolution | Evolution --- The Arrow of Time in Biology |
| ch16-18.tex | 1176 | alszakasz | sec:natural-selection | Natural Selection as a Stabiliser Measurement |
| ch16-18.tex | 1194 | egyenlet | eq:fitness-operator | F g = f_g g, |
| ch16-18.tex | 1205 | egyenlet | eq:selection-projection | ' = P_survive , , P_surviveTr(P_survive , ), |
| ch16-18.tex | 1219 | egyenlet | eq:replicator | dx_idt = x_i ( f_i(x) - f(x) ), |
| ch16-18.tex | 1230 | egyenlet | eq:replicator-gradient | dxdt = - V_eff(x), |
| ch16-18.tex | 1238 | egyenlet | eq:fisher-theorem | dfdt = Var(f) 0, |
| ch16-18.tex | 1270 | alszakasz | sec:speciation | Speciation as Spontaneous Symmetry Breaking |
| ch16-18.tex | 1327 | egyenlet | eq:verb-path | N_0 v_1 N_1 v_2 N_2 v_3 v_k N_k, |
| ch16-18.tex | 1337 | egyenlet | eq:convergent-paths | N_0 v N^* and N_0' w N^*, v w. |
| ch16-18.tex | 1339 | alszakasz | sec:evo-timescales | Evolutionary Timescales and the Arrow of Time |
| ch16-18.tex | 1373 | táblázat | tab:evo-timeline | The evolutionary timeline. Each event represents either a state transition or a … |
| ch16-18.tex | 1393 | alszakasz | sec:major-transitions | Major Transitions in Evolution |
| ch16-18.tex | 1442 | egyenlet | eq:transition-adjunction | Diagram omitted |
| ch16-18.tex | 1450 | alszakasz | sec:kleiber | Kleiber's Law and Metabolic Scaling |
| ch16-18.tex | 1460 | egyenlet | eq:kleiber | B = B_0 M^3/4, |
| ch16-18.tex | 1485 | egyenlet | eq:wbe-beta | = D_fD_f + 1, |
| ch16-18.tex | 1500 | egyenlet | eq:goldstone-ratio | 34 = (spatial dimensions)(quaternion embedding dimensions) = 33+1, |
| ch16-18.tex | 1518 | egyenlet | eq:mean-field-correction | = dd_c = 34, |
| ch16-18.tex | 1530 | alszakasz | sec:biodiversity-stabiliser | Biodiversity as the Full Stabiliser Group |
| ch16-18.tex | 1547 | egyenlet | eq:23-bit-biodiversity | \/S_eukaryota\/ 2^23 = 8,388,608. |
| ch16-18.tex | 1565 | egyenlet | eq:extinction-entropy | S_extinction = k_B 2 per lost state, |
| ch16-18.tex | 1575 | egyenlet | eq:mass-extinction-entropy | S_loss = N_extinct k_B 2. |
| ch16-18.tex | 1603 | alszakasz | sec:consciousness | Consciousness Emergence |
| ch16-18.tex | 1619 | egyenlet | eq:brain-state-space | \/H_brain\/ 2^N_synapses 2^10^15, |
| ch16-18.tex | 1650 | táblázat | tab:neural-oscillations | Neural oscillation frequency bands and their interpretation as stabiliser measur… |
| ch16-18.tex | 1680 | egyenlet | eq:brain-hamiltonian | H_brain = -12 _i,j J_ij Z_i Z_j, |
| ch16-18.tex | 1688 | alszakasz | sec:human-self-reflective | The Human as the Self-Reflective Stabiliser |
| ch16-18.tex | 1706 | egyenlet | eq:self-measurement | S S(S) = the stabiliser measures itself. |
| ch16-18.tex | 1729 | egyenlet | eq:language-stabilizer | sentence = U_grammar ( N_1 V_1 N_2 ), |
| ch16-18.tex | 1747 | egyenlet | eq:tool-stabilizer | S_human+tool = S_human S_tool, |
| ch16-18.tex | 1774 | egyenlet | eq:universe-stabilizer | S_universe = G_gravity, G_EM, G_strong, G_weak, . |
| ch16-18.tex | 1812 | egyenlet | eq:hungarian-functor | F: Hung Phys, |
| ch16-18.tex | 1818 | alszakasz | sec:chapter-summary-18 | Summary: The Universality of the Stabiliser Framework |

---

## Statisztika / 统计

| Típus | Elemek száma |
|-------|-------------:|
| fejezet | 13 |
| szakasz | 21 |
| alszakasz | 220 |
| tétel | 101 |
| definíció | 44 |
| lemma | 5 |
| következmény | 5 |
| propozíció | 1 |
| táblázat | 17 |
| egyenlet | 119 |
| összefoglaló-doboz | 3 |
| bizonyítás | 105 |
| **Összesen / Total** | **654** |

*Megjegyzés: a könyvben `insightbox` környezet nincs — a szerepét a `summarybox`
tölti be (3 db), ezért a generátor mindkettőt kezeli. Az egyenletek közül csak a
címkés (\label{eq:…}) került az indexbe, a feladat előírása szerint.*
