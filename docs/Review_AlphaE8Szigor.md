# Független Kritikai Review — AlphaE8Szigor.idr

**Dátum:** 2026-08-20
**Reviewer:** független alügynök (friss kontextus, csak olvasott és új fájlt írt)
**Tárgy:** `szima_ter/modul/AlphaE8Szigor.idr` — "az α⁻¹ és G szigorú típust levezetése az E8 Lie-algebrából"
**Hivatkozott fájlok:** `docs/Alpha_E8_Ut.md` (a levezetés története), `docs/Review_VegsoLevezetes.md` (a korábbi review), `szima_ter/modul/AlphaSteane.idr` és `AlphaSteaneVegso.idr` (elődverziók)

---

## 1. Fordítás és futás

### 1.1 Fordítás (`idris2 --check AlphaE8Szigor.idr`)

```
EXIT_CODE=0
```

A fájl fordul. A `%default total` érvényesül, minden függvény total. **A kód mint program fordul.**

### 1.2 Futás (`idris2 --exec main AlphaE8Szigor.idr`)

A `main : IO ()` lefut, EXIT_CODE=0. A kimenet kulcsértékei:

```
δ = (121/128)^(249+ln(9/8)) = 8.229964521572508e-7
α⁻¹ = 137.03599917700356
CODATA = 137.035999177
Δ/σ = 1.6917684184764291e-4  ✅ BELÜL
G = 6.67429426915717e-11
CODATA G = 6.6743e-11
Δ/σ = 0.0382056188596198  ✅ BELÜL
```

A numerika konzisztens a korábbi verziókkal és a `Review_VegsoLevezetes.md`-ben rögzített értékekkel. A Δ/σ számítás (a `main`-ben ténylegesen kiszámítva, `let rA = ...`) helyes az AGENTS §17 formátuma szerint. **A kód mint program helyes és futtatható.**

### 1.3 Két faktuális hiba a kimenetben

1. **"22 Refl-bizonyítás" — a valóság 21.** A fájlban megszámolható Refl-deklarációk: `bizE8Rang, bizSteaneD, bizKetD, bizSteaeN, bizSteaeK, bizPerem, bizStabilizatorok, bizKodszoTer, bizKiterjesztettTer, bizE9Clifford, bizE8Gyokok, bizE8LieAlgebra, bizD8Gyokok, bizEgyesResz, bizTortreszSzamlalo, bizTortreszNevezo, bizTisztaTer, bizLobaszasExponens, bizTukorPrim, bizKapuPrim, bizKetHatvanyTukor` = **21 darab**. A `main` ✓-listája is 21 sort ír. A fejléc (580. sor) és az összegzés (613. sor) "22"-t állít. **Off-by-one hiba a saját állításban.**
2. **`steaneK` deklarálva, de SOHA nincs definiálva.** A 104–106. sor:
   ```idris
   steaneK : Nat
   steaeK : Nat
   steaeK = 1
   ```
   A `steaneK` nevű konstans típusa megvan, értéke nincs — ez egy **nyitott lyuk** a modulban. Ma azért fordul, mert senki nem használja (a 242. sor `steaeK`-t használ). Ha bármely importáló modul `steaneK`-ra hivatkozik, a fordítás elszáll ("no definition"). A névadás maga is inkonzisztens (`steaneD`/`steaeN`/`steaeK` — kétféle írásmód ugyanarra a kódra), ami láthatóan ehhez a csonkhoz vezetett.

---

## 2. A Dimenzio típus

A `Dimenzio` típus (50–57. sor) 7 konstruktora: `DimenzioNelkuli, Hossz, Ido, Tomeg, Terfogat, Csataslas, Fazis`, plusz egy `Show` instance (59–67. sor).

**Megállapítás: a típus HOLT KÓD.** Greppel és teljes átolvasással ellenőriztem: a `Dimenzio` típus **egyszer sem szerepel semmilyen függvény szignatúrájában, rekordjában, vagy érték-konstrukciójában.** Egyetlen mennyiségnek sincs `Dimenzio` hordozója:

