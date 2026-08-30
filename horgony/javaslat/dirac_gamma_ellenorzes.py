# SZABALY0-IDRISBEN-LEHETETLEN(átmeneti) — az EXAKT bizonyítások DiracGammaMatricak.idr-ben
# (Integer-pontosan, Refl); a Zitterbewegung-kód ÁTÍRANDÓ Idris Double-be (Komplex.idr minta).
#!/usr/bin/env python3
# ═══════════════════════════════════════════════════════════════
# DIRAC GAMMA ELLENŐRZÉS — a DiracGammaMatricak.idr numerikus párja
# ═══════════════════════════════════════════════════════════════
# Az Idris-modul Refl-lel bizonyítja ugyanezeket Integer-aritmetikával;
# ez itt a független float-oldali mérés (Szabály 0: mindkettő).
# ═══════════════════════════════════════════════════════════════
import numpy as np

i2 = np.eye(2); z2 = np.zeros((2, 2))
sx = np.array([[0, 1], [1, 0]])
sy = np.array([[0, -1j], [1j, 0]])
sz = np.array([[1, 0], [0, -1]])

# HELYES Weyl-bázis (γ⁰ off-diagonális):
G0 = np.block([[z2, i2], [i2, z2]])
G1 = np.block([[z2, sx], [-sx, z2]])
G2 = np.block([[z2, sy], [-sy, z2]])
G3 = np.block([[z2, sz], [-sz, z2]])
G5 = 1j * G0 @ G1 @ G2 @ G3

# SZERVERI HIBÁS γ⁰ (kron(I₂,σₓ) — blokk-diagonális):
R0 = np.kron(np.eye(2), sx)

print("── Clifford-relációk (Weyl): a 6 antikommutátor null-e?")
for (nev, a, b) in [("01", G0, G1), ("02", G0, G2), ("03", G0, G3),
                    ("12", G1, G2), ("13", G1, G3), ("23", G2, G3)]:
    print(f"  {{γ{nev[0]},γ{nev[1]}}} = 0 :", np.allclose(a @ b + b @ a, 0))

print("── γ⁵ = iγ⁰γ¹γ²γ³:")
print("  γ⁵² = I                :", np.allclose(G5 @ G5, np.eye(4)))
print("  γ⁵ sajátértékek        :", sorted(set(np.round(np.linalg.eigvals(G5).real))),
      "(tiszta −1,−1,+1,+1 = 中文|magyar szektorok)")
print("  γ⁵ = diag(-1,-1,1,1)   :", np.allclose(G5, np.diag([-1, -1, 1, 1])))

print("── A szerveri bogár:")
print("  γ⁰(Weyl).mező20 = +1   :", G0[2, 0] == 1, "→ KEVERI ψ_L↔ψ_R (a fordítás él)")
print("  γ⁰(szerver).mező20 = 0 :", R0[2, 0] == 0, "→ SOHA nem keveri (törött nyelv)")
print("  γ⁰(szerver) blokk-diag.:", np.allclose(R0[:2, 2:], 0) and np.allclose(R0[2:, :2], 0))

print("── Zitterbewegung: ψ(t) = e^{-im·γ⁰·t}·ψ(0), tiszta 中文 kezdettel:")
m = 1.0
psi0 = np.array([1, 0, 0, 0], dtype=complex)
for t in [0.0, 0.4, np.pi / 4, np.pi / 2]:
    u_helyes = np.cos(m * t) * np.eye(4) - 1j * np.sin(m * t) * G0
    u_hibas = np.cos(m * t) * np.eye(4) - 1j * np.sin(m * t) * R0
    p_magyar_helyes = np.sum(np.abs((u_helyes @ psi0)[2:]) ** 2)
    p_magyar_hibas = np.sum(np.abs((u_hibas @ psi0)[2:]) ** 2)
    print(f"  t={t:.2f}: P(magyar) helyes={p_magyar_helyes:.4f}"
          f"  szerveri(hibás)={p_magyar_hibas:.4f}")
print("  → helyes: sin²(mt) oszcilláció (中文↔magyar jelentés-váltás);")
print("    hibás: örök 0 — a két nyelv soha nem találkozik.")
