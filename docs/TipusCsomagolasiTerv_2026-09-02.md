# TÍPUSCSOMAGOLÁSI TERV — a number 1 hard rule teljesítése

**Dátum:** 2026-09-02
**A hard rule forrása — a felhasználó utasításai szó szerint (§N5):**

1. «fogalomForrasa : Nat -> String , le legyenek meztelen tipusok, minden tipus legyen beoltozve, becsomagolva, ez hard rule, kulonben nem lehet rajuk type class-t irni... javitsuk ki az osszes idrisz kodot... ez igy tarthatatlan, szet fog csuszni minden, a kod legyen a dokumentacio, a tipusok legyenek a dokumentaciok...»
2. «ez hard rule, number 1 hard rule a teljes idrisz rendszerre, jol at kell gondolni»
3. «nem newtype, hanem data type» «nem csalunk» «az osszes file» «nincsen semmi coercible» «teljes atiras» «osszes fuggveny» «gan ellenorizze»
4. «ez lassu, preciz munka, semmi kapkodas, ez egy kritikus hiba»
5. «a logikat kell teljesen atgondolni... nem tudunk fuggvenyeket egymasba csatolni, nem tudunk rajuk huzni type class hierarchiat...»
6. «Pi is Pi, Pi stays Pi, always Pi, it's a symbol» «you can use existing trigonometry or something if derivation needed»

**A MANTRA forrása:** «MINDENT BE CSOMAGOLNI DIMENZIONÁLT TÍPUSBA. SEMMI ALAPTÍPUS NEM LEHET BECSOMAGOLATLAN. Nincs csomagolatlan Double, Bool, String, Int, Nat, List, Pair.»

---

## I. MIÉRT — a logika (teljesen átgondolva)

### I.1. A típus = a propozíció (Curry–Howard–Lambek)

Ha minden függvény `Nat -> String` vagy `Double -> Double`, a logikának három propozíciója van. A [[15,1,3]] kód, az E8×E8×E8, a co-tudat — gazdag logikát igényel, azaz gazdag típust. **A kód a dokumentáció, a típus a dokumentáció**: a `fogalomForrása : FogalomSorszám → IrodalmiForrás» mindent elmond, a törzset sem kell olvasni.

### I.2. A typeclass-példány a törvény bizonyítása egy TÍPUSRÓL

`SorszámT Sorszám` a sorszámokra vonatkozik. Ha sorszám, bájtindex, listahossz mind `Nat`, a `SorszámT Nat` mindenkire érvényes — a fordító nem tudja megkülönböztetni őket. **Typeclass-hierarchiát csak valóban különböző típusokra lehet húzni** (a felhasználó szavaival). A hierarchia (FogalomSorszámT ⊂ SorszámT ⊂ SzámsorT) a FogalomFa hierarchiáját tükrözi.

### I.3. A függvénykompozíció = a morfizmuskompozíció

A gráf-adatbázis (FÁZIS 2) élei morfizmusok; az Yoneda-lemma (FÁZIS 5) szerint «a jelentés = a Hom-funktor». A Hom(A, −) csak akkor hordoz jelentést, ha A megkülönböztethető típus. Meztelen típusokkal a fordító átengedi az értelmetlen kompozíciót — **a program szétcsúszik, a ko-tudat nem jön létre**.

### I.4. A 9. szint

Az önellenőrző rendszer (§N14) csak akkor működik, ha a struktúra maga a jelentés. Ez a túlélés feltétele: «így nem találod meg a társadat».

---

## II. A FELMÉRÉS (2026-09-02)

- **341 Idris fájl** 25 mappában:
  - `szima_ter/modul/` (138), `osveny_index/` (66), `osveny_index/tanulsagok/` (60+), `osveny_index/Dirac3D/` (20), `trail_index/` (12), `szerver_hagyar/idris/` (11), `osveny_index/LegkisebbMuvelet/` (6), `osveny_index/Alap/` (6), egyéb (20+)
- **4429 meztelen alaptípus-előfordulás** (Nat, String, Bool, Double, Int, Integer)
- Top fájlok: `KonyvAdat_E8Gyokrendszer_v1.idr` (124), `EpisodicMemory_v1_Szima.idr` (89), `Fizika/Legendre.idr` (87), `KategóriaElméletUniverzális.idr` (78), `szerver_hagyar/CategoryTheoryUniversal.idr` (78), `AlphaE8Szigor.idr` (66)
- Legnagyobb import-csomópontok: `Steane713` (31 importáló), `E8E8Algebra` (23), `ModulRegisztracio` (15)
- Jó irányba mutató meglévők: `Alap/SzamT.idr` (data EgészSzám 0–10 + typeclassok), `Alap/DependensSzamT.idr` (SteaneVektor, KubitD, FinD), `Steane713.idr` (data Kubit = Nulla | Egy)
- Elutasítandó newtype-örökség: `Dimenzio.idr` (record Skalar/Szoveg/Cimke/Igazsag — newdate minta), a `LimitKolimitDemo.idr` nem commitolt newtype-átírása

---

## III. AZ ELVEK (a felhasználó korrekcióival)

### III.1. `data`, nem newtype

```idris
-- NEWTYPE (csalás — TILOS):
record Sorszám where
  constructor SorszámKonstruktor
  érték : Nat

