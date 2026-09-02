# Kutatási napló — 2026-09-02 — Magyar helyesírási szótár letöltése (hunspell hu_HU)

## A feladat (szó szerint, a felhasználótól)

„Kutatás-futtató al-ágens vagy. A feladatod: keresd meg a magyar helyesírási
szótár letölthető változatát, és töltsd le a projektbe."

Célkönyvtár: `/Users/joco/opencode/trail_index/szotar/` (létrehozva, mert nem létezett).

## Végrehajtott lépések

1. **Keresés (§N12 — keress a neten mielőtt cselekszel):** brave web-keresés a
   hunspell hu_HU forrásokra → a kanonikus forrás a LibreOffice/dictionaries
   repó `hu_HU` alkönyvtára (Németh László magyarispell 1.9, AkH.12 szerinti).
2. **Letöltés (bash + curl, PYTHON TILOS §N8 betartva):**
   - `curl -sL -o hu_HU.dic https://raw.githubusercontent.com/LibreOffice/dictionaries/master/hu_HU/hu_HU.dic`
   - `curl -sL -o hu_HU.aff …/hu_HU.aff`
   - `curl -sL -o README_hu_HU.txt …/README_hu_HU.txt`
3. **Verifikáció (§N14 szellemében):**
   - `wc -l`: hu_HU.dic = 97 582 sor; hu_HU.aff = 54 141 sor.
   - `head -1 hu_HU.dic` = `97663` (deklarált szószám).
   - `file`: UTF-8 szöveges fájlok (1,8 MB + 2,3 MB — a 10 MB-os határ alatt).
   - `grep`: ékezetes szavak ellenőrizve — virágfüzér, rózsafüzér,
     egybefűzés, átdolgozó, átdolgozás.
4. **MTA-portál ellenőrzése (helyesiras.mta.hu):** web2py-alapú, online
   lekérdezéses portál; letölthető szólista/API NINCS, csak eszközök
   (Külön vagy egybe?, Helyes-e így?, Névkereső, Elválasztás, Számok,
   Dátumok, Ábécébe rendezés) + beágyazható widget. Scrapelni nem kellett
   (és a felhasználási feltételek miatt kerültük); egy-két minta-lekérdezés
   megtörtént (ez megengedett).
5. **Minta-lekérdezések eredménye (helyesiras.mta.hu, „Helyes-e így?"):**
   - „füzér” → **helyes**
   - „átdolgoz” → **helyes**
   - „fűzés” → **helyes**
6. **GitHub-AkH-szólista-keresés:** nincs érdemes önálló AkH.12-szólista a
   GitHubon; maga a magyarispell/hunspell AZ AkH.12-szótár gépi változata
   (FSF.hu-támogatott frissítés). Harmadik féltől származó tükör:
   wachin/libreoffice-dictionaries-collection (redundáns).
7. **Dokumentáció:** `trail_index/szotar/lepes-szotar-README.md` megírva
   magyarul (forrás, licenc, méretek, minta-szavak, formátum-megjegyzések).

## Eredmények (fájlok a trail_index/szotar/ könyvtárban)

| Fájl | Méret | Sorok |
|---|---|---|
| hu_HU.dic | 1 786 144 bájt | 97 582 (szószám: 97 663) |
| hu_HU.aff | 2 316 267 bájt | 54 141 |
| README_hu_HU.txt | 1 190 bájt | 31 |
| lepes-szotar-README.md | saját dokumentáció | — |

## Licenc

MPLv2 vagy LGPLv3+ (kettős), (c) Németh László és Godó Ferenc, 2025 —
szabadon terjeszthető szöveges fájlok, garancia nélkül.

## Tanulság (§N9 — magyar helyesírás)

A projekt korábbi commitjai (Fűzér→Füzér átnevezés) miatt kulcsfontosságú,
hogy a hivatalos MTA-s szótár szerint „füzér” (rövid ü) a helyes alak —
a hunspell-szótár is ezt tartja (`virágfüzér`, `rózsafüzér`).

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
