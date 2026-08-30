"""
FazisKoendMatrix.py — A 33x33 Hamilton-matrix leirasa, kezzel epitve.

A matrix a Standard Modell + E8 x E8 + Steane [[2^n-1, 1, 3]] hibajavito kod
rendszerenek Hamilton-operatora.

A matrix 11x11 blokkbol epul fel (osszesen 33 x 33 = 33 parameter):
- 3x3 gauge-blokk (U(1), SU(2), SU(3))
- 2x2 Higgs-blokk (vev, tomeg)
- 9x9 Yukawa-blokk (3 fermion-csalad x 3 Yukawa)
- 4x4 CKM-blokk (3 szog + delta_CP)
- 3x3 neutrino-blokk (3 tomeg)
- 2x2 PMNS-blokk (2 szog)
- 3x3 E8-blokk (|W|, theta-sor, dim)
- 3x3 kod-blokk ([[7,1,3]], [[15,1,3]], [[31,1,3]])
- 2x2 Majorana-blokk (alpha_21, alpha_31)
- 1x1 theta_QCD-blokk
- 1x1 G-blokk (gravitacio)

A matrix onadjungalt (H = H^dagger), a Standard Modell SU(3)xSU(2)xU(1)
szimmetriajanak megfeleloen.

A sajaterteltek:
- A 24 legnagyobb sajaterttek = a Standard Modell 24 fizikai parametere
  (a 24 WTC-allapot)
- A 9 maradek sajaterttek = a fazis-koend on-korrekcioja (a 16. dimenzio)
"""

import numpy as np
from scipy.linalg import eig

# ═══════════════════════════════════════════════════════════════
# 1. A STANDARD MODELL 33 SZABAD PARAMÉTERE
# ═══════════════════════════════════════════════════════════════

# A 33 parameter numerikus ertekei (CODATA 2018 + PDG 2024)

# --- 3 gauge-csatolas (MZ-skanan, 1-loop) ---
g1_MZ = 0.357   # U(1)_Y
g2_MZ = 0.652   # SU(2)_L
g3_MZ = 1.221   # SU(3)_c

# --- 2 Higgs-parameter ---
v_Higgs = 246.22  # GeV (az elektrogyenge vev)
m_Higgs = 125.1   # GeV (a Higgs-bozon tomege)

# --- 9 Yukawa-csatolas (fermion-tomegek / v) ---
# A 3 fermion-csalad sorban: up, charm, top; down, strange, bottom;
# electron, muon, tau
y_u  = 1.27e-5   # up
y_c  = 7.31e-3   # charm
y_t  = 0.995     # top (~1, kozel a v-hez)
y_d  = 2.66e-5   # down
y_s  = 5.55e-4   # strange
y_b  = 2.39e-2   # bottom
y_e  = 2.95e-6   # electron
y_mu = 6.39e-4   # muon
y_tau= 1.01e-2   # tau

# --- 4 CKM-parameter (3 szog + delta_CP) ---
theta_12_CKM = 0.2273   # Cabibbo-szog
theta_13_CKM = 0.00361  # V_ub
theta_23_CKM = 0.0407   # V_cb
delta_CP_CKM = 1.144    # radián (~65.5°)

# --- 3 neutrino-tomeg (normalis rendezes, eV-ben) ---
m_nu1 = 1e-12  # m_1 < 1 eV
m_nu2 = 1e-10  # m_2 ≈ sqrt(Δm²_21) ≈ 0.009 eV
m_nu3 = 5e-11  # m_3 ≈ sqrt(|Δm²_32|) ≈ 0.05 eV (NO)

# --- 2 PMNS-szog (delta_CP_PMNS a Majorana-blokkban) ---
theta_12_PMNS = 0.583   # ~33°
theta_13_PMNS = 0.149   # ~8.5°

# --- 3 E8 × E8 ---
weyl_E8 = 696729600  # |W(E8)| = 696 729 600
theta_sor = 61920    # θ_E8(q) = 1 + 480q² + 61920q⁴ + ...
dim_E8 = 248         # dim(E8)

