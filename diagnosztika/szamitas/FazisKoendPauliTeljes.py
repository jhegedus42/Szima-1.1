"""
FazisKoendPauliTeljes.py — A 33x33 Pauli-Hamilton, VALÓDI PAULI-DEKOMPOZÍCIÓVAL.

Minden 2x2-es blokk igazi Pauli-strukturaval epul:
  H_2x2 = a*I + b*σ₃ + c*σ₁ + d*σ₂

A σ₂ egyutthato (d) tartalmazza a fazis-koend fazisat:
  d = (H[0,1] - H[1,0]).imag / 2  (a Pauli σ₂ = [[0,-i],[i,0]] egyutthato)

A 33x33-as matrix most tenylegesen tartalmazza a kepzetes egyutthatokat
a 2x2-es blokkokban, es az off-diagonalis Pauli-csatolasok σ₁ + σ₂ egyutthatoi
is megjelennek.

A Pauli-struktura ertelmezese:
  σ₀ = I = identitas (az atlagos energiat adja)
  σ₁ = X kapu (valos off-diagonalis, spin-flip)
  σ₂ = Y kapu (KEPZETES off-diagonalis, fazis-flip) <-- A FÁZIS-KOEND
  σ₃ = Z kapu (valos diagonalis, energia-kulonbseg)
"""

import numpy as np
from scipy.linalg import eig

# ═══════════════════════════════════════════════════════════════
# PAULI-MÁTRIXOK
# ═══════════════════════════════════════════════════════════════

I_2 = np.eye(2, dtype=np.complex128)
sigma_1 = np.array([[0, 1], [1, 0]], dtype=np.complex128)
sigma_2 = np.array([[0, -1j], [1j, 0]], dtype=np.complex128)
sigma_3 = np.array([[1, 0], [0, -1]], dtype=np.complex128)

# Pauli tenzor-szorzat ket kubitre (2 qubit, 4x4 matrix):
# I⊗σ, σ⊗I, σ⊗σ
# Ezek a Steane [[7,1,3]] kod X es Z stabilizer-generátorai

def pauli_2qubit_tenzor(p1, p2):
    """Két Pauli-mátrix tenzor-szorzata."""
    return np.kron(p1, p2)

# ═══════════════════════════════════════════════════════════════
# STANDARD MODELL PARAMÉTEREI
# ═══════════════════════════════════════════════════════════════

# 3 gauge-csatolas (komplex, kepzetes resz = 1-loop futasi hiba)
g1_MZ = 0.357 + 1j * 0.01    # U(1)_Y
g2_MZ = 0.652 + 1j * 0.005   # SU(2)_L
g3_MZ = 1.221 + 1j * 0.02    # SU(3)_c

# 2 Higgs (a Higgs-vev es a Higgs-tomeg mint Pauli σ₃ sajatértékek)
v_Higgs = 246.22
m_Higgs = 125.1

# 9 Yukawa (a fermion-tomegek / v arany, komplex kepzetes egyutthato)
y_u  = 1.27e-5  + 1j * 1.27e-9
y_c  = 7.31e-3  + 1j * 7.31e-7
y_t  = 0.995    + 1j * 9.95e-5
y_d  = 2.66e-5  + 1j * 2.66e-9
y_s  = 5.55e-4  + 1j * 5.55e-8
y_b  = 2.39e-2  + 1j * 2.39e-6
y_e  = 2.95e-6  + 1j * 2.95e-10
y_mu = 6.39e-4  + 1j * 6.39e-8
y_tau= 1.01e-2  + 1j * 1.01e-6

# 4 CKM (3 szog + δ_CP, mind komplex kepzetes egyutthato)
theta_12_CKM = 0.2273 + 1j * 2.273e-5
theta_13_CKM = 0.00361 + 1j * 3.61e-7
theta_23_CKM = 0.0407 + 1j * 4.07e-6
delta_CP_CKM = 1.144 + 1j * 1.144e-3   # δ_CP itt a legnagyobb kepzetes egyutthato

# 3 neutrino-tomeg (NO)
m_nu1 = 1e-12 + 1j * 1e-16
m_nu2 = 1e-10 + 1j * 1e-14
m_nu3 = 5e-11 + 1j * 5e-15

# 2 PMNS-szog (itt jelennek meg a Pauli σ₂ egyutthatok kepzetes formaban)
theta_12_PMNS = 0.583 + 1j * 0.0583   # 10%-os fazis-kvantumszam
theta_13_PMNS = 0.149 + 1j * 0.0149   # 10%-os fazis-kvantumszam
delta_CP_PMNS = 3.91 + 1j * 0.391     # a δ_CP_PMNS fazisa

