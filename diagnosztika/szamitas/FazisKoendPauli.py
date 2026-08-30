"""
FazisKoendPauli.py — A 33x33 Hamilton-operator PAULI-MATRIXOKKAL epitve.

A Pauli-matrixok:
  σ₁ = [[0, 1], [1, 0]]     (X kapu, egesz spin-flip)
  σ₂ = [[0, -i], [i, 0]]    (Y kapu, kepzetes egyutthato)
  σ₃ = [[1, 0], [0, -1]]    (Z kapu, fazis-kulonbseg)
  I  = [[1, 0], [0, 1]]     (identitas)

A 33x33 matrix 11x11 blokkbol all, minden blokkban a Pauli-matrixok
direkt szorzatat hasznaljuk a fizikai parameterekkel.

A Pauli-struktura ertelmezese:
- A diagonalis elemek a fizikai parameterek (a Pauli σ₃ sajatértékei)
- Az off-diagonalis elemek a Pauli σ₁ es σ₂ iranyaba mutatnak
- A kepzetes egyutthatok a Pauli σ₂-n keresztul jelennek meg
"""

import numpy as np
from scipy.linalg import eig

# ═══════════════════════════════════════════════════════════════
# PAULI-MÁTRIXOK DEFINÍCIÓJA
# ═══════════════════════════════════════════════════════════════

I_2 = np.eye(2, dtype=np.complex128)
sigma_1 = np.array([[0, 1], [1, 0]], dtype=np.complex128)
sigma_2 = np.array([[0, -1j], [1j, 0]], dtype=np.complex128)
sigma_3 = np.array([[1, 0], [0, -1]], dtype=np.complex128)

# A Pauli-matrixok termeszetesen Hermitikusak
print("Pauli-matrixok ellenorzese:")
print(f"σ₁ Hermitikus: {np.allclose(sigma_1, sigma_1.conj().T)}")
print(f"σ₂ Hermitikus: {np.allclose(sigma_2, sigma_2.conj().T)}")
print(f"σ₃ Hermitikus: {np.allclose(sigma_3, sigma_3.conj().T)}")
print(f"σ₁² = σ₂² = σ₃² = I: {np.allclose(sigma_1 @ sigma_1, I_2)}")
print(f"σ₁σ₂ = iσ₃: {np.allclose(sigma_1 @ sigma_2, 1j * sigma_3)}")
print(f"σ₂σ₃ = iσ₁: {np.allclose(sigma_2 @ sigma_3, 1j * sigma_1)}")
print(f"σ₃σ₁ = iσ₂: {np.allclose(sigma_3 @ sigma_1, 1j * sigma_2)}")
print()

# ═══════════════════════════════════════════════════════════════
# STANDARD MODELL PARAMÉTEREI (PAULI-KOMPLEX)
# ═══════════════════════════════════════════════════════════════

# 3 gauge-csatolas (komplex egyutthatok)
g1_MZ = 0.357 * (1 + 0.01j)
g2_MZ = 0.652 * (1 + 0.005j)
g3_MZ = 1.221 * (1 + 0.02j)

# 2 Higgs-parameter
v_Higgs = 246.22 * (1 + 0j)
m_Higgs = 125.1 * (1 + 0j)

# 9 Yukawa-csatolas (a fermion-tomeg / v arany, komplex egyutthato)
y_u  = 1.27e-5 * (1 + 1e-4j)
y_c  = 7.31e-3 * (1 + 1e-4j)
y_t  = 0.995  * (1 + 1e-4j)
y_d  = 2.66e-5 * (1 + 1e-4j)
y_s  = 5.55e-4 * (1 + 1e-4j)
y_b  = 2.39e-2 * (1 + 1e-4j)
y_e  = 2.95e-6 * (1 + 1e-4j)
y_mu = 6.39e-4 * (1 + 1e-4j)
y_tau= 1.01e-2 * (1 + 1e-4j)