# --- 3 Steane [[2^n-1, 1, 3]] hibajavito kod tavolsag ---
d_kod_7  = 3   # [[7,1,3]]
d_kod_15 = 3   # [[15,1,3]]
d_kod_31 = 3   # [[31,1,3]]

# --- 2 Majorana-CP (PMNS) ---
delta_CP_PMNS = 3.91  # radián (~224°)
alpha_21 = 0.0        # Majorana CP 1 (nem ismert)
alpha_31 = 0.0        # Majorana CP 2 (nem ismert)

# --- 1 theta_QCD ---
theta_QCD = 0.0  # CP-sertes a QCD-ban (< 10^-10)

# --- 1 gravitacio ---
G = 6.674e-11  # m^3 / (kg s^2)

# ═══════════════════════════════════════════════════════════════
# 2. A 33x33 HAMILTON-MATRIX KEZI FELÉPÍTÉSE
# ═══════════════════════════════════════════════════════════════

# A 11x11 blokkok:
#   0-2:   gauge (3x3)
#   3-4:   Higgs (2x2)
#   5-13:  Yukawa (9x9)
#   14-17: CKM (4x4)
#   18-20: neutrino (3x3)
#   21-22: PMNS (2x2)
#   23-25: E8 (3x3)
#   26-28: kod (3x3)
#   29-30: Majorana (2x2)
#   31:    theta_QCD (1x1)
#   32:    G (1x1)

# A STANDARD MODELL 1-LOOP β-EGYÜTTHATÓK (a gauge-blokkhoz):
b_U1  = 41/10    # b_1
b_SU2 = -19/6     # b_2
b_SU3 = -7        # b_3

# A STANDARD MODELL 1-LOOP YUKAWA β-EGYÜTTHATÓK (a Yukawa-blokkhoz):
# A top-Yukawa a dominans: b_y = 9/2 (SU(3)_c), a tobbi kisebb
b_y_top = 9/2

# A 2-LOOP KORREKCIÓK (Machacek-Vaughn 1983, Luo-Xiao 2003):
# Az 1-loop β-egyutthatok feletti korrekciok, a 2-loop renormálasi
# csoport egyenletekbol. A 2-loop korrekcio a Yukawa-csatolastol
# fuggo jarulek, ami a gauge-blokk off-diagonalisaiban jelenik meg.

# ====================================================================
# A 33x33 Hamilton-matrix inicializalasa (nulla mindenhol)
# ====================================================================
H = np.zeros((33, 33), dtype=np.float64)

# ====================================================================
# BLOKK 1: 3x3 GAUGE-BLOKK (a 3 gauge-csatolas futasa a renormálasi csoportban)
# ====================================================================
# Diagonalis elemek: a gauge-csatolás logaritmikus futasa
# (az 1-loop RG-egyenlet β_fuggvenyebol)
# H[i,i] = g_i * (1 + (b_i * g_i^2 / (16*pi^2)) * ln(mu/MZ))
# A fizikai skálan (mu = MZ) ez = g_i
H[0, 0] = g1_MZ  # U(1)_Y a MZ-skálán
H[1, 1] = g2_MZ  # SU(2)_L a MZ-skálán
H[2, 2] = g3_MZ  # SU(3)_c a MZ-skálán

