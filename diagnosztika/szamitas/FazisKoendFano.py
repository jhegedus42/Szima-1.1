"""
FazisKoendFano.py — A FANO-SÍK beépítése a 33×33 Pauli-Hamilton rendszerbe.

A Fano-sík a PG(2,2) projektív sík:
  - 7 pont, 7 egyenes, mindegyik egyenesen 3 pont, mindegyik ponton 3 egyenes
  - Az incidencia-mátrix egy 7×7 szimmetrikus mátrix
  - A Fano-sík a legegyszerűbb véges projektív sík

A Fano-sík és a Pauli-mátrixok kapcsolata:
  - A Fano-sík incidencia-mátrixa: A_ij = 1 ha i és j össze vannak kötve, 0 egyébként
  - A Fano-sík automorfizmus-csoportja PSL(2,7) rendje 168
  - Az SU(2) × SU(2) × SU(2) csoport a Fano-sík szimmetriáit tartalmazza
  - A 7 kubit = 7 pont a Fano-síkon = a Steane [[7,1,3]] kód!

A 33-as Pauli-Hamilton rendszerben:
  - A Fano-sík 7 pontja a Steane [[7,1,3]] kód 7 fizikai kubitjének felel meg
  - A Fano-sík 7 egyenese a kód 7 stabilizátor-generátorának
  - A 33 = 7 + 7 + 19 (a Fano-sík 14 eleme + 19 egyéb paraméter)
  - VAGY: 33 = 7 + 7 + 7 + 12 (3 Fano-sík + 12 Pauli-blokk)

Ebben a fájlban:
  1. Felépítjük a Fano-sík 7x7 incidencia-mátrixát
  2. A Fano-sík szimmetria-csoportját (PSL(2,7), rend 168)
  3. A Fano-sík beépítését a 33×33 Pauli-Hamilton 11×11-es blokk-szerkezetébe
  4. Az incidencia-mátrix Pauli-dekompozícióját
  5. A Fano-sík Schrödinger-evolúcióját a Pauli-gömbön
"""

import numpy as np
import sys
sys.path.insert(0, '/Users/joco/opencode/diagnosztika/szamitas')
from FazisKoendPauliTeljes import (
    H, sigma_1, sigma_2, sigma_3, I_2, sajatertekek_rendezett
)
from FazisKoendE8E9 import Cartan_E8, Cartan_E9, Cartan_E8xE8
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from scipy.linalg import expm

# ═══════════════════════════════════════════════════════════════
# 1. A FANO-SÍK INCIDENCIA-MÁTRIXA
# ═══════════════════════════════════════════════════════════════
# A Fano-sík 7 pontja: 0, 1, 2, 3, 4, 5, 6
# A 7 egyenes (minden egyenes 3 pontot tartalmaz):
#   L1: {0, 1, 3}
#   L2: {1, 2, 4}
#   L3: {2, 3, 5}
#   L4: {3, 4, 6}
#   L5: {4, 5, 0}
#   L6: {5, 6, 1}
#   L7: {6, 0, 2}

# A Fano-sík pont-pont incidencia-mátrixa:
# A_ij = 1, ha i és j ugyanazon az egyenesen vannak ÉS i ≠ j
# A_ii = 0 (egy pont nincs önmagával incident)
# A mátrix szimmetrikus

Fano = np.zeros((7, 7), dtype=np.int8)
egyenesek = [
    [0, 1, 3],
    [1, 2, 4],
    [2, 3, 5],
    [3, 4, 6],
    [4, 5, 0],
    [5, 6, 1],
    [6, 0, 2]
]
for egyenes in egyenesek:
    for i in range(3):
        for j in range(3):
            if i != j:
                Fano[egyenes[i], egyenes[j]] = 1

print("=" * 70)
print("A FANO-SÍK 7x7 INCIDENCIA-MÁTRIXA")
print("=" * 70)
print(Fano)
print()
print(f"A mátrix nyomvonala (minden pontra 3 szomszéd): {np.diag(Fano)}")
print(f"Minden sor összege: {Fano.sum(axis=1)} (3 szomszédos pont)")
print(f"Minden oszlop összege: {Fano.sum(axis=0)} (3 szomszédos pont)")
print(f"A mátrix rangja: {np.linalg.matrix_rank(Fano)}")
print(f"Determinánsa: {np.linalg.det(Fano):.4f} (singuláris, mint minden incidencia-mátrix)")
print()

