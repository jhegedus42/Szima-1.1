# Idris 2 bizonyítási KEMÉNY SZABÁLYOK — a hivatalos dokumentációból
## / Idris 2 证明硬规则 / Beweis-Regeln von Idris 2 / כללים קשיחים להוכחות Idris 2

**Forrás (mind elolvasva, 2026-09-02):**
- https://idris2.readthedocs.io/en/latest/proofs/index.html
- /proofs/definitional.html (Propositions and Judgments)
- /proofs/pluscomm.html (Running example: Addition)
- /proofs/inductive.html (Inductive Proofs)
- /proofs/patterns.html (Pattern Matching Proofs)
- /proofs/propositional.html (Proving Propositional Equality)

═══════════════════════════════════════════════════════════════════

## SZABÁLY 1 — KONSTRUKTÍV LOGIKA (nincs kizárt harmadik)
A logika KONSTRUKTÍV (intuícionista): «nincs kizárt harmadik»
törvénye NÉLKÜL. Ami nem igaz, az nem automatikusan hamis — minden
állítást LAKÓVAL (programmal) bizonyítunk. Ellentmondásból bármi
következik — ellentmondást nem engedünk.
» Our: az Igazság-típus (Igaz/Hamis) a BOOL-os kizárt-harmadik
  logikát váltja — a deMorgan-törvényeink konstruktívak.

## SZABÁLY 2 — CURRY–HOWARD (állítás = típus, bizonyítás = program)
A propozíció TÍPUS; a bizonyítás a típust LAKÓ program. Az egyenlőség-
típusnak EGY konstruktora van: `Refl : x = x` — nincs más út.

## SZABÁLY 3 — DEFINICIONÁLIS vs. PROPOZICIONÁLIS EGYENLŐSÉG
A `Refl` CSAK definicionális egyenlőséget bizonyít: a két oldal
NORMÁLALAKJA azonos. Ha a két oldal normálalakja eltér (de az állítás
igaz), az PROPOZICIONÁLIS — Refl NEM elég, kell a mintabontás/rewrite.
» Our: pontosan ezért volt `sorBalEgység _ = Refl` (definicionális),
  de `sorJobbEgység` indukció + cong (propozicionális).

## SZABÁLY 4 — A REKURZIÓ ARGUMENTUMA DÖNT (a redukció iránya)
A `plus` az ELSŐ argumentumon recursionál: `plus Z m` azonnal
redukál (`= m`), `plus m Z` NEM. Egy egyenlőség megírása ELŐTT nézd
meg, melyik argumentumon mintázik a függvény — a konkrét értéknek a
rekurziós oldalon kell állnia, hogy redukáljon.
» Our: a `sorÖsszeadás` ugyanígy az ELSŐ argumentumon megy — ezért
  lett a `füzérHosszFűzés` bázisa Refl, a `sorJobbEgység` pedig
  indukció; és ezért kellett a `füzérHosszFűzésEgy` segéd a
  `füzérFordítHossz`-hoz (a sorEgy JOBB oldalon nem redukál!).

## SZABÁLY 5 — A MINTABONTÁS A TÍPUST IS FINOMÍTJA
Ha egy klauzúban `n` helyére `Z`/`S k` mintát írunk, a checker a
LUK TÍPUSÁBAN is behelyettesít és redukál. Minden konstruktorra
bontsunk; a luk (`?hole`) típusa megmutatja a finomított célt.
» Our: az explicit kötések `(f : Fogalom) -> …` + teljes bontás
  pontosan ezt csinálja (duálisInvolúció ×10).

## SZABÁLY 6 — INDUKCIÓ = STRUKTÚRÁLIS REKURZIÓ (totality)
Totális függvény = lefedés + strukturálisan KISEBB rekurzív hívás.
Az indukciós hipotézis = a rekurzív hívás eredménye (`let rec = …`).
A bizonyítás gerince: báziseset (Refl) + indukciós lépés (rewrite
a rekurzív hívással).