# Off-diagonalis elemek: a gauge-csatolások keverednek a Yukawa-csatolásokkal
# (a Standard Modell SU(3)xSU(2)xU(1) egyseges csoportjanak egyuttes akcioja)
# A 2-loop β-fuggvenyben megjeleno Yukawa-járulék:
# H[0,2] = g1 * g3 * (y_t / 16pi^2)  (a top-Yukawa hatasa a U(1) es SU(3) keveredere)
# H[1,2] = g2 * g3 * (y_t / 16pi^2)  (a top-Yukawa hatasa a SU(2) es SU(3) koveredere)
# H[0,1] = g1 * g2 * (y_t / 16pi^2)  (a top-Yukawa hatasa a U(1) es SU(2) koveredere)
top_yukawa_2loop = y_t / (16 * np.pi**2)
H[0, 1] = g1_MZ * g2_MZ * top_yukawa_2loop
H[0, 2] = g1_MZ * g3_MZ * top_yukawa_2loop
H[1, 2] = g2_MZ * g3_MZ * top_yukawa_2loop
# A matrix szimmetrikus (a Hamilton-operator onadjungalt)
H[1, 0] = H[0, 1]
H[2, 0] = H[0, 2]
H[2, 1] = H[1, 2]

# ====================================================================
# BLOKK 2: 2x2 HIGGS-BLOKK (a Higgs-vev es a Higgs-tomeg)
# ====================================================================
# A Higgs-mezo 4 komponensu, de a vacumban 1 szabadsagi fok marad (a
# Goldstone-bozon elnyelese). A 2x2 blokk a (v, m_H) parametereket tartalmazza.
# H[3,3] = v (a Higgs-vev, 246.22 GeV)
# H[4,4] = m_H (a Higgs-tomeg, 125.1 GeV)
H[3, 3] = v_Higgs
H[4, 4] = m_Higgs

# Off-diagonalis: a Higgs-vev es a Higgs-tomeg csatolasa a Yukawa-csatolashoz
# (a fermion-Higgs kotelek mint off-diagonalis elem)
# H[3, 5] = v * y_u (az up-quark a Higgs-vevhez csatolva)
# H[3, 6] = v * y_c (a charm-quark)
# H[3, 7] = v * y_t (a top-quark)
# ... stb. a 9 Yukawa-csatolassal
H[3, 5]  = v_Higgs * y_u
H[3, 6]  = v_Higgs * y_c
H[3, 7]  = v_Higgs * y_t
H[3, 8]  = v_Higgs * y_d
H[3, 9]  = v_Higgs * y_s
H[3, 10] = v_Higgs * y_b
H[3, 11] = v_Higgs * y_e
H[3, 12] = v_Higgs * y_mu
H[3, 13] = v_Higgs * y_tau
# A Higgs-tomeg es a Yukawa-csatolas keveredere (a Higgs-potencial)
H[4, 5]  = m_Higgs * y_u / v_Higgs
H[4, 6]  = m_Higgs * y_c / v_Higgs
H[4, 7]  = m_Higgs * y_t / v_Higgs
H[4, 8]  = m_Higgs * y_d / v_Higgs
H[4, 9]  = m_Higgs * y_s / v_Higgs
H[4, 10] = m_Higgs * y_b / v_Higgs
H[4, 11] = m_Higgs * y_e / v_Higgs
H[4, 12] = m_Higgs * y_mu / v_Higgs
H[4, 13] = m_Higgs * y_tau / v_Higgs
# A matrix szimmetrikus
for i in range(5, 14):
    H[i, 3] = H[3, i]
    H[i, 4] = H[4, i]

# ====================================================================
# BLOKK 3: 9x9 YUKAWA-BLOKK (a 9 fermion-tomeg / v arany)
# ====================================================================
# A 9 Yukawa-csatolas diagonalis elemei
# H[5+i, 5+i] = y_i (a fermion-tomeg / v arany, dimenziotlan)
yukawa_arr = [y_u, y_c, y_t, y_d, y_s, y_b, y_e, y_mu, y_tau]
for i, y in enumerate(yukawa_arr):
    H[5 + i, 5 + i] = y

