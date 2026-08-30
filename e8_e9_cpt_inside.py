import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from scipy.linalg import expm
from PIL import Image

rng = np.random.default_rng(7)

# ---------- E8^4 unitary base texture ----------
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
U0 = expm(1j * (e8 + 1j*im)); U = U0
for _ in range(3):
    U = np.kron(U, U0)
N = 128
k = U.shape[0] // N
mag = np.abs(U[::k, ::k][:N, :N])
ph  = np.angle(U[::k, ::k][:N, :N])

# ---------- 240 E8 roots ----------
roots = []
from itertools import combinations
for (i, j) in combinations(range(8), 2):
    for s1 in (+1,-1):
        for s2 in (+1,-1):
            v = np.zeros(8); v[i]=s1; v[j]=s2; roots.append(v)
for mask in range(1 << 8):
    if bin(mask).count("1") % 2 == 0:
        roots.append(np.array([(1 if (mask>>d)&1 else -1)*0.5 for d in range(8)]))
roots = np.array(roots)
P = rng.standard_normal((2, 8))
waves = roots @ P.T
charge = roots[:, 0] / np.max(np.abs(roots[:, 0]))

# ---------- sphere geometry ----------
lat = np.linspace(np.pi, 0, N); lon = np.linspace(-np.pi, np.pi, N)
Th, Ph = np.meshgrid(lat, lon, indexing="ij")
X = np.sin(Th)*np.cos(Ph); Y = np.sin(Th)*np.sin(Ph); Z = np.cos(Th)

# ---------- CPT-breaking E9 wave ----------
alpha_P = 0.6; omega = 2*np.pi/30.0; gamma = 1.2
mag_norm = (mag - mag.min())/(mag.max()-mag.min())
base_rgba = plt.get_cmap("magma")(mag_norm)   # (N,N,4)

frames = 24; imgs = []
for f in range(frames):
    t = f
    arg = waves[:,0:1]*Ph.ravel() + waves[:,1:2]*Th.ravel()
    aff = Ph.ravel()[None,:] - omega*t
    cphase = gamma*charge[:,None]
    pchir = 1.0 + alpha_P*np.sin(Ph.ravel()[None,:])
    W = (np.cos(arg + aff[None,:] + cphase[:,None]) * pchir[None,:]).mean(axis=0).reshape(N,N)
    Wn = (W - W.min())/(W.max()-W.min())
    env = 0.45 + 0.55*Wn
    rgba = base_rgba.copy()
    rgba[...,0:3] *= env[:,:,None]
    phase_tint = (np.sin(ph)*0.5+0.5)[:,:,None]
    rgba[...,1] = np.clip(rgba[...,1] + 0.15*phase_tint[:,:,0]*Wn, 0, 1)

    fig = plt.figure(figsize=(8,8)); fig.patch.set_facecolor("black")
    ax = fig.add_subplot(111, projection="3d")
    ax.set_facecolor("black")

    # --- inside view: make camera-facing hemisphere transparent ---
    # camera direction from azim/elev
    az = np.deg2rad(ax.azim); el = np.deg2rad(ax.elev)
    e = np.array([np.cos(el)*np.cos(az), np.cos(el)*np.sin(az), np.sin(el)])
    # per-face centroid direction (sphere radius 1)
    cz = Z[:-1,:-1]  # use top-left corner as cell proxy
    cx = X[:-1,:-1]; cy = Y[:-1,:-1]
    d = cx*e[0] + cy*e[1] + cz*e[2]      # >0 => faces camera (near, outside)
    alpha = np.where(d > 0.0, 0.0, 1.0)  # cut near shell -> reveal inside
    face_rgba = rgba[:-1,:-1].copy()
    face_rgba[...,3] = alpha

    ax.plot_surface(X, Y, Z, facecolors=face_rgba, rstride=1, cstride=1,
                    linewidth=0, antialiased=False)
    ax.set_box_aspect((1,1,1)); ax.set_axis_off()
    ax.set_title(f"E8$^4$ sphere interior $\\to$ E9 wave (CPT-broken)\n"
                 f"P$\\alpha$={alpha_P}  T$\\omega$={omega:.2f}  C$\\gamma$={gamma}   frame {f+1}/{frames}",
                 color="white", fontsize=11)
    fig.canvas.draw()
    buf = fig.canvas.buffer_rgba()
    img = Image.frombytes("RGBA", fig.canvas.get_width_height(), buf).convert("RGB")
    imgs.append(img); plt.close(fig)
    print("frame", f+1)

imgs[0].save("e8_e9_cpt_inside.gif", save_all=True, append_images=imgs[1:],
             duration=120, loop=0)
print("saved e8_e9_cpt_inside.gif")