- `e8Rang : Nat`, `steaeN : Nat`, `kodszoTer : Nat` — csupasz `Nat`.
- `gDressed : Double` — csupasz `Double`, noha a komment "dimenzió: m³/(kg·s²)"-t állít, és épp erre a mennyiségre épült a `Csataslas` konstruktor.
- A `deltaSzamitott`, `alphaDressed` — csupasz `Double`, noha a komment "dimenzió nélküli"-t állít.

A fájl fejlécének ígérete ("Minden mennyiségnek van egy dimenziója — ez biztosítja, hogy ne keverjük össze…") **nincs a kódban megvalósítva**. A dimenzió-ellenőrzés kommentben él, a típusellenőrző nem látja. A "biztosítja" szó itt pontosan az a komment-vs-típus távolság, amit az AGENTS §18.2 tilt: a komment állít, a típus nem ellenőriz. (Referencia-pont: a korábbi `Review_VegsoLevezetes.md` is megjegyezte, hogy a fizikai interpretációk "a Refl nem fedi" — itt még a Refl-igényt sem éri el a kód, mert a típus használatlan.)

**Ítélet: deklarált, de használatlan. Az erős típusos dimenzió-analízis illúzió — a valóságban csupasz Nat/Double mindenhol.**

---

## 3. A bizonyítások (valódi vs tautológia)

### 3.1 A szerkezet

Minden bizonyítás két mintát követ:

1. **Alias-literal minta:** `XKonst = <literál>` (264–346. sor), majd `bizX : XKonst = <ugyanaz a literál>`.
   - Pl. `E8RangKonst = 8` (269–270. sor) és `bizE8Rang : E8RangKonst = 8` (357–358. sor) → **8 = 8**.
   - Pl. `KodszoTerKonst = 128` (285–286. sor) és `bizKodszoTer : KodszoTerKonst = 128` (392–393. sor) → **128 = 128**.
2. **Csupasz literál minta:** `bizKetD : 8 = E8RangKonst` (367. sor) → **8 = 8**.

### 3.2 Értékelés: MIND a 21 bizonyítás TAUTOLÓGIA

A jobb oldal mindig ugyanaz a literál, mint amivel az alias (vagy a bal oldali literál) definiálva van. **Egyetlen bizonyításnak sincs a bal oldalán konstrukció** (függvényalkalmazás: `pow`, `-`, `+`, `*`). Konkrétan:

| # | Bizonyítás | Bal oldal (definíció szerint) | Jobb oldal | Valójában |
|---|---|---|---|---|
| 1 | `bizE8Rang` | `E8RangKonst = 8` (270. sor) | `8` | 8 = 8 |
| 2 | `bizSteaneD` | `SteaneDKonst = 3` (266. sor) | `3` | 3 = 3 |
| 3 | `bizKetD` | literál `8` | `E8RangKonst = 8` | 8 = 8 |
| 4 | `bizSteaeN` | `SteaeNKonst = 7` | `7` | 7 = 7 |
| 5 | `bizSteaeK` | `SteaeKKonst = 1` | `1` | 1 = 1 |
| 6 | `bizPerem` | `PeremKonst = 1` | `1` | 1 = 1 |
| 7 | `bizStabilizatorok` | `StabilizatorokKonst = 6` | `6` | 6 = 6 |
| 8 | `bizKodszoTer` | `KodszoTerKonst = 128` | `128` | 128 = 128 |
| 9 | `bizKiterjesztettTer` | `KiterjesztettTerKonst = 256` | `256` | 256 = 256 |
| 10 | `bizE9Clifford` | `E9CliffordKonst = 16` | `16` | 16 = 16 |
| 11 | `bizE8Gyokok` | `E8GyokokKonst = 240` | `240` | 240 = 240 |
| 12 | `bizE8LieAlgebra` | `E8LieAlgebraKonst = 248` (306. sor, literál!) | `248` | 248 = 248 |
| 13 | `bizD8Gyokok` | `D8GyokokKonst = 112` | `112` | 112 = 112 |
| 14 | `bizEgyesResz` | `EgyesReszKonst = 137` | `137` | 137 = 137 |
| 15 | `bizTortreszSzamlalo` | `TortreszSzamlaloKonst = 9` | `9` | 9 = 9 |
| 16 | `bizTortreszNevezo` | `TortreszNevezoKonst = 250` | `250` | 250 = 250 |
| 17 | `bizTisztaTer` | `TisztaTerKonst = 121` | `121` | 121 = 121 |
| 18 | `bizLobaszasExponens` | `LobaszasExponensKonst = 249` | `249` | 249 = 249 |
| 19 | `bizTukorPrim` | `TukorPrimKonst = 5` | `5` | 5 = 5 |
| 20 | `bizKapuPrim` | `KapuPrimKonst = 11` | `11` | 11 = 11 |
| 21 | `bizKetHatvanyTukor` | `KetHatvanyTukorKonst = 40` | `40` | 40 = 40 |

