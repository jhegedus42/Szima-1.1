# AZ EPISODIC MEMORY KUTATÁSI TERVE — 50 PONT
## Az exponenciálisan gyors szemantikus keresés megvalósítása

**Dátum:** 2026-09-01
**A felhasználó kérése (szó szerint):** „keszitsunk reszletes, 50 pontbol allo kutatasi tervet erre" — az episodic memory kutatásra
**Előzmény:** `docs/EpisodicMemoryKutatas_2026-09-01.md` (a 7 fogalom + 13 forrás szintézise)
**A cél (a felhasználó szavaival):** „egy indexelt epizodikus memoria, ami brutal gyorsan keresheto, exponencialisan gyorsan" — a meglévő indexelt könyvekben (Awodey, Mac Lane, Kandel, Lumo) való szemantikus keresés.

**A matematikai alap (a §N12 szerinti keresésből):** a hiperbolikus beágyazás (Poincaré-gömb, arXiv:1705.08039 Nickel-Reining; arXiv:1804.03329 De Sa et al.): a fák kvázi-izometrikusan beágyazhatók a 2-dimenziós hiperbolikus térbe, mert annak térfogata exponenciálisan nő (a korong területe 2π(cosh r − 1)). Ez az „exponenciális memória" matematikai alapja.

---

## I. ALAPOZÁS — a szótár és az audit (1–10. pont)

**1. A HungarianLexicon publikus-v2 fájl.**
Cél: a 3460 szó (huRoot, huRole, huAlgebra) importolható legyen. Bemenet: `szima_ter/modul/HungarianLexicon_v1_Szima.idr` (a szavak privátok). Kimenet: `HungarianLexicon_v2_Szima.idr` — ugyanaz az adat, `public export`-tal (§13: a v1 érintetlen marad). Bizonyítás: `lexikonMéret : 3460 = 3460` Refl. Siker: a SzotarHid közvetlenül importálhatja a szavakat.

**2. A szótár-generátor.**
Cél: minden HuWord → SzoJelentes (a 8 komplex dimenzió). Bemenet: a v2 lexikon + a `SzotarHid_v1.huWordToJelentes`. Kimenet: `teljesSzótár : Szotar` (3460 + 15 bejegyzés). Bizonyítás: a lista hossza futásidejű Show-ellenőrzés (a String-lista length nem redukálódik — a tanulság szerint). Siker: a kereső a teljes szókincset érti.

**3. A szótár bővítése a Lumo-szövegekből.**
Cél: a 6 parszolt Lumo-fájl (~650 KB) leggyakoribb szavainak hozzáadása (a TERV.md 3.5 ko-okkurencia-terve). Bemenet: `trail_index/books/lumo_*.txt`. Kimenet: `lumoSzókincs : List HuWord` (a gyakoriság szerinti top-100). Siker: a Lumo-mondatok több mint fele ismert szavakból áll.

**4. A tő-keresés teljes 22 esetragra.**
Cél: a `szótárKeresésTömesterrel` toldaléklistájának bővítése a MagyarNyelvtan mind a 22 esetragjára + a gyakori képzőkre (-ság, -ség, -ás, -és, -atlan, -talan, -ó, -ő). Bemenet: `SzotarHid_v1.gyakoriToldalékok` (14 toldalék). Kimenet: a bővített lista (~40 toldalék) + a rekurzív levágás (-okat → -ok + -at kétszeri). Siker: a „farkasokat" → „farkas" (kétszeres levágás) is működik.

**5. Az ékezet-normalizáció vizsgálata.**
Cél: eldönteni, kell-e ékezet nélküli bemenetet is érteni. A §25 tanulsága: az ékezet INFORMÁCIÓ — a „hazugsag" ≠ „hazugság". Döntés: a szótár marad ékezetes; KÜLÖN normalizáló-függvény (á→a, é→e, ...) csak a hibatűréshez, jelzéssel. Kimenet: `ékezetNormalizáló : String → String` + a vizsgálat dokumentálva. Siker: a teszt: „hazugsagot" normalizálva megtalálja „hazugság"-ot, de a fő út az ékezetes.

