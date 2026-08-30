# Független Kritikai Review — AlphaSteaneVegso.idr

**Dátum:** 2026-08-20
**Reviewer:** független alügynök (friss kontextus, csak olvasott és új fájlt írt)
**Tárgy:** `szima_ter/modul/AlphaSteaneVegso.idr` — az α⁻¹ és G levezetése a Steane [[7,1,3]] kódból
**Hivatkozott fájlok:** `AlphaSteane.idr` (korábbi verzió), `TetrapodaTest.idr`, `docs/BiologiaForrasok.md`, `docs/FizikaForrasok.md`

---

## 1. Fordítás és futás

### 1.1 Fordítás (`idris2 --check AlphaSteaneVegso.idr`)

```
$ idris2 --check AlphaSteaneVegso.idr
EXIT_CODE=0
```

**Eredmény:** a fájl fordul. Nincs hiba, nincs figyelmeztetés. A `%default total` direktíva érvényesül — minden függvény total (termináló). A 8 Refl-bizonyítás mind átment a kernen.

### 1.2 Futás (`idris2 --exec main AlphaSteaneVegso.idr`)

A `main : IO ()` lefut. A kimenet (részletek):

```
α⁻¹ = α⁻¹_bare - δ = 137.03599917700356
CODATA = 137.035999177
Δ/σ = 1.6917684184764291e-4  ✅ BELÜL

G = G_bare × (1+9/250)^(1/40) = 6.67429426915717e-11
CODATA G = 6.6743e-11
Δ/σ = 0.0382056188596198  ✅ BELÜL

(G/G_bare)^40 - 1 = 0.0359999999999967
9/256 pontosan = 0.036
egyezik? IGEN ✅
```

**Megjegyzés:** a kimenetben a "9/256 pontosan = 0.036" felirat HIBÁS — a kód a `tortresz` nevű változót írja ki, amely `tortresz = tortreszSzamlalo / tortreszNevezo = 9 / 250 = 0.036`, nem 9/256. A felirat "9/256" elgépelés, a változó értéke 9/250. Ez nem befolyásolja a számítást, de a kimenet félrevezető.

### 1.3 Összegzés (fordítás/futás)

A kód fordul és fut. A numerika konzisztens. **A kód mint program helyes.** A kérdés az, hogy a kód mint LEVEZETÉS helyes-e — l. alább.

---

## 2. Lépésenkénti bírálata

### 2.1 A három bemenet (n=7, k=1, d=3) — SZILÁRD

A Steane [[7,1,3]] kód paramétere: n=7 fizikai qubit, k=1 logikai qubit, d=3 távolság. A `FizikaForrasok.md` §1a idézi az eredeti Steane 1996 cikket (PRL 77, 793, DOI: 10.1103/PhysRevLett.77.793), és §1b az arXiv:2504.01083 megerősíti: "The [[7,1,3]] Steane code is a QEC code that encodes a single logical qubit into seven physical qubits, capable of correcting any single-qubit error." A távolság d=3: "this minimum weight corresponds precisely to the code distance d = 3."

**Ítélet:** SZILÁRD. A három bemenet a Steane kód standard paramétere, peer-reviewed forrásokkal alátámasztva.

### 2.2 s = n - k = 6 — SZILÁRD

A stabilizátor-generátorok száma. A `FizikaForrasok.md` §1b idézi: "Each stabilizer imposes one constraint on the original 2^n-dimensional Hilbert space of n physical qubits, leaving 2^{n−r} degrees of freedom to encode k = n − r logical qubits." Itt n=7, r=6, k=1. Tehát s = r = n - k = 6.

**Ítélet:** SZILÁRD. A 6 strukturális — a kód definíciójából jön.

### 2.3 N = 2^n = 128 — SZILÁRD

A kódszó-tér (a Hilbert-tér dimenziója n=7 qubithez). 2^7 = 128. Standard kvantuminformatika.

**Ítélet:** SZILÁRD.

### 2.4 M = 2^(n+1) = 256 — MAGIC NUMBER (PROBLÉMÁS)

A "kiterjesztett tér" = 2^(n+1) = 2^8 = 256. A kérdés: **miért n+1?** A Steane kód 7 qubites — nincs "8. qubit". A `FizikaForrasok.md` sehol nem definiálja a "kiterjesztett teret" mint 2^(n+1)-et. A kód kommentje (sor 20): "M = 2^(n+1) = 256 (kiterjesztett tér = n+1 qubit)" — de nincs indoklás, miért n+1 qubit.

A 256 azért kell, mert:
- 250 = M - s = 256 - 6 (a törtrész nevezője)
- 249 = M - n = 256 - 7 (a lobásás exponens egész része)

Ha M = 2^n = 128 lenne (a természetes választás), akkor 128 - 6 = 122 és 128 - 7 = 121 — ezek nem adják a kellő értékeket. A 256 = 2^8 tehát **utólagos illesztés**: azért választották, hogy a 250 és a 249 kijöjjön.

**Ítélet:** MAGIC NUMBER. A 256 nincs levezetve a Steane kódból. A "kiterjesztett tér" fogalma nincs irodalmi forrással alátámasztva. A "+1" a 2^(n+1)-ben egy utólagos illesztés, hogy a 250 és 249 kijöjjön.

### 2.5 137 = 2^7 + 2^3 + 2^0 = 128 + 8 + 1 — RÉSZBEN SZILÁRD, RÉSZBEN MAGIC

#### 2.5a 128 = 2^7 = N — SZILÁRD
A kódszó-tér. L. 2.3.

