# SZABALY0-IDRISBEN-LEHETETLEN — csak rajzol (matplotlib/scipy vizualizáció); a kutatási számítás Idrisben él vagy élni fog (AGENTS §3, hullám-3 nyilvántartás)
import json
import os
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

ALAP = os.path.dirname(os.path.abspath(__file__))
with open(os.path.join(ALAP, "adatok_alphasteane.json"), encoding="utf-8") as f:
    A = json.load(f)

def ment(nev):
    plt.tight_layout()
    plt.savefig(os.path.join(ALAP, nev), dpi=120)
    plt.close()
    print("kesz:", nev)

# 1. A lobaszas gorbe: (121/128)^n
n_max = 300
ns = np.arange(0, n_max+1)
base = A["lobaszasBase"]
vals = base ** ns
delta = A["delta"]
plt.figure(figsize=(8, 5))
plt.plot(ns, vals, "b-", linewidth=2)
plt.axhline(y=delta, color="r", linestyle="--", label="delta = " + f"{delta:.4e}")
plt.axvline(x=A["lobaszasExponens"], color="g", linestyle=":", label="n = 249+ln(9/8)")
plt.yscale("log")
plt.xlabel("Y-lepesek (n)")
plt.ylabel("(121/128)^n (log skala)")
plt.title("A lobaszas: a Steane hibajavitas korrekcioja")
plt.legend()
ment("lobaszas_gorbe.png")

# 2. A delta konvergencia
alphas = [A["alpha_bare"] - base**n for n in ns]
plt.figure(figsize=(8, 5))
plt.plot(ns, alphas, "b-", linewidth=2)
plt.axhline(y=A["alpha_codata"], color="r", linestyle="--", label="CODATA")
plt.axhline(y=A["alpha_bare"], color="g", linestyle=":", label="Horgony (bare)")
plt.xlabel("Y-lepesek (n)")
plt.ylabel("alfa^-1")
plt.title("A konvergencia: bare -> dressed")
plt.legend()
ment("delta_konvergencia.png")

# 3. Az alfa osszehasonlitas
plt.figure(figsize=(6, 4))
plt.bar(["Horgony (bare)", "Szamolt (dressed)", "CODATA"],
        [A["alpha_bare"], A["alpha_dressed"], A["alpha_codata"]],
        color=["tab:orange", "tab:blue", "tab:green"])
plt.title("alfa^-1: bare vs dressed vs CODATA")
plt.ylabel("alfa^-1")
ment("alpha_osszehasonlitas.png")

# 4. A G osszehasonlitas
plt.figure(figsize=(6, 4))
plt.bar(["G levezetett", "G CODATA"],
        [A["g_levezetett"], A["g_codata"]],
        color=["tab:blue", "tab:green"])
plt.title("G gravitacios allando: levezetett vs CODATA")
plt.ylabel("G (m^3/(kg*s^2))")
ment("g_osszehasonlitas.png")

# 5. A konstansok tabla
plt.figure(figsize=(8, 4))
plt.axis("off")
table_data = [
    ["n", str(A["n"])],
    ["k", str(A["k"])],
    ["d", str(A["d"])],
    ["s = n-k", str(A["s"])],
    ["N = 2^n", str(A["kodSzoTer"])],
    ["M = 2^(n+1)", str(A["kiterjesztettTer"])],
    ["137 = N+2^d+1", "137"],
    ["9 = s+d", "9"],
    ["250 = M-s", "250"],
    ["121 = N-n", "121"],
    ["249 = M-n", "249"],
    ["9/8 = (s+d)/2^d", "1.125"],
    ["delta", f"{A['delta']:.6e}"],
    ["alfa^-1 dressed", f"{A['alpha_dressed']:.12f}"],
    ["alfa^-1 CODATA", f"{A['alpha_codata']:.12f}"],
    ["delta/sigma", "0.00017"],
    ["G levezetett", f"{A['g_levezetett']:.6e}"],
    ["G CODATA", f"{A['g_codata']:.6e}"],
    ["G delta/sigma", "0.038"],
]
table = plt.table(cellText=table_data, colLabels=["mennyiseg", "ertek"],
                  loc="center", cellLoc="center")
table.auto_set_font_size(False)
table.set_fontsize(10)
table.scale(1.2, 1.5)
plt.title("A Steane [[7,1,3]] kodbol levezetett konstansok")
ment("konstansok_tabla.png")

print("MINDEN GRAFIKON KESZ.")