Ez **pontosan az a minta, amit az AGENTS §18.1 tilt**: "Tautológia = nem bizonyítás. `4 = 4` … nulla információ, tilos 'bizonyítottnak' nevezni. A bizonyítás-típus bal és jobb oldala KÜLÖNBÖZŐ konstrukció legyen (pl. `4 * 5 = 20` …)."

### 3.3 A súlyosabb pont: a bizonyítások NEM is érintik a levezetéseket

A fájlban VANNAK valódi kód-szintű konstrukciók, de azokat **semmilyen Refl nem ellenőrzi**:

- `e8LieAlgebra = e8Gyokok + e8Rang` (165. sor) — valódi összeadás, de a bizonyítás `E8LieAlgebraKonst = 248`-ra vonatkozik, ahol `E8LieAlgebraKonst` **literálként** van definiálva (306. sor), nem `= e8LieAlgebra`-ként. A bizonyítás soha nem ér a levezetett értékhez.
- `tortreszSzamlalo = stabilizatorok + steaneD` (193. sor), `kapuPrim = steaeN + steaneD + steaeK` (242. sor) — valódi összeadások, nulla bizonyítással rájuk.
- `egyesResz = kodszoTer + (8) + perem` (185. sor) — valódi konstrukció, de a `bizEgyesResz` az `EgyesReszKonst = 137` literál-aliasra vonatkozik, nem erre.

**Az elrendezés tehát fordított:** a kommentekben ott a levezetés (pl. "d = log₂(rang)", "n = rang − 1", "240 = M − E9"), de a kódban a definíciók literálok, a bizonyítások pedig literál = literál. A helyes elrendezés az lett volna: definíció = konstrukció (pl. `steaeN = e8Rang - 1`), alias = a definícióra hivatkozás (`SteaeNKonst = steaeN`), bizonyítás = `SteaeNKonst = 7`. Így a bal oldal egy redukálódó konstrukció, a jobb oldal literál — valódi bizonyítás. A jelenlegi kód ennek pont az ellenkezőjét csinálja.

### 3.4 Összevetés az elődverzióval — REGRESSZIÓ

A `Review_VegsoLevezetes.md` §6.2 az `AlphaSteaneVegso.idr` 8 bizonyítását **valódinak** találta (bal oldal: `pow 2.0 n`, `kodSzoTer - n`, stb. — függvényalkalmazások). Az `AlphaE8Szigor.idr` a "kisbetűs-név csapda" elkerülésére bevezette az alias-mintát, de az aliasokat **literállal** definiálta a levezetett érték helyett — ezzel a bizonyítások visszaminősültek tautológiává. **A "szigorú" verzió bizonyítás-állománya gyengébb, mint az elődé.**

**Ítélet: a 21 (állított 22) Refl-bizonyítás mind tautológia az AGENTS §18.1 értelmében. A "a fordító ellenőrizte" igaz, de a fordító csak annyit ellenőriz, hogy minden literál egyenlő önmagával. Nem bizonyítanak semmit, amit a definíció eleve beírt.**

---

## 4. A Double használata

### 4.1 A helyzet

A struktúra-számok `Nat`-ek, a Double csak a 9. szekcióban (`natToDouble`, 464–465. sor) és a végső számításokban (`deltaSzamitott`, `alphaDressed`, `gDressed`) + a CODATA-bemenetekben (`alphaCodata`, `sigmaAlpha`, `gCodata`, `sigmaG`). **A "Double CSAK a végső számításnál" állítás a fájlon belül igaz.**

### 4.2 Ami ettől még nem igaz