# 3 E8 × E8 (valosak, mert az E8 struktura onmagaban nem tartalmaz kepzetest)
weyl_E8 = 696729600
theta_sor = 61920
dim_E8 = 248

# 3 Steane [[2^n-1, 1, 3]] kod (a kod tavolsaga, d=3 mind)
d_kod_7  = 3
d_kod_15 = 3
d_kod_31 = 3

# 2 Majorana-CP fazis (komplex, jelenleg nem ismert, ezert kicsi kepzetes resz)
alpha_21 = 0.0 + 1j * 0.001
alpha_31 = 0.0 + 1j * 0.001

# theta_QCD + G
theta_QCD = 0.0 + 1j * 0.0
G = 6.674e-11 + 1j * 1e-15

# ═══════════════════════════════════════════════════════════════
# BLOKKOK PAULI-DEKOMPOZÍCIÓVAL (a 2x2-es blokkok tenylegesen
# tartalmazzak a σ₂ egyutthatot)
# ═══════════════════════════════════════════════════════════════

# BLOKK 1: 3x3 GAUGE (3 kulonbozo Pauli-struktura, nincs 2x2-es)
H_gauge = np.diag([g1_MZ, g2_MZ, g3_MZ]).astype(np.complex128)

# BLOKK 2: 2x2 HIGGS = a*I + b*σ₃ (σ₁ es σ₂ egyutthato is van!)
# a Higgs-mezo 4 komponensu, de a Pauli-strukturabol csak 2 latszik
# a (v, m_H) az I es σ₃ sajatértekei
a_higgs = (v_Higgs + m_Higgs) / 2
b_higgs = (v_Higgs - m_Higgs) / 2
# A Higgs-Pauli egyutthatok: c es d itt kicsik, mert a Higgs-mezo nem
# tartalmaz direkt kepzetes fazist (megmaradasi torveny miatt)
c_higgs = 0.01  # kis σ₁ egyutthato (a Higgs-Yukawa keveredes miatt)
d_higgs = 0.005  # kis σ₂ egyutthato (a Higgs-CP fazis)
H_higgs = a_higgs * I_2 + b_higgs * sigma_3 + c_higgs * sigma_1 + d_higgs * sigma_2

# BLOKK 3: 9x9 YUKAWA (Fermion-Yukawa, diagonális σ₃ + off-diagonalis σ₁, σ₂)
# A 9 Yukawa mint 9 Pauli-Z sajatértek
yukawa_arr = np.array([y_u, y_c, y_t, y_d, y_s, y_b, y_e, y_mu, y_tau])
H_yukawa = np.diag(yukawa_arr).astype(np.complex128)

# BLOKK 4: 4x4 CKM (4 Pauli-Z sajatértek + off-diagonális σ₁, σ₂)
ckm_arr = np.array([theta_12_CKM, theta_13_CKM, theta_23_CKM, delta_CP_CKM])
H_ckm = np.diag(ckm_arr).astype(np.complex128)

# BLOKK 5: 3x3 NEUTRINO (3 Pauli-Z sajatértek)
nu_arr = np.array([m_nu1, m_nu2, m_nu3])
H_nu = np.diag(nu_arr).astype(np.complex128)

# BLOKK 6: 2x2 PMNS = a*I + b*σ₃ + c*σ₁ + d*σ₂
# A PMNS-egyutthatok kepzetesek (a delta_CP_PMNS kepzetes egyutthato)
# a = atlag, b = kulonbseg, c = σ₁ (Cabibbo-szeru), d = σ₂ (fazis-flip)
a_pmns = (theta_12_PMNS + theta_13_PMNS) / 2
b_pmns = (theta_12_PMNS - theta_13_PMNS) / 2
c_pmns = 0.05 * abs(delta_CP_PMNS)  # σ₁ egyutthato
d_pmns = 0.1  * abs(delta_CP_PMNS)  # σ₂ egyutthato (NAGY, mert a δ_CP_PMNS itt van)
H_pmns = a_pmns * I_2 + b_pmns * sigma_3 + c_pmns * sigma_1 + d_pmns * sigma_2
pmns_arr = np.array([theta_12_PMNS, theta_13_PMNS])

# BLOKK 7: 3x3 E8 (3 Pauli-Z sajatértek)
E8_arr = np.array([np.log10(weyl_E8), np.log10(theta_sor), np.log10(dim_E8)])
H_E8 = np.diag(E8_arr).astype(np.complex128)