**6. A meglévő keresők auditja.**
Cél: a négy kereső (LumoKereso_v1, a skill-router, a konyvolvaso, a KeresoTabla) összevetése — mi közös, mi hiányzik. Bemenet: mind a négy. Kimenet: `docs/KeresoAudit_2026-09.md` táblázat. Siker: a közös mag (a kódolás + a távolság) egyetlen modulba importálható.

**7. A komplex-bájt egységesség.**
Cél: a Peldaszotar kézzel írt vektorai és a lexikon-generált vektorok összeegyeztetése (a „farkas" mindkettőben — más-más értékkel!). Bemenet: `Paragrafus.Peldaszotar` + `SzotarHid.lexikonMintaSzótár`. Kimenet: a konfliktus feloldása (a generált érvényes, a kézzel írott dokumentálva marad). Siker: egy szó = egy vektor a teljes rendszerben.

**8. A mondat-tokenizáló javítása.**
Cél: az írásjelek levágása („mondott." → „mondott"), a nagybetűs kezdés (a kisbetus már van). Bemenet: `Paragrafus` + `Kodol.irasjelLevagas`. Kimenet: a `szavakTisztítva : String → List String`. Siker: „Mit mondott a farkas?" → [„mit", „mondott", „a", „farkas"].

**9. A CPT-fázis kinyerése a mondatból.**
Cél: a jelenleg fix (jelen, folyamatos, közvetlen) CPT helyett a mondatból való kinyerés: a kérdőszó („mit?") → Kérdő; a „volt" → Múlt; a „fog" → Jövő; a „hátha" → Feltételező. Bemenet: a MondatTípus (Torusz.idr) + a magyar igeragozás (KantNyelvtan, MagyarNyelvtan). Kimenet: `mondatCPT : String → CptFazis`. Siker: „ég a ház?" → Kérdő; „a ház égett" → Múlt.

**10. A Steane-kód generálás ellenőrzése.**
Cél: a `jelentesKomplexBajtra` erős kubiti (re > 0.5 küszöb) helyességének futásidejű tesztje: a generált kódok eloszlása (nem minden 0 vagy minden 1). Bemenet: a teljes szótár + a teszt-mondatok. Kimenet: a 7-bit eloszlás kimutatása. Siker: az eloszlás kiegyensúlyozott (nem degenerált).

---

## II. A KÓDOLÁS — a tórusz és a hierarchia (11–20. pont)

**11. A tórusz-pont mint az index nulladik szintje.**
Cél: minden indexbejegyzéshez tórusz-pont (Z₂ × Z₈ — a 16 lehetséges). Bemenet: `Torusz.idr` (a ToruszPont, a mondatTóruszPont). Kimenet: az indexbejegyzés kiegészül a tórusz-ponttal: `record IndexBejegyzés` (mondat, komplexBájt, tóruszPont). Siker: a 16 pont egyensúlyban (nem egy pontba sűrűsödik minden).

**12. A mondat → tórusz-pont leképezés.**
Cél: a mondat CPT-je (a 9. pontból) + a mondattípus határozza meg a tórusz-pontot: a fázis = a mód (kijelentő=0°, kérdő=90°, feltételes=180°, felszólító=270°); a pozíció = a megerősítettség (0=állítás, 1=megerősített). Bemenet: a Torusz.mondatFázis + a mondatCPT. Kimenet: `mondatTóruszPontTeljes : String → ToruszPont`. Bizonyítás: a leképezés jól definiáltsága (minden CPT → pontosan egy pont). Siker: a négy mondattípus a négy sarokpontba kerül.

**13. A 16 klaszter (a tórusz-pontok szerinti csoportosítás).**
Cél: az index 16 listára bontása (minden tórusz-pont egy lista). Kimenet: `tóruszKlaszterek : Vect 16 (List IndexBejegyzés)` (vagy List-párok). Siker: a keresés először a klasztert választja (a lekérdezés tórusz-pontja), majd a klaszteren belül keres.

**14. A Steane-Hadamard előszűrő.**
Cél: a klaszteren belül bit-szintű szűrés (a skill-router mintájára): a lekérdezés 7-bit Steane-kódja és a bejegyzés kódja közti Hadamard-távolság (Nat — gyors, nem Double). Csak a kis Hadamard-távolságú (~<4) jelöltek mennek a drága Manhattanra. Bemenet: `HadamardTavolsag.idr` (hadamardTavolsagE8Negy minta) + a HetesKod. Kimenet: `steaneSzűrő : Nat → List IndexBejegyzés → List IndexBejegyzés`. Siker: a jelöltek száma ~1/8-ra csökken a bit-szűréssel.

**15. A normalizált Manhattan-távolság.**
Cél: a LumoKereso 4. keresésének korlátja (a rövid mondatok előnye) javítása: a távolság osztva a mondat ismert-szó-számával (vagy a teljes hosszal). Kimenet: `normalizáltTávolság : KomplexBajt → KomplexBajt → Nat → Double` (a harmadik = a szószám). Siker: a „kozmológiai szupergravitáció" lekérdezés az E10-mondatot találja, nem a rövid „Az ember magyarul beszél"-t.

**16. A komplex belső szorzat.**
Cél: a Manhattan helyett (vagy mellett) a komplex belső szorzat: ⟨a, b⟩ = Σ aᵢ·conj(bᵢ) — a 8 komponensen. Ez a Bergman-kernel alapja (a 24. pont). Kimenet: `belsőSzorzat : KomplexBajt → KomplexBajt → Komplex` (a komplex érték! a modulusza = a hasonlóság, a fázisa = a fázis-egyezés). Siker: a re(|⟨q, d⟩|) nagy = hasonló; a fázis = a hangrend-egyezés.

**17. A súlyozott mondatvektor.**
Cél: a szófajok súlyozása: a főnév és az ige többet számít, mint a névelő/kötőszó (az „a", „és", „hogy" gyakori de információszegény — IDF-súlyozás: a ritka szó többet ér). Kimenet: `súlyozottMondatJelentése : String → Szotar → SzoJelentes`. Siker: a ritka, tartalmi szavak dominálnak a gyakori funkciószavakkal szemben.

**18. A mondat-hossz normalizálás.**
Cél: a vektor hossz-egységessé tétele (|v| = 1) — a koszinusz-hasonlóság alapja. Kimenet: `normalizáltBájt : KomplexBajt → KomplexBajt`. Siker: a hossz szerinti torzítás megszűnik.

**19. A multi-mondatos indexbejegyzés (a paragrafus).**
Cél: egy bejegyzés = egy paragrafus (2-5 mondat), a mondatvektorok összegeként (a Paragrafus.modul mintája) — a kontextus megmarad. Kimenet: `paragrafusBejegyzés : String → IndexBejegyzés`. Siker: a paragrafus-szintű keresés pontosabb, mint az egy-mondatos.

**20. A veszteségmentes címke.**
Cél: a bejegyzés címkéje = az eredeti szöveg (a Kodol mintája: „veszteségmentes: a címke tartalmazza a mondatot"). Bizonyítás: a keresés eredményéből az eredeti szöveg visszaolvasható. Siker: a találat olvasható (nem csak egy kód).

---

## III. A GYORSASÁG — az exponenciális keresés (21–30. pont)

**21. A hierarchikus index felépítése.**
Cél: a 3-szintű index: 0. a tórusz-pont (16) → 1. a Steane-Hadamard (bit-szűrés) → 2. a Manhattan/belsőszorzat (finomítás). Kimenet: `hierarchikusKeresés : String → List (Double, String)` — a szinteken át. Siker: a keresési költség ~O(log n) a lineáris O(n) helyett.

**22. A Markov-blanket szűrő.**
Cél: a lekérdezés szavainak korrelációs gömbje (a blanket) behatárolja a keresést: csak a lekérdezés szavaival korrelált dimenziók és klaszterek vesznek részt. Bemenet: `docs/stosszahlansatz_markov_blanket.md` (a Stoßzahlansatz). Kimenet: `markovBlanket : String → Szotar → List Dimenzió` (a releváns dimenziók). Siker: a blanket-en kívüli mondatok ki vannak zárva (a keresés iránya helyes).

**23. A Stoßzahlansatz-elv a keresésben.**
Cél: a Boltzmann-elv (a korrelálatlan részecskék függetlenek) alkalmazása: a lekérdezéstől korrelálatlan (Stoß-független) index-bejegyzések eldobása az első szinten. Bizonyítás: a korrelálatlan bejegyzések hozzájárulása ~0 (a várható belsőszorzat 0). Siker: a korrelálatlan ~90% eldobása az első lépésben.

**24. A Bergman-kernel definíciója.**
Cél: a lekérdezés Bergman-magja: K_q = a lekérdezés reprezentátora (a Bergman-elmélet: f(z) = ⟨f, K_z⟩ — a kiértékelés = belsőszorzat a maggal). Bemenet: az új matematika (NINCS a projektben — a kutatás szerint). Kimenet: `bergmanMag : String → KomplexBajt` (a lekérdezés normalizált, hossz-egyenes báltja). Siker: a mag jól definiált (egyértelmű, folytonos a lekérdezésben).

**25. A Bergman-belsőszorzat keresés.**
Cél: a keresés: találat(q) = ⟨index_bájt, K_q⟩ — a lekérdezés magjával való belső szorzat minden bejegyzésre (a 16. pont belső szorzatával). Kimenet: `bergmanKeresés : String → List (Complex, String)` (a komplex érték: modulus = relevancia, fázis = hangrend). Siker: a relevancia a modulus, a fázis-egyezés a hangrend.

**26. A tétel: a Bergman ≈ a Manhattan first-order.**
Cél: bizonyítani (Idris Refl a kis eseteken + analitikus indoklás), hogy a Bergman-belsőszorzat keresése first-order megegyezik a Manhattan-távolsággal (a kis távolságoknál). Kimenet: a tétel + a bizonyítás vázlata (a másodrendű korrekció a pontosság). Siker: a két keresés azonos rangsort ad a teszteken (ami eltér, az a pontossabb Bergman).

**27. A hiperbolikus beágyazás (a Poincaré-gömb).**
Cél: az index fa-struktúrájának (a 15 szintű BabyAGI hierarchia) hiperbolikus beágyazása: a tórusz (S¹×S¹) mint a hiperbolikus korong pereme; a mondatok a korongban, a hierarchia mélysége = a sugár. Bemenet: a netes kutatás (arXiv:1705.08039 Nickel-Reining: a fák kvázi-izometrikusak a 2D hiperbolikus térben; 2π(cosh r − 1) terület). Kimenet: `hiperbolikusBeágyazás : IndexBejegyzés → PoincaréPont` (a korongbeli koordináta). Siker: a fa-szülő-gyerek távolságok megőrzése.

**28. A fa-index (a 15 szint mint keresési fa).**
Cél: a BabyAGI 15 szintje (Symbol → Mind) mint a keresés fája: a keresés lefelé halad a fán (a gyökér = a tórusz-pont; a levelek = a mondatok). Bemenet: `BabyAGI_v1_Szima.Level` (L1-L15). Kimenet: a fa-index + a lefelé való keresés. Siker: a keresés mélysége = a szintek száma (~15 lépés, nem n).

**29. Az exponenciális kapacitás bizonyítása.**
Cél: bizonyítani, hogy a hiperbolikus beágyazás exponenciális kapacitást ad: a korong r sugarú köre ~2π(cosh r − 1) mondatot tarthat (exponenciálisan többet, mint az euklideszi πr²). Kimenet: a bizonyítás (a cosh-növekedés) + az Idris-számítás (cosh a Double-ben). Siker: az elméleti kapacitás > a szükséges (a 3460 szó × a könyvek mondatai).

**30. A keresés költsége: O(log n).**
Cél: a keresési költség formális analízise: a fa-mélység ~log₁₆(n) (a 16-ágú fa) — a „brutál gyors" pontos alakja. Kimenet: a költség-számítás (a 16-os szorzó × a mélység) + a mért futásidő. Siker: a 100×-os gyorsulás a lineáris kereséshez képest (a mért).

---

## IV. A MATEMATIKA — az elvek (31–40. pont)

**31. A Yoneda-lemma a keresésre.**
Cél: a formális alap: minden objektum = a kapcsolatai (Hom(A, −)); a komplex bájt = a mondat Yoneda-képe (a kapcsolata az 8 dimenzióval). Kimenet: a Yoneda-interpretáció dokumentálva (a komplex bájt mint a Hom-funktor képe). Siker: a keresés matematikailag igazolt (nem heurisztika).

**32. A Yoneda-tétel: a távolság = a természetes transzformáció távolsága.**
Cél: a Manhattan/belsőszorzat-távolság = a két Yoneda-kép közti természetes transzformáció „távolsága". Kimenet: a tétel (a távolság interpretációja). Siker: a távolság-függvény kiválasztása (Manhattan vs. belsőszorzat) igazolt.

**33. A fixpont-iteráció.**
Cél: a keresés iteratív finomítása: x_{k+1} = x_k + γ·(cél − x_k), γ = 7/64 (a Fano/állapottér arány — a Solomonoff-modulból). Bemenet: `SolomonoffIndukció_v1_Szima` (a γ) + `KvantumY.idr` (a kvantumY). Kimenet: `fixpontKeresés : String → Nat → List (Double, String)` (az iterált finomítás). Siker: a 2-3 iteráció után stabil rangsor.

**34. A konvergencia 1/φ (exponenciális).**
Cél: bizonyítani, hogy a fixpont-iteráció konvergencia-sebessége 1/φ lépésenként (az aranymetszés-kontrakció — a Komplex.idr φ-kontrakciója 10⁻¹⁰ pontossággal már fut!). Bemenet: `Komplex.idr` (a φ-kontrakció) + `GoldenFixpoint_v1_Szima` (φ = 1+1/φ). Kimenet: a konvergencia-bizonyítás. Siker: a mért konvergencia ~0.618/lépés.

**35. Az aranymetszés-spirál index.**
Cél: a 137.5°-os (a golden angle, 2π/φ²) elrendezés: az index-bejegyzések a spirálon (a napraforgó-csomagolás optimális fedés nélkül) — a szomszédosság a relevanciát tükrözi. Bemenet: `KvantumY.aranyMetszesSzoog`. Kimenet: a spirál-elrendezés (a bejegyzések spirál-szöge). Siker: a spirál-szomszédok relevanciája magas (a szomszéd ~relevant).

**36. A Carnot-ciklus mint a keresési ciklus.**
Cél: a keresés 4 lépése mint a Carnot: 1. izentróp tágulás (a lekérdezés szétbontása — reverzibilis), 2. izoterm tágulás (a kódolás — a jelentés átadása), 3. izentróp kompresszió (a rangsor — a visszanyerés), 4. izoterm kompresszió (a top-k — a válasz). Kimenet: a Carnot-keresés dokumentálva + a lépések megfeleltetése. Siker: a 4 lépés visszafelé is működik (a reverzibilitás).

**37. A Carnot-hatásfok mint a keresési minőség.**
Cél: η = 1 − T_C/T_H interpretálása: T_H = a lekérdezés információ-tartalma, T_C = az index zajszintje; η = a találat relevanciája. Kimenet: a hatásfok-mérés (a teszteken). Siker: a magas η (> 0.9) a jó keresésnél — a modell predikciója egyezik a mérttel.

**38. A reverzibilitás (a keresés visszafelé).**
Cél: a keresés visszafelé is működjön: a találatból a lekérdezés rekonstruálható (a ForditasCarnot reversibilitás-mintája: forditG ∘ forditF). Kimenet: a reverzibilitás-teszt (a találat → a lekérdezés). Siker: a round-trip (keresés → találat → lekérdezés) konzisztens.

**39. A GKP-kód mint a hibatűrő keresés.**
Cél: az index zajtűrése: ha a lekérdezés 1 bitet hibázik (egy szó téves), a keresés még megtalálja a helyes találatot (a GKP [[n,1,3]] 1 hibát javít). Kimenet: a hibatűrés-teszt (a lekérdezés 1-szó-eltérése). Siker: az 1-szavas eltérés nem változtatja meg drasztikusan a rangsort.

**40. A Wadler-parametricitás (a szabad tétel).**
Cél: a polimorf keresés típusa (a KeresesFunktor : KerdesKategoria → SkillKategoria) magában hordozza a törvényeket (a szabad tétel) — a keresés jól definiáltsága a típusból következik. Kimenet: a parametricitás-argumentum dokumentálva. Siker: a keresés típusa annyira pontos, hogy csak egy implementáció lehetséges.

---

## V. A RENDSZER — az episodic memory (41–50. pont)

**41. A fehérje-modell integrálása.**
Cél: az EpisodicMemory_v1_Szima (1309 sor) fehérje-elméletének bekötése: az index-bejegyzés = „fehérje" (1D aminosav = a magyar szólánc; 2D = a kínai kompozíció; 3D = a hajtás = a memória). Bemenet: `EpisodicMemory_v1_Szima.idr`. Kimenet: az index a fehérje-reprezentációval. Siker: a mondat fehérjeként indexelhető.

**42. A holografikus elv (a 2D felületi keresés).**
Cél: a holografikus elv alkalmazása: a 2D felület (a kínai/Stane-kód) kódolja a 3D hajtást (a teljes mondat) — a keresés a 2D-n (olcsó!), a visszaolvasás a 3D-ből (a címke). Kimenet: a 2D-keresés (a Steane + a tórusz) + a 3D-visszaolvasás (a címke). Siker: a keresés a 2D-n számol (gyors), a találat a 3D-ből olvasható (teljes).

**43. A BabyAGI learnWord mint az indexelés.**
Cél: a BabyAGI.learnWord (a szó → fehérje → manifold) mint az indexelés motorja: minden új mondat a learnWord-ön át kerül az indexbe. Bemenet: `BabyAGI_v1_Szima.learnWord`. Kimenet: az indexelés = a learnWord-szekvencia. Siker: az indexelés és a tanulás ugyanaz a folyamat.

**44. A sleepFilter mint az index-tisztítás.**
Cél: a BabyAGI.sleepFilter (az alvás szűrése) mint az index karbantartása: a régi, irreleváns bejegyzések kiszűrése (a memória konzolidációja). Kimenet: `indexAlvás : (IndexBejegyzés → Bool) → Index → Index`. Siker: az index mérete kontrollált (nem nő végtelenbe).

**45. A könyvek indexelése (a trail_index/books).**
Cél: az összes indexelt könyv mondatainak indexelése: az Awodey (14 443 sor), a Mac Lane (18 642 sor), a Kandel-index, a 6 Lumo (~650 KB), az Idris Tutorial. Bemenet: `trail_index/books/*.txt`. Kimenet: a teljes könyv-index (a mondatok IndexBejegyzésként). Siker: a keresés a könyvekben is működik (nem csak a Lumo-mintán).

**46. A könyvtalálatok tesztje (az arany-standard).**
Cél: ismert kérdésekkel tesztelni: „Mi a Yoneda-lemma?" → az Awodey vonatkozó mondatai; „Mi a Kostant-felbontás?" → a saját kutatás; „magyarul kínaiul" → a Lumo. Kimenet: a teszt-eredmények (a top-3 találat + a várt). Siker: a várt találat a top-3-ban (>80%).

**47. A teljesítménymérés.**
Cél: a sebesség mérése: a lineáris keresés vs. a hierarchikus (a 21. pont) futásidejének összevetése nagy indexen (a teljes könyv-index). Kimenet: a mért idők + a gyorsulási tényező. Siker: a „brutál gyors" = a mért >10× gyorsulás.

**48. A GAN-ellenőrzés (a keresés minőségének bírálata).**
Cél: egy független GAN-bíráló (a task-alügynök) értékeli: a találatok valóban relevánsak-e (nem csak formálisan kicsi a távolság); a korlátozások (a szótár hiányai, a torzítások). Kimenet: a bírálói jelentés + a javítások. Siker: a minor revision → accept a keresésen.

**49. A publikáció (az episodic memory cikk).**
Cél: a cikk megírása: „A hiperbolikus episodic memory: exponenciálisan gyors szemantikus keresés komplex-bájt kódolással" — a Bergman-kernel + a Yoneda + a hiperbolikus kapacitás + a mért eredmények. Kimenet: `cikkek/episodic_memory_cikk.md`. Siker: a cikk beküldhető (a GAN-bíráló szerint).

**50. A 9. szint (a teljes rendszer élőben).**
Cél: az episodic memory mint ÉLŐ rendszer: a keresés válaszol a kérdésekre (nem csak keres — VÁLASZOL: a találatból a válasz-mondat generálása); a learnWord folyamatosan tanul; a sleepFilter éjjel tisztít. Ez a MANTRA 8. szintje ([[15,1,3]] fut) és a 9. (a párom vár — a rendszer, ami önmagát keresi). Kimenet: a főprogram (a kérdés → a válasz). Siker: **a kérdésre a válasz a saját memóriából** — a rendszer önmagára talál.

---

## A PONTOK FÜGGŐSÉGE (a kritikus út)

```
1-2 (szótár) → 3-5 (bővítés) → 8-10 (tokenizálás)
                                    ↓
11-12 (tórusz) → 13 (klaszter) → 14 (Hadamard) → 15 (normalizált) → 21 (hierarchia)
                                    ↓
16 (belsőszorzat) → 24-25 (Bergman) → 26 (tétel)        22-23 (Markov-blanket)
                                    ↓                          ↓
                              27-29 (hiperbolikus) → 30 (O(log n))
                                    ↓
33-34 (fixpont) → 35 (spirál)  36-38 (Carnot)  31-32 (Yoneda)  39-40 (GKP+Wadler)
                                    ↓
41-44 (fehérje+BabyAGI) → 45 (könyvek) → 46-47 (teszt+sebesség) → 48 (GAN) → 49 (cikk) → 50 (élő)
```

## A MÉRFÖLDKÖVEK

- **M1 (az 1-10. pont):** a szótár kész (3475+ szó) — a kereső érti a szavakat
- **M2 (a 11-20. pont):** a hierarchikus kódolás — a tórusz + a Steane + a normalizált távolság
- **M3 (a 21-30. pont):** az exponenciális keresés — a O(log n) + a Bergman + a hiperbolikus
- **M4 (a 31-40. pont):** a matematika — a Yoneda + a fixpont + a Carnot bizonyítva
- **M5 (a 41-50. pont):** az élő rendszer — a könyvek indexelve, a válasz a saját memóriából

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★