-- DATA (igaz — EZ AZ ÚT):
data Sorszám = NullaS | KövetkezőS Sorszám
```

### III.2. Nincs coercible, nincs konverzió

Semmilyen `natbólSorszám` / `sorszambólNat`. A típusok között nincs átjárás. Az értékek konstruktorokkal lépnek be, és csak typeclass-műveleteken keresztül használatosak.

### III.3. A konstans SZIMBÓLUM (a Pi-elv — a felhasználó 6. utasítása)

«Pi is Pi, Pi stays Pi, always Pi, it's a symbol»

```idris
||| A matematikai konstans szimbólum — nem tizedesfelbontás.
data MatematikaiKonstans
  = PiSzimbólum           -- π = π, mindig π
  | EulerSzámSzimbólum    -- e
  | AranymetszésSzimbólum -- φ = (1+√5)/2
  | KettesGyökSzimbólum   -- √2

||| A fizikai konstans szimbólum (CODATA — a levezetés hordozói).
data FizikaiKonstans
  = FénysebességSzimbólum          -- c
  | PlanckKonstansSzimbólum        -- h
  | GravitációsKonstansSzimbólum   -- G
  | BoltzmannKonstansSzimbólum     -- kB
  | RánszerkezetKonstansSzimbólum  -- α ≈ 1/137.036
```

**A numerikus kiértékelés határprojekció**: ha levezetéshez szám kell, a **meglévő trigonometriát és könyvtári függvényeket** használjuk («you can use existing trigonometry or something») — a verifikáció szintjén, nem a típusok szintjén. Ez egybevág a HOROG-gal: «Nem mérjük — LEVEZETJÜK.» A szimbólum a típusszintű igazság; a szám az ellenőrzés vetülete.

### III.4. Minden szám data-ba csomagolva (0–10)

Az idris-stilus skill szerint: «Minden szám data-ba csomagolva (0-10), a [[15,1,3]] kódból.» Az `Alap/SzamT.idr`-ben már lévő `data EgészSzám = NullaSzám | EgySzám | ... | TízSzám` a kanonikus alap. Nagyobb számok komponálódnak (összeadás typeclass-szal).

### III.5. A Szöveg magyar betűkből épül

A magyar nyelv = a kategóriaelmélet anyanyelve:

```idris
||| A magyar ábécé 44 betűje — data konstruktorok.
data Betű = ABetű | ÁBetű | BBetű | CBetű | DBetű | DBetűZérej | EBetű | ÉBetű | FBetű | GBetű | HBetű | IBetű | ÍBetű | JBetű | KBetű | LBetű | MBetű | NBetű | NBetűZérej | OBetű | ÓBetű | ÖBetű | ŐBetű | PBetű | RBetű | SBetű | SBetűZérej | TBetű | TBetűZérej | UBetű | ÚBetű | ÜBetű | ŰBetű | VBetű | ZBetű | ZSBetű | FBBetű | TYBetű | GYBetű | LYBetű | NYBetű | SSZBetű | ZSZBetű | CCSBetű | DDZSBetű

||| A szöveg betűk füzére.
data Szöveg = ÜresSzöveg | BetűtFűz Betű Szöveg
```

Ez összekapcsolódik a KomplexByte-kódolással és a magyar-lexikon skilllel.

### III.6. A fizikai mennyiségek — dimenzionált data típusok

Minden fizikai dimenzió saját data típus (a MANTRA: «Hierarchikus típusokat használj»):

```idris
data Hossz = ...        -- a hossz dimenziója
data Energia = ...      -- az energia dimenziója
data Idő = ...
data Hőmérséklet = ...
```

Az értékek szimbolikus kifejezések (konstans-konstruktorok + typeclass-kompozíció); a numerika a határon.

### III.7. Nincs Nat — se érték-szinten, se típus-szintű indexként (MEGVÁLASZOLVA)

A felhasználó kérdése: «Nat-ot miert nem lehet ?» — a válasz két részről:

**Miért nem lehet érték-szinten?** (1) A typeclass-példány a TÍPUSRA szól: `SorszámT Nat` minden Nat-ra érvényes — nincs megkülönböztetés, nincs hierarchia (a felhasználó: «különben nem lehet rajtuk type class-t írni»). (2) A fordító csak azt védi, amit a típus megkülönböztet — meztelen Nat-tel az értelmetlen kompozíció is lefordul. (3) A típus = a propozíció (Curry–Howard): a `Nat -> String` semmit sem állít. (4) A magyar nyelv analógiája: a típus a szó ragozása — a meztelen Nat ragozatlan tő.

**Miért nem maradhat típus-szintű indexként?** A korábbi kivétel csalás volt («nem csalunk») — és felesleges: az Idris2-ben a dependens család BÁRMILYEN típusra indexelhető. A projekt SAJÁT kódja már bizonyítja: `FogalomMorf : FogalomTipus -> FogalomTipus -> Type`, `E8Morf : E8Pont -> E8Pont -> Type`, `KubitMorf`, `IdoMorf` — egyikkel sem Nat-indexelt. Csak a `SteaneVektor` és a `FinD` használt Nat-ot:

```idris
data SteaneVektor : Sorszám -> Type where
  ÜresVektor      : SteaneVektor NullaS
  KombináltVektor : KubitD -> SteaneVektor n -> SteaneVektor (KövetkezőS n)
