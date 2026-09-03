# Kutatási napló — 2026-09-03 — 100.05 Hipotetikus átírása (3 meztelen)

## A felhasználó utasítása szó szerint (§N5)

«folytassa mester !」

「继续吧，大师！」

## Mi történt (minden lépés, szóról szóra)

1. §N11: a terv 100.05-bejegyzés + a Hipotetikus.idr teljes elolvasása (238 sor).
2. Megállapítás: a fájl NEM FORDULT (örökölt törés: Undefined name Eset) és
   nincs egyetlen függője sem (senki nem importálja — szabad az átírás).
3. A 3 meztelen azonosítása:
   · h3 Legendre-fázishatár: (Double -> Double -> Double) -> ... — csomagolatlan
   · h5 Landauer: (Double, Double) -> Double -> Double -> Type — csomagolatlan pár
   · 6 darab () unit (h6, h7, h8, h10, h11, h12) — a «semmi» állítás
4. A MEGOLDÁS — a jelentés a típusban (MANTRA: hozzáadás):
   · ÚJ record PotenciálMező (mezőÉrték : Double -> Double -> Double)
     — a Double csak a mező belsejében (numerikus perem);
   · ÚJ record LandauerHármas (energia, hőmérséklet, információ : Double)
     — a hármas EGYBEN hordozza a jelentést;
   · ÚJ data BizonyításraVár = BizonyításraVárKonstruktor
     — nem «semmi» (), hanem JELENTÉS: a hipotézis nyitott!
5. Az örökölt törés javítása: Eset → Esetrag + import MagyarNyelvtan.
6. A h2 Nat-je MARAD — a Steane713 Szindroma-típusának örökölt pereme
   (EgyesHiba Nat) — dokumentálva.
7. A teljes komment-állomány ékezetesítése: sed CSAK a ^(--|\|\|) kezdetű
   sorokon (~120 szabály) — az azonosítók definíciós sorai ÉRINTETLENEK
   (a csapda #21 — «a sed azonosítókat érint» — szándékos szűkítővel kerülve).
8. Mind a 12 hipotézis-doc (H1-H12) ékezetesen + kínai párban
   (「一」…「十二」) — a top-prioritású kínai szabály szerint.
9. Eredmény: Hipotetikus.idr exit 0 (ELŐBB nem fordult — most fordul!);
   14 kínai sor; a terv: 100.05 → KÉSZ.

## Tanulság (miért-lánc)

- A «jelentés a típusban» elv a hipotéziseknél KÜLÖNÖSEN fontos: a ()
  unit azt mondja «semmi», a BizonyításraVár azt mondja «nyitott kérdés» —
  a Curry–Howard-olvasat javul.
- A komment-sorokra szűkített sed (/^(--|\|\|)/ blokk) BIZTONSÁGOS módja a
  tömeges ékezetesítésnek: az azonosítók sosem sérülnek.
- Az örökölt törés (Eset) oka: a MagyarNyelv-átírás átnevezte Esetrag-ra,
  de a Hipotetikus.idr nem kapott függő-auditot — tanulság: átírás után a
  MINDEN importálót ellenőrizni kell (a «nincs függő» most is hamisnak
  bizonyult volna fordítási szempontból: a modullista!).

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
