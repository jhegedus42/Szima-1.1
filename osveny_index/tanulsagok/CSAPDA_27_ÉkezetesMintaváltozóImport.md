# CSAPDA #27 — Ékezetes mintaváltozó importok mellett (2026-09-04)
# 陷阱 #27：有 import 时匈牙利变音符模式变量失效

**A jelenség:** ha egy Idris 2 (0.8.0) modulban VAN import, akkor a
klauzusa BAL OLDALÁN álló CSUPASZ (konstruktorba NEM ágyazott) ékezetes
kisbetűs mintaváltozó elaborálása megbukik: «Undefined name …» — miközben
a függvénynév, a modulnév és a típus ékezetes lehet, és import NÉLKÜL
a mintaváltozó is működik.

**A bisect-lánc (8 próba, mind a repóban marad, `osveny_index/PróbaÉlSora*.idr`):**

| Próba | Modulnév | Import | Mintaváltozó | Eredmény |
|---|---|---|---|---|
| A | ékezetes | nincs | `lista` (ASCII) | ✓ exit 0 |
| B | ékezetes | nincs | `szám` (ékezetes) | ✓ exit 0 |
| C | tanulsagok/-ban kisbetűs útvonal | — | — | ✗ (modulnév-útvonal nagybetű-kényszer; ez az OLVASD.md régi rejtélyének magyarázata) |
| D | ASCII | `TudásGráf_v1` | `érték` (ékezetes, csupasz) | ✗ Undefined name |
| E | ASCII | `Irányító_v1` | `értékE` (ékezetes, csupasz) | ✗ Undefined name |
| F | ékezetes | `Data.List` | `értékF` (ékezetes, csupasz) | ✗ Undefined name |
| G | ASCII | `Data.List` | `ertekG` (ASCII, csupasz) | ✓ exit 0 |
| H | ASCII | `Data.List` | `értékH` (ékezetes, csupasz) | ✗ Undefined name |

**A szabály (empirikus):** import + csupasz ékezetes mintaváltozó a klauzula
bal oldalán → «Undefined name». Konstruktorba ágyazott ékezetes minta
(`ÁllapotKonstruktor _ sor _`, `elsőÉl :: többiÉl`), @-minta
(`állapot@(...)`) és case-ágbeli kötés eddig MIND működött.

**Gyógyír:** a mintaváltozót mindig konstruktor-mintába ágyazzuk
(`élekSora (elsőÉl :: többiÉl) = …`), vagy @-mintát használunk. Ez egyben
az idris-stilus szabállyal (SOHA csupasz pattern matching) is összhangban van.

**Melléktanulság (GAUGE):** az `idris2 --check` néha **exit 0-val tért vissza
a hibakimenet ellenére** (Próba C első futtatása) — az exit kód NEM elég,
a kimenetet olvasni kell (AGENTS §18/§GAUGE).

**Melléktanulság 2:** a `tanulsagok/` almappa kisbetűs neve miatt onnan a
modulok útvonala nem lehet érvényes modulnév — ez magyarázza az OLVASD.md
megjegyzését („egyesek épp nem fordulnak le — ez a tanulság bennük").

**中文：** 陷阱 #27——有 import 时，子句左侧裸露的变音符模式变量报
«Undefined name»；嵌套进构造器模式即愈。附：`--check` 有时错误仍 exit 0，
必须读输出（GAUGE）；小写目录名不能出现在模块路径中。

---

## FELÜLVIZSGÁLAT (2026-09-05, este — két független javító-ágens tapasztalata alapján)

A fenti „empirikus szabály" TÚLSÁGOSAN ERŐS: a konstruktorba ágyazott ékezetes
minta NEM mindig véd. Három pontosítás (mind futás-bizonyított):

1. **(#27-revízió, Javító 1):** import mellett a KONSTRUKTORBA ÁGYAZOTT
   ékezetes mintaváltozó IS elbukik — `találatSora (Just útvonal) = …` →
   «Undefined name útvonal». A gyógyír-rend (hitelesség sorrendjében):
   (a) pont-stílus / magasabb-rendű függvény (`maybe`, projekciók) — LEGBIZTOSABB;
   (b) @-minta (`útvonal@_`) — bizonyított IO-do-s ÉS tiszta függvény esetén is
   (Javító 4: `átfedés@_ újdonság@_` tiszta klauzulán is zöld = #27b);
   (c) konstruktor-minta — NEM megbízható védőoltás;
   (d) ASCII csupasz név (kommentben jelezve, §16).
2. **(#28, Javító 4):** a `where`-beli segéd nem látszik a MÁSIK klauzulából
   («Undefined name sorEleme» a (Z j)-klauzulában, miközben a where a
   (S i)-klauzulát követte) → a segéd FELSŐ SZINTŰ public export.
3. **(#29, Javító 4):** a `cd szima_ter && idris2 --check modul/X.idr` recept
   csapdája — a `modul/` útvonal-prefix a modulnév részévé válik («Module name
   Steane713 does not match file name modul/Steane713.idr»); működő recept:
   `cd szima_ter/modul && idris2 --check X.idr`. ÉS: a pipe (`| tail`) elrejti
   az exit-kódot — GAUGE: mindig `2>&1` + pipe nélküli exit-kiírás.

**中文：** 修订：构造器嵌套并不总是安全——有 import 时同样可报错；药方排序：
点风格 > @模式（纯函数亦证） > 构造器模式 > ASCII 裸名。新陷阱：where 助手
跨子句不可见（提升为顶层）；从 modul/ 目录内编译（路径前缀会成为模块名一部分），
管道会藏退出码。
**EN:** Revision: constructor-nesting is NOT always safe with imports; remedy
order: point-style > @-pattern (proven on pure functions too) > constructor
pattern > ASCII bare name. New traps: where-helpers invisible across clauses
(hoist to top level); compile from inside modul/ (the path prefix becomes part
of the module name); pipes hide exit codes.
**DE:** Revision: Konstruktorenverschachtelung ist bei Imports NICHT immer
sicher; Heilmittel-Reihenfolge: Punkt-Stil > @-Muster (auch an reinen
Funktionen belegt) > Konstruktormuster > nackter ASCII-Name. Neue Fallen:
where-Helfer sind über Klauseln hinweg unsichtbar (auf Top-Level heben); aus
modul/ heraus kompilieren; Pipes verstecken Exit-Codes.
