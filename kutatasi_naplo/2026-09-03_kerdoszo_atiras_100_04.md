# Kutatási napló — 2026-09-03 — 100.04 Kérdőszó átírása (3 meztelen)

## A felhasználó utasításai szó szerint (§N5)

«folytassa mester !»

「继续吧，大师！」

## Mi történt (minden lépés)

1. §N11: a terv 100.04-bejegyzés + a Kerdoszo.idr teljes elolvasása (268 sor).
2. A 3 meztelen típus azonosítva: KerdoszoT (13 konstruktor), ValaszFele
   (ElsoFele/MasodikFele), AlapOsztó (Elo/Dolog) + a NyitottKerdes-rekord.
3. Függők felmérve: Attekintes.idr, Teszt.idr, tanulsagok/MiértJó.idr.
4. Az átnevezés (BSD sed, szó-határolós, hosszabb→rövidebb sorrend):
   KérdőszóT, VálaszFél (ElsőFél/MásodikFél), AlapOsztó (Élő/Dolog),
   NyitottKérdés (kérdőSzava/válaszHelye), kérdőszóEsetT, megkérdez,
   megválaszol, binárisKérdésBit, kérdőszóOsztója, kérdőszóTáblázat,
   főJelentés, KérdésKi/Mi/Miért/Hol/Hogyan/Melyik, KérdőszóLeírás.
   A modulnév ASCII marad (csapda #6: module Kerdoszo — 1. sor visszavéve).
5. HIBÁK ÉS JAVÍTÁSOK (a tanulság a lényeg):
   a) A függőkben maradtak konstruktorok (HolKerdo, MiertKerdo…) —
      kör-ellenőrzéssel (grep -o "[A-Za-z]*Kerdo") felszedve;
      a «Kerdo» találatok egy része a Kerdoszo modulnévben van — azokat
      NEM szabad érinteni!
   b) A fonetikai konstansok (KerdesKi…) a Kerdoszo.idr-ból kimaradtak
      az első sed-csomagból — a hiba a függők «Undefined name KérdésMi»
      hibájában jelentkezett; pótolve.
   c) AZ EREDETI FÁJLBAN «TÍUSBAN» ELÍRÁS VOLT (P nélkül!) — TÍPUSBAN-ra
      javítva (§N9 helyesírás).
   d) A „KI?/MI?” záró idézőjele U+201D (nem ASCII) — az edit pontos
      bájtokat kíván.
6. tanulsagok/MiértJó.idr: ÖRÖKOLTEN törött (modulnév≠fájlnév — a git-stash
   próba bizonyította, hogy ELŐBB is törött volt); az átnevezés ott is
   megtörtént (KérdőszóT), de a fordítást az örökölt hiba blokkolja —
   külön örökölt-törés-listán marad.
7. A 9+1 szakaszcím kétnyelvű (中文 pár) — a top-prioritású szabály szerint.
8. Eredmény: Kerdoszo.idr exit 0 + futás; Attekintes.idr exit 0;
   Teszt.idr exit 0 (a nagy integrációs teszt is!). A terv: 100.04 → KÉSZ.

## Tanulság (miért-lánc)

- A tömeges átnevezésnél a függők használati módja NEM csak az azonosítók
  listája — a KONSTRUKTOROK is használatban vannak, és azok máshogy
  neveződnek (HolKerdo nem volt a fv-nevek grep-jében). Tanulság: átnevezés
  ELŐTT a függőkben a KONSTRUKTOR-mintára is grep (pl. "[A-Za-z]*Kerdo").
- A sed-csomag «hosszabb→rövidebb» elve a Kerdoszo/Kerdo párjánál
  fordítva is működik: a HOSSZABB (KerdoszoLeiras) ELŐBB, mert a rövidebb
  (Kerdo) prefix-törést okozna.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
