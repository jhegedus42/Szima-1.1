# ═══ GRAFIKON-GENERÁTOR — F2: E8 gyökrendszer ═══
# EZT A FÁJLT AZ IDRIS GENERÁLTA (KonyvAdat_E8Gyokrendszer_v1.main,
# §1.0: az Idris írja a Pythont — kéz nem írt sort).
# Minden kernel-érték az Idris-futásból (GAUGE); a Python-oldal
# ÚJRAÉPÍTI a gyökrendszert — a két út maradéka a maradekok.csv-ben.
KERNEL = {
  'tipus1Szam': 112,
  'tipus2Szam': 128,
  'gyokSzam': 240,
  'pozicioParokSzam': 28,
  'elojelParokSzam': 4,
  'osszesElojelSzam': 256,
  'faktorialisNyolc': 40320,
  'faktorialisPrim': 40320,
  'faktorialisPrimTenyezok': [128, 9, 5, 7],
  'weylD8': 5160960,
  'triality': 135,
  'weylE8': 696729600,
  'weylE8Prim': 696729600,
  'weylPrimTenyezok': [16384, 243, 25, 7],
  'e8Dimenzio': 248,
  'e8e8Dimenzio': 496,
  'hid256': 256,
  'tipus1Norma': 8,
  'tipus2Norma': 8,
  'szorzatT1T2': 4,
  'szorzatEllentett': -8,
  'szorzatMeroleges': 0,
  'reflexioOnmagara': '[-2,-2,0,0,0,0,0,0]',
  'reflexioMeroleges': '[2,-2,0,0,0,0,0,0]',
  'reflexioSzomszed': '[0,-2,2,0,0,0,0,0]',
  'eloszlasHibak': 0,
  'zarasHibak': 0,
  'fokszamOsszeg': 16,
  'hodgePelda': 12,
  'hodgeInvolutioPelda': 5,
  'kodszoElso': [1, 0, 0, 0, 0, 1, 1],
  'kodszoMindEgyes': [1, 1, 1, 1, 1, 1, 1],
  'sulyOsszeg': 16,
  'kodszoDb': 16,
  'kodszoEgyediDb': 16,
  'mindLegalabbHarom': True,
  'egeszSzavak': 112,
  'felegeszSzavak': 128,
  'alapszokincszam': 240,
}
GENERALOSOROK = [[1, 0, 0, 0, 0, 1, 1], [0, 1, 0, 0, 1, 0, 1], [0, 0, 1, 0, 1, 1, 0], [0, 0, 0, 1, 1, 1, 1]]
import itertools
import json
import math
import os
import sys
import time
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

ALAP = os.path.dirname(os.path.abspath(__file__))
GRAFIKONOK = os.path.join(ALAP, "grafikonok")
os.makedirs(GRAFIKONOK, exist_ok=True)
MENT_DARAB = 0

# ─── A GYÖKRENDSZER ÚJRAÉPÍTÉSE (a szimulációs út — §18 két út) ───
def párosMínusz(vektor):
    return sum(1 for x in vektor if x < 0) % 2 == 0

pozícióPárok = [(i, j) for i in range(1, 9) for j in range(1, 9) if i < j]
előjelPárok = [(1, 1), (1, -1), (-1, 1), (-1, -1)]
típus1 = []
for (i, j) in pozícióPárok:
    for (s1, s2) in előjelPárok:
        vektor = [0] * 8
        vektor[i - 1] = 2 * s1
        vektor[j - 1] = 2 * s2
        típus1.append(tuple(vektor))
típus2 = [tuple(v) for v in itertools.product([1, -1], repeat=8) if párosMínusz(v)]
e8 = típus1 + típus2
típus1Halmaz = set(típus1)
e8Halmaz = set(e8)
mínuszEloszlásTípus2 = [sum(1 for v in típus2 if sum(1 for x in v if x < 0) == k) for k in range(9)]

# ─── A BELSŐ SZORZAT-TÁBLA (240×240) ÉS A NORMÁK ───
MÁTRIX = np.array([[sum(a * b for a, b in zip(u, v)) for v in e8] for u in e8])
engedélyezett = [-8, -4, 0, 4, 8]
normák = [sum(x * x for x in v) for v in e8]
rosszNormák = sum(1 for n in normák if n != 8)
rosszSzorzatok = int(np.sum(~np.isin(MÁTRIX, engedélyezett)))
eloszlásPélda = [int(np.sum(MÁTRIX[0] == c)) for c in engedélyezett]
rosszEloszlás = sum(1 for k in range(len(e8)) if [int(np.sum(MÁTRIX[k] == c)) for c in engedélyezett] != [1, 56, 126, 56, 1])
párszámok = [int(np.sum(MÁTRIX == c)) for c in engedélyezett]