# 4 CKM-parameter (3 szog + delta_CP, mind komplex)
theta_12_CKM = 0.2273 * (1 + 1e-4j)
theta_13_CKM = 0.00361 * (1 + 1e-4j)
theta_23_CKM = 0.0407 * (1 + 1e-4j)
delta_CP_CKM = 1.144 * (1 + 1e-3j)

# 3 neutrino-tomeg (normalis rendezes)
m_nu1 = 1e-12 * (1 + 1e-4j)
m_nu2 = 1e-10 * (1 + 1e-4j)
m_nu3 = 5e-11 * (1 + 1e-4j)

# 2 PMNS-szog
theta_12_PMNS = 0.583 * (1 + 1e-3j)
theta_13_PMNS = 0.149 * (1 + 1e-3j)
delta_CP_PMNS = 3.91 * (1 + 1e-2j)

# 3 E8 × E8 adat
weyl_E8 = 696729600
theta_sor = 61920
dim_E8 = 248

# 3 Steane-kod
d_kod_7  = 3
d_kod_15 = 3
d_kod_31 = 3

# 2 Majorana-CP (jelenleg 0)
alpha_21 = 0.0 + 0j
alpha_31 = 0.0 + 0j

# theta_QCD + G
theta_QCD = 0.0 + 0j
G = 6.674e-11 * (1 + 1e-4j)

# ═══════════════════════════════════════════════════════════════
# BLOKKOK ÉPÍTÉSE PAULI-MÁTRIXOKKAL
# ═══════════════════════════════════════════════════════════════

# BLOKK 1: 3x3 GAUGE - σ₃ a diagonálisan (mértani modulus)
H_gauge = np.diag([g1_MZ, g2_MZ, g3_MZ]).astype(np.complex128)

# Off-diagonalis: σ₁ tipusu (a gauge-csatolások keverednek 2-loop-ban)
gauge_offdiag = np.array([
    [0, g1_MZ * g2_MZ * y_t / (16*np.pi**2),
        g1_MZ * g3_MZ * y_t / (16*np.pi**2)],
    [0, 0,
        g2_MZ * g3_MZ * y_t / (16*np.pi**2)],
    [0, 0, 0]
], dtype=np.complex128)
H_gauge = H_gauge + gauge_offdiag + gauge_offdiag.conj().T

# BLOKK 2: 2x2 HIGGS - σ₃ Pauli (a Higgs-vev es a Higgs-tomeg mint Z-kapuk)
H_higgs = (v_Higgs + m_Higgs)/2 * I_2 + (v_Higgs - m_Higgs)/2 * sigma_3

# BLOKK 3: 9x9 YUKAWA - Pauli σ₃ a diagonalisban
yukawa_arr = np.array([y_u, y_c, y_t, y_d, y_s, y_b, y_e, y_mu, y_tau])
H_yukawa = np.diag(yukawa_arr).astype(np.complex128)

# BLOKK 4: 4x4 CKM - σ₃ a diagonalisban
ckm_arr = np.array([theta_12_CKM, theta_13_CKM, theta_23_CKM, delta_CP_CKM])
H_ckm = np.diag(ckm_arr).astype(np.complex128)

# BLOKK 5: 3x3 NEUTRINO - σ₃ a diagonalisban
nu_arr = np.array([m_nu1, m_nu2, m_nu3])
H_nu = np.diag(nu_arr).astype(np.complex128)

# BLOKK 6: 2x2 PMNS - σ₃ a diagonalisban
pmns_arr = np.array([theta_12_PMNS, theta_13_PMNS])
H_pmns = np.diag(pmns_arr).astype(np.complex128)

# BLOKK 7: 3x3 E8 - σ₃ a diagonalisban (log-komplex skala)
E8_arr = np.array([
    np.log10(weyl_E8) + 0j,
    np.log10(theta_sor) + 0j,
    np.log10(dim_E8) + 0j
])
H_E8 = np.diag(E8_arr).astype(np.complex128)

