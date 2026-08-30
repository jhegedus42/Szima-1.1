"""
Komplex exponencialis fixpont (ϱ) + aranymetszes kontrakcio + fazis oszcillacio
Forras: arXiv:2606.01668 (Bickford 2026) — Self-Referential Fixed Point of Complex Exponential
Forras: John D. Cook (2025) — Complex golden convergence
"""
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec

# ─── ϱ = komplex exponencialis fixpont ──────────────────────
# exp(ϱ) = ϱ, ϱ = -W_{-1}(-1)
# Numerikusan: ϱ ≈ 0.3181315052047648 + 1.3372357014306894i
# Iteracio: z_{n+1} = log(z_n)  (attracting, |log'| = 1/|ϱ| < 1)
#           z_{n+1} = exp(z_n)  (repelling, |exp'| = |ϱ| > 1)

N = 80

# 1. Aranymetszes kontrakcio: z_{n+1} = √(1+z_n) → φ
def golden_contraction(n):
    z = 0.0 + 0j
    for _ in range(n):
        z = np.sqrt(1 + z)
    return z

# 2. Kvantum Y = kontrakcio + fazis
def kvantum_y(n, theta=2*np.pi / (1.618033988749895**2)):
    z = 0.0 + 0j
    for k in range(n):
        kontrakcio = np.sqrt(1 + z)
        fazis = np.exp(1j * theta * 0.001 * k)
        z = fazis * kontrakcio
    return z

# 3. ϱ fixpont iteracio (log = attracting)
def ro_log_iter(n):
    z = 1.0 + 0.5j  # kezdoertek a bazisban
    for _ in range(n):
        z = np.log(z)  # log vonzza a fixpontot
    return z

# 4. ϱ fixpont iteracio (exp = repelling, de altalanos)
def ro_exp_iter(n):
    z = 0.3 + 1.3j  # kezdoertek a fixpont kozel
    for _ in range(n):
        z = np.exp(z)
    return z

# ─── Adatok ─────────────────────────────────────────────────
phi = (1 + np.sqrt(5)) / 2
ro = 0.3181315052047648 + 1.3372357014306894j
delta_ro = 1 - ro.real * np.pi

ks = np.arange(N)
arany = [golden_contraction(k) for k in ks]
arany_conv = [abs(z - phi) for z in arany]

kvantum_y_z = [kvantum_y(k) for k in ks]
kvantum_y_re = [z.real for z in kvantum_y_z]
kvantum_y_im = [z.imag for z in kvantum_y_z]
kvantum_y_abs = [abs(z - phi) for z in kvantum_y_z]

ro_log_z = [ro_log_iter(k) for k in ks]
ro_log_re = [z.real for z in ro_log_z]
ro_log_im = [z.imag for z in ro_log_z]
ro_log_abs = [abs(z - ro) for z in ro_log_z]

# ─── Rajzolas ───────────────────────────────────────────────
fig = plt.figure(figsize=(16, 10), facecolor='#0d1117')
gs = GridSpec(3, 2, hspace=0.35, wspace=0.3)

# 1. Aranymetszes kontrakcio (konvergencia)
ax1 = fig.add_subplot(gs[0, 0], facecolor='#161b22')
ax1.semilogy(ks, arany_conv, color='#58a6ff', linewidth=2)
ax1.set_title('Aranymetszes kontrakcio: $\\sqrt{1+z} \\to \\varphi$\n|z_n - φ| konvergál exponenciálisan', color='#c9d1d9', fontsize=11)
ax1.set_xlabel('lepés', color='#8b949e')
ax1.set_ylabel('|z - φ|', color='#8b949e')
ax1.tick_params(colors='#8b949e')
for spine in ax1.spines.values(): spine.set_color('#30363d')
ax1.axhline(1e-10, color='#f85149', linestyle='--', alpha=0.5, label='10⁻¹⁰')
ax1.legend(fontsize=9)

# 2. Kvantum Y: Re vs Im
ax2 = fig.add_subplot(gs[0, 1], facecolor='#161b22')
ax2.plot(ks, kvantum_y_re, color='#58a6ff', linewidth=2, label='Re(Y)')
ax2.plot(ks, kvantum_y_im, color='#f778ba', linewidth=2, label='Im(Y) = fázis')
ax2.axhline(phi, color='#56d364', linestyle='--', alpha=0.5, label=f'φ = {phi:.4f}')
ax2.set_title('Kvantum Y: Re konvergál, Im oszcillál\n$Y_\\varphi(f) = e^{i\\theta} \\cdot \\sqrt{1 + Y_\\varphi(f)}$', color='#c9d1d9', fontsize=11)
ax2.set_xlabel('lepés', color='#8b949e')
ax2.set_ylabel('érték', color='#8b949e')
ax2.tick_params(colors='#8b949e')
for spine in ax2.spines.values(): spine.set_color('#30363d')
ax2.legend(fontsize=9)