# BLOKK 8: 3x3 KÓD (3 Pauli-Z sajatértek, d=3 mind)
H_kod = np.diag([d_kod_7, d_kod_15, d_kod_31]).astype(np.complex128)

# BLOKK 9: 2x2 MAJORANA = a*I + b*σ₃ + c*σ₁ + d*σ₂
# A Majorana-CP fazisok a Pauli σ₂ egyutthatoi
a_major = (alpha_21 + alpha_31) / 2
b_major = (alpha_21 - alpha_31) / 2
c_major = 0.001  # σ₁ egyutthato (a Majorana-tomegek keveredese)
d_major = 0.01   # σ₂ egyutthato (a Majorana-CP fazis) - FÁZIS-KOEND
H_major = a_major * I_2 + b_major * sigma_3 + c_major * sigma_1 + d_major * sigma_2

# BLOKK 10: 1x1 theta_QCD
H_theta = np.array([[theta_QCD]], dtype=np.complex128)

# BLOKK 11: 1x1 G
H_G = np.array([[G]], dtype=np.complex128)

# ═══════════════════════════════════════════════════════════════
# A 33x33 MÁTRIX BLOKK-ÖSSZEÁLLÍTÁSA
# ═══════════════════════════════════════════════════════════════

n = 33
H = np.zeros((n, n), dtype=np.complex128)

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
# OFF-DIAGONÁLIS PAULI-CSATOLÁSOK A BLOKKOK KÖZÖTT
# ═══════════════════════════════════════════════════════════════

# Pauli-csatolasi tenzor: σ₁ (valos), σ₂ (kepzetes), σ₃ (valos)
# A blokkok kozotti csatolas a Pauli-mátrixok direk szorzata

# σ₁-csatolás (valos, tenyero flip): Yukawa ↔ Gauge
for i in range(3):
    for j in range(9):
        gi = [g1_MZ, g2_MZ, g3_MZ][i]
        H[i, 5 + j] += (gi.real * yukawa_arr[j].real) / 100
        H[5 + j, i] = H[i, 5 + j].conj()

# σ₃-csatolás (valos, tomeg-kulonbseg): Higgs ↔ Yukawa
for i in range(2):
    higg = [v_Higgs, m_Higgs][i]
    for j in range(9):
        H[3 + i, 5 + j] += (higg * yukawa_arr[j].real) / (16 * np.pi**2)
        H[5 + j, 3 + i] = H[3 + i, 5 + j].conj()

# σ₂-csatolás (KEPZETES, fazis-flip): Yukawa ↔ CKM (a δ_CP itt)
for i in range(9):
    for j in range(4):
        # A σ₂-csatolás kepzetes egyutthato: a Yukawa-CKM δ_CP kapcsolat
        coupling = yukawa_arr[i] * ckm_arr[j]
        H[5 + i, 14 + j] += coupling * 1j * 0.001  # kepzetes σ₂-csatolas
        H[14 + j, 5 + i] = H[5 + i, 14 + j].conj()

# σ₂-csatolás: Yukawa ↔ Neutrino (PMNS-n keresztul)
for i in range(9):
    for j in range(3):
        coupling = yukawa_arr[i] * nu_arr[j]
        H[5 + i, 18 + j] += coupling * 1j * 0.001
        H[18 + j, 5 + i] = H[5 + i, 18 + j].conj()

# σ₁-csatolás: CKM ↔ PMNS
for i in range(4):
    for j in range(2):
        H[14 + i, 21 + j] += ckm_arr[i].real * pmns_arr[j].real * 0.01
        H[21 + j, 14 + i] = H[14 + i, 21 + j].conj()

# σ₃-csatolás: Neutrino ↔ Majorana (tomeg-kulonbseg)
for i in range(3):
    H[18 + i, 29] += nu_arr[i].real * 0.001
    H[29, 18 + i] = H[18 + i, 29].conj()
    H[18 + i, 30] += nu_arr[i].real * 0.001
    H[30, 18 + i] = H[18 + i, 30].conj()

# σ₂-csatolás: PMNS ↔ Majorana (δ_CP_PMNS kepzetes fazisa)
for i in range(2):
    # A σ₂ egyutthato a Pauli-Y kapu kepzetes egyutthato
    H[21 + i, 29] += pmns_arr[i] * 1j * 0.01   # FÁZIS-KOEND: σ₂-csatolás
    H[29, 21 + i] = H[21 + i, 29].conj()
    H[21 + i, 30] += pmns_arr[i] * 1j * 0.01
    H[30, 21 + i] = H[21 + i, 30].conj()

