"""
FazisKoend2kat3kat.py — A 2-kategória és 3-kategória ábrázolása,
a Fano-sík + 33×33 Pauli-Hamilton kontextusban.

A 2-kategória (2-category):
  - Objektumok: 0-sejtek (pontok, csúcsok)
  - Morfizmusok: 1-sejtek (nyilak, élek) — objektumok KÖZÖTT
  - 2-morfizmusok: 2-sejtek (felületek) — morfizmusok KÖZÖTT
  - Az egyenlőségig terjedő információ: a 2-sejt a két 1-sejt közti átalakítás

A 3-kategória (3-category):
  - Objektumok: 0-sejtek
  - 1-morfizmusok: 1-sejtek (nyilak)
  - 2-morfizmusok: 2-sejtek (felületek)
  - 3-morfizmusok: 3-sejtek (térfogatok) — 2-sejtek KÖZÖTT
  - Az egyenlőségig: a 3-sejt a két 2-sejt közti átalakítás

A 33-as Pauli-modellben:
  - 0-sejt: egy Standard Modell paraméter (24 + 9 = 33)
  - 1-sejt: egy fizikai átmenet (mértani sor, renormálás)
  - 2-sejt: egy szimmetria-művelet (gauge, SU(3)×SU(2)×U(1))
  - 3-sejt: a fázis-koend Y-kombinátor (ön-fixpont)
  - A 3-kategória a fázis-koend algebrai formája

A Fano-sík a 2-kategóriában:
  - 7 pont = 7 objektum (a Steane [[7,1,3]] kód fizikai kubitjei)
  - 7 egyenes = 7 morfizmus (a kód stabilizátor-generátorai)
  - A Fano-sík automorfizmusai = a 2-morfizmusok
  - A 7×7 incidencia-mátrix = a 2-kategória hom-részében

A 3-kategóriában a Fano-sík:
  - Hozzáadódik a 3-sejt = a Y-kombinátor fázis-operátora
  - A 7 pont × 3 (X, Y, Z) = 21 komponens
  - + 7 egyenes × 2 (X-stabilizátor, Z-stabilizátor) = 14
  - + 1 Y-kombinátor = 1
  - Összesen: 21 + 14 + 1 = 36, ami közel van a 33-hoz (a 36-3 = 33)
"""

import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import FancyArrowPatch, FancyBboxPatch, Circle, Polygon
from matplotlib.lines import Line2D
from mpl_toolkits.mplot3d import Axes3D
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
import sys
sys.path.insert(0, '/Users/joco/opencode/diagnosztika/szamitas')

# A Fano-sík 7 pontja és 7 egyenese
egyenesek = [
    [0, 1, 3], [1, 2, 4], [2, 3, 5], [3, 4, 6],
    [4, 5, 0], [5, 6, 1], [6, 0, 2]
]

# A 7 pont koordinátája (egységkörön + középpont)
pontok_xy = [
    (np.cos(0), np.sin(0)),
    (np.cos(np.pi/3), np.sin(np.pi/3)),
    (np.cos(2*np.pi/3), np.sin(2*np.pi/3)),
    (np.cos(np.pi), np.sin(np.pi)),
    (np.cos(4*np.pi/3), np.sin(4*np.pi/3)),
    (np.cos(5*np.pi/3), np.sin(5*np.pi/3)),
    (0, 0),
]

# A 7 egyenes kp-i pozíciója (a feliratokhoz)
egyenes_kozepe = []
for egyenes in egyenesek:
    xs = [pontok_xy[p][0] for p in egyenes]
    ys = [pontok_xy[p][1] for p in egyenes]
    egyenes_kozepe.append((np.mean(xs), np.mean(ys)))

# ═══════════════════════════════════════════════════════════════
# 1. A 2-KATEGÓRIA ÁBRÁJA (Fano-sík)
# ═══════════════════════════════════════════════════════════════

fig = plt.figure(figsize=(20, 14))
fig.suptitle('A 2-KATEGÓRIA és a 3-KATEGÓRIA\n'
             '(a Fano-sík + a 33×33 Pauli-Hamilton rendszerben)',
             fontsize=18, fontweight='bold', y=0.995)

