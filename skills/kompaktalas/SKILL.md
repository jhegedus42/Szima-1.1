---
name: kompaktalas
description: >
  Kategóriaelméleti tömörítés — a kontextus kompakálása coend/limit segítségével.
  Amikor a kontextus megtelik, ez a skill elvégzi a "kategóriaelméleti kompakálást":
  a redundáns bejegyzéseket eldobja (Clifford a·b átfedés), a причинális láncot
  megtartja (a "miért" menet), és a kompaktált eredményt visszainjektálja.
  A kompakálás = egy coend a why-chain kategóriáján. Soha nem Python — csak Idris.
---

# Kompaktálás — Kategóriaelméleti Tömörítés

## Használat

```
skill kompaktalas
```

Amikor a kontextus megtelik (~10k token), hívd meg. A skill:

1. **Azonosítja a redundanciát** (Clifford a·b átfedés > 0.8 → eldobható)
2. **Megőrzi a причинális láncot** (a "miért" menet — ok-okozati szál)
3. **Komponálja a lépéseket** (kompozíció: f∘g = egyetlen lépés)
4. **Visszainjektálja** a kompaktált láncot

## Az Algoritmus

A kompaktálás = egy **coend** a why-chain kategóriáján:

```
∫^c S(c,c) = a coend = a "dinaturális ko-ék" univerzális tulajdonsága
```

A why-chain bejegyzései = a kategória objektumai.
Az ok-okozati kapcsolatok = a morfizmusok.
A kompaktálás = a coend = az összes "felesleges" objektum azonosítása
és összevonása, megtartva a причинális szálat.

### 1. Redundancia detektálás (Clifford átfedés)

```
atfedes(a, b) = (a·b) / (|a|² + |b|² + 1)
```

Ha `atfedes(a, b) > 0.8` → a két bejegyzés 80%-ban megegyezik → eldobható egy.

### 2. Principális lánc megtartása

Minden bejegyzésre: "Ha ezt eltávolítom, a miért-lánc törik?"
- Ha **NEM** → eldobható (nem ok-okozati)
- Ha **IGEN** → megtartandó (ok-okozati szál)

### 3. Kompozíció (f∘g)

Ha két egymást követő bejegyzés komponálható:
```
bejegyzés_1: A → B  (miért: A szükséges B-hez)
bejegyzés_2: B → C  (miért: B szükséges C-hez)
komponált:    A → C  (miért: A szükséges C-hez, a B köztes lépés)
```

A komponált bejegyzés = egyetlen lépés a láncban.

### 4. Kompaktált lánc

A kompaktált lánc = a coend eredménye:
- Minimális bejegyzések
- Maximális információtartalom
- A perché-lánc (causal chain) érintetlen

## A Kategóriaelméleti Formalizmus

A kompaktálás kategóriaelméletileg:

```
WhyChainKategoria:
  Objektumok = bejegyzések (id, miért, mit, döntés)
  Morfizmusok = ok-okozati kapcsolatok (szülő → gyerek)
  Kompozíció = ok-okozat láncolás
  Identitás = egy bejegyzés önmagára

Kompaktalas = Coend(WhyChainKategoria):
  ∫^c S(c,c) ahol S(c,c') = "c és c' információs átfedése"
  Eredmény = a kompaktált lánc, ahol a redundáns c-k összevonva
```

## Protokoll

### Mikor kompaktálj?

- Kontextus > 10k token
- 3 egyforma hiba (AGENTS.md szabály: "Három egyforma hiba → infrastruktúra javítás")
- why-chain.jsonl > 50 bejegyzés

### Lépések

1. Olvasd a `why-chain.jsonl`-t
2. Számold az átfedést minden bejegyzéspárra (Clifford a·b)
3. Eldobd a > 0.8 átfedésűeket (redundancia)
4. Komponáld az egymást követőeket (f∘g)
5. Ellenőrizd: a perché-lánc érintetlen?
6. Írd vissza a kompaktált láncot
7. Injektáld vissza a kontextusba:

```
[Kompaktalas]
Itt vagyunk mert: <causal chain>
Utolsó döntés: <miért X Y helyett>
Következő: <mi jön>
[/Kompaktalas]
```

## A "Free Proof" (Wadler Parametricity)

A kompaktálás helyességét a parametricity garantálja:
- A why-chain típusa (bejegyzés → bejegyzés → Type) bizonyítja,
  hogy a kompaktálás uniform
- A természetességi négyzet = a coend kommutativitása
- A típus garantálja, hogy a kompaktált lánc ekvivalens az eredetivel

## Fájlok

| Fájl | Tartalom |
|------|----------|
| `~/.config/opencode/memory/why-chain.jsonl` | A why-chain (kompaktálandó) |
| `~/.agents/skills/kompaktalas/SKILL.md` | Ez a skill |
| `osveny_index/MiertLanc.idr` | Idris implementáció (jövőbeli) |