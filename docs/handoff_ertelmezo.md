# Handoff — ErtelmezoSzotar.idr folytatása

## ÁLLAPOT (2026-08-16, compact előtt)

**Minden commitolva `e55a6fa`-ig.** Két fájl van munkálatlanul:

### 1. `osveny_index/ErtelmezoSzotar.idr` — HIÁNYOS (le volt vágva, `...` szintaxissal)
Újra kell írni. A teljes terv (lásd lent).

### 2. `osveny_index/szavak_generated.txt` — KÉSZ, EZEK A TÍPUSOK BEÉPÍTENDŐK
129 sor: ~40 magyar szó helyes `Fonetika` típusként (Hang-konstruktorokból),
generálva a Python tükrőnvővel. **A generátor kb. egyezik a `Fonetika.atiro`-val**
(geminátum ddzs/ccs/ggy/lly/nny/ssz/tty/zzs, n-asszimiláció ng→[ŋ]/nng/ngy/ng,
idegen x→ks/y→i/w→v). Ellenőrzött példák:
- `szHangvilla = [MS Mh, MH Va, MS Mng, MS Mv, MH Vi, MS Ml, MS Ml, MH Va]` (ng→Mng!)
- `szHang = [MS Mh, MH Va, MS Mng]` — 1 szótagú
- egyszótagú alapszavak: szHaz szSzo szTo szHang szKor szSziV szEl szViz szFeny szKut szUt szLet szLe szFog szNyelv szHal szKep szKot szNov szAd szIszik

## A FELHASZNÁLÓ ELVE (szigorú!)

1. **Minden szó ÉS toldalék = nevesített `Fonetika`-érték** (`szHaz`, `ragBan`...), tisztán Hang-konstruktorokból. **NINCS `magyarHangok "szöveg"` a magban** — az csak gauge (határ/fájlbeolvasás).
2. **String csak Show-ban** (megjelenítés).
3. **Agglutináció = list-összefűzés**: `ragoz szHaz ragBan = szHaz ++ ragBan ragFonetika`
4. A szócikkek: ÉKSZ-forma „Az X olyan Y, amely Z" = szoCim (X) + nemFogalom (Y, genus → GeneralizacioK él a Szotár-gráfba) + jegyek (Z, minden rag egy Fillmore-slot: `SzerepKent melyEset betolto`).

## AZ ErtelmezoSzotar.idr CÉLSTRUKTÚRA (teljes újraírás)

```
module ErtelmezoSzotar
import Fonetika; import MagyarNyelvtan
%default total

-- 0. MH/MS/DG rövidítések: MH = MaganhangzoHang stb.

-- 1. szavak_generated.txt tartalma beillesztve (szHaz, ragBan, ...)

-- 2. Rag record: RagK ragFonetika ragEset  (a rag szavakhoz: ragBan stb.
--    — a generált fájlban a rag* csak Fonetika; az esetet a Rag-ba tenni)

-- 3. ragoz : Fonetika -> Rag -> Fonetika  (= ++)

-- 4. SzofajT, SzerepKent(melyEset,betolto), Szocikk(szoCim,szofaja,nemFogalom,jegyek,pelda) + Show

-- 5. szócikkek (8 db ÉKSZ-stílusban):
--    hangvilla→eszköz, entrópia→mérőszám, kategória→struktúra, funktor→leképezés,
--    komma→maradék, keresés→folyamat, energia→mennyiség, szótár→gyűjtemény
--    (jegyként a generált differentia-szavakkal: szHangot = PATIENS stb.)

-- 6. lekérdezések: cikketKeres, nemFogalma, esetGyakorisag

-- 7. main : vékony IO (csak show)
```

## TESZTEK (Teszt.idr-be)

- `ragoz szHaz ragBan` == `magyarHangok "házban"` (gauge-egyezés!)
- minden generált szóra: `ipaForma szX == magyarIPA "X"` (kör-rugalmasság)
- szótagszám: egyszótagú szavakra `szotagSzam` == 1 (Fonetika.szotagSzam String-es; kell egy Fonetika→Nat változat vagy a String-es a gauge-en)

## FORDÍTÁS/FUTTATÁS

- `cd osveny_index && idris2 -c ErtelmezoSzotar.idr` (timeout ~60s fokozatosan nőhet)
- futás: `idris2 --exec main ErtelmezoSzotar.idr`
- teszt: `idris2 --exec main Teszt.idr` (most 14 Refl + 65/65 Show)

## ISMERET Idris-CSAPDÁK (már tapasztaltuk)

- `|||` doc-komment folyósora ELTÖRI a parsert → csak `--`
- forward reference nem megy: a `fiPont`-szerű értékeket a használat ELÉ tenni
- `take` Stringen nem megy → `substr`; `take` Nat/List-en Stream-unification hiba lehet → strukturális `utolsoElott`
- totality: `where`-beli rekurzió néha elakad → top-level + fuel (`S n`)
- `Nat`-on nincs Integral → `cast {from=Nat}{to=Integer}`
- `Eq`/`Show` instance hiányzik új típusokra → kézzel megírni (Teszt.idrben is lehet)

## GIT

- `ssh-add ~/.ssh/id_github` minden session elején (agent elveszti)
- remote: `git@github.com:jhegedus42/Szima.git` (ÁTNEVEZVE opencode→Szima!)
- commit üzenetek magyarul, részletesen (lásd korábbiak)
