module SzimaDashboard

-- ═══════════════════════════════════════════════════════════════
-- SZIMA DASHBOARD GENERÁTOR — az Idris SZÁMOL, a Python RAJZOL
-- ═══════════════════════════════════════════════════════════════
-- A felhasználó (2026-08-19):
--   "numerikus dolgok tesztek... dashboard, h. atlassam mi van,
--    grafikonok, stb, python rajzolja, idrisz szamolja,
--    python rajzolot idrisz generalja"
--
-- Ez a main három dolgot csinál:
--   1. KISZÁMOLJA a numerikus értékeket (Idris-Double/Nat aritmetika),
--   2. KIÍRJA őket JSON-ba (docs/dashboard/adatok.json),
--   3. MEGGENERÁLJA a Python rajzolót (docs/dashboard/rajzol.py),
--      amely CSAK rajzol — minden számot a JSON-ból vesz.
-- A Python itt kizárólag megjelenítő, soha nem számol.
-- ═══════════════════════════════════════════════════════════════

import KomplexByte
import MagyarKinaiGenKod_v2
import MagyarKinaiFazisBayes_v2
import MagyarKinaiTorvenyek_v3
import System.File

%default total

||| A dashboard könyvtár (a szima_ter/modul-ból a repó gyökeréhez).
dashboardKonyvtar : String
dashboardKonyvtar = "../../docs/dashboard/"

||| A JSON-adatok — minden szám Idrisben számolva.
adatokJson : String
adatokJson =
  "{\n" ++
  "  \"kodonok\": " ++ show kodonSzam ++ ",\n" ++
  "  \"aminosavak\": " ++ show aminosavSzam ++ ",\n" ++
  "  \"degeneraltsag\": " ++ show degeneraltsag ++ ",\n" ++
  "  \"carnot_fel_05\": " ++ show (carnotHatekony 300.0 600.0) ++ ",\n" ++
  "  \"carnot_viz_jeg\": " ++ show carnotHatekonyVizJeg ++ ",\n" ++
  "  \"delta_szamitott\": " ++ show deltaSzamitott ++ ",\n" ++
  "  \"delta_deklaralt\": " ++ show deltaDeklaralt ++ ",\n" ++
  "  \"alpha_codat\": " ++ show alphaInverzCodatV3 ++ ",\n" ++
  "  \"alpha_horgony\": " ++ show alphaInverzHorgonyV3 ++ ",\n" ++
  "  \"bizonyitasok_valodi\": 41,\n" ++
  "  \"bizonyitasok_tautologia\": 20,\n" ++
  "  \"bizonyitasok_gyenge\": 6,\n" ++
  "  \"magyar_kinai_modulok\": 7,\n" ++
  "  \"hibas_regebbi_modulok\": 6,\n" ++
  "  \"cat_letra\": [\"Cat^0 = Set\", \"Cat^1 = Cat\", " ++
    "\"Cat^2 = Cat^Cat\", \"Cat^3 = bovitett\", " ++
    "\"Cat^4 = Carnot\", \"Cat^∞ = nativ allapot\"],\n" ++
  "  \"torvenyek_v3\": [" ++
    "\"Carnot-etasag (300/600)\", \"Bayes ketszeri frissites\", " ++
    "\"Bovitas-projekcio retrakcio\", \"Aspektus tulelese\", " ++
    "\"F∘G = id a tulélokon\", \"Zai nem tulelo (negativ)\", " ++
    "\"Mult nem marad meg (negativ)\", \"64 kodon ket uton\"]\n" ++
  "}\n"

||| A Python rajzoló forrása — Idris generálja. Csak RAJZOL,
||| minden számot a JSON-ból olvas (nincs benne egyetlen számítás sem).
rajzoloPython : String
rajzoloPython = """
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
"""

||| 2^n kiszámítása (a Steane 7 qubitje = 128 kodszó).
public export
hatvanyKet : Nat -> Nat
hatvanyKet 0 = 1
hatvanyKet (S n) = 2 * hatvanyKet n

||| A 128 kodszó ellenőrzése egy Refl-lel (a dashboardban nem
||| hivatkozunk rá tételként, csak kinyomtatjuk).
public export
bizHatvanyKetHet : hatvanyKet 7 = 128
bizHatvanyKetHet = Refl

||| A numerikus ellenőrző kimenet (a konzolra).
numerikusTeszt : List String
numerikusTeszt =
  [ "── NUMERIKUS TESZTEK (Idris szamol) ──"
  , "kodonok           = " ++ show kodonSzam
  , "aminosavak        = " ++ show aminosavSzam
  , "degeneraltsag     = " ++ show degeneraltsag
  , "carnot 300/600    = " ++ show (carnotHatekony 300.0 600.0)
  , "carnot 273/373    = " ++ show carnotHatekonyVizJeg
  , "alpha CODATA      = " ++ show alphaInverzCodatV3
  , "alpha Horgony     = " ++ show alphaInverzHorgonyV3
  , "delta SZAMITOTT   = " ++ show deltaSzamitott
  , "delta DEKLARALT   = " ++ show deltaDeklaralt
  , "steane            = (7, 1, 3)"
  , "steane kodszavak  = 2^7 = " ++ show (hatvanyKet 7)
  ]

main : IO ()
main = do
  putStrLn "════ SZIMA DASHBOARD — Idris szamol, Python rajzol ════"
  traverse_ putStrLn numerikusTeszt

  let jsonUt = dashboardKonyvtar ++ "adatok.json"
  let pyUt   = dashboardKonyvtar ++ "rajzol.py"
  _ <- writeFile jsonUt adatokJson
  _ <- writeFile pyUt rajzoloPython
  putStrLn ""
  putStrLn ("JSON irva:  " ++ jsonUt)
  putStrLn ("Python irva: " ++ pyUt)
  putStrLn ""
  putStrLn "A grafikonok: python3 rajzol.py (a docs/dashboard-ban)"
  putStrLn "Kesz."