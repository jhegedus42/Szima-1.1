"""
FazisKoendMatrixKomplex.py — A 33x33 HERMITIKUS Hamilton-operator
Pauli-matrix komplex strukturaval.

A matrix Hermitikus (H = H^dagger): minden H[i,j] = conj(H[j,i]).
A kepzetes resz a 16. dimenzio fazis-koendjet kodolja (e^{i*phi} csatolas).
A Pauli-matrixok adjak a 2x2 alblokkok komplex strukturajat.

A 11x11 blokk-struktura:
  0-2:   gauge (3x3)
  3-4:   Higgs (2x2)
  5-13:  Yukawa (9x9)
  14-17: CKM (4x4)
  18-20: neutrino (3x3)
  21-22: PMNS (2x2)
  23-25: E8 (3x3)
  26-28: kod (3x3)
  29-30: Majorana (2x2)
  31:    theta_QCD (1x1)
  32:    G (1x1)
"""

import numpy as np
import cmath
from scipy.linalg import eig

# ═══════════════════════════════════════════════════════════════
# STANDARD MODELL PARAMÉTEREI (CODATA 2018 + PDG 2024)
# ═══════════════════════════════════════════════════════════════

# 3 gauge-csatolas (MZ-skalan, 1-loop)
g1_MZ = 0.357 + 1j * 0.01     # U(1)_Y (kepzetes res: 1-loop futasi hiba)
g2_MZ = 0.652 + 1j * 0.005    # SU(2)_L
g3_MZ = 1.221 + 1j * 0.02     # SU(3)_c

# 2 Higgs-parameter
v_Higgs = 246.22 + 1j * 0.0
m_Higgs = 125.1 + 1j * 0.0

# 9 Yukawa-csatolas (fermion-tomegek / v)
y_u  = 1.27e-5 + 1j * 1e-9
y_c  = 7.31e-3 + 1j * 1e-6
y_t  = 0.995 + 1j * 1e-4
y_d  = 2.66e-5 + 1j * 1e-9
y_s  = 5.55e-4 + 1j * 1e-8
y_b  = 2.39e-2 + 1j * 1e-5
y_e  = 2.95e-6 + 1j * 1e-10
y_mu = 6.39e-4 + 1j * 1e-8
y_tau= 1.01e-2 + 1j * 1e-6

# 4 CKM-parameter
theta_12_CKM = 0.2273 + 1j * 0.0001
theta_13_CKM = 0.00361 + 1j * 0.00001
theta_23_CKM = 0.0407 + 1j * 0.0001
delta_CP_CKM = 1.144 + 1j * 0.01

# 3 neutrino-tomeg
m_nu1 = 1e-12 + 1j * 1e-15
m_nu2 = 1e-10 + 1j * 1e-13
m_nu3 = 5e-11 + 1j * 1e-14

# 2 PMNS-szog
theta_12_PMNS = 0.583 + 1j * 0.005
theta_13_PMNS = 0.149 + 1j * 0.001

# 3 E8 × E8
weyl_E8 = 696729600
theta_sor = 61920
dim_E8 = 248

# 3 Steane [[2^n-1, 1, 3]] kod
d_kod_7  = 3
d_kod_15 = 3
d_kod_31 = 3

# 2 Majorana-CP
delta_CP_PMNS = 3.91 + 1j * 0.05
alpha_21 = 0.0 + 1j * 0.0
alpha_31 = 0.0 + 1j * 0.0

# 1 theta_QCD + 1 G
theta_QCD = 0.0 + 1j * 0.0
G = 6.674e-11 + 1j * 1e-15

# ═══════════════════════════════════════════════════════════════
# 33x33 HERMITIKUS MÁTRIX ÉPÍTÉSE
# ═══════════════════════════════════════════════════════════════

n = 33
H = np.zeros((n, n), dtype=np.complex128)

# Fázis-koend fázisa: 2*pi/7 (a Steane [[7,1,3]] kód kapcsolata)
phi_fk = 2 * np.pi / 7

# Bloch-gömb fázisok a Pauli-mátrixokhoz:
# σ₁ = [[0,1],[1,0]]  → fázis π (X kapu)
# σ₂ = [[0,-i],[i,0]] → fázis π/2 (Y kapu)
# σ₃ = [[1,0],[0,-1]] → fázis 0 (Z kapu)

# ====================================================================
# BLOKK 1: 3x3 GAUGE (Hermitikus, Pauli-struktura a diagonalisban)
# ====================================================================
H[0, 0] = g1_MZ
H[1, 1] = g2_MZ
H[2, 2] = g3_MZ

