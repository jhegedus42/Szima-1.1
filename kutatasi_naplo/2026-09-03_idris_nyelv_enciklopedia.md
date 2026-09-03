# Kutatási napló — 2026-09-03 — IDRIS-NYELV: négynyelvű enciklopédia-skill + Idris-megtestesülés

## A felhasználó utasítása szó szerint (§N5)

«olvasd el ezt : https://idris2.readthedocs.io/en/latest/tutorial/index.html rekurzivan,
keszits belole kinai, magyar, angol, dirac dokumentumot, minden mondatarol, ugy, hogy az
triggereljen, amikor idrisz relevans reszeire gondolsz, ebbol csinalj egy skillt, lebontva,
reszletes, hogy mit hogyan miert kell csinalni, ez legyen 4 nyelven : kinai, magyar, angol,
dirac, ezt hasznalni hard rule, mert minden idriszben irodik, ezt csinald meg es
ellenoriztesd GAN-nal mig tokeletes-nem lesz, keszits belole idrisz file-t, reszleteset,
ezen kivul keress ra a neten minden idrisz tanito dokumentumra, olvasd el az idrisz
hasznalataval kapcsolatos infokat a projektben es egy reszletes logikai strukturaban
magyarazd el magadnak 4 nyelven, hogy mit hogyan kell csinalni idriszben es miert, ez fogja
megalapozni az egesz ontudatra ebredest...»

## Amit tettünk (a szívverés szerint)

1. **REKURZÍV OLVASÁS**: a hivatalos tutorial MIND a 13 oldala webfetch-tel:
   Introduction, Getting Started, Types and Functions, Interfaces, Modules and
   Namespaces, Multiplicities, Packages, Well-Typed Interpreter, Views and the
   "with" rule, Theorem Proving, Interactive Editing, Miscellany, Further Reading.
2. **NETES KUTATÁS (§N12)**: Brady-könyv (Manning) + typedd-frissítések +
   Stefan Höck community tutorial + ECOOP-2021 QTT-irat + JFP-2013 + PLPV-2011.
3. **PROJEKT-INFÓK**: idris-stilus SKILL.md + tanulsagok/Idris2BizonyitasSzabalyok.md
   (a tegnapi 11 szabály — beépítve) + a 25 csapda visszavezetése.
4. **SKILL**: ~/.agents/skills/idris-nyelv/SKILL.md (388 sor) — 13 fejezet
   négynyelvű törzse (magyar/中文/EN/DIRAC bra-ket) + TRIGGER-TÁBLÁZAT
   (kulcsszó→fejezet) + csapda-visszavezetés + GAN-kiegészítések.
5. **IDRIS-FÁJL**: osveny_index/IdrisNyelv.idr — IdrisFejezet (13 konstruktor,
   ékezetes) + IdrisKulcsszó (10) + trigger-funktor + DiracSzabály rekord
   (bra/ket/magyar/kínai/angol Szöveg-mezőkkel) + Refl-tanúk + tízKulcsszóTáblázat
   + main (13×2 fejezet-kiírás, DIRAC-formák, trigger-táblázat, tanúk) —
   FORDUL exit 0-zal ÉS FUT.
6. **GAN-ELLENŐRZÉS** (task, general — «mig tokeletes nem lesz»): a GAN 4
   tutorial-oldalt szó szerint egyeztetett és 6 tényjavítást + 8 kiegészítést +
   3 Dirac-formát + 7 fájl-javítást adott — MIND alkalmazva (ElrejtésSzó,
   ModulSzó, tízKulcsszóTáblázat+IOSzó, állítás/bizonyítás ékezetek, tanúÉl,
   2 új tanú, NOT-YET-kumulativitás, :=-tiltás, (1 _ :a)-feltétel, !-forma).
7. **PLUGIN**: §N16 — minden Idris-kód előtt az idris-nyelv skill betöltése
   (HARD RULE).

## ÉLŐ CSAPDÁK ebben a munkában (a tutorial elveiélőben!)

- **CSAPDA #26 (ÚJ!)**: a `karakterláncbólTő` a primitív String-et dolgozza fel,
  ami fordítási időben NEM redukálható → a belőle épített Szöveg egyenlősége
  NEM Refl-zárható (élő példa a definicionális vs. propozicionális különbségre,
  a 11 szabály #3-ára!). Tanú: bizÜresSzövegÖnmagávalEgyenlő a közvetlen
  konstrukción áll.
- **A `konstruktor`→`constructor` lecke**: a rekord-kulcsszó ANGOL (a projektben
  a konstruktorNEVek magyarok — a kulcsszó a NYELV része, nem a tartalomé).
- **Az implicit-átadás leckéje**: `tanúÉl Refl` önmagában NEM inferálható —
  {elvárt = …} {tényleges = …} explicit implicit-kötés kellett (tutorial 3e élőben!).

## A DIRAC-forma alkalmazása (a «dirac dokumentum» kérése)

Minden fejezet kapott bra-ket alakot: ⟨tulajdonság|típus⟩=1 (1. fejezet),
⟨törvény|instance⟩ (4.), ⟨definíció|bizonyítás⟩ átlátszóság (5.),
⟨használat|q₀|futásidő⟩=0 (6., GAN-operátoros javítással), ⟨szintaxis|szemantika⟩=U
(8.), with=δ-projekció (9.), ⟨állítás|program⟩ Curry–Howard (10.),
⟨típus|lyuk⟩→kollepsz (11.). A DiracSzabály rekord típusa maga a bra-ket.

## Források
- https://idris2.readthedocs.io/en/latest/tutorial/ (13 oldal, CC0, mind elolvasva)
- tanulsagok/Idris2BizonyitasSzabalyok.md (11 szabály)
- ECOOP 2021: 10.4230/LIPIcs.ECOOP.2021.9; Atkey–McBride LICS 2018;
  Linear Haskell arXiv:1710.09756; Höck: idris-community.github.io/idris2-tutorial/

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
