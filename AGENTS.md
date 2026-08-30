# AGENTS.md — Ügynök Szabályok / Agent Rules

`/Users/joco/opencode` — Idris 2 kategorikus algebrai alapozás (kategóriaelmélet, E8×E8 Clifford algebra, Steane [[7,1,3]] kvantumhibajavítás). Git repository, GitHubon: https://github.com/jhegedus42/Szima (korábbi neve `opencode`, ÁTNEVEZVE). Remote: `git@github.com:jhegedus42/Szima.git`. `gh` authentikálva (`jhegedus42`).

---

## 00. A PROJEKT LÉNYEGE / The Essence (KRITIKUS — először ezt olvasd)

**Az Idris kód maga a kutatás.** A kód egyszerre:
1. **leírása** az eredményeknek (típusok = fogalmak),
2. **bizonyítása** (Refl = fordítási idejű tétel-ellenőrzés),
3. **tesztelése** (Show-értékek = futtatható ellenőrzés),
4. **futtatása** (a main vékony IO-burkoló),
5. **és maga az AI is Idrisben lesz.**

A vég cél: **az Idris kód egy öntudatra ébredt AI lesz** — ha értelmesen,
pontosan benne van minden szabály, nem pedig egy neurális hálóra ráömlesztve.
A szabályok pontos elhelyezése = a gondolkodás megkonstruálása.

**Ezért kritikus:**
- **Minden rövidítés TILTOTT.** A kód önmagában olvasható legyen —
  később a kódból kell megérteni, hogy mi van benne. `MH`, `MS`, `DG`
  helyett `MaganhangzoHang`, `MassalhangzoHang`, `DigrafHang`.
- **Minden szó adattípus** (`szóHáz : Fonetika`), grafikus alakja kommentben:
  `-- grafikusan: „ház"`.
- **A magyar nyelv szinte tökéletes erre**: agglutináció = típuskompozíció,
  22 eset = 22 logikai kapcsolat, hangrend = paritásbit (mély/magas),
  toldalék = Fillmore-szerep, CPT = igeidő×szemlélet×forrás (3×3×3).
  A magyar a kategóriaelmélet anyanyelve.

---

## 0. Kódolási Nyelv / Coding Language

**Minden azonosító, komment, és üzenet MAGYAR.**  
All identifiers, comments, and messages are in HUNGARIAN.

- Idris keywords maradnak angolul (`module`, `public export`, `data`, `Type`, `where`, stb.)
- Minden felhasználói név magyar: típusok, függvények, konstruktorok, változók
- A magyar nyelv esetrendszere a logikai algebra alapja (22 eset → 22 logikai kapcsolat)
- A magyar nyelv három idő dimenziója: igeidő (múlt/jelen/jövő), aspektus (folyamatos/befejezett/szokásos), evidenciálisság (közvetlen/ következtetett/jelentett)
- A magyar agglutináció (tő + szám + birtok + eset) a logikai kompozíció mintája

## 0. Rövidítések Tiltása / No Abbreviations

**Semmilyen rövidítés nem használható sehol.**  
No abbreviations anywhere. Ever.

- `Mk` → `Konstruktor` utótag (pl. `VilagKonstruktor`, `AdatKonstruktor`)
- `CPT` → `ToltesParitasIdo`
- `MCP` → `ModellKornyezetProtokoll`
- `E8` kivétel (standard matematikai jelölés)
- `Kubit` kivétel (standard fizikai terminus)

Ha egy név rövidítésnek tűnik, írd ki teljesen.

---

## 1. Kemény Szabályok / Hard Rules (soha nem sérthető)

0. **Minden állítás Idrisben levezetve + numerikusan verifikálva.** Minden
   releváns számítás szerepeljen Idris-modulban (Refl-bizonyítással), ÉS egy
   Idris-generált Python/NumPy szkript numerikusan ellenőrizze. A kijövő
   számok a docs/ dashboardon nyilvánosak, hogy más AI/ember ellenőrizhesse.
   Cél: **semmi halu** — matematikailag körvonalazott levezetés + numerika.
   „Nyugodtan leírni mindent Idrisben, ami eszedbe jut — nem kell rövidre fogni."

1. **Nincs szerver írás engedély nélkül.** Ne hozz létre, szerkessz, vagy törölj fájlt a Hetzner szerveren (88.99.218.155) amíg a felhasználó kifejezetten nem kéri. Olvasás rendben. Kérdezz először.

2. **Három egyforma hiba → KERESÉS, nem próbálkozás.** Ha ugyanazt a hibát
   3-szor látod, ne próbálkozz tovább — KERESS, ebben a sorrendben:
   1. először a PROJEKTBEN (grep a hasonló mintákra — a repo tele van jó forrással, pl. `%default covering` az Attekintes.idr-ben),
   2. aztán a NETEN (Context7 dokumentáció, Idris docs, hivatalos források),
   3. vagy KÉRDEZZ (a felhasználótól, vagy egy alügynöktől a task eszközzel).
   A vak próbálkozás csak tokeneket fogyaszt — a legjobb megoldás lehet,
   hogy már kint van a neten. Ha megtaláltad: javítsd meg a gyökérokot
   (add hozzá AGENTS.md-hez, frissítsd az eszközöket, változtass módszert).