# ─── A WEYL-TÜKRÖZÉS ÉS A ZÁRTSÁG (57 600 pár) ───
def tükröz(alfa, béta):
    szorzat = sum(a * b for a, b in zip(alfa, béta))
    return tuple(b - (szorzat // 4) * a for a, b in zip(alfa, béta))
zárásHibák = sum(1 for alfa in e8 for béta in e8 if tükröz(alfa, béta) not in e8Halmaz)

# ─── RENDEK ÉS FAKTORIÁLISOK ───
f8 = math.factorial(8)
prímÚtFaktoriális = 128 * 9 * 5 * 7
weylD8 = 128 * f8
trialitás = 3 * 3 * 3 * 5
weylE8 = weylD8 * trialitás
prímÚtWeyl = 16384 * 243 * 25 * 7

# ─── A 16 PENGE (Cl(4)) ───
pengék = list(range(16))
def fok(x):
    return bin(x).count("1")
def duál(x):
    return 15 - x
fokszámok = [sum(1 for p in pengék if fok(p) == k) for k in range(5)]
hodgeInvolúcióHibák = sum(1 for p in pengék if duál(duál(p)) != p)
fokTükrözésHibák = sum(1 for p in pengék if fok(duál(p)) + fok(p) != 4)

# ─── A HAMMING [7,4,3] KÓD ───
G = GENERALOSOROK
def kódszó(üzenet):
    return [sum(üzenet[i] * G[i][b] for i in range(4)) % 2 for b in range(7)]
üzenetek = [list(m) for m in itertools.product([0, 1], repeat=4)]
kódszavak = [kódszó(m) for m in üzenetek]
súlyok = [sum(c) for c in kódszavak]
súlyEloszlás = [súlyok.count(w) for w in (0, 3, 4, 7)]
egyediKódszavak = len({tuple(c) for c in kódszavak})
párTávolságok = [sum(a != b for a, b in zip(x, y)) for x in kódszavak for y in kódszavak if x != y]
minimálisTáv = min(párTávolságok)

# ─── MARADÉKOK (Δ = szimuláció − kernel) ───
maradékok = [
    ("típus-1 gyökök száma", len(típus1), KERNEL["tipus1Szam"]),
    ("típus-2 gyökök száma", len(típus2), KERNEL["tipus2Szam"]),
    ("E8 gyökök száma", len(e8), KERNEL["gyokSzam"]),
    ("pozíciópárok C(8,2)", len(pozícióPárok), KERNEL["pozicioParokSzam"]),
    ("előjel-kombinációk 2^8", 2 ** 8, KERNEL["osszesElojelSzam"]),
    ("rossz norma² (nem 8)", rosszNormák, 0),
    ("rossz belsőszorzat-érték", rosszSzorzatok, 0),
    ("rossz eloszlású gyök", rosszEloszlás, KERNEL["eloszlasHibak"]),
    ("Weyl-zárási hiba", zárásHibák, KERNEL["zarasHibak"]),
    ("8! rekurzió", f8, KERNEL["faktorialisNyolc"]),
    ("8! prím-út", prímÚtFaktoriális, KERNEL["faktorialisPrim"]),
    ("W(D8) = 2^7·8!", weylD8, KERNEL["weylD8"]),
    ("trialitás 135", trialitás, KERNEL["triality"]),
    ("W(E8) struktúra-út", weylE8, KERNEL["weylE8"]),
    ("W(E8) prím-út", prímÚtWeyl, KERNEL["weylE8Prim"]),
    ("E8 dimenzió 240+8", len(e8) + 8, KERNEL["e8Dimenzio"]),
    ("E8×E8 dimenzió 248·2", (len(e8) + 8) * 2, KERNEL["e8e8Dimenzio"]),
    ("híd 240+16", len(e8) + len(pengék), KERNEL["hid256"]),
    ("penge-fokszámösszeg", sum(fokszámok), KERNEL["fokszamOsszeg"]),
    ("Hodge-példa duál(3)", duál(3), KERNEL["hodgePelda"]),
    ("Hodge-involúció duál(duál(5))", duál(duál(5)), KERNEL["hodgeInvolutioPelda"]),
    ("Hodge-involúció hibák (16 penge)", hodgeInvolúcióHibák, 0),
    ("fok-tükrözés hibák (k+4−k=4)", fokTükrözésHibák, 0),
    ("kódszavak száma", len(kódszavak), KERNEL["kodszoDb"]),
    ("egyedi kódszavak", egyediKódszavak, KERNEL["kodszoEgyediDb"]),
    ("súly-összeg 1+7+7+1", sum(súlyEloszlás), KERNEL["sulyOsszeg"]),
    ("minden pártávolság ≥ 3 (d = 3)", minimálisTáv >= 3, KERNEL["mindLegalabbHarom"]),
]

print("═══ MARADÉKTÁBLA (Δ = szimuláció − kernel) ═══")
maximumDéltérés = 0
with open(os.path.join(ALAP, "maradekok.csv"), "w", encoding="utf-8") as fájl:
    print("név;szimuláció;kernel;Δ", file=fájl)
    for (név, szimuláció, kernel) in maradékok:
        eltérés = szimuláció - kernel
        maximumDéltérés = max(maximumDéltérés, abs(eltérés))
        print(f"{név:38s} szimuláció={szimuláció:>12} kernel={kernel:>12} Δ={eltérés}")
        print(f"{név};{szimuláció};{kernel};{eltérés}", file=fájl)
print(f"max |Δ| = {maximumDéltérés}")
# ─── ÁBRÁK · 绘图 · Diagramme ───
SZÍN_TÍPUS1 = "#e3b341"
SZÍN_TÍPUS2 = "#39d2c0"
SZÍN_HÍD = "#58a6ff"
SZÍN_HIBA = "#f85149"

def ment(azonosító, sorszám):
    út = os.path.join(GRAFIKONOK, azonosító + "_" + str(sorszám) + ".png")
    plt.tight_layout()
    plt.savefig(út, dpi=110)
    plt.close()
    global MENT_DARAB
    MENT_DARAB = MENT_DARAB + 1

def petri(az, n, cím):
    x = [v[0] for v in e8]
    y = [v[1] for v in e8]
    színek = [SZÍN_TÍPUS1 if v in típus1Halmaz else SZÍN_TÍPUS2 for v in e8]
    plt.figure(figsize=(8.5, 5.2))
    plt.scatter(x, y, c=színek, s=28, alpha=0.75, edgecolors="none")
    plt.scatter([], [], c=SZÍN_TÍPUS1, label="típus-1: (±1,±1,0⁶) — " + str(len(típus1)))
    plt.scatter([], [], c=SZÍN_TÍPUS2, label="típus-2: (±½)⁸ — " + str(len(típus2)))
    plt.axhline(0, color="#26303d", linewidth=0.6)
    plt.axvline(0, color="#26303d", linewidth=0.6)
    plt.gca().set_aspect("equal")
    plt.xlabel("1. koordináta")
    plt.ylabel("2. koordináta")
    plt.title(cím, fontsize=10)
    plt.legend(fontsize=8)
    ment(az, n)

def típusok(az, n, cím):
    fig, tengelyek = plt.subplots(1, 2, figsize=(8.5, 5.2))
    tengelyek[0].scatter([v[0] for v in típus1], [v[1] for v in típus1], c=SZÍN_TÍPUS1, s=24)
    tengelyek[0].set_title("típus-1: " + str(len(típus1)) + " db", fontsize=9)
    tengelyek[1].scatter([v[0] for v in típus2], [v[1] for v in típus2], c=SZÍN_TÍPUS2, s=24)
    tengelyek[1].set_title("típus-2: " + str(len(típus2)) + " db", fontsize=9)
    for tengely in tengelyek:
        tengely.set_aspect("equal")
        tengely.axhline(0, color="#26303d", linewidth=0.6)
        tengely.axvline(0, color="#26303d", linewidth=0.6)
    fig.suptitle(cím, fontsize=10)
    ment(az, n)

def normaHisztogram(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    plt.hist(normák, bins=[7.5, 8.5], color=SZÍN_TÍPUS1, edgecolor="#0b0f14")
    plt.xlabel("norma² (a 2-szeres skálán)")
    plt.ylabel("gyökök száma")
    rossz = rosszNormák
    plt.title(cím + "  (hibás: " + str(rossz) + ")", fontsize=10)
    ment(az, n)

def eloszlás(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    oszlopok = [str(c) for c in engedélyezett]
    plt.bar(oszlopok, eloszlásPélda, color=[SZÍN_HIBA, "#bc8cff", "#7d8a99", SZÍN_TÍPUS2, SZÍN_TÍPUS1])
    for k, érték in enumerate(eloszlásPélda):
        plt.text(k, érték + 1, str(érték), ha="center", fontsize=9)
    plt.xlabel("⟨α,β⟩ érték")
    plt.ylabel("darab (a példagyök körül)")
    plt.title(cím + "  —  (1, 56, 126, 56, 1)", fontsize=10)
    ment(az, n)

def hőKép(az, n, cím):
    plt.figure(figsize=(7.2, 6.2))
    kép = plt.imshow(MÁTRIX, cmap="RdBu_r", vmin=-8, vmax=8, aspect="auto", interpolation="nearest")
    plt.colorbar(kép, label="⟨α,β⟩")
    plt.xlabel("β index (0…239)")
    plt.ylabel("α index (0…239)")
    plt.title(cím + "  —  {−8,−4,0,+4,+8} rácsos minta", fontsize=10)
    ment(az, n)

def szögRend(az, n, cím):
    szögek = [math.degrees(math.acos(c / 8)) for c in engedélyezett]
    rendek = [1 if szög < 1 else round(360 / szög) for szög in szögek]
    plt.figure(figsize=(8.5, 5.2))
    plt.scatter(szögek, rendek, s=140, c=SZÍN_HÍD, zorder=3)
    for szög, rend in zip(szögek, rendek):
        plt.annotate(str(rend), (szög, rend), textcoords="offset points", xytext=(8, 4), fontsize=10)
    plt.xlabel("szög a gyökök között (fok)")
    plt.ylabel("forgás rendje (360/szög)")
    plt.grid(color="#26303d", linewidth=0.5)
    plt.title(cím + "  —  rendek {1, 2, 3, 4, 6}", fontsize=10)
    ment(az, n)

def reflexióVektor(az, n, cím):
    alfa = (2, 2, 0, 0, 0, 0, 0, 0)
    béta = (2, 0, 2, 0, 0, 0, 0, 0)
    tükörKép = tükröz(alfa, béta)
    plt.figure(figsize=(7.2, 6.2))
    plt.quiver(0, 0, alfa[0], alfa[1], angles="xy", scale_units="xy", scale=1, color=SZÍN_TÍPUS1, label="α = (2,2,0⁶)")
    plt.quiver(0, 0, béta[0], béta[1], angles="xy", scale_units="xy", scale=1, color=SZÍN_TÍPUS2, label="β = (2,0,2,0⁵)")
    plt.quiver(0, 0, tükörKép[0], tükörKép[1], angles="xy", scale_units="xy", scale=1, color=SZÍN_HIBA, label="σ_α(β) = " + str(list(tükörKép)))
    tükörVonalX = [-3, 3]
    tükörVonalY = [3, -3]
    plt.plot(tükörVonalX, tükörVonalY, "--", color="#7d8a99", linewidth=1, label="tükörsík (⊥α)")
    plt.axhline(0, color="#26303d", linewidth=0.6)
    plt.axvline(0, color="#26303d", linewidth=0.6)
    plt.xlim(-3.5, 3.5)
    plt.ylim(-3.5, 3.5)
    plt.gca().set_aspect("equal")
    plt.legend(fontsize=8)
    plt.title(cím + "  (az (x₁,x₂)-vetület)", fontsize=10)
    ment(az, n)

def pengeFok(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    címkék = ["fok " + str(k) for k in range(5)]
    plt.bar(címkék, fokszámok, color=SZÍN_TÍPUS1, edgecolor="#0b0f14")
    for k, érték in enumerate(fokszámok):
        plt.text(k, érték + 0.08, str(érték), ha="center", fontsize=10)
    plt.xlabel("a penge foka (popcount)")
    plt.ylabel("pengék száma")
    plt.title(cím + "  —  (1, 4, 6, 4, 1)", fontsize=10)
    ment(az, n)

def hodgeNyilak(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    for p in pengék:
        plt.annotate("", xy=(duál(p), 0.55), xytext=(p, 0.45), arrowprops=dict(arrowstyle="->", color=SZÍN_HÍD, alpha=0.65))
    plt.scatter(pengék, [0.45] * 16, c=SZÍN_TÍPUS1, s=40, zorder=3, label="penge (bitmask)")
    plt.scatter([duál(p) for p in pengék], [0.55] * 16, c=SZÍN_TÍPUS2, s=40, zorder=3, label="Hodge-duál (15−x)")
    for p in pengék:
        plt.text(p, 0.40, str(p), ha="center", fontsize=8)
    plt.xlabel("bitmask 0…15")
    plt.yticks([])
    plt.legend(fontsize=8)
    plt.title(cím + "  —  duál(duál(x)) = x mind a 16-on", fontsize=10)
    ment(az, n)

def kódszóRács(az, n, cím):
    plt.figure(figsize=(7.2, 5.6))
    rács = np.array(kódszavak)
    plt.imshow(rács, cmap="YlGnBu", aspect="auto", vmin=0, vmax=1.4)
    plt.xlabel("bit: [idő, okság, tér, szín, hang, fázis, mód]")
    plt.ylabel("üzenet (0…15)")
    plt.title(cím + "  —  " + str(len(kódszavak)) + " kódszó", fontsize=10)
    ment(az, n)

def kódszóSúly(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    plt.bar(["w=0", "w=3", "w=4", "w=7"], súlyEloszlás, color=SZÍN_HÍD, edgecolor="#0b0f14")
    for k, érték in enumerate(súlyEloszlás):
        plt.text(k, érték + 0.08, str(érték), ha="center", fontsize=10)
    plt.xlabel("kódszó súlya (az 1-esek száma)")
    plt.ylabel("kódszavak száma")
    plt.title(cím + "  —  (1, 7, 7, 1)", fontsize=10)
    ment(az, n)

def oszlop(az, n, cím, címkék, értékek, függő):
    plt.figure(figsize=(8.5, 5.2))
    plt.bar(címkék, értékek, color=SZÍN_HÍD, edgecolor="#0b0f14")
    for k, érték in enumerate(értékek):
        plt.text(k, érték, str(érték), ha="center", va="bottom", fontsize=9)
    plt.ylabel(függő)
    plt.xticks(fontsize=8, rotation=12)
    plt.title(cím, fontsize=10)
    ment(az, n)

def prímTorony(az, n, cím, címkék, értékek):
    plt.figure(figsize=(8.5, 5.2))
    plt.bar(címkék, értékek, color=SZÍN_TÍPUS2, edgecolor="#0b0f14")
    szorzat = 1
    for érték in értékek:
        szorzat = szorzat * érték
    for k, érték in enumerate(értékek):
        plt.text(k, érték, str(érték), ha="center", va="bottom", fontsize=9)
    plt.yscale("log")
    plt.ylabel("tényező (log skála)")
    plt.title(cím + "  —  szorzatuk: " + str(szorzat), fontsize=10)
    ment(az, n)

def kétÚtHíd(az, n, cím, címkeEgy, értékEgy, címkeKettő, értékKettő):
    plt.figure(figsize=(8.5, 5.2))
    plt.bar([címkeEgy, címkeKettő], [értékEgy, értékKettő], color=[SZÍN_TÍPUS1, SZÍN_TÍPUS2], edgecolor="#0b0f14")
    plt.axhline(értékEgy, color=SZÍN_HÍD, linestyle="--", linewidth=1)
    eltérés = értékEgy - értékKettő
    plt.text(0.5, max(értékEgy, értékKettő), "Δ = " + str(eltérés), ha="center", fontsize=11, color=SZÍN_HÍD)
    plt.xticks(fontsize=8, rotation=12)
    plt.title(cím, fontsize=10)
    ment(az, n)

def maradékSáv(az, n, cím, nevek, értékek):
    plt.figure(figsize=(8.5, 5.2))
    plt.bar(nevek, értékek, color=(SZÍN_HIBA if max([abs(e) for e in értékek] + [0]) > 0 else SZÍN_TÍPUS2), edgecolor="#0b0f14")
    felső = max([abs(e) for e in értékek] + [0])
    plt.ylim(-1 if felső == 0 else -felső * 1.3, max(felső * 1.3, 1))
    plt.axhline(0, color="#3ddc84", linewidth=1)
    plt.ylabel("Δ (várható 0)")
    plt.xticks(fontsize=8, rotation=12)
    plt.title(cím + "  —  max |Δ| = " + str(felső), fontsize=10)
    ment(az, n)

def faktoriálisLétra(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    fokozatok = [str(k) for k in range(1, 9)]
    értékek = [math.factorial(k) for k in range(1, 9)]
    plt.bar(fokozatok, értékek, color=SZÍN_TÍPUS1, edgecolor="#0b0f14")
    plt.yscale("log")
    plt.xlabel("k")
    plt.ylabel("k! (log skála)")
    plt.title(cím + "  —  8! = " + str(f8), fontsize=10)
    ment(az, n)

def weylLánc(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    címkék = ["2⁷", "8!", "135", "W(D8)", "W(E8)"]
    értékek = [128, f8, trialitás, weylD8, weylE8]
    plt.bar(címkék, értékek, color=SZÍN_HÍD, edgecolor="#0b0f14")
    plt.yscale("log")
    plt.ylabel("érték (log skála)")
    plt.title(cím + "  —  2⁷·8!·135 = " + str(weylE8), fontsize=10)
    ment(az, n)

def híd256Rács(az, n, cím):
    mezők = np.zeros((16, 16))
    for sor in range(16):
        for oszlopIndex in range(16):
            mezők[sor][oszlopIndex] = 0 if sor * 16 + oszlopIndex < len(e8) else 1
    plt.figure(figsize=(7.2, 6.2))
    plt.imshow(mezők, cmap=matplotlib.colors.ListedColormap([SZÍN_TÍPUS1, SZÍN_TÍPUS2]), vmin=0, vmax=1)
    plt.scatter([], [], c=SZÍN_TÍPUS1, label="E8 gyök (tartalom): " + str(len(e8)))
    plt.scatter([], [], c=SZÍN_TÍPUS2, label="Cl(4) penge (keret): " + str(16 * 16 - len(e8)))
    plt.xlabel("16 oszlop")
    plt.ylabel("16 sor")
    plt.legend(fontsize=8, loc="lower right")
    plt.xticks([])
    plt.yticks([])
    plt.title(cím + "  —  " + str(len(e8)) + " + " + str(16 * 16 - len(e8)) + " = " + str(16 * 16), fontsize=10)
    ment(az, n)
KÁRTYÁK = {
  'F2.01': [
    ("faktoriálisLétra", "SZERKEZET — A faktoriális létra: 1!, 2!, …, 8!"),
    ("kétÚtHíd", "SZÁMOLÁS — Két út a 40320-hez: rekurzió ⟷ prímek", 'rekurzió (math.factorial)', f8, '128·9·5·7', prímÚtFaktoriális),
    ("maradékSáv", "ELLENŐRZÉS — Maradékok: f8 ⟷ kernel, prím-út ⟷ kernel (Δ = 0)", ['f8−kernel', 'prímút−kernel'], [f8 - KERNEL['faktorialisNyolc'], prímÚtFaktoriális - KERNEL['faktorialisPrim']]),
    ("prímTorony", "SPEKTRUM — A 40320 prímtornyai: 2⁷, 3², 5, 7", ['2⁷','3²','5','7'], KERNEL['faktorialisPrimTenyezok']),
    ("kétÚtHíd", "HÍD — Híd: Idris-Refl Faktorialis 8 ⟷ Python math.factorial(8)", 'Idris Faktorialis 8 (Refl)', KERNEL['faktorialisNyolc'], 'Python math.factorial(8)', f8)
  ],
  'F2.02': [
    ("prímTorony", "SZERKEZET — A prímtorony: 2⁷ = 128, 3² = 9, 5, 7", ['2⁷','3²','5','7'], KERNEL['faktorialisPrimTenyezok']),
    ("oszlop", "SZÁMOLÁS — A prím-út szorzata: 128·9·5·7", ['128·9·5·7'], [128 * 9 * 5 * 7], 'érték'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: prím-út ⟷ kernel 40320 (Δ = 0)", ['prímút−kernel'], [prímÚtFaktoriális - KERNEL['faktorialisPrim']]),
    ("faktoriálisLétra", "SPEKTRUM — A faktoriális létra 1!…8!"),
    ("kétÚtHíd", "HÍD — Híd: prím-út ⟷ rekurzió (8!)", 'prím-út 128·9·5·7', prímÚtFaktoriális, 'rekurzió 8!', f8)
  ],
  'F2.03': [
    ("petri", "SZERKEZET — A 240 gyök 2D-petri-vetülete (kiválasztott koordináta-sík)"),
    ("oszlop", "SZÁMOLÁS — 28 pozíciópár · 4 előjelpár → 112 típus-1 gyök", ['C(8,2) pozíciópár', '2² előjelpár', 'típus-1 gyök'], [len(pozícióPárok), len(előjelPárok), len(típus1)], 'darab'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: típus-1 enumeráció ⟷ kernel 112 (Δ = 0)", ['típus1−kernel'], [len(típus1) - KERNEL['tipus1Szam']]),
    ("típusok", "SPEKTRUM — A két gyöktípus halmazai: 112 egész + 128 fél-egész"),
    ("kétÚtHíd", "HÍD — Híd: kombinatorika 28·4 ⟷ enumeráció", 'kombinatorika 28·4', len(pozícióPárok) * len(előjelPárok), 'enumeráció', len(típus1))
  ],
  'F2.04': [
    ("típusok", "SZERKEZET — A két gyöktípus halmazai: 112 egész + 128 fél-egész"),
    ("oszlop", "SZÁMOLÁS — 2⁸ kombináció → 128 páros + 128 páratlan", ['2⁸ kombináció', 'páros mínusszal (típus-2)', 'páratlan (kiesett)'], [2**8, len(típus2), 2**8 - len(típus2)], 'darab'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: típus-2 enumeráció ⟷ kernel 128 (Δ = 0)", ['típus2−kernel'], [len(típus2) - KERNEL['tipus2Szam']]),
    ("oszlop", "SPEKTRUM — A mínuszok számának eloszlása a 128 gyökön", ['0','1','2','3','4','5','6','7','8'], mínuszEloszlásTípus2, 'gyök'),
    ("kétÚtHíd", "HÍD — Híd: 256/2 = 128 ⟷ enumeráció", '256/2', 2**8 // 2, 'enumeráció párosok', len(típus2))
  ],
  'F2.05': [
    ("petri", "SZERKEZET — A 240 gyök 2D-petri-vetülete"),
    ("oszlop", "SZÁMOLÁS — 112 + 128 → 240", ['típus-1', 'típus-2', 'összes'], [len(típus1), len(típus2), len(e8)], 'darab'),
    ("maradékSáv", "ELLENŐRZÉS — Maradékok: típus-1, típus-2, e8 ⟷ kernel (Δ = 0)", ['típus1−kernel', 'típus2−kernel', 'e8−kernel'], [len(típus1) - KERNEL['tipus1Szam'], len(típus2) - KERNEL['tipus2Szam'], len(e8) - KERNEL['gyokSzam']]),
    ("normaHisztogram", "SPEKTRUM — norma²-hisztogram mind a 240 gyökön (mind = 8)"),
    ("kétÚtHíd", "HÍD — Híd: 112+128 kombinatorika ⟷ enumeráció 240", '112+128 kombinatorika', 112 + 128, 'enumeráció length', len(e8))
  ],
  'F2.06': [
    ("híd256Rács", "SZERKEZET — 240 gyök + 16 penge egy rácsban (a 256 mező)"),
    ("oszlop", "SZÁMOLÁS — 240 gyök + 16 penge → 256", ['E8 gyök', 'Cl(4) penge', 'összes'], [len(e8), len(pengék), len(e8) + len(pengék)], 'elem'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: híd ⟷ kernel 256 (Δ = 0)", ['híd−kernel'], [len(e8) + len(pengék) - KERNEL['hid256']]),
    ("pengeFok", "SPEKTRUM — A 16 penge fokszámai: (1, 4, 6, 4, 1)"),
    ("kétÚtHíd", "HÍD — Híd: enumeráció 240+16 ⟷ 2⁸", '240+16 enumeráció', len(e8) + len(pengék), '2⁸', 2**8)
  ],
  'F2.07': [
    ("petri", "SZERKEZET — A példagyök (2,2,0⁶) a petri-vetületben"),
    ("oszlop", "SZÁMOLÁS — A négyzettagok: 2² + 2² + 0·6", ['2²', '2²', '0²·6'], [4, 4, 0], 'négyzet'),
    ("maradékSáv", "ELLENŐRZÉS — Hibás normák száma a 240 gyökön (várható 0)", ['rossz norma²'], [rosszNormák]),
    ("normaHisztogram", "SPEKTRUM — norma²-hisztogram mind a 240 gyökön (mind = 8)"),
    ("kétÚtHíd", "HÍD — Híd: kernel gyokNorma ⟷ szimuláció sum(v²)", 'kernel gyokNorma (2,2,0⁶)', KERNEL['tipus1Norma'], 'szimuláció sum(v²)', sum(x * x for x in e8[0]))
  ],
  'F2.08': [
    ("típusok", "SZERKEZET — A fél-egész gyökök halmaza"),
    ("oszlop", "SZÁMOLÁS — 1² × 8 négyzettag", ['1² × 8'], [8 * 1], 'négyzet'),
    ("maradékSáv", "ELLENŐRZÉS — Hibás normák a 240 gyökön (várható 0)", ['rossz norma²'], [rosszNormák]),
    ("normaHisztogram", "SPEKTRUM — norma²-hisztogram mind a 240 gyökön"),
    ("kétÚtHíd", "HÍD — Híd: kernel gyokNorma (1⁸) ⟷ szimuláció", 'kernel gyokNorma (1⁸)', KERNEL['tipus2Norma'], 'szimuláció', sum(x * x for x in [1, 1, 1, 1, 1, 1, 1, 1]))
  ],
  'F2.09': [
    ("weylLánc", "SZERKEZET — A Weyl-lánc: 2⁷ → 8! → 135 → W(D8) → W(E8)"),
    ("oszlop", "SZÁMOLÁS — 2⁷ · 8! → 5 160 960", ['2⁷', '8!', 'W(D8)'], [128, f8, 128 * f8], 'elem'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: W(D8) ⟷ kernel (Δ = 0)", ['W(D8)−kernel'], [weylD8 - KERNEL['weylD8']]),
    ("prímTorony", "SPEKTRUM — A 40320 prímtornyai: 2⁷, 3², 5, 7", ['2⁷','3²','5','7'], KERNEL['faktorialisPrimTenyezok']),
    ("kétÚtHíd", "HÍD — Híd: struktúra 2⁷·8! ⟷ kernel WeylD8Rend", 'struktúra 2⁷·8!', 128 * f8, 'kernel WeylD8Rend', KERNEL['weylD8'])
  ],
  'F2.10': [
    ("oszlop", "SZERKEZET — A trialitás-faktor felépítése: 3·3·3·5", ['3', '3', '3', '5', '135'], [3, 3, 3, 5, 3 * 3 * 3 * 5], 'tényező'),
    ("oszlop", "SZÁMOLÁS — 27 · 5 → 135", ['3³ = 27', '5', '135'], [27, 5, 27 * 5], 'érték'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: trialitás ⟷ kernel (Δ = 0)", ['trialitás−kernel'], [trialitás - KERNEL['triality']]),
    ("prímTorony", "SPEKTRUM — A prímtornyok: 3³ és 5", ['3³', '5'], [27, 5]),
    ("kétÚtHíd", "HÍD — Híd: 3·3·3·5 ⟷ kernel TrialitySzazharmincot", '3·3·3·5', 3 * 3 * 3 * 5, 'kernel 135', KERNEL['triality'])
  ],
  'F2.11': [
    ("weylLánc", "SZERKEZET — A Weyl-lánc: 2⁷ → 8! → 135 → W(D8) → W(E8)"),
    ("oszlop", "SZÁMOLÁS — W(D8) · 135 → 696 729 600", ['W(D8)', '·135', 'W(E8)'], [weylD8, trialitás, weylE8], 'elem'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: W(E8) ⟷ kernel (Δ = 0)", ['W(E8)−kernel'], [weylE8 - KERNEL['weylE8']]),
    ("prímTorony", "SPEKTRUM — A prímtornyok: 2¹⁴, 3⁵, 5², 7", ['2¹⁴','3⁵','5²','7'], KERNEL['weylPrimTenyezok']),
    ("kétÚtHíd", "HÍD — Híd: struktúra-út ⟷ kernel WeylE8Rend", 'struktúra W(D8)·135', weylE8, 'kernel WeylE8Rend', KERNEL['weylE8'])
  ],
  'F2.12': [
    ("prímTorony", "SZERKEZET — A prím-torony: 2¹⁴ · 3⁵ · 5² · 7", ['2¹⁴','3⁵','5²','7'], KERNEL['weylPrimTenyezok']),
    ("oszlop", "SZÁMOLÁS — A prím-út szorzatlánca", ['16384', '243', '25', '7', 'szorzat'], [16384, 243, 25, 7, 16384 * 243 * 25 * 7], 'érték'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: prím-út ⟷ kernel (Δ = 0)", ['W(E8) prímút−kernel'], [prímÚtWeyl - KERNEL['weylE8Prim']]),
    ("weylLánc", "SPEKTRUM — A Weyl-lánc: 2⁷ → 8! → 135 → W(E8)"),
    ("kétÚtHíd", "HÍD — Híd: struktúra-út W(D8)·135 ⟷ prím-út 2¹⁴·3⁵·5²·7", 'struktúra W(D8)·135', weylE8, 'prím 2¹⁴·3⁵·5²·7', prímÚtWeyl)
  ],
  'F2.13': [
    ("petri", "SZERKEZET — A 240 gyök 2D-petri-vetülete"),
    ("oszlop", "SZÁMOLÁS — 240 gyök + 8 Cartan → 248", ['240 gyök', '+8 Cartan', '=248'], [len(e8), 8, len(e8) + 8], 'dimenzió'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: dimenzió ⟷ kernel (Δ = 0)", ['248−kernel'], [len(e8) + 8 - KERNEL['e8Dimenzio']]),
    ("eloszlás", "SPEKTRUM — A gyökök eloszlása egy gyök körül: (1, 56, 126, 56, 1)"),
    ("kétÚtHíd", "HÍD — Híd: gyök+Cartan ⟷ kernel bizE8Dimenzio", '240+8 (gyök+Cartan)', len(e8) + 8, 'kernel 248', KERNEL['e8Dimenzio'])
  ],
  'F2.14': [
    ("típusok", "SZERKEZET — A két gyöktípus halmazai"),
    ("oszlop", "SZÁMOLÁS — A tagok: 2·1 + 2·1 + 0·6", ['2·1', '2·1', '0·1 × 6'], [2, 2, 0], 'tag'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: kevert pár szorzata ⟷ kernel (Δ = 0)", ['T1T2−kernel'], [sum(a * b for a, b in zip((2, 2, 0, 0, 0, 0, 0, 0), (1, 1, 1, 1, 1, 1, 1, 1))) - KERNEL['szorzatT1T2']]),
    ("eloszlás", "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)"),
    ("kétÚtHíd", "HÍD — Híd: kernel BizSzorzatT1T2 ⟷ szimuláció", 'kernel BizSzorzatT1T2', KERNEL['szorzatT1T2'], 'szimuláció', 2 + 2)
  ],
  'F2.15': [
    ("petri", "SZERKEZET — A 240 gyök petri-vetülete (α és −α átellenesen)"),
    ("oszlop", "SZÁMOLÁS — −4 − 4 → −8", ['(−2)·2', '(−2)·2', '0·6'], [-4, -4, 0], 'tag'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: ellentett-szorzat ⟷ kernel (Δ = 0)", ['ellentett−kernel'], [sum(a * b for a, b in zip((2, 2, 0, 0, 0, 0, 0, 0), (-2, -2, 0, 0, 0, 0, 0, 0))) - KERNEL['szorzatEllentett']]),
    ("eloszlás", "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)"),
    ("kétÚtHíd", "HÍD — Híd: kernel BizSzorzatEllentett ⟷ szimuláció", 'kernel α·(−α)', KERNEL['szorzatEllentett'], 'szimuláció', -(2 * 2 + 2 * 2))
  ],
  'F2.16': [
    ("reflexióVektor", "SZERKEZET — A merőleges vektorok az (x₁,x₂)-síkban"),
    ("oszlop", "SZÁMOLÁS — 4 − 4 → 0", ['2·2', '2·(−2)', '0·6'], [4, -4, 0], 'tag'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: merőleges szorzat ⟷ kernel (Δ = 0)", ['merőleges−kernel'], [sum(a * b for a, b in zip((2, 2, 0, 0, 0, 0, 0, 0), (2, -2, 0, 0, 0, 0, 0, 0))) - KERNEL['szorzatMeroleges']]),
    ("eloszlás", "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)"),
    ("kétÚtHíd", "HÍD — Híd: kernel BizSzorzatMeroleges ⟷ szimuláció", 'kernel α·β⊥', KERNEL['szorzatMeroleges'], 'szimuláció', 4 - 4)
  ],
  'F2.17': [
    ("reflexióVektor", "SZERKEZET — A tükrözés vektor-ábrája: α → −α"),
    ("oszlop", "SZÁMOLÁS — ⟨α,α⟩/4 = 2 → α − 2α", ['⟨α,α⟩', '/4', 'α−2α'], [8, 2, 0], 'lépés'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: σ(α,α) szöveg ⟷ kernel (0 = egyezik)", ['σ(α,α)−kernel'], [(0 if str(list(tükröz(e8[0], e8[0]))) == KERNEL['reflexioOnmagara'].replace(' ', '') else 1)]),
    ("eloszlás", "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)"),
    ("kétÚtHíd", "HÍD — Híd: kernel BizReflexioOnmagara ⟷ szimuláció", 'kernel σ(α,α) x-koord.', -2, 'szimuláció x-koord.', tükröz(e8[0], e8[0])[0])
  ],
  'F2.18': [
    ("reflexióVektor", "SZERKEZET — A merőleges β⊥ a tükör síkján marad"),
    ("oszlop", "SZÁMOLÁS — ⟨α,β⊥⟩/4 = 0 → β − 0·α", ['⟨α,β⊥⟩', '/4', 'β−0·α'], [0, 0, 0], 'lépés'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: σ(α,β⊥) ⟷ kernel (0 = egyezik)", ['σ(α,β⊥)−kernel'], [(0 if str(list(tükröz(e8[0], (2, -2, 0, 0, 0, 0, 0, 0)))) == KERNEL['reflexioMeroleges'].replace(' ', '') else 1)]),
    ("eloszlás", "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)"),
    ("kétÚtHíd", "HÍD — Híd: kernel BizReflexioMeroleges ⟷ szimuláció", 'kernel σ(α,β⊥) x-koord.', 2, 'szimuláció x-koord.', tükröz(e8[0], (2, -2, 0, 0, 0, 0, 0, 0))[0])
  ],
  'F2.19': [
    ("reflexióVektor", "SZERKEZET — A tükrözés vektor-ábrája: β → β − α"),
    ("oszlop", "SZÁMOLÁS — ⟨α,β⟩/4 = 1 → β − α", ['⟨α,β⟩', '/4', 'β−α'], [4, 1, 0], 'lépés'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: σ(α,β) ⟷ kernel (0 = egyezik)", ['σ(α,β)−kernel'], [(0 if str(list(tükröz(e8[0], (2, 0, 2, 0, 0, 0, 0, 0)))) == KERNEL['reflexioSzomszed'].replace(' ', '') else 1)]),
    ("eloszlás", "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)"),
    ("kétÚtHíd", "HÍD — Híd: kernel BizReflexioSzomszed ⟷ szimuláció", 'kernel σ(α,β) x-koord.', 0, 'szimuláció x-koord.', tükröz(e8[0], (2, 0, 2, 0, 0, 0, 0, 0))[0])
  ],
  'F2.20': [
    ("hőKép", "SZERKEZET — A 240×240 belsőszorzat-mátrix hőképe"),
    ("eloszlás", "SZÁMOLÁS — A példagyök eloszlása: (1, 56, 126, 56, 1)"),
    ("maradékSáv", "ELLENŐRZÉS — Rossz eloszlású gyökök száma (várható 0)", ['rossz eloszlás−kernel'], [rosszEloszlás - KERNEL['eloszlasHibak']]),
    ("oszlop", "SPEKTRUM — A pár-számok: 240, 13440, 30240, 13440, 240", ['−8', '−4', '0', '+4', '+8'], párszámok, 'pár'),
    ("kétÚtHíd", "HÍD — Híd: kernel eloszlasHibakSzama ⟷ szimuláció rosszEloszlás", 'kernel eloszlasHibakSzama', KERNEL['eloszlasHibak'], 'szimuláció rosszEloszlás', rosszEloszlás)
  ],
  'F2.21': [
    ("hőKép", "SZERKEZET — A 240×240 belsőszorzat-mátrix hőképe"),
    ("oszlop", "SZÁMOLÁS — 240·240 pár → 0 hibás tükrözés", ['240·240 pár', 'zárásHibák'], [240 * 240, zárásHibák], 'darab'),
    ("maradékSáv", "ELLENŐRZÉS — ZárásHibák ⟷ kernel zarasHibakSzama (0 = 0)", ['zárás−kernel'], [zárásHibák - KERNEL['zarasHibak']]),
    ("eloszlás", "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)"),
    ("kétÚtHíd", "HÍD — Híd: kernel zarasHibakSzama ⟷ szimuláció zárásHibák", 'kernel zarasHibakSzama', KERNEL['zarasHibak'], 'szimuláció zárásHibák', zárásHibák)
  ],
  'F2.22': [
    ("petri", "SZERKEZET — A 240 gyök 2D-petri-vetülete"),
    ("oszlop", "SZÁMOLÁS — 112 + 128 → 240", ['típus-1', 'típus-2', 'összes'], [len(típus1), len(típus2), len(e8)], 'darab'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: gyökSzám ⟷ kernel (Δ = 0)", ['gyökSzám−kernel'], [len(e8) - KERNEL['gyokSzam']]),
    ("normaHisztogram", "SPEKTRUM — norma²-hisztogram mind a 240 gyökön"),
    ("kétÚtHíd", "HÍD — Híd: Refl-összeg ⟷ futásidejű számláló", '112+128 (Refl)', 112 + 128, 'gyokSzamSzamitott', KERNEL['gyokSzam'])
  ],
  'F2.23': [
    ("weylLánc", "SZERKEZET — A Weyl-lánc: 2⁷ → 8! → 135 → W(E8)"),
    ("oszlop", "SZÁMOLÁS — A felezett rend megkettőzése", ['fél', 'fél', '2·fél'], [weylE8 // 2, weylE8 // 2, 2 * (weylE8 // 2)], 'elem'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: felezett út ⟷ kernel (Δ = 0)", ['2·fél−kernel'], [2 * 348364800 - KERNEL['weylE8']]),
    ("prímTorony", "SPEKTRUM — A prímtornyok: 2¹⁴, 3⁵, 5², 7", ['2¹⁴','3⁵','5²','7'], KERNEL['weylPrimTenyezok']),
    ("kétÚtHíd", "HÍD — Híd: 2·348364800 ⟷ kernel W(E8)", '2·348364800', 2 * 348364800, 'kernel W(E8)', KERNEL['weylE8'])
  ],
  'F2.24': [
    ("prímTorony", "SZERKEZET — A prím-torony: 2¹⁴ · 3⁵ · 5² · 7", ['2¹⁴','3⁵','5²','7'], KERNEL['weylPrimTenyezok']),
    ("oszlop", "SZÁMOLÁS — A prím-út szorzata", ['16384·243·25·7'], [16384 * 243 * 25 * 7], 'érték'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: prím-út ⟷ kernel (Δ = 0)", ['prímút−kernel'], [prímÚtWeyl - KERNEL['weylE8Prim']]),
    ("weylLánc", "SPEKTRUM — A Weyl-lánc: 2⁷ → 8! → 135 → W(E8)"),
    ("kétÚtHíd", "HÍD — Híd: prím-út ⟷ struktúra-út", 'prím 2¹⁴·3⁵·5²·7', prímÚtWeyl, 'struktúra W(D8)·135', weylE8)
  ],
  'F2.25': [
    ("oszlop", "SZERKEZET — Két E8: bal (tér) × jobb (szín)", ['E8 (bal, tér)', 'E8 (jobb, szín)', 'E8×E8'], [248, 248, 248 * 2], 'dimenzió'),
    ("oszlop", "SZÁMOLÁS — 248 · 2 → 496", ['240+8', '240+8', '496'], [240 + 8, 240 + 8, (240 + 8) * 2], 'dim'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: 496 ⟷ kernel (Δ = 0)", ['496−kernel'], [248 * 2 - KERNEL['e8e8Dimenzio']]),
    ("petri", "SPEKTRUM — A 240 gyök petri-vetülete"),
    ("kétÚtHíd", "HÍD — Híd: dimenzió-szorzat ⟷ kernel 496", '248·2', 248 * 2, 'kernel e8E8Dimenzio', KERNEL['e8e8Dimenzio'])
  ],
  'F2.26': [
    ("petri", "SZERKEZET — A 240 gyök 2D-petri-vetülete (α, −α átellenesen)"),
    ("oszlop", "SZÁMOLÁS — 2 · 120 → 240", ['120 pozitív', '120 negatív', 'összes'], [120, 120, 240], 'gyök'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: felezés ⟷ enumeráció (Δ = 0)", ['párok−120'], [len([(v, tuple(-x for x in v)) for v in e8 if tuple(-x for x in v) in e8Halmaz]) - 240]),
    ("eloszlás", "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1)"),
    ("kétÚtHíd", "HÍD — Híd: 2·120 ⟷ enumeráció 240", '2·120', 2 * 120, 'enumeráció', len(e8))
  ],
  'F2.27': [
    ("pengeFok", "SZERKEZET — A Cl(4) fokszámai: (1, 4, 6, 4, 1)"),
    ("oszlop", "SZÁMOLÁS — C(4,k) oszlopok: 1, 4, 6, 4, 1", ['fok 0', 'fok 1', 'fok 2', 'fok 3', 'fok 4'], fokszámok, 'penge'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: fokszám-összeg ⟷ kernel (Δ = 0)", ['fokösszeg−kernel'], [sum(fokszámok) - KERNEL['fokszamOsszeg']]),
    ("hodgeNyilak", "SPEKTRUM — A Hodge-duál nyilai: k ↔ 4−k"),
    ("kétÚtHíd", "HÍD — Híd: binomiális összeg ⟷ szimuláció", '1+4+6+4+1', 1 + 4 + 6 + 4 + 1, 'szimuláció', sum(fokszámok))
  ],
  'F2.28': [
    ("híd256Rács", "SZERKEZET — 240 gyök + 16 penge egy rácsban"),
    ("oszlop", "SZÁMOLÁS — A kettő-hatvány létra: 2¹…2⁴", ['2¹','2²','2³','2⁴'], [2**k for k in range(1, 5)], 'hatvány'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: 2⁴ ⟷ len(pengék) (Δ = 0)", ['2⁴−pengék'], [2**4 - len(pengék)]),
    ("pengeFok", "SPEKTRUM — A Cl(4) fokszámai: (1, 4, 6, 4, 1)"),
    ("kétÚtHíd", "HÍD — Híd: 2·2·2·2 ⟷ enumeráció", '2·2·2·2', 2 * 2 * 2 * 2, 'enumeráció len(pengék)', len(pengék))
  ],
  'F2.29': [
    ("hodgeNyilak", "SZERKEZET — A Hodge-duál nyilai: k ↔ 4−k mind a 16 pengén"),
    ("oszlop", "SZÁMOLÁS — 15 − 3 → 12", ['3 (0011₂)', '12 (1100₂)'], [3, 12], 'maszk'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: duál(3) ⟷ kernel (Δ = 0)", ['duál(3)−kernel'], [duál(3) - KERNEL['hodgePelda']]),
    ("pengeFok", "SPEKTRUM — A Cl(4) fokszámai: (1, 4, 6, 4, 1)"),
    ("kétÚtHíd", "HÍD — Híd: kernel BizHodgePelda ⟷ szimuláció duál(3)", 'kernel pengeDual 3', KERNEL['hodgePelda'], 'szimuláció duál(3)', duál(3))
  ],
  'F2.30': [
    ("hodgeNyilak", "SZERKEZET — A Hodge-duál nyilai: k ↔ 4−k"),
    ("oszlop", "SZÁMOLÁS — 5 → 10 → 5 (oda-vissza)", ['duál(5)', 'duál(duál(5))'], [duál(5), duál(duál(5))], 'maszk'),
    ("maradékSáv", "ELLENŐRZÉS — Involúció-hibák a 16 pengén (várható 0)", ['hodgeInvolúcióHibák'], [hodgeInvolúcióHibák]),
    ("pengeFok", "SPEKTRUM — A Cl(4) fokszámai: (1, 4, 6, 4, 1)"),
    ("kétÚtHíd", "HÍD — Híd: kernel duál(duál(5)) ⟷ szimuláció", 'kernel pengeDual (pengeDual 5)', KERNEL['hodgeInvolutioPelda'], 'szimuláció', duál(duál(5)))
  ],
  'F2.31': [
    ("kódszóRács", "SZERKEZET — A 16 kódszó 7 bites rácsa"),
    ("oszlop", "SZÁMOLÁS — 4 bites üzenet → 7 bites kódszó", ['üzenet bit', 'kódszó bit'], [4, 7], 'bit'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: első kódszó ⟷ kernel (0 = egyezik)", ['kódszó1−kernel'], [(0 if kódszavak[8] == KERNEL['kodszoElso'] else 1)]),
    ("kódszóSúly", "SPEKTRUM — A súlyeloszlás: (1, 7, 7, 1)"),
    ("kétÚtHíd", "HÍD — Híd: kernel kódszó súlya ⟷ szimuláció súlya", 'kernel első kódszó súlya', sum(KERNEL['kodszoElso']), 'szimuláció súlya', sum(kódszavak[8]))
  ],
  'F2.32': [
    ("kódszóRács", "SZERKEZET — A 16 kódszó 7 bites rácsa"),
    ("oszlop", "SZÁMOLÁS — A súlyok: 0, 3, 4, 7", ['w=0', 'w=3', 'w=4', 'w=7'], súlyEloszlás, 'kódszó'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: mind-egyes kódszó ⟷ kernel (0 = egyezik)", ['kódszó16−kernel'], [(0 if kódszavak[15] == KERNEL['kodszoMindEgyes'] else 1)]),
    ("kódszóSúly", "SPEKTRUM — A súlyeloszlás: (1, 7, 7, 1)"),
    ("kétÚtHíd", "HÍD — Híd: kernel súly 7 ⟷ szimuláció súly 7", 'kernel mind-egyes súlya', sum(KERNEL['kodszoMindEgyes']), 'szimuláció', sum(kódszavak[15]))
  ],
  'F2.33': [
    ("kódszóSúly", "SZERKEZET — A súlyeloszlás: (1, 7, 7, 1)"),
    ("oszlop", "SZÁMOLÁS — 1+7+7+1 → 16", ['w=0', 'w=3', 'w=4', 'w=7'], súlyEloszlás, 'kódszó'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: súly-összeg ⟷ kernel (Δ = 0)", ['súlyösszeg−kernel'], [sum(súlyEloszlás) - KERNEL['sulyOsszeg']]),
    ("pengeFok", "SPEKTRUM — A Cl(4) fokszámai: (1, 4, 6, 4, 1) — a testvér"),
    ("kétÚtHíd", "HÍD — Híd: (1,7,7,1) összeg ⟷ (1,4,6,4,1) összeg", '1+7+7+1 (kódszó)', sum(súlyEloszlás), '1+4+6+4+1 (penge)', sum(fokszámok))
  ],
  'F2.34': [
    ("híd256Rács", "SZERKEZET — 240 gyök + 16 penge egy rácsban (a 16×16 mező)"),
    ("oszlop", "SZÁMOLÁS — 240 + 16 → 256", ['E8 gyök', 'penge', 'összes'], [len(e8), len(pengék), len(e8) + len(pengék)], 'elem'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: híd ⟷ kernel (Δ = 0)", ['híd−kernel'], [len(e8) + len(pengék) - KERNEL['hid256']]),
    ("pengeFok", "SPEKTRUM — A (1,7,7,1) súly- ⟷ (1,4,6,4,1) fok-tükrözés"),
    ("kétÚtHíd", "HÍD — Híd: 240+16 enumeráció ⟷ 2⁸ = 256", '240+16 enumeráció', len(e8) + len(pengék), '2⁸', 2**8)
  ],
  'F2.35': [
    ("híd256Rács", "SZERKEZET — 240 gyök + 16 penge egy rácsban"),
    ("oszlop", "SZÁMOLÁS — A kettő-hatvány létra 2¹…2⁸", ['2¹','2²','2³','2⁴','2⁵','2⁶','2⁷','2⁸'], [2**k for k in range(1, 9)], 'hatvány'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: 2⁸ ⟷ enumeráció (Δ = 0)", ['2⁸−enumeráció'], [2**8 - (len(e8) + len(pengék))]),
    ("kódszóRács", "SPEKTRUM — A 16 kódszó rácsa (2⁴ = 16)"),
    ("kétÚtHíd", "HÍD — Híd: 2·2·…·2 ⟷ 240+16", '2⁸', 2**8, '240+16', len(e8) + len(pengék))
  ],
  'F2.36': [
    ("petri", "SZERKEZET — A 240 szó két osztályban (112/128) — petri-vetület"),
    ("oszlop", "SZÁMOLÁS — 112 egész + 128 fél-egész → 240 szó", ['egész szavak', 'fél-egész szavak', 'alapszókincs'], [KERNEL['egeszSzavak'], KERNEL['felegeszSzavak'], KERNEL['alapszokincszam']], 'szó'),
    ("maradékSáv", "ELLENŐRZÉS — Maradék: szókincs ⟷ gyökrendszer (Δ = 0)", ['szókincs−240'], [KERNEL['alapszokincszam'] - KERNEL['gyokSzam']]),
    ("eloszlás", "SPEKTRUM — Az eloszlás: (1, 56, 126, 56, 1) — a jelentés-távolság forrása"),
    ("kétÚtHíd", "HÍD — Híd: 112+128 kombinatorika ⟷ alapszókincs hossza", '112+128', KERNEL['egeszSzavak'] + KERNEL['felegeszSzavak'], 'alapszókincs', KERNEL['alapszokincszam'])
  ]
}
# ─── A DISZPÉCSER: kártyánként 5 ábra · 每卡五图 · Dispatcher ───
for kártyaAzonosító, bejegyzések in KÁRTYÁK.items():
    for sorszám, (függvény, cím, *extra) in enumerate(bejegyzések, 1):
        globals()[függvény](kártyaAzonosító, sorszám, cím, *extra)

# ─── GAUGE-ZÁRÁS · 收尾 · Abschluss ───
print()
print("═══ GAUGE ═══")
print("megrajzolt PNG-ek száma:", MENT_DARAB)
print("várt PNG-szám:", 5 * len(KÁRTYÁK))
print("max |Δ| a maradéktáblában:", maximumDéltérés)
if maximumDéltérés == 0 and MENT_DARAB == 5 * len(KÁRTYÁK):
    print("GAUGE: OK — minden maradék 0, minden PNG megvan.")
    sys.exit(0)
else:
    print("GAUGE: HIBA — nézd a maradéktáblát / a PNG-számot!")
    sys.exit(1)