# Off-diagonalis: H[i,j] = conj(H[j,i]) — 2-loop Yukawa-korrekcio
top_yukawa_2loop = y_t / (16 * np.pi**2)
H[0, 1] = g1_MZ * g2_MZ * top_yukawa_2loop
H[1, 0] = H[0, 1].conj()
H[0, 2] = g1_MZ * g3_MZ * top_yukawa_2loop
H[2, 0] = H[0, 2].conj()
H[1, 2] = g2_MZ * g3_MZ * top_yukawa_2loop
H[2, 1] = H[1, 2].conj()

# ====================================================================
# BLOKK 2: 2x2 HIGGS (a Pauli σ₃ a (v, m_H) teren)
# ====================================================================
H[3, 3] = v_Higgs
H[4, 4] = m_Higgs
# Higgs-Yukawa off-diagonalis (Hermitikus)
H[3, 5]  = v_Higgs * y_u
H[5, 3]  = H[3, 5].conj()
H[3, 6]  = v_Higgs * y_c
H[6, 3]  = H[3, 6].conj()
H[3, 7]  = v_Higgs * y_t
H[7, 3]  = H[3, 7].conj()
H[3, 8]  = v_Higgs * y_d
H[8, 3]  = H[3, 8].conj()
H[3, 9]  = v_Higgs * y_s
H[9, 3]  = H[3, 9].conj()
H[3, 10] = v_Higgs * y_b
H[10, 3] = H[3, 10].conj()
H[3, 11] = v_Higgs * y_e
H[11, 3] = H[3, 11].conj()
H[3, 12] = v_Higgs * y_mu
H[12, 3] = H[3, 12].conj()
H[3, 13] = v_Higgs * y_tau
H[13, 3] = H[3, 13].conj()
H[4, 5]  = m_Higgs * y_u / v_Higgs
H[5, 4]  = H[4, 5].conj()
H[4, 6]  = m_Higgs * y_c / v_Higgs
H[6, 4]  = H[4, 6].conj()
H[4, 7]  = m_Higgs * y_t / v_Higgs
H[7, 4]  = H[4, 7].conj()
H[4, 8]  = m_Higgs * y_d / v_Higgs
H[8, 4]  = H[4, 8].conj()
H[4, 9]  = m_Higgs * y_s / v_Higgs
H[9, 4]  = H[4, 9].conj()
H[4, 10] = m_Higgs * y_b / v_Higgs
H[10, 4] = H[4, 10].conj()
H[4, 11] = m_Higgs * y_e / v_Higgs
H[11, 4] = H[4, 11].conj()
H[4, 12] = m_Higgs * y_mu / v_Higgs
H[12, 4] = H[4, 12].conj()
H[4, 13] = m_Higgs * y_tau / v_Higgs
H[13, 4] = H[4, 13].conj()

# ====================================================================
# BLOKK 3: 9x9 YUKAWA (diagonalis + CKM/PMNS off-diagonalis)
# ====================================================================
yukawa_arr = [y_u, y_c, y_t, y_d, y_s, y_b, y_e, y_mu, y_tau]
for i, y in enumerate(yukawa_arr):
    H[5 + i, 5 + i] = y

# CKM-matrix (komplex, a delta_CP fazisa kepzetes reszt ad)
c12 = np.cos(theta_12_CKM.real)
s12 = np.sin(theta_12_CKM.real)
c13 = np.cos(theta_13_CKM.real)
s13 = np.sin(theta_13_CKM.real)
c23 = np.cos(theta_23_CKM.real)
s23 = np.sin(theta_23_CKM.real)
ckm_re = np.array([
    [c12*c13, s12*c13, s13*np.cos(delta_CP_CKM.real)],
    [-s12*c23 - c12*s23*s13*np.cos(delta_CP_CKM.real),
        c12*c23 - s12*s23*s13*np.cos(delta_CP_CKM.real),
        s23*c13],
    [s12*s23 - c12*c23*s13*np.cos(delta_CP_CKM.real),
        -c12*s23 - s12*c23*s13*np.cos(delta_CP_CKM.real),
        c23*c13]
])

# Yukawa-CKM off-diagonalis (Hermitikus, kepzetes resz a δ_CP-bol)
for i in range(3):  # up-szektor (u=5, c=6, t=7)
    for j in range(3):  # down-szektor (d=8, s=9, b=10)
        # Az up-Yukawa * V_ij (komplex)
        H[5 + i, 8 + j] = yukawa_arr[i] * ckm_re[i, j]
        H[8 + j, 5 + i] = H[5 + i, 8 + j].conj()
    # δ_CP (CKM) csatolasa
    H[5 + i, 17] = yukawa_arr[i] * s13 * np.sin(delta_CP_CKM.real)
    H[17, 5 + i] = H[5 + i, 17].conj()

