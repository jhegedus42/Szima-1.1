# A SZÍVDÖBBANÁS-PLUGIN — hogyan működik és hogyan alkalmazandó
# 心跳插件——如何运作与如何应用 · Der Herzschlag-Plugin · פלאגין פעימת הלב
# (2026-08-22; forrás: a felhasználó kérése — "read horog at every 3rd
# prompt, make this a plugin, also read agents at every 3rd prompt...
# and summarize relevant parts of it regarding the current workflow,
# and write and document how it should be could be applied")

## 1. Miért kell? / Why? / 为什么？

Az AGENTS.md és HOROG.md szabálygyűjteményei a session közben
**elsodródnak**: a modell a kontextus elején olvassa őket, aztán a
munka elfedi. A HOROG.md maga mondja ("5 PERCENKÉNT: Olvasd ezt
vissza"), az AGENTS §10 pedig a **3-promptos ritmust** írja elő (git
snapshot minden 3. promptnál). A v5 plugin ezt a ritmust GÉPIRE veszi:
a szívverés maga az emlékezet.

## 2. Hogyan működik? (horog-injektor_v5.ts)

Minden LLM-hívásnál a `experimental.chat.messages.transform` horog:
1. megszámolja a user-üzeneteket (= prompt-szám);
2. minden prompt után injektálja a HOROG-ot (a 12 szabály);
3. **ha a prompt-szám osztható 3-mal** (3., 6., 9., …), PLUSZBAN
   injektálja a ♥ SZÍVDÖBBENÉS blokkot, amely:
   - **A)** a `HOROG.md`-et **FRISSEN a lemezről** olvassa (nem a
     beégetett másolatból — tehát a HOROG.md szerkesztése AZONNAL él,
     újraindítás nélkül; a `--` komment-előtagokat levágja, hogy a
     modell sima szöveget lásson);
   - **B)** az `AGENTS.md` szakaszait (a `## ` címek mentén) összeveti
     a legutóbbi user-üzenet szavaival, és **a releváns szakaszok 2-2
     lényegi sorát** injektálja (+ mindig a teljes szakaszjegyzéket) —
     "summarize relevant parts regarding the current workflow";
   - **C)** emlékeztet az AGENTS §10 ritmusára: a 3. prompt = **git
     snapshot** esedékes (`git add -A && git commit -m "snapshot N: …"`).
4. Minden művelet sora a `kutatasi_naplo/plugin_naplo_YYYY-MM-DD.log`
   fájlba kerül (`♥ SZÍVDÖBB.` műveletnévvel) — `tail -f`-fel követhető.

A duplikáció-védelem: a horog-szintetikus rész megléte esetén nem
injektál újra; a szívdobbanás csak az adott 3-multiple prompton fut.

## 3. Hogyan ALKALMAZZA a modell? (a várt viselkedés)

Amikor a ♥ SZÍVDÖBBANÉS blokk megjelenik a kontextusban:
1. **Nyugtasd meg egy sorban**: mely szabályokat alkalmazod éppen
   (pl. „♥ szívdobbanás: §24 duplikáció-tilalom + §25 ékezet
   érvényesítve ebben a válaszban").
2. **Hajtsd végre a §10 ritmust**: git snapshot + push (ha távoli van).
3. **Olvasd el az A) friss HOROG-ot** — ha a fájl megváltozott a
   session indulta óta, az ÚJ szabályok azonnal érvényesek.
4. **A B) releváns szakaszokat** alkalmazd az aktuális feladatra
   (pl. ha git-ről/commitról van szó → §10+§21; ha Idris-írásról →
   §13/§24/§25 + boot-up §14).

## 4. Hogyan LEHET még alkalmazni? (kiterjesztési ötletek)

- **Compaction-ellenállás**: tömörítés után a prompt-szám elveszhet;
  a plugin a user-üzenetek számából számol, így a tömörített
  kontextusban is újraszámol — a szívverés túléli a kompakálást.
- **Más fájlok same ritmusa**: a `szivdobbanasBlokk` könnyen bővíthető
  pl. a `MANTRA.md` vagy a `tanulsagok/OLVASD.md` friss olvasásával.
- **Súlyozott relevancia**: a B) szóegyezés helyett embedding-alapú
  hasonlóság (későbbi fejlesztés — most szándékosan egyszerű).
- **TUI-jelzés**: a `session.idle` eseményben a plugin-naplóba írt
  `♥ SZÍVDÖBB.` sor egy pin-elt `tail -f` ablakban látható szívverés.

## 5. A plugin család (§13 — minden verzió megmarad)

| verzió |funkció |
|---|---|
| v1 | injekció minden LLM-hívásnál |
| v2 | + auto-napló (session.idle → auto-spool) |
| v3 | + tanulság-őrszem (csapda-minták .idr-írásra) |
| v4 | + láthatóság (tool-cím ✓/⚠ + plugin-napló) |
| **v5** | **+ SZÍVDÖBBANÉS: minden 3. promptnál friss HOROG.md +
  AGENTS.md-relevancia + §10 commit-ritmus emlékeztető** |

A config a v5-re mutat: `"plugin": ["./plugin/horog-injektor_v5.ts"]`
(újraindítás után él).
