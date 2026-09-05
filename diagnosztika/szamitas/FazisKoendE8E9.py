# SZABALY0-IDRISBEN-LEHETETLEN(átmeneti) — numerikus kutatás-szimuláció, Idrisbe átírandó (Komplex.idr-minta); hullám-3 nyilvántartás
"""
FazisKoendE8E9.py — Az E8 × E8 + E9 egyesített struktúra,
komplex Pauli-mátrixos felépítésben.

Az E8 × E8 húrelméleti gauge-csoport (a "fázis-koend" húrelméleti analogonja):
  - E8: 248-dimenziós egyszerű Lie-algebra
  - E8 × E8: 496-dimenziós (a két E8 direkt szorzata)
  - Weyl-csoport: |W(E8)| × |W(E8)| = 4.86e17

Az E9 az E8 affin kiterjesztése:
  - Végtelen dimenziós, de a fázis-koendben egy 9-dimenziós projekció
  - Az E9/E8 Cartan-matrixában megjelenő 9 × 9-es struktúra
  - Az affin Weyl-csoport: W̃(E8) = W(E8) ⋉ (a gyökérrács 9-dimenziós altere)

A 33-as Pauli-modellben az E8 × E8 + E9 rendszer:
  - A 33 mátrix 9. blokkja (9 dimenziós, sor 23-25 = 3 E8 + 9 E9?)
  - VAGY a teljes 33-as rendszer egy 9-es struktúrát hordoz

Ebben a fájlban:
  1. Felépítjük az E8 Cartan-matrixát (8x8)
  2. Felépítjük az E9 affin Cartan-matrixát (9x9)
  3. Az E8 × E8 direkt szorzatot (16x16) és a fázis-koend 33-as kapcsolatát
  4. Komplex Pauli-mátrixokkal diagonalizáljuk a 33-as H-t
  5. A Pauli-gömbön való mozgást az E8/E9 alterekben is megmutatjuk
"""

import numpy as np
import sys
sys.path.insert(0, '/Users/joco/opencode/diagnosztika/szamitas')
from FazisKoendPauliTeljes import (
    H, sigma_1, sigma_2, sigma_3, I_2, sajatertekek_rendezett,
    yukawa_arr, ckm_arr, nu_arr, weyl_E8, theta_sor, dim_E8
)
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from scipy.linalg import expm

# ═══════════════════════════════════════════════════════════════
# 1. AZ E8 CARTAN-MÁTRIXA (8x8)
# ═══════════════════════════════════════════════════════════════
# Az E8 Dynkin-diagramja:
#   1---2---3---4---5---6
#                   |
#                   7
#                   |
#                   8 (visszacsatolás 6-hoz)
#
# A Cartan-matrix A_ij = 2(α_i, α_j)/(α_j, α_j) elemei:
# A_ii = 2
# A_ij = -1 ha i és j össze vannak kötve
# A_ij = 0 ha nincsenek összekötve

Cartan_E8 = np.array([
    [ 2, -1,  0,  0,  0,  0,  0,  0],
    [-1,  2, -1,  0,  0,  0,  0,  0],
    [ 0, -1,  2, -1,  0,  0,  0,  0],
    [ 0,  0, -1,  2, -1,  0,  0,  0],
    [ 0,  0,  0, -1,  2, -1,  0,  0],
    [ 0,  0,  0,  0, -1,  2, -1,  0],
    [ 0,  0,  0,  0,  0, -1,  2, -1],
    [ 0,  0,  0,  0,  0,  0, -1,  2]
], dtype=np.float64)

print("=" * 70)
print("AZ E8 CARTAN-MÁTRIXA (8x8)")
print("=" * 70)
print(Cartan_E8)
print(f"\nDetermináns: {np.linalg.det(Cartan_E8):.4f}")
print(f"Sajátértékek: {np.linalg.eigvalsh(Cartan_E8)}")
print()

# Az E8 gyökrendszerének 240 gyöke (egyszerűsített: 8 fő + 232 egyéb)
# Az E8 rangja 8, tehát 8 független Cartan-vektor

