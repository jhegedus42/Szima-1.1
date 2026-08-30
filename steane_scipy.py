"""
Steane [[7,1,3]] — scipy matrix-exponential Hamiltonian dynamics -> 3D cut in half.
|psi(t)> = expm(-i H t) |psi(0)>
H = -sum_{i=1}^{6} S_i  (Stabilizer Hamiltonian)
Bloch vectors <sigma_i> drive the 3D geometry.
"""
import numpy as np
from scipy.linalg import expm
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
from matplotlib.animation import FuncAnimation

# ============================================================
# 1. Pauli matrices
# ============================================================
I2 = np.eye(2, dtype=complex)
X = np.array([[0, 1], [1, 0]], dtype=complex)
Z = np.array([[1, 0], [0, -1]], dtype=complex)
Y = np.array([[0, -1j], [1j, 0]], dtype=complex)

N = 7
DIM = 2 ** N

def tensor_pauli(op_list):
    """Tensor product of single-qubit Pauli operators."""
    result = op_list[0]
    for op in op_list[1:]:
        result = np.kron(result, op)
    return result

def pauli_string(str_list):
    """Build N-qubit operator from string like 'XZIIIII'."""
    ops = {'I': I2, 'X': X, 'Y': Y, 'Z': Z}
    return tensor_pauli([ops[c] for c in str_list])

# ============================================================
# 2. Steane stabilizers
# ============================================================
STAB_STR = [
    'XXXIIII', 'XXIIXXI', 'XIXIXIX',   # X-stabilizers
    'ZZZIIII', 'ZZIIZZI', 'ZIZIZIZ',   # Z-stabilizers
]

STAB = [pauli_string(s) for s in STAB_STR]

# Hamiltonian: H = -sum S_i
H = -sum(STAB)

print(f"H shape: {H.shape}")
print(f"H Hermitian: {np.allclose(H, H.conj().T)}")

# Eigenvalues
eigvals = np.linalg.eigvalsh(H)
print(f"H eigenvalues range: [{eigvals.min():.1f}, {eigvals.max():.1f}]")
unique_eig = np.unique(np.round(eigvals, 4))
print(f"Unique eigenvalues: {unique_eig}")

# ============================================================
# 3. Single-qubit observables (for Bloch vectors)
# ============================================================
def single_pauli(i, op):
    """N-qubit operator: op on qubit i, I elsewhere."""
    ops = [I2] * N
    ops[i] = op
    return tensor_pauli(ops)

X_ops = [single_pauli(i, X) for i in range(N)]
Y_ops = [single_pauli(i, Y) for i in range(N)]
Z_ops = [single_pauli(i, Z) for i in range(N)]

# ============================================================
# 4. Initial state: |1000000> = qubit 0 in |1>
# ============================================================
psi0 = np.zeros(DIM, dtype=complex)
psi0[1] = 1.0

H0_val = np.real(psi0.conj() @ H @ psi0)
print(f"<H>(0) = {H0_val:.4f}")

# ============================================================
# 5. Time evolution via scipy expm
# ============================================================
def evolve(psi, t):
    U = expm(-1j * H * t)
    return U @ psi

def bloch_vector(psi, i):
    """Return (⟨X_i⟩, ⟨Y_i⟩, ⟨Z_i⟩) for qubit i."""
    bx = np.real(psi.conj() @ X_ops[i] @ psi)
    by = np.real(psi.conj() @ Y_ops[i] @ psi)
    bz = np.real(psi.conj() @ Z_ops[i] @ psi)
    return np.array([bx, by, bz])

def stabilizer_values(psi):
    return [np.real(psi.conj() @ S @ psi) for S in STAB]

# ============================================================
# 6. Fano-plane geometry
# ============================================================
G = (1 + np.sqrt(5)) / 2
base = np.array([
    [1, 1, 1], [1, -1, -1], [-1, 1, -1], [-1, -1, 1],
    [0, G, -1/G], [G, -1/G, 0], [-1/G, 0, G],
])
base = base / np.linalg.norm(base, axis=1, keepdims=True) * 1.2