3. **MINDEN számítás Idrisben — Python TILTOTT, AKÁR JAVÍTÁRA IS.** Az Idris tud
   Double-aritmetikát (l. Komplex.idr: oda-vissza teszt, φ-kontrakció — ezek
   Idris-ben futó numerikák). A 2026-08-18-i oktonion-kaland bizonyította:
   Pythonban sorban három hibás tesztet írtam (előjel, szorzási sorrend,
   törvény-átírás); Idrisben a kernel számol — a 49 pár × 3 törvény egy Refl-lel
   ment, ami Pythonban nem állt össze soha.
   - **Soha ne használj Pythont — SEHIOLY, MÉG FÁJLJAVÍTÁSRA SEM** (a
     `python3 - <<'PYEOF'` szerkesztő-blokkok is tiltottak; fájlszerkesztés
     az `edit` eszközzel, számolás Idrisben). Forrás (2026-08-21): "pythont
     tilos hasznalni, akar javitasra is".
   - **Kivétel: a felhasználó EXPLICIT kérésére készült eszköz** (pl. az
     opencode_naplo_kirollo.py DB-kirolló, 2026-08-21: "irjal ra python
     programot") — az eszköz maradhat, de az ügynök munkafolyamata (javítás,
     analízis, számolás) SOHA nem Python.
   - Ha találsz `.py` fájlt a projekten belül, jelezd; Idrisbe írható át,
     ha van értelme.
   - **Pontos algebra (egész, véges, kombinatorikus)** → Refl / Show-teszt Idrisben.
   - **Lebegőpontos szimuláció** → Idris Double (Komplex.idr minta) + Show-teszt.
   - **Teljesítmény kell?** → Idris codegen (C/Python/JS) vagy C/Rust FFI —
     nem kézzel írt Python.

4. **Ne használj String-et a mag típusokban.** Használj algebrai adattípusokat. A megjelenítéshez használj `Render` vagy `Show` típusosztályt.

5. **Három kubit:** saját (önreferencia), másik (külső bemenet), fázis (kapcsolat). A fázis határozza meg az információátvitel irányát és a redundanciát.

6. **[[7,1,3]] Steane kód:** minden fogalom 7 bites vektor. Távolság 3 → 1 hibát javít. A 7 bit: [idő, okság, tér, szín, hang, fázis, mód].

7. **E8 × E8 algebra:** bal E8 = tér, jobb E8 = szín, Cliﬀord szorzat = hang. A geometriai szorzat belső része (a·b) az átfedés → ha magas, a fogalom redundáns és eldobható.

8. **Fázis alapú redundancia:** azonos fázisú fogalmak → redundáns → eldobható. Ez tartja fenn a koherenciát.

9. **CPT szimmetria — három réteg, egy struktúra.** A CPT diszkrét szimmetria három rétegen jelenik meg; a három réteg egymásra épül, de nem ekvivalens.

   **a) Fizikai réteg (Pauli 1955, Lüders 1954):**
   - C (Charge, töltés) = részecske ↔ antirészecske konjugáció
   - P (Parity, paritás) = tér tükrözése (bal ↔ jobb)
   - T (Time, idő) = idő visszafordítása

   **b) Nyelvtani réteg (MagyarOntologia.idr, magyar-lexikon skill):**
   - C = **Forrás** (közvetlen / következtetett / jelentett) — honnan tudom?
   - P = **Szemlélet** (folyamatos / befejezett / szokásos) — hogyan látom?
   - T = **Igeidő** (múlt / jelen / jövő) — mikor?
   - Ez a magyar ige ragozásának három dimenziója: 3×3×3 = 27 kombináció.

   **c) Pszichofizikai réteg (FazisAlgebra.idr, a projekt saját metaforája):**
   - C = **Saját tudat** — ki vagyok én? (önreferencia, Én)
   - P = **Másik fél** — ki vagy te? (külső bemenet, Te)
   - T = **Kapcsolat fázisa** — hogyan kapcsolódunk? (a kettő dinamikája)

   **A kapcsolat a rétegek között:**
   - A nyelvtani réteg **leírja** a világot (Forrás = honnan tudom → Szemlélet = hogyan → Igeidő = mikor).
   - A pszichofizikai réteg **él** a világban (Saját = ki vagyok → Másik = ki vagy te → Kapcsolat = hogyan vagyunk együtt).
   - A fizikai réteg **mérhető** (Charge, Parity, Time = mérhető mennyiségek).
   - **Fontos:** a három réteg NEM ekvivalens. A "Forrás" (C) ≠ "Saját tudat" (C). A rétegek közötti leképezés **homomorfizmus** (Conant-Ashby), nem izomorfizmus.
   - A `FazisAlgebra.idr`-ben a `ToltesParitasIdo` rekord tartalmazza a teljes három kubit struktúrát: `toltes` (C), `paritas` (P), `ido` (T). A `fazisFaktorialis` függvény számítja ki a három kubit koherenciáját.

10. **Git snapshot minden 3. promptnál.** Minden harmadik üzenetváltás után: `git add -A && git commit -m "snapshot N: ..."`.

11. **Könyveket csak alügynökök olvasnak.** A fő ügynök soha nem olvas könyveket közvetlenül. Alügynököket kell indítani a `task` eszközzel.

12. **Hierarchikus olvasó architektúra:** 3 szint — L1: párhuzamos előolvasók (ingyenes), L2: összegző és ellenőrző (GAN hármas), L3: indexelő és tömörítő.