# ──────────────────────────────────────────────────────────────
# PANEL 1: A 2-kategória (Fano-sík + 2-sejt morfizmusok)
# ──────────────────────────────────────────────────────────────
ax1 = plt.subplot(2, 2, 1)

# A 7 egyenes (morfizmusok)
for i, egyenes in enumerate(egyenesek):
    if 6 in egyenes:
        other = [p for p in egyenes if p != 6]
        p1, p2 = pontok_xy[other[0]], pontok_xy[other[1]]
        ax1.plot([p1[0], p2[0]], [p1[1], p2[1]], 'b-', linewidth=2, alpha=0.7)
    else:
        pts = [pontok_xy[p] for p in egyenes]
        for j in range(3):
            for k in range(j+1, 3):
                ax1.plot([pts[j][0], pts[k][0]], [pts[j][1], pts[k][1]],
                         'b-', linewidth=2, alpha=0.7)

# A 2-sejt (zöld felület az egyenesek "között") — egy ötszög a közepén
center_pentagon = Polygon([(np.cos(2*np.pi*k/5 + np.pi/2)*0.3,
                            np.sin(2*np.pi*k/5 + np.pi/2)*0.3) for k in range(5)],
                          closed=True, facecolor='green', alpha=0.3,
                          edgecolor='darkgreen', linewidth=2)
ax1.add_patch(center_pentagon)
ax1.text(0, 0, '2-sejt\n(morfizmusok\nközött)',
         ha='center', va='center', fontsize=8, fontweight='bold',
         color='darkgreen')

# A 7 pont (objektumok)
for i, (x, y) in enumerate(pontok_xy):
    ax1.scatter([x], [y], s=400, color='red', zorder=5, edgecolor='darkred')
    ax1.annotate(f'{i}\n(0-sejt)', (x, y), ha='center', va='center',
                 fontsize=9, color='white', fontweight='bold', zorder=6)

# A 7 egyenes címkéje
for i, (x, y) in enumerate(egyenes_kozepe):
    if i < 6:  # az első 6 egyenes (a 7. a középpontban van)
        ax1.annotate(f'L_{i+1}\n(1-sejt)', (x*1.3, y*1.3),
                     ha='center', va='center', fontsize=7,
                     color='darkblue', fontweight='bold',
                     bbox=dict(boxstyle='round', facecolor='lightyellow', alpha=0.7))

ax1.set_xlim(-1.5, 1.5)
ax1.set_ylim(-1.5, 1.5)
ax1.set_aspect('equal')
ax1.set_title('A 2-KATEGÓRIA\n(Fano-sík: 7 objektum + 7 morfizmus + 1 2-sejt)',
              fontsize=12, fontweight='bold')
ax1.axis('off')

# Jelmagyarázat
ax1.scatter([], [], s=200, color='red', label='0-sejt (objektum)')
ax1.plot([], [], 'b-', linewidth=2, label='1-sejt (morfizmus)')
ax1.scatter([], [], s=500, color='green', alpha=0.5, label='2-sejt (2-morfizmus)')
ax1.legend(loc='lower right', fontsize=9)

# ──────────────────────────────────────────────────────────────
# PANEL 2: A 3-kategória (Fano-sík + 3-sejt Y-kombinátor)
# ──────────────────────────────────────────────────────────────
ax2 = fig.add_subplot(2, 2, 2, projection='3d')

# A 7 pont (0-sejtek) egy tetraéder + 3 csúcs elrendezésben
pontok_3d = [
    (1.0, 0, 0),           # 0
    (-1.0, 0, 0),          # 1
    (0, 1.0, 0),           # 2
    (0, -1.0, 0),          # 3
    (0, 0, 1.0),           # 4
    (0, 0, -1.0),          # 5
    (0, 0, 0),             # 6 (középpont)
]

