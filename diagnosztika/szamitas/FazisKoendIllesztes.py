# SZABALY0-IDRISBEN-LEHETETLEN(átmeneti) — numerikus kutatás-szimuláció, Idrisbe átírandó (Komplex.idr-minta); hullám-3 nyilvántartás
"""
FazisKoendIllesztes.py — A 33×33 Pauli-Hamilton ILLESZTÉSE a CODATA-ra
scipy.optimize.least_squares (TRF) segítségével.

A cél: a 8 Pauli-csatolási együttható úgy hangolása, hogy a 33×33
Hamilton-operátor 24 legnagyobb sajátértéke minél jobban közelítse
a Standard Modell 24 fizikai paraméterét (CODATA).

A 8 szabad paraméter:
  1. theta_yukawa: a Yukawa-csatolás erőssége (σ₁ + σ₃)
  2. theta_ckm: a CKM-csatolás erőssége (σ₂)
  3. theta_pmns: a PMNS-csatolás erőssége (σ₂)
  4. theta_higgs: a Higgs-Yukawa off-diagonális
  5. theta_g: a gravitációs csatolás erőssége
  6. theta_e8: az E8-Gauge GUT-csatolás
  7. theta_kod: a Steane-kód csatolás erőssége
  8. theta_qcd: a CP-sértés csatolás

A TRF (Trust Region Reflective) módszer a legrobusztusabb
nemlineáris legkisebb négyzetes illesztés.
"""

import numpy as np
import sys
sys.path.insert(0, '/Users/joco/opencode/diagnosztika/szamitas')
from FazisKoendPauliTeljes import (
    H, sigma_1, sigma_2, sigma_3, I_2,
    yukawa_arr, ckm_arr, nu_arr, theta_12_PMNS, theta_13_PMNS, delta_CP_PMNS,
    alpha_21, alpha_31, theta_QCD, G,
    v_Higgs, m_Higgs, g1_MZ, g2_MZ, g3_MZ,
    weyl_E8, theta_sor, dim_E8, d_kod_7, d_kod_15, d_kod_31
)
from scipy.optimize import least_squares
from scipy.linalg import expm
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

# A 24 CODATA referenciaérték (normalizálva: minden adat > 0)
wtc_ref = np.array([
    0.357, 0.652, 1.221, 246.22, 125.1,
    1.27e-5, 7.31e-3, 0.995, 2.66e-5, 5.55e-4, 2.39e-2, 2.95e-6,
    6.39e-4, 1.01e-2, 0.2273, 3.61e-3, 4.07e-2, 1.144,
    1e-12, 1e-10, 5e-11, 0.583, 0.149, 6.674e-11
])
# Log-skálán dolgozunk, hogy a különböző nagyságrendek kezelhetők legyenek
log_wtc_ref = np.log10(wtc_ref)