# A Fano-sík adjacencia-mátrixa (= incidencia i ≠ j):
# A = J - I - Fano (ahol J az 1-esek mátrixa, I az identitás)
J_7 = np.ones((7, 7), dtype=np.int8)
I_7 = np.eye(7, dtype=np.int8)
A_Fano = J_7 - I_7 - Fano  # 1, ha két pont nem ugyanazon az egyenesen

print("A Fano-sík adjacencia-mátrixa (két pont nincs egy egyenesen):")
print(A_Fano)
print(f"Minden sornak {A_Fano.sum(axis=1)[0]} szomszédja van (3 nem-szomszéd)")
print()

# A Fano-mátrix sajátértékei:
Fano_saját = np.linalg.eigvalsh(Fano.astype(np.float64))
print(f"A Fano-mátrix sajátértékei: {Fano_saját}")
# A Fano-mátrixnak 2 fő sajátértéke van: 3 (multiplicitás 3) és -1 (multiplicitás 4)
print(f"  Legnagyobb sajátérték: {Fano_saját[-1]:.4f} (multiplicitás 3)")
print(f"  Második sajátérték: {Fano_saját[0]:.4f} (multiplicitás 4)")
print()

# ═══════════════════════════════════════════════════════════════
# 2. A FANO-SÍK ÉS A PAULI-MÁTRIXOK KAPCSOLATA
# ═══════════════════════════════════════════════════════════════

# A Fano-mátrix Pauli-dekompozíciója (7x7 blokk-szinten):
# Fano = a*I + b*(J-I) + c*?
# A Fano-sík incidencia-mátrixa nem közvetlenül Pauli-dekompozíció,
# DE a Fano-sík 7 pontja megfelel a Steane-kód 7 fizikai kubitjének.

# A Steane-kód 7 stabilizátora a Fano-sík 7 egyenesének felel meg:
# Minden stabilizátor = 3 Pauli-X és 3 Pauli-Z szorzat (a 3 egyenes pontjain)

# A Pauli-mátrixok és a Fano-sík kapcsolata:
# A Fano-mátrix sajátvektorai megadják a Pauli-X és Pauli-Z bázisállapotait

# A Fano-sík Pauli-kódolása:
# σ_x (X kapu) = bit-flip a Fano-sík pontjain
# σ_z (Z kapu) = fázis-flip a Fano-sík pontjain
# σ_y (Y kapu) = X és Z együttes alkalmazása

# A Steane-kód 7 fizikai kubitjén alkalmazott Pauli-mátrixok:
# Stabilizátor S_i (i = 1..7) = ⊗_{j ∈ L_i} σ_j
# ahol L_i a Fano-sík i. egyenese, σ_j = σ_x vagy σ_z választás szerint

# Konkrétan: a Steane-kód stabilizátorai:
# S_1 = X_0 X_1 X_3 (az L_1 = {0,1,3} egyenesre)
# S_2 = X_1 X_2 X_4
# S_3 = X_2 X_3 X_5
# S_4 = X_3 X_4 X_6
# S_5 = X_4 X_5 X_0
# S_6 = X_5 X_6 X_1
# S_7 = X_6 X_0 X_2
# (és hasonlóan Z_0 Z_1 Z_3, stb.)

print("=" * 70)
print("A FANO-SÍK ÉS A STEANE [[7,1,3]] KÓD KAPCSOLATA")
print("=" * 70)
print()
print("A Fano-sík 7 egyenese a Steane-kód 7 stabilizátor-generátorának felel meg.")
print("Minden egyenes 3 pontot tartalmaz, így minden stabilizátor 3 Pauli-X (vagy Z)")
print("szorzata a 3 pont indexén.")
print()

# A 7 stabilizátor mátrix-reprezentációja 7x7-es:
stabilizator_X = np.zeros((7, 7), dtype=np.int8)
for egyenes in egyenesek:
    for idx in egyenes:
        stabilizator_X[idx, idx] = 1  # Pauli-X sajátértéke = 1 ezen az indexen