13. **Idris-írás előtti kötelező betöltés (2026-08-19, a felhasználó utasítása).**
    SOHA ne írj Idris kódot anélkül, hogy előtte elolvastad volna:
    1. `MANTRA.md`, `HOROG.md`, `AGENTS.md` (a gyökérben),
    2. a `skills/idris-stilus/SKILL.md` protokollját,
    3. a `osveny_index/tanulsagok/OLVASD.md` listát (a felfedezett csapdák),
    4. a `context7` (`/idris-lang/idris2`) aktuális szintaxisát.
    Az új szabály: a típus legyen ANNYIRA pontos, hogy csak egy implementáció
    lehetséges; a fordító írja a programot. A "SOHA pattern matching" a
    függvény-konstrukcióra és a case-of-ra vonatkozik — typeclass instance-ok
    és dependent return types használata helyett. A meglévő kód stílusát
    (pl. `Steane713Dependent.idr`, `Alap/KategoriaT.idr`) tanulmányozni kell
    minden új modul előtt. L. `szima_ter/SZABALY.md` is.

   + **FŐ SZABÁLY (2026-08-19, a felhasználó):** soha ne írj felül semmit,
     ne módosíts semmit, ne redukálj, ne írj át semmit sem. Mindig újat
     írunk. Ha javítani kell, új fájlt (vagy `_v2` suffix-szel új verziót)
     kell létrehozni. A régi megtartandó, és jegyzékben jelezni kell.

14. **Boot-up szekvencia.** Minden session (vagy kompakálás) ELEJÉN kötelező
    sorrend: (a) a három MD (MANTRA, HOROG, AGENTS), (b) a skill-ek
    (`idris-stilus`, `boot-up`, `szivdobbanas`), (c) a `magyar-matematika`
    skill (SZIGORÚ — a magyar matematikai szaknyelv és helyesírás; a
    projekt lényege: a szavak pontossága = a megértés), (c2) a `MiertJo`-tanulság
    (a propozíciók vs. típusok), (d) a `KisBetűsProjekcióCsapda` (a
    kisbetűs-név a bizonyítás TÍPUSÁBAN), (e) a `LetLáncProbe` (az
    állapot-lánc-csapda), (f) a tíz-parancsolat a tanulságok mappájából.
    Ha bármelyik kimarad, a kód biztosan megbukik a tanulság-csapdákon.