def build_H_pauli(theta):
    """
    A Pauli-Hamilton felépítése a 8 szabad paraméterrel.

    theta = [theta_yukawa, theta_ckm, theta_pmns, theta_higgs,
             theta_g, theta_e8, theta_kod, theta_qcd]
    """
    theta_yukawa, theta_ckm, theta_pmns, theta_higgs, theta_g, theta_e8, theta_kod, theta_qcd = theta

    n = 33
    H = np.zeros((n, n), dtype=np.complex128)

    # BLOKK 1: 3x3 GAUGE
    H[0, 0] = g1_MZ
    H[1, 1] = g2_MZ
    H[2, 2] = g3_MZ
    top_yukawa_2loop = yukawa_arr[2] / (16 * np.pi**2)
    H[0, 1] = g1_MZ * g2_MZ * top_yukawa_2loop
    H[1, 0] = H[0, 1].conj()
    H[0, 2] = g1_MZ * g3_MZ * top_yukawa_2loop
    H[2, 0] = H[0, 2].conj()
    H[1, 2] = g2_MZ * g3_MZ * top_yukawa_2loop
    H[2, 1] = H[1, 2].conj()

    # BLOKK 2: 2x2 HIGGS Pauli-dekompozícióval
    a_h = (v_Higgs + m_Higgs) / 2
    b_h = (v_Higgs - m_Higgs) / 2
    H_higgs = a_h * I_2 + b_h * sigma_3
    H[3:5, 3:5] = H_higgs

    # BLOKK 3: 9x9 YUKAWA + Pauli-együtthatók
    for i, y in enumerate(yukawa_arr):
        H[5 + i, 5 + i] = y

    # BLOKK 4: 4x4 CKM
    for i, c in enumerate(ckm_arr):
        H[14 + i, 14 + i] = c

    # BLOKK 5: 3x3 NEUTRINO
    for i, n_ in enumerate(nu_arr):
        H[18 + i, 18 + i] = n_

    # BLOKK 6: 2x2 PMNS Pauli-dekompozícióval
    a_p = (theta_12_PMNS + theta_13_PMNS) / 2
    b_p = (theta_12_PMNS - theta_13_PMNS) / 2
    c_p = 0.05 * abs(delta_CP_PMNS)
    d_p = 0.1 * abs(delta_CP_PMNS)
    H_pmns = a_p * I_2 + b_p * sigma_3 + c_p * sigma_1 + d_p * sigma_2
    H[21:23, 21:23] = H_pmns

    # BLOKK 7: 3x3 E8
    H[23, 23] = np.log10(weyl_E8)
    H[24, 24] = np.log10(theta_sor)
    H[25, 25] = np.log10(dim_E8)

    # BLOKK 8: 3x3 KÓD
    H[26, 26] = d_kod_7
    H[27, 27] = d_kod_15
    H[28, 28] = d_kod_31

    # BLOKK 9: 2x2 MAJORANA
    a_m = (alpha_21 + alpha_31) / 2
    b_m = (alpha_21 - alpha_31) / 2
    H_major = a_m * I_2 + b_m * sigma_3
    H[29:31, 29:31] = H_major

    # BLOKK 10-11
    H[31, 31] = theta_QCD
    H[32, 32] = G

    # ═════════════════════════════════════════════════════════════
    # PAULI-CSATOLÁSOK (a theta szabad paraméterekkel)
    # ═════════════════════════════════════════════════════════════

    # σ₁-csatolás: Yukawa ↔ Gauge (theta_yukawa)
    for i in range(3):
        gi = [g1_MZ, g2_MZ, g3_MZ][i]
        for j in range(9):
            H[i, 5 + j] += theta_yukawa * gi.real * yukawa_arr[j].real / 100
            H[5 + j, i] = H[i, 5 + j].conj()

    # σ₃-csatolás: Higgs ↔ Yukawa (theta_higgs)
    for i in range(2):
        higg = [v_Higgs, m_Higgs][i]
        for j in range(9):
            H[3 + i, 5 + j] += theta_higgs * higg * yukawa_arr[j].real / (16 * np.pi**2)
            H[5 + j, 3 + i] = H[3 + i, 5 + j].conj()

    # σ₂-csatolás: Yukawa ↔ CKM (theta_ckm, KÉPZETES!)
    for i in range(9):
        for j in range(4):
            H[5 + i, 14 + j] += theta_ckm * yukawa_arr[i] * ckm_arr[j] * 1j * 0.001
            H[14 + j, 5 + i] = H[5 + i, 14 + j].conj()

    # σ₂-csatolás: Yukawa ↔ Neutrino (theta_pmns)
    for i in range(9):
        for j in range(3):
            H[5 + i, 18 + j] += theta_pmns * yukawa_arr[i] * nu_arr[j] * 1j * 0.001
            H[18 + j, 5 + i] = H[5 + i, 18 + j].conj()

    # σ₁-csatolás: CKM ↔ PMNS
    for i in range(4):
        for j in range(2):
            H[14 + i, 21 + j] += ckm_arr[i].real * 0.01
            H[21 + j, 14 + i] = H[14 + i, 21 + j].conj()

    # σ₃-csatolás: Neutrino ↔ Majorana
    for i in range(3):
        H[18 + i, 29] += nu_arr[i].real * 0.001
        H[29, 18 + i] = H[18 + i, 29].conj()
        H[18 + i, 30] += nu_arr[i].real * 0.001
        H[30, 18 + i] = H[18 + i, 30].conj()

    # σ₂-csatolás: PMNS ↔ Majorana
    for i in range(2):
        H[21 + i, 29] += 1j * 0.01
        H[29, 21 + i] = H[21 + i, 29].conj()
        H[21 + i, 30] += 1j * 0.01
        H[30, 21 + i] = H[21 + i, 30].conj()

    # σ₃-csatolás: E8 ↔ Gauge (theta_e8)
    for i in range(3):
        for j in range(3):
            gi = [g1_MZ, g2_MZ, g3_MZ][j]
            E8_val = [np.log10(weyl_E8), np.log10(theta_sor), np.log10(dim_E8)][i]
            H[23 + i, j] += theta_e8 * gi.real * E8_val / 1000
            H[j, 23 + i] = H[23 + i, j].conj()

    # σ₁-csatolás: E8 ↔ Kod (theta_kod)
    for i in range(3):
        for j in range(3):
            E8_val = [np.log10(weyl_E8), np.log10(theta_sor), np.log10(dim_E8)][i]
            H[23 + i, 26 + j] += theta_kod * E8_val * 0.0001
            H[26 + j, 23 + i] = H[23 + i, 26 + j].conj()

    # σ₁-csatolás: Kod ↔ Higgs (theta_kod)
    for i in range(3):
        for j in range(2):
            higg = [v_Higgs, m_Higgs][j]
            H[26 + i, 3 + j] += theta_kod * higg * 0.0001
            H[3 + j, 26 + i] = H[26 + i, 3 + j].conj()

    # σ₂-csatolás: theta_QCD ↔ CKM (theta_qcd)
    for j in range(4):
        H[31, 14 + j] += theta_qcd * ckm_arr[j] * 1j * 0.001
        H[14 + j, 31] = H[31, 14 + j].conj()

    # σ₃-csatolás: G ↔ minden (theta_g)
    for i in range(32):
        H[32, i] = theta_g * G.real * (i + 1) / 1000
        H[i, 32] = H[32, i].conj()

    # Hermitikusság
    if not np.allclose(H, H.conj().T):
        H = (H + H.conj().T) / 2

    return H


