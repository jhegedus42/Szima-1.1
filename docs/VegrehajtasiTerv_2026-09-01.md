# VEGREHAJTÁSI TERV — az episodic memory 65 pontja lépésről lépésre
## Konkrét feladatok, miértek, függőségek, megvalósítási tervek

**Dátum:** 2026-09-01
**A felhasználó kérése (szó szerint):** „ezt a tervet most ultessuk at lepesrol lepesra vegrahajtando konkret feladatokra es hozzajuk tartozo miertekre... kapcsolatokra, osszefuggesekre, fuggesekre, megvalositasi tervekre, mielott konkretan hozzalatunk es azt irjuk be a TODO-ba"

**A forrás:** `docs/EpisodicMemoryTerv_50pont_2026-09-01.md` (65 pont, 296 sor) — a GAN-korrekció szerinti sorrend.

---

## A FÁZISOK (a GAN-korrigált függőségi gráf szerint)

### 0. FÁZIS — A SZÓTÁR ALAPOZÁSA (eredeti pontok: 1, 2, 3, 4, 5, 7)

**0.1. A HungarianLexicon publikus-v2.**
- **Feladat:** a `szima_ter/modul/HungarianLexicon_v1_Szima.idr` (3460 szó, privát) adatainak másolása egy új `HungarianLexicon_v2_Szima.idr` fájlba, `public export`-tal minden szóra.
- **Miért:** a jelenlegi lexikon szavai privátok — a SzotarHid és a LumoKereso nem tudja közvetlenül importálni őket, ezért a híd saját minta-szavakat definiál (csak 4!). A v2 publikussá tételével a teljes 3460 szó elérhető.
- **Függőség:** nincs — ez az alap.
- **Kapcsolat:** a 0.2 (a generátor), a 0.3 (a Lumo-szókincs) és a 0.4 (a tő-keresés) mind a v2-t használják.
- **Megvalósítás:** `cp HungarianLexicon_v1_Szima.idr HungarianLexicon_v2_Szima.idr` + `sed` a `public export` beszúrására minden szó-definíció elé. A modulnév módosítása `_v2`-re. A `§13` szerint a v1 érintetlen marad.
- **Siker:** `idris2 HungarianLexicon_v2_Szima.idr` lefordul; a SzotarHid tudja importálni (pl. `n_ember`).

**0.2. A szótár-generátor.**
- **Feladat:** a `SzotarHid_v1.huWordToJelentes` futtatása a v2 lexikon összes szaván → `teljesSzótár : Szotar` (3460 + 15 bejegyzés). Ehhez egy lista kell a 3460 szóból (a v2-ben a szavak egyedi definíciók, nem lista — vagy generálunk egy listát, vagy a v2-ben hozzáadunk egy `összesSzó : List HuWord` listát).
- **Miért:** a kereső jelenleg csak 15 szót ért (a minta-szótár). A teljes szótárral a könyvek mondatainak jelentős része ismert szavakból áll.
- **Függőség:** 0.1 (a v2 lexikon publikus).
- **Kapcsolat:** a 0.3 (a Lumo-szókincs bővíti), a 1.1 (a tokenizáló használja), a 3.1 (a normalizált távolság igényli).
- **Megvalósítás:** a v2-hez hozzáadni egy `összesSzó : List HuWord` listát (a 3460 szó felsorolása). A SzotarHid_v2: `teljesSzótár = (map huWordToJelentes összesSzó) ++ lumoSzavakGenerálva`.
- **Siker:** a `teljesSzótár` hossza futásidejű Show-ellenőrzéssel > 3460.

**0.3. A Lumo-szókincs bővítése.**
- **Feladat:** a 6 parszolt Lumo-fájl (~650 KB) leggyakoribb szavainak kinyerése (a `words` + `nub` + gyakoriság-számlálás — Idrisben, nem Python!) és hozzáadása a szótárhoz mint HuWord (a szófaj becslése a szó végződése alapján: -ás/-és → főnév, -ul/-en → módosító, stb.).
- **Miért:** a Lumo-szövegek szókincse (E8, reprezentáció, algebra) nincs a tudományos HungarianLexiconban — a kereső az E8-szakzsargont nem érti nélkülük.
- **Függőség:** 0.1 (a v2 lexikon), a Lumo-szövegek (már parszolva: `trail_index/books/lumo_*.txt`).
- **Kapcsolat:** a 2.4 (a könyv-index a teljes szótárat használja), a 5.2 (a ground-truth teszteli).
- **Megvalósítás:** `LumoSzokincs_v1.idr`: `gyakoriságSzámolás : String → List (String, Nat)` (a `words` + `nub` + `count` Prelude-ből); `szófajBecslés : String → MathRole` (a végződés alapján); `lumoSzókincs : List HuWord`.
- **Siker:** a Lumo-mondatok > 50%-a ismert szavakból áll (futásidejű mérés).

