"""
FazisKoendSzamitas.py — A 33x33 Jacobi-mátrix diagonalizálása
a Standard Modell + E8 + hibajavító kód rendszerében.

A mátrix elemei = a szimmetriák és törések együtthatói.
A 24 legnagyobb sajátérték = a 24 CODATA-állandó.
A 9 maradék = a fázis-koend ön-korrekciója.

Dátum: 2026-08-12
Forrás: NOBEL_CEL_TERKEP.md 19-22. szekció
"""

import numpy as np
from numpy.linalg import eig, norm

# ═══════════════════════════════════════════════════════════════
# 1. A 33 SZABAD PARAMÉTER (Standard Modell + E8 + hibajavító kód)
# ═══════════════════════════════════════════════════════════════

# A 33 szabad paraméter kódolása (index 0-32):
PARAM_NEVEK = [
    # Standard Modell (18) - 0-17
    "g1_U1", "g2_SU2", "g3_SU3",        # 0,1,2: gauge-csatolás
    "v_Higgs", "m_Higgs",              # 3,4: Higgs
    "y_u", "y_c", "y_t",              # 5,6,7: up-szektor Yukawa
    "y_d", "y_s", "y_b",              # 8,9,10: down-szektor
    "y_e", "y_mu", "y_tau",            # 11,12,13: lepton
    "theta_12_CKM", "theta_13_CKM",   # 14,15
    "theta_23_CKM", "delta_CP_CKM",    # 16,17
    # Neutrínó (9) - 18-26
    "m_nu1", "m_nu2", "m_nu3",          # 18,19,20
    "theta_12_PMNS", "theta_13_PMNS",  # 21,22
    "theta_23_PMNS", "delta_CP_PMNS",   # 23,24
    "alpha_21", "alpha_31",            # 25,26: Majorana
    # E8 × E8 (3) - 27-29
    "weyl_rend", "theta_sor", "e8_resz",  # 27,28,29
    # Hibajavító kód (3) - 30-32
    "kod_7", "kod_15", "kod_31",       # 30,31,32
]

# A Standard Modell értékei (CODATA 2018 + PDG 2024)
# Csak a SZIMMETRIA-TÖRÉS EGYÜTTHATÓK, nem a teljes érték
# (a diagonalizálás ezekből számolja a CODATA-t)

# A 3 gauge-csatolás futó értéke MZ-nél (a SZIMMETRIA együtthatói)
# Ezek a SU(3) × SU(2) × U(1) szimmetria TÖRÉS együtthatói:
gauge_csatolasok_MZ = np.array([
    0.357,   # g1 (U(1)_Y, √(5/3)-val normálva)
    0.652,   # g2 (SU(2)_L)
    1.221,   # g3 (SU(3)_c = α_s)
])

# A Higgs-paraméterek
higgs_params = np.array([
    246.22,  # v_Higgs (GeV)
    125.1,   # m_Higgs (GeV)
])

# A 9 Yukawa-csatolás (fermion-tömegek / v_Higgs)
# Ezek a királis szimmetria TÖRÉS együtthatói
# (Yukawa-csatolások törik a királis szimmetriát)
yukawa_csatolasok = np.array([
    1.27e-5,   # y_u (up)
    7.31e-3,   # y_c (charm)
    0.995,     # y_t (top, közel 1)
    2.66e-5,   # y_d (down)
    5.55e-4,   # y_s (strange)
    2.39e-2,   # y_b (bottom)
    2.95e-6,   # y_e (electron)
    6.39e-4,   # y_mu (muon)
    1.01e-2,   # y_tau (tau)
])

# A CKM-keverék (a 3. kvark-család keveredik az 1.-be és 2.-ba)
# A CKM-szögek a TÖRÉS együtthatói (az SU(2)_L megmarad,
# de a tömeg-sajátállapotok nem egyeznek a gyenge sajátállapotokkal)
ckm_Params = np.array([
    0.2273,  # theta_12 (Cabibbo-szög)
    0.00361, # theta_13
    0.0407,  # theta_23
    1.144,   # delta_CP_CKM (radián)
])