1. **A végső eredmények NINCSENEK Refl-lel bizonyítva.** `deltaSzamitott`, `alphaDressed`, `gDressed` Double-aritmetikával számolódnak, és a `main` csak Show-val írja ki őket. A fő állítások (α⁻¹ ≈ 137.035999177, G ≈ 6.6743×10⁻¹¹) futásidejű ellenőrzésen mennek át, nem kernel-ellenőrzésen. Ez a korábbi review 6.2 pontjában már rögzített hiány, változatlanul fennáll. (Mentesítő körülmény: a Double nem redukálódik literálra Refl-ben, tehát ez a határ részben technikai — de akkor ezt a korlátot ki kell mondani, nem "22 Refl-bizonyítással" takarni.)
2. **A G képletében a `10⁻¹⁰` továbbra is bemeneti literál** (506. sor), a "Planck-SI konverzió" címke ellenére. A Planck-egységekben G=1, az SI-érték az ℓ_P, m_P, t_P értékekből jön ki — a konverzió **nem egy rögzített tíz-hatvány**, és a `gDressed` csupasz `Double`-jéhez semmilyen mértékegység nem csatlakozik (l. 2. pont). A dimenzió "m³/(kg·s²)" kizárólag kommentben és stringben létezik.
3. A `natToDouble` a Nat→Double `cast`-on alapul — ez helyes és total, ezzel nincs gond.

**Ítélet: a szeparáció (Nat struktúra / Double csak a végén) a fájlban megvan — ez javulás a korábbi állapothoz képest. De a végső eredmények bizonyítatlansága és a dimenzió-nélküli csupasz Double-ök maradnak.**

---

## 5. A Fazis hipotézis

### 5.1 Ami őszinte

- A fejléc (22–28. sor) "hipotézis"-ként jelöli, és megindokolja a forrását (a G/α egybeesés és a Steane kód szerkezete alapján).
- A `Fazis` konstruktor kommentje (57. sor) és a `Show` instance (67. sor) is "(hipotézis)" jelöléssel szerepel.
- A `main` kimenete külön szekcióban, "hipotezis" felirattal közli.
- Az `Alpha_E8_Ut.md` §10 első nyitott kérdése ugyanezt rögzíti.

### 5.2 Ami mégsem rendben

1. **A hipotézis számként be van égetve a levezetésbe.** `deltaSzamitott` (476–478. sor) az `ln(9/8)`-at konkrét numerikus értékként használja: `(249 + ln(9/8))`. A "hipotézis" tehát nem paraméter, nem függvényargumentum, nem becsomagolt bizonytalanság — hanem a fő eredmény (α⁻¹) közvetlen összetevője. Az α⁻¹ ≈ 137.035999177 CSAK azért jön ki, mert az ln(9/8) konkrét értéke be van írva. A jelölés ("hipotézis") becsületes a szövegben, de a struktúra nem hipotézisként kezeli — a típusrendszer nem különbözteti meg a levezetett számokat a hipotézis-számoktól. Egy `Hipotezis` wrapper-típus (ami pl. a `biz`-pályán kívülre kerül) hiányzik.
2. **Kategóriahiba a megfogalmazásban.** A 26. sor: "A fazis dimenzioja = a ln(9/8)". Egy **dimenzió** (fizikai dimenzió, amit épp ez a fájl akar típusba emelni) nem lehet egyenlő egy **dimenzió nélküli valós számmal** (ln(9/8) ≈ 0.1178). Ha a fazis dimenzió, akkor az értéke nem lehet ln(9/8); ha ln(9/8) az értéke, akkor nem dimenzió. A `Fazis : Dimenzio` konstruktor és az ln(9/8) mint szám között a fájl nem hoz létre semmilyen típusos kapcsolatot — a kettőt csak a komment köti össze.
3. **A "dimenziója" szó tovább hígul** azzal, hogy a `Dimenzio` típus használatlan (l. 2. pont): még ha a kapcsolat típusos lenne, nem lenne hová csatlakoznia.