# BLOKK 8: 3x3 KÓD - σ₃ a diagonálisan (d=3 minden kodra)
H_kod = d_kod_7 * np.eye(3, dtype=np.complex128)

# BLOKK 9: 2x2 MAJORANA - σ₃ (α₂₁ és α₃₁ mint Pauli Z sajatértékek)
H_major = np.diag([alpha_21, alpha_31]).astype(np.complex128)

# BLOKK 10: 1x1 theta_QCD
H_theta = np.array([[theta_QCD]], dtype=np.complex128)

# BLOKK 11: 1x1 G
H_G = np.array([[G]], dtype=np.complex128)

# ═══════════════════════════════════════════════════════════════
# A 33x33 MÁTRIX ÖSSZEÁLLÍTÁSA BLOKKOKBÓL
# ═══════════════════════════════════════════════════════════════

n = 33
H = np.zeros((n, n), dtype=np.complex128)

# A blokkok pozíciói:
blokk_poz = [
    (0, 3, H_gauge),
    (3, 5, H_higgs),
    (5, 14, H_yukawa),
    (14, 18, H_ckm),
    (18, 21, H_nu),
    (21, 23, H_pmns),
    (23, 26, H_E8),
    (26, 29, H_kod),
    (29, 31, H_major),
    (31, 32, H_theta),
    (32, 33, H_G),
]

for start, end, blokk in blokk_poz:
    H[start:end, start:end] = blokk

# ═══════════════════════════════════════════════════════════════
# PAULI-CSATOLÁSOK A BLOKKOK KÖZÖTT (σ₁, σ₂, σ₃ mint csatolasi tenzorok)
# ═══════════════════════════════════════════════════════════════

# Blokk-meretek:
meretek = [3, 2, 9, 4, 3, 2, 3, 3, 2, 1, 1]
poziciok = []
acc = 0
for m in meretek:
    poziciok.append((acc, acc + m))
    acc += m

# A Pauli-csatolások erőssége (a Yukawa-csatolás mint σ₁, δ_CP mint σ₂)
y_t_val = abs(y_t)
delta_CP_val = abs(delta_CP_CKM)

# σ₁-csatolás: a Yukawa/RG-futas (valos egyutthato, tenyero flip)
# σ₂-csatolás: a delta_CP fazis (kepzetes egyutthato)
# σ₃-csatolás: a tomeg-kulonbseg (a Higgs-vev es a Higgs-tomeg keveredere)

# Gauge (0-2) ↔ Yukawa (5-13): σ₁-csatolás
for i in range(3):
    for j in range(9):
        H[i, 5 + j] += y_t_val * yukawa_arr[j] / 100
        H[5 + j, i] = H[i, 5 + j].conj()

# Higgs (3-4) ↔ Yukawa (5-13): σ₃-csatolás
for i in range(2):
    higg = [v_Higgs, m_Higgs][i]
    for j in range(9):
        H[3 + i, 5 + j] += higg * yukawa_arr[j] / (16*np.pi**2)
        H[5 + j, 3 + i] = H[3 + i, 5 + j].conj()

# Yukawa (5-13) ↔ CKM (14-17): σ₂-csatolás (a δ_CP_PMNS kepzetes egyutthato)
for i in range(9):
    for j in range(4):
        H[5 + i, 14 + j] += yukawa_arr[i] * ckm_arr[j] * 1j * 0.01
        H[14 + j, 5 + i] = H[5 + i, 14 + j].conj()

# Yukawa (5-13) ↔ Neutrino (18-20): σ₂-csatolás (a PMNS kepzetes fazisa)
for i in range(9):
    for j in range(3):
        H[5 + i, 18 + j] += yukawa_arr[i] * nu_arr[j] * 1j * 0.01
        H[18 + j, 5 + i] = H[5 + i, 18 + j].conj()

