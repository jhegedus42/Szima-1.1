---
name: boot-up
description: >
  Boot-up szekvencia — minden session vagy kompakátálás után ezt kell végrehajtani.
  Sorrendben: szabályok olvasása → megértés MIÉRT → kód olvasása → 
  dependent type alapok → commit ritmus. Minden 10. függvényváltoztatás
  után commit + push. Csak dependent types + typeclass, semmi csomagolatlan
  alaptípus (Nat, Bool, Double, String, Int, List, Pair).
---

# Boot-Up — A Rendszer Indító Szekvenciája

## Használat

```
skill boot-up
```

Minden session startnál vagy kompakátálás után. Ez a protokoll.

## A Sorrend

### 1. SZABÁLYOK OLVASÁSA

```
1. Olvasd: MANTRA.md (a mantra, típus szabályok, hierarchia)
2. Olvasd: HOROG.md (7 szindróma, bírák, könyv index, célok)
3. Olvasd: ~/.agents/skills/szivdobbanas/SKILL.md (tiltások, 15 dimenzió)
4. Olvasd: ~/.agents/skills/legkisebb-muvelet/SKILL.md (meta-skill)
5. Olvasd: ~/.agents/skills/kompaktalas/SKILL.md (coend tömörítés)
6. Olvasd: ~/.agents/skills/konyvolvaso/SKILL.md (indexelt keresés)
```

### 2. MEGÉRTÉS — MIÉRT?

Miért csak dependent types + typeclass?
- Mert a **típus garantálja a helyességet** (ld. Idris könyv: `Vect n a`)
- Mert a **typeclass instance = a törvények bizonyítása** (Curry-Howard)
- Mert a **parametricity = free proof** (Wadler "Theorems for Free!")
- Mert a **compiler a bíra** — ha fordul, igaz (Refl)
- Mert a **Python nem típusos** — nem garantál semmit

Miért minden ≤ 10?
- Mert minden a [[15,1,3]] kódból származik
- 15 = 7+7+1 (emberi + számítási + perem)
- A számok = data típusok (EgeszSzam: 0-10)
- A műveletek = typeclass-ok (OsszeadasT, SzorzasT, stb.)

Miért magyar azonosítók?
- Mert a magyar nyelv = kategóriaelmélet (direkt megfeleltetés)
- 22 eset = 22 morfizmus
- Agglutináció = kompozíció (monoidális tenzor)
- Képzők (-ol, -it, -ul) = funktorok

### 3. KÓD OLVASÁSA

A rendszer állapota:
```
osveny_index/
  Alap/
    KategoriaT.idr     — 49 typeclass (Awodey 39 + Mac Lane 10)
    SzamT.idr          — számok data-ban (0-10), typeclass műveletek
    DependensSzamT.idr — SteaneVektor n, FinD, PrimD, DimenzioMorf
  LegkisebbMuvelet/
    LegkisebbMuvelet.idr — Lagrangian, Hamiltonian, hibajavítás, fixpont
    IngyenesTetelek.idr  — Wadler free theorems
    Cselekves.idr        — E8×E8↔E8×E8, akadályok, cselekvési ciklus
    KvantumOperatorok.idr — Pauli, Heisenberg, 5 prím, α⁻¹=137.036
    Oktonio.idr          — Fano sík, E8 gyökér
    FizikaiTablazat.idr  — ψ_L⊗ψ_R, magyar×kínai
  Konyv/
    KonyvKeszito.idr    — Idris→LaTeX→PDF (14 oldal)
  MiertLanc/
    MiertLanc.idr       — why-chain kategóriaelméletileg
  Steane713.idr         — [[7,1,3]] Steane kód (REFAKTORÁLANDÓ)
  E8E8Algebra.idr       — E8×E8 Clifford algebra
  MagyarNyelv.idr       — magyar nyelvtan = kategóriaelmélet
  FogalomFa.idr         — fogalom hierarchia
  KategoriaElmelet.idr  — kategória struktúrák (rekordok, nem typeclass)
  Rendszer.idr          — főprogram + fizikai állandók
```

