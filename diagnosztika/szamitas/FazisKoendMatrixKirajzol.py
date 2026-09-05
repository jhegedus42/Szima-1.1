# SZABALY0-IDRISBEN-LEHETETLEN(átmeneti) — numerikus kutatás-szimuláció, Idrisbe átírandó (Komplex.idr-minta); hullám-3 nyilvántartás
"""
FazisKoendMatrixKirajzol.py — A 33x33 Pauli-Hamilton matrix kirajzolasa,
szemleletesen, 4 panelben:

1. A matrix homoterképe (valos + kepzetes resz)
2. A 33 sajatértek (WTC + on-korrekcio szetvalasztassal)
3. A 24 WTC vs. CODATA arány (log skálán)
4. A 9 fazis-koend on-korrekcio

Minden panel magyar nyelvu, mert minden azonosito magyar.
"""

import numpy as np
import sys
sys.path.insert(0, '/Users/joco/opencode/diagnosztika/szamitas')
from FazisKoendPauli import H, sajatertekek_rendezett
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
import matplotlib.patches as mpatches

# ═══════════════════════════════════════════════════════════════
# A BLOKKOK POZÍCIÓI A 33-AS MÁTRIXBAN
# ═══════════════════════════════════════════════════════════════

blokk_poz = [
    (0, 3, 'gauge\n(3x3)', '#e8d5ff'),       # lila
    (3, 5, 'Higgs\n(2x2)', '#ffd5e8'),        # pink
    (5, 14, 'Yukawa\n(9x9)', '#d5e8ff'),      # kek
    (14, 18, 'CKM\n(4x4)', '#d5ffe8'),        # zold
    (18, 21, 'neutr.\n(3x3)', '#ffffd5'),     # sarga
    (21, 23, 'PMNS\n(2x2)', '#ffd5d5'),       # voros
    (23, 26, 'E8\n(3x3)', '#e8d5d5'),         # voroses
    (26, 29, 'kod\n(3x3)', '#d5d5ff'),        # kek2
    (29, 31, 'Major.\n(2x2)', '#ffe8d5'),     # narancs
    (31, 32, 'θQCD\n(1x1)', '#d5ffff'),       # cyan
    (32, 33, 'G\n(1x1)', '#ffffff'),          # feher
]

# ═══════════════════════════════════════════════════════════════
# A 4 PANELES ÁBRA
# ═══════════════════════════════════════════════════════════════

fig = plt.figure(figsize=(20, 16))
fig.suptitle('A 33x33 Pauli-Hamilton (Standard Modell + E8xE8 + Steane kod)',
             fontsize=18, fontweight='bold', y=0.995)

# ──────────────────────────────────────────────────────────────
# PANEL 1: A MÁTRIX HŐTÉRKÉPE (valós + képzetes rész)
# ──────────────────────────────────────────────────────────────
ax1 = plt.subplot(2, 2, 1)

# A mátrix abszolút értéke (log skálán)
H_abs = np.abs(H)
H_log = np.log10(H_abs + 1e-25)

im1 = ax1.imshow(H_log, cmap='viridis', aspect='equal', interpolation='nearest',
                 vmin=H_log[H_log > -24].min(), vmax=H_log.max())

# A blokk-határok (piros szaggatott vonalak)
for start, end, _, _ in blokk_poz[:-1]:
    ax1.axhline(end - 0.5, color='red', linewidth=1.2, linestyle='--', alpha=0.6)
    ax1.axvline(end - 0.5, color='red', linewidth=1.2, linestyle='--', alpha=0.6)

# A blokkok színezése (színes keretek)
for start, end, nev, szin in blokk_poz:
    rect = Rectangle((start - 0.5, start - 0.5), end - start, end - start,
                     linewidth=2.5, edgecolor='red', facecolor='none')
    ax1.add_patch(rect)