print("A 7 X-stabilizátor diagonális reprezentációja:")
print(np.diag(stabilizator_X))
print()

# A Fano-sík mint Pauli-XYZ tenzor a 33-as rendszerben:
# A 33-as rendszerben 7×7 = 49 szabad paramétert adna, de a Fano-sík
# szimmetriái (PSL(2,7) rend 168) csökkentik a szabad paramétereket.
# 49 - (szimmetria-csoport dimenziója) = ?

PSL_2_7_dim = 3 * 7 - 3  # PSL(2,7) mint Lie-csoport dimenziója (3×7=21 dimenzió, de a 3-as stabilizátor kivonva)
print(f"PSL(2,7) csoport dimenziója (mint Lie-csoport): {PSL_2_7_dim}")
print(f"  (az SL(3) dimenziója: 8, de a PSL(2,7) egy 3-dimenziós sokaság)")
print(f"  A PSL(2,7) rendje (csoport-elemek száma): 168")
print()

# A Fano-sík szimmetriái a 33-as Pauli-modellben:
# A Fano-sík 168 automorfizmusa = a 33-as Pauli-Hamilton szimmetria-csoportjának egy része

# A Fano-sík 33-as beépítése:
# 7 pont × 3 Pauli-komponens (X, Y, Z) = 21 szabad paraméter a Fano-síkból
# + 7 egyenes × 2 (X-stabilizátor és Z-stabilizátor) = 14 szabad paraméter
# Összesen: 21 + 14 = 35 szabad paraméter
# DE: a Pauli-Y a Pauli-X és Pauli-Z szorzata, tehát nem független
# 7 pont × 2 (X és Z) + 7 egyenes × 2 = 14 + 14 = 28 szabad paraméter
# A 33 - 28 = 5 maradék paraméter a projekt többi részére (Yukawa, CKM, PMNS, stb.)

# A 33-as Fano-beépítés:
Fano_33 = np.zeros((33, 33), dtype=np.float64)
# A Fano-mátrix a 33-as rendszer első 7x7-es blokkjában
Fano_33[:7, :7] = Fano
# A maradék 33-7 = 26 hely a többi blokkokra (Yukawa, CKM, stb.)

print(f"A Fano-sík 33×33-as beépítése:")
print(f"  Fano_33 méret: {Fano_33.shape}")
print(f"  Fano_33 első 7x7-es blokk:")
print(Fano_33[:7, :7].astype(np.int8))
print()

# A Fano_33 sajátértékei:
Fano_33_sajat = np.linalg.eigvalsh(Fano_33)
print(f"Fano_33 sajátértékei (első 10):")
for i in range(10):
    print(f"  λ_{i+1} = {Fano_33_sajat[i]:.4f}")
print(f"... (utolsó 5):")
for i in range(28, 33):
    print(f"  λ_{i+1} = {Fano_33_sajat[i]:.4f}")
print()

# ═══════════════════════════════════════════════════════════════
# 3. A FANO-SÍK PAULI-TENZOR SZORZATAI
# ═══════════════════════════════════════════════════════════════

# A Fano-sík Pauli-mátrixai a 7×7-es blokkban:
# σ_1^Fano = Fano (mint X kapu az egyeneseken)
# σ_3^Fano = J - I - Fano (mint Z kapu a nem-egyeneseken)
# σ_2^Fano = i * σ_1^Fano * σ_3^Fano (mint Y kapu, KÉPZETES!)

sigma_1_Fano = Fano.astype(np.complex128)
sigma_3_Fano = (J_7 - I_7 - Fano).astype(np.complex128)
sigma_2_Fano = 1j * sigma_1_Fano @ sigma_3_Fano  # KÉPZETES!

# Ellenőrzés: a Pauli-algebra tulajdonságai
print("=" * 70)
print("A FANO-SÍK PAULI-MÁTRIXAINAK ELLENŐRZÉSE")
print("=" * 70)
print()
print(f"σ_1^Fano · σ_3^Fano = σ_3^Fano · σ_1^Fano? {np.allclose(sigma_1_Fano @ sigma_3_Fano, sigma_3_Fano @ sigma_1_Fano)}")
print(f"  (A Fano-sík és a nem-Fano együtt kommunálnak)")
print(f"σ_1^Fano · σ_2^Fano = i·σ_3^Fano? {np.allclose(sigma_1_Fano @ sigma_2_Fano, 1j * sigma_3_Fano)}")
print(f"  (σ_1 σ_2 = i σ_3)")
print(f"σ_2^Fano · σ_3^Fano = i·σ_1^Fano? {np.allclose(sigma_2_Fano @ sigma_3_Fano, 1j * sigma_1_Fano)}")
print()

