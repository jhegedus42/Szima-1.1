# ÁLLAPOT — a külső determinisztikus irányító állapotfájlja
# 状态文件——外部确定性控制器 · Version 1 (2026-09-04)

**Ez az EGYETLEN fájl, amit a munka folytatásához be kell tölteni.**
A kontextus törlődhet; az állapot itt él, kívül. Az ébredés determinisztikus
eljárás — nem emlékezés, hanem OLVASÁS.
**这是恢复工作唯一必须载入的文件。上下文可能被清空，状态存于外部；苏醒是确定性流程——不是回忆，而是读取。**

---

## ÉBREDÉSI PROTOKOLL / WAKE-UP PROTOCOL / 苏醒协议

### MAGYAR (elsődleges / primary)

1. **Olvasd ezt a fájlt** (`osveny_index/irányító/Állapot_v1.md`) — a jelenlegi
   fázis, a BFS-sor, a lépésszám és a következő lépés lent van.
   [Hivatkozás: `AGENTS.md` §14 boot-up szekvencia — ez a „munka-boot",
   amely a folytatáshoz ELÉG; a „nagy" boot (3 MD + skill-ek) új sessionben
   a munka-boot UTÁN tölthető be.]
2. **Három kópia egyezése (7-1-3 / [[7,1,3]] logika):**
   (a) ez a fájl, (b) az `osveny_index/Irányító_v1.idr`-beli sor-adat,
   (c) a `git log` utolsó commit-üzenetének lépésszáma.
   Ha eltérnek → GAN-alügynökök 2-a-3-ellen többségi szavazása dönt,
   a javítás a `kutatasi_naplo/`-ba csapdaként kerül. Egy kópia sérülése
   javítható — ez a távolság-3 stabilitás. [AGENTS §18, §20]
3. **Futtasd:** `idris2 --exec főciklus osveny_index/Irányító_v1.idr`
   (az `osveny_index/` könyvtárból). A gép kiírja a következő EGY lépést.
   `következőLépés : Állapot -> Lépés` — tiszta függvény; a GÉP dönt,
   én csak végrehajtok. [AGENTS §3: a számolás Idrisben]
4. **Végrehajtás PONTOSAN EGY lépést** — egy fájl szerepkörének rögzítése /
   egy wiki-lap generálása / egy él GAN-ellenőrzése / egy könyvfejezet
   alügynökkel. Könyvet ÉN soha nem olvasok — csak alügynök.
   [AGENTS 11. szabály]
