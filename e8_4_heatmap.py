import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

# E8 Cartan matrix (Dynkin diagram: chain 1..7 with node 8 branching off node 6)
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

# E8^4 = 4-fold Kronecker product -> 8^4 = 4096 x 4096
m = e8
for _ in range(3):
    m = np.kron(m, e8)

print("matrix shape:", m.shape, "min:", m.min(), "max:", m.max(), "nnz:", np.count_nonzero(m))

fig, ax = plt.subplots(figsize=(10, 10))
im = ax.imshow(m, cmap="RdBu_r", interpolation="nearest")
ax.set_title(r"E8$^4$ — 4-fold Kronecker power of the E8 Cartan matrix (4096$\times$4096)")
ax.set_xlabel("basis index")
ax.set_ylabel("basis index")
fig.colorbar(im, ax=ax, fraction=0.046, pad=0.04, label="entry value")
fig.tight_layout()
out = "e8_4_heatmap.png"
fig.savefig(out, dpi=90)
print("saved", out)