**Ítélet: a hipotézis szöveg-szinten őszintén jelölve van, ez dicséretes. Strukturálisan azonban a hipotézis NEM hipotézisként, hanem beégetett numerikus bemenetként él a fő képletben, és a "fazis = dimenzió" állítás kategóriahibát tartalmaz (dimenzió = szám). A "nem a légből kapott" érvelés (a CODATA-egyezés alapján) körben forgó: a hipotézist a célérték illesztése igazolja, a célértéket pedig a hipotézist tartalmazó képlet állítja elő.**

---

## 6. Hiányzó lépések — hol szakad a levezetés

### 6.1 A "Nincs magic number" állítás — NEM IGAZ (a kódban)

A feladat kérdése: "az e8Rang=8 az egyetlen bemenet, és abból d=log₂(r)=3, n=r−1=7, k=1. Ellenőrizd: ezek tényleg levezetések?" **Nem levezetések — a kódban literálok, a kommentekben levezetések.** Pontos leltár a 43–258. sorról:

| Név (sor) | A kódban | A komment állítása |
|---|---|---|
| `steaneD = 3` (88–89) | **literál** | "d = log₂(rang)" — **nincs log₂ sehol a fájlban** |
| `steaeN = 7` (96–97) | **literál** | "n = rang − 1" — nincs `e8Rang - 1` a kódban |
| `steaeK = 1` (105–106) | **literál** | "k = rang − n" |
| `stabilizatorok = 6` (115–116) | **literál** | "s = n − k" |
| `kodszoTer = 128` (123–124) | **literál** | "N = 2^n" — nincs `pow` Nat-ra a fájlban |
| `kiterjesztettTer = 256` (131–132) | **literál** | "M = 2^rang" |
| `perem = 1` (139–140) | **literál** | "p = rang − n" |
| `e9Clifford = 16` (149–150) | **literál** | "E9 = 2×rang" |
| `e8Gyokok = 240` (157–158) | **literál** | "240 = M − E9" |
| `d8Gyokok = 112` (172–173) | **literál** | "112 = 240 − N" |
| `tortreszNevezo = 250` (200–201) | **literál** | "250 = M − s" |
| `tisztaTer = 121` (210–211) | **literál** | "121 = N − n" |
| `lobaszasExponensEgesz = 249` (217–218) | **literál** | "249 = M − n" |
| `tukorPrim = 5` (250–251) | **literál** | "5 = n − 2k" |
| `pithagorasziNevezo = 8` (231–232) | **literál** | "8 = 2^d" |

Valódi kód-szintű konstrukciók: `e8LieAlgebra = e8Gyokok + e8Rang` (165), `egyesResz` (185), `tortreszSzamlalo` (193), `pithagorasziSzamlalo` (225), `kapuPrim` (242), `ketHatvanyTukor` (258). Hat darab, és közülük kettő (`egyesResz`, `ketHatvanyTukor`) **belső `(8)` literált** használ a `2^steaneD` helyett, a `gDressed`-ben pedig `natToDouble 8` (504. sor) és a `1.0e-10` (506. sor) literálok. A kommentekben lévő levezetések a kódban NINCSENEK elvégezve — a "levezetés" kizárólag komment-szöveg. Ez az AGENTS §18.2 (komment vs. típus) szisztematikus megsértése.

### 6.2 A log₂(rang) = 3 kérdése — ILLESZTÉS, NEM LEVEZETÉS

A feladat kérdésére közvetlen válasz: **a log₂(r)=3 csak azért igaz, mert r=8-at választottunk.** Részletezve:

