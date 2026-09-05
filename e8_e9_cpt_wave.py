# SZABALY0-IDRISBEN-LEHETETLEN — csak rajzol (matplotlib/scipy vizualizáció); a kutatási számítás Idrisben él vagy élni fog (AGENTS §3, hullám-3 nyilvántartás)
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from scipy.linalg import expm
from PIL import Image

rng = np.random.default_rng(7)

# ---------- E8^4 unitary base texture (strided to N x N) ----------
e8 = np.array([
    [ 2,-1, 0, 0, 0, 0, 0, 0],
    [-1, 2,-1, 0, 0, 0, 0, 0],
    [ 0,-1, 2,-1, 0, 0, 0, 0],
    [ 0, 0,-1, 2,-1, 0, 0, 0],
    [ 0, 0, 0,-1, 2,-1, 0, 0],
    [ 0, 0, 0, 0,-1, 2,-1,-1],
    [ 0, 0, 0, 0, 0,-1, 2, 0],
    [ 0, 0, 0, 0, 0,-1, 0, 2],
], dtype=float)
r = rng.standard_normal((8, 8)); im = r - r.T
U0 = expm(1j * (e8 + 1j*im))
U = U0
for _ in range(3):
    U = np.kron(U, U0)
N = 80
k = U.shape[0] // N
mag = np.abs(U[::k, ::k][:N, :N])
ph  = np.angle(U[::k, ::k][:N, :N])

# ---------- the 240 E8 roots ----------
roots = []
# type 1: two coords +-1, rest 0  (112)
from itertools import combinations
for (i, j) in combinations(range(8), 2):
    for s1 in (+1, -1):
        for s2 in (+1, -1):
            v = np.zeros(8); v[i] = s1; v[j] = s2; roots.append(v)
# type 2: all +-1/2 with even number of minus signs (128)
for mask in range(1 << 8):
    if bin(mask).count("1") % 2 == 0:
        roots.append(np.array([(1 if (mask >> d) & 1 else -1) * 0.5 for d in range(8)]))
roots = np.array(roots)   # (240, 8)
print("E8 roots:", roots.shape)

# fixed random projection R^8 -> R^2 : each root -> a 2D wave vector
P = rng.standard_normal((2, 8))
waves = roots @ P.T        # (240, 2)  wavevectors on the (phi,theta) plane
# charge label per root (C): first coordinate of root, normalized
charge = roots[:, 0] / np.max(np.abs(roots[:, 0]))

# ---------- sphere geometry ----------
lat = np.linspace(np.pi, 0, N)
lon = np.linspace(-np.pi, np.pi, N)
Th, Ph = np.meshgrid(lat, lon, indexing="ij")
X = np.sin(Th)*np.cos(Ph); Y = np.sin(Th)*np.sin(Ph); Z = np.cos(Th)

# ---------- CPT-breaking E9 wave ----------
# P (parity) break: chiral asymmetry between +phi and -phi
alpha_P = 0.6
# T (time) break: directional travel via -omega*t  (omega affine frequency)
omega = 2*np.pi/30.0
# C (charge) break: per-root phase offset gamma*charge
gamma = 1.2

# base colormap RGB
mag_norm = (mag - mag.min())/(mag.max()-mag.min())
base_rgba = plt.get_cmap("magma")(mag_norm)   # (N,N,4)

frames = 20
imgs = []
for f in range(frames):
    t = f
    # E8 crystalline standing part + affine E9 traveling part across all roots
    # field w(phi,theta,t) on the (N,N) grid  (vectorize over roots)
    # dot of each wavevector with (Ph, Th)
    arg = waves[:, 0:1] * Ph.ravel()[None, :] + waves[:, 1:2] * Th.ravel()[None, :]   # (240, N*N)
    # affine E9 traveling term: propagation around longitude (the "ninth" affine root)
    aff = Ph.ravel()[None, :] - omega * t
    # charge phase (C-break) + chirality (P-break)
    cphase = gamma * charge[:, None]
    pchir = 1.0 + alpha_P * np.sin(Ph.ravel()[None, :])   # breaks mirror phi->-phi
    contrib = np.cos(arg + aff + cphase) * pchir
    W = contrib.mean(axis=0).reshape(N, N)                # (N,N)
    Wn = (W - W.min())/(W.max()-W.min())                 # 0..1
    # modulate brightness / blend toward phase hue
    env = 0.45 + 0.55 * Wn
    rgba = base_rgba.copy()
    rgba[..., 0:3] *= env[:, :, None]
    # tint by phase where wave is strong
    phase_tint = (np.sin(ph) * 0.5 + 0.5)[:, :, None]
    rgba[..., 1] = np.clip(rgba[..., 1] + 0.15*phase_tint[:,:,0]*Wn, 0, 1)

    fig = plt.figure(figsize=(6, 6))
    ax = fig.add_subplot(111, projection="3d")
    ax.plot_surface(X, Y, Z, facecolors=rgba, rstride=1, cstride=1,
                    linewidth=0, antialiased=False)
    ax.set_box_aspect((1,1,1)); ax.set_axis_off()
    ax.set_title(f"E8$^4$ sphere $\\to$ E9 wave  (CPT-broken)\n"
                 f"P:$\\alpha$={alpha_P}  T:$\\omega$={omega:.2f}  C:$\\gamma$={gamma}   frame {f+1}/{frames}",
                 fontsize=11)
    fig.canvas.draw()
    buf = fig.canvas.buffer_rgba()
    img = Image.frombytes("RGBA", fig.canvas.get_width_height(), buf).convert("RGB")
    imgs.append(img)
    plt.close(fig)
    print("frame", f+1)

imgs[0].save("e8_e9_cpt_wave.gif", save_all=True, append_images=imgs[1:],
             duration=120, loop=0)
print("saved e8_e9_cpt_wave.gif")
