"""
FazisKoendFazisAtalakulas.py — A 33×33 Pauli-Hamilton fázisátalakulás-szimuláció.

A Hamilton-operátor fázisátalakulás-szimulációja:
  H(λ) = (1-λ) * H_0 + λ * H_1
  ahol λ ∈ [0, 1] a fázisátalakulás paramétere.

H_0: a jelenlegi Pauli-Hamilton (gyenge Yukawa, alacsony hőmérséklet)
H_1: egy módosított Hamilton (erős Yukawa, magas hőmérséklet)

A program:
  1. Felépíti H_0-t és H_1-et
  2. Kiszámolja a sajátértékeket minden λ-ra
  3. Megkeresi a fázisátalakulás kritikus pontját
  4. Kirajzolja a 24 WTC és 9 ön-korrekció λ-függését
  5. 3D-ben ábrázolja a Pauli-gömbön való mozgást
"""

import numpy as np
import sys
sys.path.insert(0, '/Users/joco/opencode/diagnosztika/szamitas')
from FazisKoendPauliTeljes import (
    H, sigma_1, sigma_2, sigma_3, I_2,
    yukawa_arr, v_Higgs, m_Higgs
)
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from scipy.linalg import expm, eigvalsh

# H_0: jelenlegi Pauli-Hamilton
H_0 = H.copy()

# H_1: erős Yukawa fázis (a top-kvark domináns, a Higgs-vev csökkent)
H_1 = H.copy()
# A top-Yukawa (sor 7, a Yukawa-blokk 3. eleme) erősítése 100x
H_1[7, 7] *= 100
# A Higgs-vev (sor 3) csökkentése 10x (szimmetria-helyreállás)
H_1[3, 3] /= 10
# A Higgs-tömeg (sor 4) csökkentése 5x
H_1[4, 4] /= 5

print("=" * 70)
print("A 33×33 PAULI-HAMILTON FÁZISÁTKALAKULÁS-SZIMULÁCIÓ")
print("=" * 70)
print()
print("H(λ) = (1-λ)·H_0 + λ·H_1")
print("  H_0: gyenge Yukawa (λ=0)")
print("  H_1: erős Yukawa (λ=1, top-kvark domináns, Higgs-vev csökkent)")
print()

N_lam = 50
lambda_arr = np.linspace(0, 1, N_lam)

# Sajátértékek minden λ-ra
print(f"λ tartomány: [0, 1], {N_lam} lépésben")
print()

sajátértékek_lambda = np.zeros((N_lam, 33))
sajátvektorok_lambda = np.zeros((N_lam, 33, 33), dtype=np.complex128)

for i, lam in enumerate(lambda_arr):
    H_lam = (1 - lam) * H_0 + lam * H_1
    sajátértékek, sajátvektorok = np.linalg.eigh(H_lam)
    # Abszolút érték szerint rendezve
    idx = np.argsort(np.abs(sajátértékek))[::-1]
    sajátértékek_lambda[i] = sajátértékek[idx]
    sajátvektorok_lambda[i] = sajátvektorok[:, idx]

# A 24 WTC és 9 ön-korrekció elkülönítése
wtc_lambda = sajátértékek_lambda[:, :24]
onk_lambda = sajátértékek_lambda[:, 24:]

# A fázisátalakulás kritikus pontjának keresése
# A kritikus pont a sajátértékek ugrásszerű változásánál van
diff_wtc = np.diff(np.log10(np.abs(wtc_lambda[:, :5])), axis=0)
max_diff_idx = np.argmax(np.max(np.abs(diff_wtc), axis=1))
lambda_crit = lambda_arr[max_diff_idx + 1]

print(f"A fázisátalakulás kritikus pontja (legnagyobb ugrás): λ_crit ≈ {lambda_crit:.4f}")
print()

# A Pauli-gömb koordinátái a Higgs-blokkban minden λ-ra
# X(λ) = ⟨ψ_max(λ)|σ₁|ψ_max(λ)⟩ a Higgs-blokkban
P1_higgs = np.zeros((33, 33), dtype=np.complex128)
P1_higgs[3:5, 3:5] = sigma_1
P2_higgs = np.zeros((33, 33), dtype=np.complex128)
P2_higgs[3:5, 3:5] = sigma_2
P3_higgs = np.zeros((33, 33), dtype=np.complex128)
P3_higgs[3:5, 3:5] = sigma_3