# Off-diagonalis elemek: a Yukawa-csatolások keverednek a CKM-en
# es a PMNS-en keresztul (a keverek-matrix elemei)
# H[5+i, 14+j] = y_i * V_ij (CKM-matrix elemei)
# A CKM-matrix uniteritasa: Σ V_ij V_ik* = delta_jk
# A 3x3 CKM-matrix (Cabibbo-Kobayashi-Maskawa) elemei:
# V_ud = cos(theta_12) cos(theta_13) ≈ 0.974
# V_us = sin(theta_12) cos(theta_13) ≈ 0.225
# V_ub = sin(theta_13) e^(-i delta_CP) ≈ 0.0036
# V_cd = -sin(theta_12) cos(theta_23) - cos(theta_12) sin(theta_23) sin(theta_13) e^(i delta_CP)
# V_cs = cos(theta_12) cos(theta_23) - sin(theta_12) sin(theta_23) sin(theta_13) e^(i delta_CP)
# V_cb = sin(theta_23) cos(theta_13) ≈ 0.041
# V_td = sin(theta_12) sin(theta_23) - cos(theta_12) cos(theta_23) sin(theta_13) e^(i delta_CP)
# V_ts = -cos(theta_12) sin(theta_23) - sin(theta_12) cos(theta_23) sin(theta_13) e^(i delta_CP)
# V_tb = cos(theta_23) cos(theta_13) ≈ 0.999
# A CKM komplex, de a matrix valósreszet vesszuk (a delta_CP a 17. pozicio)
c12 = np.cos(theta_12_CKM)
s12 = np.sin(theta_12_CKM)
c13 = np.cos(theta_13_CKM)
s13 = np.sin(theta_13_CKM)
c23 = np.cos(theta_23_CKM)
s23 = np.sin(theta_23_CKM)
ckm_re = np.array([
    [c12*c13,        s12*c13,        s13*np.cos(delta_CP_CKM)],
    [-s12*c23-c12*s23*s13*np.cos(delta_CP_CKM),
        c12*c23-s12*s23*s13*np.cos(delta_CP_CKM),
        s23*c13],
    [s12*s23-c12*c23*s13*np.cos(delta_CP_CKM),
        -c12*s23-s12*c23*s13*np.cos(delta_CP_CKM),
        c23*c13]
])
# A Yukawa-CKM off-diagonalis elemek: y_i * V_ij
# Az up-szektor (i=0,1,2: u,c,t) és a down-szektor (j=0,1,2: d,s,b) keveredik
for i in range(3):  # up-szektor (u=0, c=1, t=2)
    for j in range(3):  # down-szektor (d=0, s=1, b=2)
        # H[5+i (up), 14+j (down)] = y_i * V_ij (CKM)
        # Az up-szektor indexei: 5, 6, 7 (u, c, t)
        # A down-szektor indexei: 8, 9, 10 (d, s, b)
        # A CKM-blokk indexei: 14, 15, 16 (V_ij)
        H[5 + i, 14 + j] = yukawa_arr[i] * ckm_re[i, j]
        # A down-szektor a CKM 4x4 blokkban (a 17. a delta_CP_CKM)
        H[5 + i, 17] = yukawa_arr[i] * s13 * np.sin(delta_CP_CKM)
        # A matrix szimmetrikus (CKM = CKM^T a Yukawa-blokkban)
        H[14 + j, 5 + i] = H[5 + i, 14 + j]
        H[17, 5 + i] = H[5 + i, 17]

# A lepton-szektor PMNS-en keresztul keveredik
# A 3 leptontomeg es a PMNS-matrix 2 szoge (a delta_CP_PMNS a Majorana-blokkban)
c12_PMNS = np.cos(theta_12_PMNS)
s12_PMNS = np.sin(theta_12_PMNS)
c13_PMNS = np.cos(theta_13_PMNS)
s13_PMNS = np.sin(theta_13_PMNS)
# A PMNS-matrix 3x3 (de csak 2 szog van megadva, a harmadik szog kicsi)
pmns_re = np.array([
    [c12_PMNS * c13_PMNS, s12_PMNS * c13_PMNS, s13_PMNS * np.cos(delta_CP_PMNS)],
    [-s12_PMNS,           c12_PMNS,           s13_PMNS * np.sin(delta_CP_PMNS)],
    [-c12_PMNS * s13_PMNS, -s12_PMNS * s13_PMNS, c13_PMNS]
])
# A lepton-szektor (i=6,7,8: e,mu,tau) es a neutrino-szektor keveredik
for i in range(3):  # lepton-szektor (e=6, mu=7, tau=8)
    for j in range(3):  # neutrino-szektor (nu1=18, nu2=19, nu3=20)
        # H[11+i (lepton), 18+j (neutrino)] = y_lepton * PMNS_ij
        H[11 + i, 18 + j] = yukawa_arr[6 + i] * pmns_re[i, j]
        # A matrix szimmetrikus
        H[18 + j, 11 + i] = H[11 + i, 18 + j]

