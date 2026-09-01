# Kutatási napló — 2026-09-01 — a TOBBI könyvtárak és nyelvek behozatala (az Idris összefogja őket)

## A felhasználó kérdése (szó szerint, §N5)

„hozzuk be a tobbi konyvtarokat is, a tobbi nyelveket is, idrisz majd osszefogja oket..."

## A §N12 (MCP: brave-search + exa) eredménye — 10 további könyvtár

### A. FIZIKA és kvantum-információ (Lean 4)

#### 1. physlib (Lean 4 — a Lean közösség fizika könyvtára)
- URL: https://github.com/leanprover-community/physlib
- Tartalom: a fizika eredményeinek digitalizálása Lean 4-be, beleértve a kvantum-információt
- Különlegesség: a Lean hivatalos közösségi projektje

#### 2. LeanQuantum (Lean 4 — a kvantum-számítás)
- URL: https://github.com/inQWIRE/LeanQuantum
- Tartalom: Hadamard, Pauli (X, Y, Z), rotáció, fázis, CNOT, SWAP; Pauli-operátorok; Stabilizátor-kódok (bit-flip, Shor 9-qubit); Ket/Brá; Kronecker-szorzat; tenzorm帽子ok; Hermiticitás; unitaritás; a [X,Y]=2iZ kommutátor
- Különlegesség: a `solve_matrix` taktika a kvantum-kapu-egyenlőségek bizonyítására

#### 3. QECLean (Lean 4 — a kvantum-hibajavítás!)
- URL: https://github.com/Stavan-Jain/QECLean
- Tartalom: Pauli-csoportok, bináris szimplektikus reprezentáció, stabilizátor-kódok, CSS-szerkezet, centralizátor, **toric code** (L×L, distance=L), **Steane 7-qubit**, **Shor 9-qubit**, [[5,1,3]], [[4,2,2]], [[6,2,2]], **bivariate-bicycle** (IBM [[144,12,12]] gross code, distance=12!), CSS-konkatenáció ([[49,1,9]] Steane⊗Steane), kvantum-Hamming
- Különlegesség: a távolság SAT-alapú automatikus verifikációja; a toric code chain complex (H₁ ≅ 𝔽₂²) + a CSS distance bridge — EZ A LEGKÖZELEBB a projekt [[7,1,3]] Steane-kód céljához!

#### 4. Lean-QEC / VerifiedQC (Lean 4 — a SAT-assisted QEC)
- URL: https://github.com/VerifiedQC/Lean-QEC
- Tartalom: bináris szimplektikus mátrixok, distance_eq_distance tétel, bitvec_sat_translation_correct, BB72_dist_6
- Különlegesség: a kódparaméterek→SAT fordítás, Lean-ben verifikálva

#### 5. QICLean + TNLean (Lean 4 — a tenzor-hálózatok!)
- URL: https://github.com/LionSR/TNLean + https://github.com/LionSR/QICLean
- Tartalom: matrix product states (MPS), kanonikus formák, gauge-struktúra, **a fundamentális tétel** (Pérez-García et al. 2007; Cirac et al. 2017), parent Hamiltonians, **PEPS** (2D tenzor-hálózatok), kvantum-csatornák, Kadison-Schwarz, kvantum Perron-Frobenius, kvantum Wielandt, **MPDO** (matrix-product density operators), renormalizációs fixpontok
- Különlegesség: **a tenzor-hálózatok = a holografikus kódok!** A PEPS = a 2D kiterjesztés, ami a surface/toric kódok alapja — EZ A LEGKÖZELEBB a holografikus kódok céljához!

### B. HOLOGRAFIKUS kódok

#### 6. LEGO_HQEC (Python — a holografikus kvantum-hibajavítás!)
- URL: https://github.com/QML-Group/HQEC
- Tartalom: holografikus csempe-műveletek, operator push, 3 dekóder (erasure, integer optimization, **tensor network decoder**), HaPPY code, heptagon Steane code
- Különlegesség: **a HaPPY code = a holografikus elv tenzor-hálózati megvalósítása!** (Pastawski et al. 2015)

### C. COQ (Rocq)

#### 7. t6s/qecc (Coq — a kvantum-áramkörök és hibajavító kódok)
- URL: https://github.com/t6s/qecc
- Tartalom: unitary, density matrix, kqm (caps and cups — a kompakt zárt kategória jelei!), Shor 9-qubit, GHZ, reverse circuit, qutrit gates
- Különlegesség: **a caps and cups = a kompakt zárt kategória!** (az E8×E8×E8 kapcsolat!)