X_lam = np.zeros(N_lam)
Y_lam = np.zeros(N_lam)
Z_lam = np.zeros(N_lam)
for i in range(N_lam):
    psi_max = sajátvektorok_lambda[i, :, 0]  # a legnagyobb sajátértékhez tartozó vektor
    X_lam[i] = np.real(np.conj(psi_max) @ P1_higgs @ psi_max)
    Y_lam[i] = np.real(np.conj(psi_max) @ P2_higgs @ psi_max)
    Z_lam[i] = np.real(np.conj(psi_max) @ P3_higgs @ psi_max)

print(f"A Pauli-gömbön való mozgás a Higgs-blokkban:")
print(f"  λ=0:   X={X_lam[0]:+.4f}, Y={Y_lam[0]:+.4f}, Z={Z_lam[0]:+.4f}")
print(f"  λ=0.5: X={X_lam[N_lam//2]:+.4f}, Y={Y_lam[N_lam//2]:+.4f}, Z={Z_lam[N_lam//2]:+.4f}")
print(f"  λ=1:   X={X_lam[-1]:+.4f}, Y={Y_lam[-1]:+.4f}, Z={Z_lam[-1]:+.4f}")
print()

# ═══════════════════════════════════════════════════════════════
# ÁBRA: 4 PANEL (a fázisátalakulás több szemszögből)
# ═══════════════════════════════════════════════════════════════

fig = plt.figure(figsize=(20, 14))
fig.suptitle('A 33×33 Pauli-Hamilton FÁZISÁTKALAKULÁSA\n'
             '(H(λ) = (1-λ)·H_0 + λ·H_1, λ ∈ [0,1])',
             fontsize=16, fontweight='bold')

# ──────────────────────────────────────────────────────────────
# PANEL 1: A 24 WTC sajátérték λ függvényében
# ──────────────────────────────────────────────────────────────
ax1 = plt.subplot(2, 2, 1)
for i in range(24):
    ax1.plot(lambda_arr, np.log10(np.abs(wtc_lambda[:, i])), '-',
             alpha=0.4, linewidth=0.8)
ax1.axvline(x=lambda_crit, color='red', linestyle='--', alpha=0.7,
            label=f'λ_crit ≈ {lambda_crit:.3f}')
ax1.set_xlabel('λ (fázisátalakulás paramétere)', fontsize=11)
ax1.set_ylabel('log|λ_WTC|', fontsize=11)
ax1.set_title('A 24 WTC sajátérték λ függvényében', fontsize=12, fontweight='bold')
ax1.legend(fontsize=10)
ax1.grid(True, alpha=0.3)

# ──────────────────────────────────────────────────────────────
# PANEL 2: A 9 ön-korrekció λ függvényében
# ──────────────────────────────────────────────────────────────
ax2 = plt.subplot(2, 2, 2)
for i in range(9):
    ax2.plot(lambda_arr, np.log10(np.abs(onk_lambda[:, i])), '-',
             color='darkred', alpha=0.7, linewidth=1.2)
ax2.axvline(x=lambda_crit, color='red', linestyle='--', alpha=0.7,
            label=f'λ_crit ≈ {lambda_crit:.3f}')
ax2.set_xlabel('λ', fontsize=11)
ax2.set_ylabel('log|λ_ön-korr|', fontsize=11)
ax2.set_title('A 9 ön-korrekció λ függvényében', fontsize=12, fontweight='bold')
ax2.legend(fontsize=10)
ax2.grid(True, alpha=0.3)

# ──────────────────────────────────────────────────────────────
# PANEL 3: A Pauli-gömb 3D-s mozgása λ függvényében
# ──────────────────────────────────────────────────────────────
ax3 = fig.add_subplot(2, 2, 3, projection='3d')
u = np.linspace(0, 2*np.pi, 30)
v = np.linspace(0, np.pi, 30)
x_gomb = np.outer(np.cos(u), np.sin(v))
y_gomb = np.outer(np.sin(u), np.sin(v))
z_gomb = np.outer(np.ones_like(u), np.cos(v))
ax3.plot_surface(x_gomb, y_gomb, z_gomb, color='lightblue', alpha=0.15,
                 edgecolor='gray')