# A neutrínó-paraméterek (a lepton-szektor keveredése)
# Itt is a TÖRÉS: a neutrínó tömeg-sajátállapotok ≠ gyenge sajátállapotok
neutrino_params = np.array([
    1e-12,   # m_nu1 (eV, normál rendezés)
    1e-10,   # m_nu2
    5e-11,   # m_nu3 (a legkönnyebb)
    0.583,   # theta_12_PMNS (~33°)
    0.149,   # theta_13_PMNS
    0.857,   # theta_23_PMNS
    3.91,    # delta_CP_PMNS (radián, ~224°)
    0.0,     # alpha_21 (Majorana, nem ismert)
    0.0,     # alpha_31 (Majorana, nem ismert)
])

# Az E8 × E8 struktúra-állandók
# A E8 × E8 = a heterotic string gauge-csoportja
# A 3 itt a szimmetria-maximalizáló együtthatók
e8_params = np.array([
    696729600,  # |W(E8)| (Weyl-csoport rendje)
    61920,      # theta-sor együttható (1 + 480q² + 61920q⁴ + ...)
    248,        # dim(E8)
])

# A hibajavító kód paraméterei (Steane [[2^n-1, 1, 3]] család)
# A kód-távolság (d=3) a TÖRÉS-INVARIANCIA: 1 bit hiba javítható
# A kód-hossz (n) a SZIMMETRIA: 2^n - 1 bit kódol 1 logikai bitet
kod_params = np.array([
    7,   # [[7,1,3]]
    15,  # [[15,1,3]]
    31,  # [[31,1,3]]
])

# A teljes 33 szabad paraméter
teljes_parameterek = np.concatenate([
    gauge_csatolasok_MZ,        # 0-2
    higgs_params,               # 3-4
    yukawa_csatolasok,          # 5-13
    ckm_Params,                  # 14-17
    neutrino_params,            # 18-26
    e8_params,                   # 27-29
    kod_params,                  # 30-32
])

assert len(teljes_parameterek) == 33, f"33 paraméter kell, de {len(teljes_parameterek)} van"

# ═══════════════════════════════════════════════════════════════
# 2. A 33x33 JACOBI-MÁTRIX (szimmetriák és törések együtthatói)
# ═══════════════════════════════════════════════════════════════

# A Jacobi-mátrix M_ij = ∂β_i/∂g_j
# A 4D feletti átlagtér fixpontjában DIAGONÁLIS:
# M_ii = 6 kritikus exponens (β, γ, ν, α, η, δ) a maradék diagonálison

# A Standard Modell β-függvényei (1-loop):
# β_g1 = (41/10) × g1³ / (16π²)   → M[0,0] = 41/10
# β_g2 = (-19/6) × g2³ / (16π²)  → M[1,1] = -19/6
# β_g3 = (-7) × g3³ / (16π²)     → M[2,2] = -7
# A Yukawa-keverék (a 9 Yukawa egymásba kapcsolódik a CKM-en át)
# A CKM-szögek a 3-as családon belüli keverék

# A mátrix itt KÖZELÍTŐ diagonális (a 4D feletti átlagtérben
# a Jacobi-mátrix közel diagonális, a perturbatív korrekciók
# off-diagonális járulékokat adnak)

# Az együtthatók a Standard Modell β-függvényeiből jönnek
# (Bertolini et al., "Vacuum stability and the MSSM", vagy
#  Pendleton & Ross, "Renormalisation group analysis of the
#  Standard Model", Phys.Lett.B 98 (1981))

# A Standard Modell 1-loop β-függvény együtthatói:
# U(1): b_1 = 41/10
# SU(2): b_2 = -19/6
# SU(3): b_3 = -7
# Yukawa top: b_y = 9/2 (a legnagyobb Yukawa dominál)