#### 2.5b 8 = 2^3 = 2^d — PROBLÉMÁS
A "távolság hatványa" — de miért 2^d? A d=3 távolság fizikai jelentősége a hibajavítás ereje (1 hibát javít), de a 2^d = 8 nem egy standard fizikai mennyiség a Steane kódban. A hiba-szindróma 2^d = 8 féle lehetne (3 qubit hiba, 2^3 = 8 szindróma), de ez nincs levezetve. A kód kommentje (sor 26): "2^d = 8 = a távolság hatványa (a hibajavítás ereje)" — analógia, nem levezetés.

#### 2.5c 1 = "a Legendre perem (grade 0 az Cl(4)-ben)" — MAGIC NUMBER
A "Legendre perem" és a "Cl(4)" sehol máshol nincs definiálva a projektben. Nincs irodalmi forrás. A `FizikaForrasok.md` §6e kifejezetten jelzi: "A **2⁷, 2³, 2⁰ komponensek fizikai interpretációja** nem resze a peer-reviewed fizikai szakirodalomnak — ez a projekt saját kategóriaelméleti-interpretációs hipotézise."

Az 1 azért kell, mert 128 + 8 = 136 ≠ 137, és az 137 kell az α⁻¹ közelítéshez. Az 1 egy **utólagos illesztés**: a 137 decimális érték bináris felbontása (10001001₂ = 128+8+1) utólag jön, nem a kódból.

**Ítélet:** RÉSZBEN SZILÁRD (a 128 strukturális), RÉSZBEN PROBLÉMÁS (a 8 = 2^d analógia), RÉSZBEN MAGIC NUMBER (az 1 = "Legendre perem" nincs levezetve). A 137 = 128+8+1 felbontás utólagos: a 137 decimális értéket bontják binárisra, nem a kódból jön.

### 2.6 9 = s + d = 6 + 3 — STRUKTURÁLIS, DE AZ ÖSSZEADÁS NEM LEVEZETETT

A 6 strukturális (s = n - k), a 3 strukturális (d). De a **6+3 = 9 összeadás** miért? Mi fizikai indokolja, hogy a stabilizátorok számát és a távolságot összeadjuk? Nincs levezetés.

Az `AlphaSteane.idr` (korábbi verzió) egy azonosítást tesz (sor 24): "(s+d) = 2^d + 1 = 9 (azonosság a [[7,1,3]]-ra)". De ez nem azonososság: s+d = 6+3 = 9, és 2^d + 1 = 8+1 = 9. Ezek numerikusan egyenlő, DE fogalmilag különböző konstrukciók. A numerikus egyenlőség a 9-re **véletlen egybeesés** (a [[7,1,3]] specifikus paramétereire: 6+3 = 9 és 8+1 = 9), nem pedig strukturális azonosság. Ha n=9, k=1, d=3 lenne (egy [[9,1,3]] kód), akkor s+d = 8+3 = 11 és 2^d+1 = 9 — nem egyenlő. Tehát az "azonosság" CSAK a [[7,1,3]]-ra igaz, ami utólagos illesztés.

**Ítélet:** STRUKTURÁLIS (a 6 és 3 külön-külön), DE az összeadás (6+3 = 9) és az "azonosság" (s+d = 2^d+1) nincs levezetve. Numerikus egybeesés a specifikus paramétereken.

### 2.7 250 = M - s = 256 - 6 — MAGIC (M magic)

Mivel M = 256 magic number (l. 2.4), a 250 is magic. A "kiterjesztett tér - stabilizátorok" fogalmilag: 256 - 6 = 250. De milyen fizikai mennyiség a "kiterjesztett tér - stabilizátorok"? Nincs irodalmi forrás.

**Ítélet:** MAGIC NUMBER (M magic, a kivonás nem levezetett).

### 2.8 δ = (121/128)^(249+ln(9/8)) — PROBLÉMÁS (több magic)

#### 2.8a 121 = N - n = 128 - 7 — PROBLÉMÁS
A "tiszta tér" (kódszó-tér - kód hossza). A `FizikaForrasok.md` §1b írja: "a stabilizátor-altér (tiszta tér) komplementer dimenziója 128 − 7 = 121 (a 7 egykvantum-bit hibatér dimenziója)." De ez a forrás szerint is **interpretáció**, nem standard. A 128 - 7 = 121 numerikusan igaz, de a "tiszta tér" fogalom nincs standard kvantumhibajavítási irodalomban.

#### 2.8b 121/128 mint "lobásás bázis" — ANALÓGIA, NEM LEVEZETÉS
"Minden Y-lépésben a hibajavítás 7/128-át költ el, 121/128 marad." — ez egy analógia (a hibajavítás mint "költés"), nem levezetés. Nincs forrás, ami ezt a lobásás-formulát adná. A (N-n)/N = (128-7)/128 = 121/128 alakja utólagos: azért kell, hogy a δ = (121/128)^(...) ≈ 8.23×10⁻⁷ kijöjjön.

#### 2.8c 249 = M - n = 256 - 7 — MAGIC (M magic)
M magic (l. 2.4), tehát 249 is magic.

