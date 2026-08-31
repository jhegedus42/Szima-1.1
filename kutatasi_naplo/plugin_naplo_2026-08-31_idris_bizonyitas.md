# Kutatási napló — 2026-08-31 (Idris bizonyítás)

## A felhasználó kérdése (szó szerint, §N5)
- „we have to figure out how to really proove stuff in idris, so first you have to read all idris related proof information"

## Mit csináltunk

### 1. A három mesterdokumentum elolvasása (idris-stilus skill szerint)
- `MANTRA.md` (58 sor) — a típus szabályok, a hierarchia, a Refl = minden bizonyítás alapja
- `HOROG.md` (281 sor) — a 12 szindróma, a 7 bíra, a könyv index, a 3 cél
- `AGENTS.md` (607 sor) — a kemény szabályok, a bizonyítási tanulságok (§7, §18)

### 2. Idris proof információ keresése a neten (§N12)
- Context7 `/idris-lang/idris2` — a hivatalos Idris2 dokumentáció
- A proof taktikák: Refl, rewrite, cong, trans, sym
- Az interaktív proof mode: `:ps` (proof search), lyukak, `:t`

### 3. Alügynök indítása — Idris proof info összegyűjtése
- Az alügynök elolvasta: `theorems.rst`, `interactive.rst`, `DependensSzamT.idr`, `Steane713Dependent.idr`, `KostantFelbontás.idr`, `Torusz.idr`
- 691 soras részletes összefoglaló: 12 pont, minden taktikára 2-3 példa
- Fájl: `osveny_index/kutatasi_naplo/2026-08-31_idris2_bizonyitasi_osszefoglalo.md`

### 4. A Torusz.idr tautológiáinak javítása (KÉT független út)
- `bizTóruszPontokSzáma : 16 = 16` → `2 * 8 = 16` (a tórusz = direkt szorzat)
- `bizTóruszCl4Penge : 16 = 16` → `1 + 4 + 6 + 4 + 1 = 16` (Pascal háromszög n=4)
- A KÉT független út minta: két fogalmilag különböző konstrukció, mind 16-ra fut

## Fő megállapítások

### A Refl taktika
- A `Refl` csak akkor működik, ha a két oldal definíció szerint megegyezik (definitional equality)
- A függvények definíció szerint redukálódnak (pl. `plus Z n = n`)
- Nem működik, ha a redukció megakad (pl. `plus n Z` nem redukálódik `n`-re)

### A rewrite taktika
- `rewrite ... in ...` — a céltípus átirása egy egyenlőségi bizonyítás alapján
- `rewrite sym ... in ...` — az irány megfordítása
- A projektben nincs rewrite — minden bizonyítás Refl

### A cong taktika
- `cong f (a=b_bizonyitas) : f a = f b` — függvény emeli az egyenlőséget
- Indukciós lépésben kell (pl. `cong S (plusReducesZ k)`)
- A projektben nincs cong

### A trans taktika
- `trans Refl Refl = Refl` — bizonyítás-lánc (a=b, b=c ⇒ a=c)
- A projektben nincs trans

### A tautológia csapda (AGENTS §18)
- `X = X` Refl-lel — nulla információ, tilos "bizonyítottnak" nevezni
- A jó minta: KÉT független út, egy híd (pl. 64 = 8×8 = 2⁶ = 128/2)
- A Torusz.idr-ben két tautológia volt (16=16), javítva

### A kisbetűs név csapda (AGENTS §7)
- A kisbetűs név a bizonyítás típusában implicit argumentummá válik
- A javítás: nagybetűs alias (pl. `KezdoKisAI = kezdoKisAI`)
- A projektben minden bizonyítás nagybetűs neveket használ — nincs probléma

### A Wadler "free proof"
- A polimorf típus bizonyítja a törvényt (pl. `id : a -> a` bizonyítja az identitást)
- A `Steane713Dependent.idr` `noetherTetelDNulla` példája: a dekodol∘kodol=id

### A meglévő kód bizonyításainak katalógusa
- `DependensSzamT.idr`: 12 bizonyítás, mind Refl, nem tautológia
- `Steane713Dependent.idr`: 5 bizonyítás, mind Refl, a noetherTetelDNulla valódi
- `KostantFelbontás.idr`: 17 bizonyítás, a 64 három útja = KÉT független út minta
- `Torusz.idr`: 10 bizonyítás, 2 tautológia javítva

## Push
- `728fc17` — snapshot 12: Idris2 bizonyitasi osszefoglalo (691 sor)
- `bdd350c` — Torusz.idr: tautológia javítva (KÉT független út)

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★