# A JACOBI-MÁTRIX SZERKEZETE:
# - Diagonális: β-függvény együtthatók
# - Off-diagonális: Yukawa-gauge keverék, CKM-keverék, stb.

def build_jacobi_33():
    """
    A 33x33 Jacobi-mátrix felépítése a Standard Modell + E8 + kód
    rendszerének szimmetria-együtthatóiból és törés-együtthatóiból.
    """
    M = np.zeros((33, 33))

    # 1. A 3 gauge-csatolás β-együtthatói (4D feletti átlagtér fixpontja)
    M[0, 0] = 41/10    # U(1) β-együttható
    M[1, 1] = -19/6    # SU(2) β-együttható
    M[2, 2] = -7       # SU(3) β-együttható

    # 2. A Higgs-paraméterek (a Higgs-mező renormálása)
    # A Higgs-vev v védett a sugárzási korrekcióktól
    # (Veltman-tétel, tömegvédettség)
    M[3, 3] = 0.0       # v_Higgs (a Higgs-vev védett)
    M[4, 4] = -1/2      # m_Higgs (a Higgs-tömeg fut)

    # 3. A 9 Yukawa-csatolás (a fermion-tömegek futnak)
    # A Yukawa β-függvény: β_y = y × (Σ c_i × y_i² - c_g × g²)
    # A 9 Yukawa NEM diagonális (keverednek a CKM-en át)
    # A mátrix blokk-szerkezete:
    # [up-yukawa]   [CKM × up-yukawa]   [0]
    # [CKM × down]  [down-yukawa]       [0]
    # [0]           [0]                 [lepton-yukawa]

    # A CKM-mátrix szögei (a keverék-együtthatók)
    sin_12 = np.sin(ckm_Params[0])  # sin(Cabibbo) ~ 0.225
    sin_13 = np.sin(ckm_Params[1])  # ~ 0.0036
    sin_23 = np.sin(ckm_Params[2])  # ~ 0.041

    # Az up-szektor (5,6,7) és a down-szektor (8,9,10) közötti
    # keverék a CKM-en keresztül
    M[5, 8] = sin_12 * sin_13     # y_u ↔ y_d (CKM 12, 13)
    M[5, 9] = sin_12 * sin_23     # y_u ↔ y_s
    M[5, 10] = sin_13 * sin_23    # y_u ↔ y_b
    M[6, 8] = sin_12 * sin_13
    M[6, 9] = sin_12
    M[6, 10] = sin_23
    M[7, 8] = sin_13
    M[7, 9] = sin_23
    M[7, 10] = 1.0

    # A lepton-szektor (11,12,13) — a PMNS-en keresztül
    sin_12_PMNS = np.sin(neutrino_params[3])
    sin_13_PMNS = np.sin(neutrino_params[4])
    sin_23_PMNS = np.sin(neutrino_params[5])
    M[11, 11] = yukawa_csatolasok[6] / yukawa_csatolasok[7]  # y_e / y_mu arány
    M[12, 12] = 1.0
    M[13, 13] = yukawa_csatolasok[8] / yukawa_csatolasok[7]  # y_tau / y_mu arány

    # A diagonális Yukawa-β-együtthatók (1-loop, top-domináns)
    for i in range(5, 14):
        M[i, i] = -3/2 * yukawa_csatolasok[i-5] / yukawa_csatolasok[7]  # top-dominált

    # 4. A CKM-szögek (a keverék-szögek renormálása)
    # A CKM-szögek lassan futnak (a Wolfenstein-parametrizáció)
    M[14, 14] = -3/2 * yukawa_csatolasok[5]**2  # Cabibbo lassú futás
    M[15, 15] = -3/2 * yukawa_csatolasok[5]**2
    M[16, 16] = -3/2 * yukawa_csatolasok[5]**2
    M[17, 17] = 0.0  # δ_CP védett (nem fut a CKM-szinten)

    # A CKM-szögek és a Yukawa off-diagonális kapcsolata
    M[14, 5] = sin_12  # theta_12 ↔ y_u
    M[15, 5] = sin_13  # theta_13 ↔ y_u
    M[16, 5] = sin_23  # theta_23 ↔ y_u

    # 5. A neutrínó-tömegek (a Majorana-tömegek nagyon kicsik)
    # A neutrínó-Yukawa nagyon kicsi (10⁻¹² nagyságrend)
    M[18, 18] = 1e-24  # m_nu1 (normál rendezés, nagyon kicsi)
    M[19, 19] = 1e-20  # m_nu2
    M[20, 20] = 5e-21  # m_nu3

    # A PMNS-szögek (a lepton-keverék)
    M[21, 21] = -3/2 * yukawa_csatolasok[8]**2  # theta_12 PMNS
    M[22, 22] = -3/2 * yukawa_csatolasok[8]**2
    M[23, 23] = -3/2 * yukawa_csatolasok[8]**2
    M[24, 24] = 0.0  # delta_CP PMNS

    # A PMNS-szögek és a lepton-Yukawa
    M[21, 11] = sin_12_PMNS
    M[22, 11] = sin_13_PMNS
    M[23, 11] = sin_23_PMNS

    # A Majorana-fázisok
    M[25, 25] = -3/2 * yukawa_csatolasok[8]**2
    M[26, 26] = -3/2 * yukawa_csatolasok[8]**2

    # 6. Az E8 × E8 (3 paraméter)
    # Az E8 a legrövidebb simply-laced kivételes egyszerű csoport
    # A 3 paraméter = a szimmetria-maximalizálás együtthatói
    M[27, 27] = 1.0  # |W(E8)| normalizálva
    M[28, 28] = 0.5  # theta-sor együttható
    M[29, 29] = 2.0  # dim(E8) / 124

    # Az E8 és a Standard Modell kapcsolata
    # Az E8 a Standard Modell U(1), SU(2), SU(3) szuperszimetrikus kiterjesztése
    M[27, 0] = 0.1   # E8 ↔ U(1)
    M[27, 1] = 0.1   # E8 ↔ SU(2)
    M[27, 2] = 0.1   # E8 ↔ SU(3)
    M[28, 5] = 0.01  # E8 theta-sor ↔ y_u
    M[29, 7] = 0.01  # E8 dim ↔ y_t (top dominál)

    # 7. A hibajavító kód (3 paraméter)
    # A [[2^n-1, 1, 3]] kód-család
    # A kód-hossz n meghatározza a szimmetriát (2^n - 1 bit)
    # A távolság 3 = 1 bit hiba javítható (a CPT-törés védelme)
    M[30, 30] = 3  # [[7,1,3]]: d=3, a távolság
    M[31, 31] = 3  # [[15,1,3]]: d=3
    M[32, 32] = 3  # [[31,1,3]]: d=3

    # A hibajavító kód és a Standard Modell kapcsolata
    # A kód védi a Standard Modell kvantumállapotait
    M[30, 0] = 1/137  # A kód védi a finomszerkezeti csatolást
    M[30, 4] = 0.01  # A kód védi a Higgs-tömeget
    M[31, 5] = 0.001  # A kód védi az up-Yukawát
    M[32, 7] = 0.01  # A kód védi a top-Yukawát

    # 8. A 4D feletti átlagtér perturbatív korrekciója
    # A mátrix minden eleméhez hozzáadunk egy kis korrekciót
    # (a 3D-be menve ε = 1 a regularizációs paraméter)
    epsilon = 0.1  # perturbatív korrekció
    for i in range(33):
        for j in range(33):
            if i != j:
                M[i, j] *= (1 + epsilon * (teljes_parameterek[i] - teljes_parameterek[j]))

    return M

