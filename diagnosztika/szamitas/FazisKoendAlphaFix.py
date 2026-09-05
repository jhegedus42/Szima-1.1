# SZABALY0-IDRISBEN-LEHETETLEN(átmeneti) — numerikus kutatás-szimuláció, Idrisbe átírandó (Komplex.idr-minta); hullám-3 nyilvántartás
"""
FazisKoendAlphaFix.py — A 33x33 Pauli-Hamilton α levezetésének RÖGZÍTETT ábrája.

A kulcs: λ₂₂ = 7.309e-03 ≈ α_CODATA = 7.297e-03 (0.16% hiba!)

Az ábra 4 panelt tartalmaz:
  1. A 33 sajátérték (log skála), λ₂₂ kiemelve
  2. A 24 WTC vs CODATA scatter plot, α pozíciója
  3. Az α futása a renormálási skálán (MZ → Planck)
  4. A 33-as fraktálgömb 3D, λ₂₂ pozíciója
"""

import numpy as np
import sys
sys.path.insert(0, '/Users/joco/opencode/diagnosztika/szamitas')
from FazisKoendPauliTeljes import H, sajatertekek_rendezett
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Paraméterek
g_Y = 0.357
g_2 = 0.652
e = g_Y * g_2 / np.sqrt(g_Y**2 + g_2**2)
alpha_MZ = e**2 / (4*np.pi)
alpha_0 = 7.2973525693e-3

# A Pauli-Hamilton sajátértékei
sajatert = sajatertekek_rendezett.real
sajatert_abs = np.abs(sajatert)

# λ₂₂ index (0-alapú: index 21)
idx_alpha = 21
lambda_22 = sajatert_abs[idx_alpha]

# === α FUTÁSA A RENORMÁLÁSI SKÁLÁN ===
# 1/α(Q) = 1/α(MZ) - (b_QED/2π) · ln(Q/MZ)
# b_QED = (1/3π) · Σ_f Q_f² = (1/3π) · 11/3 (3 generáció)
b_QED = 2/(3*np.pi) * 11/3
MZ = 91.1876
mu_scales = np.logspace(-1, 19, 200, base=10)  # 0.1 GeV → 10^19 GeV
inv_alpha_running = 1/alpha_MZ - (b_QED/(2*np.pi)) * np.log(mu_scales/MZ)
# Csak a fizikailag értelmes tartomány (α > 0)
valid = inv_alpha_running > 0

# === A 4 PANELES ÁBRA ===
fig = plt.figure(figsize=(18, 13))
fig.suptitle('A 33×33 Pauli-Hamilton: λ₂₂ ≈ α = 1/137.036\n'
             '(0.16%-os pontosság, α bemenet nélkül)',
             fontsize=15, fontweight='bold', y=0.995)

# PANEL 1: A 33 sajátérték (log skála), λ₂₂ kiemelve
ax1 = plt.subplot(2, 2, 1)
colors = ['#2255cc']*24 + ['#cc2222']*9
colors[idx_alpha] = '#22cc22'  # λ₂₂ zöld
ax1.bar(range(1, 34), sajatert_abs, color=colors, edgecolor='black', linewidth=0.4)
ax1.set_yscale('log')
ax1.axhline(y=alpha_0, color='green', linewidth=2, linestyle='--',
            label=f'α CODATA = {alpha_0:.4e} (1/137.036)')
ax1.axhline(y=alpha_MZ, color='orange', linewidth=1.5, linestyle=':',
            label=f'α(MZ) = {alpha_MZ:.4e} (1/128.16)')
ax1.annotate(f'λ₂₂ = {lambda_22:.4e}\n(1/{1/lambda_22:.1f})',
             xy=(22, lambda_22), xytext=(22, lambda_22*8),
             ha='center', fontsize=9, fontweight='bold', color='darkgreen',
             arrowprops=dict(arrowstyle='->', color='darkgreen', lw=1.5))
ax1.set_xlabel('Sajátérték index')
ax1.set_ylabel('|λ| (log skála)')
ax1.set_title('A 33 sajátérték — λ₂₂ ≈ α', fontweight='bold')
ax1.legend(fontsize=8, loc='upper right')
ax1.grid(True, alpha=0.3, which='both', linestyle=':')

# PANEL 2: WTC vs CODATA scatter (log-log), α pozíció
ax2 = plt.subplot(2, 2, 2)
wtc_codata = np.array([0.357, 0.652, 1.221, 246.22, 125.1,
                       1.27e-5, 7.31e-3, 0.995, 2.66e-5, 5.55e-4, 2.39e-2,
                       2.95e-6, 6.39e-4, 1.01e-2, 0.2273, 3.61e-3, 4.07e-2,
                       1.144, 1e-12, 1e-10, 5e-11, 0.583, 0.149, 6.674e-11])