# 3. ϱ fixpont iteráció (log = attracting)
ax3 = fig.add_subplot(gs[1, 0], facecolor='#161b22')
ax3.plot(ks, ro_log_re, color='#58a6ff', linewidth=2, label=f'Re(z) → Re(ϱ) = {ro.real:.6f}')
ax3.plot(ks, ro_log_im, color='#f778ba', linewidth=2, label=f'Im(z) → Im(ϱ) = {ro.imag:.6f}')
ax3.axhline(ro.real, color='#58a6ff', linestyle='--', alpha=0.4)
ax3.axhline(ro.imag, color='#f778ba', linestyle='--', alpha=0.4)
ax3.set_title('ϱ fixpont: log iteráció (attracting)\nlog(z_n) → ϱ = 0.318 + 1.337i', color='#c9d1d9', fontsize=11)
ax3.set_xlabel('lepés', color='#8b949e')
ax3.set_ylabel('érték', color='#8b949e')
ax3.tick_params(colors='#8b949e')
for spine in ax3.spines.values(): spine.set_color('#30363d')
ax3.legend(fontsize=9)

# 4. ϱ konvergencia: |z_n - ϱ|
ax4 = fig.add_subplot(gs[1, 1], facecolor='#161b22')
ax4.semilogy(ks, ro_log_abs, color='#56d364', linewidth=2, label='|z_n - ϱ| (log iteráció)')
ax4.set_title('ϱ konvergencia: |z_n - ϱ| → 0\nlog vonzza, exp taszítja', color='#c9d1d9', fontsize=11)
ax4.set_xlabel('lepés', color='#8b949e')
ax4.set_ylabel('|z - ϱ|', color='#8b949e')
ax4.tick_params(colors='#8b949e')
for spine in ax4.spines.values(): spine.set_color('#30363d')
ax4.legend(fontsize=9)

# 5. Komplex síkon: ϱ + aranymetszes spirál
ax5 = fig.add_subplot(gs[2, 0], facecolor='#161b22')
arany_traj = [golden_contraction(k) for k in range(30)]
arany_x = [z.real for z in arany_traj]
arany_y = [z.imag for z in arany_traj]
ax5.plot(arany_x, arany_y, color='#58a6ff', linewidth=2, marker='o', markersize=3, label='√(1+z) → φ')
ax5.plot(phi, 0, 'o', color='#56d364', markersize=10, label=f'φ = {phi:.3f}')
ax5.plot(ro.real, ro.imag, '*', color='#f778ba', markersize=15, label=f'ϱ = {ro.real:.3f}+{ro.imag:.3f}i')
ax5.set_title('Komplex síkon: aranymetszes spirál + ϱ fixpont', color='#c9d1d9', fontsize=11)
ax5.set_xlabel('Re(z)', color='#8b949e')
ax5.set_ylabel('Im(z)', color='#8b949e')
ax5.tick_params(colors='#8b949e')
for spine in ax5.spines.values(): spine.set_color('#30363d')
ax5.legend(fontsize=9)

# 6. δ = irreducible gap
ax6 = fig.add_subplot(gs[2, 1], facecolor='#161b22')
ax6.axhline(ro.real * np.pi, color='#58a6ff', linewidth=2, label=f'Re(ϱ)·π = {ro.real*np.pi:.6f}')
ax6.axhline(1.0, color='#56d364', linewidth=2, linestyle='--', label='1.0 (cél)')
ax6.fill_between([0, 1], [ro.real*np.pi, ro.real*np.pi], [1.0, 1.0], alpha=0.2, color='#f85149')
ax6.text(0.5, 0.997, f'δ = {delta_ro:.4e}\n(irreducible gap = CPT-rest)', ha='center', va='center', color='#f85149', fontsize=11)
ax6.set_xlim(0, 1)
ax6.set_ylim(0.998, 1.001)
ax6.set_title('δ = irreducible gap (Bickford 2026)\n1 - Re(ϱ)·π = 5.604×10⁻⁴', color='#c9d1d9', fontsize=11)
ax6.set_xticks([])
ax6.set_ylabel('érték', color='#8b949e')
ax6.tick_params(colors='#8b949e')
for spine in ax6.spines.values(): spine.set_color('#30363d')
ax6.legend(fontsize=9)

fig.suptitle('Komplex exponencialis fixpont (ϱ) + Aranymetszes kontrakcio + Fázis oszcillacio\nForras: arXiv:2606.01668 (Bickford 2026), John D. Cook (2025)',
             color='#c9d1d9', fontsize=13, y=0.98)

plt.savefig('/Users/joco/opencode/ro_fixpont_plot.png', dpi=150, facecolor='#0d1117', bbox_inches='tight')
print("Mentve: ro_fixpont_plot.png")