15. **A Cat³ (a kategóriák kategóriájának kategóriája) hierarchia
    (2026-08-19, a felhasználó utasítása: "kategóriák kategóriája a
    kategóriák kategóriájának a kategóriája").** A projekt magasabb
    kategóriaelméleti struktúrája:
    - `Cat^0 = Set` (halmazok kategóriája, 0-sejtek: objektumok).
    - `Cat^1 = Cat` (kategóriák kategóriája, 1-sejtek: funktorok).
    - `Cat^2 = Cat^Cat` (funktor-kategória, 2-sejtek: természetes
      transzformációk).
    - `Cat^3 = Cat^Cat^Cat` (3-kategóriák kategóriája, 3-sejtek:
      **módosítások** / modifications — a Mac Lane kocka két lapját
      kiegyenlítő 3-sejt).
    - `Cat^∞ = ∞-kategóriák` (az n-kategóriák sorozatának határértéke,
      az ∞-toposzok előfeltétele).
    A teljes Cat³ dokumentáció a `docs/Cat3_TeljesDokumentacio.md`
    fájlban található, a 10 boot-up szint részletes leírása a
    `docs/BootUp_10Szint_Teljes.md` fájlban, a teljes hivatkozáslista
    pedig a `docs/Hivatkozasok_Teljes.md` fájlban. Minden
    felfedezést dokumentálni kell — információveszteség nélkül.

16. **Információveszteség nélküli dokumentáció (2026-08-19, a
    felhasználó utasítása: "ne dobd el amit felfedeztel, ami ertekes
    azt ird le").** Minden felfedezést, hivatkozást, struktúrát,
    Refl-bizonyítékot, típus-definíciót, és gondolatmenetet
    dokumentálni kell. Az új felfedezések a `docs/` könyvtárba
    kerülnek (Markdown), az Idris-kód a `szima_ter/modul/`-ba.
    A "soha ne írj felül" szabály miatt a dokumentáció is ÚJ
    fájlokba kerül (nem a régit írjuk felül).

---

## 1a. /tmp TILOS (2026-08-17, a felhasználó utasítása)

**Soha nem írunk a /tmp-be.** Az újraindítás törli, és a munka nyoma elveszik.
Kísérleti/ideiglenes Idris-fájlok helye:
- a repón belül: `osveny_index/tanulsagok/` (a tanulság-fájlok archívuma), vagy
- az előre engedélyezett külső munkakönyvtár:
  `/var/folders/cw/4jhpxnwn47d7y4jyg2zgvpx80000gn/T/opencode`
Semmit nem törlünk onnan sem — archiválunk (l. `tanulsagok/OLVASD.md`).

## 2. Környezet / Environment

- macOS (arm64), shell `zsh`. `~/.zshenv` egy hiányzó `~/.cargo/env`-et hivatkozik — ártalmatlan, ne "javítsd" ki.
- Csomagkezelők: Homebrew (`brew`), npm (Node v25).
- opencode globális konfig: `~/.config/opencode/opencode.jsonc`. Perzisztens szabályok: `~/.config/opencode/AGENTS.md` (még nem létezik).
- opencode adat/auth: `~/.local/share/opencode/` (`mcp-auth.json`). Skill-ek: `~/.agents/skills/`.

## 3. Telepített Eszközök / Installed Tooling

- `gws` (Google Workspace CLI) v0.22.5 — `brew install googleworkspace-cli`.
- `gcloud` (Google Cloud SDK) — `brew install --cask google-cloud-sdk`. **Figyelem:** nincs PATH-on amíg a `path.zsh.inc` be nem töltődik; ha `gcloud` nem található, forrás: `/opt/homebrew/share/google-cloud-sdk/path.zsh.inc`.
- Telepített skill-ek: `bx`, `find-skills`, `firecrawl-research-index`, `research-agent`, `gws-gmail`, `szerver-ismeret`.
- MCP authentikálva: `exa-search`.
- Idris 2: `/opt/homebrew/bin/idris2` (0.8.0 verzió).

### Szerverek — Fontos Figyelmeztetés

**A `chickenloop` SSH alias NEM a Hetzner szerverre mutat.**
- `chickenloop` → SiteGround shared hosting (`gtxm1079.siteground.biz`)
- Hetzner IP (`88.99.218.155`) → Jelenleg nincs működő SSH hozzáférés
- **Minden szerver-elérés előtt:** használd a `szerver-ismeret` skill-et (`skill szerver-ismeret`) — a részletek ott vannak.
- **Soha ne tételezz fel** egy szerver identitását az IP alapján vagy az SSH alias alapján.

## 4. Gmail hozzáférés (gws-gmail skill)

- Szükséges: `gws` bináris (telepítve) + egyszeri Google OAuth bejelentkezés.
- `gws auth setup` interaktív (böngésző) és `gcloud` kell hozzá. `@gmail.com` fióknál az ellenőrizetlen alkalmazás 25-scope korlát vonatkozik, ezért egyedi scope-okkal jelentkezz be: `gws auth login --scopes gmail`.
- **Auth státusz: MÉG NEM KÉSZ.** Mielőtt feltételeznéd, hogy a Gmail működik, ellenőrizd: `gws gmail users getProfile`.
- Használat: `gws gmail +triage`, `gws gmail +read`, `gws gmail +reply --message-id <id> --body "..."`.

---

## 5. Bizalmas Fájlok — NE olvasd, ne írd ki, ne tedd elérhetővé

A ProtonDrive gyökérben (`~/Library/CloudStorage/ProtonDrive-chickenloop42@proton.me-folder/`):
- `1Password*.zip`, `1password-credentials*.json`, `1PasswordExport-*.1pux`
- `AccessKey.csv`, `RAM Access Key AliBaba.txt`, `R12.der`
- `proton-recovery-phrase.pdf`, `ai/dev/secret_1pw.env`
- Bármilyen `.env`, recovery kifejezés, vagy credentials fájl általában.

Ha egy feladat titkot igényel, kérdezd meg a felhasználót — ne kutakodj ezekben a fájlokban.

---

## 6. Felhasználó AI Kutatása (kontextus; ne szerkeszd)

- Aktív munka: `…/ai/dev/` (Obsidian vault, opencode forrás) és egy nagy kutatási dump `…/ai/` alatt: komplex értékű / temporális transzformerek (GPT-2 alapú), neurális hálózatok × QFT, és kapcsolódó arXiv preprint-ek.
- Több AI szolgáltatónál dolgozik (DeepSeek, Kimi, Gemini, Claude, Z.ai/GLM).

---

## 7. Git Használat / Git Usage

- `git init` megtörtént a `/Users/joco/opencode/` könyvtárban
- Snapshot minden 3. prompt után: `git add -A && git commit -m "snapshot N: rövid leírás"`
- `.gitignore`: `session-*.md`, `trail_index/build/`

### Idris 2 csapda: kisbetűs név a bizonyítástípusban (0.8.0)

Ha egy felső szintű deklaráció TÍPUSÁBAN csupusz **kisbetűs** definiált
név áll (pl. `bizKetto : kettoLeg = 2`), az elaborátor azt automatikusan
új implicit argumentumként köti be ("shadowing" figyelmeztetés), és a
`Refl` nem redukálódik. A nagybetűs konstansnév jó: `bizNagy : KettoLegNev = 2` átmegy.

Szabály: **a bizonyítástípusokban hivatkozott konstansok neve nagybetűvel
kezdődjön** (FanóNégy, NullaPont), vagy konstruktor-alkalmazás legyen.
Futásidejű kódban (érték jobboldalán) a kisbetűs név teljesen jó.

A csapda **függvény-argumentumként is él** (nem csak csupaszon): a
KisAI.idr esetében még a `tudastar kezdoKisAI = []` legegyszerűbb projekció
is elbukott, mert a `kezdoKisAI` kisbetűs konstans a bizonyítás TÍPUSÁBAN
implicit argumentummá vált. A szerkezetileg azonos önálló probe (minden
konstansa nagybetűs) átment — ezért a vak probe-ok nem találták meg.
Gyógyítás (MANTRA-konform): a kisbetűs definíció marad (futásidejű kód
használja), és mellé **nagybetűs alias** kerül a bizonyítások számára:
`public export KezdoKisAI : KisAI; KezdoKisAI = kezdoKisAI`.
Példa: `osveny_index/tanulsagok/KisBetűsProjekcióCsapda.idr`.

### Idris 2 csapda: a let-lánc felrobbanhat (0.8.0) — de a mechanizmus nyitott

A **mérés** (2026-08-18, KisAI.idr): ha egy konstans értékét egymásba
ágyazott let-kötések láncával építjük, a fordítási idő a lánc hosszával
erősen nőtt: 1 bejegyzés = 1.6 mp, 2 = 4 mp, 3 = 18.6 mp, 5 = "lefagyás".
A **megoldás** (lista-konstans + egyszeri konstrukció): ugyanarra az
eredményre 1.05 mp, az üres állapottal azonos. **Soha ne építs állapotot
let-lánccal — mindig lista + egy konstruktor.**

A **mechanizmus NEM ismert pontosan**: 7 féle minimalisztikus próba
(tanulsagok/LetLáncProbe/: primitív, összetett típusú, kétszintű,
projektoros, literálos, IO-használatos, típusaliasos lánc) MIND lineáris
(~0.22 mp, n=12-nél is). A robbanás tehát a let-lánc ÉS a teljes fájl
kontextusának (szótár, sok függvény, rekurzív IO) interakciója — a
hipotézisem ("a típusellenőrző újra kibontja az előző kötéseket") nem
állja meg minimálisan. **Akit érdekel, folytassa a bisectet** — a
bizonyíték-fájlok megvannak. Ez is tanulság: a "miért" megválaszolása
nem ér véget a működő megoldásnál; a mechanizmus-állítás is bizonyításra
szorul.

### A hibakeresés módja: bisect, nem próbálgatás (2026-08-18)

Ha valami "lefagy" vagy ismételten hibázik: **vissza az utolsó jó
állapothoz** (`git checkout <jó commit> -- <fájl>`), ellenőrizd, hogy
gyorsan fordul (ez a "kályha"), aztán **egyesével** rakd vissza a
változtatásokat, minden lépésnél mérve az időt. Így azonosítottuk a
let-lánc csapdát: a rekord-mező OK volt, a rekurzív függvények OK
voltak, a let-lánc volt a bűnös. A vak próbálgatás elveszíti az embert —
a bisect megtalálja a gyökérokot.

### Tanulság: mit bizonyít a Refl — és mit NEM (2026-08-17, közösen)

1. **A Refl csak azt bizonyítja, ami a kódban le van írva.** A kernel a
   bizonyítás típusának mindkét oldalát kiszámolja; ha eltér, nem fordul.
   A "bizonyítva" szó ennél többet NEM jelent.
2. **Köröző (tautologikus) bizonyítás nulla információ.** `E8Beirva = 240`
   + `E8Beirva = 240` bizonyítás — üres. Az érték a DEFINÍCIÓ és az
   ÁLLÍTÁS közti távolságban van: strukturált konstrukció (pl. 4·28 + 2⁷)
   ellenőrzése valódi munka, a kernel nem tud megtéveszteni.
3. **A legjobb minta: KÉT független út, egy híd.** `BizOktonionEgyenloE8 :
   OktonionEgysegekSzama = E8GyokokSzama` — két fogalmilag különböző
   konstrukció (16+224 oktonion egységek vs 112+128 rács-gyökök) kényszerítve,
   hogy ugyanarra fusson. Bármelyik oldal átírása a hidat automatikusan
   töri. Ilyet írjunk, ne `E8Beirva = 240`-at.
4. **A jelentést a numerika + irodalom fedezi, nem a Refl.** Hogy a 240
   tényleg az E8 gyökök ℝ⁸-beli halmaza: Idris-generált Python generálja
   a 240 vektort, méri norma²-t, skalárszorzatokat (simply-laced); a
   kanonikus izomorfizmust Conway–Sloane (SPLAG) fedezi.
5. **Az eszköztár**: Refl (kiszámolt egyezés) → cong (függvény emeli) →
   trans (bizonyítás-lánc) → rewrite (behelyettesítés; IRÁNYRA figyelni!)
   → ?lyuk + `:ps` proof search (interaktív). Részlet: trail_index/books/
   idris2_docs/theorems.rst, interactive.rst; web: idris2.readthedocs.io.
6. **Kimenetet soha nem jelenteni ki ellenőrizetlenül.** Előfordult:
   elgépelt shell-lánc kimenetét "eredménynek" mondtam (a "0 hiba"
   műtermék volt). A szabály: ha a lánc gyanús, EGYSZERűEN ÚJRAFUTTATNI
   tiszta fájlban — az olcsó, a félrevezetés drága. A GAUGE-elve rám
   is vonatkozik.

---

## 17. Mérési hiba-kötelezettség (2026-08-19, a felhasználó utasítása)

**Minden fizikai konstans összehasonlításnál a RELATÍV HIBÁT a MÉRÉSI
BIZONYTALANSÁGHOZ KÉPEST (Δ/σ) kell megadni — soha nem "σ" önállóan,
soha nem abszolút Δ a szövegben jelentéktelenedve.**

1. **Relatív hiba kötelező:** ha egy levezetett/szerkezeti értéket
   egy mérési értékkel hasonlítasz össze, a kimenet KÖTELEZŐen tartalmazza:
   `Δ = érték_levezetett − érték_mért`, `σ = a mérés abszolút
   bizonytalansága`, és `Δ/σ` (a relativ eltérés a mérési hibához képest).
   "σ" önmagában (pl. "6.5σ off") ÉRTELMEZhetetlen a σ_C definíciója
   nélkül — tilos ilyen állítást leírni a σ_C explicit megadása nélkül.
2. **Mérési hiba belevétele:** a CODATA (vagy más referencia) mérési
   bizonytalansága KÖTELEZŐ bemenet. Nem lehet "kerülő közelítés" néven
   figyelmen kívül hagyni. Ha a projekt egy konstanshoz "C_Mach×C_phon"
   közelítést ad, az közelítés hibáját (|közelítés − pontos| / |pontos|)
   is meg kell adni — nem "~17%" kijelentés a számolás nélkül.
3. **Saját dokumentum-ellenőrzés:** ha a projekt saját keretdokumentuma
   (pl. `trail_index/E9_framework.md`) olyan állítást tesz, amit a
   projekt SAJÁT számai cáfolnak (pl. "6.5σ off" amikor Δ/σ_C ≈ 40–75),
   a feladat NEM az állítás ismétlése, hanem a **hibák megjelölése** és
   a pontos érték kiszámítása. "Ne ismételj, hanem ellenőrizz."
4. **Kimenet-formátum:** minden fizikai konstans-összehasonlítás
   kimenete:
   ```
   érték_levezetett = <szám>
   érték_mért       = <szám> (σ = <bizonytalanság>, forrás: <CODATA év>)
   Δ                = <érték_levezetett − érték_mért>
   Δ/σ              = <relatív eltérés a mérési hibához képest>
   ```
   Ehhez tartozó Idris-modul kötelező (l. `MagyarKinaiTorvenyek_v3.idr`
   `deltaSzamitott` mintája). A dashboard a `delta.png`-n mutatja.

**Indoklás (2026-08-19):** a projekt korábbi keretdokumentuma "6.5σ off"
állítást tett a Horgony 137.036 vs CODATA 137.035999177(11) különbségre,
amit a saját számai cáfolnak (Δ = 8.23×10⁻⁷, σ_C = 1.1×10⁻⁸ → Δ/σ_C ≈
74.8; még a lazább σ_C ≈ 2.06×10⁻⁸ esetén is ~40σ). Ez a "haluhalmaz"
vektörétől jön — a megoldás a kemény relatív-hiba-kötelezettség.

---

## 18. Őszinte verifikáció — a "parasztvakítás" tilalma (2026-08-19)

**Minden "bizonyított" állítást a FORDÍTÓNak kell ellenőriznie; a
kommentben állított törvény és a típusban lévő állítás különbsége =
NEM bizonyított.**

1. **Tautológia = nem bizonyítás.** `4 = 4`, `(7,1,3) = (7,1,3)`,
   `X = X` Refl-lel — nulla információ, tilos "bizonyítottnak" nevezni.
   A bizonyítás-típus bal és jobb oldala KÜLÖNBÖZŐ konstrukció legyen
   (pl. `4 * 5 = 20`, `magyarAspektusToKinai X = Y`, `length lista = N`
   a lista enumerálásából). L. a "Tanulság: mit bizonyít a Refl" fent
   (2. pont) — ez most KEMÉNY szabály, nem tanulság.
2. **Komment vs. típus:** ha a `|||` dokumentációs komment "asszociativitást"
   állít, de a típus csak `X = X` — a komment NEM bizonyított. A típus
   az igazság; a komment csak szándék. A kettő különbsége = hiányzó
   bizonyítás, amit külön feladatként kell listázni.
3. **Független review kötelező:** minden jelentős modul-lánc kiadása
   előtt egy független alügynök (fris kontextus, l. `docs/Review_20260819_
   Fuggetlen.md` minta) ellenőrzi a bizonyításokat: valódi vs. tautológia
   besorolás, ellentmondás-keresés, hiányzó-törvény-lista. A review
   eredményét a `docs/`-ba kell menteni (információveszteség nélkül).
4. **Minden állítás kettős fedése:** a jelentést a (a) Idris-bizonyítás
   + (b) numerikus teszt + (c) irodalmi hivatkozás együtt fedik. Ha
   valamelyik hiányzik, az állítás "speculatív" jelölést kap (l.
   `source/quantum_language_engine/hypothesis_mdl_cpt.txt:107` mintája:
   "STATUS: SPECULATIVE" — ez a minta).
5. **A "GAUGE-elv" kiterjesztése:** ha egy shell-lánc kimenete gyanús,
   tiszta fájlban újrafuttatni (l. fent). Ugyanez vonatkozik a
   bizonyításokra: ha egy Refl "túl könnyen" lefordul, ellenőrizni, hogy
   a két oldal valóban különbözik-e. A "0 hiba" műtermék (elgépelt lánc)
   és a "0 hiba" valós (fordul) között a különbség: a valós futtatás
   kimenetének ÉRTELMEZhetőnek kell lennie, nem csak "exit 0"-nak.

**Indoklás:** a független review (2026-08-19) 67 bizonyításból 20-at
tautológiának talált, és a projekt saját `AltInverzMegtalalhato`
deklarációját a modul saját Refl-jei cáfolták. A "haluhalmaz" vád
részben jogos volt. Ez a szabály megakadályozza az ismétlődését.

---

## 19. ProtonDrive olvasás (2026-08-19, a felhasználó feloldása)

**A ProtonDrive olvasás SZABAD** (a felhasználó feloldotta 2026-08-19).
A `~/Library/CloudStorage/ProtonDrive-chickenloop42@proton.me-folder/`
tartalma olvasható, greppelhető, kutatható.

**KIVÉTEL** (továbbra is TILTVA, AGENTS §5):
- `1Password*.zip`, `1password-credentials*.json`, `1PasswordExport-*.1pux`
- `AccessKey.csv`, `RAM Access Key AliBaba.txt`, `R12.der`
- `proton-recovery-phrase.pdf`, `ai/dev/secret_1pw.env`
- Bármilyen `.env`, recovery kifejezés, credentials fájl.

A ProtonDrive-ban lévő kutatási anyagok (pl. `quantum_language_engine/`,
`Jul29_Kimi_Agent_Metaforikus_Fizika_File_Request/`) olvasása engedélyezett.
Ha a ProtonDrive lokálisan nem szinkronizált, a `gondnok-laptop/project/
target/all_sources/` index tartalmazza a ProtonDrive fájlok másolatait.

**SiteGround (`chickenloop` SSH alias): NEM.** A felhasználó kizárta.
**Hetzner (88.99.218.155): IGEN**, ha van működő SSH (a `szerver-ismeret`
skill ellenőrzi). Olvasás rendben, írás tilos (AGENTS §1).

---

## 20. SOHA SEMMIT NEM LEHET TÖRÖLNI (2026-08-19, a felhasználó utasítása)

**SOHA, SEMILYEN KÖRÜLMÉNYEK KÖZÖTT nem szabad fájlt törölni.**
Nem `rm`, nem `rm -f`, nem `git rm`, nem `git clean`, semmi destruktív.

- Ha egy ideiglenes fájl keletkezik (pl. `GCheck.idr`), az a repóban
  MARAD — archiváljuk a `osveny_index/tanulsagok/` vagy `szima_ter/modul/`
  könyvtárba, NE töröljük.
- A "soha ne írj felül" (AGENTS §13) és a "destruktív operációk tilva"
  (AGENTS §1) már léteznek, de a `rm` parancsot külön is TILTANI kell.
- Ha egy fájl feleslegessé válik, jelezd a felhasználónak, de NE töröld.

**Indoklás:** a felhasználó 2026-08-19-én kifejezetten tiltotta: "semit
nem lehet torolni soha". A `rm -f GCheck.idr` parancs megsértette ezt.

## 21. KUTATÁSI NAPLÓ — minden kérdés–válasz pusholva (2026-08-21, a felhasználó utasítása)

**Minden üzenetváltás (a felhasználó kérdése + az asszisztens válasza)
időbélyeggel a `kutatasi_naplo/` könyvtárba kerül, és pusholva lesz.**

- Formátum: `kutatasi_naplo/YYYY-MM-DD_<téma>_session.md` — egy fájl
  sessionenként, azon belül sorszámozott bejegyzések (KÉRDÉS / VÁLASZ),
  mindegyik időbélyeggel (vagy időhorgonnyal: commit-idő, fájl-mtime).
- A kérdést idézőjelben, szó szerint (nyelvtörés nélkül) őrzünk — a
  napló elsődleges forrás, információveszteség nélkül (AGENTS §16).
- A válasz összefoglalója + a létrejött fájlok/commitok listája.
- Minden napló-írás után: commit + push (l. §10 ritmus).

**Indoklás:** a felhasználó 2026-08-21-én: "remember, push our
conversations, each time my question and your answer with timestamp,
it's a research log". A kutatás láncolata így rekonstruálható.

## 22. NÉGYNYELVŰ VÁLASZOK ÉS KOMMENTEK (2026-08-21, a felhasználó utasítása)

**Minden válasz és kódkomment magyarul MEGY, mellé ahol lehetséges:
中文 (KRITIKUS — a felhasználó külön kérte), Deutsch, עברית.**

- Magyar az elsődleges nyelv (AGENTS §0); a 中文 / Deutsch / עברית
  rövid összefoglaló formájában jelenik meg (nem teljes fordítás,
  ha a hossz aránytalan — de a lényeg mind a négy nyelven).
- Idris-kommentek: a blokk-fejlécek és a kulcs-tanulságok négynyelvűek;
  a soronkénti kommentek maradhatnak magyar+kínai párosban.
- **A kínai NEM opcionális** — "kinai fontos, kritikus" (2026-08-21).
- **MINDEN git push ELŐTT KÜLÖN KIEMELÉS** (a felhasználó 2026-08-21-i
  utasítása: "a valasz 4 nyelvu! ezt kulon emeld ki minden push-elott"):
  az asszisztens a push előtt külön sorban jelzi:

    ★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★

- Ugyanez a szabály a perzisztens plugin-configban is:
  `~/.config/opencode/AGENTS.md` (§N1–§N4) — minden sessionbe betöltendő.

### 22a. A NÉGYNYELVŰ VÁLASZ SABLONA (pontos alak / exact template)

Minden válasz EZEN a formán készül, ebben a sorrendben:

```
[MAGYAR — a válasz TÖRZSE: a teljes válasz, listákkal, kóddal,
 számokkal, minden részlettel. Ez az elsődleges szöveg.]

**中文：** [a lényeg tömör összefoglalója kínaiul — KRITIKUS,
 mindig jelen van, soha nem maradhat el]

**Deutsch:** [die Kernaussage kurz auf Deutsch]

**עברית:** [תמצית התשובה בעברית]
```

És minden git push ELŐTT külön sorban (a §22 szerint):

```
★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
```

PÉLDA (helyes):

```
A 240 gyök két típusra bomlik: 112 darab (±1,±1,0⁶)-permutáció
és 128 darab (±½)⁸ páros mínusszal.

**中文：** 240 个根分为两类：112 个 (±1,±1,0⁶) 排列，128 个偶负号 (±½)⁸。

**Deutsch:** Die 240 Wurzeln zerfallen in 112 Permutationen (±1,±1,0⁶)
und 128 halbzahlige (±½)⁸ mit gerader Minuszahl.

**עברית:** 240 השורשים: 112 תמורות (±1,±1,0⁶) ו־128 מהצורה (±½)⁸ עם מספר זוגי של מינוסים.
```

ELLENPÉLDA (helytelen — eddig ilyen történt): a válasz magyarul,
és a többi nyelv csak "lábjegyzet-szerűen" elszórva, sablon nélkül.

## 23. SZÓRÓL SZÓRA, NINCS TÖMÖRÍTÉS — horog (2026-08-21, a felhasználó utasítása)

**Mindent szó szerint írunk le; a tömörítés = információvesztés (§16).**

1. **A felhasználó kérdése idézőjelben, SZÓRÓL SZÓRA** — nyelvtörés,
   elírás, dupla szóköz, kis- és nagybetű együtt marad (l. §21).
2. **A válasz NEM tömörített:** inkább TÖBB, mint kevesebb. Semmi
   el nem dobható — részletek, számok, hibaüzenetek, mérési idők,
   közbülső lépések mind bekerülnek.
3. **Szépen pontokba szedve:** listák, számozott szakaszok, táblázatok.
4. **A horog a pluginban is él:** `~/.config/opencode/AGENTS.md` §N5
   és a HOROG.md 8. szindrómája ("Tömörítek → SZÓRÓL SZÓRA").

Forrás: a felhasználó 2026-08-21-i utasítása szó szerint: "fontos, hogy
szorul szora irjal le mindent, nincsen tomorites !!! inkabb legyen tobb,
mint kvesebb es legyen szepen pontokba szedve, ez menjen ez a szabaly
is a pluginba mint horog".

## 24. KÓD DUPLIKÁCIÓ TILOS — PRIORITÁS (2026-08-21, a felhasználó utasítása)

**Meglévő függvényt IMPORTÁLNI kell, soha nem újraírni.
| 代码重复禁止 — 必须导入，不得重写！ | Codeduplikation VERBOTEN!**

1. **Új függvény írása ELŐTT KÖTELEZŐ:**
   a) grep a projektre — ugyanaz a NÉV vagy ugyanaz a SZIGNATÚRA;
   b) Prelude / Data.List ellenőrzés (elem, take, nub, filter, length,
      zipWith, all, any... — a standard könyvtár NEM írható újra);
   c) ha létezik: IMPORT (pl. `import E8TizenhatPenge` a gf2-höz).