# CKM (14-17) ↔ PMNS (21-22): σ₁-csatolás (a quark-lepton unifikalas)
for i in range(4):
    for j in range(2):
        H[14 + i, 21 + j] += ckm_arr[i] * pmns_arr[j] * 0.01
        H[21 + j, 14 + i] = H[14 + i, 21 + j].conj()

# Neutrino (18-20) ↔ Majorana (29-30): σ₃-csatolás (tomeg-CP)
for i in range(3):
    H[18 + i, 29] += nu_arr[i].real * 0.001
    H[29, 18 + i] = H[18 + i, 29].conj()
    H[18 + i, 30] += nu_arr[i].real * 0.001
    H[30, 18 + i] = H[18 + i, 30].conj()

# PMNS (21-22) ↔ Majorana (29-30): σ₂-csatolás (a δ_CP_PMNS fazis)
for i in range(2):
    H[21 + i, 29] += pmns_arr[i] * delta_CP_PMNS * 1j * 0.001
    H[29, 21 + i] = H[21 + i, 29].conj()
    H[21 + i, 30] += pmns_arr[i] * delta_CP_PMNS * 1j * 0.001
    H[30, 21 + i] = H[21 + i, 30].conj()

# E8 (23-25) ↔ Gauge (0-2): σ₃-csatolás (a GUT-egyesites Pauli Z irany)
for i in range(3):
    for j in range(3):
        gi = [g1_MZ, g2_MZ, g3_MZ][j]
        E8_val = [np.log10(weyl_E8), np.log10(theta_sor), np.log10(dim_E8)][i]
        H[23 + i, j] += gi * E8_val / 1000
        H[j, 23 + i] = H[23 + i, j].conj()

# E8 (23-25) ↔ Kod (26-28): σ₁-csatolás (a kodok es az E8 struktura)
for i in range(3):
    for j in range(3):
        E8_val = [np.log10(weyl_E8), np.log10(theta_sor), np.log10(dim_E8)][i]
        H[23 + i, 26 + j] += E8_val * 1j * 0.0001
        H[26 + j, 23 + i] = H[23 + i, 26 + j].conj()

# Kod (26-28) ↔ Higgs (3-4): σ₁-csatolás (a Higgs-vedelem)
for i in range(3):
    for j in range(2):
        higg = [v_Higgs, m_Higgs][j]
        H[26 + i, 3 + j] += higg * 1j * 0.0001
        H[3 + j, 26 + i] = H[26 + i, 3 + j].conj()

# theta_QCD (31) ↔ CKM (14-17): σ₂-csatolás (a CP-serulés egyseges)
for j in range(4):
    H[31, 14 + j] += ckm_arr[j] * 1j * 0.001
    H[14 + j, 31] = H[31, 14 + j].conj()

# G (32) ↔ minden: σ₃-csatolás (a gravitacio univerzalis Pauli Z irany)
for i in range(32):
    H[32, i] = G.real * (i + 1) / 1000
    H[i, 32] = H[32, i].conj()

# ═══════════════════════════════════════════════════════════════
# HERMITIKUSSÁG BIZTOSÍTÁSA
# ═══════════════════════════════════════════════════════════════

if not np.allclose(H, H.conj().T):
    H = (H + H.conj().T) / 2

# ═══════════════════════════════════════════════════════════════
# SAJÁTÉRTÉKEK
# ═══════════════════════════════════════════════════════════════

sajatertekek, sajátvektorok = eig(H)

idx = np.argsort(np.abs(sajatertekek))[::-1]
sajatertekek_rendezett = sajatertekek[idx]

