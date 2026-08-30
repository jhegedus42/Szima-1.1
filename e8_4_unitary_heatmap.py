import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from scipy.linalg import expm

rng = np.random.default_rng(42)

# E8 Cartan matrix (symmetric, real)
e8 = np.array([
    [ 2, -1,  0,  0,  0,  0,  0,  0],
    [-1,  2, -1,  0,  0,  0,  0,  0],
    [ 0, -1,  2, -1,  0,  0,  0,  0],
    [ 0,  0, -1,  2, -1,  0,  0,  0],
    [ 0,  0,  0, -1,  2, -1,  0,  0],
    [ 0,  0,  0,  0, -1,  2, -1, -1],
    [ 0,  0,  0,  0,  0, -1,  2,  0],
    [ 0,  0,  0,  0,  0, -1,  0,  2],
], dtype=float)

# Make it a complex Hermitian operator: real E8 part + random antisymmetric imaginary part
r = rng.standard_normal((8, 8))
im = r - r.T                       # antisymmetric -> 1j*im is skew-Hermitian
H = e8 + 1j * im                   # Hermitian

# exp(i*H) is unitary
U0 = expm(1j * H)

# verify unitarity of the block
err = np.max(np.abs(U0.conj().T @ U0 - np.eye(8)))
print("block unitarity error:", err)

# E8^4 = Kronecker power 4  (product of unitaries is unitary)
U = U0
for _ in range(3):
    U = np.kron(U, U0)
err4 = np.max(np.abs(U.conj().T @ U - np.eye(4096)))
print("E8^4 unitarity error:", err4, "shape", U.shape)

fig, axes = plt.subplots(1, 2, figsize=(18, 9))
im1 = axes[0].imshow(np.abs(U), cmap="magma", interpolation="nearest")
axes[0].set_title(r"E8$^4$ unitary — magnitude $|\!U\!|$  (4096$\times$4096)")
axes[0].set_xlabel("basis index"); axes[0].set_ylabel("basis index")
fig.colorbar(im1, ax=axes[0], fraction=0.046, pad=0.04)

im2 = axes[1].imshow(np.angle(U), cmap="twilight", interpolation="nearest")
axes[1].set_title(r"E8$^4$ unitary — phase $\arg(U)$")
axes[1].set_xlabel("basis index"); axes[1].set_ylabel("basis index")
fig.colorbar(im2, ax=axes[1], fraction=0.046, pad=0.04)

fig.suptitle("Complex unitary E8$^4$ (Kronecker power of a complex E8-derived block)")
fig.tight_layout()
out = "e8_4_unitary_heatmap.png"
fig.savefig(out, dpi=80)
print("saved", out)
