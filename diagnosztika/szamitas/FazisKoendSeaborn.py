"""
FazisKoendSeaborn.py — A 33x33 Pauli-Hamilton SEABORN stílusú vizualizáció.

Seaborn:
  - Verzió: 0.13.2
  - Stílusok: darkgrid, whitegrid, dark, white, ticks
  - Paletták: deep, muted, pastel, bright, dark, colorblind, husl, hls, rocket, viridis, magma

A program:
  1. A 33x33 H mátrix hőtérképe (seaborn.heatmap, felső háromszög)
  2. A 33 sajátérték eloszlása (seaborn.histplot KDE-vel)
  3. A 24 WTC vs CODATA arány (seaborn.barplot, viridis paletta)
  4. A 9 ön-korrekció (seaborn horizontal barplot, rocket paletta)
  5. Korrelációs heatmap a WTC és ön-korrekciók között
  6. Pairplot a Pauli-sajátvektorok között
"""

import numpy as np
import sys
sys.path.insert(0, '/Users/joco/opencode/diagnosztika/szamitas')
from FazisKoendPauliTeljes import H, sajatertekek_rendezett
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import seaborn as sns
from scipy.linalg import expm

# Seaborn stílus és paletta beállítása
sns.set_theme(style="darkgrid", palette="husl", font_scale=1.0)

print("=" * 70)
print("A 33x33 PAULI-HAMILTON SEABORN VIZUALIZÁCIÓ")
print("=" * 70)
print(f"Seaborn verzió: {sns.__version__}")

# ═══════════════════════════════════════════════════════════════
# 6 PANELES ÁBRA
# ═══════════════════════════════════════════════════════════════

fig = plt.figure(figsize=(22, 16))
fig.suptitle('A 33×33 Pauli-Hamilton (Seaborn 0.13.2 stílus)',
             fontsize=18, fontweight='bold', y=0.995)

# ──────────────────────────────────────────────────────────────
# PANEL 1: A mátrix hőtérképe (seaborn.heatmap)
# ──────────────────────────────────────────────────────────────
ax1 = plt.subplot(2, 3, 1)
H_abs = np.abs(H)
H_log = np.log10(H_abs + 1e-25)
# Csak a felső háromszögöt mutatjuk (Hermitikus → az alsó ugyanaz)
mask = np.zeros_like(H_log, dtype=bool)
mask[np.tril_indices_from(mask)] = True
sns.heatmap(H_log, mask=mask, cmap='magma', ax=ax1,
            cbar_kws={'label': 'log|x|'}, square=True,
            linewidths=0.3, linecolor='gray', xticklabels=3, yticklabels=3)
ax1.set_title('Hőtérkép (seaborn, felső háromszög)', fontweight='bold')

# ──────────────────────────────────────────────────────────────
# PANEL 2: A 33 sajátérték eloszlása (histplot KDE-vel)
# ──────────────────────────────────────────────────────────────
ax2 = plt.subplot(2, 3, 2)
sajatert_abs = np.abs(sajatertekek_rendezett)
sns.histplot(np.log10(sajatert_abs), bins=12, kde=True, ax=ax2,
             color='crimson', edgecolor='black', alpha=0.7)
ax2.set_title('A 33 sajátérték eloszlása (KDE)', fontweight='bold')
ax2.set_xlabel('log|λ|')
ax2.axvline(x=np.log10(sajatert_abs[23]), color='red',
            linestyle='--', label='24/9 határ')
ax2.legend(fontsize=9)

# ──────────────────────────────────────────────────────────────
# PANEL 3: A 24 WTC vs CODATA (barplot, viridis)
# ──────────────────────────────────────────────────────────────
ax3 = plt.subplot(2, 3, 3)
wtc_nevek = ['g₁', 'g₂', 'g₃', 'v_H', 'm_H', 'y_u', 'y_c', 'y_t',
             'y_d', 'y_s', 'y_b', 'y_e', 'y_μ', 'y_τ',
             'CKM₁₂', 'CKM₁₃', 'CKM₂₃', 'δ_CP',
             'm_ν₁', 'm_ν₂', 'm_ν₃', 'PMNS₁₂', 'PMNS₁₃', 'G']
wtc_codata = [0.357, 0.652, 1.221, 246.22, 125.1,
              1.27e-5, 7.31e-3, 0.995, 2.66e-5, 5.55e-4, 2.39e-2,
              2.95e-6, 6.39e-4, 1.01e-2, 0.2273, 3.61e-3, 4.07e-2,
              1.144, 1e-12, 1e-10, 5e-11, 0.583, 0.149, 6.674e-11]
sajatert_wtc = sajatertekek_rendezett[:24].real
arany = [abs(s/c) if c != 0 else 0 for s, c in zip(sajatert_wtc, wtc_codata)]
sns.barplot(x=list(range(24)), y=np.log10(np.array(arany)+1e-10),
            ax=ax3, palette='viridis')
ax3.set_xticks(range(24))
ax3.set_xticklabels(wtc_nevek, rotation=70, fontsize=7, ha='right')
ax3.set_ylabel('log|λ/CODATA|')
ax3.set_title('24 WTC vs. CODATA (viridis)', fontweight='bold')

# ──────────────────────────────────────────────────────────────
# PANEL 4: A 9 ön-korrekció (rocket horizontal barplot)
# ──────────────────────────────────────────────────────────────
ax4 = plt.subplot(2, 3, 4)
ok_nevek = ['|W(E8)|', 'θ_sor', 'dim E8', '[[7,1,3]]',
            '[[15,1,3]]', '[[31,1,3]]', 'α₂₁', 'α₃₁', 'θ_QCD']