#### 2.8d ln(9/8) mint "a zenei temperálás logaritmusa" — ANALÓGIA
A 9/8 jön a (s+d)/2^d = 9/8-ból (l. 2.6 és 2.5b). A püthagoraszi nagy egész hang (major second, 203.9 cent) — ezt a `FizikaForrasok.md` §5a megerősíti. De miért a **logaritmus**? "a zenei temperálás logaritmusa = a lobásás exponensének nem-egész (nem-determinisztikus) része" — analógia, nem levezetés. A lobásás exponens egész része (249) + nem-egész része (ln(9/8)) összeadásának nincs fizikai indoka. Miért épp ln(9/8) és nem log₂(9/8) vagy log₁₀(9/8)? Azért, mert ln(9/8) ≈ 0.1178, és 249 + 0.1178 = 249.1178, és (121/128)^249.1178 ≈ 8.23×10⁻⁷ — ami pont jó. Ha log₂(9/8) ≈ 0.1699 lenne, akkor (121/128)^249.1699 ≈ 7.86×10⁻⁷ — más érték. Tehát az ln (természetes logaritmus) választása **utólagos illesztés**: azért ln, hogy a δ a megfelelő értéket adja.

#### 2.8e Az egész δ formula — UTÓLAGOS ILLESZTÉS
A δ = (121/128)^(249+ln(9/8)) = 8.22996×10⁻⁷. Ez AZÉRT jó, mert 137.036 - 8.22996×10⁻⁷ ≈ 137.035999177. De a formula alakja (bázis = (N-n)/N, exponens = (M-n) + ln((s+d)/2^d)) **utólagos illesztés** — a bázist és az exponenst úgy választották, hogy az eredmény 8.23×10⁻⁷ legyen. Nincs fizikai vagy matematikai indok, ami erre a formulaalakra vezetne.

**Ítélet:** PROBLÉMÁS. A δ formula alakja utólagos illesztés. A 121/128 bázis analógia, a 249 exponens magic (M magic), az ln(9/8) exponens-rész utólagos (az ln választása illesztés). A δ = 8.23×10⁻⁷ érték AZÉRT jön ki, mert a formulát úgy kalibrálták.

---

## 3. A G levezetés — PROBLÉMÁS (több magic)

### 3.1 G_bare formula

```
G_bare = (n × (n+d+k)) / ((2^d) × (n-2k)²) × √d × 10⁻¹⁰
       = (7 × 11) / (8 × 25) × √3 × 10⁻¹⁰
       = 77 / 200 × 1.732 × 10⁻¹⁰
       = 0.6674 × 10⁻¹⁰
       = 6.674 × 10⁻¹¹
```

#### 3.1a 11 = n+d+k = 7+3+1 — a "kapu prím"
Mi a "kapu prím"? Nincs irodalmi forrás. A n+d+k = 11 összeadásnak nincs fizikai indoka. Miért kéne a n, d, k összeadásának a gravitációval köze lenni?

#### 3.1b 5 = n-2k = 7-2 — a "tükör prím"
Mi a "tükör prím"? Nincs irodalmi forrás. A n-2k = 5 egy algebrai művelet eredménye, de a fizikai jelentőség nincs levezetve.

#### 3.1c 40 = 2^d × (n-2k) = 8 × 5 — az "oktáv³ × tükör"
Fogalmi konstrukció ("oktáv³ × tükör"), nem fizikai. A 2^d = 8 = "oktáv" analógia (3 oktáv = 2³), de ez zenei analógia, nem fizika.

#### 3.1d √3 = √d — a "kvint gyök"
Miért √d? Nincs indoklás. A √3 = √d egy algebrai művelet, de a fizikai jelentőség nincs levezetve.

#### 3.1e 10⁻¹⁰ — MAGIC NUMBER (kifejezett)
EZ KIFEJEZETTEN MAGIC NUMBER. Miért épp 10⁻¹⁰? A G rendje 10⁻¹¹ (a CODATA érték 6.67430×10⁻¹¹). A 10⁻¹⁰ tehát nem is a G rendje — a (7×11)/(8×25)×√3 ≈ 0.6674, és 0.6674×10⁻¹⁰ = 6.674×10⁻¹¹. Tehát a 10⁻¹⁰ azért kell, hogy a (7×11)/(8×25)×√3 ≈ 0.6674 rész a megfelelő rendet adja. **Utólagos illesztés**: a 10⁻¹⁰ úgy van megválasztva, hogy a végeredmény a G rendjeibe essen. Ha 10⁻¹¹ lenne, akkor 0.6674×10⁻¹¹ = 6.674×10⁻¹² — rossz rend. Ha 10⁻⁹ lenne, akkor 0.6674×10⁻⁹ = 6.674×10⁻¹⁰ — rossz rend. A 10⁻¹⁰ az egyetlen, ami a G rendjét adja — de ez nem levezetés, hanem kalibrálás.

### 3.2 G_dressed formula

```
G = G_bare × (1 + 9/250)^(1/40)
```

A "(1+9/250)^(1/40) mint vákuum-polarizáció" analógia. A `FizikaForrasok.md` §2 a vákuum-polarizációt tárgyalja (Schwinger, Uehling, α/(3π)), de ezek a források NEM ADJÁK a (1+9/250)^(1/40) formulát. A Schwinger α/(2π) és az α/(3π) más szerkezetűek. A (1+x)^(1/n) alak a QED renormálási csoport formulájára hasonlít (e_dressed² = e_bare² / (1 - Π(q²))), de a (1+9/250)^(1/40) nem ebből jön — a 9/250 és a 40 a Steane kódból jön, nem a QED-ből. Tehát az "analógia" csak felületi: a formula alakja hasonlít a renormálásra, de a tartalom (9/250, 40) nem a QED-ből jön.

**Ítélet:** PROBLÉS. A G_bare formula alakja nincs levezetve — a 11, 5, 40, √3 mind analógiák vagy fogalmi konstrukciók. A 10⁻¹⁰ kifejezett magic number. A (1+9/250)^(1/40) "vákuum-polarizáció" analógia felületi — a tartalom a Steane kódból jön, nem a QED-ből.

