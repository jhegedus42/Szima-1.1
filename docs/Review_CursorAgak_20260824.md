# Review: Cursor-ágak — merge-döntés előkészítése (2026-08-24)
# Review: Cursor branches — merge decision preparation
# Review: Cursor-Ágak — Merge-Entscheidung vorbereiten
# סקירה: ענפי Cursor — הכנת החלטת מיזוג

**Szerep:** csak-olvasó review (`git log` / `git diff` / `git show` / `git merge-tree` / ideiglenes `git worktree`).
**Szabályok:** §20 (nem törlünk), §13 (nem írunk felül) — mindkét ág tisztán additív, semmi nem íródik felül.
**Build-teszt:** `origin/cursor/idris-javitasok-d1f8` kipróbálva worktree-ben:
`/var/folders/cw/4jhpxnwn47d7y4jyg2zgvpx80000gn/T/opencode/cursor-idris-review`
(a worktree a §1a szerinti engedélyezett temp-könyvtárban marad, nem törlöm).

---

## 1. Ág: `origin/cursor/idris-javitasok-d1f8` — MERGE-ÖLENDŐ ✅

### 1.1 Mit tartalmaz / What it contains / Inhalt / תוכן

18 commit, **+3332 sor, 10 új fájl**, mind a `osveny_index/FuggetlenLevezetes/`
könyvtárban — a master nem rendelkezik ezzel a könyvtárral, tehát a merge
**konfliktusmentes** (merge-base: `9479b9b`).

| Fájl | Sor | Tartalom |
|---|---|---|
| `E8SteaneLevezetes.idr` | 829 | véges felsorolással: [8,4,4] kiterjesztett Hamming → [7,4,3] Hamming → [[7,1,3]] CSS-konstrukció |
| `MagyarTeriTetrakod.idr` | 665 | magyar térbeli esetek ternáris tetrakódja, ternáris Hamming-gömb mérete |
| `ParitasBuborek.idr` | 562 | a C₇/C₇-duális hányados mint „paritásbuborék" — normalizátor 256, stabilizátor 64, négy 64-es logikai mellékosztály |
| `AffinE8KarakterLevezetes.idr` | 544 | affin E₈-karakter véges levezetése, egész együtthatós karakterkocka |
| `OLVASD.md` | 457 | dokumentáció: mit bizonyít a fordító, mit nem |
| `FuggetlenLevezetes.ipkg` + `Foprogram` + `KorabbiNumerikusEllenorzes` | 45 | csomag + főprogram + korábbi numerika átvétele |
| `Tanulsagok/ParitasMagProba.idr` | 83 | tanulság: a törölt koordináta paritása = C₇-duális magja |
| `Tanulsagok/PauliOsztalyProba.idr` | 147 | **fő tanulság**, l. 1.3 |

### 1.2 Fordul-e? / Does it build? / Kompiliert es? / האם זה מתקמפל?

**IGEN — tesztelve.** `idris2 --build` a worktree-ben:
`1/6 … 6/6` modul + futtatható `e8-steane-levezetes` — **exit 0, nulla hiba**.

### 1.3 A PauliOsztalyProba tanulság / The PauliOsztalyProba lesson

Az ágExplicit nevezetes megállapítása (a fájl saját kommentjében): a
`KozvetlenLogikaiPauliTavolsag` Refl-normalizálása **Idris 2 0.8.0 alatt több
mint egy percig fut** — ezért a fő modul a már bizonyított klasszikus
mellékosztály-távolságot használja, a probe pedig futásidejű független
ellenőrzésként marad meg. Ez illeszkedik a projekt let-lánc / teljesítmény-
csapda tanulságcsaládjába (AGENTS §13). A fájl emellett 6 darab valódi
Refl-t hordoz (256/64 darabszámok, négy 64-es osztály, stabilizátor = nullaosztály).

### 1.4 Stílus-észrevételek (nem blokkolók)

