# Tanulság: a cong beragad GLOBÁLIS függvényfejű szakasznál (Idris 2 0.8.0)
# 教训：cong 在全局函数头处卡住 · Lehre: cong bleibt bei globalen Funktionsköpfen hängen
# (2026-08-22; a KetoldaliKategoria_v3 gyógyítása közben, PróbaKvir→PróbaLambdaCong lánc)

## A jelenség

Lista-egyenlőségek rekurzív bizonyításánál (`cong (fej ::) (rekurzív bizonyítás)`):

- **VÁLTOZÓ függvényfej** (pl. `cong (g (f x) ::) ...`, ahol g, f kötés): **MŰKÖDIK**
  (bizMapKompozicio ✓, bizMapId — sima `x` fej — ✓).
- **GLOBÁLIS függvényfej** (pl. `cong (dualitas (f x) ::) ...` vagy akár
  `cong (Egy ::)` ellenében a cél `kettos Nulla :: ...`): **BERAGAD** —
  „Can't solve constraint between: dualitas (f x) and dualitas (f x)"
  (két SZÓRÓL SZÓRA azonos tag közt!), ill. „Mismatch between: Egy and
  kettos Nulla" — a unifikátor nem redukálja/iota-bontja a fejet.

Kipróbált és szintén beragadt formák: lambda a szakasz helyett, rewrite,
with-absztrakció („kettos is not accessible"), J-mintás saját fej-kongruencia
(hívóhelyén „not accessible"), eseti bontás + konstruktoros fej.
A `%default total` / `%default covering` NEM ok (mindkettő alatt ugyanaz).

## A mérőlánc (GAUGE-elv; mind archiválva a T/opencode-ban)

| próba | eredmény |
|---|---|
| PróbaIdKötés (minősített Prelude.id + cong) | ✓ ÁTMENT — az `id` a típusban AUTOMATIKUS IMPLICIT lenne! |
| PróbaKvir (azonos két oldal, sima Refl) | ✓ ÁTMENT |
| PróbaKvir2 (konstans-átalakító két oldal, Refl) | ✗ beragadt |
| PróbaCongTotal (%default total alatt is) | ✗ beragadt |
| PróbaLambdaCong (lambda a szakasz helyett) | ✗ beragadt |
| PróbaDöntő2 (saját J-mintás fejKong) | ✗ „kettos is not accessible" a hívóhelyen |
| PróbaCongAlak (proof-first cong) | ✗ — a 0.8.0 cong FÜGGVÉNY-ELSŐ (a theorems.rst helyes) |

## A gyógyír (két út)

1. **Ha a fej VÁLTOZÓ**: cong marad (bizMapId/bizMapKompozicio minta).
2. **Ha a fej GLOBÁLIS függvény**: AGENTS §18 (b)-ága — **futásidejű KIMERÍTŐ
   ellenőrzés**, ha a világ véges (a Kubit-világ az: a függvénytér 4 elemű,
   a listák hosszig enumerálhatók). Minta: `természetesTranszformációKimerítő`
   a KetoldaliKategoria_v3-ban (4 függvény × hossz≤6 listák = kimerítő).
   A kernel-bizonyítás állítását KOMMENTBEN megőrizzük jövőbeli Idris-
   verziókra.

## Melléktanulságok

- **`id` a bizonyítás típusában** → minősítendő `Prelude.id`-ként, különben
  automatikus implicit kötés lesz belőle (a KisBetűsProjekcióCsapda testvére).
- **Import NEM tranzitív**: a `Kubit`-ot mindig KÖZVETLENül a KomplexByte-ból
  importálni (KetoldaliE8Fa_v3 reexportálása nem öröklődik tovább).
- **Konstruktor ↔ típusálnév ütközés** ugyanabban a névtérben:
  „already defined" (TranszcendentalisEgyseg-konstruktor vs. -típusálnév —
  az álnevet átneveztük TranszcendentalisÉrtékTípus-ra).