# ═══════════════════════════════════════════════════════════════
# 2. AZ E9 AFFIN CARTAN-MÁTRIXA (9x9)
# ═══════════════════════════════════════════════════════════════
# Az E9 az E8 affin kiterjesztése. A 9. egyszerű gyök: α_0 = δ - θ,
# ahol δ a gyökérrács imgáris gyöke, θ a legmagasabb gyök.
#
# A Cartan-matrix 9x9-es, ahol az utolsó sor/oszlop a 9. affin gyök.
#
# E9 affin Cartan-matrixa:
#   0---1---2---3---4---5---6---7
#                  |              |
#                  +-8 (affin)----+
#
# Az affin Cartan-matrix: A_00 = 2, és a 0-ás csomópont össze van kötve
# a 7-es csomóponttal (mert θ tartalmazza α_7-et)

# Az E8 affin Cartan-matrix (E9):
Cartan_E9 = np.array([
    [ 2,  0,  0,  0,  0,  0,  0, -1,  0],   # α_0 = δ - θ
    [ 0,  2, -1,  0,  0,  0,  0,  0,  0],   # α_1
    [ 0, -1,  2, -1,  0,  0,  0,  0,  0],   # α_2
    [ 0,  0, -1,  2, -1,  0,  0,  0,  0],   # α_3
    [ 0,  0,  0, -1,  2, -1,  0,  0,  0],   # α_4
    [ 0,  0,  0,  0, -1,  2, -1,  0,  0],   # α_5
    [ 0,  0,  0,  0,  0, -1,  2, -1,  0],   # α_6
    [-1,  0,  0,  0,  0,  0, -1,  2, -1],   # α_7 (összekötve α_0-val és α_8-cal)
    [ 0,  0,  0,  0,  0,  0,  0, -1,  2]    # α_8 (az új affin gyök, α_0-val összekötve)
], dtype=np.float64)

print("=" * 70)
print("AZ E9 AFFIN CARTAN-MÁTRIXA (9x9)")
print("=" * 70)
print(Cartan_E9)
print(f"\nDetermináns: {np.linalg.det(Cartan_E9):.4f}")
print(f"Ez 0 kellene hogy legyen (a 9. gyök miatt az affin algebra szinguláris)")
print(f"Sajátértékek: {np.linalg.eigvalsh(Cartan_E9)}")
print()

# ═══════════════════════════════════════════════════════════════
# 3. AZ E8 × E8 DIREKT SZORZAT (16x16)
# ═══════════════════════════════════════════════════════════════

Cartan_E8xE8 = np.zeros((16, 16), dtype=np.float64)
Cartan_E8xE8[:8, :8] = Cartan_E8
Cartan_E8xE8[8:, 8:] = Cartan_E8

print("=" * 70)
print("AZ E8 × E8 DIREKT SZORZAT (16x16)")
print("=" * 70)
print(f"Determináns: {np.linalg.det(Cartan_E8xE8):.4f}")
print(f"|W(E8)| × |W(E8)| = {weyl_E8 * weyl_E8:.4e}")
print(f"dim(E8 × E8) = {2 * dim_E8}")
print()

# ═══════════════════════════════════════════════════════════════
# 4. AZ E8 + E9 EGYESÍTETT RENDSZER ÉS A 33-AS MODELL KAPCSOLATA
# ═══════════════════════════════════════════════════════════════

print("=" * 70)
print("AZ E8 + E9 KAPCSOLATA A 33-AS MODELLEL")
print("=" * 70)
print()
print("A 33-as Pauli-modell blokkszerkezete:")
print("  - 11x11 blokk, osszesen 33x33 = 33 szabad parameter")
print("  - Az E8 × E8 + E9 rendszer 16 + 9 = 25 kulonallo egyseges csoportot ad")
print("  - A 33 = 24 (WTC) + 9 (on-korrekcio) + 0 (a 24 magaban foglalja az E8-at is)")
print()
print("Az E8 az 1., 2., 3. blokkban (gauge) jelenik meg a 33-as modellben")
print("  - A gauge-csatolasok (g_1, g_2, g_3) az E8 harom fo komponense")
print("  - Az E9 affin kiterjesztes a 9. on-korrekcioban")
print()

# Az E8 × E8 Weyl-csoport mint fázis-koend:
# W(E8) ≅ Spin(16) / Z_2×Z_2 (az E8 spinszorzata)
# A 33-as Pauli-modell fázis-koendje:
# a 9. ön-korrekció a W(E8) × W(E8) egy 9-dimenziós projekciója