1. **Ékezet nélküli azonosítók** (`Foprogram`, `Korabbi`, `KetszazOtvenhat`,
   `listaParok`) — §25 szerint ékezetes kellene legyen (`Főprogram`,
   `Korábbi`, `KétszázÖtvenhat`). Javaslás: merge után `_v2`-hullámban
   ékezetesítés (§13: a régi marad).
2. **Pattern matching a Tanulsag-fájlokban** (`jelVagy`, `listaParok`,
   `minimumPauliTartoSuly`) — az idris-stilus „SOHA pattern matching"
   szabálya szerint eltérés, de tanulság-probe-ként tolerálható; a fő modulok
   (pl. `E8SteaneLevezetes.idr`) típusvezéreltek.
3. **Nem duplikáció, hanem kettős út:** a csomag tudatosan NEM importálja a
   projekt meglévő algebrai moduljait — ez a §24-gel látszólag feszül, de
   megfelel az AGENTS „KÉT független út, egy híd" elvének (független
   levezetés = valódi ellenőrzés). A `KorabbiNumerikusEllenorzes.idr` az
   korábbi kódtételeket „átlátszatlanul" (opaque) veszi át, nem másolja.

### 1.5 Javaslat

**(a) MERGE-ÖLENDŐ, egészben.** Additív, önálló csomag, fordul, konfliktusmentes,
a §20/§13 szabályoknak maradéktalanul megfelel. Az ékezetesítés utólagos
`_v2`-hullám feladata.

---

## 2. Ág: `origin/cursor/literature-aaa6` — RÉSZLEGES / MERGE kis javítással ⚠️

### 2.1 Mit tartalmaz / What it contains

4 commit, +987 sor, 18 fájl (merge-base: `6d3fe0b`):

- **Literatúra-térkép:** `docs/Literatura_Terkep_Teljes.md` (311 sor, mermaid
  + hivatkozási gráf), `docs/Literatura_INDEX.md`, `docs/adatok/literatura_index.json`.
- **Böngésző nézet:** `docs/literatura.html` (230 sor) — a literatúra-kártyák
  kereshető HTML-nézete.
- **Deploy infrastruktúra:**
  - gyökér `vercel.json`: `buildCommand = bash docs/scripts/vercel-build.sh`,
    `outputDirectory = docs`, `cleanUrls` — **Vercel ág-preview** (minden ág
    külön URL-t kap);
  - `docs/vercel.json`: ugyanaz, ha a Vercel Root Directory = `docs` (kommentje
    szerint a gyökér a kanonikus);
  - `docs/scripts/vercel-build.sh` (75 sor): ág-meta generálása
    (`docs/adatok/preview_meta.json`, gitignore-olt);
  - `.github/workflows/deploy-docs-pages.yml`: GitHub Pages deploy, trigger
    `master` + `cursor/literature-aaa6` ágra, `docs/**` útvonal-szűréssel.
- **Preview-banner:** `docs/_preview/banner.css` + `banner.js`, és a banner
  beszúrása 6 meglévő HTML fejébe (`index`, `attekintes`, `dashboard`,
  `carnot_entropia`, `vizualizaciok`, `zitterbewegung` — egyenként +2 sor).

### 2.2 Ütközések / Conflicts / Konflikte / התנגשויות

`git merge-tree` (merge-base `6d3fe0b`): **2 szöveges ütközés**, mindkettő triviális:

1. **`.gitignore`** — mindkét oldal a fájl végére fűzött eltérő blokkot:
   - master: `zene_es_zaj/sziami_audio/` (Sziámi hangfájlok);
   - ág: `docs/adatok/preview_meta.json` (Vercel build-meta).
   **Megoldás: mindkét blokk megtartása** (egymás alá).
2. **`docs/index.html`** — master: hiányzó záró újsor javítása; ág: banner-link
   a `<head>`-be. **Megoldás: mindkettő megtartása** (banner + újsor).

