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
