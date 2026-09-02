# Kutatási napló — 2026-09-02 — «Nat-ot miert nem lehet ?» (a nyitott kérdés #1 megválaszolva)

## A felhasználó kérdése szó szerint (§N5)

«Nat-ot miert nem lehet ?»

## A válasz — két részről

### 1. Mi maga a Nat nem rossz típus — a HASZNÁLAT a baj

A `data Nat = Z | S Nat` kifogástolan Peano-struktúra — pontosan az, amit a terv is javasol (`data Sorszám = NullaS | KövetkezőS Sorszám`). A probléma: EGYETLEN típus sok, fogalmilag különböző dologra (fogalom index, bájt index, lista hossz, verziószám, ciklusszámláló).

### 2. A mély okok (miért nem lehet)

1. **A typeclass-példány a TÍPUSRA szól** — `SorszámT Nat` minden Nat-ra érvényes; nem lehet hierarchiát húzni (a felhasználó: «különben nem lehet rajtuk type class-t írni»).
2. **A fordító csak azt védi, amit a típus megkülönböztet** — meztelen Nat-tel az értelmetlen kompozíció is lefordul; a HOROG «ami fordul, az igaz» fordítva is áll: olyasmi is fordul, ami hazugság. Külön típusokkal a fordító ELUTASÍTJA az értelmetlen kompozíciót.
3. **A típus = a propozíció (Curry–Howard)** — a `Nat -> String` semmit sem állít; a `FogalomSorszám → IrodalmiForrás» tétel.
4. **A kompozíció = morfizmus-kompozíció** — a gráf-adatbázis és a Yoneda gazdag Hom-halmazokat igényel.
5. **A magyar nyelv analógiája** — a típus a szó ragozása; a meztelen Nat ragozatlan tő.

### 3. A típus-szintű Nat-index kivétel VISSZAVONVA

A terv korábbi javaslata (Nat maradhat típus-szintű indexként) **csalás volt** — és felesleges:

- Az Idris2-ben a dependens család BÁRMILYEN típusra indexelhető (dokumentáció: idris2.readthedocs.io — «indexed families»).
- **A projekt saját kódja már bizonyítja**: `FogalomMorf : FogalomTipus -> FogalomTipus -> Type`, `E8Morf : E8Pont -> E8Pont -> Type`, `KubitMorf : HaromKubit -> HaromKubit -> Type`, `IdoMorf : IgeIdo -> IgeIdo -> Type` — EGYIKSEM Nat-indexelt (KategoriaElmelet.idr 163–216. sor).
- Csak a `SteaneVektor : Nat -> Type` és a `FinD` használt Nat-ot — ezek átírandók:

```idris
data SteaneVektor : Sorszám -> Type where
  ÜresVektor      : SteaneVektor NullaS
  KombináltVektor : KubitD -> SteaneVektor n -> SteaneVektor (KövetkezőS n)
```

- **Ára:** a standard `Vect`/`Fin` (Nat-indexelt) helyett saját struktúrák.
- **Nyeresége:** a hossz-aritmetika törvényeit MI bizonyítjuk (SzámsorT + Refl), nem a könyvtárból vesszük — «Minden bizonyítást az alapaxiómákból kell levezetni» (HOROG).
- **Nagy számok** (240 = E8 gyökök száma): tizedes data-struktúra (`data SzámjegyesSzám`), nem unáris Peano (a Peano unáris — lassú).

## A terv frissítve

`docs/TipusCsomagolasiTerv_2026-09-02.md` III.7 szakasz: a nyitott kérdés #1 MEGVÁLASZOLVA — **Nat sehol, sem érték-szinten, sem típus-szintű indexként.**

## A hátralévő nyitott kérdések

1. A `Betű` legyen teljesen független a `Char`-tól? (javaslat: igen, 44 konstruktor)
2. A `Show`-határ: String csak a `main`-ben megengedett?
3. A `tanulsagok/` 65 próbafájlja átírandoó vagy archiválható?

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★