# Az E9 affin gyökrendszer projektált alakja (9 dimenzió):
E9_projected = np.eye(9, dtype=np.complex128) * 0
for i in range(9):
    E9_projected[i, i] = 2 * np.cos(2 * np.pi * i / 9)  # diagonális affin struktúra

print("Az E9 affin struktúra projekciója (9x9 diagonális):")
print(f"  diag: {np.diag(E9_projected.real)[:5]}...")
print()

# ═══════════════════════════════════════════════════════════════
# 5. A 33-AS PAULI-HAMILTON SCHRÖDINGER-EVOLÚCIÓJA AZ E8×E8 + E9 BLOKKOKBAN
# ═══════════════════════════════════════════════════════════════

# A 33-as rendszer Pauli-operátorai az E8 blokkban (sor 23-25, 3x3)
# Itt az E8 × E8 + E9 struktúrát 3 Pauli-blokkba kódoljuk:
# - Blokk 1: E8 első fele (α_1..α_4)
# - Blokk 2: E8 második fele (α_5..α_8)
# - Blokk 3: E9 affin gyök (α_0)

P_E8_1 = np.zeros((33, 33), dtype=np.complex128)
P_E8_1[23, 23] = 1  # E8 α_1
P_E8_1[24, 24] = 1  # E8 α_5
P_E8_1[25, 25] = 1  # E9 α_0

P1_E8 = np.zeros((33, 33), dtype=np.complex128)
P2_E8 = np.zeros((33, 33), dtype=np.complex128)
P3_E8 = np.zeros((33, 33), dtype=np.complex128)

# Az E8 blokk Pauli-mátrixai (3x3-as méret):
P1_E8[23:26, 23:26] = sigma_1  # X kapu az E8 blokkban
P2_E8[23:26, 23:26] = sigma_2  # Y kapu az E8 blokkban (kéPZETES!)
P3_E8[23:26, 23:26] = sigma_3  # Z kapu az E8 blokkban

# Az E8 × E8 + E9 egyesített blokk Pauli-tenzora:
# σ_k^E8×E8 = σ_k ⊗ σ_k (tenzor-szorzat, az E8 × E8 két felére)
P1_E8xE8 = np.zeros((33, 33), dtype=np.complex128)
P1_E8xE8[23:26, 23:26] = np.kron(sigma_1, sigma_1)[:3, :3]
P2_E8xE8 = np.zeros((33, 33), dtype=np.complex128)
P2_E8xE8[23:26, 23:26] = np.kron(sigma_2, sigma_2)[:3, :3]  # KÉPZETES!
P3_E8xE8 = np.zeros((33, 33), dtype=np.complex128)
P3_E8xE8[23:26, 23:26] = np.kron(sigma_3, sigma_3)[:3, :3]

print("=" * 70)
print("AZ E8 × E8 PAULI-TENZOR SZORZATOK A 33-AS MODELLBEN")
print("=" * 70)
print()
print("σ₁ ⊗ σ₁ (X kapu az E8 × E8 tenzor-szorzaton):")
print(P1_E8xE8[23:26, 23:26])
print()
print("σ₂ ⊗ σ₂ (Y kapu az E8 × E8 tenzor-szorzaton) — ez KÉPZETES:")
print(P2_E8xE8[23:26, 23:26])
print()
print("σ₃ ⊗ σ₃ (Z kapu az E8 × E8 tenzor-szorzaton):")
print(P3_E8xE8[23:26, 23:26])
print()

# A Schrödinger-evolúció az E8 × E8 + E9 blokkban
hbar = 1.0
n = 33
sajatertekek, sajátvektorok = np.linalg.eigh(H)

# Inicializálás: a 23-25. sajátállapot (az E8 blokkhoz tartozó)
psi_0 = np.zeros(n, dtype=np.complex128)
psi_0[23] = 1.0 / np.sqrt(2)
psi_0[24] = 1.0 / np.sqrt(2)
psi_0[25] = 1.0 / np.sqrt(2)

print(f"|ψ(0)⟩: az E8 × E8 + E9 blokk 3 állapota (sor 23-25)")
print(f"  E1 = {sajatertekek[23]:.4e}")
print(f"  E2 = {sajatertekek[24]:.4e}")
print(f"  E3 = {sajatertekek[25]:.4e}")
print(f"  ΔE_max = {sajatertekek[25] - sajatertekek[23]:.4e}")
print()

