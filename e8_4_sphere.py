# SZABALY0-IDRISBEN-LEHETETLEN — csak rajzol (matplotlib/scipy vizualizáció); a kutatási számítás Idrisben él vagy élni fog (AGENTS §3, hullám-3 nyilvántartás)
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.colors import Normalize
from scipy.linalg import expm

rng = np.random.default_rng(42)

e8 = np.array([
    [ 2, -1,  0,  0,  0,  0,  0,  0],
    [-1,  2, -1,  0,  0,  0,  0,  0],
    [ 0, -1,  2, -1,  0,  0,  0,  0],
    [ 0,  0, -1,  2, -1,  0,  0,  0],
    [ 0,  0,  0, -1,  2, -1,  0,  0],
    [ 0,  0,  0,  0, -1,  2, -1, -1],
    [ 0,  0,  0,  0,  0, -1,  2,  0],
    [ 0,  0,  0, 0,  0, -1,  0,  2],
], dtype=float)

r = rng.standard_normal((8, 8))
im = r - r.T
H = e8 + 1j * im
U0 = expm(1j * H)
U = U0
for _ in range(3):
    U = np.kron(U, U0)

# Downsample to a square lat/long grid preserving block structure (strided)
N = 256
k = U.shape[0] // N
g = U[::k, ::k][:N, :N]           # N x N
mag = np.abs(g)
ph = np.angle(g)

# Build sphere coordinates (equirectangular: row->latitude, col->longitude)
lat = np.linspace(np.pi, 0, N)            # north -> south
lon = np.linspace(-np.pi, np.pi, N)
Theta, Phi = np.meshgrid(lat, lon, indexing="ij")
X = np.sin(Theta) * np.cos(Phi)
Y = np.sin(Theta) * np.sin(Phi)
Z = np.cos(Theta)

def textured_sphere(data, cmap, title):
    norm = Normalize(vmin=np.nanmin(data), vmax=np.nanmax(data))
    rgba = plt.get_cmap(cmap)(norm(data))
    fig = plt.figure(figsize=(8, 8))
    ax = fig.add_subplot(111, projection="3d")
    ax.plot_surface(X, Y, Z, facecolors=rgba, rstride=1, cstride=1,
                    linewidth=0, antialiased=False)
    ax.set_box_aspect((1, 1, 1))
    ax.set_axis_off()
    ax.set_title(title)
    m = plt.cm.ScalarMappable(cmap=cmap, norm=norm)
    m.set_array([])
    fig.colorbar(m, ax=ax, fraction=0.046, pad=0.04, shrink=0.6)
    return fig

fig1 = textured_sphere(mag, "magma", r"E8$^4$ unitary on a sphere — magnitude $|\!U\!|$")
fig1.savefig("e8_4_sphere_mag.png", dpi=100)

fig2 = textured_sphere(ph, "twilight", r"E8$^4$ unitary on a sphere — phase $\arg(U)$")
fig2.savefig("e8_4_sphere_phase.png", dpi=100)
print("saved e8_4_sphere_mag.png and e8_4_sphere_phase.png")
