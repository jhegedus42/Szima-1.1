# SZABALY0-IDRISBEN-LEHETETLEN — csak rajzol (matplotlib/scipy vizualizáció); a kutatási számítás Idrisben él vagy élni fog (AGENTS §3, hullám-3 nyilvántartás)
"""
Steane [[7,1,3]] kod — 3D vizualizacio, fele vagva.
A 7 kubit stabilizator-struktura + energia-informacio csere ciklus.
"""
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from mpl_toolkits.mplot3d import Axes3D  # noqa
from mpl_toolkits.mplot3d.art3d import Poly3DCollection

# --- Steane kod adatok ---
KUBIT_SZAM = 7
STABILIZATOR_SZAM = 6
SINDROM_SZAM = 64
HIBA_IGE_SZAM = 279

# Stabilizator-pauli-szovegek (X-es es Z-s csoport)
STABILIZATOROK_X = [
    [1, 1, 1, 1, 0, 0, 0],  # S1 = X1X2X3X4
    [1, 1, 0, 0, 1, 1, 0],  # S2 = X1X2X5X6
    [1, 0, 1, 0, 1, 0, 1],  # S3 = X1X3X5X7
]
STABILIZATOROK_Z = [
    [1, 1, 1, 1, 0, 0, 0],  # S4 = Z1Z2Z3Z4
    [1, 1, 0, 0, 1, 1, 0],  # S5 = Z1Z2Z5Z6
    [1, 0, 1, 0, 1, 0, 1],  # S6 = Z1Z3Z5Z7
]

# Hamiltonian sajatertekei: -6,-4,-2,0,+2,+4,+6
ENERGIA_SZINTEK = np.array([-6, -4, -2, 0, 2, 4, 6])

# --- Geometria: 7 kubit elhelyezese egy E8-gyoker-rendszer tipusu halojan ---
# Fano-sik szerkezet (Steane kod = qubitek a Fano-sik pontjain)
# 7 pont egy "kocka forgatott hatvanyakent" elhelyezve
GOLDEN = (1 + np.sqrt(5)) / 2
kubit_poziciok = np.array([
    [1, 1, 1],
    [1, -1, -1],
    [-1, 1, -1],
    [-1, -1, 1],
    [0, GOLDEN, -1/GOLDEN],
    [GOLDEN, -1/GOLDEN, 0],
    [-1/GOLDEN, 0, GOLDEN],
])
# Normalizalas a kocka sugarara
kubit_poziciok = kubit_poziciok / np.linalg.norm(kubit_poziciok, axis=1, keepdims=True) * 1.0


def stabilizator_suly(stab, poz):
    """Stabilizator atlagos pozicioja (a kubitek ahol 1-es szerepel)."""
    indexek = [i for i, v in enumerate(stab) if v == 1]
    return poz[indexek].mean(axis=0)


def build_scene(ax, fele_vagas=True, vagas_sik="z"):
    """Epitsd fel a 3D jelenetet: kubitek, stabilizatorok, energia-palyak."""
    ax.cla()

    # --- Kubitok (7 csomopont) ---
    szinek = plt.cm.viridis(np.linspace(0.1, 0.9, KUBIT_SZAM))
    for i, (p, szin) in enumerate(zip(kubit_poziciok, szinek)):
        if fele_vagas and _kivul_vagas(p, vagas_sik):
            continue
        ax.scatter(*p, color=szin, s=320, edgecolors="black", linewidths=1.5,
                   depthshade=True, zorder=5)
        ax.text(*p + 0.08, f"$\\tau_{{{i+1}}}$", fontsize=11, zorder=6)

    # --- Stabilizatorok (3 X + 3 Z) --- osszekoto lapok/elek
    stab_poz_x = [stabilizator_suly(s, kubit_poziciok) for s in STABILIZATOROK_X]
    stab_poz_z = [stabilizator_suly(s, kubit_poziciok) for s in STABILIZATOROK_Z]

    def rajzol_stabilizator(stab, szin, stilus, alpha=0.25):
        indexek = [i for i, v in enumerate(stab) if v == 1]
        pontok = kubit_poziciok[indexek]
        # Negyszog/haromszog a 4 kubit kozott
        if fele_vagas:
            pontok = np.array([p for p in pontok if not _kivul_vagas(p, vagas_sik)])
            if len(pontok) < 3:
                return
        poly = Poly3DCollection([pontok], alpha=alpha, facecolor=szin,
                                edgecolor=szin, linewidth=1.5, linestyle=stilus)
        ax.add_collection3d(poly)

    for s in STABILIZATOROK_X:
        rajzol_stabilizator(s, "#e74c3c", "-", alpha=0.18)
    for s in STABILIZATOROK_Z:
        rajzol_stabilizator(s, "#3498db", "--", alpha=0.18)

    # --- Energia-informacio csere ciklus: stacionalus pontok az energiaszintokon ---
    # A 7 energiaszintet 7 kavitathato korongkent abrazoljuk a kubitok korul
    theta = np.linspace(0, 2 * np.pi, 60)
    for i, (p, E) in enumerate(zip(kubit_poziciok, ENERGIA_SZINTEK)):
        if fele_vagas and _kivul_vagas(p, vagas_sik):
            continue
        sugar = 0.15 + 0.04 * (E + 6) / 12.0  # energiaszint -> sugar
        szin = plt.cm.coolwarm((E + 6) / 12.0)
        x_kor = p[0] + sugar * np.cos(theta)
        y_kor = p[1] + sugar * np.sin(theta)
        z_kor = np.full_like(theta, p[2])
        ax.plot(x_kor, y_kor, z_kor, color=szin, alpha=0.6, linewidth=1.2)

    # --- Kozoos koherencia-fonalak: kubit-kubit kapcsolatok (Fano-sik egyenesek) ---
    fano_vonalak = [
        (0, 1), (0, 2), (0, 3), (0, 4), (0, 5), (0, 6),
        (1, 2), (1, 3), (1, 5), (1, 6),
        (2, 3), (2, 4), (2, 6),
        (3, 4), (3, 5),
        (4, 5), (4, 6),
        (5, 6),
    ]
    for a, b in fano_vonalak:
        pa, pb = kubit_poziciok[a], kubit_poziciok[b]
        if fele_vagas and (_kivul_vagas(pa, vagas_sik) or _kivul_vagas(pb, vagas_sik)):
            continue
        ax.plot(*zip(pa, pb), color="gray", alpha=0.3, linewidth=0.8)

    # --- Vagasi sik (ha fele van vagva) ---
    if fele_vagas:
        _rajzol_vagasi_sik(ax, vagas_sik)

    # --- Tengelyek es cimkek ---
    ax.set_xlim(-1.6, 1.6)
    ax.set_ylim(-1.6, 1.6)
    ax.set_zlim(-1.6, 1.6)
    ax.set_xlabel("$T$ (ido)", fontsize=10)
    ax.set_ylabel("$L$ (ter)", fontsize=10)
    ax.set_zlabel("$iP$ (kepzelt paritas)", fontsize=10)
    ax.set_title(
        f"Steane $[[7,1,3]]$ — 7 kubit, 6 stabilizator, 64 sindrom, 279 hiba-ige\n"
        f"Hamiltonian $H = -\\sum_{{i=1}}^{{6}} S_i$  |  $E \\in \\{{-6,-4,-2,0,+2,+4,+6\\}}$"
        f"{'  [fele vagva: ' + vagas_sik + '>0]' if fele_vagas else ''}",
        fontsize=12, pad=18,
    )

    # Jelmagyarazo
    from matplotlib.lines import Line2D
    jel = [
        Line2D([0], [0], marker="o", color="w", markerfacecolor="gray",
               markersize=12, label="kubit $\\tau_i$"),
        Line2D([0], [0], color="#e74c3c", linewidth=6, alpha=0.4, label="X-stabilizator"),
        Line2D([0], [0], color="#3498db", linewidth=6, alpha=0.4, linestyle="--", label="Z-stabilizator"),
        Line2D([0], [0], color="gray", alpha=0.5, label="koherencia-fonal"),
    ]
    ax.legend(handles=jel, loc="upper left", fontsize=8, framealpha=0.85)


