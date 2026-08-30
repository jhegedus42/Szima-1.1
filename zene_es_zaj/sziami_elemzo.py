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
DALOK = [    ("Testből testbe", "sziami_testbol_testbe.wav", "https://www.youtube.com/watch?v=p0xd7u_0bnQ", 10, 9),
    ("Világegyetemista", "sziami_vilagegyetemista.wav", "https://www.youtube.com/watch?v=ugLBPh28xeM", 0, 0),
    ("Olyan vagy!!!", "sziami_olyan_vorang.wav", "https://www.youtube.com/watch?v=YtpSzXRvm-4", 0, 0),
    ("Hungarikum", "sziami_hungarikum.wav", "https://www.youtube.com/watch?v=J0XRj-Kj21w", 12, 11),
    ("Zuhanórepülés", "sziami_zuhanorepules.wav", "https://www.youtube.com/watch?v=HFWpxyimOh0", 0, 0),
    ("Apokalipszis itt és most", "sziami_apokalipszis.wav", "https://www.youtube.com/watch?v=t9edrlbkYYo", 0, 0),
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