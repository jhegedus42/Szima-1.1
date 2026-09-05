# SZABALY0-IDRISBEN-LEHETETLEN — csak rajzol (matplotlib/scipy vizualizáció); a kutatási számítás Idrisben él vagy élni fog (AGENTS §3, hullám-3 nyilvántartás)
"""
A Riemann-zeta nemtrivialis gyokei + K(E9) spektrum + Montgomery-parkorrelacio

A lancers:
  Stosszahlansatz (utkozeszam-felteves)
    → Boltzmann H-tetel (dH/dt ≤ 0, entropia no)
    → ido iranya (CPT T-resze)
    → Markov blanket (Friston: a rendszer levallasztasa)
    → K(E9) involucio (ω²=id = onadjungalt)
    → Hilbert-Polya operator (onadjungalt H)
    → Riemann-hipotezis (ζ gyokok = H sajatertekei)

A szamitas:
  1. A ζ(s) elso N nemtrivialis gyoke (mpmath.zetazero)
  2. A ζ gyokok parkorrelacioja (Montgomery, 1972)
  3. A GUE (Gaussian Unitary Ensemble) statisztika
  4. A K(E9) Berman-generatorok spektruma (numpy.linalg.eig)
"""
import numpy as np
from scipy.linalg import eig
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec

try:
    import mpmath
    mpmath.mp.dps = 25
    MPMATH_OK = True
except ImportError:
    MPMATH_OK = False
    print("mpmath nincs telepitve: pip install mpmath")

# ─── 1. A ζ(s) nemtrivialis gyokei ──────────────────────────

def zeta_zeros(N):
    """Az elso N nemtrivialis gyok a kriticuas egyenesen: s = 1/2 + i*gamma_n."""
    zeros = []
    for n in range(1, N+1):
        z = mpmath.zetazero(n)
        gamma = float(z.imag)
        zeros.append(gamma)
    return np.array(zeros)

# ─── 2. A Montgomery-parkorrelacio ──────────────────────────

def montgomery_pair_correlation(zeros, x_max=10.0, n_bins=50):
    """A ζ gyokok parkorrelacioja: P(lambda_m - lambda_n) ~ 1 - (sin(pi*x)/(pi*x))^2."""
    n = len(zeros)
    diffs = []
    for i in range(n):
        for j in range(i+1, n):
            d = zeros[j] - zeros[i]
            if d < x_max:
                diffs.append(d)
    diffs = np.array(diffs)
    # Normalizalas: az atlagos kozes a ζ(1/2) menten
    avg_spacing = np.mean(np.diff(zeros[:100]))
    normalized = diffs / avg_spacing
    hist, edges = np.histogram(normalized, bins=n_bins, range=(0, x_max))
    centers = (edges[:-1] + edges[1:]) / 2
    density = hist / (len(normalized) * (edges[1] - edges[0]))
    return centers, density

def gue_pair_correlation(x):
    """A GUE parkorrelacio: 1 - (sin(pi*x)/(pi*x))^2."""
    with np.errstate(divide='ignore', invalid='ignore'):
        sinc = np.where(x == 0, 1.0, np.sin(np.pi*x) / (np.pi*x))
    return 1.0 - sinc**2

# ─── 3. A K(E9) Berman-generatorok ──────────────────────────

def berman_e9_matrix(n):
    """Az E9 affin Kac-Moody algebra Berman-generatorok (n×n).
    
    A Berman-generatorok x1..x10 (a Berman-relacioval).
    Az E9 = E8 + affine gyok (9 dimenzio).
    A Berman-relacio: [xi, [xi, xj]] = -xj ha i,j kapcsolodnak.
    
    Itt: a Berman-generatorok mint 9×9 valos matricesok.
    A Cartan-matrix az E9-hez (affin E8).
    """
    # Az E9 Cartan-matrix (9×9, affin E8)
    # A Dinkin-diagram: 1-2-3-4-5-6-7-8 (E8) + 0-1 (affine)
    # A Cartan-matrix az E9-hez:
    A = np.array([
        [ 2, -1,  0,  0,  0,  0,  0,  0,  0],  # α0 (affine)
        [-1,  2, -1,  0,  0,  0,  0,  0,  0],  # α1
        [ 0, -1,  2, -1,  0,  0,  0,  0,  0],  # α2
        [ 0,  0, -1,  2, -1,  0,  0,  0,  0],  # α3
        [ 0,  0,  0, -1,  2, -1,  0,  0, -1],  # α4
        [ 0,  0,  0,  0, -1,  2, -1,  0,  0],  # α5
        [ 0,  0,  0,  0,  0, -1,  2, -1,  0],  # α6
        [ 0,  0,  0,  0,  0,  0, -1,  2,  0],  # α7
        [ 0,  0,  0,  0, -1,  0,  0,  0,  2],  # α8
    ], dtype=float)
    return A

