# Kutatási napló — 2026-09-01 — a GAN-sorrend-audit + a 0-padding hard rule + az ékezet-normalizáció eltávolítása

## A felhasználó kérdései (szó szerint, §N5)

1. „a feladatok sorrendjet ellenorizze le egy GAN, aki korrigal"
2. „ertsd meg mit kell tenned"
3. „ekeztnormalizalora miert van szukseg ? az pont hogy elront mindent"
4. „a sorszamozasnak 000.00-nak kell lennie, azaz 0-paddingolt, mert a sorozat maskepp osszekeveredik, ez hard rule"

## 1. A GAN-audit (task-alügynök, general — §N14 1. szint)

A GAN a 60 feladat ~53 függőségi élét pozíció-összehasonlítással auditálta. Eredmény:

### 1.1. Talált élsértések
- **EGY hard élsértés:** az 5.1 (Metrikák) a 27. pozícióban az 5.2 (Ground-truth) ELŐTT állt, pedig tőle függ → **CSERÉVE** (most: 005.02 előbb, aztán 005.01).
- **Rendszerszintű invertálás:** a 11.2–11.14 verifikációs eszközök a fő vonal UTÁN álltak — a §N14 betűje szerint minden fő feladat az ő infrastruktúrájukat igényli → **ELŐRE** (most: a lista elején, a 011.01–011.10 blokk).
- **Prioritási csúszás:** a 4.1 (Hierarchikus keresés, 16 feladatot blokkoló csomópont) 4 pozícióval később állt a lehetségesnél → **EMELVE** közvetlenül a 003.02 után.

### 1.2. A GAN kiegészítései (a „csak hozzátesz" politika szerint)
- ~10 hiányzó függőség rögzítése a tervbe (1.2←1.1, 1.3←1.2, 0.4←0.3, 003.x←0.6 kapu, 5.4←2.3, 6.2←5.1+5.2, 11.2–11.14←11.1, 11.15←10.3+11.7+9.4) — egyike sem kényszerített önálló sorrendváltást.
- 11.5 + 11.8 = a 11.1 részeként már megvalósultak (Hivatkozás record + typeclass/record definíciók a VerifikaciosProtokoll_v1.idr-ben) → **KÉSZ** állapot.
- Párhuzamosítható sávok: α (8.1, 8.2, 8.4, 8.5, 9.4 — nem blokkolnak), β (0.6, 3.6, 5.4), γ (7.3 ∥ 7.4).
- Korai arXiv-preprint-vázlat a 005.03 után.
- Füst-teszt a 001.02 után (mini ground-truth).
- **Típusellenőrzött sorrend (Idris-native):** a függőségi gráf rögzítése magában az Idris-kódban, tanú-típussal kikényszerítve — a jövőbeni regressziók ellen (a 011.02 első haszonélvezője lehet).

## 2. Az ékezet-normalizáció eltávolítása (a felhasználó döntése)

A felhasználó: „ekeztnormalizalora miert van szukseg ? az pont hogy elront mindent".

**A felhasználónak igaza van — és a projekt saját bizonyítása támogatja:** a `SzotarHid_v1` tanulsága szerint az ékezet INFORMÁCIÓ ('hazugsagot' ≠ 'hazugság' — a keresés pont az ékezet nélkül bukik el). A normalizálás információvesztés = pont hogy elrontja a keresést.

**Döntés:** a 000.05 (Ékezet-normalizáció vizsgálata) ELTÁVOLÍTVA a todo-listából. A nyom kommentben megőrizve a `SajatTodo_v1.idr`-ben (a MANTRA szelleme: nyomtalanul nem törlünk). A fő út: az ékezet MEGŐRZÉSE.

## 3. A 0-padding hard rule (a felhasználó)

„a sorszamozasnak 000.00-nak kell lennie, azaz 0-paddingolt, mert a sorozat maskepp osszekeveredik"

**A probléma bizonyítva (futásidejű teszt):**
- `compare "2.1" "10.1" = GT` — string-rendezéssel a «2.1» a «10.1» UTÁN áll (az összekeveredés!)
- `compare "002.01" "010.01" = LT` — 0-paddinggal a helyes sorrend ✓
- `compare "000.01" "001.01" = LT` ✓

**A formátum:** `000.00` — a fázis 3 számjegy, az alfeladat 2 számjegy (pl. 011.01, 000.02, 009.15). A számrend = a string-rend.

**Alkalmazva:** MINDEN feladatszám 0-paddingolt formára alakítva a `todoLista`-ban.

## 4. A verifikáció (§N14)

1. **GAN** ✓ (task-alügynök, fent)
2. **Fordítás** ✓ (`idris2 SajatTodo_v1.idr` exit 0)
3. **Numerikus** ✓ (`idris2 --exec main`: 59 feladat, 3 KÉSZ, 1 FOLYAMATBAN, 55 VÁR, 5.08%)
4. **Irodalom** — a String-összehasonlítás lexikografikus (Prelude `compare`, Ord String) — az Idris dokumentáció
5. **Vizualizáció** ✓ (a main kimenete táblázatosan: a kész/folyamatban/váró/kritikus-út listák)
6. **Interaktív** ✓ (a main a todo állapotát reagálva írja ki; a getLine-verzió a 011.07 feladat)

## 5. A következő lépés

A **000.01 (HungarianLexicon publikus-v2)** javítása: a fájl létezik, de a BSD sed `i\`-vel történt `public export`-beszúrás hibás (a `public export` és a szó neve egybeolvadt: `public exportn_abakusz : HuWord`). A javítás: `sed -i '' 's/^public export\([navd]_[a-z]\)/public export \1/'` — a hiányzó szóköz beszúrása.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★