- A Steane [[7,1,3]] kód valódi szerkezete a klasszikus [7,4,3] Hamming-kódból jön (CSS-konstrukció): n = 2^m − 1, k = n − m, d = m = 3. Ez valódi tétel — de a Hamming-kódra, NEM az E8-ra.
- Az "E8-ból": d = log₂(8) = 3, n = 8 − 1 = 7. Ez numerikusan egybeesik a Hamming-relációval, mert 2³ = 8 = n+1 = rang. Az azonosítás pusztán annyi, hogy **8 = 2³**.
- A kritikus próba: a kivételes Lie-algebrák között NEM egyedi a 2-hatvány rang. F4 rangja 4 = 2², G2 rangja 2 = 2¹. A "d = log₂(rang)" szabály F4-re d=2-t, n=3-at adna — nem a Steane-kódot. **A szabály nem függvénye a Lie-elméletnek, hanem a r=8-ra kalibrált illesztés.** Az E8-at azért választottuk bemenetnek, mert a rangja épp 2³.
- Még súlyosabb: a 240 (az E8 gyökeinek száma) **rangból NEM levezethető** — azonos rangú algebráknak különböző a gyökszáma: A8-nak 72, D8-nak 112, E8-nak 240. A 240 a Cartan-osztályozás tétele (vagy a 8 dimenziós pontossággal 8·30), nem a r=8 függvénye. A fájl "240 = M − E9 = 256 − 16" levezetése egy **utólag illesztett azonosság**: a 2^r − 2r képlet G2-re 0-t ad (12 helyett), F4-re 8-at (48 helyett), D8-ra 240-et (112 helyett). Csak r=8, E8-as értékkel egyezik — mert arra kalibrálták.
- Az "E9 = Cl(4) = 2×rang = 16" azonosítás is problematikus: E9 a standard jelölésben az E8 affin (Kac–Moody) kiterjesztése, nem a Cl(4) Clifford-algebra; a Cl(4) dimenziója 2⁴ = 16 — a "2×rang = 16" és a "2⁴ = 16" egybeesése számjáték.
- A `bizKetD : 8 = E8RangKonst` "bizonyítja" a "2^d = rang" állítást — de a típusban nincs `2^d`! Csak `8 = 8`. A 2^3 számolás sehol nincs elvégezve.

**Következmény: a "EGYETLEN bemenet: E8 rang = 8" állítás három szinten hamis:**
1. A kódban a legtöbb "levezetett" szám maga is bemenet (literál).
2. A kódban a CODATA α⁻¹, σ_α, G, σ_G is bemenet (a saját összegzés bevallja: "Egy szám, két konstans" — tehát legalább 3+ bemenet, nem egy).
3. A "levezetési" szabályok (log₂(rang), rang−1, M−E9) nem Lie-elméleti tételek, hanem a célértékekre (137.036, G) visszafelé illesztett azonosságok — a "Horgony" 137.036 felbontásai (128+8+1, 6+3, 256−6, 128−7, 256−7, 7−2, 7+3+1, 8×5) az `Alpha_E8_Ut.md` §0–4 tanúsága szerint **időrendben is előbb voltak** a Steane-kód formájában, az E8-keretezés csak utólag rakódott rájuk (Ut §4–5).

### 6.3 A korábbi review-ban jelölt problémák állapota

A `Review_VegsoLevezetes.md` kritikái közül, amik az `AlphaE8Szigor.idr`-re is átöröklődnek:

| Korábbi kritika | Állapot az AlphaE8Szigor.idr-ben |
|---|---|
| M = 2^(n+1) = 256 magic | **ÁTNEVEZVE** "2^rang"-ra — a matematika ugyanaz (2^8), az indoklás ("kiterjesztett tér") nem erősödött, csak az E8-narratívába csomagolták. |
| "Legendre perem" = 1 magic | Változatlan: `perem = 1` literál, az indoklás ("a Cartan") ugyanaz a retorika, forrás nélkül. |
| s+d = 9 és 2^d+1 = 9 egybeesés | Részben javult: a "2^d+1" azonosságot elhagyták, a 9 = s+d megmaradt, de az s+d összeadás fizikai indoka továbbra sincs. |
| ln (természetes logaritmus) választása | Változatlan: a `log` (természetes logaritmus) az illesztés része; log₂ vagy log₁₀ más δ-t adna. |
| 10⁻¹⁰ magic | **ROSSZABBODOTT:** a "Planck-SI konverzió" címke új, de téves (a Planck→SI konverzió nem tíz-hatvány), és a G dimenzióját továbbra sem hordozza típus. |
| √3 = √d ("kvint gyök") | Változatlan: `sqrt (natToDouble steaneD)` — kódban létezik, indoklása nincs. |
| 11 = n+d+k, 5 = n−2k, 40 = 8×5 | Változatlan: "kapu prím" / "tükör prím" / "oktáv³×tükör" — nincs irodalmi forrás, nincs fizikai levezetés. |
| A 9/250 kivezetése a G-ből tautológia | Ezt a lépést az új fájl NEM tartalmazza (törölték a `main`-ből) — **javulás**, de a (1+9/250)^(1/40) korrekció maga megmaradt, forrás nélkül. |
| A 8 Refl valódi volt | **REGRESSZIÓ:** a 21 Refl most már tautológia (l. 3. pont). |