# A trajektória színezése λ szerint
from matplotlib.colors import LinearSegmentedColormap
colors = plt.cm.coolwarm(lambda_arr)
for i in range(N_lam - 1):
    ax3.plot([X_lam[i], X_lam[i+1]], [Y_lam[i], Y_lam[i+1]],
             [Z_lam[i], Z_lam[i+1]], color=colors[i], linewidth=2)

ax3.scatter([X_lam[0]], [Y_lam[0]], [Z_lam[0]], color='blue', s=150,
            label='λ=0 (H_0)', zorder=5)
ax3.scatter([X_lam[-1]], [Y_lam[-1]], [Z_lam[-1]], color='red', s=150,
            label='λ=1 (H_1)', zorder=5)
ax3.scatter([X_lam[N_lam//2]], [Y_lam[N_lam//2]], [Z_lam[N_lam//2]],
            color='orange', s=150, label=f'λ={lambda_crit:.3f} (kritikus)',
            zorder=5)

ax3.set_xlabel('X = ⟨σ₁⟩', fontsize=10)
ax3.set_ylabel('Y = ⟨σ₂⟩ (KÉPZETES!)', fontsize=10)
ax3.set_zlabel('Z = ⟨σ₃⟩', fontsize=10)
ax3.set_title('A Pauli-gömbön való mozgás a fázisátalakulás alatt',
              fontsize=12, fontweight='bold')
ax3.legend(loc='upper left', fontsize=9)

# ──────────────────────────────────────────────────────────────
# PANEL 4: A Pauli-X, Y, Z idő-szerű λ függvénye
# ──────────────────────────────────────────────────────────────
ax4 = plt.subplot(2, 2, 4)
ax4.plot(lambda_arr, X_lam, 'r-', linewidth=2, label='X(λ) = ⟨σ₁⟩')
ax4.plot(lambda_arr, Y_lam, 'b-', linewidth=2, label='Y(λ) = ⟨σ₂⟩ (kéPZETES!)')
ax4.plot(lambda_arr, Z_lam, 'g-', linewidth=2, label='Z(λ) = ⟨σ₃⟩')
ax4.axvline(x=lambda_crit, color='red', linestyle='--', alpha=0.7,
            label=f'λ_crit ≈ {lambda_crit:.3f}')
ax4.axhline(y=0, color='black', linewidth=0.5, linestyle=':')
ax4.set_xlabel('λ', fontsize=11)
ax4.set_ylabel('Pauli-várakozási érték', fontsize=11)
ax4.set_title('X, Y, Z a fázisátalakulás alatt', fontsize=12, fontweight='bold')
ax4.legend(loc='best', fontsize=10)
ax4.grid(True, alpha=0.3)

plt.tight_layout(rect=[0, 0, 1, 0.96])

output = '/Users/joco/opencode/diagnosztika/szamitas/FazisKoendFazisAtalakulas.png'
plt.savefig(output, dpi=120, bbox_inches='tight')
print(f"Fázisátalakulás ábrája mentve: {output}")
print()

# Statisztikák
print("=" * 70)
print("A FÁZISÁTKALAKULÁS STATISZTIKÁI")
print("=" * 70)
print()
print(f"  H_0 legnagyobb sajátérték: {np.abs(wtc_lambda[0, 0]):.4e}")
print(f"  H_1 legnagyobb sajátérték: {np.abs(wtc_lambda[-1, 0]):.4e}")
print(f"  Változás: {(np.abs(wtc_lambda[-1, 0]) / np.abs(wtc_lambda[0, 0])):.4e}-szeres")
print()
print(f"  Kritikus pont: λ_crit ≈ {lambda_crit:.4f}")
print(f"  A Pauli-gömbön megtett távolság: {np.sum(np.sqrt(np.diff(X_lam)**2 + np.diff(Y_lam)**2 + np.diff(Z_lam)**2)):.4f}")
print()
print(f"  9 ön-korrekció legnagyobb változása:")
for i in range(9):
    r = np.abs(onk_lambda[-1, i] / onk_lambda[0, i]) if onk_lambda[0, i] != 0 else 0
    print(f"    OK{i+1}: λ=0 → λ=1 arány: {r:.4e}")
print()

plt.show()