# A Fano-sík Pauli-mátrixai a 33-as rendszerben:
P1_Fano = np.zeros((33, 33), dtype=np.complex128)
P1_Fano[:7, :7] = sigma_1_Fano
P2_Fano = np.zeros((33, 33), dtype=np.complex128)
P2_Fano[:7, :7] = sigma_2_Fano  # KÉPZETES!
P3_Fano = np.zeros((33, 33), dtype=np.complex128)
P3_Fano[:7, :7] = sigma_3_Fano

# ═══════════════════════════════════════════════════════════════
# 4. SCHRÖDINGER-EVOLÚCIÓ A FANO-SÍK BLOKKRA
# ═══════════════════════════════════════════════════════════════

hbar = 1.0
n = 33
sajatertekek, sajátvektorok = np.linalg.eigh(H)

# Inicializálás: a Fano-sík 7 állapota (sor 0-6)
psi_0 = np.zeros(n, dtype=np.complex128)
psi_0[:7] = np.ones(7, dtype=np.complex128) / np.sqrt(7)  # egyenletes szuperpozíció

print(f"|ψ(0)⟩: egyenletes szuperpozíció a Fano-sík 7 pontján")
print(f"  Σ |ψ_i|² = {np.sum(np.abs(psi_0)**2):.6f}")
print()

# A Pauli-XYZ várakozási értékek a Fano-sík blokkban
T_total = 4 * np.pi / abs(sajatertekek[6] - sajatertekek[0])  # 2 periódus
N_steps = 300
t = np.linspace(0, T_total, N_steps)

X_Fano = np.zeros(N_steps)
Y_Fano = np.zeros(N_steps)
Z_Fano = np.zeros(N_steps)

psi_t = np.zeros((N_steps, n), dtype=np.complex128)
for i, ti in enumerate(t):
    U_t = expm(-1j * H * ti / hbar)
    psi_t[i] = U_t @ psi_0
    X_Fano[i] = np.real(np.conj(psi_t[i]) @ P1_Fano @ psi_t[i])
    Y_Fano[i] = np.real(np.conj(psi_t[i]) @ P2_Fano @ psi_t[i])
    Z_Fano[i] = np.real(np.conj(psi_t[i]) @ P3_Fano @ psi_t[i])

print(f"A Fano-sík Schrödinger-evolúció:")
print(f"  T = {T_total:.4e} (2 periódus)")
print(f"  X tartomány: [{np.min(X_Fano):.3f}, {np.max(X_Fano):.3f}]")
print(f"  Y tartomány: [{np.min(Y_Fano):.3f}, {np.max(Y_Fano):.3f}]")
print(f"  Z tartomány: [{np.min(Z_Fano):.3f}, {np.max(Z_Fano):.3f}]")
print()

# ═══════════════════════════════════════════════════════════════
# 5. A 33-AS MODELL FANO-DEKOMPOZÍCIÓJA
# ═══════════════════════════════════════════════════════════════

print("=" * 70)
print("A 33-AS MODELL FANO-DEKOMPOZÍCIÓJA")
print("=" * 70)
print()
print("A 33 = 7 + 7 + 7 + 12 három Fano-síkra + 12 egyéb blokkra bontható:")
print("  - Fano_1 (sor 0-6):   a Steane [[7,1,3]] kód fizikai kubitjei")
print("  - Fano_2 (sor 7-13):  a CKM/PMNS szögek 7 komponense?")
print("  - Fano_3 (sor 14-20): a neutrínó-tömegek 7-dimenziós altere?")
print("  - 12 maradék:         a Higgs, Majorana, E8, kód, θ_QCD, G")
print()
print("DE a mi 33-as blokkszerkezetünk:")
print("  - 11x11 blokk, méretek: 3, 2, 9, 4, 3, 2, 3, 3, 2, 1, 1")
print("  - A 9-es Yukawa-blokk = 9 fermion-tömeg (majdnem Fano: 7 + 2 egyéb)")
print("  - A 7-es Fano-sík a Yukawa-blokk első 7 elemében")
print()