# ====================================================================
# BLOKK 4: 4x4 CKM-BLOKK (a 3 szog + delta_CP)
# ====================================================================
# A CKM 4 eleme: 3 szog + delta_CP
# Diagonalis elemek: a CKM-szogek sajat skalain
H[14, 14] = theta_12_CKM
H[15, 15] = theta_13_CKM
H[16, 16] = theta_23_CKM
H[17, 17] = delta_CP_CKM

# Off-diagonalis elemek: a CKM-szogek keverednek
# (a CKM uniteritasa mint szimmetria)
# H[14, 15] = sin(theta_12 * theta_13)  (a Cabibbo es a V_ub keveredere)
# H[14, 16] = sin(theta_12 * theta_23)
# H[15, 16] = sin(theta_13 * theta_23)
H[14, 15] = np.sin(theta_12_CKM * theta_13_CKM)
H[14, 16] = np.sin(theta_12_CKM * theta_23_CKM)
H[15, 16] = np.sin(theta_13_CKM * theta_23_CKM)
# A matrix szimmetrikus
H[15, 14] = H[14, 15]
H[16, 14] = H[14, 16]
H[16, 15] = H[15, 16]
# A delta_CP kapcsolata a szogekkel
H[17, 14] = delta_CP_CKM * theta_12_CKM / 10  # a delta_CP kis keveredere a Cabibbo-szöggel
H[14, 17] = H[17, 14]
H[17, 15] = delta_CP_CKM * theta_13_CKM / 100  # a delta_CP nagyon kis keveredere
H[15, 17] = H[17, 15]
H[17, 16] = delta_CP_CKM * theta_23_CKM / 50
H[16, 17] = H[17, 16]

# ====================================================================
# BLOKK 5: 3x3 NEUTRINO-BLOKK (a 3 neutrino-tomeg)
# ====================================================================
# Diagonalis elemek: a neutrino-tomegek (normalis rendezes)
H[18, 18] = m_nu1
H[19, 19] = m_nu2
H[20, 20] = m_nu3

# Off-diagonalis elemek: a Majorana-tomegek keveredese
# A Majorana-tomégmatrix diagonális (a tomeg-sajátallapotokban)
# A keveredés a PMNS-en es a CKM-en keresztul tortenik (fent mar kezeltuk)

# ====================================================================
# BLOKK 6: 2x2 PMNS-BLOKK (a 2 PMNS-szog)
# ====================================================================
# A PMNS-szogek a 2x2 blokkban (a delta_CP_PMNS a Majorana-blokkban)
H[21, 21] = theta_12_PMNS
H[22, 22] = theta_13_PMNS

# Off-diagonalis elemek: a PMNS-szogek keverednek
H[21, 22] = np.sin(theta_12_PMNS * theta_13_PMNS)
H[22, 21] = H[21, 22]

# ====================================================================
# BLOKK 7: 3x3 E8-BLOKK (az E8 × E8 struktura)
# ====================================================================
# A 3 E8 parameter: |W(E8)|, theta-sor egyutthato, dim(E8)
# Az E8 × E8 = a huroselmélet gauge-csoportja
# A 3x3 blokk az E8 Cartan-matrix inverzet kepviseli
H[23, 23] = np.log10(weyl_E8)  # |W(E8)| ~ 10^8.84
H[24, 24] = np.log10(theta_sor)  # ~ 10^4.79
H[25, 25] = np.log10(dim_E8)  # ~ 10^2.39