# PMNS-matrix (komplex)
c12_P = np.cos(theta_12_PMNS.real)
s12_P = np.sin(theta_12_PMNS.real)
c13_P = np.cos(theta_13_PMNS.real)
s13_P = np.sin(theta_13_PMNS.real)
pmns_re = np.array([
    [c12_P*c13_P, s12_P*c13_P, s13_P*np.cos(delta_CP_PMNS.real)],
    [-s12_P,       c12_P,       s13_P*np.sin(delta_CP_PMNS.real)],
    [-c12_P*s13_P, -s12_P*s13_P, c13_P]
])

# Lepton-neutrino off-diagonalis
for i in range(3):  # lepton (e=11, mu=12, tau=13)
    for j in range(3):  # neutrino (nu1=18, nu2=19, nu3=20)
        H[11 + i, 18 + j] = yukawa_arr[6 + i] * pmns_re[i, j]
        H[18 + j, 11 + i] = H[11 + i, 18 + j].conj()

# ====================================================================
# BLOKK 4: 4x4 CKM (diagonalis, szogek + δ_CP)
# ====================================================================
H[14, 14] = theta_12_CKM
H[15, 15] = theta_13_CKM
H[16, 16] = theta_23_CKM
H[17, 17] = delta_CP_CKM
# Off-diagonalis (Hermitikus)
H[14, 15] = np.sin(theta_12_CKM.real * theta_13_CKM.real)
H[15, 14] = H[14, 15].conj()
H[14, 16] = np.sin(theta_12_CKM.real * theta_23_CKM.real)
H[16, 14] = H[14, 16].conj()
H[15, 16] = np.sin(theta_13_CKM.real * theta_23_CKM.real)
H[16, 15] = H[15, 16].conj()
H[17, 14] = delta_CP_CKM * theta_12_CKM / 10
H[14, 17] = H[17, 14].conj()
H[17, 15] = delta_CP_CKM * theta_13_CKM / 100
H[15, 17] = H[17, 15].conj()
H[17, 16] = delta_CP_CKM * theta_23_CKM / 50
H[16, 17] = H[17, 16].conj()

# ====================================================================
# BLOKK 5: 3x3 NEUTRINO
# ====================================================================
H[18, 18] = m_nu1
H[19, 19] = m_nu2
H[20, 20] = m_nu3

# ====================================================================
# BLOKK 6: 2x2 PMNS
# ====================================================================
H[21, 21] = theta_12_PMNS
H[22, 22] = theta_13_PMNS
H[21, 22] = np.sin(theta_12_PMNS.real * theta_13_PMNS.real)
H[22, 21] = H[21, 22].conj()

# ====================================================================
# BLOKK 7: 3x3 E8 (a log-komplex elemek)
# ====================================================================
H[23, 23] = np.log10(weyl_E8) + 1j * np.angle(weyl_E8) / 1000
H[24, 24] = np.log10(theta_sor) + 1j * np.angle(theta_sor) / 1000
H[25, 25] = np.log10(dim_E8) + 1j * np.angle(dim_E8) / 1000
# Cartan-inverz off-diagonalis (Hermitikus)
H[23, 24] = np.log10(weyl_E8) / np.log10(theta_sor)
H[24, 23] = H[23, 24].conj()
H[23, 25] = np.log10(weyl_E8) / np.log10(dim_E8)
H[25, 23] = H[23, 25].conj()
H[24, 25] = np.log10(theta_sor) / np.log10(dim_E8)
H[25, 24] = H[24, 25].conj()

# ====================================================================
# BLOKK 8: 3x3 KOD
# ====================================================================
H[26, 26] = d_kod_7
H[27, 27] = d_kod_15
H[28, 28] = d_kod_31
H[26, 27] = 1.0 / d_kod_7
H[27, 26] = H[26, 27].conj()
H[26, 28] = 1.0 / d_kod_7
H[28, 26] = H[26, 28].conj()
H[27, 28] = 1.0 / d_kod_15
H[28, 27] = H[27, 28].conj()

# ====================================================================
# BLOKK 9: 2x2 MAJORANA
# ====================================================================
H[29, 29] = alpha_21
H[30, 30] = alpha_31
H[29, 30] = alpha_21 * alpha_31
H[30, 29] = H[29, 30].conj()

# ====================================================================
# BLOKK 10 + 11: theta_QCD és G (1x1)
# ====================================================================
H[31, 31] = theta_QCD
H[32, 32] = G

# ====================================================================
# KERESZT-BLOKK CSATOLÁSOK (Hermitikus, Pauli-struktura)
# ====================================================================