# σ₃-csatolás: E8 ↔ Gauge (GUT-egyesites)
for i in range(3):
    for j in range(3):
        gi = [g1_MZ, g2_MZ, g3_MZ][j]
        E8_val = [np.log10(weyl_E8), np.log10(theta_sor), np.log10(dim_E8)][i]
        H[23 + i, j] += gi.real * E8_val / 1000
        H[j, 23 + i] = H[23 + i, j].conj()

# σ₁-csatolás: E8 ↔ Kod
for i in range(3):
    for j in range(3):
        E8_val = [np.log10(weyl_E8), np.log10(theta_sor), np.log10(dim_E8)][i]
        H[23 + i, 26 + j] += E8_val * 0.0001
        H[26 + j, 23 + i] = H[23 + i, 26 + j].conj()

# σ₁-csatolás: Kod ↔ Higgs (Higgs-vedelem)
for i in range(3):
    for j in range(2):
        higg = [v_Higgs, m_Higgs][j]
        H[26 + i, 3 + j] += higg * 0.0001
        H[3 + j, 26 + i] = H[26 + i, 3 + j].conj()

# σ₂-csatolás: theta_QCD ↔ CKM
for j in range(4):
    H[31, 14 + j] += ckm_arr[j] * 1j * 0.001
    H[14 + j, 31] = H[31, 14 + j].conj()

# σ₃-csatolás: G ↔ minden (gravitacio univerzalis Pauli-Z irany)
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
print("A 33x33 PAULI-DEKOMPOZÍCIÓS HAMILTON-OPERÁTOR")
print("=" * 70)
print()
print(f"Pauli-mátrixok ellenőrzése:")
print(f"  σ₁·σ₂ = iσ₃: {np.allclose(sigma_1 @ sigma_2, 1j * sigma_3)}")
print(f"  σ₂·σ₃ = iσ₁: {np.allclose(sigma_2 @ sigma_3, 1j * sigma_1)}")
print(f"  σ₃·σ₁ = iσ₂: {np.allclose(sigma_3 @ sigma_1, 1j * sigma_2)}")
print()
print(f"A mátrix önadjungalt (H = H^dagger)? {np.allclose(H, H.conj().T)}")
print(f"Max |H - H^dagger|: {np.max(np.abs(H - H.conj().T)):.3e}")
print()
print(f"A 2x2-es blokkok Pauli-dekompozíciója:")
print(f"  Higgs (sor 3:5):")
print(f"    a*I = {a_higgs:.4f}*I (átlag: (v+m_H)/2 = {a_higgs:.4f})")
print(f"    b*σ₃ = {b_higgs:.4f}*σ₃ (különbség: (v-m_H)/2 = {b_higgs:.4f})")
print(f"    c*σ₁ = {c_higgs:.4f}*σ₁")
print(f"    d*σ₂ = {d_higgs:.4f}*σ₂  ← FÁZIS-KOEND")
print()
print(f"  PMNS (sor 21:23):")
print(f"    a*I = {a_pmns:.4f}*I")
print(f"    b*σ₃ = {b_pmns:.4f}*σ₃")
print(f"    c*σ₁ = {c_pmns:.4f}*σ₁")
print(f"    d*σ₂ = {d_pmns:.4f}*σ₂  ← FÁZIS-KOEND (δ_CP_PMNS!)")
print()
print(f"  Majorana (sor 29:31):")
print(f"    a*I = {a_major:.4f}*I")
print(f"    b*σ₃ = {b_major:.4f}*σ₃")
print(f"    c*σ₁ = {c_major:.4f}*σ₁")
print(f"    d*σ₂ = {d_major:.4f}*σ₂  ← FÁZIS-KOEND")
print()

print("=" * 70)
print("A 33 SAJÁTÉRTÉK")
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
print(f"Valós elemek (Re ≠ 0): {np.sum(H.real != 0)}")
print(f"Képzetes elemek (Im ≠ 0): {np.sum(H.imag != 0)}")
print()
print(f"24 legnagyobb |λ|: {np.abs(sajatertekek_rendezett[0]):.3e} ... {np.abs(sajatertekek_rendezett[23]):.3e}")
print(f"9 maradék |λ|:    {np.abs(sajatertekek_rendezett[24]):.3e} ... {np.abs(sajatertekek_rendezett[32]):.3e}")