---

## 4. A 9/250 kivezetése a G-ből — KÖRÖZŐ (TAUTOLÓGIA)

A kód szerint (sor 90, komment):
```
(G/G_bare)^(2^d×(n-2k)) - 1 = (1+9/250)^1 - 1 = 9/250  (pontosan)
```

A futtatás kimenete:
```
(G/G_bare)^40 - 1 = 0.0359999999999967
9/256 pontosan = 0.036
egyezik? IGEN ✅
```

**Bírálata:** EZ TAUTOLÓGIA. A G_dressed = G_bare × (1+9/250)^(1/40) definícióból. Tehát:

```
G_dressed / G_bare = (1+9/250)^(1/40)
(G_dressed / G_bare)^40 = (1+9/250)^(40/40) = 1+9/250
(G_dressed / G_bare)^40 - 1 = 9/250
```

Ez **pontosan** kijön — definícióból. A "9/250 kivezethető a G-ből" állítás **KÖRÖZŐ**: a 9/250-t betettük a G-be (mint G_dressed = G_bare × (1+9/250)^(1/40)), aztán kivetjük belőle (mint (G_dressed/G_bare)^40 - 1 = 9/250). A kimenet (0.0359999999999967) egy numerikus apró hiba a lebegőpontos aritmetikából (a 0.036 - 0.0359999999999967 = 3.3×10⁻¹⁵), nem pedig valódi "egyezés". A "pontosan reverzibilis" állítás (sor 94) **igaz**, de csak azért, mert a 9/250-t előbb betettük — ez köröző érvelés.

**A kimenet "9/256 pontosan = 0.036" felirata is HIBÁS** — a változó értéke 9/250 = 0.036, nem 9/256. A felirat elgépelés, de félrevezető.

**Ítélet:** KÖRÖZŐ (TAUTOLÓGIA). A 9/250 kivezetése a G-ből nem levezetés — a 9/250-t előbb betettük a G-be, aztán kivetjük. A "pontosan reverzibilis" állítás igaz, de köröző.

---

## 5. A 137 = [k,d,n] base 10-ben — NUMEROLÓGIA

A kód szerint (sor 97-100):
```
10 = 2 × 5 = oktáv × tükör
base 10-ben: 137 = 1×100 + 3×10 + 7×1 = [k, d, n]
CSAK base 10-ben (a 10 = 2×5 miatt)
```

A `TetrapodaTest.idr` kiegészíti: a 2 = bilaterális szimmetria (~600 Mya), az 5 = pentadactylia (360 Mya, Hox-gének), a 2×5 = 10 = base 10.

### 5.1 A biológiai kapcsolat — SZILÁRD (a források)

A `BiologiaForrasok.md` jól dokumentálja:
- A pentadactylia (5 ujj) evolúciós konzervációja: Tabin 1992 (PMID 1363084), Kherdjemil 2017/2018, Towers 2025. AZ 5 ujj egy **fejlesztési korlát** (Hox-gének 5 szektora), nem véletlen.
- A bilaterális szimmetria ~600 Mya (Wray 1996, De Robertis 2022).
- A tetrapodia 4 végtag (Tiktaalik 375 Mya, Shubin 2006).

**A biológiai tények SZILÁRDOK** — a források peer-reviewed, az idézetek ellenőrizhetők.

### 5.2 A 137 = [k,d,n] base 10 — NUMEROLÓGIA

A probléma: a **base 10 választása**. Az 137 = [k,d,n] CSAK base 10-ben igaz:
- base 2: 137 = 10001001₂, nem [k,d,n]
- base 7: 137 = 254₇, nem [k,d,n]
- base 8: 137 = 211₈, nem [k,d,n]
- base 16: 137 = 89₁₆, nem [k,d,n]

Tehát az állítás az emberi test 2×5 ujjára és a base 10-re épül. De a base 10 VÁLASZTÁSA azért történt, mert az 137 = [k,d,n] CSAK base 10-ben igaz. Ez **köröző**: az emberi test → base 10 → 137 = [k,d,n] → Steane [[7,1,3]] → fizikai konstansok. De a base 10-et úgy választották, hogy az 137 = [k,d,n] igaz legyen — utólagos illesztés.

Ha base 7 lenne (ami szintén természetes: 7 nap, 7 qubit, 7 szín), akkor 137 (base 7) = 254, nem [k,d,n]. Ha base 8 lenne (ami szintén természetes: 8 oktáv, 2³), akkor 137 (base 8) = 211, nem [k,d,n]. A base 10 az EGYETLEN, ami az 137 = [k,d,n] igazságot adja — de ez nem levezetés, hanem kalibrálás.

### 5.3 A "2 = oktáv, 5 = tükör" analógia — PROBLÉMÁS

A 2 = oktáv (zenei analógia: oktáv = 2:1 frekvenciaarány), az 5 = tükör (biológiai analógia: pentadactylia). Ezek KÉT KÜLÖNBÖZŐ analógia összevonása: a zenei oktáv és a biológiai pentadactylia nincs strukturális kapcsolatban — az 2×5 = 10 összeadás a két analógiát köti össze, de a kötés maga nincs levezetve.

**Ítélet:** NUMEROLÓGIA. A biológiai tények (5 ujj, 2 oldal) szilárdak, de a 137 = [k,d,n] base 10-ben utólagos illesztés — a base 10-et úgy választották, hogy az 137 = [k,d,n] igaz legyen. A "2 = oktáv, 5 = tükör" két különböző analógia összevonása, a kötés nincs levezetve.