## SZABÁLY 7 — A REWRITE IRÁNYA (a leggyakoribb bukó)
`rewrite prf in expr` (ahol prf : x = y): a CÉLTÍPUSBAN minden x
előfordulást y-ra CSERÉL. A visszafelé irányhoz `sym prf`. A
helyettesítés a VISSZATÉRÉSI TÍPUSBAN történik — ezért kell gyakran
a FORDÍTOTT egyenlőséget átadni (a dok példája y=x-et ad!).
» Our: a füzérFordítHossz-nál pont ezért nem volt elég a HosszFűzés
  rewrite — a segédlemma (FűzésEgy) a jó irányba hozta a célt.

## SZABÁLY 8 — REPLACE ALATTA (az azonosságok megkülönböztethetetlensége)
A `rewrite` a `replace`-et alkalmazza: ha x=y, akkor bármely
tulajdonság x-re igaz → y-ra is. A `replace`-nél a prop implicit
nehezen inferálható → ha lehet, `rewrite`-ot használjunk.

## SZABÁLY 9 — SYM ÉS TRANS A PRELUDE-BEN VAN
`sym : x = y -> y = x` és `trans : a = b -> b = c -> a = c` KÉSZEN
vannak — §24: IMPORTÁLD, soha ne írd újra.

## SZABÁLY 10 — A STDLIB MÁR BIZONYÍTOTT (§24!)
`plusCommutative`, `plusAssociative` stb. a standard könyvtárban
VANNAK — mielőtt tulajdonságot bizonyítasz, KERESD a stdlib-ben.
» Our: a füzér-törvényeink NEM stdlib-ek (saját típus), de a Sorszám-
  törvényeknél a `cong`-ot importáljuk (meg is tesszük).

## SZABÁLY 11 — TOTAL ANNOTÁCIÓ A BIZONYÍTÁSOKRA
A bizonyításfüggvény legyen `total` (%default total): az érvényesség
MINDEN bemenetre szól, nem csak arra, amire épp definiáltuk. Részleges
«bizonyítás» nem bizonyítás.

## SZABÁLY 12 — HETEROGÉN EGYENLŐSÉG (~=~)
Az `(=)` Idrisben HETEROGÉN lehet; ha a fordító tévesen HOMOGÉNNEK
választja, az EXPLICIT `(~=~)` («John Major») használható.
» Our: pontosan ez a vektorFűzés-törvények (400.03) eszköze
  (n+0 ≠ n a típusban) — a dokumentáció MEGENGEDI és NEVEZZI.

## SZABÁLY 13 — INTERAKTÍV LÉTRA (luk → bontás → típus → keresés)
A bizonyítás lépcsői: lukak (`?hole`), case-split, luk típusának
olvasása, proof search, lemma-készítés. A GÉP megmondja a következő
célt — ne találgassunk, kérdezzük a luk típusát! (Vim: \t \c \s \l \a;
a REPL nyílt kifejezéseken is redukál — λ-kötésekkel!)
» Our: a `GanProbeX.idr` próbalovag-módszerünk enak a szellemi
  rokona — gépileg kérdezzük, nem találgatunk.

## SZABÁLY 14 — VÁZOLJ ELŐBB (papíron), AZUTÁN ÍRJ
A dok a plus_commutes bizonyítást ELŐSZÖR vázolja (tulajdonság,
bázis, lépés, mit ad a HI), és csak utána írja Idrisben.
» Our: a GAN «előre-bizonyító próbalovaga» ugyanez — a célállapot
  vázlata gépileg ellenőrizve, mielőtt a valódi fájlba írunk.

═══════════════════════════════════════════════════════════════════
Forrás: The Idris 2 documentation (CC0), Theorem Proving fejezet.
Olvasva: 2026-09-02, a 100.02-es lépés előtt (a felhasználó kérésére).

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★