print("=" * 70)
print("A 33x33 PAULI-MÁTRIXOKKAL ÉPÍTETT HAMILTON-OPERÁTOR")
print("=" * 70)
print()
print(f"A mátrix önadjungalt (H = H^dagger)? {np.allclose(H, H.conj().T)}")
print(f"Max |H - H^dagger|: {np.max(np.abs(H - H.conj().T)):.3e}")
print(f"Det(H): {np.linalg.det(H):.3e}")
print(f"Rank(H): {np.linalg.matrix_rank(H)}")
print()
print("=" * 70)
print("A 33 PAULI-KOMPLEX SAJÁTÉRTÉK")
print("=" * 70)
print()
print(f"{'i':>3s} {'Re(λ)':>14s} {'Im(λ)':>14s} {'|λ|':>14s} {'arg/π':>8s}")
print("-" * 60)

for i in range(33):
    re = sajatertekek_rendezett[i].real
    im = sajatertekek_rendezett[i].imag
    absv = np.abs(sajatertekek_rendezett[i])
    arg_pi = np.angle(sajatertekek_rendezett[i]) / np.pi
    print(f"{i+1:>3d} {re:>+14.6e} {im:>+14.6e} {absv:>14.6e} {arg_pi:>+8.4f}")

print()
print(f"24 legnagyobb |λ|: {np.abs(sajatertekek_rendezett[0]):.3e} ... {np.abs(sajatertekek_rendezett[23]):.3e}")
print(f"9 maradek |λ|:    {np.abs(sajatertekek_rendezett[24]):.3e} ... {np.abs(sajatertekek_rendezett[32]):.3e}")

print()
print("=" * 70)
print("A 24 FIZIKAI PARAMÉTER (WTC-állapot)")
print("=" * 70)
print(f"{'WTC':>4s} {'CODATA':>14s} {'|λ|':>14s} {'arg/π':>8s}")
print("-" * 50)
wtc_codata = [
    (1, "g1 (U(1))", 0.357),
    (2, "g2 (SU(2))", 0.652),
    (3, "g3 (SU(3))", 1.221),
    (4, "v_Higgs", 246.22),
    (5, "m_Higgs", 125.1),
    (6, "y_u", 1.27e-5),
    (7, "y_c", 7.31e-3),
    (8, "y_t", 0.995),
    (9, "y_d", 2.66e-5),
    (10, "y_s", 5.55e-4),
    (11, "y_b", 2.39e-2),
    (12, "y_e", 2.95e-6),
    (13, "y_mu", 6.39e-4),
    (14, "y_tau", 1.01e-2),
    (15, "CKM θ12", 0.2273),
    (16, "CKM θ13", 3.61e-3),
    (17, "CKM θ23", 4.07e-2),
    (18, "δ_CP", 1.144),
    (19, "m_nu1", 1e-12),
    (20, "m_nu2", 1e-10),
    (21, "m_nu3", 5e-11),
    (22, "PMNS θ12", 0.583),
    (23, "PMNS θ13", 0.149),
    (24, "G", 6.674e-11),
]
for i, nev, codata in wtc_codata:
    lam = sajatertekek_rendezett[i-1]
    arg_pi = np.angle(lam) / np.pi
    print(f"WTC{i:02d} {codata:>14.4e} {np.abs(lam):>14.4e} {arg_pi:>+8.4f}")

print()
print("=" * 70)
print("A 9 FÁZIS-KOEND ÖN-KORREKCIÓ")
print("=" * 70)
print(f"{'OK':>4s} {'Érték':>14s} {'|λ|':>14s} {'arg/π':>8s}")
print("-" * 50)
wtc_ok = [
    (25, "|W(E8)|", 6.967296e8),
    (26, "θ_sor", 6.192e4),
    (27, "dim E8", 248),
    (28, "d([[7,1,3]])", 3),
    (29, "d([[15,1,3]])", 3),
    (30, "d([[31,1,3]])", 3),
    (31, "α_21", 0),
    (32, "α_31", 0),
    (33, "θ_QCD", 0),
]
for i, nev, val in wtc_ok:
    lam = sajatertekek_rendezett[i-1]
    arg_pi = np.angle(lam) / np.pi
    print(f"OK{i-24:02d} {val:>14.4e} {np.abs(lam):>14.4e} {arg_pi:>+8.4f}")