---

## 6. A bizonyítások (8 Refl) — VALÓDI, DE CSAK AZ ÉRTÉKET BIZONYÍTJÁK

### 6.1 A 8 Refl-bizonyítás felsorolása

| # | Név | Bal oldal (konstrukció) | Jobb oldal (literál) | Ítélet |
|---|---|---|---|---|
| 1 | bizKodSzoTer | `pow 2.0 n` (= `pow 2.0 7.0`) | `128.0` | IGAZI |
| 2 | bizTisztaTer | `kodSzoTer - n` (= `128.0 - 7.0`) | `121.0` | IGAZI |
| 3 | bizEgyesResz | `kodSzoTer + pow 2.0 d + 1.0` (= `128.0 + 8.0 + 1.0`) | `137.0` | IGAZI |
| 4 | bizTortreszNevezo | `kiterjesztettTer - s` (= `256.0 - 6.0`) | `250.0` | IGAZI |
| 5 | bizLobaszasExponensEgesz | `kiterjesztettTer - n` (= `256.0 - 7.0`) | `249.0` | IGAZI |
| 6 | bizTukorPrim | `n - 2.0 * k` (= `7.0 - 2.0`) | `5.0` | IGAZI |
| 7 | bizKapuPrim | `n + d + k` (= `7.0 + 3.0 + 1.0`) | `11.0` | IGAZI |
| 8 | bizKetHatvanyTukor | `pow 2.0 d * tukorPrim` (= `8.0 * 5.0`) | `40.0` | IGAZI |

### 6.2 Értékelés

Minden Refl-bizonyítás **VALÓDI**: a bal oldal mindig egy **KONSTRUKCIÓ** (függvényalkalmazás: `pow`, `-`, `+`, `*`), a jobb oldal mindig egy **LITERÁL**. A kernel kiszámolja a konstrukciót és ellenőrzi, hogy egyenlő-e a literállal. **NEM TAUTOLÓGIA** — a két oldal fogalmilag különböző. Ez megfelel az AGENTS §18.1 követelménynek ("A bizonyítás-típus bal és jobb oldala KÜLÖNBÖZŐ konstrukció legyen").

A bizonyítások CSAK a levezetett mennyiségek **ÉRTÉKÉT** bizonyítják (128, 121, 137, 250, 249, 5, 11, 40). **Nem bizonyítják**, hogy ezek a mennyiségek BÁRMILYEN fizikai jelentőséggel bírnak. A Refl azt mondja, hogy "128 - 7 = 121" — ez igaz. De azt NEM mondja, hogy "121 a tiszta tér dimenziója a Steane kódban" — ez egy **interpretáció**, amit a Refl nem fed. A `FizikaForrasok.md` §6e kifejezetten jelzi: a bináris komponensek fizikai interpretációja "nem része a peer-reviewed fizikai szakirodalomnak — ez a projekt saját kategóriaelméleti-interpretációs hipotézise."

**Hiányzó bizonyítások:** nincs Refl-bizonyítás a következőkre:
- α⁻¹_dressed = α⁻¹_bare - δ (ez futásidejű Double-aritmetika, nem Refl)
- G_dressed = G_bare × (1+9/250)^(1/40) (szintén futásidejű)
- A δ ≈ 8.23×10⁻⁷ (szintén futásidejű)
- A G ≈ 6.674×10⁻¹¹ (szintén futásidejű)

Ezek a fő eredmények NINCSENK Refl-bizonyítással — csak futásidejű Show-kimenettel. A futtatás kimenete ellenőrizhető, de nem "bizonyított" a kernel által (a Double-aritmetika nem Refl-lel ellenőrzött).

**Ítélet:** VALÓDI (a 8 Refl nem tautológia), DE CSAK AZ ÉRTÉKET BIZONYÍTJÁK. A fizikai interpretáció nincs bizonyítva. A fő eredmények (α⁻¹, G) csak futásidejű Show-kimenettel rendelkeznek, nem Refl-lel.

---

## 7. A CODATA összehasonlítás — NUMERIKUSAN HELYES, DE A FORMULA ILLESZTÉS

### 7.1 α⁻¹

A kód szerint:
```
α⁻¹_dressed = 137.03599917700356
CODATA      = 137.035999177
Δ           = 137.03599917700356 - 137.035999177 = 3.56×10⁻¹²
σ           = 2.1×10⁻⁸
Δ/σ         = 3.56×10⁻¹² / 2.1×10⁻⁸ = 1.69×10⁻⁴ ≈ 0.00017
```

**Numerikusan HELYES.** A σ = 2.1×10⁻⁸ a `FizikaForrasok.md` §3a szerint is a CODATA 2022 értéke (α⁻¹ = 137.035999177(21), a (21) = 21×10⁻⁹ = 2.1×10⁻⁸). A Δ/σ = 0.00017 < 1, tehát a mérési hibán belül van. **A számolás szilárd.**

**DE:** a Δ = 3.56×10⁻¹² azért kicsi, MERT a δ-t úgy kalibrálták, hogy 137.036 - δ ≈ 137.035999177. Tehát a Δ/σ = 0.00017 azért kicsi, mert a δ formula **utólagos illesztés** (l. 2.8e). Ha a δ formula alakja más lenne, a Δ más lenne. A "mérési hibán belül" állítás **numerikusan igaz**, de a formula alakja **nem levezetett** — a δ-t úgy kalibrálták, hogy az eredmény jó legyen.