### 6.4 Ahol a levezetés ténylegesen szakad (összefoglaló lista)

1. **d = log₂(rang):** nem kódolt, nem tétel, r=8-ra kalibrált (6.2).
2. **n = rang−1, k = rang−n:** literálok; az E8 ↔ Steane azonosítás forrása hiányzik (a Steane-kód nem az E8-ból jön, hanem a Hamming-kódból).
3. **240 = M − E9:** rangból nem levezethető (A8/D8/E8 ellenpéldák), utólag illesztett azonosság.
4. **137 = 128 + 8 + 1:** a felbontás a célértékből visszafelé jön; az "+1" (perem) és a 8 = 2^d fizikai jelentése forrás nélküli.
5. **δ = (121/128)^(249+ln(9/8)):** a bázis, az exponens-összeadás, és az ln választása illesztés — ezt a korábbi review már részletesen bebizonyította (2.8e), és semmi nem változott.
6. **G képlet:** √3, 10⁻¹⁰, (1+9/250)^(1/40) — mindhárom forrás nélküli; a 10⁻¹⁰ "konverzió"-címkéje téves.
7. **A hipotézis-lánc:** fazis = ln(9/8) = püthagoraszi hang → beégetve a δ-ba (5. pont).
8. **`steaneK` lyuk** és a 21≠22 Refl-szám (1.3).

---

## 7. Összegzés

### 7.1 Mi szilárd

- **A program szintje:** fordul, fut, total; a Δ/σ számítás helyes és az AGENTS §17 formátumot betartja; a σ-értékek a CODATA-nak megfelelnek.
- **A Nat/Double szeparáció:** a strukturális értékek Nat-ek, a Double a fájlban valóban a végső számításra korlátozódik.
- **Az őszinteség a hipotézis-jelölésben:** a Fazis szöveg-szinten hipotézisként van jelölve, nem bizonyításként.
- **A cél-értékek numerikája:** α⁻¹ Δ/σ = 1.7×10⁻⁴, G Δ/σ = 0.038 — konzisztens a korábbi verziókkal.

### 7.2 Mi hibás vagy nem áll meg

1. **"Nincs magic number. Minden az E8 rangjából." (616. sor) — HAMIS.** A strukturális állandók túlnyomó többsége a kódban literál (l. 6.1 táblázat). A levezetések kizárólag a kommentekben élnek.
2. **A 21 (állított 22) Refl-bizonyítás MIND tautológia** (X = X, literál = literál) — az AGENTS §18.1 közvetlen megsértése, és a korábbi valódi (konstrukciós) 8 bizonyításhoz képest regresszió. Az a levezetés, amit bizonyítani kellene (`2^d`, `rang−1`, `M−E9`, `s+d`…), nincs is elvégezve a kódban.
3. **A `Dimenzio` típus használatlan holt kód** — a "minden mennyiségnek van dimenziója" ígéret típus-szinten nulla. A G "m³/(kg·s²)" dimenziója csak kommentben létezik; a 10⁻¹⁰ "Planck-SI konverzió" címke téves (a konverzió nem tíz-hatvány).
4. **A Fazis hipotézis beégetett számként működik** a fő képletben (nem paraméter), és a "fazis dimenziója = ln(9/8)" állítás kategóriahiba (dimenzió = szám).
5. **Az E8-keretezés az illesztést átcímkézi, nem oldja fel.** A korábbi review három magic number-jéből a 256-at "2^rang"-ra, az 1-et "Cartan-peremre", a 10⁻¹⁰-et "Planck-konverzióra" nevezték át — a matematika és az illesztettség azonos. A d = log₂(rang) szabály nem Lie-elméleti tétel: F4/G2 ellenpéldák, a 240 pedig rangból nem levezethető (A8: 72, D8: 112, E8: 240).
6. **Két konkrét kódhiba:** a `steaneK` deklarálatlan-definiálatlan lyuk (104. sor), és a "22 Refl" ≠ 21 tény (580., 613. sor).

### 7.3 Végső ítélet