FANO = [
    (0,1),(0,2),(0,3),(0,4),(0,5),(0,6),
    (1,2),(1,3),(1,5),(1,6),
    (2,3),(2,4),(2,6),
    (3,4),(3,5),
    (4,5),(4,6),(5,6),
]

kubit_szinek = ['#58a6ff','#f0883e','#56d364','#e74c3c','#bc8cff','#f778ba','#79c0ff']

# Stabilizer qubit indices
STAB_IDX = []
for s in STAB_STR:
    idx = [i for i, c in enumerate(s) if c != 'I']
    STAB_IDX.append(idx)

# ============================================================
# 7. Precompute trajectory
# ============================================================
N_FRAMES = 200
T_MAX = 8.0
times = np.linspace(0, T_MAX, N_FRAMES)
dt = times[1] - times[0]

print("Precomputing trajectory (scipy expm)...")
bloch_traj = np.zeros((N_FRAMES, N, 3))
stab_traj = np.zeros((N_FRAMES, 6))
H_traj = np.zeros(N_FRAMES)

# Evolve step by step for efficiency
psi = psi0.copy()
for f in range(N_FRAMES):
    bv = np.array([bloch_vector(psi, i) for i in range(N)])
    sv = stabilizer_values(psi)
    bloch_traj[f] = bv
    stab_traj[f] = sv
    H_traj[f] = np.real(psi.conj() @ H @ psi)
    if f < N_FRAMES - 1:
        psi = evolve(psi, dt)

print(f"Done. <H> conservation: min={H_traj.min():.6f}, max={H_traj.max():.6f}, spread={H_traj.max()-H_traj.min():.2e}")

# ============================================================
# 8. 3D animation — cut in half
# ============================================================
fig = plt.figure(figsize=(14, 7), facecolor='#0d1117')

ax1 = fig.add_subplot(121, projection='3d', facecolor='#0d1117')
ax2 = fig.add_subplot(122, projection='3d', facecolor='#0d1117')

AMP = 0.5  # Bloch amplitude multiplier

def kvul(p, axis='z'):
    """Is point outside the cut half (z < 0)?"""
    idx = {'x':0, 'y':1, 'z':2}[axis]
    return p[idx] < -0.02

def setup_ax(ax, fele_vagas, title):
    ax.set_xlim(-2, 2)
    ax.set_ylim(-2, 2)
    ax.set_zlim(-2, 2)
    ax.set_xlabel('$T$ (ido)', color='#8b949e', fontsize=9)
    ax.set_ylabel('$L$ (ter)', color='#8b949e', fontsize=9)
    ax.set_zlabel('$iP$ (kepzelt)', color='#8b949e', fontsize=9)
    ax.set_title(title, color='#58a6ff', fontsize=11, pad=15)
    ax.xaxis.pane.set_facecolor('#161b22')
    ax.yaxis.pane.set_facecolor('#161b22')
    ax.zaxis.pane.set_facecolor('#161b22')
    ax.xaxis.pane.set_edgecolor('#30363d')
    ax.yaxis.pane.set_edgecolor('#30363d')
    ax.zaxis.pane.set_edgecolor('#30363d')
    ax.tick_params(colors='#8b949e', labelsize=7)