2. **Kanonikus helyek nyilvántartása:**
   `osveny_index/tanulsagok/KódDuplikációAudit_*.md` — minden függvény
   egyetlen otthonnal; minden más modul importál.
3. **Refaktorálás §13 szerint:** új fájl / `_v2` suffix, a régi megmarad,
   információvesztés nélkül (§16, §20).
4. **A kernel a duplikáció szövetségese:** a hibás másolat Refl-en
   elbukik (l. gf2Pontszorzat "Mismatch 0 vs 2" — a másolás közben
   belopódzott per-tag-redukálási hiba).

Forrás (a felhasználó, 2026-08-21, szó szerint): "ne legyen kod
duplikacio!!!! ... keresd meg a problemat miert nem importalja, kod
duplikacio tilos !!! ez most prioritas ... kod duplikacio kinyirja az
egesz projektet, minden szetcsuszik, hasznalhatatlan lesz ... EZ TILOS !!!
kodot ujra kell hasznallni !!! nem ujra irni !!!!!"

## 25. ÉKEZETES MAGYAR A KÓDBAN — HARD RULE (2026-08-21, a felhasználó utasítása)

**Minden magyar szó a kódban (típusok, függvények, konstruktorok, változók,
kommentek, üzenetek) a HELYES ÉKEZETES alakján írandó.
| 代码中所有匈牙利语必须带完整变音符号！ | Alles Ungarische im Code mit
| vollständigen Diakritika! | כל ההונגרית בקוד עם סימני ניקוד מלאים!**