### 7.2 G

A kód szerint:
```
G_dressed   = 6.67429426915717e-11
CODATA G    = 6.67430e-11
Δ           = 6.67429426915717e-11 - 6.67430e-11 = -5.73×10⁻¹⁶
σ           = 1.5×10⁻¹⁵
Δ/σ         = 5.73×10⁻¹⁶ / 1.5×10⁻¹⁵ = 0.382 ≈ 0.038
```

**Numerikusan HELYES.** A σ = 1.5×10⁻¹⁵ a `FizikaForrasok.md` §4a szerint is a CODATA értéke (G = 6.67430(15)×10⁻¹¹, a (15) = 0.00015×10⁻¹¹ = 1.5×10⁻¹⁵). A |Δ|/σ = 0.038 < 1, tehát a mérési hibán belül van. **A számolás szilárd.**

**DE:** a G_bare formula 10⁻¹⁰ szorzója **magic number** (l. 3.1e). A (7×11)/(8×25)×√3 ≈ 0.6674 rész és a 10⁻¹⁰ szorzó úgy vannak megválasztva, hogy 0.6674×10⁻¹⁰ = 6.674×10⁻¹¹ ≈ G_CODATA. A (1+9/250)^(1/40) korrekció ≈ 1.000897, ami 6.6684×10⁻¹¹ × 1.000897 ≈ 6.6743×10⁻¹¹. Tehát a "mérési hibán belül" állítás **numerikusan igaz**, de a formula alakja (különösen a 10⁻¹⁰) **utólagos illesztés**.

### 7.3 A σ értékek helyessége

| Konstans | σ a kódban | σ a `FizikaForrasok.md` szerint | Egyezik? |
|---|---|---|---|
| α⁻¹ | 2.1×10⁻⁸ | 2.1×10⁻⁸ (§3a, CODATA 2022) | IGEN |
| G | 1.5×10⁻¹⁵ | 1.5×10⁻¹⁵ (§4a, CODATA 2018/2022) | IGEN |

**A σ értékek HELYESEK** — a `FizikaForrasok.md` által hivatkozott NIST CODATA értékekkel egyeznek.

### 7.4 Megjegyzés az AGENTS §17 (mérési hiba-kötelezettség)

Az AGENTS §17 előírja a relatív hiba (Δ/σ) kötelező megadását. A kód MEGADJA a Δ/σ-t (a futtatás kimenetében). **HELYES.** De az AGENTS §17.3 is előírja: "ha a projekt saját keretdokumentuma olyan állítást tesz, amit a projekt SAJÁT számai cáfolnak... a feladat NEM az állítás ismétlése, hanem a hibák megjelölése és a pontos érték kiszámítása." A kód NEM cáfolja önmagát — a Δ/σ értékek a mérési hibán belül vannak. **HELYES.**

**Ítélet:** NUMERIKUSAN HELYES (a Δ/σ számolás és a σ értékek helyesek), DE a formula alakja (különösen a δ és a 10⁻¹⁰) utólagos illesztés. A "mérési hibán belül" állítás igaz, de a formula nem levezetett — kalibrált.

---

## 8. Hiányzó lépések

### 8.1 Nincs levezetve (magic number vagy analógia)

| # | Mennyiség | Mi hiányzik? | Ítélet |
|---|---|---|---|
| 1 | M = 2^(n+1) = 256 | Miért n+1? A "kiterjesztett tér" nincs irodalmi forrással. | MAGIC NUMBER |
| 2 | 1 (a "Legendre perem") | Nincs definíció, nincs forrás. | MAGIC NUMBER |
| 3 | 9 = s+d = 2^d+1 "azonosság" | Csak [[7,1,3]]-ra igaz, nem strukturális. | NUMERIKUS EGBEESÉS |
| 4 | 121 = N-n ("tiszta tér") | A fogalom nem standard, interpretáció. | PROBLÉMÁS |
| 5 | 121/128 mint "lobásás bázis" | Analógia, nem levezetés. | ANALÓGIA |
| 6 | 249+ln(9/8) mint "lobásás exponens" | Az összeadás nincs indokolva. | ANALÓGIA |
| 7 | ln (természetes logaritmus) választása | Más logaritmus más δ-t ad. | ILLESZTÉS |
| 8 | 10⁻¹⁰ (G_bare szorzó) | Miért 10⁻¹⁰? A G rendje 10⁻¹¹. | MAGIC NUMBER |
| 9 | 11 = n+d+k ("kapu prím") | Nincs forrás, nincs fizikai indok. | ANALÓGIA |
| 10 | 5 = n-2k ("tükör prím") | Nincs forrás, nincs fizikai indok. | ANALÓGIA |
| 11 | 40 = 2^d×(n-2k) ("oktáv³×tükör") | Fogalmi konstrukció, nem fizika. | ANALÓGIA |
| 12 | √d ("kvint gyök") | Miért √d? Nincs indoklás. | ANALÓGIA |
| 13 | (1+9/250)^(1/40) ("vákuum-polarizáció") | A tartalom Steane-kódból jön, nem QED-ből. | FELÜLETI ANALÓGIA |
| 14 | base 10 választása | Más bázis más [k,d,n]-t ad (vagy semmit). | ILLESZTÉS |
| 15 | 137 = [k,d,n] csak base 10-ben | A base 10 azért, hogy ez igaz legyen. | NUMEROLÓGIA |

### 8.2 Nincs bizonyítva (Refl)