# A 7 egyenes (1-sejtek) — a tetraéder élei és a középponthoz húzott vonalak
for i, egyenes in enumerate(egyenesek):
    if 6 in egyenes:
        other = [p for p in egyenes if p != 6]
        p1, p2 = pontok_3d[other[0]], pontok_3d[other[1]]
        ax2.plot([p1[0], p2[0]], [p1[1], p2[1]], [p1[2], p2[2]],
                 'b-', linewidth=2, alpha=0.6)
    else:
        pts = [pontok_3d[p] for p in egyenes]
        for j in range(3):
            for k in range(j+1, 3):
                p1, p2 = pts[j], pts[k]
                ax2.plot([p1[0], p2[0]], [p1[1], p2[1]], [p1[2], p2[2]],
                         'b-', linewidth=2, alpha=0.6)

# A 7 tetraéder lap (2-sejt) — a tetraéder belső felülete
tetra_lapok = [
    [pontok_3d[0], pontok_3d[2], pontok_3d[4]],  # 0-2-4
    [pontok_3d[0], pontok_3d[3], pontok_3d[5]],  # 0-3-5
    [pontok_3d[1], pontok_3d[2], pontok_3d[5]],  # 1-2-5
    [pontok_3d[1], pontok_3d[3], pontok_3d[4]],  # 1-3-4
]
for lap in tetra_lapok:
    tri = Poly3DCollection([lap], facecolors='green', alpha=0.2,
                          edgecolor='darkgreen', linewidth=2)
    ax2.add_collection3d(tri)

# A 3-sejt — egy tetraéder a középpont körül (sárga gömb)
u = np.linspace(0, 2 * np.pi, 20)
v = np.linspace(0, np.pi, 20)
x_gomb = 0.4 * np.outer(np.cos(u), np.sin(v))
y_gomb = 0.4 * np.outer(np.sin(u), np.sin(v))
z_gomb = 0.4 * np.outer(np.ones_like(u), np.cos(v))
ax2.plot_surface(x_gomb, y_gomb, z_gomb, color='gold', alpha=0.5,
                 edgecolor='darkorange')
ax2.text(0, 0, 0.6, '3-sejt\n(Y-kombinátor)',
         ha='center', va='center', fontsize=9, fontweight='bold',
         color='darkorange')

# A 7 pont (0-sejtek) — piros gömbök
for i, (x, y, z) in enumerate(pontok_3d):
    if i != 6:
        ax2.scatter([x], [y], [z], s=200, color='red', zorder=5)
        ax2.text(x*1.15, y*1.15, z*1.15, f'{i}', fontsize=10,
                 color='darkred', fontweight='bold')

ax2.set_xlim(-1.3, 1.3)
ax2.set_ylim(-1.3, 1.3)
ax2.set_zlim(-1.3, 1.3)
ax2.set_title('A 3-KATEGÓRIA\n(7 objektum + 7 morfizmus + 4 2-sejt + 1 3-sejt)',
              fontsize=12, fontweight='bold')
ax2.set_xlabel('X')
ax2.set_ylabel('Y')
ax2.set_zlabel('Z')

# ──────────────────────────────────────────────────────────────
# PANEL 3: A 33×33 Pauli-modell 2-kategóriás felépítése
# ──────────────────────────────────────────────────────────────
ax3 = plt.subplot(2, 2, 3)

# A 33-as modell 11×11 blokk-szerkezete mint 2-kategória
# Objektumok (0-sejtek): 11 blokk
# Morfizmusok (1-sejtek): a 11×11 blokkok közötti csatolások

blokk_nevek = [
    'gauge', 'Higgs', 'Yukawa', 'CKM', 'neutr.',
    'PMNS', 'E8', 'kod', 'Major.', 'θQCD', 'G'
]
n_blokk = 11

# Objektumok (színes négyzetek a bal oldalon)
for i, nev in enumerate(blokk_nevek):
    rect = FancyBboxPatch((0.05, 1 - (i+0.8)/n_blokk), 0.15, 0.6/n_blokk,
                          boxstyle='round,pad=0.02',
                          facecolor=plt.cm.tab10(i/n_blokk),
                          edgecolor='black', linewidth=1)
    ax3.add_patch(rect)
    ax3.text(0.125, 1 - (i+0.4)/n_blokk, nev, ha='center', va='center',
             fontsize=8, color='white', fontweight='bold')