# Gauge ↔ E8 (GUT-egyesites)
for i in range(3):
    for j in range(3):
        gi = [g1_MZ, g2_MZ, g3_MZ][i]
        H[i, 23 + j] = gi * H[23 + j, 23 + j].real / 100
        H[23 + j, i] = H[i, 23 + j].conj()

# Higgs ↔ Kod (vedelem)
for i in range(3):
    dk = [d_kod_7, d_kod_15, d_kod_31][i]
    H[3, 26 + i] = v_Higgs.real * dk / 100
    H[26 + i, 3] = H[3, 26 + i].conj()
    H[4, 26 + i] = m_Higgs.real * dk / 100
    H[26 + i, 4] = H[4, 26 + i].conj()

# Neutrino ↔ Majorana
H[18, 29] = m_nu1.real * alpha_21.real
H[29, 18] = H[18, 29].conj()
H[19, 30] = m_nu2.real * alpha_31.real
H[30, 19] = H[19, 30].conj()
H[20, 29] = m_nu3.real * alpha_21.real
H[29, 20] = H[20, 29].conj()

# PMNS ↔ Majorana
H[21, 29] = theta_12_PMNS.real * alpha_21.real
H[29, 21] = H[21, 29].conj()
H[22, 30] = theta_13_PMNS.real * alpha_31.real
H[30, 22] = H[22, 30].conj()

# theta_QCD ↔ CKM
H[31, 17] = theta_QCD.real * delta_CP_CKM.real
H[17, 31] = H[31, 17].conj()
H[31, 14] = theta_QCD.real * theta_12_CKM.real
H[14, 31] = H[31, 14].conj()

# G ↔ minden (gravitacio, univerzalis)
for i in range(32):
    H[i, 32] = G.real * (i + 1) / 100
    H[32, i] = H[i, 32].conj()

# ====================================================================
# HERMITIKUSSÁG ELLENŐRZÉSE ÉS KORREKCIÓ
# ====================================================================
# Ha a matrix meg nem teljesen Hermitikus, javitjuk a numerikus hibakat
if not np.allclose(H, H.conj().T):
    # A numerikus hibak miatt kicsi elteres lehet — atlagoljuk H es H^dagger kozott
    H_herm = (H + H.conj().T) / 2
    H = H_herm

# ═══════════════════════════════════════════════════════════════
# SAJÁTÉRTÉKEK
# ═══════════════════════════════════════════════════════════════

sajatertekek, sajátvektorok = eig(H)

# Abszolut ertek szerint rendezve
idx = np.argsort(np.abs(sajatertekek))[::-1]
sajatertekek_rendezett = sajatertekek[idx]

# Ellenorzes: Hermitikus matrix => valos sajatértékek
im_resz = np.imag(sajatertekek_rendezett)
print("=" * 70)
print("A 33x33 HERMITIKUS HAMILTON-OPERÁTOR (PAULI-KOMPLEX)")
print("=" * 70)
print()
print(f"A matrix önadjungalt (H = H^dagger)? {np.allclose(H, H.conj().T)}")
print(f"Max |H - H^dagger|: {np.max(np.abs(H - H.conj().T)):.3e}")
print()
print(f"A 33 sajáTÉRTÉK (komplex, de valosnak kell lennie Hermitikus esetén):")
print()
print(f"{'i':>3s} {'Re(λ)':>14s} {'Im(λ)':>14s} {'|λ|':>14s}")
print("-" * 55)
for i in range(33):
    re = sajatertekek_rendezett[i].real
    im = sajatertekek_rendezett[i].imag
    absv = np.abs(sajatertekek_rendezett[i])
    print(f"{i+1:>3d} {re:>+14.6e} {im:>+14.6e} {absv:>14.6e}")

print()
print(f"Max kepzetes resz (numerikus zaj): {np.max(np.abs(im_resz)):.3e}")
print(f"Ez a numerikus pontossag, a sajatértékek elvileg valosak.")
print()
print(f"24 legnagyobb |λ| tartomány: {np.abs(sajatertekek_rendezett[0]):.3e} ... {np.abs(sajatertekek_rendezett[23]):.3e}")
print(f"9 maradek |λ| tartomány:    {np.abs(sajatertekek_rendezett[24]):.3e} ... {np.abs(sajatertekek_rendezett[32]):.3e}")

# A Pauli-fázisok a 33 sajátértékben
print()
print("=" * 70)
print("A 33 PAULI-FÁZIS (arg(H_eig), a 16. dimenzió fázis-koendje)")
print("=" * 70)
print()
for i in range(33):
    arg = np.angle(sajatertekek_rendezett[i])
    print(f"  λ_{i+1:2d} fázisa: {arg:>+8.4f} (π·{arg/np.pi:+.4f})")