| # | Állítás | Mi hiányzik? |
|---|---|---|
| 1 | α⁻¹_dressed = α⁻¹_bare - δ ≈ 137.035999177 | Csak futásidejű Show, nem Refl. |
| 2 | G_dressed = G_bare × (1+9/250)^(1/40) ≈ 6.674×10⁻¹¹ | Csak futásidejű Show, nem Refl. |
| 3 | δ ≈ 8.23×10⁻⁷ | Csak futásidejű Show, nem Refl. |
| 4 | (G/G_bare)^40 - 1 = 9/250 | Csak futásidejű Show (a 0.035999... numerikus hibával), nem Refl. |

### 8.3 Nincs irodalmi forrás

| # | Állítás | Mi hiányzik? |
|---|---|---|
| 1 | A "kiterjesztett tér" = 2^(n+1) fogalom | Nincs forrás. |
| 2 | A "Legendre perem" = 1 fogalom | Nincs forrás. |
| 3 | A "lobásás" (121/128)^(249+ln(9/8)) formula | Nincs forrás. |
| 4 | A G_bare formula alakja | Nincs forrás. |
| 5 | A (1+9/250)^(1/40) mint "vákuum-polarizáció" | A `FizikaForrasok.md` §2 a QED vákuum-polarizációt tárgyalja, de NEM ADJA a (1+9/250)^(1/40) formulát. |
| 6 | A "kapu prím", "tükör prím", "oktáv³×tükör" fogalmak | Nincs forrás. |
| 7 | A 137 = [k,d,n] base 10 fizikai jelentősége | Nincs forrás. |

### 8.4 Inkonzisztencia a két fájl között

Az `AlphaSteane.idr` (korábbi) és az `AlphaSteaneVegso.idr` (végső) között van egy eltérés:
- `AlphaSteane.idr` (sor 18-21): α⁻¹_bare = 2^n + (s+d) + (s+d)/(M-s) = 128 + 9 + 9/250 = 137 + 9/250. Itt a 137 = 2^n + 2^d + 1 = 128 + 8 + 1, és az (s+d) = 2^d + 1 = 9 "azonosságot" használja, az (s+d) = 9 az EGÉSZ rész része (128 + 9 + 9/250).
- `AlphaSteaneVegso.idr` (sor 34-35): α⁻¹_bare = (2^n + 2^d + 1) + (s+d)/(M-s) = 137 + 9/250. Itt az (s+d)/(M-s) = 9/250 csak a TÖRTrész, és az egész rész a 137 = 128+8+1.

Ez **KÖRÖZŐ**: az (s+d) = 2^d + 1 = 9 "azonosság" miatt a két felírás numerikusan azonos (128 + 9 + 9/250 = 137 + 9/250 = 137.036), de fogalmilag különböző. A Vegso verzió tisztább (a 137 az egész rész, a 9/250 a törtrész), de a korábbi verzió az (s+d) = 9-ot az egész részbe tette — ez inkonzisztens. A Vegso verzió javítja ezt, de a javítás itself rávilágít, hogy az (s+d) = 2^d + 1 "azonosság" numerikus egybeesés, nem strukturális.

---

## 9. Összegzés: mi szilárd, mi spekulatív, mi hibás

### 9.1 SZILÁRD (peer-reviewed forrással alátámasztva)

| Állítás | Forrás |
|---|---|
| A Steane [[7,1,3]] kód paraméterei: n=7, k=1, d=3 | Steane 1996 PRL + arXiv:2504.01083 (`FizikaForrasok.md` §1) |
| s = n - k = 6 (stabilizátor-generátorok) | arXiv:2504.01083 (`FizikaForrasok.md` §1b) |
| N = 2^n = 128 (kódszó-tér) | Standard kvantuminformatika |
| A 9/8 püthagoraszi nagy egész hang (203.9 cent) | Wikipedia + Xenharmonic + Tonalsoft (`FizikaForrasok.md` §5) |
| α⁻¹ CODATA 2022 = 137.035999177(21), σ = 2.1×10⁻⁸ | NIST CODATA 2022 (`FizikaForrasok.md` §3a) |
| G CODATA = 6.67430(15)×10⁻¹¹, σ = 1.5×10⁻¹⁵ | NIST CODATA (`FizikaForrasok.md` §4a) |
| A pentadactylia (5 ujj) evolúciós konzervációja | Tabin 1992, Kherdjemil 2017/2018, Towers 2025 (`BiologiaForrasok.md` §1, §5) |
| A bilaterális szimmetria ~600 Mya | Wray 1996, De Robertis 2022 (`BiologiaForrasok.md` §2) |
| A tetrapodia 4 végtag (Tiktaalik 375 Mya) | Shubin 2006 (`BiologiaForrasok.md` §1.1, §3) |
| A 8 Refl-bizonyítás valódi (nem tautológia) | A kernel ellenőrizte (exit 0) |
| A Δ/σ számolás numerikusan helyes (α⁻¹: 0.00017, G: 0.038) | A futtatás kimenete |

### 9.2 SPEKULATÍV (interpretáció, analógia, nincs peer-reviewed forrás)