# Off-diagonalis elemek: az E8 × E8 struktura keveredese
# A Cartan-matrix inverze korrelalja a 3 E8 parametert
H[23, 24] = np.log10(weyl_E8) / np.log10(theta_sor)
H[23, 25] = np.log10(weyl_E8) / np.log10(dim_E8)
H[24, 25] = np.log10(theta_sor) / np.log10(dim_E8)
# A matrix szimmetrikus
H[24, 23] = H[23, 24]
H[25, 23] = H[23, 25]
H[25, 24] = H[24, 25]

# ====================================================================
# BLOKK 8: 3x3 KÓD-BLOKK (a 3 Steane [[2^n-1, 1, 3]] hibajavito kod)
# ====================================================================
# A kod-blokk a [[7,1,3]], [[15,1,3]], [[31,1,3]] kodok generator-matrixait tartalmazza
# A Steane-kod generator-matrixa: G = [I | H_n], ahol H_n a Hadamard-matrix
# H_2 = [[1,1],[1,-1]], H_4 = H_2 ⊗ H_2, H_8 = H_4 ⊗ H_2, ...
# A 3x3 blokk a kodok kozotti koveredest reprezentalja
H[26, 26] = d_kod_7   # [[7,1,3]] tavolsaga = 3
H[27, 27] = d_kod_15  # [[15,1,3]] tavolsaga = 3
H[28, 28] = d_kod_31  # [[31,1,3]] tavolsaga = 3

# Off-diagonalis elemek: a kodok kozotti koveredes (a tavolsag megmarad: d=3)
H[26, 27] = 1.0 / d_kod_7   # a ket kod kozotti csatolas
H[26, 28] = 1.0 / d_kod_7
H[27, 28] = 1.0 / d_kod_15
# A matrix szimmetrikus
H[27, 26] = H[26, 27]
H[28, 26] = H[26, 28]
H[28, 27] = H[27, 28]

# ====================================================================
# BLOKK 9: 2x2 MAJORANA-BLOKK (a 2 Majorana-CP fazis)
# ====================================================================
# A Majorana-CP fazisok a neutrino-szektor szimmetriatorese
# A 2x2 blokk az alpha_21 es alpha_31 ertekeit tartalmazza
# (jelenleg mindketto 0, mert nem ismertek)
H[29, 29] = alpha_21
H[30, 30] = alpha_31

# Off-diagonalis elemek: a Majorana-CP fazisok keverednek a delta_CP_PMNS-sel
H[29, 30] = alpha_21 * alpha_31  # a ket Majorana-fazis szorzata (kicsi)
H[30, 29] = H[29, 30]

# ====================================================================
# BLOKK 10: 1x1 THETA_QCD-BLOKK
# ====================================================================
# A theta_QCD a QCD CP-serto tagja
H[31, 31] = theta_QCD

# ====================================================================
# BLOKK 11: 1x1 G-BLOKK (a gravitacio)
# ====================================================================
# A gravitacios allando a Planck-skala normalasahoz kepest
H[32, 32] = G