# A blokk-nevek (a felső és bal szélén)
for start, end, nev, szin in blokk_poz:
    ax1.text((start + end - 1) / 2, -2.0, nev, ha='center', va='bottom',
             fontsize=8, color='darkred', fontweight='bold')
    ax1.text(-2.0, (start + end - 1) / 2, nev, ha='right', va='center',
             fontsize=8, color='darkred', fontweight='bold', rotation=90)

ax1.set_title('A 33x33 H mátrix (log|x| homotérkép)',
              fontsize=13, fontweight='bold', pad=15)
ax1.set_xlabel('Oszlop index')
ax1.set_ylabel('Sor index')
ax1.set_xticks(range(0, 33, 3))
ax1.set_yticks(range(0, 33, 3))
plt.colorbar(im1, ax=ax1, fraction=0.046, pad=0.04, label='log|x|')

# ──────────────────────────────────────────────────────────────
# PANEL 2: A 33 SAJÁTÉRTÉK
# ──────────────────────────────────────────────────────────────
ax2 = plt.subplot(2, 2, 2)

sajatert_abs = np.abs(sajatertekek_rendezett)
szinek = ['darkblue'] * 24 + ['darkred'] * 9

bars = ax2.bar(range(1, 34), sajatert_abs, color=szinek,
               edgecolor='black', linewidth=0.5)
ax2.set_yscale('log')
ax2.set_xlabel('Sajátérték index', fontsize=11)
ax2.set_ylabel('|λ| (log skála)', fontsize=11)
ax2.set_title('A 33 sajátérték (24 WTC + 9 ön-korrekció)',
              fontsize=13, fontweight='bold')
ax2.axvline(x=24.5, color='red', linewidth=2.5, linestyle='--',
            label='24 WTC ↔ 9 ön-korrekció határ')
ax2.legend(loc='upper right', fontsize=10)
ax2.grid(True, alpha=0.3, which='both', linestyle=':')

# Feliratok a legnagyobbakra
for i in [0, 1, 2, 3, 4, 11, 23, 32]:
    ax2.annotate(f'λ{i+1}={sajatert_abs[i]:.1e}',
                 xy=(i + 1, sajatert_abs[i]),
                 xytext=(i + 1, sajatert_abs[i] * 2.5),
                 ha='center', fontsize=8,
                 color='darkblue' if i < 24 else 'darkred')

# ──────────────────────────────────────────────────────────────
# PANEL 3: A 24 WTC vs. CODATA
# ──────────────────────────────────────────────────────────────
ax3 = plt.subplot(2, 2, 3)

wtc_nevek = [
    "g₁(U₁)", "g₂(SU₂)", "g₃(SU₃)", "v_Higgs", "m_Higgs",
    "y_u", "y_c", "y_t", "y_d", "y_s", "y_b", "y_e", "y_μ", "y_τ",
    "CKM_θ₁₂", "CKM_θ₁₃", "CKM_θ₂₃", "δ_CP",
    "m_ν₁", "m_ν₂", "m_ν₃",
    "PMNS_θ₁₂", "PMNS_θ₁₃", "G"
]
wtc_codata = [0.357, 0.652, 1.221, 246.22, 125.1,
              1.27e-5, 7.31e-3, 0.995, 2.66e-5, 5.55e-4, 2.39e-2, 2.95e-6,
              6.39e-4, 1.01e-2, 0.2273, 3.61e-3, 4.07e-2, 1.144,
              1e-12, 1e-10, 5e-11, 0.583, 0.149, 6.674e-11]
sajatert_wtc = sajatertekek_rendezett[:24].real
arány = []
for c, s in zip(wtc_codata, sajatert_wtc):
    if c != 0:
        arány.append(abs(s / c))
    else:
        arány.append(0)
arány = np.array(arány)

x = np.arange(24)
szinek_arany = ['#2255cc' if a > 100 else '#22aa55' if a > 1 else '#cc8822'
                for a in arány]