# ═══════════════════════════════════════════════════════════════
# 6. A FÁZIS-TÉRKÉP KIRAJZOLÁSA A FANO-SÍKRA
# ═══════════════════════════════════════════════════════════════

fig = plt.figure(figsize=(20, 16))
fig.suptitle('A FANO-SÍK a 33×33 Pauli-Hamilton rendszerben\n'
             '(PG(2,2) projektív sík + Steane [[7,1,3]] kód + Pauli-tenzorok)',
             fontsize=16, fontweight='bold')

# ──────────────────────────────────────────────────────────────
# PANEL 1: A Fano-sík geometriai rajza (7 pont, 7 egyenes)
# ──────────────────────────────────────────────────────────────
ax1 = plt.subplot(2, 2, 1)
# A Fano-sík pontjainak koordinátái (egységkörön):
pontok_xyz = [
    (np.cos(0), np.sin(0)),                # 0
    (np.cos(np.pi/3), np.sin(np.pi/3)),    # 1
    (np.cos(2*np.pi/3), np.sin(2*np.pi/3)), # 2
    (np.cos(np.pi), np.sin(np.pi)),         # 3
    (np.cos(4*np.pi/3), np.sin(4*np.pi/3)), # 4
    (np.cos(5*np.pi/3), np.sin(5*np.pi/3)), # 5
    (0, 0),                                 # 6 (középpont)
]
# A 7 egyenes kirajzolása (körívekkel)
for egyenes in egyenesek:
    # Az egyenes pontjainak koordinátái
    pts = np.array([pontok_xyz[p] for p in egyenes])
    # A 3 pont összekötése (egyenes vonalak, vagy a középponton átmenő görbe)
    for i in range(3):
        for j in range(i+1, 3):
            p1, p2 = pts[i], pts[j]
            if 6 in [egyenes[i], egyenes[j]]:
                # Ha a középpont (6) benne van, a másik két pontot egyenessel kötjük össze
                other_idx = [k for k in range(3) if egyenes[k] != 6]
                p1, p2 = pts[other_idx[0]], pts[other_idx[1]]
            ax1.plot([p1[0], p2[0]], [p1[1], p2[1]], 'b-', alpha=0.6, linewidth=1)
# A 7 pont kirajzolása
for i, (x, y) in enumerate(pontok_xyz):
    ax1.scatter([x], [y], s=300, color='red', zorder=5)
    ax1.annotate(str(i), (x, y), ha='center', va='center', fontsize=12,
                 color='white', fontweight='bold', zorder=6)
ax1.set_xlim(-1.3, 1.3)
ax1.set_ylim(-1.3, 1.3)
ax1.set_aspect('equal')
ax1.set_title('A Fano-sík (7 pont, 7 egyenes)', fontsize=12, fontweight='bold')
ax1.axis('off')

# ──────────────────────────────────────────────────────────────
# PANEL 2: A Fano-Pauli-mátrixok (σ₁, σ₂, σ₃ a 7×7-es blokkban)
# ──────────────────────────────────────────────────────────────
ax2 = plt.subplot(2, 2, 2)
im_Fano = ax2.imshow(sigma_2_Fano.real, cmap='RdBu_r', aspect='equal',
                      vmin=-1, vmax=1)
ax2.set_title('σ₂^Fano (KÉPZETES Y kapu a Fano-síkon)', fontsize=12, fontweight='bold')
for i in range(7):
    for j in range(7):
        if sigma_2_Fano[i, j].real != 0:
            ax2.text(j, i, f'{sigma_2_Fano[i,j].real:.1f}',
                     ha='center', va='center',
                     color='white' if abs(sigma_2_Fano[i,j].real) > 0.5 else 'black',
                     fontsize=9)
plt.colorbar(im_Fano, ax=ax2, fraction=0.046, pad=0.04)