def _kivul_vagas(p, sik):
    """Vizsgald meg, hogy a pont a vagasi sikon kivul esik-e (eldobjuk)."""
    idx = {"x": 0, "y": 1, "z": 2}[sik]
    return p[idx] < 0.0


def _rajzol_vagasi_sik(ax, sik):
    """Rajzold ki a vagasi sikot (atszuro vilagos lap)."""
    idx = {"x": 0, "y": 1, "z": 2}[sik]
    n = 20
    s = np.linspace(-1.5, 1.5, n)
    S1, S2 = np.meshgrid(s, s)
    S3 = np.zeros_like(S1)
    if idx == 0:
        X, Y, Z = S3, S1, S2
    elif idx == 1:
        X, Y, Z = S1, S3, S2
    else:
        X, Y, Z = S1, S2, S3
    ax.plot_surface(X, Y, Z, alpha=0.06, color="#2ecc71", edgecolor="none")


def main():
    fig = plt.figure(figsize=(13, 7), facecolor="#0d1117")

    # Ket reszabra: bal = teljes, jobb = fele vagva
    ax1 = fig.add_subplot(121, projection="3d", facecolor="#0d1117")
    ax2 = fig.add_subplot(122, projection="3d", facecolor="#0d1117")

    build_scene(ax1, fele_vagas=False)
    build_scene(ax2, fele_vagas=True, vagas_sik="z")

    # Sotet tema
    for ax in (ax1, ax2):
        ax.xaxis.pane.fill = True
        ax.yaxis.pane.fill = True
        ax.zaxis.pane.fill = True
        ax.xaxis.pane.set_facecolor("#161b22")
        ax.yaxis.pane.set_facecolor("#161b22")
        ax.zaxis.pane.set_facecolor("#161b22")
        ax.xaxis.pane.set_edgecolor("#30363d")
        ax.yaxis.pane.set_edgecolor("#30363d")
        ax.zaxis.pane.set_edgecolor("#30363d")
        ax.tick_params(colors="#8b949e")
        for label in (ax.get_xticklabels() + ax.get_yticklabels() + ax.get_zticklabels()):
            label.set_color("#8b949e")

    fig.text(0.5, 0.02,
             "$\\alpha \\approx 7/(64 \\cdot 15) \\approx 0.00729 \\approx 1/137$  |  "
             "$E \\leftrightarrow I$: Landauer $E = k_B T \\ln 2 \\cdot I$  |  "
             "Cardano-ciklus: energia $\\to$ informacio $\\to$ hibajavitas $\\to$ reset",
             ha="center", fontsize=10, color="#8b949e")

    kimenet = "/Users/joco/opencode/steane_3d_fele.png"
    plt.savefig(kimenet, dpi=140, facecolor="#0d1117", bbox_inches="tight")
    print(f"Mentve: {kimenet}")


if __name__ == "__main__":
    main()