#### 8. QuantumLib / SQIR (Coq — a kvantum-számítás)
- URL: https://github.com/inQWIRE/QuantumLib + SQIR
- Tartalom: a LeanQuantum inspirációja; a Small Quantum Intermediate Representation

### D. SPECIÁLIS — a „8-tick" és a „Recognition Science"

#### 9. shape-of-logic / QuantumErrorCorrection.lean (Lean 4 — az 8-tick!)
- URL: https://github.com/jonwashburn/shape-of-logic/blob/main/IndisputableMonolith/Information/QuantumErrorCorrection.lean
- Tartalom: EightTickCode (n_physical=8, n_logical=1, uses_8tick=true), CSS-kódok, **Steane [[7,1,3]]** (a [7,4,3] Hamming + [7,3,4]), surface codes, a „8-tick connection" (|0_L⟩ = (|0⟩+|4⟩)/√2, |1_L⟩ = (|2⟩+|6⟩)/√2)
- Különlegesség: **az 8-tick = a projekt [[7,1,3]] Steane-kódjának 7+1 dimenziója!** (a 7 bit [idő, okság, tér, szín, hang, fázis, mód] + 1 chiralitás; a 8. tick a chiralitás)

### E. ÁLTALÁNOS ALGEBRA

#### 10. agda-algebras (Agda — az univerzális algebra)
- URL: https://github.com/ualib/agda-algebras
- Tartalom: az univerzális algebra (csoportok, gyűrűk, testek, hálóalgebrák) formalizálása
- Különlegesség: az algebrai struktúrák általános kerete

## A lefedettség elemzése (a 50 kategóriaelméleti + a fizikai fogalmak)

| Fogalom | Megvan? | A forrás |
|---|---|---|
| Kategória, funktor, adjunkció, Yoneda, Kan, monad, limit, toposz | ✓ (6 kategoriaelmeleti konyvtar) | agda-categories, agda-unimath, Cat_on_Coq, Mathlib, catagi |
| Pauli-mátrixok, Hadamard, CNOT, kvantum-kapuk | ✓ | LeanQuantum, QuantumLib |
| Stabilizátor-kódok, CSS, Steane [[7,1,3]], Shor, toric | ✓ | QECLean, Lean-QEC |
| Tenzor-hálózatok, MPS, PEPS | ✓ | TNLean |
| Holografikus kódok, HaPPY | ✓ | LEGO_HQEC |
| Kompakt zárt kategória (caps and cups) | ✓ (részben) | t6s/qecc (a kqm.v) |
| **Dagger kategória** | ✗ (NINCS) | SAJÁT |
| **Szalagos kategória (ribbon)** | ✗ (NINCS) | SAJÁT |
| **Nyom (trace)** | ✓ (részben) | t6s/qecc (density) |
| **E8 gyökrendszer** | ✓ (a projekt) | KostantFelbontás_v2 |
| **CPT-buborék** | ✗ (NINCS) | SAJÁT |
| **8-tick connection** | ✓ | shape-of-logic |

## A döntés

Az Idris2 a főnyelv (a hard rule szerint). A meglévő könyvtárak KONCEPCIÓIT és BIZONYÍTÁS-STRUKTÚRÁIT adaptáljuk Idris2-be:
- a **QECLean** Steane [[7,1,3]] + toric code struktúrája (a projekt hibajavító kódjához — az őr a §24 szerint: IMPORT, nem újraírás)
- a **TNLean** MPS/PEPS fundamentális tétele (a holografikus kódokhoz)
- a **LeanQuantum** Pauli-operátor-algebra + a `solve_matrix` taktika (a Pauli-mátrixokhoz)
- a **catagi** YonedaAttention + ToposCausal (a gráf kutatási keretrendszerhez — az előző naplóban)
- a **t6s/qecc** caps and cups (a kompakt zárt kategóriához — az E8×E8×E8 kapcsolat)
- a **shape-of-logic** 8-tick connection (a [[7,1,3]] 7+1 dimenziójához)

A **dagger kategória**, a **szalagos kategória** és a **CPT-buborék** NINCSSENEK egyetlen könyvtárban sem — ezeket a projekt SAJÁT magának kell implementálnia. Ez a projekt EREDETI hozzájárulása.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★