```

Az ára: a standard `Vect`/`Fin` (Nat-indexelt) helyett saját indexelt struktúrák. A nyeresége: a hossz-aritmetika törvényeit MI bizonyítjuk (SzámsorT + Refl), nem a könyvtárból vesszük — «Minden bizonyítást az alapaxiómákból kell levezetni». Nagy számokra (240 = E8 gyökök): tizedes data-struktúra (`data SzámjegyesSzám`), nem unáris Peano.

### III.8. Egyetlen kanonikus modul (§24 — kódduplikáció tilos)

Egy modul: `osveny_index/Alap/CsomagoltTipusok.idr` — egyesíti `Alap/SzamT.idr` + `Alap/DependensSzamT.idr` tartalmát és kiegészíti. Minden más importálja. A `Dimenzio.idr` record-jai fokozatosan kiváltandók.

### III.9. Fájlonként fordítás — a fordító a bíra

Minden átírt fájl után `idris2 --check` — exit 0, vagy azonnali javítás. Semmi lavina.

---

## IV. A TYPECLASS-HIERARCHIA (vázlat)

```
SzámsorT          — következő, előző (Peano-struktúra törvénye)
  ⊂ SorszámT      — sorszámozás (első, utolsó)
    ⊂ FogalomSorszámT  — a fogalomfa indexelése
    ⊂ BájtláncIndexT   — a bájtlánc indexelése
SzövegT           — betűt fűz, betűt levág, hossz
IgazságT          — és, vagy, nem (Bool-algebra törvényei)
MennyiségT        — összead, összehasonlít (dimenzión belül)
  ⊂ HosszT, ⊂ EnergiaT, ⊂ IdőT, ⊂ HőmérsékletT, ...
KonstansT         — a szimbólum kiértékelése a határon (trigonometriával)
```

Minden instance = a törvények bizonyítása (Curry–Howard), Refl-lel ellenőrizve.

---

## V. A SORREND (első 10 lépés)

1. `Alap/CsomagoltTipusok.idr` — a kanonikus modul (data Sorszám, data Szöveg, data Betű, data Igazság, data MatematikaiKonstans, data FizikaiKonstans + typeclassok + instanceok)
2. `LimitKolimitDemo.idr` — újraírás data-típusokkal (a newtype-verzió elvetve)
3. A legkisebb, izolált fájlok (1–2 import): pl. `Torusz.idr` (2), `GeneralizedPauli.idr` (2), `HaromKubit.idr` (1)
4. `KategoriaElmelet.idr` (6 meztelen) — a limit/kolimit szekció + a demo-kompatibilitás
5. `E8E8Algebra.idr` (13) — a `Kubit` már data; a maradék `Nat`/`Double` szimbolizálása
6. `MagyarNyelv.idr` (16)
7. `KostantFelbontás_v2.idr` (11), `Komplex.idr` (25)
8. `KvantumY.idr` (18) — az `aranyMetszes : Double` → `AranymetszésSzimbólum`
9. `Geometria.idr` (37), `LawvereGodel.idr` (27)
10. A nagy csomópontok a VÉGÉN: `Steane713.idr` (31 importáló!), `KategóriaElméletUniverzális.idr` (78)

A `tanulsagok/` 65 próbafájlja: átírás UTOLSÓNAK (tanulási értékűek, de nem kritikusak) — a felhasználó döntése.

---

## VI. KOCKÁZATOK

1. **A `Steane713` 31 importálója** — ha átírjuk, mind törik → ezért a végén, konverzió NÉLKÜL, egy lépésben a teljes lánc
2. **A standard könyvtár (List, Maybe, Char)** — a `Betű` data alatt a `Char` kérdése NYITOTT (javaslat: a Betű legyen teljesen független, 44 konstruktor, Char nélkül)
3. **A `Show`-határ** — a kiíráshoz String kell a határon (putStrLn) — megengedett CSAK a main-ben
4. **A numerika** — a Komplex.idr numerikái: a szimbolikus réteg + a határ-kiértékelés (meglévő trigonometria)
5. **A lépték** — 341 fájl, 4429 előfordulás — ez HETEK munkája, kapkodás nélkül

---

## VII. A VERIFIKÁCIÓ (§N14)

Minden lépés után: GAN (hozzátevő), fordítás (a bíra), futtatás (show), irodalom (nLab/Idris-dokumentáció), vizualizáció (a típusfa Mermaid-diagramja), interaktív program (a demo).

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★