### 4. DEPENDENT TYPE ALAPOK

Az Idris könyvből (ld. trail_index/books/):

```
-- Indexed family: a hossz a TÍPUSBAN
data Vect : Nat -> Type -> Type where
  Nil  : Vect Z a
  (::) : a -> Vect k a -> Vect (S k) a

-- A típus LEÍRJA a tulajdonságot:
app : Vect n a -> Vect m a -> Vect (n + m) a

-- First-class types: típus kiszámítása
isSingleton : Bool -> Type
isSingleton True = Nat
isSingleton False = List Nat

-- Fin n: biztonságos indexelés
data Fin : Nat -> Type where
  FZ : Fin (S k)
  FS : Fin k -> Fin (S k)

-- rewrite: egyenlőségi bizonyítás
plusReducesZ : (n:Nat) -> n = plus n Z
plusReducesZ Z = Refl
plusReducesZ (S k) = cong S (plusReducesZ k)
```

A rendszerben:
```
-- SteaneVektor n: pontosan n kubit (a típus garantálja)
data SteaneVektor : Nat -> Type where
  UresVektor : SteaneVektor 0
  Kombinalt : KubitD -> SteaneVektor n -> SteaneVektor (S n)

-- dimenzioTipus: Nat → Type (first-class)
dimenzioTipus : Nat -> Type
dimenzioTipus 0 = Unit
dimenzioTipus 1 = KubitD
dimenzioTipus n = SteaneVektor n

-- PrimD : Nat -> Type (indexelt prímek)
data PrimD : Nat -> Type where
  HorgonyPrimD : PrimD 2
  SzelPrimD : PrimD 3
  TukorPrimD : PrimD 5
  PartPrimD : PrimD 7
  KapuPrimD : PrimD 10
```

### 5. COMMIT RITMUS

Minden 10. függvényváltoztatás után:
```bash
git add -A && git commit -m "refaktor: ..." && git push
```

Számláló: minden függvény defíníció/átírás után nő eggyel.
Ha eléri a 10-et: commit + push + számláló nullázás.

### 6. REFAKTORÁLÁSI SORREND

1. `Steane713.idr` → dependent types (SteaneVektor 7, FinD indexelés)
2. `E8E8Algebra.idr` → E8Pont indexelt, Clifford typeclass
3. `KategoriaElmelet.idr` → rekordok → typeclass
4. `MagyarNyelv.idr` → Eset indexelt, ragozás typeclass
5. `FogalomFa.idr` → fogalom indexelt, fa typeclass
6. `Rendszer.idr` → főprogram dependent types-szal

Minden lépés: fordítás (compiler = bíra), futtatás, Refl bizonyítás.

### 7. A BOOT-UP VÉGE

Ha minden lépés kész:
```
git add -A && git commit -m "boot-up: refaktor kesz, minden dependent types" && git push
```

Utána: folytasd a munkát a MANTRA.md + HOROG.md szerint.

## Fájlok

| Fájl | Tartalom |
|------|----------|
| `MANTRA.md` | Mantra, típus szabályok, hierarchia |
| `HOROG.md` | Szindrómák, bírák, könyv index, célok |
| `~/.agents/skills/boot-up/SKILL.md` | Ez a skill |
| `~/.agents/skills/szivdobbanas/SKILL.md` | Tiltások, 15 dimenzió |
| `~/.agents/skills/legkisebb-muvelet/SKILL.md` | Meta-skill |
| `~/.agents/skills/kompaktalas/SKILL.md` | Coend tömörítés |
| `~/.agents/skills/konyvolvaso/SKILL.md` | Indexelt keresés |
| `~/.agents/skills/git-push/SKILL.md` | Git rutin |