def residual(theta):
    """A maradék: a Pauli-Hamilton 24 legnagyobb sajátértéke vs. CODATA."""
    H = build_H_pauli(theta)
    sajatertekek = np.linalg.eigvalsh(H)
    # Csak a legnagyobb 24 abszolút értékű sajátértéket vesszük
    absv = np.abs(sajatertekek)
    idx = np.argsort(absv)[::-1]
    legnagyobb_24 = absv[idx[:24]]
    # Log-skálán illesztünk (a CODATA is log-skálán van)
    return np.log10(legnagyobb_24) - log_wtc_ref


# Kezdőértékek: minden theta = 1.0
theta_0 = np.ones(8)

print("=" * 70)
print("A 33×33 PAULI-HAMILTON ILLESZTÉSE A CODATA-RA (scipy TRF)")
print("=" * 70)
print()
print(f"Kezdőértékek: theta = {theta_0}")
print(f"Szabad paraméterek száma: {len(theta_0)}")
print(f"Cél: 24 WTC CODATA-érték")
print()

# Kezdő maradék
res_0 = residual(theta_0)
chi2_0 = np.sum(res_0**2)
print(f"Kezdő χ² = {chi2_0:.4f}")
print(f"Kezdő maradék (log|λ| - log|CODATA|):")
for i in range(24):
    print(f"  WTC{i+1:2d}: maradék = {res_0[i]:+.4f} ({10**res_0[i]:.4f}-szeres eltérés)")
print()

# Az illesztés futtatása
print("Az illesztés futtatása (TRF módszer)...")
result = least_squares(
    residual,
    theta_0,
    method='trf',
    bounds=([0.01]*8, [100.0]*8),  # theta >= 0.01 és <= 100
    verbose=1,
    max_nfev=200
)