ax3.bar(x, arány, color=szinek_arany, edgecolor='black', linewidth=0.5)
ax3.set_yscale('log')
ax3.set_xticks(x)
ax3.set_xticklabels(wtc_nevek, rotation=70, fontsize=8, ha='right')
ax3.set_ylabel('|λ_i / CODATA_i| (log)', fontsize=11)
ax3.set_title('A 24 WTC-állapot vs. CODATA arány',
              fontsize=13, fontweight='bold')
ax3.axhline(y=1, color='red', linewidth=1.5, linestyle='--',
            label='arány=1 (tökéletes illesztés)')
ax3.legend(loc='upper right', fontsize=9)
ax3.grid(True, alpha=0.3, which='both', linestyle=':')

# ──────────────────────────────────────────────────────────────
# PANEL 4: A 9 ÖN-KORREKCIÓ
# ──────────────────────────────────────────────────────────────
ax4 = plt.subplot(2, 2, 4)

ok_nevek = [
    "|W(E8)|", "θ_sor", "dim E8",
    "[[7,1,3]]", "[[15,1,3]]", "[[31,1,3]]",
    "α₂₁", "α₃₁", "θ_QCD"
]
sajatert_ok = sajatertekek_rendezett[24:33].real
sajatert_ok_abs = np.abs(sajatert_ok)

ax4.barh(range(9), sajatert_ok_abs, color='darkred',
         edgecolor='black', linewidth=0.5)
ax4.set_yticks(range(9))
ax4.set_yticklabels(ok_nevek, fontsize=10)
ax4.set_xscale('log')
ax4.set_xlabel('|λ| (log skála)', fontsize=11)
ax4.set_title('A 9 fázis-koend ön-korrekció (16. dimenzió)',
              fontsize=13, fontweight='bold')
ax4.grid(True, alpha=0.3, which='both', linestyle=':')

for i in range(9):
    ax4.text(sajatert_ok_abs[i] * 1.7, i, f'{sajatert_ok_abs[i]:.1e}',
             va='center', fontsize=9, color='darkred')

# ──────────────────────────────────────────────────────────────
# MENTÉS
# ──────────────────────────────────────────────────────────────

plt.tight_layout(rect=[0, 0, 1, 0.97])

# Két fájlba mentjük: teljes és kicsi
output_full = '/Users/joco/opencode/diagnosztika/szamitas/FazisKoendMatrix_4panel.png'
output_small = '/Users/joco/opencode/diagnosztika/szamitas/FazisKoendMatrix_kicsi.png'

plt.savefig(output_full, dpi=150, bbox_inches='tight')
plt.savefig(output_small, dpi=80, bbox_inches='tight')

print(f"Ábra mentve:")
print(f"  Teljes felbontás: {output_full}")
print(f"  Kicsi felbontás:  {output_small}")

# Statisztika
print()
print("=" * 60)
print("A 33x33 MÁTRIX STATISZTIKÁJA")
print("=" * 60)
print(f"  Méret:           33x33 = 1089 komplex elem")
print(f"  Önadjungált:     {np.allclose(H, H.conj().T)}")
print(f"  Determiáns:      {np.linalg.det(H):.3e}")
print(f"  Rang:            {np.linalg.matrix_rank(H)}")
print(f"  Kondíciószám:    {np.linalg.cond(H):.3e}")
print()
print(f"  24 legnagyobb |λ|: {sajatert_abs[0]:.3e} ... {sajatert_abs[23]:.3e}")
print(f"  9 maradék |λ|:    {sajatert_abs[24]:.3e} ... {sajatert_abs[32]:.3e}")
print(f"  Különbség:        {sajatert_abs[23] / sajatert_abs[32]:.3e}-szeres")
print()
print(f"  Valós elemek száma (Re ≠ 0): {np.sum(H.real != 0)}")
print(f"  Képzetes elemek száma (Im ≠ 0): {np.sum(H.imag != 0)}")
print(f"  Diagonális elemek: 33 (mind valós)")

plt.show()