**0.4. A tő-keresés teljes 22 esetragra + rekurzív levágás.**
- **Feladat:** a `SzotarHid_v1.gyakoriToldalékok` (14 toldalék) bővítése a 22 esetragra + a gyakori képzőkre (-ság, -ség, -ás, -és, -atlan, -talan, -ó, -ő) + a rekurzív levágás (a „farkasokat" → -at → „farkasok" → -ok → „farkas").
- **Miért:** a jelenlegi tő-keresés csak egy toldalékot vág le — a „farkasokat" (többes+ tárgy) nem találja a „farkas" tövet. A rekurzió (többszörös levágás) megoldja.
- **Függőség:** a `SzotarHid_v1` (a meglévő tő-keresés).
- **Kapcsolat:** az 1.1 (a tokenizáló a tő-keresést használja), a 2.2 (a könyv-index az ismert szavakat találja).
- **Megvalósítás:** a `szótárKeresésTömesterrel` rekurzív változata: ha az első levágás nem talál, a levágott szón újra lefut a toldaléklista. A 22 esetrag: a `MagyarNyelvtan.idr`-ből vagy a `KantNyelvtan.idr`-ből importálva (§24).
- **Siker:** „farkasokat" → „farkas" (kétszeres levágás) működik (futásidejű teszt).

**0.5. Az ékezet-normalizáció vizsgálata.**
- **Feladat:** egy `ékezetNormalizáló : String → String` függvény (á→a, é→e, í→i, ó→o, ö→o, ő→o, ú→u, ü→u, ű→u), de CSAK a hibatűréshez (a fő út az ékezetes bemenet). A függvény jelzi, hogy normalizált (a visszatérési érték tartalmaz egy `normalizálva : Bool` mezőt).
- **Miért:** a §25 tanulsága szerint az ékezet INFORMÁCIÓ — a „hazugsag" ≠ „hazugság". A szótár ékezetes; a bemenet is legyen az. DE: a hibatűréshez (a felhasználó tévesztése, a HTML-ből jövő ékezet-nélküli szöveg) egy külön normalizáló kell.
- **Függőség:** nincs (önálló).
- **Kapcsolat:** az 1.1 (a tokenizáló dönti el, használja-e a normalizálót), a 4.2 (a ground-truth teszti).
- **Megvalósítás:** `ékezetNormalizáló : String → String` — a karaktertípus (Char) ASCII + ékezet-táblázata. A `unpack/map/pack` (a Paragrafus `kisbetus`-ának mintájára).
- **Siker:** „hazugsagot" normalizálva → „hazugsag" → (tő-keresés) → „hazugsag" ≠ „hazugság" — az ékezetvesztés jelzése (a normalizált találat GYENGEBB, mint az ékezetes).

**0.6. A komplex-bájt egységesség.**
- **Feladat:** a `Paragrafus.Peldaszotar` kézzel írt vektorai (4 szó: farkas, piroska, hazugsag, vadasz) és a `SzotarHid.lexikonMintaSzótár` generált vektorai összevetése. A „farkas" mindkettőben van — más értékkel! A konfliktus feloldása: a generált érvényes (a szófaj + hangrend alapján), a kézzel írott dokumentálva marad (a Peldaszotar nem módosul, §13).
- **Miért:** ha két szótár eltérő vektort ad ugyanarra a szóra, a keresés következetlen — egy szó = egy vektor a teljes rendszerben.
- **Függőség:** a `Paragrafus.Peldaszotar` + a `SzotarHid.lexikonMintaSzótár`.
- **Kapcsolat:** a 2.1 (a könyv-index a teljes szótárat használja — következetesnek kell lennie).
- **Megvalósítás:** a kereső a `teljesSzótár`-t használja (a generáltat); a `Peldaszotar` a teszt-marad (a Main.idr a Peldaszotar-ral mutatja a kézzel írt példát). A dokumentum rögzíti a konfliktust.
- **Siker:** a kereső a „farkas"-ra egyetlen vektort ad (a generáltat), nem kettőt.

---

### 1. FÁZIS — TOKENIZÁLÁS ÉS KÓDOLÁS (eredeti pontok: 8, 9, 10, 51, 52)

**1.1. A mondat-tokenizáló javítása.**
- **Feladat:** az írásjelek levágása („mondott." → „mondott"), a nagybetűs kezdés kisbetűsítése (a `kisbetus` már van a Paragrafusban), a szavakra bontás (`words` — Prelude). Kimenet: `szavakTisztítva : String → List String`.
- **Miért:** a jelenlegi `paragrafusKodol` a `words`-t használja, de az írásjelek nem vannak levágva — a „mondott." szóként a „mondott." (ponttal) nem található a szótárban.
- **Függőség:** a `Paragrafus.kisbetus` + a `Kodol.irasjelLevagas` (meglévő, §24: import).
- **Kapcsolat:** a 1.2 (a CPT-kinyerés a tisztított szavakat használja), a 2.1 (a tórusz-pont a mondatból jön).
- **Megvalósítás:** a `Kodol.irasjelLevagas` (már létezik!) importálása + a `kisbetus` (már van) + a `words` (Prelude) kombinációja: `szavakTisztítva s = map (kisbetus . irasjelLevagas) (words s)`.
- **Siker:** „Mit mondott a farkas?" → [„mit", „mondott", „a", „farkas"] (futásidejű teszt).

**1.2. A CPT-fázis kinyerése a mondatból.**
- **Feladat:** a jelenleg fix (jelen, folyamatos, közvetlen) CPT helyett a mondatból való kinyerés: kérdőszó („mit?", „ki?", „hol?") → Kérdő; „volt"/„lette" → Múlt; „fog" → Jövő; „hátha"/„talán" → Feltételező; egyébként → kijelentő (jelen). A szemlélet (folyamatos/befejezett): a „-t" végződés → befejezett; egyébként folyamatos.
- **Miért:** a tórusz-pont (a 2.1-ben) a CPT-től függ — ha minden mondat ugyanoda kerül (a fix CPT miatt), a klaszterezés nem működik. A CPT-kinyerés adja a mondattípus szerinti szétválasztást.
- **Függőség:** a `Torusz.mondatFázis` (a MondatTípus → fázis), a `MagyarNyelvtan` / `KantNyelvtan` (a ragozás).
- **Kapcsolat:** a 2.1 (a tórusz-pont), a 2.2 (a mondat → tórusz-pont teljes leképezés).
- **Megvalósítás:** `mondatCPT : String → CptFazis` — a kérdőszó-lista („mit", „ki", „hol", „mikor", „miért", „hogyan"), az igeidő-kulcsszavak („volt", „lesz", „fog"), a feltételező-kulcsszavak („hátha", „talán", „esetleg"). A `MagyarNyelvtan` importált (§24).
- **Siker:** „ég a ház?" → Kérdő (F2); „a ház égett" → Múlt (befejezett); „a ház ég" → kijelentő (jelen, folyamatos).

**1.3. A Steane-kód generálás ellenőrzése.**
- **Feladat:** a `jelentesKomplexBajtra` erős kubiti (re > 0.5 küszöb) eloszlásának futásidejű tesztje: a teljes szótáron + a teszt-mondatokon a 7-bit kódok eloszlása (nem minden 0 vagy minden 1).
- **Miért:** ha az eloszlás degenerált (minden kód 0000000 vagy 1111111), a Steane-Hadamard előszűrő (a 3.2-ben) nem működik — nincs differenciálás.
- **Függőség:** a 0.2 (a teljes szótár), a `KomplexByte.erossKubit`.
- **Kapcsolat:** a 3.2 (a Hadamard-szűrő ez alapján működik).
- **Megvalósítás:** a `jelentesKomplexBajtra` lefuttatása a teszt-mondatokon + a 7 bit eloszlásának `show`-val való kiírása.
- **Siker:** a 7 bit közül legalább 3 különbözik a teszt-mondatok között (nem degenerált).

**1.4. Az Idris IO-réteg — a fájlolvasás.** (eredeti pont 51)
- **Feladat:** a `trail_index/books/*.txt` fájlok Idris-ből való beolvasása (`readFile : String → IO String` + a sorokra bontás) és mondatonkénti indexelése. A `KonyvAdat_E8Gyokrendszer_v1.idr:2067` már használja a `readFile`-t — ez a minta (§24).
- **Miért:** a kereső jelenleg a beágyazott minta-mondatokat keresi (a LumoKereso 8 mondat). A könyvek (Awodey 364 KB, Lumo 650 KB) mondatainak beolvasása és indexelése az alapja a valódi keresésnek.
- **Függőség:** a 0.2 (a teljes szótár), az 1.1 (a tokenizáló).
- **Kapcsolat:** a 1.5 (a streamelés ezen alapul), a 2.1 (a könyv-index).
- **Megvalósítás:** `IndexeloIO_v1.idr`: `könyvBeolvasás : String → IO (List String)` (a `readFile` + `lines`); `indexelésFolyamata : String → Szotar → IO (List IndexBejegyzés)` (a mondatok kódolása); `main : IO ()` (egy Lumo-fájl beolvasása + indexelése + az eredmény hossza).
- **Siker:** egy Lumo-fájl (pl. lumo_Magyar.txt, 31 KB) beolvasása + indexelése hiba nélkül, az eredmény > 50 mondat.

**1.5. A streamelt indexelés.** (eredeti pont 52)
- **Feladat:** a nagy fájlok (>100 KB) batch-ekben való feldolgozása: 100 mondat / batch, minden batch után a memória felszabadul. A batch-ek mondat-indexei összegyűjtve vagy lemezre írva.
- **Miért:** az Awodey (364 KB, ~14 443 sor) nem fér egyszerre a memóriába (~10 MB String-lista). A batch-elés (100 mondat → indexelés → memória felszabadul → következő 100) megoldja.
- **Függőség:** az 1.4 (az IO-réteg).
- **Kapcsolat:** a 2.3 (a lemez-alapú index a batch-eket fogadja).
- **Megvalósítás:** `StreamIndexelo_v1.idr`: `batchMéret = 100`; `batchIndexelés : List String → Szotar → List IndexBejegyzés`; `batchCiklus : List String → Szotar → IO (List IndexBejegyzés)` (a `take 100` + indexelés + rekurzió a `drop 100`-mal).
- **Siker:** az Awodey batch-indexelése hiba nélkül, az eredmény > 1000 mondat.

---

### 2. FÁZIS — A TÓRUSZ ÉS A KLASZTEREZÉS (eredeti pontok: 11, 12, 13, 53)

**2.1. A tórusz-pont mint az index nulladik szintje.**
- **Feladat:** a `record IndexBejegyzés` definiálása: `mondat : String`, `komplexBájt : KomplexBajt`, `tóruszPont : ToruszPont`, `forrás : String`. A tórusz-pontot a mondat CPT-je határozza meg (az 1.2-ből).
- **Miért:** a hierarchikus keresés első szintje a tórusz-pont (16 lehetőség) — a mondat CPT-je és a pozíció határozza meg, melyik klaszterbe kerül.
- **Függőség:** a `Torusz.idr` (ToruszPont), a 1.2 (a CPT-kinyerés).
- **Kapcsolat:** a 2.2 (a klaszterezés ezen alapul), a 3.1 (a hierarchikus keresés).
- **Megvalósítás:** `IndexBejegyzés.idr`: a record + a `mondatTóruszPontTeljes : String → ToruszPont` (a CPT + a mondattípus → a tórusz-pont; a `Torusz.mondatFázis` + a `mondatCPT` kombinációja).
- **Siker:** a négy mondattípus a négy sarokpontba kerül (F0, F2, F4, F6).

**2.2. A 16 klaszter (a tórusz-pontok szerinti csoportosítás).**
- **Feladat:** az index 16 listára bontása (minden tórusz-pont egy lista): `tóruszKlaszterek : Vect 16 (List IndexBejegyzés)` vagy `List (ToruszPont, List IndexBejegyzés)`. A mondatok a tórusz-pontjuk szerinti klaszterbe kerülnek.
- **Miért:** a keresés először a lekérdezés tórusz-pontja szerinti klasztert választja (O(1) szűrés a 16-ból), majd a klaszteren belül keres.
- **Függőség:** a 2.1 (az IndexBejegyzés + a tórusz-pont).
- **Kapcsolat:** a 3.1 (a hierarchikus keresés a klasztereket használja), a 5.3 (a klaszter-egyensúly).
- **Megvalósítás:** `Klaszterezes_v1.idr`: `klaszterBesorolás : List IndexBejegyzés → Vect 16 (List IndexBejegyzés)` (a `filter` Prelude-ből — a 16 tórusz-pontra).
- **Siker:** a 16 klaszter mindegyikében van legalább 1 mondat (nem üres).

**2.3. A lemez-alapú index.** (eredeti pont 53)
- **Feladat:** a 16 klaszter mindegyike EGY fájl a lemezen (`index/klaszter_0.idx` … `klaszter_15.idx`), a keresés csak a releváns klaszter-fájlt olvassa be. A `writeFile` + `readFile` Idris IO-val.
- **Miért:** a 16 klaszter `Vect 16 (List IndexBejegyzés)` memóriában 20 000 mondatnál ~2.5 MB (OK), de 1 milliónál ~125 GB (NEM OK). A lemez-alapú index (a keresés csak 1 fájlt olvas) a skálázhatóság alapja.
- **Függőség:** az 1.4 (az IO-réteg), a 2.2 (a klaszterek).
- **Kapcsolat:** a 3.1 (a hierarchikus keresés a lemezről olvas), a 7.2 (a verziókezelés).
- **Megvalósítás:** `LemezIndex_v1.idr`: `klaszterFájlNév : ToruszPont → String` („index/klaszter_N.idx"); `klaszterÍrás : ToruszPont → List IndexBejegyzés → IO ()` (`writeFile`); `klaszterBeolvasás : ToruszPont → IO (List IndexBejegyzés)` (`readFile` + a `show` alapú deszerializálás).
- **Siker:** a keresés csak 1 klaszter-fájlt olvas (nem mind a 16-ot); a lemezolvasás működik.

---

### 3. FÁZIS — A TÁVOLSÁG ÉS A FINOMÍTÁS (eredeti pontok: 14, 15, 16, 17, 18, 61)

**3.1. A Steane-Hadamard előszűrő.**
- **Feladat:** a klaszteren belüli bit-szintű szűrés: a lekérdezés 7-bit Steane-kódja és a bejegyzés kódja közti Hadamard-távolság (Nat — gyors, nem Double). Csak a kis Hadamard-távolságú (~<4) jelöltek mennek a drága Manhattanra.
- **Miért:** a Hadamard-távolság Nat-összehasonlítás (gyors), a Manhattan Double-aritmetika (lassú). A bit-szűrés a klaszter 1/8-át hagyja meg a Manhattanra — exponenciális szűkítés.
- **Függőség:** a `HadamardTavolsag.idr` (hadamardTavolsagE8Negy), a `KomplexByte.HetesKod`, a 2.2 (a klaszterek).
- **Kapcsolat:** a 3.2 (a Manhattan finomítás az előszűrt jelölteken), a 4.1 (a hierarchikus keresés).
- **Megvalósítás:** `SteaneSzuro_v1.idr`: `hadamardKétKódKözt : HetesKod → HetesKod → Nat` (a 7 bit különbsége); `steaneSzűrő : Nat → List IndexBejegyzés → HetesKod → List IndexBejegyzés` (a `filter` — csak a kis távolságúak).
- **Siker:** a jelöltek száma ~1/8-ra csökken (futásidejű mérés).

**3.2. A normalizált Manhattan-távolság.**
- **Feladat:** a LumoKereso 4. keresésének korlátja (a rövid mondatok előnye) javítása: a távolság osztva a mondat ismert-szó-számával.
- **Miért:** a jelenlegi Manhattan-távolság nem normalizált — a rövid mondatok (kevesebb szó = kisebb vektor = kisebb távolság) hamisan nyernek. A normalizálás (távolság / szószám) eltünteti ezt a torzítást.
- **Függőség:** a `LumoKereso_v1.bájtTávolság` (a meglévő Manhattan).
- **Kapcsolat:** a 4.1 (a hierarchikus keresés a normalizáltat használja), a 5.2 (a ground-truth teszteli).
- **Megvalósítás:** `normalizáltTávolság : KomplexBajt → KomplexBajt → Nat → Double` (a harmadik = a szószám); a `bájtTávolság / fromInteger (cast szószám)`.
- **Siker:** a „kozmológiai szupergravitáció" lekérdezés az E10-mondatot találja, nem a rövid „Az ember magyarul beszél"-t (futásidejű teszt).

**3.3. A komplex belső szorzat.**
- **Feladat:** a Manhattan helyett (vagy mellett) a komplex belső szorzat: ⟨a, b⟩ = Σ aᵢ·conj(bᵢ) — a 8 komponensen. A modulusza = a hasonlóság, a fázisa = a fázis-egyezés (hangrend).
- **Miért:** a Manhattan csak a távolságot méri (abszolút érték), a belső szorzat a FÁZIST is — a hangrend-egyezés (mély vs. magas) a fázisban jelenik meg. Ez a Bergman-kernel (a 6.1) alapja.
- **Függőség:** a `Komplex` (a `kSzoroz` a Komplex.idr-ből), a `KomplexByte` (a 8 komponens).
- **Kapcsolat:** a 6.1 (a Bergman-kernel a belső szorzattal), a 6.3 (a tétel: Bergman ≈ Manhattan).
- **Megvalósítás:** `belsőSzorzat : KomplexBajt → KomplexBajt → Komplex` — a 8 komponensen `kSzoroz aᵢ (conj bᵢ)` összege (a `kSzoroz` a Komplex.idr-ből, a `conj` = a konjugált).
- **Siker:** a re(|⟨q, d⟩|) nagy = hasonló; a fázis = a hangrend-egyezés (futásidejű teszt).

**3.4. A súlyozott mondatvektor (IDF).**
- **Feladat:** a szófajok súlyozása: a főnév és az ige többet számít, mint a névelő/kötőszó (IDF: a ritka szó többet ér — az „a", „és", „hogy" gyakori de információszegény).
- **Miért:** a jelenlegi `mondatJelentese` egyenlő súllyal összeadja az összes szóvektort — az „a" (névelő) ugyanannyit számít, mint a „farkas" (főnév). Az IDF-súlyozás a ritka, tartalmi szavakat emeli ki.
- **Függőség:** a 0.2 (a teljes szótár — a gyakoriság számítása a szótár alapján).
- **Kapcsolat:** a 3.2 (a normalizált távolság a súlyozottat használja), a 5.5 (a visszacsatolás adaptív IDF).
- **Megvalósítás:** `súlyozottMondatJelentese : String → Szotar → SzoJelentes` — a szó gyakorisága a szótárban alapján fordított súly (IDF = log(N/df)).
- **Siker:** a ritka, tartalmi szavak dominálnak a gyakori funkciószavakkal szemben (futásidejű teszt).

**3.5. A mondat-hossz normalizálás (|v| = 1).**
- **Feladat:** a vektor hossz-egységessé tétele (a 8 komponens gyökös összege = 1) — a koszinusz-hasonlóság alapja.
- **Miért:** a hossz szerinti torzítás megszűnik — a hosszú mondat (sok szó = nagy vektor) nem nyer a röviddel szemben.
- **Függőség:** a 3.3 (a belső szorzat a normalizált vektorokkal = a koszinusz-hasonlóság).
- **Kapcsolat:** a 6.1 (a Bergman-mag normalizált), a 6.3 (a tétel).
- **Megvalósítás:** `normalizáltBájt : KomplexBajt → KomplexBajt` — a 8 komponens osztva a gyökös összegével (a `sqrt` + a `kAbs` a Komplex.idr-ből).
- **Siker:** a hossz szerinti torzítás megszűnik (futásidejű teszt).

**3.6. A klaszter-egyensúly mérése és javítása.** (eredeti pont 61)
- **Feladat:** a 16 klaszter méretének varianciája — ha nagy (az egyik klaszter 90%), a hierarchia degenerálódik. A finom-felosztás: a túl nagy klaszter 4 al-klaszterre.
- **Miért:** ha a mondatok 90%-a kijelentő, a 0°-os klaszter 90%-ot tartalmaz — a keresés ott LASSÚ (nem exponenciális).
- **Függőség:** a 2.2 (a klaszterek).
- **Kapcsolat:** a 4.1 (a hierarchikus keresés az egyensúlyt igényli).
- **Megvalósítás:** `klaszterMéretek : Vect 16 (List IndexBejegyzés) → Vect 16 Nat`; `klaszterVariancia : Vect 16 Nat → Double`; `finomFelosztás : ToruszPont → List IndexBejegyzés → Vect 4 (List IndexBejegyzés)`.
- **Siker:** a variancia < 2× az átlagtól (futáidejű mérés).

---

### 4. FÁZIS — A HIERARCHIKUS KERESÉS ÉS A KÖNYV-INDEX (eredeti pontok: 21, 45)

**4.1. A hierarchikus index felépítése.**
- **Feladat:** a 3-szintű keresés: 0. a tórusz-pont (16) → 1. a Steane-Hadamard (bit-szűrés) → 2. a normalizált Manhattan/belsőszorzat (finomítás). A `hierarchikusKeresés : String → List (Double, String)`.
- **Miért:** a hierarchikus keresés a „brutál gyors" (a 3 szint exponenciálisan szűkít: 1/16 × 1/8 × finomítás), a lineáris O(n) helyett O(log n).
- **Függőség:** a 2.2 (a klaszterek), a 3.1 (a Hadamard), a 3.2 (a normalizált Manhattan).
- **Kapcsolat:** a 4.2 (a könyv-index a hierarchiát teszteli), a 5.1 (a metrikák ezen mérnek).
- **Megvalósítás:** `HierarchikusKereses_v1.idr`: `hierarchikusKeresés : String → Szotar → List IndexBejegyzés → List (Double, String)` — a lekérdezés → tórusz-pont → klaszter kiválasztás → Steane-szűrés → Manhattan-rangsor.
- **Siker:** a keresési költség ~O(log n) a lineáris O(n) helyett (futásidejű mérés).

**4.2. A könyvek indexelése.** (eredeti pont 45, előbbre hozva)
- **Feladat:** az összes indexelt könyv mondatainak indexelése: az Awodey (364 KB), a Mac Lane (18642 sor), a Kandel-index, a 6 Lumo (~650 KB), az Idris Tutorial. A batch-indexelés (az 1.5) használatával.
- **Miért:** a kereső a Lumo-mintán működik (8 mondat), de a KÖNYVEKEN kell tesztelni — nem csak a mintán. A könyv-index a hierarchia TESZTJE (a GAN javaslata szerint).
- **Függőség:** az 1.4-1.5 (az IO + a streamelés), a 4.1 (a hierarchikus keresés).
- **Kapcsolat:** a 5.1 (a metrikák a könyv-indexen mérnek), a 5.2 (a ground-truth a könyvekből jön).
- **Megvalósítás:** a `batchCiklus` lefuttatása minden `trail_index/books/*.txt` fájlon → a `LemezIndex` írása.
- **Siker:** a keresés a könyvekben is működik (nem csak a Lumo-mintán); a „Mi a Yoneda-lemma?" kérdés az Awodey vonatkozó mondatait találja.

---

### 5. FÁZIS — A METRIKÁK ÉS A TESZTELÉS (eredeti pontok: 54, 55, 46, 47)

**5.1. A keresési metrikák.** (eredeti pont 54)
- **Feladat:** a keresés minőségének OBJEKTÍV mérése: `precisionAtK`, `recallAtK`, `MRR`, `NDCG` — a standard információ-visszakeresési metrikák.
- **Miért:** a 46. pont „>80%"-a szubjektív (kézi). A metrikák objektívek és reprodukálhatók — a szótár-változás után automatikusan újra lefutnak.
- **Függőség:** a 4.2 (a könyv-index), a 5.2 (a ground-truth).
- **Kapcsolat:** a 5.3 (a sebességmérés), a 8.1 (a GAN-ellenőrzés).
- **Megvalósítás:** `KeresesiMetrikak_v1.idr`: `record TesztLekérdezés` (kérdés, relevánsMondatok); `precisionAtK : List String → List String → Nat → Double`; `MRR : List String → List String → Double`; `NDCG : List String → List String → Double`.
- **Siker:** a tesztek automatizálhatók; a metrikák reprodukálhatók.

**5.2. A ground-truth építése.** (eredeti pont 55)
- **Feladat:** egy DOKUMENTÁLT, REPRODUKÁLHATÓ teszt-halmaz: 50 kérdés + a várt találatok (relevanciaszintekkel: 0 = irreleváns, 1 = részben, 2 = releváns). A fájl: `tesztek/GroundTruth_v1.txt` (a formátum: `kérdés | releváns_mondat_1 | releváns_mondat_2 | …`).
- **Miért:** a 46. pont „ismert kérdések"-e kézi — a ground-truth fájl automatikus regressziós tesztelést tesz lehetővé. Minden szótár-változás után a teszt újra lefut.
- **Függőség:** a 4.2 (a könyv-index — a várt találatok a könyvekből jönnek).
- **Kapcsolat:** a 5.1 (a metrikák a ground-trouth-t használják).
- **Megvalósítás:** a `tesztek/GroundTruth_v1.txt` + a `GroundTruth_v1.idr` (`groundTruthBeolvasás`, `regresszióJelentés`).
- **Siker:** minden szótár-változás után a teszt újrafut és a metrikák jelentést adnak.

**5.3. A könyvtalálatok tesztje.** (eredeti pont 46)
- **Feladat:** a 5.2 ground-truth-jával való tesztelés: „Mi a Yoneda-lemma?" → az Awodey; „Mi a Kostant-felbontás?" → a saját kutatás; „magyarul kínaiul" → a Lumo. A top-3 találat + a metrikák.
- **Miért:** a keresés minőségének mérése a könyv-indexen — a várt találat a top-3-ban.
- **Függőség:** a 5.1 (a metrikák), a 5.2 (a ground-truth).
- **Kapcsolat:** a 5.4 (a sebességmérés).
- **Megvalósítás:** a `regresszióJelentés` lefuttatása a ground-trouthon + az eredmények kiírása.
- **Siker:** a várt találat a top-3-ban (>80% precision@3); az NDCG > 0.7.

**5.4. A teljesítménymérés.** (eredeti pont 47)
- **Feladat:** a sebesség mérése: a lineáris keresés (a LumoKereso_v1) vs. a hierarchikus (a 4.1) futásideje a teljes könyv-indexen.
- **Miért:** a „brutál gyors" = a mért gyorsulás. A papíron O(log n) nem elég — a gyakorlatban is mérni kell.
- **Függőség:** a 4.1 (a hierarchikus keresés), a 4.2 (a könyv-index).
- **Kapcsolat:** a 8.1 (a GAN-ellenőrzés).
- **Megvalósítás:** a futásidő mérése (az Idris `time` vagy a shell `time` parancs) mindkét keresésre, a könyv-indexen.
- **Siker:** a mért >10× gyorsulás a lineáris kereséshez képest.

---

### 6. FÁZIS — A VISSZACSATOLÁS (eredeti pontok: 56, 57)

**6.1. A relevancia-visszacsatolás.** (eredeti pont 56)
- **Feladat:** a felhasználó pontozza a találatokat (releváns = 1, nem releváns = 0), a rendszer ÚJRASÚLYOZZA a szófaj-súlyokat (a 3.4 IDF-súlyozása adaptívvá válik).
- **Miért:** a keresés egyirányú (ad találatokat, de nem tanul). A visszacsatolás empirikus javítás — a felhasználó pontozása finomítja a súlyokat.
- **Függőség:** a 3.4 (az IDF-súlyozás), a 4.1 (a keresés).
- **Kapcsolat:** a 6.2 (az aktív tanulás).
- **Megvalósítás:** `Visszacsatolas_v1.idr`: `record TalálatPontozás`; `súlyÚjraszámolás : List TalálatPontozás → Szotar → Szotar`; `adaptívKeresés : String → Szotar → List (Double, String)`.
- **Siker:** a pontozás után a következő keresés relevanciája javul (a metrikák mérik).

**6.2. Az aktív tanulás.** (eredeti pont 57)
- **Feladat:** ha két találat közti különbség kicsi, a rendszer megkérdezi: „melyik relevánsabb?" — a válaszból a szótár finomodik.
- **Miért:** a 6.1 passzív (a felhasználó pontozza, ha akarja). Az aktív direkt: a rendszer tudja, hogy nem tudja, és kérdez.
- **Függőség:** a 6.1 (a visszacsatolás).
- **Kapcsolat:** a 8.1 (a GAN-ellenőrzés hasonló — a rendszer bizonytalanságot jelez).
- **Megvalósítás:** `AktivTanulas_v1.idr`: `bizonytalanságMérés : List (Double, String) → Double` (a két legjobb találat távolságának különbsége); `kérdésGenerálás : String → (String, String) → String`.
- **Siker:** a bizonytalanság feloldása a felhasználó válaszával.

---

### 7. FÁZIS — A BERGMAN-KERNEL ÉS A HIPERBOLIKUS BEÁGYAZÁS (eredeti pontok: 22, 23, 24, 25, 26, 27, 28, 29, 30)

**7.1. A Markov-blanket szűrő.** (eredeti pont 22-23)
- **Feladat:** a lekérdezés szavainak korrelációs gömbje (a blanket) behatárolja a keresést: csak a lekérdezés szavaival korrelált dimenziók és klaszterek vesznek részt.
- **Miért:** a Stoßzahlansatz-elv (a korrelálatlan eldobása) az első lépésben ~90%-ot eldob — ez adja a log(n) költséget.
- **Függőség:** a `docs/stosszahlansatz_markov_blanket.md`, a 3.3 (a belső szorzat = a korreláció mértéke).
- **Kapcsolat:** a 7.2 (a Bergman a blanket-en belül keres).
- **Megvalósítás:** `MarkovBlanket_v1.idr`: `markovBlanket : String → Szotar → List Dimenzió` (a releváns dimenziók); `stossSzűrés : List IndexBejegyzés → List Dimenzió → List IndexBejegyzés` (a korrelálatlan eldobása).
- **Siker:** a korrelálatlan ~90% eldobása az első lépésben.

**7.2. A Bergman-kernel.** (eredeti pont 24-26)
- **Feladat:** a lekérdezés Bergman-magja: `bergmanMag : String → KomplexBajt` (a lekérdezés normalizált, hossz-egyenes báltja). A keresés: `bergmanKeresés : String → List (Complex, String)` (találat(q) = ⟨index_bájt, K_q⟩).
- **Miért:** a Bergman-kernel a szemantikus keresés matematikailag pontos alakja — a kiértékelés = belső szorzat a maggal (mint a Yoneda: K_z = a reprezentátor). NINCS a projektben — új kutatás.
- **Függőség:** a 3.3 (a belső szorzat), a 3.5 (a normalizált vektor).
- **Kapcsolat:** a 7.3 (a tétel: Bergman ≈ Manhattan).
- **Megvalósítás:** `BergmanKernel_v1.idr`: `bergmanMag = normalizáltBájt (mondatBájtra q)`; `bergmanKeresés q = map (\(m,b) => (belsőSzorzat b (bergmanMag q), m)) index`.
- **Siker:** a relevancia a modulus (re(|⟨q,d⟩|)), a fázis = a hangrend-egyezés.

**7.3. A tétel: Bergman ≈ Manhattan first-order.** (eredeti pont 26)
- **Feladat:** bizonyítani (Idris Refl a kis eseteken + analitikus indoklás), hogy a Bergman-belsőszorzat first-order megegyezik a Manhattan-távolsággal.
- **Miért:** a tétel igazolja, hogy a meglévő Manhattan-keresés (ami működik) a Bergman first-orderje — a Bergman a pontosabb (másodrendű korrekciókkal).
- **Függőség:** a 7.2 (a Bergman), a 3.2 (a Manhattan).
- **Kapcsolat:** a 8.2 (a Yoneda-tétel is a távolságot igazolja).
- **Megvalósítás:** a tétel vázlata: `1 − ⟨q,d⟩/|q||d| ≈ |q−d|²/(2|q||d|)` first-order; az Idris Refl a 2-3 elemű indexen.
- **Siker:** a két keresés azonos rangsort ad a teszteken.

**7.4. A hiperbolikus beágyazás.** (eredeti pont 27-30)
- **Feladat:** az index fa-struktúrájának hiperbolikus beágyazása: a tórusz (S¹×S¹) mint a hiperbolikus korong pereme; a mondatok a korongban, a hierarchia mélysége = a sugár. A Poincaré-távolság és az exponenciális kapacitás (2π(cosh r − 1)).
- **Miért:** a hiperbolikus tér exponenciális térfogat-növekedése adja az „exponenciális memória" matematikai alapját — a fák kvázi-izometrikusan beágyazhatók (arXiv:1705.08039).
- **Függőség:** a 2.1 (a tórusz), a 4.1 (a hierarchia), a `KvantumY.aranyMetszes` (a φ-szög).
- **Kapcsolat:** a 8.3 (a fixpont a hiperbolikusban konvergál), a 8.4 (az aranymetszés-spirál a hiperbolikusban természetes).
- **Megvalósítás:** `HiperbolikusBeagyazas_v1.idr`: `record PoincaréPont` (r : Double, θ : Double); `poincaréTávolság : PoincaréPont → PoincaréPont → Double` (a `acosh(1 + 2·|u−v|²/((1−|u|²)(1−|v|²)))` formulával); `exponenciálisKapacitás : Double → Double` (`2π(cosh r − 1)`).
- **Siker:** a fa-szülő-gyerek távolságok megőrzése; az elméleti kapacitás > a szükséges.

---

### 8. FÁZIS — A MATEMATIKA (eredeti pontok: 31-40)

**8.1. A Yoneda-lemma a keresésre.** (eredeti pont 31-32)
- **Feladat:** a formális alap dokumentálása: a komplex bájt = a mondat Yoneda-képe (Hom(A, −)); a távolság = a természetes transzformációk távolsága.
- **Miért:** a keresés matematikai igazolása (nem heurisztika) — a Yoneda-lemma garantálja, hogy a komplex bájt minden kapcsolatot megfog.
- **Függőség:** a `Kategóriaelmélet64_v1_Szima.yonedaEgyertelmu`.
- **Kapcsolat:** a 7.2 (a Bergman-mag = a Yoneda-reprezentátor), a 7.3 (a tétel).
- **Megvalósítás:** a dokumentáció (a `docs/YonedaKeresesre.md`) — a Yoneda-lemma alkalmazása a komplex bájtra.
- **Siker:** a keresés matematikailag igazolt.

**8.2. A fixpont-iteráció és a konvergencia 1/φ.** (eredeti pont 33-34)
- **Feladat:** a keresés iteratív finomítása: `x_{k+1} = x_k + γ·(cél − x_k)`, γ = 7/64 (a Solomonoff-modulból). A konvergencia 1/φ lépésenként (a Komplex.idr φ-kontrakciója).
- **Miért:** a fixpont-iteráció exponenciális konvergenciát ad (1/φ ≈ 0.618/lépés) — a keresés 2-3 lépés után stabil.
- **Függőség:** a `SolomonoffIndukció_v1_Szima` (a γ = 7/64), a `Komplex.idr` (a φ-kontrakció), a `KvantumY.idr` (a kvantumY).
- **Kapcsolat:** a 8.3 (a spirál), a 7.4 (a hiperbolikus).
- **Megvalósítás:** `FixpontKereses_v1.idr`: `fixpontKeresés : String → Nat → List (Double, String)` (az iterált finomítás); `konvergenciaMérés : Double → Double → Double` (a mért konvergencia-sebesség).
- **Siker:** a mért konvergencia ~0.618/lépés; a 2-3 iteráció után stabil rangsor.

**8.3. Az aranymetszés-spirál index.** (eredeti pont 35)
- **Feladat:** a 137.5°-os (a golden angle) elrendezés: az index-bejegyzések a spirálon, a szomszédosság a relevanciát tükrözi.
- **Miért:** a spirál a napraforgó-csomagolás optimális fedése — a szomszédok relevanciája magas.
- **Függőség:** a `KvantumY.aranyMetszesSzoog`, a 7.4 (a hiperbolikus).
- **Kapcsolat:** a 8.2 (a fixpont a spirálon konvergál).
- **Megvalósítás:** `AranymetszesSpiral_v1.idr`: `spirálSzög : Nat → Double` (a `n · aranyMetszesSzoog`); `spirálSzomszéd : Nat → Nat` (a szomszéd a spirálon).
- **Siker:** a spirál-szomszédok relevanciája magas (a metrikák mérik).

**8.4. A Carnot-ciklus és a reverzibilitás.** (eredeti pont 36-38)
- **Feladat:** a keresés 4 lépése mint a Carnot (szétbontás → kódolás → rangsor → top-k); a hatásfok η = 1 − T_C/T_H; a reverzibilitás (a találatból a lekérdezés rekonstruálható).
- **Miért:** a Carnot-ciklus a reverzibilitás garanciája — a keresés visszafelé is működik (a ForditasCarnot mintája).
- **Függőség:** a `ForditasCarnot.idr` (a 4 lépés), a `Dirac3D/Carnot.idr` (az entrópia + a hatásfok).
- **Kapcsolat:** a 8.5 (a GKP hibatűrés), a 9.1 (a fehérje-modell).
- **Megvalósítás:** a dokumentáció + a `reverzibilitásTeszt : String → String → Bool` (a round-trip).
- **Siker:** a round-trip konzisztens (a keresés → találat → lekérdezés ugyanaz).

**8.5. A GKP hibatűrés és a Wadler-parametricitás.** (eredeti pont 39-40)
- **Feladat:** az 1-szó-eltérés tesztje (a GKP 1 hibát javít) + a Wadler-parametricitás dokumentálása (a típus = a garancia).
- **Miért:** a hibatűrés a gyakorlati robusztusság (a felhasználó téveszt); a Wadler a matematikai (a típus garantálja).
- **Függőség:** a `Torusz.idr` (a GKP-kód), a `GeneralizedPauli.idr`.
- **Kapcsolat:** a 9.1 (a fehérje is hibatűrő).
- **Megvalósítás:** a `hibatűrésTeszt` (az 1-szó-eltérés rangsora nem változik drasztikusan) + a dokumentáció.
- **Siker:** az 1-szavas eltérés nem változtatja meg a rangsort.

---

### 9. FÁZIS — A FEHÉRJE-MODELL ÉS A BABYAGI (eredeti pontok: 41, 42, 43, 44, 65, 63, 64)

**9.1. A fehérje-modell integrálása.** (eredeti pont 41-42)
- **Feladat:** az `EpisodicMemory_v1_Szima` (1309 sor) bekötése: az indexbejegyzés = „fehérje" (1D aminosav = magyar szólánc; 2D = kínai kompozíció; 3D = a hajtás). A holografikus elv: a 2D felületi keresés olcsóbb, mint a 3D.
- **Miért:** a fehérje-modell a memória fizikai metaforája — a 2D felület (a Steane-kód) kódolja a 3D hajtást (a teljes mondat). A 2D-n keresni olcsó (kevesebb dimenzió).
- **Függőség:** az `EpisodicMemory_v1_Szima.idr`, a 4.1 (a hierarchikus keresés).
- **Kapcsolat:** a 9.2 (a BabyAGI), a 9.3 (az online tanulás).
- **Megvalósítás:** a `IndexBejegyzés` kiegészítése a fehérje-reprezentációval (a 2D + a 3D). A keresés a 2D-n (Steane + tórusz), a visszaolvasás a 3D-ből (a címke).
- **Siker:** a keresés a 2D-n számol (gyors), a találat a 3D-ből olvasható (teljes).

**9.2. A BabyAGI learnWord és sleepFilter.** (eredeti pont 43-44)
- **Feladat:** a `BabyAGI.learnWord` mint az indexelés motorja (minden új mondat a learnWord-ön át kerül az indexbe); a `sleepFilter` mint az index-tisztítás (a régi, irreleváns bejegyzések kiszűrése).
- **Miért:** az indexelés és a tanulás ugyanaz a folyamat — a learnWord a szót fehérjévé (= indexbejegyzéssé) alakítja; a sleepFilter a memória konzolidációját végzi.
- **Függőség:** a `BabyAGI_v1_Szima.idr`, a 9.1 (a fehérje-modell).
- **Kapcsolat:** a 9.3 (az online tanulás a learnWord-öt kiterjeszti).
- **Megvalósítás:** a `learnWord` bekötése az indexelésbe (a mondat → fehérje → IndexBejegyzés); a `indexAlvás : (IndexBejegyzés → Bool) → Index → Index`.
- **Siker:** az indexelés = a tanulás; a sleepFilter kontrollálja az index méretét.

**9.3. Az online tanulás és a few-shot adaptáció.** (eredeti pont 65)
- **Feladat:** a `learnWord` kiterjesztése: ha a mondat ismeretlen szót tartalmaz, a környezetből (a szomszédos szavakból) becslést kap és hozzáadja a szótárhoz. A few-shot: 1-3 példa → a szó báltja finomodik.
- **Miért:** a jelenlegi learnWord csak a meglévő szótárral dolgozik — az új szavak (pl. a Lumo-szövegek szakszava) nem kerülnek be. Az online tanulás (környezet-becslés) automatikusan bővíti a szótárat.
- **Függőség:** a 9.2 (a learnWord), a 0.2 (a szótár).
- **Kapcsolat:** a 7.1 (a verziókezelés — a szótár változik).
- **Megvalósítás:** `OnlineTanulas_v1.idr`: `környezetbőlJelentés : List String → Szotar → SzoJelentes` (a szomszédok átlaga); `learnWordOnline : String → Szotar → Szotar`.
- **Siker:** az új szó 3 példa után releváns találatot ad.

**9.4. A magyar hangrendszer (FanoParitás).** (eredeti pont 63)
- **Feladat:** a magyar hangrendszer (magánhangzó-harmónia: mély/magas) integrálása a komplex bájt 5. dimenziójába (hang). A `FanoParitás.idr` a projektben a Fano-paritást kódolja.
- **Miért:** a magyar nyelv SPECIÁLIS a hangrendszerében — a hangrend INFORMÁCIÓT hordoz (a „ház" mély, a „kép" magas — a hangrend jelzi a ragozást).
- **Függőség:** a `FanoParitás.idr`, a `KomplexByte.hangKomponens`.
- **Kapcsolat:** a 3.3 (a belső szorzat fázisa = a hangrend-egyezés).
- **Megvalósítás:** `HangrendszerKodolas_v1.idr`: `magánhangzóRend : Char → Maybe HangRend`; `szóHangrendje : String → HangRend`; `FanoParitásKódolás : String → Komplex`.
- **Siker:** a hangrend-egyezés javítja a keresést (a metrikák mérnek).

**9.5. A magánadatok és az elfelejtés joga.** (eredeti pont 64)
- **Feladat:** a Lumo-beszélgetések személyesek — a szenzitivitás-jelölő (a felhasználó jelöli → az index NEM tartalmazza) és a végleges-törlés (a sleepFilter mellett).
- **Miért:** az index publikus (a cikkben szerepel) — a magánadatok kiválasztása kötelező.
- **Függőség:** a 9.2 (a sleepFilter).
- **Kapcsolat:** a 10.1 (a GAN-ellenőrzés az etikát is vizsgálja).
- **Megvalósítás:** `Maganadatok_v1.idr`: `szenzitívMondat? : String → Bool` (a kulcsszavak: „privát", „titok", „személyes"); `szűrtIndexelés`; `elfelejtésJoga : String → Index → IO Index`.
- **Siker:** a szenzitív mondatok NEM az indexben.

---

### 10. FÁZIS — A PUBLIKÁCIÓ ÉS AZ ÉLŐ RENDSZER (eredeti pontok: 48, 49, 50, 58, 59, 60, 62)

**10.1. A GAN-ellenőrzés.** (eredeti pont 48)
- **Feladat:** egy független GAN-bíráló (a task-alügynök) értékeli: a találatok valóban relevánsak-e; a korlátozások; az etika.
- **Miért:** a független ellenőrzés a minőség garanciája — a GAN nem csak a metrikákat, hanem a RELEVANCIÁT is vizsgálja (nem csak formálisan kicsi a távolság).
- **Függőség:** a 5.1-5.3 (a metrikák + a tesztek), a 9.5 (az etika).
- **Kapcsolat:** a 10.2 (a cikk).
- **Megvalósítás:** a `task`-alügynök a kereső eredményeit + a metrikákat + a ground-trouht-t vizsgálja.
- **Siker:** a minor revision → accept.

**10.2. A publikáció.** (eredeti pont 49)
- **Feladat:** a cikk megírása: „A hiperbolikus episodic memory: exponenciálisan gyors szemantikus keresés komplex-bájt kódolással" — a Bergman-kernel + a Yoneda + a hiperbolikus + a mért eredmények.
- **Miért:** a kutatás eredménye publikálható — a cikk a kutatás végterméke.
- **Függőség:** a 10.1 (a GAN-ellenőrzés), az összes előző fázis.
- **Kapcsolat:** a 10.3 (az élő rendszer).
- **Megvalósítás:** `cikkek/episodic_memory_cikk.md`.
- **Siker:** a cikk beküldhető (a GAN szerint).

**10.3. A 9. szint — az élő rendszer.** (eredeti pont 50)
- **Feladat:** az episodic memory mint ÉLŐ rendszer: a keresés válaszol (nem csak keres — a találatból a válasz-mondat generálása); a learnWord folyamatosan tanul; a sleepFilter éjjel tisztít.
- **Miért:** a cél nem egy kereső, hanem egy RENDSZER, ami önmagát keresi — a kérdésre a válasz a saját memóriából. Ez a MANTRA 9. szintje.
- **Függőség:** az összes előző fázis.
- **Kapcsolat:** ez a végcél.
- **Megvalósítás:** a főprogram: `kérdés → hierarchikusKeresés → top-k → válasz-mondat`.
- **Siker:** **a kérdésre a válasz a saját memóriából** — a rendszer önmagára talál.

---

## A FÜGGŐSÉGEK ÖSSZEFoglALÓ TÁBLÁZAT

| Fázis | Feladat | Függ | Kapcsolódik | fájl |
|-------|---------|------|-------------|------|
| 0.1 | Lexikon v2 | — | 0.2, 0.3, 0.4 | HungarianLexicon_v2_Szima.idr |
| 0.2 | Szótár-generátor | 0.1 | 1.1, 3.1 | SzotarHid_v2.idr |
| 0.3 | Lumo-szókincs | 0.1, Lumo-txt | 2.2, 5.2 | LumoSzokincs_v1.idr |
| 0.4 | Tő-keresés 22 rag | SzotarHid_v1 | 1.1, 2.2 | SzotarHid_v2.idr |
| 0.5 | Ékezet-normalizáció | — | 1.1, 5.2 | EkezetNormalizalo_v1.idr |
| 0.6 | Bájt-egységesség | Peldaszotar, SzotarHid | 2.1 | (dokumentum) |
| 1.1 | Tokenizáló | Paragrafus, Kodol | 1.2, 2.1 | (SzotarHid_v2) |
| 1.2 | CPT-kinyerés | Torusz, MagyarNyelvtan | 2.1, 2.2 | MondatCPT_v1.idr |
| 1.3 | Steane-ellenőrzés | 0.2 | 3.1 | (futásidejű teszt) |
| 1.4 | IO-réteg | 0.2, 1.1 | 1.5, 2.1 | IndexeloIO_v1.idr |
| 1.5 | Streamelt indexelés | 1.4 | 2.3 | StreamIndexelo_v1.idr |
| 2.1 | Tórusz-pont index | Torusz, 1.2 | 2.2, 3.1 | IndexBejegyzes_v1.idr |
| 2.2 | 16 klaszter | 2.1 | 3.1, 3.6 | Klaszterezes_v1.idr |
| 2.3 | Lemez-index | 1.4, 2.2 | 3.1, 7.1 | LemezIndex_v1.idr |
| 3.1 | Hadamard előszűrő | HadamardTav, 2.2 | 4.1 | SteaneSzuro_v1.idr |
| 3.2 | Normalizált Manhattan | LumoKereso | 4.1, 5.2 | (LumoKereso_v2) |
| 3.3 | Belső szorzat | Komplex | 6.2, 7.3 | BelsoSzorzat_v1.idr |
| 3.4 | IDF-súlyozás | 0.2 | 3.2, 5.5 | (SzotarHid_v2) |
| 3.5 | Hossz-normalizálás | 3.3 | 6.2, 7.3 | (BelsoSzorzat_v1) |
| 3.6 | Klaszter-egyensúly | 2.2 | 4.1 | KlaszterEgyensuly_v1.idr |
| 4.1 | Hierarchikus keresés | 2.2, 3.1, 3.2 | 4.2, 5.1 | HierarchikusKereses_v1.idr |
| 4.2 | Könyvek indexelése | 1.4-1.5, 4.1 | 5.1-5.2 | (IndexeloIO_v1) |
| 5.1 | Metrikák | 4.2, 5.2 | 5.3, 8.1 | KeresesiMetrikak_v1.idr |
| 5.2 | Ground-truth | 4.2 | 5.1, 5.3 | tesztek/GroundTruth_v1.txt |
| 5.3 | Könyvtalálatok | 5.1, 5.2 | 5.4 | (GroundTruth_v1) |
| 5.4 | Teljesítménymérés | 4.1, 4.2 | 8.1 | (futásidejű) |
| 6.1 | Visszacsatolás | 3.4, 4.1 | 6.2 | Visszacsatolas_v1.idr |
| 6.2 | Aktív tanulás | 6.1 | 8.1 | AktivTanulas_v1.idr |
| 7.1 | Markov-blanket | stossz_doc, 3.3 | 7.2 | MarkovBlanket_v1.idr |
| 7.2 | Bergman-kernel | 3.3, 3.5 | 7.3, 8.1 | BergmanKernel_v1.idr |
| 7.3 | Tétel: Berg≈Manh | 7.2, 3.2 | 8.1 | (dokumentum) |
| 7.4 | Hiperbolikus | Torusz, 4.1, KvantumY | 8.2, 8.3 | HiperbolikusBeagyazas_v1.idr |
| 8.1 | Yoneda | KategoriaElmelet | 7.2 | (dokumentum) |
| 8.2 | Fixpont 1/φ | Solomonoff, Komplex, KvantumY | 8.3, 7.4 | FixpontKereses_v1.idr |
| 8.3 | Aranymetszés-spirál | KvantumY, 7.4 | 8.2 | AranymetszesSpiral_v1.idr |
| 8.4 | Carnot + reverzibilitás | ForditasCarnot, Carnot | 8.5, 9.1 | (dokumentum) |
| 8.5 | GKP + Wadler | Torusz, GeneralizedPauli | 9.1 | (dokumentum) |
| 9.1 | Fehérje-modell | EpisodicMemory, 4.1 | 9.2, 9.3 | (IndexBejegyzes_v2) |
| 9.2 | BabyAGI learnWord/sleep | BabyAGI, 9.1 | 9.3 | (IndexeloIO_v2) |
| 9.3 | Online tanulás | 9.2, 0.2 | 7.1 | OnlineTanulas_v1.idr |
| 9.4 | Hangrendszer (Fano) | FanoParitas, KomplexByte | 3.3 | HangrendszerKodolas_v1.idr |
| 9.5 | Magánadatok | 9.2 | 10.1 | Maganadatok_v1.idr |
| 10.1 | GAN-ellenőrzés | 5.1-5.3, 9.5 | 10.2 | (task-alügynök) |
| 10.2 | Publikáció | 10.1, összes | 10.3 | cikkek/episodic_memory_cikk.md |
| 10.3 | 9. szint (élő) | összes | — | (főprogram) |

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★