# Morfizmusok (vonalak a blokkok között)
for i in range(n_blokk):
    for j in range(n_blokk):
        if i != j:
            x_start = 0.22
            x_end = 0.42
            y_start = 1 - (i+0.4)/n_blokk
            y_end = 1 - (j+0.4)/n_blokk
            ax3.annotate('', xy=(x_end, y_end), xytext=(x_start, y_start),
                         arrowprops=dict(arrowstyle='->', color='gray',
                                         alpha=0.3, lw=0.5))

# A 2-sejt (hom-rész) — a jobb oldali sáv
ax3.text(0.55, 0.95, '2-sejt\n(hom-rész):\nPauli σ₁, σ₂, σ₃',
         ha='center', va='top', fontsize=9, fontweight='bold',
         bbox=dict(boxstyle='round', facecolor='lightyellow', alpha=0.7))

# A Pauli-mátrixok a 2-sejtben
ax3.text(0.55, 0.55,
         'σ₁: X kapu (valós)\n'
         'σ₂: Y kapu (KÉPZETES!)\n'
         'σ₃: Z kapu (valós)\n\n'
         'A Fano-sík σ₂ = iσ₁σ₃',
         ha='center', va='top', fontsize=9, family='monospace',
         bbox=dict(boxstyle='round', facecolor='lightcyan', alpha=0.7))

# A jobb szélén a kimenet
ax3.text(0.85, 0.5, 'Σ 33 paraméter\n24 WTC + 9 ön-korrekció',
         ha='center', va='center', fontsize=11, fontweight='bold',
         bbox=dict(boxstyle='round', facecolor='lightgreen', alpha=0.7))

ax3.set_xlim(0, 1)
ax3.set_ylim(0, 1)
ax3.set_aspect('equal')
ax3.set_title('A 33×33 PAULI-MODELL 2-KATEGÓRIÁJA\n(11 objektum + 11×11 morfizmus + 2-sejt)',
              fontsize=12, fontweight='bold')
ax3.axis('off')

# ──────────────────────────────────────────────────────────────
# PANEL 4: A 33-as modell 3-kategóriás felépítése (Y-kombinátor)
# ──────────────────────────────────────────────────────────────
ax4 = plt.subplot(2, 2, 4)

# A 33-as modell 3-kategóriája:
# 0-sejt: 33 Standard Modell paraméter (24 WTC + 9 ön-korrekció)
# 1-sejt: 11 blokk (gauge, Higgs, Yukawa, ...)
# 2-sejt: 2-sejt = a Pauli-tenzor-szorzat (σ_1 ⊗ σ_1, σ_2 ⊗ σ_2, σ_3 ⊗ σ_3)
# 3-sejt: a Y-kombinátor = a fázis-koend ön-fixpontja

# 0-sejtek: 33 paraméter egy sorban
ax4.text(0.05, 0.95, '0-sejt (33 paraméter)', fontsize=9, fontweight='bold',
         transform=ax4.transAxes)
for i in range(33):
    color = 'lightblue' if i < 24 else 'lightcoral'
    rect = plt.Rectangle((0.02 + i*0.029, 0.85), 0.025, 0.05,
                          facecolor=color, edgecolor='black', linewidth=0.3)
    ax4.add_patch(rect)
ax4.text(0.02 + 24*0.029, 0.78, '|← 24 WTC →||← 9 ön-korr →|',
         fontsize=7, ha='left', va='top')

# 1-sejtek: 11 blokk
ax4.text(0.05, 0.70, '1-sejt (11 blokk)', fontsize=9, fontweight='bold',
         transform=ax4.transAxes)
blokk_meretek = [3, 2, 9, 4, 3, 2, 3, 3, 2, 1, 1]
x_pos = 0.02
for i, (nev, m) in enumerate(zip(blokk_nevek, blokk_meretek)):
    width = m * 0.029
    rect = plt.Rectangle((x_pos, 0.60), width, 0.05,
                          facecolor=plt.cm.tab10(i/11),
                          edgecolor='black', linewidth=0.3)
    ax4.add_patch(rect)
    ax4.text(x_pos + width/2, 0.625, nev, ha='center', va='center',
             fontsize=6, color='white', fontweight='bold')
    x_pos += width