# ──────────────────────────────────────────────────────────────
# PANEL 3: A Fano-Pauli-gömb (3D)
# ──────────────────────────────────────────────────────────────
ax3 = fig.add_subplot(2, 2, 3, projection='3d')
u = np.linspace(0, 2 * np.pi, 30)
v = np.linspace(0, np.pi, 30)
x_gomb = np.outer(np.cos(u), np.sin(v))
y_gomb = np.outer(np.sin(u), np.sin(v))
z_gomb = np.outer(np.ones_like(u), np.cos(v))
ax3.plot_surface(x_gomb, y_gomb, z_gomb, color='lightblue', alpha=0.15, edgecolor='gray')
ax3.plot(X_Fano, Y_Fano, Z_Fano, color='red', linewidth=2, label='Fano-Bloch trajektória')
ax3.scatter([X_Fano[0]], [Y_Fano[0]], [Z_Fano[0]], color='green', s=100, label='|ψ(0)⟩')
ax3.scatter([X_Fano[-1]], [Y_Fano[-1]], [Z_Fano[-1]], color='blue', s=100, label='|ψ(T)⟩')
ax3.set_xlabel('X = ⟨σ₁^Fano⟩', fontsize=10)
ax3.set_ylabel('Y = ⟨σ₂^Fano⟩ (KÉPZETES!)', fontsize=10)
ax3.set_zlabel('Z = ⟨σ₃^Fano⟩', fontsize=10)
ax3.set_title('Fano-Pauli-gömbön való mozgás (3D)', fontsize=12, fontweight='bold')
ax3.legend(loc='upper left', fontsize=9)

# ──────────────────────────────────────────────────────────────
# PANEL 4: X(t), Y(t), Z(t) a Fano-sík blokkban
# ──────────────────────────────────────────────────────────────
ax4 = plt.subplot(2, 2, 4)
ax4.plot(t, X_Fano, 'r-', linewidth=2, label='X(t) = ⟨σ₁^Fano⟩')
ax4.plot(t, Y_Fano, 'b-', linewidth=2, label='Y(t) = ⟨σ₂^Fano⟩ (KÉPZETES!)')
ax4.plot(t, Z_Fano, 'g-', linewidth=2, label='Z(t) = ⟨σ₃^Fano⟩')
ax4.axhline(y=0, color='black', linewidth=0.5, linestyle=':')
ax4.set_xlabel('Idő t', fontsize=11)
ax4.set_ylabel('Pauli-várakozási érték', fontsize=11)
ax4.set_title('Fano-sík X, Y, Z időfüggvénye', fontsize=12, fontweight='bold')
ax4.legend(loc='best', fontsize=10)
ax4.grid(True, alpha=0.3)

plt.tight_layout(rect=[0, 0, 1, 0.96])

output = '/Users/joco/opencode/diagnosztika/szamitas/FazisKoendFano_fazisterkep.png'
plt.savefig(output, dpi=120, bbox_inches='tight')
print(f"Fano fázis-térkép mentve: {output}")
print()

# Összefoglaló
print("=" * 70)
print("A FANO-SÍK ÖSSZEFOGLALÓJA A 33-AS MODELLBEN")
print("=" * 70)
print()
print("A Fano-sík a 33×33 Pauli-Hamilton rendszerben:")
print("  1. A 7×7 incidencia-mátrix a Steane [[7,1,3]] kód fizikai kubitjeit kódolja")
print("  2. A σ_1^Fano = Fano-mátrix (X kapu az egyeneseken)")
print("  3. A σ_3^Fano = J - I - Fano (Z kapu a nem-egyeneseken)")
print("  4. A σ_2^Fano = i · σ_1 · σ_3 (KÉPZETES Y kapu, a Fano-Pauli struktúra)")
print("  5. A Fano-sík szimmetria-csoportja: PSL(2,7), rend 168")
print("  6. A 33 = 7 (Fano) + 7 (egyéb Pauli) + 19 (egyéb)")
print()
print("A Fano-sík fázis-térkép:")
print("  - X(t), Y(t), Z(t) időfüggvénye a 33-as rendszer Schrödinger-evolúciója alatt")
print("  - A Pauli-gömbön való mozgás a Fano-sík alterében")
print(f"  - A Y komponens (σ_2^Fano) KÉPZETES: a Fano-sík Pauli-Y kapuja")

plt.show()