1. **Az Idris 2 teljes Unicode-azonosítókat támogat** — bizonyítva
   (ProbeUnikod, 2026-08-21): `SzóHáz`, `magánhangzóMélyÉ`, `négyzet`
   mind lefordulnak.
2. **Az ékezet NEM esztétika, hanem INFORMÁCIÓ**: a "Szotar" nem szó —
   a `Szótár` (hosszú á) az. A hosszú/különböző magánhangzók (ó/ő, ű/ú)
   jelentéskülönbséget hordoznak; ékezet nélkül a lexikon HAMIS.
3. **Új kód**: eleve ékezetesen írandó. **Régi kód**: refaktorhullámokban
   ékezetesítendő (_v3 generáció — §13: a régi marad, az új ékezetes).
4. **A válaszok, napló, commit-üzenetek UGYANÍGY** — magyarul mindig
   ékezetekkel.

Forrás (a felhasználó, 2026-08-21, szó szerint): "maga a kod is legyen
ekezetes, elvileg tud unikodot, nem ?" / "minden magyar szo legyen normalisan
kiirva teljesen a kodban es ekezetes" / "pl Szotar az hosszu o, csak azert
mert en ekezet nelkul irok... atool a kodban minden ekezetes legyen, minden
fuggveny, minden tipus, minden magyarul" / "ekezettel, ez hard rule, ird be
az osszes hook-ba"