# 2-sejt: Pauli-tenzor
ax4.text(0.05, 0.45, '2-sejt (Pauli-tenzor): σ₁⊗σ₁, σ₂⊗σ₂, σ₃⊗σ₃',
         fontsize=9, fontweight='bold', transform=ax4.transAxes)
ax4.text(0.5, 0.40,
         'σ₁⊗σ₁ (valós)\nσ₂⊗σ₂ (kéPZETES!)\nσ₃⊗σ₃ (valós)',
         ha='center', va='center', fontsize=8, family='monospace',
         bbox=dict(boxstyle='round', facecolor='lightyellow', alpha=0.7))

# 3-sejt: Y-kombinátor
y_komb = FancyBboxPatch((0.3, 0.05), 0.4, 0.18,
                        boxstyle='round,pad=0.05',
                        facecolor='gold', edgecolor='darkorange',
                        linewidth=2)
ax4.add_patch(y_komb)
ax4.text(0.5, 0.18,
         '3-sejt: Y-KOMBINÁTOR\n'
         'Y_ℂ(f) = e^{iφ} · f(Y_ℂ(f))\n'
         'A fázis-koend ön-fixpontja',
         ha='center', va='center', fontsize=10, fontweight='bold',
         color='darkred')

# Nyilak az egyes szintek között
ax4.annotate('', xy=(0.5, 0.55), xytext=(0.5, 0.60),
             arrowprops=dict(arrowstyle='->', color='black', lw=1.5))
ax4.annotate('', xy=(0.5, 0.30), xytext=(0.5, 0.40),
             arrowprops=dict(arrowstyle='->', color='black', lw=1.5))
ax4.annotate('', xy=(0.5, 0.20), xytext=(0.5, 0.30),
             arrowprops=dict(arrowstyle='->', color='black', lw=1.5))

ax4.set_xlim(0, 1)
ax4.set_ylim(0, 1)
ax4.set_title('A 33×33 PAULI-MODELL 3-KATEGÓRIÁJA\n(33 → 11 → 3 → 1 Y-kombinátor)',
              fontsize=12, fontweight='bold')
ax4.axis('off')

plt.tight_layout(rect=[0, 0, 1, 0.97])

output = '/Users/joco/opencode/diagnosztika/szamitas/FazisKoend_2kat_3kat.png'
plt.savefig(output, dpi=120, bbox_inches='tight')
print(f"2-kategória és 3-kategória ábrája mentve: {output}")
print()

# Összefoglaló
print("=" * 70)
print("A 2-KATEGÓRIA ÉS 3-KATEGÓRIA A 33-AS MODELLBEN")
print("=" * 70)
print()
print("A 2-KATEGÓRIA:")
print("  - 0-sejt: Standard Modell paraméter (24 WTC + 9 ön-korrekció)")
print("  - 1-sejt: blokk-csatolás (11×11 blokk a 33-as rendszerben)")
print("  - 2-sejt: Pauli σ₁, σ₂, σ₃ (a morfizmusok közötti átmenet)")
print()
print("A 3-KATEGÓRIA:")
print("  - 0-sejt: 33 paraméter")
print("  - 1-sejt: 11 blokk")
print("  - 2-sejt: 3 Pauli-tenzor (σ₁⊗σ₁, σ₂⊗σ₂, σ₃⊗σ₃)")
print("  - 3-sejt: Y-kombinátor (e^{iφ} ön-fixpont)")
print()
print("A Fano-sík a 2-kategóriában:")
print("  - 7 objektum (0-sejt) + 7 morfizmus (1-sejt) + 1 2-sejt")
print("  - 21 + 14 + 1 = 36 komponens → kiegészítve 33-36 = -3 szimmetria-csökkentés")
print()
print("A Y-kombinátor csak ℂ felett definiálható (e^{iφ} kell)")
print("Ezért a Pauli σ₂ együtthatója (a KÉPZETES fázis) kötelező.")

plt.show()