print()
print(f"Illesztés befejezve!")
print(f"  Sikeres: {result.success}")
print(f"  Iterációk: {result.nfev}")
print(f"  Végső χ² = {np.sum(result.fun**2):.4f}")
print()
print(f"Az optimális theta paraméterek:")
for i, nev in enumerate(['theta_yukawa', 'theta_ckm', 'theta_pmns',
                          'theta_higgs', 'theta_g', 'theta_e8',
                          'theta_kod', 'theta_qcd']):
    print(f"  {nev:>15s} = {result.x[i]:.6f}")
print()

# Az illesztett mátrix sajátértékei
H_fit = build_H_pauli(result.x)
sajet_fit = np.linalg.eigvalsh(H_fit)
absv_fit = np.abs(sajet_fit)
idx_fit = np.argsort(absv_fit)[::-1]
legnagyobb_24_fit = absv_fit[idx_fit[:24]]

print("=" * 70)
print("AZ ILLESZTETT 24 WTC SAJÁTÉRTÉK vs. CODATA")
print("=" * 70)
print(f"{'WTC':>10s} {'CODATA':>14s} {'|λ_fit|':>14s} {'arány':>10s} {'|maradék|':>10s}")
print("-" * 65)
for i in range(24):
    r = legnagyobb_24_fit[i] / wtc_ref[i]
    resid = abs(np.log10(legnagyobb_24_fit[i]) - log_wtc_ref[i])
    print(f"{i+1:>10d} {wtc_ref[i]:>14.4e} {legnagyobb_24_fit[i]:>14.4e} {r:>10.4f} {resid:>10.4f}")

# Korreláció az illesztés után
log_fit = np.log10(legnagyobb_24_fit)
corr_fit = np.corrcoef(log_fit, log_wtc_ref)[0, 1]
print()
print(f"Az illesztett korreláció (Pearson-r): {corr_fit:.4f}")
print(f"  Javulás: {corr_fit - 0.5419:+.4f}")

# Ábra készítése
fig, axes = plt.subplots(1, 2, figsize=(14, 5))
fig.suptitle('A Pauli-Hamilton illesztése a CODATA-ra (scipy TRF)',
             fontsize=14, fontweight='bold')

# Panel 1: Kezdő vs. illesztett
ax1 = axes[0]
ax1.scatter(log_wtc_ref, np.log10(np.abs(sajatertekek_rendezett[:24].real)),
            s=80, color='gray', alpha=0.6, label='kezdeti (r=0.5419)')
ax1.scatter(log_wtc_ref, log_fit, s=80, color='crimson', alpha=0.8,
            label=f'illesztett (r={corr_fit:.4f})')
# Az y=x egyenes (tökéletes illesztés)
minv, maxv = log_wtc_ref.min(), log_wtc_ref.max()
ax1.plot([minv, maxv], [minv, maxv], 'k--', alpha=0.5, label='y=x (tökéletes)')
ax1.set_xlabel('log(CODATA)')
ax1.set_ylabel('log(|λ|)')
ax1.set_title('CODATA vs. sajátérték')
ax1.legend(fontsize=9)
ax1.grid(True, alpha=0.3)

# Panel 2: A maradékok
ax2 = axes[1]
residuals_fit = log_fit - log_wtc_ref
colors = ['green' if abs(r) < 0.5 else 'orange' if abs(r) < 1.0 else 'red'
          for r in residuals_fit]
ax2.bar(range(24), residuals_fit, color=colors, edgecolor='black')
ax2.axhline(y=0, color='black', linewidth=0.5, linestyle='--')
ax2.set_xticks(range(0, 24, 3))
ax2.set_xticklabels([f'{i+1}' for i in range(0, 24, 3)])
ax2.set_xlabel('WTC index')
ax2.set_ylabel('maradék (log|λ| - log|CODATA|)')
ax2.set_title('Az illesztés maradékai')
ax2.grid(True, alpha=0.3)

plt.tight_layout()
output = '/Users/joco/opencode/diagnosztika/szamitas/FazisKoendIllesztes.png'
plt.savefig(output, dpi=120, bbox_inches='tight')
print(f"\nIllesztési ábra mentve: {output}")

plt.show()