| Állítás | Miért spekulatív? |
|---|---|
| A 137 = 2^7 + 2^3 + 2^0 bináris felbontás fizikai jelentősége | A `FizikaForrasok.md` §6e kifejezetten jelzi: "nem része a peer-reviewed fizikai szakirodalomnak — ez a projekt saját kategóriaelméleti-interpretációs hipotézise." |
| A "kiterjesztett tér" = 2^(n+1) = 256 fogalom | Nincs irodalmi forrás. |
| A 121 = N-n ("tiszta tér") fogalom | A `FizikaForrasok.md` §1b szerint is interpretáció, nem standard. |
| A (121/128)^(249+ln(9/8)) mint "lobásás" formula | Nincs forrás, analógia. |
| A G_bare formula alakja (11, 5, 40, √3, 10⁻¹⁰) | Nincs forrás, analógiák és fogalmi konstrukciók. |
| A (1+9/250)^(1/40) mint "vákuum-polarizáció" | A QED vákuum-polarizáció más szerkezetű (α/(3π), Uehling-potenciál); a (1+9/250)^(1/40) tartalma a Steane kódból jön, nem a QED-ből. |
| A "kapu prím", "tükör prím", "oktáv³×tükör", "kvint gyök" fogalmak | Nincs forrás. |
| A 137 = [k,d,n] base 10 fizikai jelentősége | Numerológia (l. 5.2). |
| A CPT szimmetria rétegek (C=kivon, P=hozzáad, T=lobásás) | Analógia, nem levezetés. |
| A biológiai test kódolja a fizikai konstansokat | A biológiai tények szilárdak, de a kapcsolat a fizikai konstansokkal spekulatív. |

### 9.3 HIBÁS vagy MAGIC NUMBER

| # | Mennyiség | Mi a hiba? |
|---|---|---|
| 1 | M = 2^(n+1) = 256 | MAGIC NUMBER — a "+1" nincs levezetve, azért kell, hogy a 250 és 249 kijöjjön. |
| 2 | 1 (a "Legendre perem") | MAGIC NUMBER — nincs definíció, nincs forrás, azért kell, hogy 128+8+1 = 137. |
| 3 | 10⁻¹⁰ (G_bare szorzó) | MAGIC NUMBER — azért kell, hogy a G rendjébe essen. |
| 4 | A 9/250 kivezetése a G-ből | KÖRÖZŐ (TAUTOLÓGIA) — a 9/250-t betettük a G-be, aztán kivetjük. |
| 5 | A (s+d) = 2^d+1 = 9 "azonosság" | NUMERIKUS EGBEESÉS — csak [[7,1,3]]-ra igaz, nem strukturális. |
| 6 | A ln (természetes logaritmus) választása a δ-ban | ILLESZTÉS — más logaritmus más δ-t ad. |
| 7 | A base 10 választása a 137 = [k,d,n]-hez | ILLESZTÉS — más bázis nem ad [k,d,n]-t. |
| 8 | A kimenet "9/256 pontosan = 0.036" felirata | HIBA — a változó értéke 9/250, nem 9/256. Elgépelés a feliratban. |

### 9.4 Végső ítélet

A kód **mint program** helyes: fordul, fut, a numerika konzisztens, a 8 Refl-bizonyítás valódi, a Δ/σ számolás numerikusan helyes, a σ értékek a CODATA-nak megfelelnek.

A kód **mint levezetés** PROBLÉMÁS. A fő eredmények (α⁻¹, G) "mérési hibán belül" állítása **numerikusan igaz**, de a formula alakja **utólagos illesztés**:
- A δ = (121/128)^(249+ln(9/8)) formulát úgy kalibrálták, hogy 137.036 - δ ≈ 137.035999177.
- A G_bare 10⁻¹⁰ szorzóját úgy választották, hogy a G rendjébeessen.
- A 9/250 kivezetése a G-ből tautológia (betettük, aztán kivetjük).
- A 137 = [k,d,n] base 10 numerológia (a base 10 azért, hogy igaz legyen).

A három bemenet (n=7, k=1, d=3) SZILÁRD (Steane kód standard paraméter). A levezetett mennyiségek ÉRTÉKEI (128, 121, 137, 250, 249, 5, 11, 40) SZILÁRDAN BIZONYÍTVA (Refl, nem tautológia). DE a levezetett mennyiségek FIZIKAI JELENTŐSSÉGE (miért 2^(n+1), miért 2^d, miért a Legendre perem = 1, miért s+d, miért (N-n)/N bázis, miért 249+ln(9/8) exponens, miért a G_bare formula alakja, miért 10⁻¹⁰) **NINCS LEVEZETVE** — analógiák, fogalmi konstrukciók, és magic number-ök.

**A "Nincs magic number. Minden szám levezethető." állítás (sor 115) NEM IGAZ.** Három kifejezett magic number van: a 2^(n+1) = 256 (a "+1" nincs levezetve), az 1 ("Legendre perem"), és a 10⁻¹⁰ (G_bare szorzó). Továbbá több analógia (121/128 bázis, 249+ln(9/8) exponens, G_bare formula alakja) nincs levezetve — ezek utólagos illesztések, amelyek azért adnak jó eredményt, mert úgy lettek kalibrálva.

**A "haluhalmaz" vád (AGENTS §17 indoklás) részben jogos marad:** a Δ/σ < 1 eredmények nem bizonyítják, hogy a formula strukturális — csak azt, hogy a formula kalibrált. A különbség a "kalibrált" és a "levezetett" között kritikus: a kalibrált formula utólagos illesztés (a számokat úgy választották, hogy az eredmény jó legyen), a levezetett formula előre jön a struktúrából (a számok a kódból fakadnak, és az eredmény ezekből következik). Ez a levezetés a KÖZÉPSŐ LÉPÉSEKBEN (a 256, az 1, a 10⁻¹⁰, a δ formula alakja) nem teljesül — ezek utólagos illesztések.

---

*Review verzió: 1.0. Létrehozva: 2026-08-20, független kritikai alügynök. Csak olvasott és új fájlt írt — semmilyen más fájlt nem módosított.*