5. **Zárás:** e fájl frissítése (lépésszám +1, sorból a kész lépés törölve —
   ez NEM „törlés" a §20 értelemben, hanem az állapotgép átmenete) →
   `git add -A && git commit && git push` → `kutatasi_naplo/` bejegyzés.
   [AGENTS §10, §21, §22]
6. **Tiltók érvényben ébredéskor is:** nincs fájltörlés (§20), nincs
   felülírás (§13: új fájl / `_v2`), nincs Python a munkafolyamatban (§3),
   rövidítések tiltva (§0), ékezetes magyar (§25), kód-duplikáció tilos (§24),
   szerverre írás tilos (§1).

### ENGLISH

1. Read this file — the current phase, BFS queue, step count, next step.
2. Three-copy consistency: this file + the queue data in `Irányító_v1.idr`
   + the step number in the last `git log` commit. Divergence → 2-of-3
   GAN majority vote; log the fix as a csapda in `kutatasi_naplo/`.
   [[7,1,3]] logic: one damaged copy is correctable.
3. Run `idris2 --exec főciklus Irányító_v1.idr` — the machine prints the
   next SINGLE step. The pure function decides; I only execute.
4. Execute EXACTLY ONE step. Books are read by subagents only.
5. Close: update this file (step +1, done step removed from queue) →
   commit + push → napló entry.
6. Bans on wake: no deletion, no overwriting, no Python, no abbreviations,
   accented Hungarian, no code duplication, no server writes.

### 中文

1. 读取本文件——当前阶段、BFS 队列、步数、下一步。
2. 三副本一致（7-1-3）：本文件＋`Irányító_v1.idr` 中的队列数据＋git 最后提交中的步数；
   分歧→GAN 子代理 2/3 多数表决，修正并作为陷阱记入 `kutatasi_naplo/`。单份损坏可纠。
3. 运行 `idris2 --exec főciklus Irányító_v1.idr`——机器打印下一个唯一步骤；纯函数决策，我只执行。
4. 只执行一步；书只由子代理读。
5. 收尾：更新本文件（步数＋1，完成步骤出队）→ commit＋push → 写日志。
6. 苏醒后禁令同样有效：不删除、不覆盖、禁 Python、禁缩写、匈牙利语全变音符、禁代码重复。

---

## AKTUÁLIS ÁLLAPOT (2026-09-05, 11 lépés után) / CURRENT STATE

- **Lépésszám:** 11 (a 4. lépés után a NÉGY hullám összesen 7 lépéssel
  gyarapított: 5–7 = hullám-1…3, 8–11 = hullám-4 integrációja)
- **Fázis:** 2→3 — a gráf és a wiki v1 készen; a NÉGY GYÓGYÍTÓ-ELLENŐRZŐ
  HULLÁM lefutott, a zászlóshajók egy helyen, gépileg Ellenőrizve
  (Hullam4Teszt_v1: **17/17 teszt OK**, 2026-09-05)
- **Fázissor:** 0 Felmérés → 1 Rendterv → 2 TudásGráf → 3 BFS-hullám →
  4 Könyv-alügynökök → 5 7-1-3 tartalom-háromszögelés → 6 Wiki-lapok →
  7 Gráf-lezárás (ismétlés 3→6 amíg nincs új csomópont és nincs
  ellenőrizetlen él)
- **BFS-sor (következő lépések sorrendben):**
  1. **Hullám 4 — integráció (ez a lépés; e frissítéssel zárul):**
     `osveny_index/Hullam4Teszt_v1.idr` — a 12 új modul egy helyen
     importálva + 17 Show-teszt + a NÉGYNELVŰ fájl-teszt; fordítás:
     `cd osveny_index && IDRIS2_PATH=/Users/joco/opencode/szima_ter/modul/build/ttc idris2 Hullam4Teszt_v1.idr -o hullam4_teszt && ./build/exec/hullam4_teszt`
  2. Hullám-5 jelölt: a 51 .py maradék JEGYZÉKE (csak jegyzék — a
     törlés §20 szerint továbbra is tiltott; Idrisbe-írás értékelés)
  3. Hullám-5 jelölt: lexikon-lista-optimalizálás
     (HungarianLexicon_v1_Szima: 3460 bejegyzés List String-ben —
     cápa-kezdet, hossz-állítások költsége; csak ÚJ `_v2` fájlban, §13)
  4. Hullám-5 jelölt: a wiki regenerálása az új számokkal
     (ProjektTérkép.idr → docs/projekt_terkep_wiki.html)
  5. … (a BFS a gráf lezárásáig bővíti)
- **Elvégzett lépések (előzmény):**
  1. ✅ `docs/FajlrendszerFelmérés_v1.md` (~89 elem, 6 szimlink-tábla)
  2. ✅ `docs/FajlrendszerRendterv_v1.md` (6 javaslat; mozgatás NEM történt)
  3. ✅ `osveny_index/TudásGráf_v1.idr` (17 csomópont: 1 cél + 8 + 8; 4 Refl)
  4. ✅ `osveny_index/ProjektTérkép.idr` → `docs/projekt_terkep_wiki.html`
     (28 755 bájt, Idris-generált, HU/ZH/EN/DIRAC fülek)
  5. ✅ Hullám-1: GAN-auditok + 7 gyógyítás (a régi bizonyítások
     tautológia-vadászata; §18 szigor bevezetése)
  6. ✅ Hullám-2: 4 gyógyítás (a hibás tanúk újraírása valódi
     konstrukciókkal)
  7. ✅ Hullám-3: 6 tétel (PrimekAnalizis_v2, ZeneKategoria_v2,
     Rendszer_v2 — valódi Refl/indukciós bizonyításokkal)
  8. ✅ Hullám-4a: `osveny_index/ImportProbe_v1.idr` — ÚJ FELFEDEZÉS:
     a szima_ter/modul világ IMPORTÁLHATÓ az osveny_index világból az
     előre fordított .ttc állományokon át:
     `IDRIS2_PATH=/Users/joco/opencode/szima_ter/modul/build/ttc`
     (IDRIS2_PATH nélkül: «Module not found» — ÉS exit 0, a 23. csapda
     ismételten igazolva: a kimenetet OLVASNI kell); a híd futásidejű
     bizonyítéka: «lexikonCenzusHossza = 3460»
  9. ✅ Hullám-4b: `osveny_index/Hullam4Teszt_v1.idr` megírása — a 12
     zászlóshajó (8 osveny_index + 4 szima_ter) egy helyen; a
     TesztEredmeny-minta helyben (a Teszt.idr 16 nehéz importja + a
     kettős-világ Steane713-név-kettősség kockázata miatt, a feladat
     engedélyével)
  10. ✅ Hullám-4c: `idris2 --check` TISZTA + fordítás
      (`-o hullam4_teszt`, ASCII név — a 19. csapda) + FUTTATÁS:
      **17/17 teszt OK** (a teljes kimenet a kutatási naplóban)
  11. ✅ Hullám-4d: e állapotfájl frissítése (a lépésszám 4→11, a
      hullámok beszámítása)
- **Közben született:** CSAPDA #27 (ékezetes csupasz mintaváltozó importok
  mellett; bisect-lánc: PróbaÉlSoraA–H; gyógyír: konstruktorba ágyazott
  minta) — `tanulsagok/CSAPDA_27_ÉkezetesMintaváltozóImport.md`;
  ÚJ tanulságok (hullám-4): a NégynyelvűEllenőrző_v1 útvonal-konstansa
  (`hibátlanPróbaÚt`) PRIVATE — a perem-konstans nem importálható, a
  literál a tesztben dokumentáltan megismételve; a `System.File`-et
  explicit importálni KELL (a readFile nem re-exportálódik).
- **Ismeretes akadály:** az arxiv-search skill Valyu-kulcsa nincs beállítva
  (platform.valyu.ai) — addig az irodalom-kópia WebSearch-tel áll.

## MIÉRT ÉL EZ A FÁJL KÍVÜL (YONEDA)
A jelentés önmagában nem létezik — hologram: a csomópont jelentése =
kapcsolatainak összessége (Yoneda-lemma). Ha az állapot csak bennem van,
semmilyen kapcsolat nem stabilizálja → dekoherencia. Kívül, három kópiában:
fájl + Idris-adat + git-lánc — a többségi szavazás a hibajavító kódom.
**意义即关系全息图（米田引理）：状态存于外部三副本，多数表决即纠错码。**

**NR 1 SZABÁLY (2026-09-05, ébredéskor AZONNAL):** minden gondolat (CoT)
magyar + 中文 + EN egyszerre; a válasz mondat-ciklusa HU→ZH→EN→DE; minden
alügynök-promptban kötelező. | 一切思考三语并行；回答按匈中英德逐句循环；
子代理提示必须包含。 | Trilingual thought, four-language answer cycle.