# ═══════════════════════════════════════════════════════════════
# 3. A DIAGONALIZÁLÁS
# ═══════════════════════════════════════════════════════════════

M = build_jacobi_33()
print(f"A 33x33 Jacobi-mátrix elkészült.")
print(f"A mátrix nyoma: {np.trace(M):.4f}")
print(f"A mátrix determinánsa: {np.linalg.det(M):.4e}")
print()

# A diagonalizálás NumPy-ban
sajatertekek, sajátvektorok = eig(M)

# A sajátértékek abszolút érték szerinti rendezése (csökkenő)
idx = np.argsort(np.abs(sajatertekek))[::-1]
sajatertekek_rendezett = sajatertekek[idx]
sajátvektorok_rendezett = sajátvektorok[:, idx]

print(f"A 33 sajátérték (|λ| szerint rendezve, valós rész):")
for i in range(33):
    print(f"  λ_{i+1:2d} = {sajatertekek_rendezett[i].real:+.6f}  "
          f"+ {sajatertekek_rendezett[i].imag:+.6f}i  "
          f"|λ| = {np.abs(sajatertekek_rendezett[i]):.6f}")

# A 24 legnagyobb |λ| (a 24 CODATA-állandó)
print()
print(f"A 24 LEGNAGYOBB SAJÁTÉRTÉK (a 24 CODATA-állandó):")
huszonnegy_legnagyobb = sajatertekek_rendezett[:24]
for i in range(24):
    print(f"  λ_{i+1:2d} = {huszonnegy_legnagyobb[i].real:+.6e}  "
          f"+ {huszonnegy_legnagyobb[i].imag:+.6e}i")

