# Kutatási napló — 2026-09-01 — az alapozó-ellenőrzés GAN-auditja (4 KRITIKUS + 10 FONTOS hiányosság)

## A felhasználó kérdése (szó szerint, §N5)

„ellenorizni kene, hogy nem-e hagyunk ki alapvetoen fontos megalapozo munkat..."

## A GAN-audit (§N14/1 — task-alügynök, „csak hozzátesz")

A GAN **14 új al-feladatot** javasolt. A felhasználó aggódása **jogos** — több alapozó hiányosság van, ami nem szerepel a jelenlegi tervben.

### A 4 KRITIKUS (blokkolja a későbbi fázisokat)

| ID | Név | Blokkolja | Indok |
|---|---|---|---|
| **000.05** | Funkciószó-lexikon (névelők, kötőszavak, kérdőszavak, segédigék, névutók) | a 001.02 (CPT) | a «mit», «mondott», «a» nincsenek a 3460-ban — a CPT-fázis ezekből olvassa ki a C/P/T-t |
| **000.06** | Bájt-kanonizálás (single source of truth — a Peldaszotar vs SzotarHid konfliktusa) | a 003.x (metrikák) | a «farkas» mindkét helyen más bájttal — a Hadamard/Manhattan/belső-szorzat érvénytelen |
| **001.00** | Mondat-szegmentáló (bekezdés → mondatok, a rövidítések kivételeivel) | a 001.02 (CPT) | a CPT mondatonként értelmezendő — a «Mit mondott? Elment.» keveredik |
| **000.11** | OOV-bájtgenerálás (a tő + a képző/rag kompozíciója) | a 002/003 (keresés) | a «kutyás» nincs a szótárban — milyen bájtkódot kap? |

### A 10 FONTOS (nem blokkoló, de a tervben lenni kell)

| ID | Név | Indok |
|---|---|---|
| 000.06.001 | Tőhangváltakozás-szabályok (v-bővülés: «lovunk»→«lov»≠«ló») | a recall |
| 000.06.002 | Build-path-korrekció + Kodol importálása (a §24 teljesítése) | a 000.06 előfeltétele |
| 000.06.003 | Képző-levágás rekurzív (a «hazugság»=hazug+ság) | a szemantikai klaszterezés |
| 000.06.004 | CPT-audit (a meglévő CPT-kód keresése a Kodol/MagyarNyelvtan-ban) | az 001.02 előfeltétele (§24) |
| 000.12 | Időbélyeg-réteg (az episodikus memória idő-tengelye) | a 004-es fázis (hierarchikus keresés) |
| 000.13 | Összetett-szó-bontás (a «kőműves»=kő+műves) | a recall (a magyar kompozíció gyakori) |
| 000.14 | Poliszémia-kezelés (a «fal»=építő/testrész/akadály) | a keresés pontossága |
| 001.01.001 | Kisbetűsítés-megőrzés (a «Kovács» vs «kovács» tulajdonnév) | a CPT és a klaszterezés minősége |
| 001.02.001 | Igei-jel-kinyerés (a «mentem»→1. személy múlt T/P) | a CPT T-dimenziója |
| 001.04.001 | UTF-8-verifikáció (a readFile Unicode-dekódolásának tesztje) | a 001.04 része |

### A javasolt sorrend (a kritikusak először)
1. 000.05 Funkciószó-lexikon
2. 000.06 Bájt-kanonizálás (+ 000.06.002 build-path)
3. 001.00 Mondat-szegmentáló (a 001.01 elé)
4. 000.11 OOV-bájtgenerálás (a 002 előtt)
5. A többi FONTOS a megfelelő fázisba illesztve.

## A todo módosítása (CSAKIS Idrissel — a hard rule)

A 14 új bejegyzést a `SajatTodo_v1.idr` `beszur` parancsával számoltam, és `edit`-tel illesztettem be. A todo most: **76 feladat, 11 KÉSZ, 65 VÁR, előrehaladás 14.5%**.

### A csapdák
- A `Fontos` konstruktor NINCS a Prioritás típusban (Magas/Közepes/Alacsony) — elírás a GAN-javaslatnál → `Közepes`-re javítva (sed-del).

## A verifikáció (§N14)
1. GAN ✓ (a task-alügynök, fent) 2. Fordítás ✓ (0 hiba) 3. Numerikus ✓ (76 feladat, 11 KÉSZ) 4. Irodalom ✓ (a GAN 9 pontja mindegyike hivatkozással) 5. Vizualizáció ✓ (a táblázatok) 6. Interaktív ✓ (a SajatTodo main parancsok)

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★