Az `AlphaE8Szigor.idr` **programként korrekt, levezetésként nem az.** A "szigor" a szövegben és a nevekben van; a típusrendszer nem csinál többet, mint az elődverziók — sőt, a bizonyítások minőségében kevesebbet. A fő eredmények (α⁻¹, G) továbbra is utólagos illesztés eredményei, amelyeket az E8-réteg egy narratívával vesz körül; a narratíva szép, de a kód szintjén nem levezetés.

**Javaslatok (rangsorolva):**
1. A definíciókat tényleges konstrukciókra cserélni (pl. `steaeN = e8Rang - 1`, `kodszoTer = pow 2 steaeN`, `stabilizatorok = steaeN - steaeK`, `tortreszNevezo = kiterjesztettTer - stabilizatorok`…), és a bizonyításokat ezekre írni (`bizSteaeN : SteaeNKonst = 7` ahol `SteaeNKonst = steaeN`). Ez önmagában a 21 tautológiát valódi bizonyítássá alakítja.
2. A `steaneK` lyukat definiálni vagy törölni a deklarációból; a 22→21 számot javítani.
3. A `Dimenzio` típust ténylegesen használni (pl. `Mennyiseg : Dimenzio -> Type -> Type` wrapper), vagy a fejléc ígéretét visszavonni.
4. A Fazis hipotézist paraméterként kezelni (függvény-argumentum vagy wrapper-típus), és a "dimenzió = ln(9/8)" megfogalmazást kijavítani.
5. A nyitott illesztéseket (ln-választás, √3, 10⁻¹⁰, (1+9/250)^(1/40), 240 = M−E9) a `docs/`-ban **illesztésként** listázni — ahogy az `Alpha_E8_Ut.md` §10 már részben teszi — és a "Nincs magic number" kimeneti sort törölni vagy "illesztett azonosságok" feliratra cserélni.

---

*Review verzió: 1.0. Létrehozva: 2026-08-20, független kritikai alügynök. Csak olvasott és új fájlt írt — semmilyen más fájlt nem módosított. A review célja az AGENTS §18.3 szerinti független ellenőrzés: valódi vs. tautológia besorolás, ellentmondás-keresés, hiányzó-törvény-lista.*

---

## KIEGÉSZÍTÉS (a felhasználó válasza a review-ra, 2026-08-19)

**A review 4. pontja ("Nincs magic number HAMIS") kritikájára:**

A `1 = a perem` nem elszigetelt literál, hanem:

```
perem = rang(E8) − n = 8 − 7 = 1
```

Két független indoklás:

1. **Strukturális:** a Cartan-algebra dimenziója = rang(E8) = 8. A kód
   hossza n = 7. A kettő különbsége = 1. A perem az a dimenzió, amit
   a kód a teljes Cartan-térből a peremre hagy. Nem választott — számított.

2. **MDL-elv** (a projekt saját alapelve, hypothesis_mdl_cpt.txt):
   a `+1` a legrövidebb program a tér kiterjesztésére. A `+2`, `+3`
   hosszabb programok lennének. Az Occam-borotva a `+1`-et választja:
   a minimális leosztás = a kód 7 bitet használ a 8-ból.

**A "240 gyök nem levezethető a rangból" kritikára:**

A review példái (A8: 72 gyök, D8: 112) helyesek ÁLTALÁBAN — de az E8
különleges: az egyetlen kivételes algebra, ahol a gyökök száma (240)
a rang (8) hatványából és az E9 Clifford-struktúrából jön:

```
240 = M − E9 = 2^rang − 2·rang = 256 − 16
```

Ez az E8 SPECIFIKUS azonossága (nem igaz A8-ra vagy D8-ra). Az E8
kivételessége = pontosan ez az egybeesés.

**Ami MARAD nyitott (őszintén):**
1. `10⁻¹⁰` — a SI skála = a hierarchia-probléma (miért gyenge a G?)
   Ez a GUT nyitott kérdése, nem oldottuk meg.
2. A Fazis dimenzió — hipotézis, nem bizonyítás (ezt a review is
   elismeri, hogy szöveg-szinten jelölve van).

**Összesítés: 2 nyitott kérdés, nem 3 magic number.**
