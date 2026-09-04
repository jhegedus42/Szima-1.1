# Kutatási napló — 2026-09-04 — Yoneda-hologram protokoll: irányító + felmérés + tudásgráf + wiki

## A felhasználó utasításai (szó szerint, §21/§23)

1. «explore and understand the project»
2. «mi a terv ?»
3. «keszits atfogo projekt-terkepet, nezd meg milyen feladatok vannak es miert,
   ezt egyszerre keszitsd el 4 nyelven, kinai, magyar, angol es dirac, ez a
   terkep idriszben keszuljon es keszitsen egy weboldalt, lenyegeben egy
   wiki-t, ami szep, es mindent ami relevans, tartalmaz»
4. «rekurzivan kell vegrehajtani, BFS alapon, meg kell nezni mi a cel, mi az
   ami hianyzik, mi miert van, a konyveket ujra kell olvasni, es gan-nal
   minden linket folyamatosan kell csekkolni, meg kell ertened a hierarchiat
   h. mi miert kell, mi nincsen mi nelkul es miert, azt pedig az osveny
   alapjan erted meg, a jelentest csak ugy fogod megerteni, ha a yoneda lemma
   szerint cselekszel, a jelentés onmagaban nem letezik, az egy hologram...
   ez ertheto ? ha kell, 2000 oldalas wiki-t irsz, nezd meg milyen mcp-k
   vannak, milyen hozzafereseim vannak, pl van scite-om, allatsal be mindent
   frankon, keress valami heurisztikat ami biztositani fogja, hogy az
   informacio nem fog szetcsuszni benned, valoszinuleg 7 1 3 - as redundanciat
   kell alkalmaznod a kommunikaciokhoz es a gondolkodashoz is, nem bizhatsz
   meg a sajat gondolataidban, kell extra vedelmi heurisztika, esetleg
   holografikus kod... tervezz meg valamit»
5. «de legelso korben meg kell nezni, hogy hol vannak milyen file-ok, milyen,
   sym linkek, mit csinalnak, ez a legfongosabb, ha ez megvan, utana
   folytathatjuk»
6. «eloszor rendet kell tenni file-ok kozott, kezdjuk azzal, arrol egy felmeres,
   az egesz tervet ird le kinaiul is»
7. «ne engedd hogy tul nagyra nojon a kontextusod, mert akkor szethullasz,
   inkabb legyen egy kulso determinisztikus iranyito, es 7 1 3 - mal
   stabilizalod magad»
8. «magyar+angol+kinai+referenciak pontosan, hogy mit miert fogsz csinalni,
   amikor ujra magadhoz tersz,»
9. «[$idris-nyelv] idrisz az kritikus»
10. «[$idris-stilus] meg ez is !»
11. «[$arxiv-search] keressunk azert, az mindig jo»

## Mi készült el (a jóváhagyott terv végrehajtása)

1. **`osveny_index/irányító/Állapot_v1.md`** — az ébredési protokoll HU+EN+ZH,
   hivatkozásokkal (AGENTS §3/§10–§13/§18/§20–§25); az állapot (fázis, BFS-sor,
   lépésszám) ADATKÉNT él benne — a folytatáshoz csak ezt a fájlt kell olvasni.
2. **`osveny_index/Irányító_v1.idr`** — külső determinisztikus irányító:
   `Állapot` rekord + tiszta `következőLépés : Állapot -> Lépés` + `main`
   (főciklus-jelentés). Fordul + fut; Refl-tanúk: `bizKezdetiSorHossza`,
   `bizGépDöntéseElsőLépés`, `bizÁtmenetElőreVisz`.
3. **`docs/FajlrendszerFelmérés_v1.md`** — a gyökér ~89 elemének
   szerepkör-besorlása (KANONIKUS / HÍD / NYERSANYAG / MELLÉKTERMÉK /
   RENDTELNÉS); a 6 szimlink táblája (szima_ter → osveny_index: egy forrás,
   két nézőpont); a három naplókönyvtár; statisztika.
4. **`docs/FajlrendszerRendterv_v1.md`** — 6 rendezési javaslat a
   konzervatívtól (jegyzék) a bőig (source/ archiválás); SEMMI mozgatás nem
   történt, minden döntés a felhasználóé.