sajatert_wtc = sajatert_abs[:24]
ax2.scatter(wtc_codata, sajatert_wtc, s=80, c='steelblue', edgecolor='black',
            alpha=0.7, label='24 WTC sajátérték')
# A y=x egyenes
lim = [1e-14, 1e3]
ax2.plot(lim, lim, 'k--', alpha=0.3, label='y=x (tökéletes)')
# α pozíció
ax2.scatter([alpha_0], [lambda_22], s=200, c='green', marker='*', zorder=5,
            label=f'λ₂₂ ≈ α (0.16% hiba)')
ax2.set_xscale('log')
ax2.set_yscale('log')
ax2.set_xlim(1e-14, 1e3)
ax2.set_ylim(1e-14, 1e3)
ax2.set_xlabel('CODATA érték')
ax2.set_ylabel('|λ| (sajátérték)')
ax2.set_title('WTC vs. CODATA — α kiemelve', fontweight='bold')
ax2.legend(fontsize=8)
ax2.grid(True, alpha=0.3, which='both', linestyle=':')

# PANEL 3: α futása a renormálási skálán
ax3 = plt.subplot(2, 2, 3)
ax3.plot(mu_scales[valid], inv_alpha_running[valid], 'b-', linewidth=2,
         label=f'1/α(Q) futás (1-loop QED)')
ax3.axhline(y=137.036, color='green', linewidth=1.5, linestyle='--',
            label='1/α(0) = 137.036 (Thomson)')
ax3.axhline(y=1/alpha_MZ, color='orange', linewidth=1.5, linestyle=':',
            label=f'1/α(MZ) = {1/alpha_MZ:.2f}')
ax3.axhline(y=1/lambda_22, color='darkgreen', linewidth=2, linestyle='-.',
            label=f'1/λ₂₂ = {1/lambda_22:.2f} (Pauli-Hamilton)')
ax3.set_xscale('log')
ax3.set_xlabel('Renormálási skála μ [GeV]')
ax3.set_ylabel('1/α')
ax3.set_title('A finomszerkezeti állandó futása', fontweight='bold')
ax3.legend(fontsize=8)
ax3.grid(True, alpha=0.3, which='both', linestyle=':')
ax3.set_ylim(120, 145)

# PANEL 4: Fraktálgömb 3D, λ₂₂ pozíció
ax4 = fig.add_subplot(2, 2, 4, projection='3d')
theta_arr = np.angle(sajatert)
phi_arr = np.linspace(0, 4*np.pi, 33)
r_arr = np.log10(sajatert_abs)
x_pts = r_arr * np.sin(np.abs(theta_arr)) * np.cos(phi_arr)
y_pts = r_arr * np.sin(np.abs(theta_arr)) * np.sin(phi_arr)
z_pts = r_arr * np.cos(np.abs(theta_arr))

# A 33 pont színezése
for i in range(33):
    if i == idx_alpha:
        ax4.scatter([x_pts[i]], [y_pts[i]], [z_pts[i]], s=200, c='green',
                    marker='*', zorder=5)
        ax4.text(x_pts[i], y_pts[i], z_pts[i]+0.3, f'λ₂₂≈α\n(1/{1/lambda_22:.0f})',
                 fontsize=8, fontweight='bold', color='darkgreen')
    elif i < 24:
        ax4.scatter([x_pts[i]], [y_pts[i]], [z_pts[i]], s=40, c='steelblue', alpha=0.6)
    else:
        ax4.scatter([x_pts[i]], [y_pts[i]], [z_pts[i]], s=40, c='red', alpha=0.6)

ax4.set_xlabel('X')
ax4.set_ylabel('Y')
ax4.set_zlabel('Z')
ax4.set_title('Fraktálgömb — λ₂₂ pozíció', fontweight='bold')

plt.tight_layout(rect=[0, 0, 1, 0.95])
output = '/Users/joco/opencode/diagnosztika/szamitas/FazisKoendAlpha_fix.png'
plt.savefig(output, dpi=150, bbox_inches='tight')
print(f"Ábra mentve: {output}")
print()
print(f"λ₂₂ = {lambda_22:.6e}")
print(f"α_CODATA = {alpha_0:.6e}")
print(f"Hiba: {abs(lambda_22 - alpha_0)/alpha_0 * 100:.4f}%")
print(f"1/λ₂₂ = {1/lambda_22:.4f}")
print(f"1/α_CODATA = {1/alpha_0:.4f}")
