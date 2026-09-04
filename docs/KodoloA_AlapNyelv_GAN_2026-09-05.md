# Kódoló_A — „ALAP + NYELV" réteg GAN-ellenőrzés (2026-09-05)

**Fejléc / Header / 头部 / Kopf — NÉGYNYELVŰ:**

- **MAGYAR:** A Kódoló_A alügynök a Szima-projekt 16 fájlból álló „ALAP + NYELV"
  rétegét ellenőrizte GAN-módszerrel: minden fájlon valós `idris2 --check`
  futás (friss `build_gan_fris` build-dirrel, hogy a ttc-gyorsítótár ne hazudjon),
  Refl-minőség-vizsgálat, tartalmi tény-ellenőrzés (§18-2) és stílus-audit (§0/§4/§25).
  Eredmény: **14 TISZTA / 2 HIBA** a 16 valós futásból; a két hiba a
  `KeresoTabla.idr` (lezáratlan karakterlánc) és a `ZeneKategoria.idr`
  (az asszociativitás-Refl nem zár). A javítás NEM történt meg (§13: az
  örökölt fájlohoz nem nyúlunk — a _v2-hullámé). Új build-mappák keletkeztek
  (`osveny_index/build_gan_fris`, `szima_ter/modul/build_gan_fris`) — §20
  szerint NEM törlőnek, a felhasználó dönt sorsukról.
- **中文：** Kódoló_A 子代理对 Szima 项目的「ALAP + NYELV」层（16 个文件）
  做了 GAN 检查：每个文件都跑真实的 `idris2 --check`（用全新 build 目录防止
  缓存说谎），并审计 Refl 质量、内容事实（§18-2）与风格（§0/§4/§25）。
  结果：16 次真实运行中 **14 次干净 / 2 次失败**——`KeresoTabla.idr`
  （字符串未闭合）与 `ZeneKategoria.idr`（结合律 Refl 不闭合）。
  遵守 §13 不修改继承文件；新产生的 build 目录按 §20 不删除。
- **English:** The Kódoló_A sub-agent GAN-checked the 16-file "ALAP + NYELV"
  layer of the Szima project: a real `idris2 --check` run per file (fresh
  `build_gan_fris` build-dir so the ttc cache cannot lie), plus Refl-quality,
  content-fact (§18-2) and style audits (§0/§4/§25). Result: **14 CLEAN /
  2 FAILING** out of 16 real runs — `KeresoTabla.idr` (unclosed string) and
  `ZeneKategoria.idr` (associativity Refl does not close). No inherited file
  was modified (§13); the new build dirs are kept (§20).
- **Deutsch:** Der Sub-Agent Kódoló_A hat die 16 Dateien umfassende Schicht
  „ALAP + NYELV" des Szima-Projekts GAN-geprüft: ein echtes `idris2 --check`
  pro Datei (frischer Build-Ordner `build_gan_fris`, damit der ttc-Cache nicht
  lügt), dazu Refl-Qualitäts-, Inhaltsfakten- (§18-2) und Stil-Audits
  (§0/§4/§25). Ergebnis: **14 SAUBER / 2 FEHLERHAFT** von 16 echten Läufen —
  `KeresoTabla.idr` (unabgeschlossene Zeichenkette) und `ZeneKategoria.idr`
  (Assoziativitäts-Refl schließt nicht). Geerbte Dateien wurden nicht geändert
  (§13); die neuen Build-Ordner bleiben erhalten (§20).

---

## 1. A --check futások VALÓS eredménye (GAUGE-tanúság, szó szerinti kimenet)