sajatert_ok = np.abs(sajatertekek_rendezett[24:33])
sns.barplot(x=np.log10(sajatert_ok + 1e-20), y=list(range(9)),
            ax=ax4, palette='rocket_r', orient='h')
ax4.set_yticks(range(9))
ax4.set_yticklabels(ok_nevek, fontsize=9)
ax4.set_xlabel('log|λ|')
ax4.set_title('9 ön-korrekció (rocket paletta)', fontweight='bold')

# ──────────────────────────────────────────────────────────────
# PANEL 5: A Pauli-sajátvektorok valós része (kdeplot)
# ──────────────────────────────────────────────────────────────
ax5 = plt.subplot(2, 3, 5)
sajátvektorok = np.linalg.eigh(H)[1]
# Az első 3 sajátvektor valós része
for i in range(3):
    sns.kdeplot(sajátvektorok[:, i].real, ax=ax5, fill=True,
                alpha=0.4, label=f'|ψ_{i+1}⟩ (Re)')
ax5.set_title('A 3 legnagyobb sajátvektor valós része (kdeplot)',
              fontweight='bold')
ax5.set_xlabel('Érték')
ax5.legend(fontsize=9)

# ──────────────────────────────────────────────────────────────
# PANEL 6: A 24 WTC korrelációs mátrix (seaborn.heatmap)
# ──────────────────────────────────────────────────────────────
ax6 = plt.subplot(2, 3, 6)
# Korreláció a sajátértékek és a CODATA között (csak WTC)
wtc_data = np.column_stack([
    np.log10(np.abs(sajatert_wtc) + 1e-15),
    np.log10(np.array(wtc_codata) + 1e-15)
])
corr = np.corrcoef(wtc_data.T)
sns.heatmap(corr, annot=True, fmt='.3f', cmap='coolwarm',
            ax=ax6, square=True, vmin=-1, vmax=1,
            xticklabels=['λ_WTC', 'CODATA'],
            yticklabels=['λ_WTC', 'CODATA'])
ax6.set_title('WTC vs. CODATA korreláció', fontweight='bold')

plt.tight_layout(rect=[0, 0, 1, 0.97])

output = '/Users/joco/opencode/diagnosztika/szamitas/FazisKoendSeaborn_vizualizacio.png'
plt.savefig(output, dpi=120, bbox_inches='tight')
print(f"Seaborn vizualizáció mentve: {output}")

# ──────────────────────────────────────────────────────────────
# BÓNUSZ: PAIRPLOT A 24 WTC + 9 ÖN-KORREKCIÓ SAJÁTÉRTÉKEIRŐL
# ──────────────────────────────────────────────────────────────

fig2, axes2 = plt.subplots(1, 2, figsize=(16, 6))
fig2.suptitle('Seaborn bónusz: a 33 sajátérték eloszlás-elemzése',
              fontsize=14, fontweight='bold')

# Boxplot a 24 WTC és 9 ön-korrekció összehasonlítására
ax_b1 = axes2[0]
data_boxplot = {
    'log|λ|': list(np.log10(np.abs(sajatertekek_rendezett[:24]))),
    'kategória': ['WTC']*24
}
data_boxplot['log|λ|'].extend(list(np.log10(np.abs(sajatertekek_rendezett[24:33]))))
data_boxplot['kategória'].extend(['Ön-korr']*9)
import pandas as pd
df_box = pd.DataFrame(data_boxplot)
sns.boxplot(x='kategória', y='log|λ|', data=df_box, ax=ax_b1,
            palette='Set2', width=0.5)
sns.swarmplot(x='kategória', y='log|λ|', data=df_box, ax=ax_b1,
              color='black', alpha=0.5, size=4)
ax_b1.set_title('WTC vs. ön-korrekció (boxplot + swarmplot)',
                fontweight='bold')

# Violinplot az eloszlás részletes megjelenítéséhez
ax_b2 = axes2[1]
sns.violinplot(x='kategória', y='log|λ|', data=df_box, ax=ax_b2,
               palette='muted', inner='quartile')
ax_b2.set_title('WTC vs. ön-korrekció (violinplot, quartile belső)',
                fontweight='bold')

plt.tight_layout()

output2 = '/Users/joco/opencode/diagnosztika/szamitas/FazisKoendSeaborn_bonusz.png'
plt.savefig(output2, dpi=120, bbox_inches='tight')
print(f"Seaborn bónusz mentve: {output2}")

print()
print("=" * 70)
print("A SEABORN VIZUALIZÁCIÓ EREDMÉNYEI")
print("=" * 70)
print()
print("Panel 1: Hőtérkép — a 33×33 mátrix felső háromszöge")
print("Panel 2: Hisztogram + KDE — a 33 sajátérték log-eloszlása")
print("Panel 3: Barplot (viridis) — a 24 WTC vs. CODATA arány")
print("Panel 4: Horizontal barplot (rocket) — a 9 ön-korrekció")
print("Panel 5: KDE plot — a 3 legnagyobb sajátvektor valós része")
print("Panel 6: Korrelációs heatmap — WTC vs. CODATA Pearson-r")
print()
print("Bónusz panelek:")
print("Boxplot + swarmplot: a 24 WTC és 9 ön-korrekció eloszlás-összehasonlítása")
print("Violinplot: a quartilisek szerinti belső struktúra")
print()

# Korreláció kiírása
print(f"A WTC sajátértékek és a CODATA Pearson-féle korrelációja:")
print(f"  r = {corr[0, 1]:.4f}")
print(f"  (1.0 = tökéletes korreláció, 0 = független, -1 = anti-korreláció)")
print()

plt.show()