# Kutatási napló — 2026-09-01 (terv kiegészítve: 50→65 pont)

## A felhasználó kérdése (szó szerint, §N5)
- „nezessuk at GAN-nal, ami segitsen, hogy kiegeszitsuk a tervet (ne pedig elvegyen belole)" (többször is)

## Mit csináltunk

### 1. A GAN-bíráló (task-alügynök) átnézte a 50 pontos tervet
A GAN a tervet ERŐSNEK találta matematikailag (a Bergman-kernel, a Yoneda, a hiperbolikus beágyazás, a fixpont — valódi kutatási hozzájárulások), DE GYENGE gyakorlatilag:
- NINCS IO-réteg (a fájlolvasás hiánya — a mondatok hogyan kerülnek az indexbe?)
- NINCS metrika (NDCG, MAP, recall@k, MRR — a minőség OBJEKTÍV mérése)
- NINCS visszacsatolás (a felhasználó pontozza a találatokat → adaptív súlyok)
- NINCS hibatűrés az adatok szintjén (a hibás indexbejegyzések)
- NINCS verziókezelés (a szótár-változás → a régi index érvénytelenné válik)
- NINCS magánadat-kezelés (a Lumo-beszélgetések személyesek)
- NINCS online tanulás (az új szavak környezet-becslése)

### 2. 15 ÚJ pont (51-65) — a gyakorlati réteg pótlása
51. Idris IO-réteg (readFile, withFile)
52. Streamelt indexelés (batch=100 mondat, memória-takarékos)
53. Lemez-alapú index (a 16 klaszter mindegyike egy fájl, nem memóriában)
54. Keresési metrikák (NDCG, MAP, recall@k, MRR, precision@k)
55. Ground-truth építése (50 kérdés + várt találatok — reprodukálható teszt)
56. Relevancia-visszacsatolás (a felhasználó pontoz → adaptív IDF-súlyok)
57. Aktív tanulás (a rendszer kérdez: „melyik relevánsabb?")
58. Hibás bejegyzések detektálása (ismeretlen-szó arány > 50% → hibás)
59. Konfliktus-feloldás (forrás-súlyozás: Awodey=1.0, Lumo=0.8)
60. Szótár verziókezelése (diff-index: csak a változások újra-indexelése)
61. Klaszter-egyensúly mérése (a 16 klaszter varianciája, finom-felosztás)
62. Cache-elés (a Bergman-mag és a fixpont memoizációja)
63. Magyar hangrendszer (FanoParitás integrálás: mély/magas hangrend → a 5. dimenzió)
64. Magánadatok (szenzitivitás-jelölő + elfelejtés joga)
65. Online tanulás (környezet-becslés: új szó → szomszédok átlaga)

### 3. Sorrend-korrekció
- A 45. pont (könyvek) előbbre: a 21. (hierarchia) után — a könyv-index a hierarchia TESZTJE, nem az eredménye
- Az 51-52. (IO + stream) a 10-11. közé — mielőtt a tórusz jön, a mondatoknak be kell kerülniük
- Az 54-55. (metrikák) a 45. után — a könyv-indexen mérik a minőséget

## Push
- `8adbb0e` — terv kiegészítve: 50→65 pont (a GAN 15 új pontja + sorrend-korrekció)

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★