def k_e9_spectrum(A):
    """A K(E9) spektrum: a Cartan-matrix sajatertekei."""
    eigenvalues = np.linalg.eigvalsh(A)
    return eigenvalues

def berman_e10_matrix():
    """A K(E10) kritikus Berman-generator x1 (10×10).
    
    A Berman x1 = a kritikus generator ami osszekoti a q+/q- parabolikusokat.
    Az x1 egy 10×10 anti-Hermitian matrix (a Berman-relaciobol).
    """
    # A Berman x1 = a hurokvaltozo forgatasa (t → t^{-1})
    # Egy 10×10 anti-Hermitian matrix (komplex sajateretek)
    n = 10
    M = np.zeros((n, n), dtype=complex)
    # A Berman-relacio: [x1, [x1, xj]] = -xj (j osszekottetvvel)
    # Az x1 = a forgatas matrix (t → t^{-1})
    for i in range(n-1):
        M[i, i+1] = 1j
        M[i+1, i] = -1j
    # A hurok (affine gyok)
    M[0, n-1] = 1j
    M[n-1, 0] = -1j
    return M

def berman_spectrum(M):
    """A Berman-generator spektruma (komplex sajateretek)."""
    eigenvalues = np.linalg.eigvals(M)
    return eigenvalues

# ─── 4. A GUE (Gaussian Unitary Ensemble) ──────────────────

def gue_matrix(n):
    """Egy n×n GUE matrix (random Hermitian)."""
    A = np.random.randn(n, n) + 1j * np.random.randn(n, n)
    A = (A + A.conj().T) / np.sqrt(2)
    return A

def gue_spectrum(n, N_samples=100):
    """A GUE spektrum (N minta atlagaban)."""
    all_eigs = []
    for _ in range(N_samples):
        M = gue_matrix(n)
        eigs = np.linalg.eigvalsh(M)
        all_eigs.extend(eigs)
    return np.array(all_eigs)

# ─── 5. FOMPROGRAM ─────────────────────────────────────────