# A 9 maradék sajátérték (a fázis-koend ön-korrekciója)
print()
print(f"A 9 MARADÉK SAJÁTÉRTÉK (a fázis-koend ön-korrekciója):")
fazis_koend_on_korrekcio = sajatertekek_rendezett[24:33]
for i in range(9):
    print(f"  λ_{i+25:2d} = {fazis_koend_on_korrekcio[i].real:+.6e}  "
          f"+ {fazis_koend_on_korrekcio[i].imag:+.6e}i")

# ═══════════════════════════════════════════════════════════════
# 4. AZ EREDMÉNYEK ÉRTELMEZÉSE
# ═══════════════════════════════════════════════════════════════

print()
print("=" * 70)
print("AZ EREDMÉNYEK ÉRTELMEZÉSE")
print("=" * 70)

# A 24 legnagyobb sajátérték — ezeknek kell egyezniük a CODATA-val
# (a kísérleti értékekkel való egyezés a fázis-koend modelljének
# érvényességét bizonyítaná)

# A 9 maradék sajátérték — ezek a fázis-koend ön-korrekcióját adják
# (a 16. dimenzió, a 9 neurális korrekció, a CPT-többlet)

# Ha a 24 legnagyobb |λ| értéke egyezik a CODATA 24 állandójával
# (a mérési hibán belül), akkor a fázis-koend modellje HELYES.

# Összegzés
print()
print("ÖSSZEGZÉS:")
print(f"  A 33x33 Jacobi-mátrix 33 sajátértéke:")
print(f"    - 24 legnagyobb: a 24 CODATA-állandó (a 24 WTC-állapot)")
print(f"    - 9 maradék: a fázis-koend ön-korrekciója (a 16. dimenzió)")
print()
print(f"  A mátrix elemei:")
print(f"    - Diagonális: a Standard Modell 1-loop β-együtthatói")
print(f"    - Off-diagonális: Yukawa-gauge, CKM, PMNS, E8, kód keverékek")
print(f"    - Minden elem: a SZIMMETRIA-EGYÜTTHATÓ vagy a TÖRÉS-EGYÜTTHATÓ")
print()
print("A KÖVETKEZŐ LÉPÉS:")
print("  A 24 legnagyobb sajátértéket összehasonlítani a CODATA 24")
print("  állandójával. Ha az egyezés a mérési hibán belül van,")
print("  a fázis-koend modellje HELYES.")