def draw_frame(ax, f, fele_vagas, vagas_tengely='z'):
    ax.cla()
    setup_ax(ax, fele_vagas,
             f"Steane $[[7,1,3]]$ — $|\\psi(t)\\rangle = e^{{-iHt}}|\\psi_0\\rangle$"
             + (f"  [vágva: {vagas_tengely}>0]" if fele_vagas else "  [teljes]"))

    bv = bloch_traj[f]
    sv = stab_traj[f]
    pos = base + bv * AMP

    # Kubitok
    for i in range(N):
        if fele_vagas and kvul(pos[i], vagas_tengely):
            continue
        ax.scatter(*pos[i], color=kubit_szinek[i], s=250, edgecolors='white',
                   linewidths=0.8, depthshade=True, zorder=5)
        ax.text(pos[i,0]+0.08, pos[i,1]+0.08, pos[i,2]+0.08,
                f'$\\tau_{{{i+1}}}$', color='#c9d1d9', fontsize=9, zorder=6)

    # Bloch vektor nyilak
    for i in range(N):
        if fele_vagas and kvul(pos[i], vagas_tengely):
            continue
        mag = np.linalg.norm(bv[i])
        if mag > 0.01:
            ax.quiver(pos[i,0], pos[i,1], pos[i,2],
                      bv[i,0]*AMP, bv[i,1]*AMP, bv[i,2]*AMP,
                      color=kubit_szinek[i], alpha=0.8, linewidth=2, arrow_length_ratio=0.15)

    # Stabilizator lapok
    for idx in range(6):
        kidx = STAB_IDX[idx]
        pts = pos[kidx]
        if fele_vagas:
            if any(kvul(p, vagas_tengely) for p in pts):
                continue
        szin = '#e74c3c' if idx < 3 else '#3498db'
        stilus = '-' if idx < 3 else '--'
        poly = Poly3DCollection([pts], alpha=0.05 + 0.15 * sv[idx]**2,
                                facecolor=szin, edgecolor=szin, linewidth=1.0)
        ax.add_collection3d(poly)

    # Fonalak
    for a, b in FANO:
        if fele_vagas and (kvul(pos[a], vagas_tengely) or kvul(pos[b], vagas_tengely)):
            continue
        corr = abs(np.dot(bv[a], bv[b]))
        ax.plot(*zip(pos[a], pos[b]), color='#6e7681',
                alpha=0.1 + 0.2 * corr, linewidth=0.8)

    # Vagasi sik
    if fele_vagas:
        s = np.linspace(-1.8, 1.8, 20)
        S1, S2 = np.meshgrid(s, s)
        ti = {'x':0,'y':1,'z':2}[vagas_tengely]
        if ti == 0:
            Xg, Yg, Zg = np.zeros_like(S1), S1, S2
        elif ti == 1:
            Xg, Yg, Zg = S1, np.zeros_like(S1), S2
        else:
            Xg, Yg, Zg = S1, S2, np.zeros_like(S1)
        ax.plot_surface(Xg, Yg, Zg, alpha=0.04, color='#2ecc71', edgecolor='none')

    # Energia szoveg
    ax.text2D(0.02, 0.97, f"t={times[f]:.2f}  $\\langle H\\rangle$={H_traj[f]:.4f}  H(0)={H0_val:.4f}",
              transform=ax.transAxes, color='#56d364', fontsize=9, verticalalignment='top')

def update(f):
    draw_frame(ax1, f, fele_vagas=False, vagas_tengely='z')
    draw_frame(ax2, f, fele_vagas=True, vagas_tengely='z')
    return []

anim = FuncAnimation(fig, update, frames=N_FRAMES, interval=80, blit=False, repeat=True)

# Also text
fig.text(0.5, 0.02,
         r"$H = -\sum_{i=1}^{6} S_i$  |  $U = e^{-iHt}$ (scipy expm)  |  "
         r"$\alpha \approx 7/(64\cdot15) \approx 1/137$  |  "
         r"Bal: teljes  |  Jobb: $z>0$ féle vágás",
         ha='center', fontsize=10, color='#8b949e')

plt.subplots_adjust(left=0.02, right=0.98, top=0.92, bottom=0.08)

# Save as MP4 if ffmpeg available, otherwise GIF
kimenet = '/Users/joco/opencode/steane_scipy'
anim.save(kimenet + '.gif', writer='pillow', fps=10, dpi=90,
          savefig_kwargs={'facecolor': '#0d1117'})
print(f"Saved: {kimenet}.gif")

# Also save first frame as PNG for preview
draw_frame(ax1, 0, False, 'z')
draw_frame(ax2, 0, True, 'z')
plt.savefig('/Users/joco/opencode/steane_scipy_frame0.png',
            dpi=120, facecolor='#0d1117', bbox_inches='tight')
print("Saved: steane_scipy_frame0.png")