**Funkcionális átfedés (nem szöveges ütközés, de döntést kíván):** a master
rendelkezik `.github/workflows/pages.yml`-lel; az ág új
`deploy-docs-pages.yml`-t ad — a kettő azonos `concurrency: group: pages`
csoporttal párhuzamosan deployolna. Merge-nél **EGY deploy-utat kell
választani**: vagy a meglévő `pages.yml` marad és az új workflow triggerét
ki kell venni (a fájl §20 szerint megmarad, csak nem fut), vagy fordítva.
Emellé az új workflow `cursor/literature-aaa6`-ra is triggerel — merge után
ez az ágnév elavult, tisztítandó.

### 2.3 Javaslat

**(b) RÉSZLEGES / MERGE kis javítással.** Maga a tartalom (térkép, index,
literatura.html, Vercel-konfig) értékes és additív; a merge megengedett, DE:
- a 2 szöveges ütközést kézzel oldjuk fel (mindkét oldalt megtartva);
- a dupla Pages-deploy-ból egyet válasszunk (javaslat: a meglévő `pages.yml`
  maradjon aktív; az új workflow fájl maradjon a repóban, trigger nélkül);
- a banner-injektálás 6 meglévő HTML-t ÉRINT (head +2 sor) — §13 szellemében
  ez módosítás, nem felülírás; ha ez elfogadható, az ág egésze mehet.

---

## 3. Összegzés táblázat / Summary table / Zusammenfassung / סיכום

| Ág | Commit | Sor | Fordul? | Ütközés | Javaslat |
|---|---|---|---|---|---|
| `cursor/idris-javitasok-d1f8` | 18 | +3332 | **IGEN (tesztelve)** | nincs | **(a) MERGE egészben** |
| `cursor/literature-aaa6` | 4 | +987 | — (docs/config) | 2 triviális + dupla Pages-deploy | **(b) MERGE kis javítással** |

**中文：** 两条 Cursor 分支均可安全合并。`idris-javitasok-d1f8`（18 个提交，+3332 行）：独立的 E8→Steane 推导包，在临时 worktree 中实测编译通过（6/6 模块，exit 0），全部为新文件，无冲突——建议整体合并。`literature-aaa6`（4 个提交，+987 行）：文献地图、literatura.html、Vercel 分支预览与 GitHub Pages 部署；仅 `.gitignore` 与 `docs/index.html` 两处琐碎冲突（两边改动都保留即可），但会引入第二个 Pages 部署工作流，须二选一。风格注意：Idris 标识符暂无变音符号（§25），合并后以 `_v2` 波次补齐。

**Deutsch:** Beide Cursor-Äste sind sicher mergbar. `idris-javitasok-d1f8` (18 Commits, +3332 Zeilen): eigenständiges E8–Steane-Herleitungspaket, im Worktree testweise kompiliert (6/6 Module, Exit 0), nur neue Dateien, konfliktfrei — ganz mergen. `literature-aaa6` (4 Commits, +987 Zeilen): Literatur-Landkarte, literatura.html, Vercel-Branch-Preview und GitHub-Pages-Deploy; nur zwei triviale Konflikte (.gitignore, docs/index.html — beide Seiten behalten), aber doppelter Pages-Workflow erfordert eine Entscheidung. Stil: Idris-Bezeichner ohne Diakritika (§25), später per `_v2`-Welle ergänzen.

**עברית:** שני ענפי ה־Cursor בטוחים למיזוג. `idris-javitasok-d1f8` (18 התחייבויות, ‏+3332 שורות): חבילת גזירה עצמאית E8→Steane שנבדקה ב־worktree ומתקמפלת (6/6 מודולים), כולה קבצים חדשים ללא התנגשויות — מומלץ למזג כמות שהוא. `literature-aaa6` (4 התחייבויות, ‏+987 שורות): מפת ספרות, דף עיון, תצוגה מקדימה לכל ענף ב־Vercel ופריסת Pages; שתי התנגשויות שוליות בלבד (.gitignore, docs/index.html — לשמור את שני הצדדים), אך נוצר זרימת Pages כפולה ויש לבחור אחת.
