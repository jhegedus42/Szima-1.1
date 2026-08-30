import json
import os
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

ALAP = os.path.join(os.path.dirname(os.path.abspath(__file__)))
with open(os.path.join(ALAP, "adatok.json"), encoding="utf-8") as f:
    A = json.load(f)

def ment(nev):
    plt.tight_layout()
    plt.savefig(os.path.join(ALAP, nev), dpi=120)
    plt.close()
    print("kesz:", nev)

# 1. A Cat^∞ letra
l = A["cat_letra"]
x = list(range(len(l)))
plt.figure(figsize=(7, 4))
plt.step(x, x, where="mid", color="tab:blue", linewidth=2)
plt.scatter(x, x, color="tab:red", zorder=5, s=60)
for xi, li in zip(x, l):
    plt.annotate(li, (xi, xi + 0.15), ha="center", fontsize=9)
plt.title("Cat^∞ letra: a magyar-kinai rendszer szintjei (Idris szamolta)")
plt.xlabel("szint")
plt.ylabel("Cat-hatvany")
ment("cat_letra.png")

# 2. Bizonyitas-statisztika (a fuggetlen review szamai)
cimkek = ["valodi (Refl ket kulonbozo konstrukcion)", "tautologia", "gyenge/ures"]
ertekek = [A["bizonyitasok_valodi"], A["bizonyitasok_tautologia"], A["bizonyitasok_gyenge"]]
szinek = ["tab:green", "tab:red", "tab:orange"]
plt.figure(figsize=(7, 4))
plt.bar(cimkek, ertekek, color=szinek)
plt.title("Bizonyitas-statisztika (67 db, fuggetlen review)")
plt.ylabel("darab")
plt.xticks(rotation=12, ha="right")
ment("bizonyitas_statisztika.png")

# 3. Genetikai kod: kodonok vs aminosavak
plt.figure(figsize=(7, 4))
plt.bar(["kodonok (4^3, Idris szamolta)", "aminosavak (4*5, Idris szamolta)"],
        [A["kodonok"], A["aminosavak"]], color=["tab:blue", "tab:purple"])
plt.title("Genetikai kod analogia: " + str(A["kodonok"]) + " kodon → " +
          str(A["aminosavak"]) + " aminosav (degeneraltsag " +
          str(A["degeneraltsag"]) + ")")
plt.ylabel("darab")
ment("genetikai_kod.png")

# 4. Carnot-ciklus 4 fazisa
fazisok = ["1. izoterm expansio", "2. adiabatikus expansio",
           "3. izoterm kompresszio", "4. adiabatikus kompresszio"]
plt.figure(figsize=(7, 5))
szogek = np.linspace(0, 2 * np.pi, 5)
for i, f in enumerate(fazisok):
    plt.annotate(f, (np.cos(szogek[i]) * 1.3, np.sin(szogek[i]) * 1.3),
                 ha="center", fontsize=8)
plt.plot(np.cos(szogek), np.sin(szogek), "o-", color="tab:green", linewidth=2)
plt.xlim(-1.6, 1.6)
plt.ylim(-1.6, 1.6)
plt.gca().set_aspect("equal")
plt.title("Carnot-ciklus (a QEC 4 fazisa) — hatasfok Tc=300/Th=600: " +
          str(A["carnot_fel_05"]))
plt.axis("off")
ment("carnot_ciklus.png")

# 5. Delta osszehasonlitas (log skala)
ertekek_d = [A["delta_szamitott"], A["delta_deklaralt"]]
plt.figure(figsize=(7, 4))
plt.bar(["delta SZAMITOTT (Horgony-CODATA)", "delta DEKLARALT (8.23e-7)"],
        ertekek_d, color=["tab:cyan", "tab:grey"])
plt.yscale("log")
plt.title("A delta: az Idris szamitja (Horgony − CODATA), a deklaralt csak kerekites")
plt.ylabel("ertek (log skala)")
ment("delta.png")

print("MINDEN GRAFIKON KESZ. Idris szamolt, Python rajzolt.")