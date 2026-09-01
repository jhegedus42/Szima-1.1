# Kutatási napló — 2026-09-01 — a prozódia a szótárban (ritmus + hangsúly + fonetika)

## A felhasználó követelménye (szó szerint, §N5)

„fontos, hogy a szotar tartalmazzon ritmust is, a ritmus extra hibajavito redundanci, illetve a hangsuly, idealis esetben fonetikus leirast is"

## Az irodalom (§N14/4 — MCP-keresés: brave-search + exa)

1. **A magyar hangsúly FIX:** mindig a szó első szótagon — „fully predictable, thus postlexical rather than lexical" (The Phonology of Hungarian; Mády & Szalontai 2017: Prosodic prominence in Hungarian and German; Remitly guide). NINCS másodlagos hangsúly-bizonyíték.
2. **A kvantitás DISTINKTÍV:** 14 magánhangzó = 7 hosszúság-pár; minimálpárok: «hal–hál», «kor–kór», «birtok–bírtok» (Mády & Reichel 2007: Quantity distinction in the Hungarian vowel system). A hosszú magánhangzókat ékezet jelöli (í ú é ó á ő ű) — **az ékezet INFORMÁCIÓ (§25)**.
3. **A lábak:** Kager (1995) — a prozódiailag szavakat kéttagú trocheusok fedik le (Trommer: words7.pdf); a magyar szó- és mondatprosódia BAL-FEJES.
4. **Az időzítés:** a hangsúly NEM hosszabbít a magyarban (a fonémikus kvantitás megőrzése miatt — White & Mády 2008, ISCA Speech Prosody).
5. **A fonetika:** a magyar helyesírás majdnem fonémikus; a ly→[j] egyértelmű eltérés (Wikipedia: Hungarian phonology).

## A megvalósítás — `SzotarHid_v2.idr` (szima_ter/modul/)

### A típusok (a kód = a definíció, §N14)
- `data Hossz = Rövid | Hosszú` (+ Eq + Show) — a szótag kvantitása
- `data HangsúlyPozíció = ElsőSzótag` — **a típus EGYETLEN lakosa = a determinizmus bizonyítása** (Curry–Howard: az egyetlen konstruktor = az egyetlen lehetséges bizonyítás)
- `record Prozódia` (szótagszám : Nat, ritmus : List Hossz, hangsúly : HangsúlyPozíció, fonetikusÁtirat : String)

### A kinyerés
- `rövidMagánhangzók = "aeiouöü"`, `hosszúMagánhangzók = "áéíóőúű"`
- `ritmusKinyerő : String → List Hossz` — a magánhangzók hosszmintázata (a magyarban nincs diftongus → a szótagszám = a magánhangzók száma, Siptár & Törkenczy 2000)
- `fonetikusÁtiratKészítő` — v1: ly→[j]-közeli egyszerűsítés (a teljes digráf-feldolgozás a 009.04-ben)
- `prozódia : HuWord → Prozódia`

### A hibajavító redundancia (a [[7,1,3]] logika szavanként)
- `prozódiaiEllenőrző : String → Prozódia → Bool` — a szöveg = az «adat», a ritmus+szótagszám+fonetikus = a «páritásbitek»

## A verifikáció (§N14 — mind a 6 szint)

1. **GAN** — a felhasználó maga (a követelmény döntően KIEGÉSZÍTETTE a specifikációt: +ritmus, +hangsúly, +fonetika)
2. **Fordítás** ✓ — `idris2 --check SzotarHid_v2.idr` exit 0 (6/6 modul)
3. **Numerikus** ✓ — `idris2 --exec main`:
   - «birtok» → [Rövid, Rövid]; «bírtok» → [Hosszú, Rövid]; KÜLÖNBÖZNEK = True ✓
   - «abakusz» → 3 szótag [R,R,R] ✓; «abisszikus» → 4 szótag [R,R,R,R] ✓; «hazugság» → 3 szótag [R,R,Hosszú] ✓
   - hibajavítás: az ép «abakusz» → True; a SÉRÜLT «abekusz» → **False** (detektálva!) ✓
   - REFL-ok: ElsőSzótag=ElsőSzótag (determinizmus), Rövid==Rövid, Rövid≠Hosszú ✓
4. **Irodalom** ✓ — 5 forrás fent, a kód kommentjeiben is
5. **Vizualizáció** ✓ — a main kimenete táblázatos (a minimálpár, a lexikon-szavak, a hibajavítás)
6. **Interaktív** ✓ — getLine: a beírt «hangsúlytalan» → 4 szótag [Rövid, Hosszú, Rövid, Rövid] — a program REAGÁL

## A csapdák amiket javítottunk

- **Két-HuWord-ütközés:** a `hazugságMinta` (SzotarHid_v1 → v1-HuWord) vs. a v2-HuWord — „Mismatch between: HuWord and HuWord" — megoldás: `n_hazugsa2g` (v2-ből, huText = „hazugság" ékezetesen)

## A tanulság

A «hangsúlytalan» ritmusa [Rövid, Hosszú, Rövid, Rövid]: a hangsúly AZ ELSŐ szótagon áll, amely RÖVID — pontosan az irodalom szerint (a magyar hangsúly nem hosszabbít, mert a kvantitás fonémikus marad). **A ritmus tényleg EXTRA információ: a «birtok»/«bírtok» minimálpár CSAK a ritmusban különbözik.**

## A következő lépés

A `000.02` folytatása: az `összesSzó : List HuWord` generálása a v2-be (a 3460 publikus szó listája) — a teljes szótár.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★