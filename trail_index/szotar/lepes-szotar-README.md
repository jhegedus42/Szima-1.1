# Magyar helyesírási szótár (hunspell hu_HU) — letöltési dokumentáció

| Fájl | Méret | Sorok (wc -l) | Tartalom |
|---|---|---|---|
| `hu_HU.dic` | 1 786 144 bájt (~1,8 MB) | 97 582 | a szótár: az első sor a deklarált szószám (97 663), utána a szavak `/affix-kód` alakban |
| `hu_HU.aff` | 2 316 267 bájt (~2,3 MB) | 54 141 | affix-szabályok (ragozás, képzés, morfológiai adatok) |
| `README_hu_HU.txt` | 1 190 bájt | 31 | az eredeti (magyar + angol) licenc-leírás |

## Forrás (letöltve: 2026-09-02)

- LibreOffice dictionaries-repo, `hu_HU` alkönyvtár:
  - https://github.com/LibreOffice/dictionaries/tree/master/hu_HU
  - raw URL-ek: `https://raw.githubusercontent.com/LibreOffice/dictionaries/master/hu_HU/hu_HU.dic` stb.
- Ez Németh László **magyarispell** projektjének hivatalos tükre:
  https://github.com/laszlonemeth/magyarispell (honlap: http://magyarispell.sf.net)
- Verzió: **1.9**, morfológiai adatokkal; az AkH. 12. (2015) szerint — a frissítését
  az FSF.hu Alapítvány támogatta.

## Licenc

- **MPLv2 vagy LGPLv3+** (kettős licenc, a LibreOffice projekt részeként),
  mindenféle garancia nélkül.
- (c) Németh László és Godó Ferenc, 2025.
- Teljes szöveg: `README_hu_HU.txt` (magyarul és angolul).

## Formátum-megjegyzések

- A `.dic` első sora a szószám: **97 663**; a fájl tényleges sorszáma 97 582
  (több szavas szócikkek és tabbal elválasztott morfológiai mezők vannak).
- A szó után a `/` jel utáni szám affix-kód (pl. `üzlet/1`), a tab utáni mezők
  morfológiai/adatmezők.
- Mindkét fájl UTF-8 szöveg (a `file` parancs szerint: „Unicode text, UTF-8 text").

## Minta-szavak a szótárból (ékezetes, grep-pel ellenőrizve)

1. `virágfüzér/4`
2. `rózsafüzér/26`
3. `egybefűzés/4`
4. `átdolgozó/42`
5. `átdolgozás/14`
6. `üzembe helyezés/10`
7. `üzlethelyiség/4`
8. `üzenet/1`

## Az MTA hivatalos portálja (helyesiras.mta.hu) — nem letölthető

- A **Helyesírási tanácsadó szótár és portál** (AkH.12, MTA Nyelvtudományi
  Intézet) **online lekérdezéses** webalkalmazás (web2py), letölthető
  szólistát vagy API-t **nem** kínál; csak eszközönkénti lekérdezés
  (`suggest?q=…`, `kulegy`, `predict`, `hyph`, `numerals`, `dates`,
  `akhsort`), valamint beágyazható widget webmestereknek.
- Minta-lekérdezések (2026-09-02):
  - „füzér” → **helyes**
  - „átdolgoz” → **helyes**
  - „fűzés” → **helyes**
- Ezért a projektben a hunspell-fájl a kanonikus, gépi szótár-forrás.

## Kapcsolódó (nem letöltött) források

- https://github.com/laszlonemeth/magyarispell — az eredeti forrásrepo (make-jal
  generálható állományok; a LibreOffice-tükör kész build-jét töltöttük le).
- https://sourceforge.net/projects/magyarispell/ — örökölt SourceForge-oldal.
- https://github.com/wachin/libreoffice-dictionaries-collection — harmadik féltől
  származó tükör-gyűjtemény (LibreOffice 25.2.3), redundáns, nem erre van szükség.
