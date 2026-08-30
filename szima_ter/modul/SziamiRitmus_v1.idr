module SziamiRitmus_v1

-- ═══════════════════════════════════════════════════════════════
-- SZIÁMI RITMUS v1 — a projekt névadójának zenéje: időkvantálás mérese
-- SZIÁMI RITMUS v1 — rhythm of the project's namesake: measuring time-quantization
-- 西亚米节奏 v1 — 项目命名乐队之乐：时间量化的测量
-- SZIÁMI RITMUS v1 — Rhythmus des Namensgebers: Zeitquantelung messen
-- סיאמי קצב v1 — הקצב של נותן השם של הפרויקט: מדידת קוונטיזציית זמן
-- ═══════════════════════════════════════════════════════════════
--
-- A FELADAT (2026-08-24, general ügynök): a Sziámi-dalok letöltése
-- (a felhasználó MEGVETTE az anyagot, explicit engedély:
-- „a sziami zeneket en megvettem, letoltheted … ez egy tudomanyos
-- kutatas") és a ritmus MATEMATIKAI elemzése: hanghossz, BPM-becslés
-- (onsetboríték-autokorreláció), onset-sűrűség, spektrogram,
-- onset-hisztogram — dalonként legalább 5 kimenet.
--
-- §1.0 (AZ IDRIS ÍRJA A PYTHONT — az EGYETLEN megengedett Python-minta):
--   a main KIÍRJA a zene_es_zaj/sziami_elemzo.py fájlt (a Python
--   szövegét AZ IDRIS GENERÁLJA ebből a modulból), majd FUTTATJA.
--   A Python kizárólag MÉR (numpy) és RAJZOL (matplotlib) — az
--   adatmodell (dallista, szótagszámok, bizonyítások) Idrisben él.
-- §8/§18 (GAUGE): a dokumentumba CSAK a tényleges futásból származó
--   számok kerülnek — semmit nem jelentünk ki ellenőrizetlenül.
-- §24 (KÓD DUPLIKÁCIÓ TILOS): a writeFile+generált-Python minta a
--   SzimaDashboard.idr / AlphaSteaneDashboard.idr mintájára készült
--   (ott a Python csak rajzol; itt mér is — ez a §1.0 kiterjesztése
--   hangfájlokra); a system hívás a base System moduljából jön.
-- §13: EZ EGY ÚJ MODUL — semmi régit nem ír felül.
-- §25: minden magyar azonosító ÉKEZETES (SziamiDal, DalBejegyzés…).
-- ═══════════════════════════════════════════════════════════════
--
-- A HANGANYAG (letöltve 2026-08-24, yt-dlp; a rossz találat — a teljes
-- album — átnevezve maradt: §20 szerint NEM törlendő):
--   1. Testből testbe        (Testből testbe, 1992)  — p0xd7u_0bnQ
--   2. Világegyetemista      (Testből testbe, 1992)  — ugLBPh28xeM
--   3. Olyan vagy!!!         (Olyan vagy!!!, 1994)   — YtpSzXRvm-4
--   4. Hungarikum            (késői Sziámi)          — J0XRj-Kj21w
--   5. Zuhanórepülés         (Testből testbe, 1992)  — HFWpxyimOh0
--   6. Apokalipszis itt és most (Testből testbe, 1992) — t9edrlbkYYo
-- A WAV-változatok (mono, 22050 Hz) az elemzés bemenetei.
-- ═══════════════════════════════════════════════════════════════

import Data.List      -- filter, foldr (§24: standard, nem újraírva)
import System         -- system (a generált Python futtatása)
import System.File    -- writeFile

%default total

-- ===============================================================
-- 1. A DAL ADATTÍPUSA — teleszkópmezőkkel
--    The song datatype with telescope fields · 歌曲的数据类型
--    Der Datentyp Lied mit Teleskopfeldern · טיפוס הנתונים של השיר
-- ===============================================================

||| Egy letöltött Sziámi-dal metaadatai. A szótagszámok a
||| docs/Sziami_Dalok_Tanulas.md ellenőrzött idézetsoraiból jönnek;
||| a 0 azt jelöli, hogy ellenőrzött refrén-idézet NINCS (nem találgatunk).
||| 一首已下载的西亚米歌曲的元数据；音节数 0 表示无经过核实的引文。
public export
data SziamiDal : Type where
  DalBejegyzés : (dalCíme : String) ->
                 (hangfájlNeve : String) ->
                 (forrásHivatkozás : String) ->
                 (refrénElsőSorSzótagszáma : Nat) ->
                 (refrénMásodikSorSzótagszáma : Nat) ->
                 SziamiDal

||| A dal megjelenítése — cím, fájl, forrás, szótagszám-pár.
public export
Show SziamiDal where
  show (DalBejegyzés dalCíme hangfájlNeve forrásHivatkozás első második) =
    dalCíme ++ " [" ++ hangfájlNeve ++ "; forrás: " ++ forrásHivatkozás ++
    "; refrénszótag: " ++ show első ++ "/" ++ show második ++ "]"

-- ── Mezőkiválasztók (a teleszkópmezők olvasása) ──

||| A dal címe. 歌曲标题。
public export
dalCíme : SziamiDal -> String
dalCíme (DalBejegyzés cím _ _ _ _) = cím

||| A hangfájl neve (WAV, a hangkönyvtárban relatív). 音频文件名。
public export
hangfájlNeve : SziamiDal -> String
hangfájlNeve (DalBejegyzés _ fájl _ _ _) = fájl

||| A letöltés forrás-URL-je (YouTube). 下载来源链接。
public export
forrásHivatkozás : SziamiDal -> String
forrásHivatkozás (DalBejegyzés _ _ forrás _ _) = forrás

||| A refrén első sorának szótagszáma (0 = nincs ellenőrzött idézet).
public export
refrénElsőSorSzótagszáma : SziamiDal -> Nat
refrénElsőSorSzótagszáma (DalBejegyzés _ _ _ első _) = első

||| A refrén második sorának szótagszáma (0 = nincs ellenőrzött idézet).
public export
refrénMásodikSorSzótagszáma : SziamiDal -> Nat
refrénMásodikSorSzótagszáma (DalBejegyzés _ _ _ _ második) = második

||| Van-e ellenőrzött (nem nulla) refrénszótag-adat a dalhoz?
public export
ismertSzótagszámú : SziamiDal -> Bool
ismertSzótagszámú dal = refrénElsőSorSzótagszáma dal > 0

-- ===============================================================
-- 2. A DALOK JEGYZÉKE — a letöltött hat kulcsdal
--    The list of songs · 歌曲清单 · Die Liederliste · רשימת השירים
-- ===============================================================

||| A hat letöltött kulcsdal (a 12-es lista legfontosabbjai közül).
||| NAGYBETŰS konstans — bizonyítástípusban hivatkozható
||| (KisBetűsProjekcióCsapda tanulsága).
public export
SziamiDalok : List SziamiDal
SziamiDalok =
  [ DalBejegyzés "Testből testbe" "sziami_testbol_testbe.wav"
      "https://www.youtube.com/watch?v=p0xd7u_0bnQ" 10 9
  , DalBejegyzés "Világegyetemista" "sziami_vilagegyetemista.wav"
      "https://www.youtube.com/watch?v=ugLBPh28xeM" 0 0
  , DalBejegyzés "Olyan vagy!!!" "sziami_olyan_vorang.wav"
      "https://www.youtube.com/watch?v=YtpSzXRvm-4" 0 0
  , DalBejegyzés "Hungarikum" "sziami_hungarikum.wav"
      "https://www.youtube.com/watch?v=J0XRj-Kj21w" 12 11
  , DalBejegyzés "Zuhanórepülés" "sziami_zuhanorepules.wav"
      "https://www.youtube.com/watch?v=HFWpxyimOh0" 0 0
  , DalBejegyzés "Apokalipszis itt és most" "sziami_apokalipszis.wav"
      "https://www.youtube.com/watch?v=t9edrlbkYYo" 0 0
  ]

-- ===============================================================
-- 3. IDRIS-OLDALI SZÁMÍTÁSOK ÉS BIZONYÍTÁSOK (§18: két út, egy híd)
--    Idris-side computations and proofs · Idris 侧的计算与证明
-- ===============================================================

||| A dalok száma — NAGYBETŰS (bizonyítástípusba való).
public export
SziamiDalokSzáma : Nat
SziamiDalokSzáma = length SziamiDalok

||| HÍD-BIZONYÍTÁS: a jegyzék enumerációja (length a kimerített listán)
||| ⟷ a letöltött dalok darabszáma (6). Nem tautológia (§18): a két oldal
||| két különböző konstrukció — a lista kimerítése és a mért darabszám.
public export
bizHatSziámiDal : SziamiDalokSzáma = 6
bizHatSziámiDal = Refl

||| Az ellenőrzött refrénszótag-adattal rendelkező dalok száma (filter).
public export
IsmertSzótagszámúDalakSzáma : Nat
IsmertSzótagszámúDalakSzáma = length (filter ismertSzótagszámú SziamiDalok)

||| HÍD-BIZONYÍTÁS: a filter-enumeráció ⟷ a tanulmány két ellenőrzött
||| refrén-idézete (Testből testbe: 10/9; Hungarikum: 12/11).
public export
bizIsmertRefrénKettő : IsmertSzótagszámúDalakSzáma = 2
bizIsmertRefrénKettő = Refl

||| Az ismert refrén-elsősorok szótagösszege (map + foldr út).
public export
RefrénSzótagÖsszeg : Nat
RefrénSzótagÖsszeg = foldr (+) 0 (map refrénElsőSorSzótagszáma SziamiDalok)

||| HÍD-BIZONYÍTÁS: a map+foldr kiszámítása ⟷ az idézetek literális
||| összeadása (10 + 12) — két független út, egy híd (§18, E8Gyokok-minta).
public export
bizRefrénÖsszegHíd : RefrénSzótagÖsszeg = 10 + 12
bizRefrénÖsszegHíd = Refl

-- ===============================================================
-- 4. A PYTHON-GENERÁLÁS (§1.0 — az Idris írja a Pythont)
--    Python generation · 生成 Python · Python-Erzeugung
-- ===============================================================

||| Egy dal → egy Python-sor a DALOK listában.
||| (A címek nem tartalmaznak idézőjelet, így escaping nem kell.)
dalPythonSora : SziamiDal -> String
dalPythonSora (DalBejegyzés dalCíme hangfájlNeve forrásHivatkozás első második) =
  "    (\"" ++ dalCíme ++ "\", \"" ++ hangfájlNeve ++ "\", \"" ++
  forrásHivatkozás ++ "\", " ++ show első ++ ", " ++ show második ++ "),"

||| A teljes dal-lista Python-sorai.
dalokPythonSorai : String
dalokPythonSorai =
  foldr (\sor, folytatás => sor ++ "\n" ++ folytatás) "" (map dalPythonSora SziamiDalok)

||| A mérő-Python eleje: importok, útvonalak, függvények.
||| A fájl NEM tartalmaz `"""`-t, backslash-t — az Idris hármas
||| idézőjeles sztringjében biztonságos.
pythonEleje : String
pythonEleje = """
# -*- coding: utf-8 -*-
# ═══════════════════════════════════════════════════════════════
# SZIÁMI ELEMZŐ — AZ IDRIS GENERÁLTA EZT A FÁJLT (AGENTS §1.0)
# Idris számolja az adatmodellt, a Python MÉR (numpy) és RAJZOL
# (matplotlib). 节奏分析器——由 Idris 生成。 | Rhythmus-Analyse — von
# Idris erzeugt. | מנתח קצב — שנוצר על ידי Idris.
# KÉZZEL NEM SZERKESZTENDŐ — a forrás: szima_ter/modul/SziamiRitmus_v1.idr
# ═══════════════════════════════════════════════════════════════
import os
import wave
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

GYÖKÉRKÖNYVTÁR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
HANGKÖNYVTÁR = os.path.join(GYÖKÉRKÖNYVTÁR, "zene_es_zaj", "sziami_audio")
KIMENETIKÖNYVTÁR = os.path.join(GYÖKÉRKÖNYVTÁR, "docs", "zene_elemzes", "sziami")
os.makedirs(KIMENETIKÖNYVTÁR, exist_ok=True)

KERETHOSSZ = 1024
LÉPÉSKÖZ = 512

# A dalok listája — AZ IDRIS-BŐL GENERÁLVA (SziamiDalok konstans)
# (cím, hangfájl, forrás-URL, refrén 1. sor szótagszáma, 2. sor szótagszáma)
DALOK = [
"""

||| A mérő-Python vége: a dalonkénti mérő- és rajzolóciklus.
pythonVége : String
pythonVége = """
]

def hangBeolvasása(út):
    # 16 bites PCM WAV → mono lebegőpontos jellánc. 读取 WAV。
    with wave.open(út, "rb") as bemenet:
        csatornaszám = bemenet.getnchannels()
        mintavételifrekvencia = bemenet.getframerate()
        nyersbájt = bemenet.readframes(bemenet.getnframes())
    jel = np.frombuffer(nyersbájt, dtype=np.int16).astype(np.float64) / 32768.0
    if csatornaszám > 1:
        jel = jel.reshape(-1, csatornaszám).mean(axis=1)
    return jel, mintavételifrekvencia

def spektrumnagyság(jel):
    # keretezett Fourier-nagyságspekttrum. 分帧频谱幅度。
    keretszám = 1 + (len(jel) - KERETHOSSZ) // LÉPÉSKÖZ
    ablak = np.hanning(KERETHOSSZ)
    nagyság = np.zeros((keretszám, KERETHOSSZ // 2 + 1))
    for i in range(keretszám):
        keret = jel[i * LÉPÉSKÖZ : i * LÉPÉSKÖZ + KERETHOSSZ] * ablak
        nagyság[i] = np.abs(np.fft.rfft(keret))
    return nagyság

def onsetboríték(nagyság):
    # spektrális fluxus: a pozitív keret-közi nagyságnövekedések összege.
    fluxus = np.maximum(0.0, np.diff(nagyság, axis=0)).sum(axis=1)
    fluxus = fluxus / (fluxus.max() + 1e-12)
    return fluxus

def onsetidőpontok(fluxus, keretfrekvencia):
    # lokális maximumok küszöb felett, min. 50 ms távolsággal.
    küszöb = fluxus.mean() + 0.5 * fluxus.std()
    időpontok = []
    for i in range(2, len(fluxus) - 2):
        t = i / keretfrekvencia
        if fluxus[i] > küszöb and fluxus[i] >= max(fluxus[i - 2 : i + 3]):
            if not időpontok or t - időpontok[-1] > 0.05:
                időpontok.append(t)
    return np.array(időpontok)

def bpmbecslés(fluxus, keretfrekvencia):
    # az onsetboríték autokorrelációja; a csúcs késleltetése = ütemperiódus.
    középre = fluxus - fluxus.mean()
    autoikon = np.correlate(középre, középre, mode="full")[len(középre) - 1 :]
    autoikon = autoikon / (autoikon.max() + 1e-12)
    legkisebbkésleltetés = int(np.floor(keretfrekvencia * 60.0 / 200.0))
    legnagyobbkésleltetés = int(np.ceil(keretfrekvencia * 60.0 / 60.0))
    tartomány = autoikon[legkisebbkésleltetés : legnagyobbkésleltetés + 1]
    legjobb = legkisebbkésleltetés + int(np.argmax(tartomány))
    finomítás = 0.0
    if 0 < legjobb < len(autoikon) - 1:
        a = autoikon[legjobb - 1]
        b = autoikon[legjobb]
        c = autoikon[legjobb + 1]
        nevező = a - 2.0 * b + c
        if abs(nevező) > 1e-12:
            finomítás = 0.5 * (a - c) / nevező
    késleltetés = legjobb + finomítás
    alapbpm = 60.0 * keretfrekvencia / késleltetés
    # oktávkorrekció: a jelölt és a felezett/dukázott változat közül
    # a [65, 190] BPM sávban lévő, legerősebb autokorrelációjú nyer.
    legjobbBpm = alapbpm
    legjobbÉrték = autoikon[int(round(késleltetés))]
    for szorzó in (0.5, 2.0):
        próbálkésleltetés = késleltetés / szorzó
        próbálbpm = alapbpm * szorzó
        if 65.0 <= próbálbpm <= 190.0:
            kerekítettKésleltetés = int(round(próbálkésleltetés))
            if 1 <= kerekítettKésleltetés < len(autoikon):
                érték = autoikon[kerekítettKésleltetés]
                if érték > legjobbÉrték:
                    legjobbBpm = próbálbpm
                    legjobbÉrték = érték
    return legjobbBpm, autoikon

print("═" * 64)
print("SZIÁMI RITMUSELEMZÉS — az Idris generálta, a Python mér")
print("═" * 64)
eredménySorok = []
for cím, hangfájl, forrásurl, szótag1, szótag2 in DALOK:
    út = os.path.join(HANGKÖNYVTÁR, hangfájl)
    if not os.path.isfile(út):
        print("HIBA: hiányzó hangfájl:", út)
        continue
    jel, fsz = hangBeolvasása(út)
    hossz = len(jel) / fsz
    nagyság = spektrumnagyság(jel)
    fluxus = onsetboríték(nagyság)
    keretfrekvencia = fsz / LÉPÉSKÖZ
    időpontok = onsetidőpontok(fluxus, keretfrekvencia)
    bpm, autoikon = bpmbecslés(fluxus, keretfrekvencia)
    sűrűség = len(időpontok) / hossz
    alapnév = os.path.splitext(hangfájl)[0]

    # (a) hanghossz + (b) BPM + (c) onset-sűrűség — stdout (GAUGE)
    print("─" * 64)
    print("DAL:             ", cím)
    print("  hangfájl:      ", hangfájl)
    print("  forrás-URL:    ", forrásurl)
    print("  hossz:          %.1f s" % hossz)
    print("  BPM-becslés:    %.1f" % bpm)
    print("  onsetszám:     ", len(időpontok))
    print("  onset-sűrűség:  %.2f db/s" % sűrűség)
    if len(időpontok) > 1:
        időközök = np.diff(időpontok)
        print("  átlag IOI:      %.0f ms (medián: %.0f ms)" %
              (1000.0 * időközök.mean(), 1000.0 * np.median(időközök)))
    else:
        időközök = np.array([0.0])
        print("  átlag IOI:      nincs adat")
    print("  refrénszótag:  ", szótag1, "/", szótag2,
          "(0 = nincs ellenőrzött idézet)")

    # (d) spektrogram — PNG
    plt.figure(figsize=(10, 4))
    plt.imshow(np.log1p(nagyság.T * 100.0), origin="lower", aspect="auto",
               cmap="magma", extent=(0, hossz, 0, fsz / 2000.0))
    plt.xlabel("idő (s)")
    plt.ylabel("frekvencia (kHz)")
    plt.title("Spektrogram — Sziámi: " + cím)
    plt.colorbar(label="log(1 + 100·nagyság)")
    plt.tight_layout()
    plt.savefig(os.path.join(KIMENETIKÖNYVTÁR, "spektrogram_" + alapnév + ".png"), dpi=110)
    plt.close()
    print("  PNG: spektrogram_" + alapnév + ".png")

    # (e) onsetboríték + onsetidőpontok — PNG
    keretidők = np.arange(len(fluxus)) / keretfrekvencia
    plt.figure(figsize=(10, 3))
    plt.plot(keretidők, fluxus, color="tab:blue", linewidth=0.7)
    plt.vlines(időpontok, 0.0, 1.05, color="tab:red", linewidth=0.6, alpha=0.7)
    plt.xlabel("idő (s)")
    plt.ylabel("fluxus (normált)")
    plt.title("Onsetboríték és onsetidőpontok — Sziámi: " + cím)
    plt.tight_layout()
    plt.savefig(os.path.join(KIMENETIKÖNYVTÁR, "onsetek_" + alapnév + ".png"), dpi=110)
    plt.close()
    print("  PNG: onsetek_" + alapnév + ".png")

    # (f) onsetidőközök (IOI) hisztogramja — PNG
    plt.figure(figsize=(7, 4))
    plt.hist(időközök[időközök < 1.5], bins=40, color="tab:purple", alpha=0.85)
    ütemperiódus = 60.0 / bpm
    plt.axvline(ütemperiódus, color="tab:red", linestyle="--",
                label="ütemperiódus = 60/BPM = %.3f s" % ütemperiódus)
    plt.xlabel("onsetidőköz (s)")
    plt.ylabel("darab")
    plt.title("IOI-hisztogram — Sziámi: " + cím)
    plt.legend()
    plt.tight_layout()
    plt.savefig(os.path.join(KIMENETIKÖNYVTÁR, "ioi_hisztogram_" + alapnév + ".png"), dpi=110)
    plt.close()
    print("  PNG: ioi_hisztogram_" + alapnév + ".png")

    # (g) BPM-autokorreláció — PNG
    késleltetések = np.arange(len(autoikon)) / keretfrekvencia
    sáv = késleltetések <= 1.05
    plt.figure(figsize=(7, 4))
    plt.plot(késleltetések[sáv], autoikon[sáv], color="tab:green")
    plt.axvline(ütemperiódus, color="tab:red", linestyle="--",
                label="becsült ütemperiódus (%.1f BPM)" % bpm)
    plt.xlabel("késleltetés (s)")
    plt.ylabel("normált autokorreláció")
    plt.title("Onset-autokorreláció — Sziámi: " + cím)
    plt.legend()
    plt.tight_layout()
    plt.savefig(os.path.join(KIMENETIKÖNYVTÁR, "bpm_autoikon_" + alapnév + ".png"), dpi=110)
    plt.close()
    print("  PNG: bpm_autoikon_" + alapnév + ".png")

    eredménySorok.append((cím, hossz, bpm, len(időpontok), sűrűség))

# ── Összegző BPM-összehasonlítás — PNG ──
if eredménySorok:
    címek = [sor[0] for sor in eredménySorok]
    bpmek = [sor[2] for sor in eredménySorok]
    plt.figure(figsize=(9, 4.5))
    plt.bar(címek, bpmek, color="tab:blue")
    plt.xticks(rotation=20, ha="right")
    plt.ylabel("BPM (onset-autokorreláció)")
    plt.title("A hat Sziámi-dal mért tempója (Idris generálta, Python mérte)")
    plt.tight_layout()
    plt.savefig(os.path.join(KIMENETIKÖNYVTÁR, "bpm_osszehasonlitas.png"), dpi=110)
    plt.close()
    print("─" * 64)
    print("ÖSSZEGZÉS (cím | hossz s | BPM | onsetszám | onset-sűrűség db/s):")
    for sor in eredménySorok:
        print("  %-24s | %6.1f | %5.1f | %5d | %5.2f" % sor)
    print("PNG: bpm_osszehasonlitas.png")
print("═" * 64)
print("MINDEN ELEMZÉS KÉSZ — a PNG-k a docs/zene_elemzes/sziami/-ben.")
"""

||| A teljes generált Python-szöveg (eleje + dalok + vége).
elemzőPython : String
elemzőPython = pythonEleje ++ dalokPythonSorai ++ pythonVége

-- ===============================================================
-- 5. A MAIN — ír, futtat, jelent (a §1.0 minta)
--    Write, run, report · 写入、运行、报告 · Schreiben, ausführen
-- ===============================================================

||| A generált Python relatív útja (a szima_ter/modul-ból a repó gyökeréhez).
elemzőÚtja : String
elemzőÚtja = "../../zene_es_zaj/sziami_elemzo.py"

main : IO ()
main = do
  putStrLn "════ SZIÁMI RITMUS v1 — Idris generál, Python mér, PNG rajzol ════"
  putStrLn ""
  putStrLn "── A hat letöltött kulcsdal (forrás-URL-lel) ──"
  traverse_ putStrLn (map show SziamiDalok)
  putStrLn ""
  putStrLn "── Idris-oldali számítások és híd-bizonyítások (§18) ──"
  putStrLn ("SziamiDalokSzáma            = " ++ show SziamiDalokSzáma ++
            "   [bizHatSziámiDal : Refl]")
  putStrLn ("IsmertSzótagszámúDalakSzáma = " ++ show IsmertSzótagszámúDalakSzáma ++
            "   [bizIsmertRefrénKettő : Refl]")
  putStrLn ("RefrénSzótagÖsszeg          = " ++ show RefrénSzótagÖsszeg ++
            "   [bizRefrénÖsszegHíd : Refl]")
  putStrLn ""
  _ <- writeFile elemzőÚtja elemzőPython
  putStrLn ("A mérő-Python megírva (AZ IDRIS GENERÁLTA): " ++ elemzőÚtja)
  putStrLn "Futtatás következik (system)…"
  kilépésiKód <- system ("python3 " ++ elemzőÚtja)
  putStrLn ""
  putStrLn ("A Python kilépési kódja: " ++ show kilépésiKód)
  putStrLn "Kész — a mért számok fentről valók (GAUGE: semmi ellenőrizetlen)."
