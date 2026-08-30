# Tanulság: a nagy-Nat kernel-csapda és az árva-chez csapda (2026-08-21)

## A jelenség / The phenomenon / 现象 / Das Phänomen / התופעה

Az `E8Gyokok.idr` (v1) `idris2 --check`-je 300+ másodperc után sem
fejeződött be — látszólag "lefagyott", 0,01s user-idővel (a bash-wrapper
szemszögéből). Valójában KÉT egymást fedő csapda volt.

## 1. csapda: a nagy szám Nat-ként (unáris kernel-normalizálás)

**Az Idris2 Nat-ja a kernellben UNÁRIS** (`S (S (... S Z))`). Egy
`bizWeyl : WeylE8Rend = 696729600` típusú Refl-bizonyítás a kernelt
~700 millió konstrukturális lépésre kényszeríti — órákig tart.

- MÉRÉS: `WeylD8 = 128 * Faktorialis 8` (5 160 960) Nat-ként már
  45 mp alatt SEM futott le (nagybetűs nevekkel, tényleges
  normalizálással). Integer-ként: 1,2 mp, hibátlanul.
- **Gyógyír: minden 10 000 fölötti számot bizonyításban INTEGER-ként
  írunk** (`Faktorialis : Nat -> Integer` mintája: `cast (S n)`).

## 2. csapda: a kisbetűs-csapda MÉRÉSI TORZÍTÁST okozott

A probe-ok (`weylD8Rend = 5160960` kisbetűvel) "gyorsan átestek" —
de csak azért, mert a kisbetűs konstans a bizonyítás típusában
implicit argumentummá kötődött be, és a Refl SOHA nem számolt.
**Ez a kisbetűs-csapda új arca: hamis negatív mérési eredményt ad
a teljesítmény-probe-okra.** A probe csak nagybetűs nevekkel érvényes.

## 3. csapda: az árva Chez-folyamat

Az `idris2` egy bash-wrapper, ami Chez-Scheme gyereket indít
(`/opt/homebrew/opt/chezscheme/bin/chez --program .../idris2.so`).
A `timeout` CSAK a wrappert öli meg; a chez gyerek árva folyamatként
(szülő = 1) 82% CPU-n tovább számol, és elnyeli a magot — a későbbi
futtatások "véletlenszerűen" lassulnak.

- **Gyógyír minden timeout után: `pkill -f "chez --program"`**
- Diagnosztika: `ps -ax -o pid,ppid,%cpu,command | grep chez`
  (a szülő = 1 árva folyamatokat keresve), `sample <pid>` a blokkolás
  helyére (`__wait4` = wrapper vár; magas CPU = gyerek számol).

## 4. csapda: a komprehenziós mintaillesztés nem fedő

`[s1,...,s8] <- osszesElojel` minta a listakomprehenzióban nem-fedő
case-blokkra fordul → `%default covering` alatt hiba láncolódik
felfelé minden hívóig.

- **Gyógyír: fedő konverzió** — `listaGyokke : List Integer -> List E8Gyok`
  a `listaGyokke [a..h] = [gyök]` / `listaGyokke _ = []` mintával,
  és `filter parosGyok (concatMap listaGyokke osszesElojel)`.

## 5. csapda: definíció main UTÁN → "Undefined name"

Bár az Idris2 top-level deklarációk sorrendje elméletileg szabad,
a `main`-ben hivatkozott, a fájl VÉGÉN álló konstansokra
"Undefined name" hiba jött (0.8.0). **Gyógyír: minden konstans a
main ELŐTT.**

## A mért adatok

| próba | idő | eredmény |
|---|---|---|
| komprehenzió 256 elem (Nat, kis) | 1,15 s | ok |
| szűrt komprehenzió (kisbetűs, üres) | 1,14 s | hamis ok |
| Nat 5 160 960 Refl (nagybetűs) | >45 s | KILENG |
| Integer 696 729 600 Refl (nagybetűs) | 1,2 s | ok |
| E8Gyokok_v2.idr teljes (Integer) | 2,7 s | ok, fut |

## A tanulság lényege

**A "lefagyás" nem varázslat: bisect + sample + pgref mutatja a
gyökérokokat.** Három rétegű volt: (a) unáris Nat, (b) árva folyamat,
(c) hamis probe a kisbetűs-csapdából. A GAUGE-elv (gyanús láncot
tiszta fájlban újrafuttatni) most is működött — a korábbi
"exit 0"-k műtermékek voltak.