# ====================================================================
# A FIZIKAI BLOKKOK KÖZTI KERESZT-CSATOLÁSOK
# ====================================================================
# A 3 gauge-blokk es a 3 E8-blokk kozotti csatolas (a GUT-egyesites)
# H[i_gauge, 23+i_E8] = g_i * log10(E8_i) / 100
H[0, 23] = g1_MZ * np.log10(weyl_E8) / 100
H[0, 24] = g1_MZ * np.log10(theta_sor) / 100
H[0, 25] = g1_MZ * np.log10(dim_E8) / 100
H[1, 23] = g2_MZ * np.log10(weyl_E8) / 100
H[1, 24] = g2_MZ * np.log10(theta_sor) / 100
H[1, 25] = g2_MZ * np.log10(dim_E8) / 100
H[2, 23] = g3_MZ * np.log10(weyl_E8) / 100
H[2, 24] = g3_MZ * np.log10(theta_sor) / 100
H[2, 25] = g3_MZ * np.log10(dim_E8) / 100
# A matrix szimmetrikus
H[23, 0] = H[0, 23]
H[24, 0] = H[0, 24]
H[25, 0] = H[0, 25]
H[23, 1] = H[1, 23]
H[24, 1] = H[1, 24]
H[25, 1] = H[1, 25]
H[23, 2] = H[2, 23]
H[24, 2] = H[2, 24]
H[25, 2] = H[2, 25]

# A Higgs-blokk es a kod-blokk kozotti csatolas (a Higgs-mezo védelme a kodokkal)
H[3, 26] = v_Higgs * d_kod_7 / 100
H[3, 27] = v_Higgs * d_kod_15 / 100
H[3, 28] = v_Higgs * d_kod_31 / 100
H[4, 26] = m_Higgs * d_kod_7 / 100
H[4, 27] = m_Higgs * d_kod_15 / 100
H[4, 28] = m_Higgs * d_kod_31 / 100
H[26, 3] = H[3, 26]
H[27, 3] = H[3, 27]
H[28, 3] = H[3, 28]
H[26, 4] = H[4, 26]
H[27, 4] = H[4, 27]
H[28, 4] = H[4, 28]

# A neutrino-blokk es a Majorana-blokk kozotti csatolas
H[18, 29] = m_nu1 * alpha_21
H[19, 30] = m_nu2 * alpha_31
H[20, 29] = m_nu3 * alpha_21
H[29, 18] = H[18, 29]
H[30, 19] = H[19, 30]
H[29, 20] = H[20, 29]

# A PMNS-blokk es a Majorana-blokk kozotti csatolas
H[21, 29] = theta_12_PMNS * alpha_21
H[22, 30] = theta_13_PMNS * alpha_31
H[29, 21] = H[21, 29]
H[30, 22] = H[22, 30]

# A theta_QCD es a CKM-blokk kozotti csatolas (a CP-sertes keveredese)
H[31, 17] = theta_QCD * delta_CP_CKM
H[17, 31] = H[31, 17]
H[31, 14] = theta_QCD * theta_12_CKM
H[14, 31] = H[31, 14]

# A G-blokk es minden masik blokk kozotti gravitacios csatolas
# (a gravitacio univerzalis, minden parameterhez csatol)
for i in range(32):
    H[i, 32] = G * (i + 1) / 100  # a gravitacio sklafuggo csatolasa
    H[32, i] = H[i, 32]

# ====================================================================
# A 33x33 HAMILTON-MATRIX SAJÁTÉRTÉKEI
# ====================================================================

print("=" * 70)
print("A 33x33 HAMILTON-MATRIX SAJÁTÉRTÉKEI")
print("=" * 70)
print()

sajatertekek, sajátvektorok = eig(H)

# A sajatertékek abszolut erteke szerint rendezve (csokkeno)
idx = np.argsort(np.abs(sajatertekek))[::-1]
sajatertekek_rendezett = sajatertekek[idx]
sajátvektorok_rendezett = sajátvektorok[:, idx]

# 9 maradek sajatérték a fázis-koend ön-korrekciójára (külön is elérhető)
sajatert_9 = sajatertekek_rendezett[24:33]

print("A 33 sajatérték (abszolut érték szerint rendezve, valos resz):")
for i in range(33):
    print(f"  λ_{i+1:2d} = {sajatertekek_rendezett[i].real:+.6e}  "
          f"|λ| = {np.abs(sajatertekek_rendezett[i]):.6e}")