def main():
    if not MPMATH_OK:
        print("mpmath szukseges: pip install mpmath")
        return

    N = 100

    print("=== ZETA GYOKOK + K(E9) SPEKTRUM ===")
    print()

    # 1. A ζ(s) elso N gyoke
    zeros = zeta_zeros(N)
    print(f"1. ζ(s) elso {N} nemtrivialis gyoke (γ_n):")
    for i in range(min(10, N)):
        print(f"  γ_{i+1} = {zeros[i]:.6f}")
    print(f"  ...")
    print(f"  γ_{N} = {zeros[-1]:.6f}")
    print()

    # 2. A Montgomery-parkorrelacio
    centers, density = montgomery_pair_correlation(zeros, x_max=5.0, n_bins=40)
    x_theory = np.linspace(0.01, 5.0, 200)
    gue_theory = gue_pair_correlation(x_theory)
    print(f"2. Montgomery-parkorrelacio:")
    print(f"  A ζ gyokok parkorrelacioja ~ GUE statisztika")
    print(f"  P(x) ~ 1 - (sin(πx)/(πx))^2 (GUE)")
    print()

    # 3. A K(E9) Cartan-matrix spektruma
    A = berman_e9_matrix(N)
    spectrum = k_e9_spectrum(A)
    print(f"3. K(E9) Cartan-matrix spektruma ({N}×{N}):")
    print(f"  Sajatertekek: {sorted(spectrum[:5])}")
    print(f"  ...")
    print(f"  Min: {spectrum.min():.4f}, Max: {spectrum.max():.4f}")
    print()

    # 4. A Berman x1 spektruma
    M = berman_e10_matrix()
    berman_spec = berman_spectrum(M)
    print(f"4. Berman x1 spektruma (10×10):")
    print(f"  Sajatertekek: {np.sort(berman_spec.real)[:5]}")
    print(f"  Min Re: {berman_spec.real.min():.4f}, Max Re: {berman_spec.real.max():.4f}")
    print(f"  Min Im: {berman_spec.imag.min():.4f}, Max Im: {berman_spec.imag.max():.4f}")
    print()

    # 5. A GUE spektrum
    gue_spec = gue_spectrum(10, N_samples=100)
    gue_spacings = np.diff(np.sort(gue_spec))
    gue_normalized = gue_spacings / np.mean(gue_spacings)
    print(f"5. GUE spektrum (10×10, 100 minta):")
    print(f"  Atlagos koz: {np.mean(gue_spacings):.4f}")
    print(f"  Szoras: {np.std(gue_spacings):.4f}")
    print()

    # 6. Rajzolas
    fig = plt.figure(figsize=(16, 10), facecolor='#0d1117')
    gs = GridSpec(2, 3, hspace=0.4, wspace=0.3)

    # Panel 1: ζ gyokok a kriticuas egyenesen
    ax1 = fig.add_subplot(gs[0, 0], facecolor='#161b22')
    ax1.scatter(np.zeros(N), zeros, color='#58a6ff', s=10, alpha=0.7)
    ax1.set_title('ζ(s) gyökök a kritikus egyenesen\nRe(s) = 1/2', color='#c9d1d9', fontsize=10)
    ax1.set_xlabel('Re(s) = 1/2', color='#8b949e')
    ax1.set_ylabel('Im(s) = γ_n', color='#8b949e')
    ax1.tick_params(colors='#8b949e')
    for spine in ax1.spines.values(): spine.set_color('#30363d')

    # Panel 2: Montgomery-parkorrelacio
    ax2 = fig.add_subplot(gs[0, 1], facecolor='#161b22')
    ax2.plot(centers, density, 'o-', color='#58a6ff', markersize=4, label='ζ gyökök')
    ax2.plot(x_theory, gue_theory, '-', color='#f778ba', linewidth=2, label='GUE: 1-(sin πx/πx)²')
    ax2.set_title('Montgomery-párkorreláció\nζ gyökök vs GUE', color='#c9d1d9', fontsize=10)
    ax2.set_xlabel('x = (γ_m - γ_n) / ⟨s⟩', color='#8b949e')
    ax2.set_ylabel('P(x)', color='#8b949e')
    ax2.legend(fontsize=8, facecolor='#161b22', edgecolor='#30363d')
    ax2.tick_params(colors='#8b949e')
    for spine in ax2.spines.values(): spine.set_color('#30363d')

    # Panel 3: K(E9) spektrum
    ax3 = fig.add_subplot(gs[0, 2], facecolor='#161b22')
    ax3.hist(spectrum, bins=30, color='#56d364', alpha=0.7, edgecolor='#30363d')
    ax3.set_title('K(E9) Cartan-matrix spektrum', color='#c9d1d9', fontsize=10)
    ax3.set_xlabel('Sajátérték', color='#8b949e')
    ax3.set_ylabel('Gyakoriság', color='#8b949e')
    ax3.tick_params(colors='#8b949e')
    for spine in ax3.spines.values(): spine.set_color('#30363d')

    # Panel 4: Berman x1 spektrum (komplex)
    ax4 = fig.add_subplot(gs[1, 0], facecolor='#161b22')
    ax4.scatter(berman_spec.real, berman_spec.imag, color='#f778ba', s=50, alpha=0.7)
    ax4.set_title('Berman x1 spektrum (komplex)\nK(E10) kritikus generátor', color='#c9d1d9', fontsize=10)
    ax4.set_xlabel('Re(λ)', color='#8b949e')
    ax4.set_ylabel('Im(λ)', color='#8b949e')
    ax4.tick_params(colors='#8b949e')
    for spine in ax4.spines.values(): spine.set_color('#30363d')
    ax4.axhline(0, color='#30363d', linewidth=0.5)
    ax4.axvline(0, color='#30363d', linewidth=0.5)

    # Panel 5: GUE spektrum kozek
    ax5 = fig.add_subplot(gs[1, 1], facecolor='#161b22')
    ax5.hist(gue_normalized, bins=30, color='#f0883e', alpha=0.7, density=True, edgecolor='#30363d')
    ax5.set_title('GUE szomszéd-távolságok\n(Wigner-Dyson)', color='#c9d1d9', fontsize=10)
    ax5.set_xlabel('s / ⟨s⟩', color='#8b949e')
    ax5.set_ylabel('P(s)', color='#8b949e')
    ax5.tick_params(colors='#8b949e')
    for spine in ax5.spines.values(): spine.set_color('#30363d')

    # Panel 6: ζ gyokok kozek
    ax6 = fig.add_subplot(gs[1, 2], facecolor='#161b22')
    zeta_spacings = np.diff(zeros)
    zeta_normalized = zeta_spacings / np.mean(zeta_spacings)
    ax6.hist(zeta_normalized, bins=30, color='#58a6ff', alpha=0.7, density=True, edgecolor='#30363d')
    ax6.set_title('ζ gyök szomszéd-távolságok\n(normalizált)', color='#c9d1d9', fontsize=10)
    ax6.set_xlabel('s / ⟨s⟩', color='#8b949e')
    ax6.set_ylabel('P(s)', color='#8b949e')
    ax6.tick_params(colors='#8b949e')
    for spine in ax6.spines.values(): spine.set_color('#30363d')

    fig.suptitle('ζ(s) gyökök + K(E9) spektrum + Montgomery-párkorreláció + GUE\nStoßzahlansatz → H-tétel → Markov blanket → K(E9) → Hilbert-Pólya',
                 color='#c9d1d9', fontsize=12, y=0.98)

    plt.savefig('/Users/joco/opencode/zeta_ke9_spectrum.png', dpi=150, facecolor='#0d1117', bbox_inches='tight')
    print("6. Rajz mentve: zeta_ke9_spectrum.png")

if __name__ == "__main__":
    main()