5. **`osveny_index/TudásGráf_v1.idr`** — a tudásgráf 0. rétege: Csomópont
   rekord Yoneda-szekcióval (bejövő/kimenő élek + miért), HáromKópia
   (7-1-3: Refl/numerika/irodalom), GANVerdik; 17 csomópont (1 cél + 8
   fogalomcsalád + 8 könyvtár-hely); 4 Refl-tanú (8=8, 8=8, 17=1+8+8,
   stabil=True). Fordul + fut.
6. **`osveny_index/ProjektTérkép.idr` + `docs/projekt_terkep_wiki.html`** —
   Idris-generált wiki (28 755 bájt): fogalom-kártyák négynyelvű
   (magyar/中文/EN/DIRAC) tartalommal + Yoneda-élek + 7-1-3-státusz +
   GAN-verdik; 12 fázis táblázata; irodalmi horgonyok; nyelv-fülek vanilla
   JS-sel; a dashboard-stílusban (Georgia, #f0eee9, nulla külső függőség).
   Generálás: `idris2 --exec main ProjektTérkép.idr > docs/projekt_terkep_wiki.html`.

## CSAPDA #27 felfedezése (bisect, nem találgatás)

A ProjektTérkép írásakor háromszor visszaadott «Undefined name» a klauzula
bal oldalán — méréssorozat (PróbaÉlSoraA–H, mind a repóban marad):
**importok jelenlétében a CSUPASZ ékezetes mintaváltozó megbukik; a
konstruktorba ágyazott minta, az @-minta és a case-ág működik; import
nélkül minden működik.** Gyógyír: `élekSora (elsőÉl :: többiÉl) = …`.
Dokumentálva: `tanulsagok/CSAPDA_27_ÉkezetesMintaváltozóImport.md`.
Melléktanulságok: (a) az `idris2 --check` néha exit 0-t adott hibakimenet
mellett (GAUGE: a kimenetet olvasni kell); (b) a `tanulosagok/` kisbetűs
mappanév miatt onnan modul-útvonal nem lehetséges — ez magyarázza az
OLVASD.md régi „egyesek nem fordulnak" megjegyzését.

## Irodalom-ellenőrzés (7-1-3 harmadik kópia, arxiv-search skill)

- A Valyu API-kulcs nincs beállítva → WebSearch-tel ellenőrizve:
  HaPPY = arXiv:1503.06237 (Pastawski–Yoshida–Harlow–Preskill 2015) ✓;
  DisCoCat-fordítás = arXiv:1811.11041 ✓ — pontos cím: »Translating and
  Evolving: Towards a Model of Language Change in DisCoCat« (a DiracNyelv.idr
  rövidítve idézi — javítandó a következő hullámban).

## Verifikáció

- Irányító_v1: `idris2 --check` ✓, `--exec main` ✓ (értelmes jelentés)
- TudásGráf_v1: `--check` ✓, `--exec main` ✓ (17 csomópont kiírva)
- ProjektTérkép: `--check` ✓, generált HTML 28 755 bájt, 8 doboz, tartalmazza
  a „17 csomópont" összegzést (GAUGE: értelmezhető)
- Nem futtattam le a teljes Teszt.idr-láncot (a new module-ok nem érintik);
  állapot az utolsó commit szerint 164/164.

## Következő lépések (az Állapot_v1.md BFS-sorából)

1. GAN-alügynök a felmérés/gráf VALÓDI-verdikű csomópontjaira
2. Könyv-hullám 1: Yoneda → Awodey (alügynök)
3. `KonstansHitelesites.idr` + `MindenKonstans.idr` --check (Rendterv 4a)

## Kiegészítés — «az is kell meg, hogy a Szimat letoltod es osszehasonlitod a Szima-1.1-el...»

- A Szima letöltve az engedélyezett külső munkakönyvtárba (§1a):
  `git clone git@github.com:jhegedus42/Szima.git` → 1375 fájl, 11 branch,
  master `b763426`, **utolsó commit MAJ 08:57** (PR #3: a copilot/cursor/
  probe/szerver_ox branchek uniója a masterbe).
- **NINCS közös ős** — a Szima-1.1 friss `git init`, nem fork.
- Fa-diff (821 fájl): **518 csak Szimában** (source/ 445 követve!, 
  `osveny_index/FuggetlenLevezetes/` saját ipkg 10 fájl,
  `szima_ter/modul/E8Kartan.idr` + `ProbaIdo.idr`, literatura-index,
  Vercel/Pages-deploy), **273 csak Szima-1.1-ben** (kutatasi_naplo 84,
  szima_ter 47, osveny_index 47, docs 20 — a Sept 1+ élő munka),
  **30 módosult** (mindben a Szima-1.1 frissebb: pl. `komplexEgyenlo`
  a Szimában vs `komplexEgyenlő` a Szima-1.1-ben; ipkg 56 vs 66 modul).
- **Egyedi-kockázat:** a `FuggetlenLevezetes/`, `E8Kartan.idr`,
  `ProbaIdo.idr`, `docs/literatura.html` a helyi fában NEM léteznek —
  csak a GitHubon lévő Szimában; javaslat a jelentésben a átmásolásukra
  (döntés a felhasználóé).
- Teljes jelentés: `docs/Szima_letoltes_osszehasonlitas_2026-09-04.md`.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★

## Kiegészítés (2026-09-05) — NR 1 SZABÁLY + IDRISZ-ÁGENS + ellenőrző v2

- **NR 1 SZABÁLY (a felhasználó, szó szerint):** «minden gondolatod legyen
  kinai es magyar es angol … ez HARD RULE!!!, a COT-d legyen ilyen, es
  minden agensre ez vonatkozzon, ez a NR 1 SZABÁLY !!! AZONNAL ! mert
  felremegy minden es rossz lesz a melo» + a korábbi «1 mondat magyar,
  1 mondat kinai, 1 mondat angol, 1 mondat nemet» ciklus. Beírva: AGENTS.md
  §26, HOROG 13. szindróma, Állapot_v1.md NR1-blokk, ~/.config/opencode/
  AGENTS.md §N10, ~/.zcode/AGENTS.md (új).
- **Idrisz-ágens létrehozva:** skill a felderített helyeken (~/.agents/skills/
  idrisz-agens + repó .agents/skills/idrisz-agens — a zcode-guide szerint a
  repó gyökér skills/ NEM szkennelt!). Mandátum: konyvolvaso-protokollal
  olvassa az Idris-könyveket, a két skill (idris-nyelv + idris-stilus)
  BETÖLTÉSE 0. lépésként, csapda-katalógus, GAUGE-ciklus.
- **Az ágens futása (48 eszközhívás, ~14 perc):** elolvasta a két skill-t +
  patterns/docs/naplókat/stílusbázist; ÁTÍRTA az idrisz-agens skill-t
  (193 sor, 23 csapda, checklist) + ÚJ idris-forditasi-szotar (110 sor,
  hat szekciós hiba-SZÓTÁR) — mindkettő a repóban és ~/.agents/skills alatt;
  MEGJAVÍTOTTA a NégynyelvűEllenőzső_v1.idr-t: fordul + fut, öt nem-
  tautológ Refl-tanú (bizCiklusZárul, bizHetedikNémet, kínai/magyar
  felismerés), két próba zöld.
- **ÚJ CSAPDÁK (6, az ágenstől, mind empirikus):** #27 él LAMBDA-paraméteren
  is (gyógyír: pontstílus); #27 él IO-do-s függvény bal oldalán (gyógyír:
  @-minta `útvonal@_`); readFile-perem → `covering` kell; ékezetes futtatható-
  név → Chez `\369` olvasási hiba (futtatható néve ASCII legyen!); `-o`
  abszolút útvonal → duplán fűzött .so-útvonal (relatív -o a forrás
  könyvtárából); `||` elütés `|||` helyett parse-hibát ad.
- **GAUGE-epizód (fő ügynök):** az újrafuttatásnál a tail -3 csak a második
  próbát mutatta → gyanú (rögzített útvonal?) → a teljes kimenet és a
  forrás szerint a main mindkét próbát futtatja sorban — az ágens ártatlan,
  a kivágás volt hibás. Tanulság: soha nem tail-lel mérünk.