T_total = 4 * np.pi / abs(sajatertekek[25] - sajatertekek[23])  # 2 periódus
N_steps = 300
t = np.linspace(0, T_total, N_steps)

X_E8 = np.zeros(N_steps)
Y_E8 = np.zeros(N_steps)
Z_E8 = np.zeros(N_steps)

psi_t = np.zeros((N_steps, n), dtype=np.complex128)
for i, ti in enumerate(t):
    U_t = expm(-1j * H * ti / hbar)
    psi_t[i] = U_t @ psi_0
    X_E8[i] = np.real(np.conj(psi_t[i]) @ P1_E8xE8 @ psi_t[i])
    Y_E8[i] = np.real(np.conj(psi_t[i]) @ P2_E8xE8 @ psi_t[i])
    Z_E8[i] = np.real(np.conj(psi_t[i]) @ P3_E8xE8 @ psi_t[i])

Bloch_E8 = np.sqrt(X_E8**2 + Y_E8**2 + Z_E8**2)
norma_E8 = np.array([np.real(np.conj(psi) @ psi) for psi in psi_t])

print(f"E8 × E8 + E9 Schrödinger-evolúció:")
print(f"  T = {T_total:.4e} (2 periódus)")
print(f"  Átlagos Bloch-hossz: {np.mean(Bloch_E8):.4f}")
print(f"  Átlagos norma: {np.mean(norma_E8):.10f} (eltérés: {np.max(np.abs(norma_E8 - 1)):.3e})")
print()

# ═══════════════════════════════════════════════════════════════
# 6. A FÁZIS-TÉRKÉP KIRAJZOLÁSA AZ E8 × E8 + E9 BLOKKRA
# ═══════════════════════════════════════════════════════════════

fig = plt.figure(figsize=(18, 14))
fig.suptitle('Az E8 × E8 + E9 rendszer a 33-as Pauli-Hamiltonban\n'
             '(komplex Pauli-tenzor szorzatok + Schrödinger-evolúció)',
             fontsize=16, fontweight='bold')

# ──────────────────────────────────────────────────────────────
# PANEL 1: A Cartan-mátrixok (E8, E9, E8xE8)
# ──────────────────────────────────────────────────────────────
ax1 = plt.subplot(2, 2, 1)
im_E8 = ax1.imshow(Cartan_E8, cmap='RdBu_r', vmin=-2, vmax=2, aspect='equal')
ax1.set_title('E8 Cartan-mátrix (8x8)', fontsize=12, fontweight='bold')
for i in range(8):
    for j in range(8):
        if Cartan_E8[i, j] != 0:
            ax1.text(j, i, f'{int(Cartan_E8[i,j])}', ha='center', va='center',
                     color='white' if abs(Cartan_E8[i,j]) > 1 else 'black', fontsize=10)
plt.colorbar(im_E8, ax=ax1, fraction=0.046, pad=0.04)

# ──────────────────────────────────────────────────────────────
# PANEL 2: E9 affin Cartan-mátrix
# ──────────────────────────────────────────────────────────────
ax2 = plt.subplot(2, 2, 2)
im_E9 = ax2.imshow(Cartan_E9, cmap='RdBu_r', vmin=-2, vmax=2, aspect='equal')
ax2.set_title('E9 affin Cartan-mátrix (9x9)', fontsize=12, fontweight='bold')
for i in range(9):
    for j in range(9):
        if Cartan_E9[i, j] != 0:
            ax2.text(j, i, f'{int(Cartan_E9[i,j])}', ha='center', va='center',
                     color='white' if abs(Cartan_E9[i,j]) > 1 else 'black', fontsize=10)
plt.colorbar(im_E9, ax=ax2, fraction=0.046, pad=0.04)

