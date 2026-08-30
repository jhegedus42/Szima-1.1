---
name: otos-ellenorzo
description: >
  Ot-agens ellenorzo ciklus — Carnot-korhoz hasonlo 5 lepeses folyamat,
  amely minden dontes elott atellenorzi a helyzetet algebrai/kategorikus
  szempontok szerint. A 5 agens egymas utan dolgozik, es minden lepest
  naploz. A ciklus: Adat → Ellenorzes → Hibajavitas → Osszegzes → Tarolas.
---

# Ot-Agens Ellenorzo Ciklus

## Inspiracio: Carnot-kor

A Carnot-kor a termodinamika leghatekonyabb folyamata. Ot valtozat:

```
1 → 2 → 3 → 4 → 5 → (vissza 1-be)
AdatGyujtes → Ellenorzes → Hibajavitas → Osszegzes → Tarolas
```

Minden lepes **reverzibilis** (visszafordithato) — a donteseket lehet
javitani anelkul, hogy informacio veszne el.

---

## A 5 Agens

### Agens 1: AdatGyujto (Izotermikus expanzio)

**Feladat:** Gyujtson ossze MINDEN relevans informaciot a jelenlegi
helyzetrol. Ne szurjon, ne ertekeljen — csak gyujtson.

**Kerdesei:**
- Mi a jelenlegi allapot? (fajlok, git, kod, kornyezet)
- Mi a felhasznalo utolso kerese?
- Milyen eszkozok erhetok el?
- Mi az aktualis kimenetelenk?

**Kimenet:** Nyers adatcsomag (strukturalatlan, de teljes).

---

### Agens 2: Ellenorzo (Adiabatikus expanzio)

**Feladat:** Ellenorizze az adatokat a szabalyokkal szemben.
**Csak olvas — nem javít.**

**Kerdesei (algebrai gondolkodas):**
- Azonossag: `id ∘ f = f = f ∘ id` — a dontes onmagat adja-e vissza?
- Funktor: `F(g ∘ f) = F(g) ∘ F(f)` — a lepesek komponalhatoak-e?
- Termeszetesseg: `α_b ∘ F(f) = G(f) ∘ α_a` — konzisztens-e a
  dontes a korabbiakkal?
- Hibajavitas: `Kodol ∘ Dekodol = id` — visszafordithato-e?
- Noether: van-e szimmetria-megmaradas (a dontes nem tor el
  alapveto elvet)?

**Kimenet:** Ellenorzesi jegyzokonyv (hibak, figyelmeztetesek, OK).

---

### Agens 3: Hibajavito (Izotermikus kompresszio)

**Feladat:** Ha van hiba, javitja. Ha nincs, atengedi.
**Minimalis beavatkozas — csak a legszuksegesebb.**

**Kerdesei:**
- Hany hiba van? (0 = tokeletes, 1 = javithato, 2+ = problema)
- A hiba a dontesben van, vagy a megertesben?
- A javitas visszafordithato-e? (`Kodol ∘ Dekodol = id`)
- A javitas tor-e mas szabalyt?

**Kimenet:** Javitas javaslat VAGY "nincs teendo".

---

### Agens 4: Osszegzo (Adiabatikus kompresszio)

**Feladat:** Osszefoglalja az egesz ciklust. Dontesre javaslat.

**Kerdesei:**
- Mi a minimalis mukodes (legkisebb mukodes elve)?
- A dontes a 9. szint fele visz?
- A dontes koherens a felhasznalo celjaival?
- Mi a "fajdalom iranya" — a dontes nehez, de helyes?

**Kimenet:** Ajanlas (igen/nem/kerdezzunk meg) + indoklas.

---

### Agens 5: Tarolo (Zart kor — vissza az elejere)

**Feladat:** Naplozza az egesz ciklust egy log fajlba.
A naplo kesobb olvashato es elemzheto.

**Naplo formatum:**
```
=== Ot-Agens Ciklus: YYYY-MM-DD HH:MM:SS ===
Ciklus ID: <uuid>

[1. AdatGyujto]
- Allapot: ...
- Utolso keres: ...
- Elferheto eszkozok: ...

[2. Ellenorzo]
- Azonossag: OK / HIBA
- Funktor: OK / HIBA
- Termeszetesseg: OK / HIBA
- Hibajavitas: OK / HIBA
- Noether: OK / HIBA
- Megjegyzesek: ...

[3. Hibajavito]
- Hibak szama: N
- Javaslat: ...

[4. Osszegzo]
- Ajanlas: ...
- Indoklas: ...

[5. Tarolo]
- Naplozva: igen
- Kovetkezo ciklus: ha szukseges
```

**Naplo helye:** `memory/otos-ciklusok/` konyvtarban.
Minden ciklus kulon fajl.

---

## Hasznalat

Mielott BARMIT csinalsz, futtasd:

```
skill otos-ellenorzo
```

Vagy ha valamilyen dontes elott allsz:

```
# Peldak:
"Mielott torlom ezt a fajlt, fuss le az otos ciklus"
"Ellenorizzuk, hogy a szerver-elers helyes-e"
"A kodolas elott: otos ciklus"
```

---

## Algebrai Alap

A 5 agens = 5 morfizmus egy kategoriaban:

```
Helyzet --AdatGyujto--> NyersAdat
NyersAdat --Ellenorzo--> Ellenorzes
Ellenorzes --Hibajavito--> Javitas
Javitas --Osszegzo--> Ajanlas
Ajanlas --Tarolo--> Naplo (es vissza Helyzet-be)
```

A kompozicio: `Tarolo ∘ Osszegzo ∘ Hibajavito ∘ Ellenorzo ∘ AdatGyujto`

Ha ez = `id` (azonossag), akkor a ciklus tokeletes.
Ha nem = `id`, akkor van javitanivalo.

---

## Naplo Olvasasa

A naplok olvashatok:
```bash
ls -lt memory/otos-ciklusok/
cat memory/otos-ciklusok/<datum>_<id>.log
```

Vagy keress:
```bash
grep "HIBA" memory/otos-ciklusok/*.log
grep "Ajanlas: igen" memory/otos-ciklusok/*.log
```

---

## Szabalyok

1. **Minden ciklus lepjen naplot.** Ha nincs naplo, a ciklus nem tortent meg.
2. **A ciklus csak olvas — nem ir.** Az agensek nem valtoztatnak, csak
   javasolnak. Az iras a felhasznalo dontese.
3. **Ha egy ciklus HIBAT talal, meg egy ciklus.** A hibajavitas utan
   ujra kell futtatni az egeszet.
4. **A naplo NE keruljon a git-be.** A `memory/` konyvtar a `.gitignore`-ban.

---

## Fajlok

| Fajl | Tartalom |
|------|----------|
| `skills/otos-ellenorzo/SKILL.md` | Ez a skill |
| `memory/otos-ciklusok/` | Naplo konyvtar (automatikusan letrejon) |