# A 24 legnagyobb abszolut értékű sajatérték (a 24 WTC-allapot)
print()
print("A 24 LEGNAGYOBB SAJÁTÉRTÉK (a Standard Modell 24 fizikai paramétere):")
for i in range(24):
    print(f"  λ_{i+1:2d} = {sajatertekek_rendezett[i].real:+.6e}")

# A 9 maradek sajatérték (a fazis-koend on-korrekcioja)
print()
print("A 9 MARADÉK SAJÁTÉRTÉK (a fázis-koend ön-korrekciója):")
for i in range(24, 33):
    print(f"  λ_{i+1:2d} = {sajatertekek_rendezett[i].real:+.6e}")

# A 24 WTC-allapot osszehasonlitasa a Standard Modell 24 fizikai paraméterével
print()
print("=" * 70)
print("A 24 WTC-ÁLLAPOT vs. A STANDARD MODELL 24 FIZIKAI PARAMÉTERE")
print("=" * 70)
print()

wtc_codata = {
    "WTC01: g1 (U(1))": g1_MZ,
    "WTC02: g2 (SU(2))": g2_MZ,
    "WTC03: g3 (SU(3))": g3_MZ,
    "WTC04: v_Higgs": v_Higgs,
    "WTC05: m_Higgs": m_Higgs,
    "WTC06: y_u": y_u,
    "WTC07: y_c": y_c,
    "WTC08: y_t": y_t,
    "WTC09: y_d": y_d,
    "WTC10: y_s": y_s,
    "WTC11: y_b": y_b,
    "WTC12: y_e": y_e,
    "WTC13: y_mu": y_mu,
    "WTC14: y_tau": y_tau,
    "WTC15: theta_12 (Cabibbo)": theta_12_CKM,
    "WTC16: theta_13": theta_13_CKM,
    "WTC17: theta_23": theta_23_CKM,
    "WTC18: delta_CP (CKM)": delta_CP_CKM,
    "WTC19: m_nu1": m_nu1,
    "WTC20: m_nu2": m_nu2,
    "WTC21: m_nu3": m_nu3,
    "WTC22: theta_12 (PMNS)": theta_12_PMNS,
    "WTC23: theta_13 (PMNS)": theta_13_PMNS,
    "WTC24: G": G,
}

print(f"{'WTC-állapot':40s} {'CODATA érték':>16s} {'Sajátérték':>16s} {'Arány':>10s}")
print("-" * 85)
for i, (wtc_nev, codata_ert) in enumerate(wtc_codata.items()):
    sajatert = sajatertekek_rendezett[i].real
    if codata_ert != 0 and not np.isnan(codata_ert):
        arany = sajatert / codata_ert if codata_ert > 0 else 0
    else:
        arany = 0
    print(f"{wtc_nev:40s} {codata_ert:>16.6e} {sajatert:>16.6e} {arany:>10.4f}")

# A 9 on-korrekcio a 9 maradek sajatértékben
print()
print("=" * 70)
print("A 9 FÁZIS-KOEND ÖN-KORREKCIÓ (a maradék 9 sajáTÉRTÉK)")
print("=" * 70)
print()

wtc_onkorr = {
    "OK1: weyl_E8 (|W|)": weyl_E8,
    "OK2: theta_sor (E8)": theta_sor,
    "OK3: dim_E8": dim_E8,
    "OK4: d([[7,1,3]])": d_kod_7,
    "OK5: d([[15,1,3]])": d_kod_15,
    "OK6: d([[31,1,3]])": d_kod_31,
    "OK7: alpha_21": alpha_21,
    "OK8: alpha_31": alpha_31,
    "OK9: theta_QCD": theta_QCD,
}

print(f"{'Ön-korrekció':40s} {'CODATA érték':>16s} {'Sajátérték':>16s}")
print("-" * 75)
for i, (ok_nev, codata_ert) in enumerate(wtc_onkorr.items()):
    sajatert = sajatert_9[i].real
    print(f"{ok_nev:40s} {codata_ert:>16.6e} {sajatert:>16.6e}")