Minden futás friss build-dirrel (`--build-dir build_gan_fris`), így minden sor
valódi elaborációt jelez (a „Building …" sorok a tényleges fordítás tanúi).

### 1a. TISZTA futások (14)

| # | Fájl | Szó szerinti kimenet lényege |
|---|------|------------------------------|
| 1 | `osveny_index/Alap/CsomagoltTipusok.idr` | `1/1: Building Alap.CsomagoltTipusok (Alap/CsomagoltTipusok.idr)` — exit 0 |
| 2 | `osveny_index/Alap/SzamT.idr` | `1/1: Building Alap.SzamT (Alap/SzamT.idr)` — exit 0 |
| 3 | `osveny_index/Alap/KategoriaT.idr` | `1/1: Building Alap.KategoriaT (Alap/KategoriaT.idr)` — exit 0 |
| 4 | `osveny_index/Alap/GrafT.idr` | `3/4: Building Kategoriak.MagyarOntologia (Kategoriak/MagyarOntologia.idr)` + `4/4: Building Alap.GrafT (Alap/GrafT.idr)` — exit 0 |
| 5 | `osveny_index/Alap/Hatar.idr` | `2/2: Building Alap.Hatar (Alap/Hatar.idr)` — exit 0 |
| 6 | `osveny_index/Alap/LagrangianT.idr` | `5/5: Building Alap.LagrangianT (Alap/LagrangianT.idr)` — exit 0 |
| 7 | `osveny_index/Alap/DependensSzamT.idr` | `1/1: Building Alap.DependensSzamT (Alap/DependensSzamT.idr)` — exit 0 |
| 8 | `osveny_index/KategoriaElmelet.idr` | `1/10 … 10/10: Building KategoriaElmelet` (épült: Steane713, E8E8Algebra, HaromKubit, Emberi.Index, Szamitasi.Index, MagyarNyelv, FogalomFa, FazisAlgebra) — exit 0 |
| 9 | `osveny_index/KategoriaStruktura/PrimekAnalizis.idr` | `2/2: Building KategoriaStruktura.PrimekAnalizis (…)` — exit 0 |
| 10 | `osveny_index/Kategoriak/MagyarOntologia.idr` | friss dirben a GrafT-futtás építette: `3/4: Building Kategoriak.MagyarOntologia` — exit 0 |
| 11 | `osveny_index/Kategoriak/ZeneiRetegek.idr` | `2/2: Building Kategoriak.ZeneiRetegek (…)` — exit 0 |
| 12 | `osveny_index/Teszt.idr` | `3/20 … 20/20: Building Teszt` (20 modul: MagyarNyelvtan, ModulRegisztracio, LawvereGodel, Szotar, Fonetika, FanoParitás, ErtelmezoSzotar, SteaneHamiltonian, LejeuneTranszformacio, HanMagyarKodolas, Kerdoszo, E8Gyokrendszer, DiracGammaMatricak, OktonionAlgebra, Komplex, DiracIdoFejlodes, …) — exit 0 |
| 13 | `szima_ter/modul/Alap/KategoriaT.idr` (szimlink) | `1/1: Building Alap.KategoriaT (Alap/KategoriaT.idr)` — exit 0; ttc-bizonyíték: `szima_ter/modul/build_gan_fris/ttc/2025081600/Alap/KategoriaT.ttc` |
| 14 | `szima_ter/modul/Kategoriak/MagyarOntologia.idr` (szimlink) | `2/2: Building Kategoriak.MagyarOntologia (Kategoriak/MagyarOntologia.idr)` — exit 0; ttc-bizonyíték: `szima_ter/modul/build_gan_fris/ttc/2025081600/Kategoriak/MagyarOntologia.ttc` |

A két szimlink célja `readlink`-kel igazolva: `../../../osveny_index/Alap/KategoriaT.idr`
illetve `../../../osveny_index/Kategoriak/MagyarOntologia.idr` — ugyanaz a
kanonikus fájl, a v2-útvonalas check SZÁMÍTÓGÉP-SZINTEN is átment.

### 1b. HIBÁS futások (2) — szó szerinti hiba-kimenet

**HIBA 1 — `osveny_index/Alap/KeresoTabla.idr`:**

```
Error: Bracket is not properly closed.

Alap.KeresoTabla:302:12--302:13
 298 |   putStrLn ("  Algebrák: " ++ show (length algebraStrukturak))
 299 |   putStrLn ("  Fizikai konstansok: " ++ show (length fizikaiKonstansok))
 300 |   putStrLn ("  Magyar lexikon: " ++ show (length magyarLexikon))
 301 |   putStrLn ""
 302 |   putStrLn "Kész.
                  ^

--- exit: 1 ---
```

Ok: a 302. sorban `putStrLn "Kész.` — hiányzik a záró `"` és a `)`. Az EGÉSZ
modul (484 sor minden rekordja, táblája) ezért most együtt sem fordul.
Csapda-rokon: #15 (lezáratlan/rossz idézőjel a Stringben).

**HIBA 2 — `osveny_index/Kategoriak/ZeneKategoria.idr`:**

```
Error: While processing right hand side of zeneAsszociativ. When unifying:
    zeneKompozicio (ZeneOsszetett _ _ _) (zeneKompozicio g h)
and:
    zeneKompozicio (zeneKompozicio (ZeneOsszetett _ _ _) g) h
Mismatch between: b and c.

Kategoriak.ZeneKategoria:120:45--120:49
 120 | zeneAsszociativ (ZeneOsszetett _ _ _) g h = Refl
                                                    ^^^^

Error: While processing right hand side of asszociativ. When unifying:
    zeneKompozicio (zeneKompozicio f g) h
and:
    zeneKompozicio f (kompozicio g h)
Mismatch between: c and b.

Kategoriak.ZeneKategoria:134:17--134:32
 134 |   asszociativ = zeneAsszociativ
                       ^^^^^^^^^^^^^^^
--- exit: 1 ---
```

Ok: a `zeneKompozicio` 3. klauzulája (77. sor) BAL-oldali összetettet ad
 vissza — az asszociativitás `ZeneOsszetett`-esetben indukciót igényelne,
definicionálisan NOL_NULL nem zár. A 121–122. sorok (második-arg `ZeneOsszetett`)
ráadásul a 120. catch-all mögött ELHÉRHETETLEN KLAUZULÁK.

---

## 2. Fájlonkénti GAN-táblázat (Refl-minőség, tartalmi tények, stílus, cél-megjegyzés)

Jelölés: **[H]** = tartalmi hiba a §18-2 szerint (komment/kimenet állít,
típus/kód nem támasztja alá); **[T]** = tautológia (X = X); **[BM]** = believe_me.

| Fájl | --check | Refl-minőség | Tartalmi tények | Stílus-jelzések | Háromnyelvű cél-megjegyzés |
|---|---|---|---|---|---|
| `Alap/CsomagoltTipusok.idr` | TISZTA | KIVÁLÓ: De Morgan (4-4 eset), `duplaTagadás`, `kizártHarmadik`, `sorBalEgység/sorJobbEgység` — bal oldal számított, jobb oldal konstruktor; „-- Kimenet: Refl" kommentek; ~30+ valódi bizonyítás, 0 tautológia | A fejléc „NINCS String/Nat/Bool/Double" állítása IGAZ — az egyetlen nyers `igazságÉrtéke : Igazság -> Bool` a dokumentált híd (61–67. sor); 18-esetrág-tétel irodalomhivatkozással | Teljesen ékezetes (Igazság, egyenlőE, duplaTagadás) — §25 mintafájl | MAG: a rendszer kanonikus csomagolt alapmodulja — nulla nyers típus, dokumentált Igazság→Bool híd. ZH: 系统的规范基础模块——无裸类型，唯一的 Igazság→Bool 桥有文档。EN: canonical boxed foundation — no naked types, single documented bridge. |
| `Alap/SzamT.idr` | TISZTA | JÓ: 10 Refl (`osszead EgyS EgyS = KettoS` stb.), mindegyik számított bal oldalú. **DE 1 tautológia [T]: `oktonioAlapokBizonyitas : NyolcS = NyolcS` (411. sor)** | **[H] Halott elágazás:** `kivon a b = if kisebb a b then NullaS else NullaS` (279. sor) — mindkét ág ugyanaz. **[H] Fejléc `KategoriaT EgeszSzam SzamMorf` és „CsoportT EgeszSzam" példaként sorolt instance-ok NEM LÉTEZNEK** a fájlban (FelcsoportSzamT/MonoidSzamT/CsoportSzamT interface-t senki nem valósítja meg) | Ékezet nélküli: EgeszSzam, OtS, TizS, HaromS, osszead, RendelezesT (helyesen RendelkezésT — elírás is), egyszegElem (egységelem), SzamKategoria, TizenotStruktura, oktonioAlapokSzama, TukorPrim, SzelPrim, szamTFom („Fom" rövidítés); `kisebb : a -> a -> Bool` nyers Bool a mag-interface-ben (§4) | MAG: 0–10-es egész számok data-ként, műveletek typeclass-ként. ZH: 0–10 整数为 data，运算为类型类；注意死分支与同义反复。EN: digits 0–10 as data, ops as typeclasses; watch the dead branch and tautology. |
| `Alap/KategoriaT.idr` | TISZTA | 0 Refl — a törvények a TÍPUSOKBAN élnek (asszociativ, balAzonos, jobbAzonos interface-mezők) — Curry–Howard, ez önmagában helyes | **[H] A fejléc „49 struktúra" (Awodey 39 + Mac Lane 10) — a fájlban pontosan 48 interface van (#1–#48)**; a 49. hiányzik | Ékezet nélküli: ElorerendezesT, refleksiv, tranzitiv, ReszbenrendezettHalmazT, TermeszetesTranszformacioT, VisszahuzasT, KitolasT, ExponencialT, KartezianusZartKategoriaT, MonoidalisKategoriaT, ZartKategoriaT, KanKiterjesztesT, ReprezentalhatoFunktorT, kompozicio, identitas, asszociativ, parositass/elagazass (elírás-gyanús dupla s); „EXPOENCIÁL" elírás a kommentben | MAG: 48 kategóriaelméleti struktúra typeclass-ként (a fejléc 49-et ígér). ZH: 48 个范畴论结构以类型类实现（头注却写 49）。EN: 48 category-theory structures as typeclasses (header promises 49). |
| `Alap/GrafT.idr` | TISZTA | JÓ: `uresUtHosszBizonyitas : pathHossz (UresUt …) = 0` számított bal oldalú | **[H] A főprogram KIÍRJA: „pathJobbAzonos : f ∘ id = f (indukció, Refl ✓)" (173. sor) — ilyen függvény/bizonyítás NINCS a fájlban** (grep: csak a putStrLn-stringben él). A fejléc nyíltan dokumentálja a mintaillesztés-kivételt (jó átláthatóság) | pathKompozicio mintaillesztése dokumentált stílus-kivétel; 124. sor sérült box-karakter („�"); „grafFom" rövidítés | MAG: gráf + szabad kategória Path-konstrukció a döntéshozóhoz. ZH: 图与自由范畴的 Path 构造，为决策系统服务。EN: graph + free-category Path for the decision system. |
| `Alap/Hatar.idr` | TISZTA | KIVÁLÓ: `körútBetű` 44 klauzula (mind számított körút vs. `Csak (BetűtFűz b ÜresSzöveg)`), `jelKörút` 13, `normalizáldNFD`, `normalizáldŐNFD` — a „44 Refl" komment Igaz | A „String CSAK itt" önszabály tart; %default total + dokumentált `covering` peremek | Majdnem teljesen ékezetes; kisebb hibák: `jelbölKarakter` (helyesen jelből), `szóStringÉsMaradék` vegyes angol; **`esetragDemo` 18 kötéses let-láncot használ** (a LetLánc-tanulság kerülendő mintája — itt lefordul, de kockázat) | MAG: az egyetlen String/Char-perem — NFC-normalizálás, digráf-barát körút-tételek. ZH: 全系统唯一 String/Char 边界——NFC 规范化与双字母友好往返定理。EN: the single String/Char boundary — NFC normalization and digraph-friendly roundtrip theorems. |
| `Alap/KeresoTabla.idr` | **HIBA** (302. sor) | 0 valódi bizonyítás (1 Refl-emlés, kommentben) | **[H] A beégetett `projektGraf` HAMIS függőségeket állít:** „Alap.KategoriaT ← Alap.SzamT", „Alap.KeresoTabla ← SzamT+KategoriaT", „Alap.DependensSzamT ← SzamT" — mindhárom modul valójában SEMMIT sem importál. A `kategoriaStrukturak = []` TODO a „49"-et ismétli (valójában 48) | **37 nyers String/Nat mező a magban (§4-sértés terv szerint); `CptRekord` — a CPT rövidítés AGENTS §0 szerint tiltott (kanonikus név: ToltesParitasIdo)**; „keresoTablaFom" rövidítés; cptPelda, modulKereses ékezet nélkül | MAG: a projekt memória-táblája — MOST LEZÁRATLAN STRING MIATT NEM FORDUL. ZH: 项目记忆表——因未闭合字符串当前无法编译。EN: the project's memory table — currently unbuildable due to an unclosed string. |
| `Alap/LagrangianT.idr` | TISZTA | 0 Refl (tiszta interface-réteg) | **[H] Az „L = T − V" törvény és a „default implementáció: lagrangian a (b ** lepes) = T − V" állítás csak KOMMENTBEN él — az interface-ben NINCS default test, és a `lagrangian` mező nem kötött `kinetikaiEnergia`-hoz/`potencialisEnergia`-hoz. A NoetherT „szimmetria ⟹ megmaradás" tételnek NINCS típus-szintű kifejezése** (csak két kapcsolat nélküli mező) | Nincs nyers Double (MANTRA betartva); ékezet nélküli: potencialisEnergia, idoFejlesztes, megmaradas, ValosTipusT, OsszeadasT/KivonasT/SzorzasT (importált nevek); „lagrangianFom" rövidítés; „RacionisTipus" elírás; hivatkozott „Alap/SuseksegT.idr" NEM LÉTEZIK | MAG: a döntéshozó Lagrangian–Hamiltonian–Noether interface-rétege (törvények egyelőre kommentben). ZH: 决策系统的拉格朗日–哈密顿–诺特接口层（定律暂只在注释中）。EN: the Lagrangian–Hamiltonian–Noether interface layer (laws still comment-only). |
| `Alap/DependensSzamT.idr` | TISZTA | JÓ Reflex (7+1=8 stb. számított), DE **[BM] `dimenzioKompozicio DimenzioLepes DimenzioLepes = believe_me "ket lepes"` (194. sor)** és **[BM] `dimenzioMorfolgia DimenzioLepes x = believe_me x` (215. sor)** — hamis morfizmus/funktor-akció sztringből/értékből öntve | A [[15,1,3]] összeállítások (emberiOldal=7, peremOldal=1, oktonioDimenzio) típusgarantáltak — jó; de a kompozíció-ként hirdetett `DimenzioLepes ∘ DimenzioLepes` futásidőben GARBAGE | Nyers Nat-konstansok (7,7,1 — mint típusindex elfogadható, de jelzendő); ékezet nélküli: oktonioTipus, Kombinalt, TukorPrim, szel; `vektorKonkat` (konkatenáció-rövidítés), `FinD/FZD/FSD` rövidítés-gyanú; `dimenzioMorfolgia` elírás; `hetPluszEgyNyolc` DUPlikálva van SzamT-vel (§24) | MAG: [[15,1,3]] dependens számok — jó indexelt típusok, DE két believe_me hamisítja a morfizmus-kompozíciót. ZH: [[15,1,3]] 依值数——类型索引好，但两处 believe_me 伪造复合。EN: [[15,1,3]] dependent numbers — good indexed types, but two believe_me fakes fake the morphism composition. |
| `KategoriaElmelet.idr` | TISZTA | 0 végrehajtható Refl (13 emlés kommentben); a törvények interface-típusokban | **[H-near] SAJÁT `KategoriaT` interface a saját `Kategoria` rekord mellett — párhuzamosan az Alap.KategoriaT-vel: KÉT KategoriaT él a projektben (§24-duplikáció)**; a fejléc-modulok (Steane713, FazisAlgebra stb.) mind felépülnek | Vegyes: `identitas/kompozicio/asszociativ` ékezet nélkül MELLETT `azonos/összetétel/MonoidálisKategoria/DuálisKategória` ékezetessel (félig migrált fájl); „példanyok" elírás; magyar mondatokban kínai „。" zárójel | MAG: a régebbi, félig ékezetes kategóriaelmélet-gyűjtemény — párhuzamos KategoriaT-vel. ZH: 较旧、半迁移的范畴论合集——与 Alap.KategoriaT 平行存在。EN: the older, half-migrated category-theory collection — parallel KategoriaT exists. |
| `KategoriaStruktura/PrimekAnalizis.idr` | TISZTA | VEGYES: JÓ-k — `E8DimenzioPrimek : 248 = 8 * 31`, `WeylPrimek : 696729600 = 16384 * 243 * 25 * 7` (számított felbontások); **DE 5 explicit TAUTOLÓGIA [T]: `47 = 47`, `29 = 29`, `7 = 7`, `3 = 3`, `2 = 2`** (§18 szerint nulla információ, „bizonyítás"-nak nevezve) | A matematikai felbontások (E8=2³·31, 240=2⁴·3·5, 496=16·31, 31=2⁵−1 Mersenne, 127=2⁷−1) HELYESEK és ellenőrzöttek; a HTML-adatok (54 node, 47 függőség) adatok, nem tétel-értékűek | Ékezet nélküli: FuggesekPrimek, OsszesElPrimek, TenylegesNodeokPrimek, SteaneTavolsagPrimek, KapuNemPrim, DuplikaltIdPrimek; „Nodeok" angol szó | MAG: E8/Steane-számok prímfelbontásai — jó felbontások mellé 5 tautológia csúszott be. ZH: E8/Steane 数的素数分解——分解正确，但混入 5 个同义反复。EN: prime factorizations of E8/Steane numbers — sound, but five tautologies slipped in. |
| `Kategoriak/MagyarOntologia.idr` | TISZTA | 1 Refl-emlés, ami KOMMENT — **[H] az utolsó komment „Kimenet: Refl (3 × 3 × 3 = 27 ✓)" (596. sor) ILYEN NÉVEN bizonyítást NEM talál a fájlban** | Szép típus-szintű ontológia (szó = típus, képző = KepzoT, rag = RagT); a 22-esethiba-rendszer (9+6+7) belül konzisztens, DE a CsomagoltTipusok „18 valódi esetrag" (É. Kiss) állításával MEGOLDATLAN KETTŐSSÉG | TÖRZSÉBEN erősen ékezet nélküli: SzamTipus, TerToTipus, JoTipus, GyujtemenyJK, CselekvesJK, AllapotJK, kepzo, minoseg, targy, IgeidoTipus, SzemleletTipus, JovoTipus, KovetkeztetettTipus; `CptIgeragozasTipus` — CPT-rövidítés (tiltott); kiíró-stringben töredezett kínai („人才的irotol too tipusok"); „MEO" rövidítés | MAG: minden szó önálló típus, képző és rag typeclass — String nélkül. ZH: 每个词都是独立类型，词缀与格为类型类——无 String。EN: every word its own type, derivations and cases as typeclasses — no String. |
| `Kategoriak/ZeneiRetegek.idr` | TISZTA | JÓ-k: `zeneiAlter…Bizonyitas` számított bal oldalú; DE **Oda és Himnusz bizonyítása SZÓ SZERINT AZONOS állítás kétszer** (mindkettő `HetesKonstruktor Egy … Egy = (Egy,Egy,Egy)`) | A 7-bit → (hang, fázis, idő) leképezés kommentje megegyezik a kóddal; „Ne félj 1110111" kommenthez nincs bizonyítás (csak 3 van) | Ékezet nélküli: Hangkozi, OktavH, Idomertekes, UtemHangsulyos, Szimultan, Emelkedo, Ereszkedo, remenytelenulZene, annyitSzivZene, balatoniNyarZene, ketHexameterZene; Show-stringek vegyes angolul („P-broken", „T-ep") | MAG: József Attila- és Himnusz-sorok 7-bites zenei rétege (hang, ritmus, dallam). ZH: 奥洛夫诗与《颂歌》的 7 位音乐层（音、节奏、旋律）。EN: the 7-bit musical layer (tone, rhythm, melody) of the poem corpus. |
| `Kategoriak/ZeneKategoria.idr` | **HIBA** (120, 134) | A 116–119. „temperált/tiszta" esetek jók; **a 120. catch-all Refl NEM ZÁR (hiányzó indukció), a 121–122. klauzula elérhetetlen** | **[H] A komment „Ez garantálja az asszociativitást definíció szerint (Refl)" (72. sor) és „Refl minden esetre" (99–100. sor) HAMIS** — épp a ZeneOsszetett esetben nem definicionális | Ékezet nélküli: ZeneOsszetett, zeneKompozicio, zeneAsszociativ, zeneIdentitas, Temperalt; „morfizus" elírás (53. sor); KvintO/OktavO rövidítés-szerű, de zenetermészetes | MAG: a hangközök kategóriája — MOST NEM FORDUL, mert az asszociativitás indukciót igényel. ZH: 音程范畴——当前无法编译：结合律需归纳证明。EN: the category of intervals — currently unbuildable: associativity needs induction. |
| `Teszt.idr` | TISZTA (20 modullal) | JÓ-k: `bizKubitXor*`, `bizKleeneFixpont`, `bizNoether*` — mind számított bal oldalú, 0 tautológia az Adat-ból láthatóban | A fejléc kétszintű filozófiája (Refl + Show) következetesen végigvitt; `%hide` az importok VÉGÉN — csapda #3/#4 szabályos gyógyír | `showK` segéd (rövidítés-szerű, de dokumentált); Show-stringek ékezet nélkül | MAG: az áttekintő teszt — fordítási Reflex + tiszta Show-értékek két szintje. ZH: 概览测试——编译期 Refl 与纯 Show 值两层。EN: the overview test — compile-time Refls plus pure Show values. |
| `szima_ter/modul/Alap/KategoriaT.idr` (szimlink) | TISZTA | = az `Alap/KategoriaT.idr`-é (azonos inode) | — | — | MAG: híd-szimlink a kanonikus KategoriaT-hez — a v2-útvonalból fordul. ZH: 指向规范 KategoriaT 的桥接符号链接，可从 v2 路径编译。EN: bridge symlink to canonical KategoriaT — compiles from the v2 path. |
| `szima_ter/modul/Kategoriak/MagyarOntologia.idr` (szimlink) | TISZTA | = az `Kategoriak/MagyarOntologia.idr`-é | — | — | MAG: híd-szimlink a kanonikus MagyarOntologia-hoz — fordul. ZH: 指向规范 MagyarOntologia 的符号链接，可编译。EN: bridge symlink to canonical MagyarOntologia — compiles. |

---

## 3. Összefoglaló mondat-ciklusban (HU → 中文 → EN → DE)

A tizenhat valós futásból tizennégy tiszta, kettő hibás.
十六次真实运行中，十四次干净，两次失败。
Out of sixteen real runs, fourteen were clean and two failed.
Von sechzehn echten Läufen waren vierzehn sauber, zwei fehlerhaft.

A két blokkoló hiba: a KeresoTabla lezáratlan karakterlánca és a ZeneKategoria nem záruló asszociativitás-Reflje.
两个阻断性错误：KeresoTabla 的未闭合字符串与 ZeneKategoria 不闭合的结合律 Refl。
The two blocking errors: KeresoTabla's unclosed string and ZeneKategoria's non-closing associativity Refl.
Die beiden blockierenden Fehler: die unabgeschlossene Zeichenkette in KeresoTabla und der nicht schließende Assoziativitäts-Refl in ZeneKategoria.

A legmélyebb sebhely a DependensSzamT két believe_me-je, mert ott a TÍPUS hazudik a futásról.
最深的伤疤是 DependensSzamT 的两处 believe_me，因为类型在对运行时说谎。
The deepest scar is DependensSzamT's two believe_me's, because there the TYPE lies about the runtime.
Die tiefste Narbe sind die beiden believe_me in DependensSzamT, denn dort lügt der TYP über die Laufzeit.

A tautológiák (47=47 ötözete, NyolcS=NyolcS) nem hamisak, csak üresek — §18 szerint le kell őket cserélni valódi két-konstrukciós állításokra.
同义反复（47=47 五个、NyolcS=NyolcS）不假但空洞——按 §18 应换成真正的双构造命题。
The tautologies (the 47=47 quintet, NyolcS=NyolcS) are not false, just empty — per §18 they must be replaced by genuine two-construction propositions.
Die Tautologien (das Quintett 47=47, NyolcS=NyolcS) sind nicht falsch, nur leer — laut §18 sind sie durch echte Zwei-Konstruktionen-Aussagen zu ersetzen.

A legjobb minták a CsomagoltTipusok (ékezet + De Morgan) és a Hatar (44 körút-Refl) — ezek a kanonikus stílus.
最佳范例是 CsomagoltTipusok（全变音符 + 德摩根定律）与 Hatar（44 个往返 Refl）——这是规范风格。
The best exemplars are CsomagoltTipusok (full accents + De Morgan) and Hatar (44 roundtrip Refls) — this is the canonical style.
Die besten Vorbilder sind CsomagoltTipusok (volle Diakritika + De Morgan) und Hatar (44 Rundweg-Refls) — das ist der kanonische Stil.

## 4. Top-javítandók (prioritás-sorrend; MIND _v2-hullám, örökölt fájlhoz nem nyúlunk)

1. **`Alap/KeresoTabla.idr:302`** — záró `"` és `)` hiányzik; az egész modul blokkolva. Plusz a `projektGraf` hamis függőségei és a `CptRekord` CPT-rövidítés a _v2-ben javítandó.
2. **`Kategoriak/ZeneKategoria.idr:120`** — a `zeneAsszociativ` ZeneOsszetett-esete indukciós bizonyítást igényel (vagy jobb-oldali normalizáló kompozíció), a 121–122. elérhetetlen klauzulák eldobandók (a _v2-ben).
3. **`Alap/DependensSzamT.idr:194,215`** — a két `believe_me` helyett valódi `DimenzioLepesKetto` konstruktor vagy indukciós bizonyítás.
4. **Tautológiák [T]** — `PrimekAnalizis` 47=47/29=29/7=7/3=3/2=2 és `SzamT:411` NyolcS=NyolcS: valódi tartalommal helyettesítendők (pl. `47 = 46 + 1` számított formában vagy törlés-jelölés a jegyzékben).
5. **Fejléc-ígéretek [H]** — `KategoriaT.idr` 48≠49; `GrafT.idr:173` kód nélküli kijelzett bizonyítás; `MagyarOntologia.idr:596` ígert Refl nélküli komment; `LagrangianT.idr` komment-törvények típusba írása; `SzamT.idr:279` halott elágazás.
6. **Ékezetesítési hullám (§25)** — a lista fájlonként a táblázatban; a CsomagoltTipusok és a Hatar a minta.
7. **§24-duplikációk** — KategoriaElmelet saját KategoriaT-je; SzamT/DependensSzamT azonos nevű Reflex; ZeneiRetegek Oda=Himnusz dupla bizonyítás.

---

*Készítette: Kódoló_A alügynök, 2026-09-05. Fordító: Idris 2, version 0.8.0
(/opt/homebrew/bin/idris2). Minden --check futás friss build-dirben
(`build_gan_fris`) történt; a keletkezett ttc-mappák megmaradnak (§20).*