# ──────────────────────────────────────────────────────────────
# PANEL 3: A Pauli-gömbön való 3D mozgás az E8×E8+E9 blokkban
# ──────────────────────────────────────────────────────────────
ax3 = fig.add_subplot(2, 2, 3, projection='3d')
u = np.linspace(0, 2 * np.pi, 30)
v = np.linspace(0, np.pi, 30)
x_gomb = np.outer(np.cos(u), np.sin(v))
y_gomb = np.outer(np.sin(u), np.sin(v))
z_gomb = np.outer(np.ones_like(u), np.cos(v))
ax3.plot_surface(x_gomb, y_gomb, z_gomb, color='lightblue', alpha=0.15, edgecolor='gray')
ax3.plot(X_E8, Y_E8, Z_E8, color='red', linewidth=2, label='Bloch (E8×E8)')
ax3.scatter([X_E8[0]], [Y_E8[0]], [Z_E8[0]], color='green', s=100, label='|ψ(0)⟩')
ax3.scatter([X_E8[-1]], [Y_E8[-1]], [Z_E8[-1]], color='blue', s=100, label='|ψ(T)⟩')
ax3.set_xlabel('X = ⟨σ₁⊗σ₁⟩', fontsize=10)
ax3.set_ylabel('Y = ⟨σ₂⊗σ₂⟩ (kéPZETES!)', fontsize=10)
ax3.set_zlabel('Z = ⟨σ₃⊗σ₃⟩', fontsize=10)
ax3.set_title('E8×E8+E9 Pauli-gömbön való mozgás', fontsize=12, fontweight='bold')
ax3.legend(loc='upper left', fontsize=9)
ax3.set_xlim(-1, 1)
ax3.set_ylim(-1, 1)
ax3.set_zlim(-1, 1)

# ──────────────────────────────────────────────────────────────
# PANEL 4: X(t), Y(t), Z(t) időfüggvénye az E8×E8 blokkban
# ──────────────────────────────────────────────────────────────
ax4 = plt.subplot(2, 2, 4)
ax4.plot(t, X_E8, 'r-', linewidth=2, label='X(t) = ⟨σ₁⊗σ₁⟩')
ax4.plot(t, Y_E8, 'b-', linewidth=2, label='Y(t) = ⟨σ₂⊗σ₂⟩ (kéPZETES!)')
ax4.plot(t, Z_E8, 'g-', linewidth=2, label='Z(t) = ⟨σ₃⊗σ₃⟩')
ax4.axhline(y=0, color='black', linewidth=0.5, linestyle=':')
ax4.set_xlabel('Idő t', fontsize=11)
ax4.set_ylabel('Pauli-tenzor várakozási érték', fontsize=11)
ax4.set_title('E8×E8+E9 X, Y, Z időfüggvénye', fontsize=12, fontweight='bold')
ax4.legend(loc='best', fontsize=10)
ax4.grid(True, alpha=0.3)

plt.tight_layout(rect=[0, 0, 1, 0.96])

output = '/Users/joco/opencode/diagnosztika/szamitas/FazisKoendE8E9_fazisterkep.png'
plt.savefig(output, dpi=120, bbox_inches='tight')
print(f"E8×E8+E9 fázis-térkép mentve: {output}")
print()

# Statisztikák
print("=" * 70)
print("AZ E8 × E8 + E9 RENDSZER STATISZTIKÁI A 33-AS MODELLBEN")
print("=" * 70)
print()
print(f"  E8 Cartan-matrix:    8x8, det = {np.linalg.det(Cartan_E8):.4f}")
print(f"  E9 affin Cartan:     9x9, det = {np.linalg.det(Cartan_E9):.4f} (singularis)")
print(f"  E8 × E8 direkt szorzat: 16x16, det = {np.linalg.det(Cartan_E8xE8):.4f}")
print(f"  |W(E8)| × |W(E8)| = {weyl_E8 * weyl_E8:.4e}")
print(f"  dim(E8 × E8) = {2 * dim_E8}")
print(f"  E8 rang: 8, E8 × E8 rang: 16, E9 rang: 8 (affin: végtelen)")
print()
print(f"  A 33-as Pauli-modell 9 ön-korrekciója:")
print(f"    - OK01-03: |W(E8)|, θ_sor, dim E8 (az E8 struktúra adatai)")
print(f"    - OK04-06: d([[7,1,3]]), d([[15,1,3]]), d([[31,1,3]]) (Steane-kódok)")
print(f"    - OK07-08: α₂₁, α₃₁ (Majorana-CP)")
print(f"    - OK09: θ_QCD")
print()
print(f"  Az E9 affin kiterjesztés a 16. dimenzióban:")
print(f"    A 9 ön-korrekció az E9 9-dimenziós projektált altere.")
print(f"    A 33 = 24 + 9 a Standard Modell 24 fizikai paramétere +")
print(f"    az E9 9-dimenziós ön-korrekciója.")
print()

plt.show()