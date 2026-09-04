# Kandel — Principles of Neural Science (6th ed.) — Kinyerés / Extraction
# Forrás chunk: kandel_chunk_12.txt (Chapter 51: Sexual Differentiation of the Nervous System)
# Séma: book_processor.md ConceptNote YAML.
# Minden azonosító magyar (AGENTS.md §0), rövidítés nincs. Idris 2 aláírások.
# A "neocortex" / "kategoriaelmelet" / "E8" címkék csak valódi fogalmi híd esetén.

---

## Fogalomjegyzetek / ConceptNotes

```yaml
- id: KANDEL12-001
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Epigenetikus módosítás DNS-metilációval (epigenetic modification by DNA methylation)"
  type: CausalRelation
  idris_version: 2
  summary: >
    A korai tapasztalás a glükokortikoid-receptor (glucocorticoid receptor) gén egy
    kulcshelyének metilációjával (DNA methyltransferase enzim útján) tartósan bekapcsolja
    vagy kikapcsolja a gént. Ez a kovalens genomiális módosítás élethosszig tartó
    viselkedésmintázatokhoz vezet anélkül, hogy a DNS szekvenciája megváltozna.
  signature: "EpigenetikusMódosítás : (Gén, KoraiTapasztalás) -> ÉlethosszigTartóViselkedés"
  code: "EpigenetikusMódosítás = Metiláció (Gén) `olasában` (Tapasztalás)"
  related: [KANDEL12-002, KANDEL12-012, KANDEL12-004]
  causes: [KANDEL12-002, KANDEL12-012]
  caused_by: [KANDEL12-011]
  resolves: ["Génkifejeződés tartós, nem-generetikai átkapcsolása (öröklődő viselkedésminta)"]
  tags: [neocortex, "epigenetika", "plaszticitás", "fenotípus-tartósság"]
```

```yaml
- id: KANDEL12-002
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Magas gondozási szintű (high-LG) anya -> szelektív demetiláció -> felnőttkori tapasztalat felerősítése"
  type: Pattern
  idris_version: 2
  summary: >
    Az alacsony-LG (low-LG) anyáról nevelt kölykökben a glükokortikoid-receptor gén
    metilált marad, míg a magas-LG anyáról neveltekben szelektíven demetilálódik.
    Így a magas-LG környezetben nevelkedő állatoknál a felnőttkori tapasztalat hatása
    felerősödik, és tompított (blunted) viselkedéses válasz jelenik meg a stresszorokra.
  signature: "GondozásiSzint : AnyaiGondozás -> (MetilációsÁllapot, FelnőttkoriÉrzékenység)"
  code: "GondozásiSzint MagasLG = Demetilált Receptor + FelerősítettTapasztalat"
  related: [KANDEL12-001, KANDEL12-012]
  causes: [KANDEL12-012]
  caused_by: []
  resolves: ["Korai környezeti bemenet leképezése tartós neurobiológiai állapotra"]
  tags: [neocortex, "epigenetika", "környezet-hatás", "fenotípus-tartósság"]
```

```yaml
- id: KANDEL12-003
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Oxitocin és vazopresszin szabályozza az anyai kötődést és szociális viselkedést"
  type: Pattern
  idris_version: 2
  summary: >
    Az oxitocin (oxytocin) a hipotalamuszban termelődik, az agyalapi mirigyen (posterior
    pituitary) keresztül a vérkeringésbe kerül, és szabályozza a tejleadást (milk let-down)
    és a szociális kötődést. Az egyedi különbségek a gondozásban az agy bizonyos területein
    mért oxitocin-receptor szintjével korrelálnak; a tapasztalat mind a felszabadulást, mind
    a receptor-szintet módosítja.
  signature: "OxitocinSzabályozás : (SzenzorosBemenet, Tapasztalat) -> SzociálisViselkedés"
  code: "OxitocinSzabályozás = ReceptorSzint (Agytérfkelet) `függ` (KoraiGondozás)"
  related: [KANDEL12-002, KANDEL12-012]
  causes: []
  caused_by: [KANDEL12-002]
  resolves: ["Szociális viselkedés neurokémiai alapjának és tapasztalati modulálhatóságának megadása"]
  tags: [neocortex, "szociális-viselkedés", "polipeptid-hormon", "receptor-szint"]
```

```yaml
- id: KANDEL12-004
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Ösztrogén felnőttkori, ciklikus preszinaptikus újrakonfigurálása"
  type: Definition
  idris_version: 2
  summary: >
    Az ösztrogén (estrogen) nemcsak fejlődéskor, hanem felnőtt korban is periodikusan
    újrakonfigurálja egy hipotalamikus áramkör preszinaptikus kapcsolódását, így biztosítva,
    hogy a nőstény egér csak ovuláció és termékenység idején párzzon. A dendritikus tövis
    (dendritic spine) plaszticitás is ciklushoz kötötten változik — a vezetékezési diagram
    tehát műanyag és hormonálisan válaszoló.
  signature: "FelnőttkoriÚjrakonfigurálás : (HormonSzint, CiklusFázis) -> PreszinaptikusKapcsolat"
  code: "FelnőttkoriÚjrakonfigurálás = Átírás (Kapcsolat) `szerint` (ÖsztrogénHullám)"
  related: [KANDEL12-001, KANDEL12-005, KANDEL12-008]
  causes: []
  caused_by: [KANDEL12-005]
  resolves: ["Felnőttkori, feladatfüggő áramkör-módosulás (dinamikus vezetékezés)"]
  tags: [neocortex, "plaszticitás", "felnőttkori-újrakonfigurálás", "dendritikus-tövis"]
```

```yaml
- id: KANDEL12-005
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Szerveződési (organizational) vs aktivációs (activational) fejlődési fázis"
  type: Definition
  idris_version: 2
  summary: >
    A nemi szteroidhormonok egy korai, kritikus ablakban visszafordíthatatlanul
    megszervezik (organize) a viselkedés idegrendszeri alapját, míg felnőtt korban
    ugyanezen hormonok hevenyben és reverzíbilisen aktiválják (activate) a nemre jellemző
    válaszokat. Ez a kétlépéses séma a maszkulinizáció gerincét adja.
  signature: "FejlődésiFázis : (KritikusAblak, HormonJelenlét) -> (Szervezett, Aktivált)"
  code: "FejlődésiFázis = Szerveződés (Korai) + Aktiváció (Felnőtt)"
  related: [KANDEL12-006, KANDEL12-004, KANDEL12-010]
  causes: [KANDEL12-006, KANDEL12-010]
  caused_by: []
  resolves: ["Visszafordíthatatlan fejlődési program és felülíró felnőttkori aktiváció szétválasztása"]
  tags: [neocortex, "kritikus-ablak", "fejlődési-fázis", "reverzibilitás"]
```

```yaml
- id: KANDEL12-006
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "A tesztoszteron aromatizációja ösztrogénné a maszkulinizációhoz"
  type: CausalRelation
  idris_version: 2
  summary: >
    A perinatális tesztoszteron-söprés nagyrészt helyi aromatizáció (aromatase enzim)
    útján ösztrogénné alakulva maszkulinitálja az agyat. Az ösztrogén (vagy tesztoszteron)
    újszülött rágcsáló nőstényeknél maszkulinizálja az agyat; felnőttkorban a tesztoszteron
    és az ösztrogén együtt facilitálja a hímre jellemző szociális interakciókat.
  signature: "Maszkulinizáció : Tesztoszteron -> (AromatizáltÖsztrogén, MaszkulintAgypálya)"
  code: "Maszkulinizáció = Aromatáz (Tesztoszteron) `eredményez` ÖsztrogénHatás"
  related: [KANDEL12-005, KANDEL12-010]
  causes: [KANDEL12-005]
  caused_by: []
  resolves: ["Hím és nőstény agyi útvonal különválásának hormonális kiváltása"]
  tags: [neocortex, "hormonális-differenciáció", "aromatizáció", "kritikus-ablak"]
```

```yaml
- id: KANDEL12-007
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Nemi dimorf viselkedések moduláris genetikai irányítása (modular genetic manner)"
  type: Pattern
  idris_version: 2
  summary: >
    Az egyes nemi hormonnal szabályozott gének csak a szexuálisan dimorf szociális
    interakciók egy részhalmazát befolyásolják, nem a teljes viselkedési programot.
    Különböző gének különböző neuronpopulációkban hatnak, így az irányítás sok különböző
    neuroncsoport között elosztott (distributed) — ez a moduláris kompozíció analóg a
    kategóriaelméleti összetétel-elvvel (egy kompozíció több független morfizmust kombinál).
  signature: "ModulárisIrányítás : (GénKészlet, NeuronPopulációKészlet) -> ElosztottViselkedés"
  code: "ModulárisIrányítás = összetétel (Gén_i `hat` Populáció_i) | i <- ViselkedésiElem"
  related: [KANDEL12-008, KANDEL12-009, KANDEL12-010]
  causes: [KANDEL12-009]
  caused_by: []
  resolves: ["Összetett viselkedés dekompozíciója független, újrahasználható modulokra"]
  tags: [neocortex, "kategoriaelmelet", "moduláris-architektúra", "elosztott-vezérlés"]
```

```yaml
- id: KANDEL12-008
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Megosztott áramkörök eltérő kulcs-neuronpopulációkkal (shared circuits, dimorphic key populations)"
  type: Pattern
  idris_version: 2
  summary: >
    A legtöbb viselkedés mindkét nemnél közös, és a szexuális dimorfizmus a közös áramkörökbe
    ágyazott kulcs-neuronpopulációk aktivitásából és kapcsolódásából ered. Ezek a populációk
    a szenzoros, motoros és közvetítő (intermediary) neuronok szintjén egyaránt előfordulnak,
    és hím- vagy nőstény-típusú irányba tolják a viselkedési kimenetet.
  signature: "MegosztottÁramkör : (KözösÚtvonal, KulcsPopuláció) -> NemreJellemzőKimenet"
  code: "MegosztottÁramkör = KözösÍv + DimorfPopuláció (Férfitípus `vagy` Nőstípus)"
  related: [KANDEL12-007, KANDEL12-009, KANDEL12-004]
  causes: [KANDEL12-009]
  caused_by: []
  resolves: ["Közös hálózaton belüli nemi specializáció (egy típus, több módosított régió)"]
  tags: [neocortex, "elosztott-vezérlés", "kulcs-populáció", "architektúra"]
```

```yaml
- id: KANDEL12-009
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Szexuálisan dimorf viselkedések elosztott (distributed) irányítása"
  type: Pattern
  idris_version: 2
  summary: >
    A dimorf viselkedések moduláris irányítása jól illeszkedik az elképzeléshez, hogy a
    legtöbb áramkör mindkét nemnél közös, és a viselkedésbeli különbségek a kulcs-populációk
    által módosított áramköri működésből adódnak. A különböző viselkedések idegi irányítása
    több, különböző neuronpopuláció között oszlik meg — nincs egyetlen, mindent irányító
    neuronpopuláció (funktor-kompozíció: a teljes tér több morfizmus képe).
  signature: "ElosztottIrányítás : ViselkedésHalmaz -> NeuronsoportHalmaz (Leképezés)"
  code: "ElosztottIrányítás = leképezés (Viselkedés_i -> Populáció_csoport_i)"
  related: [KANDEL12-007, KANDEL12-008]
  causes: []
  caused_by: [KANDEL12-007, KANDEL12-008]
  resolves: ["Központosított vezérlő helyett elosztott, robusztus irányítási topológia"]
  tags: [neocortex, "kategoriaelmelet", "elosztott-vezérlés", "robusztusság"]
```

```yaml
- id: KANDEL12-010
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Androgén-receptor az idegrendszerben (neonatális maszkulinizáció)"
  type: CausalRelation
  idris_version: 2
  summary: >
    Azok a hím egerek, amelyeknek az androgén-receptor (androgen receptor) hiányzik kizárólag
    az idegrendszerből, külsőleg ép hímeknek látszanak, de csökkent intenzitású hím-típusú
    szexuális és agresszív viselkedést mutatnak. Ez igazolja, hogy a maszkulinizáció irányítása
    az idegrendszeri androgén-receptor jelenlététől függ.
  signature: "IdegrendszeriMaszkulinizáció : AndrogénReceptorJelenlét -> HímTípusViselkedés"
  code: "IdegrendszeriMaszkulinizáció = ReceptorMeglét (NS) `határozza` ViselkedésIntenzitás"
  related: [KANDEL12-005, KANDEL12-006]
  causes: [KANDEL12-005]
  caused_by: [KANDEL12-006]
  resolves: ["Szövetspecifikus receptor-szerep izolálása a viselkedésben"]
  tags: [neocortex, "receptor", "szövetspecifikusság", "hormonális-differenciáció"]
```

```yaml
- id: KANDEL12-011
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Pheromon-észlelés emberben vs egérben (hiányzó vomeronasal szerv)"
  type: Definition
  idris_version: 2
  summary: >
    Az embernek nincs funkcionális vomeronasal szerve (vomeronasal organ, VNO), és a
    vomeronasal receptorokhoz (trpc2 stb.) kötődő gének hiányoznak vagy nem működnek a
    genomban. Az emberi feromon-észlelés (ha létezik) a fő szaglóhámon (main olfactory
    epithelium) és hagymán (olfactory bulb) keresztül történik, nem a rágcsálók VNO-útvonalán.
  signature: "EmberiFeromonÉszlelés : SzaglóHám -> (AND, EST) -> HipotalamikusAktiváció"
  code: "EmberiFeromonÉszlelés = FőSzaglóÚt (AND `vagy` EST)"
  related: [KANDEL12-003]
  causes: []
  caused_by: []
  resolves: ["Fajspecifikus érzékelési útvonal (ember: fő szagló, egér: VNO) tisztázása"]
  tags: [neocortex, "érzékelés", "szaglás", "fajspecifikusság"]
```

```yaml
- id: KANDEL12-012
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Korai tapasztalat emberi hatása: bántalmazás -> glükokortikoid-receptor promóter metilációja"
  type: CausalRelation
  idris_version: 2
  summary: >
    Posztumusz emberi vizsgálatok azt mutatják, hogy a gyermekkorban bántalmazott felnőttek
    glükokortikoid-receptor génjük promóterének nagyobb metilációját mutatják, mint a
    kontrollcsoport. Az árvaházban, kevés egyéni gondozásban nevelkedett gyerekek alacsonyabb
    oxitocin- és vazopresszin-szintet mutatnak évekkel a nevelőszülőhöz kerülés után is.
  signature: "KoraiBántalmazás : GyermekkoriTrauma -> PromóterMetiláció (ReceptorGén)"
  code: "KoraiBántalmazás = NöveltMetiláció (GRPromóter) `csökkenti` OxitocinSzint"
  related: [KANDEL12-001, KANDEL12-002, KANDEL12-003]
  causes: [KANDEL12-001]
  caused_by: [KANDEL12-002]
  resolves: ["Élethosszig tartó szülői gondozás biológiai mechanizmusának emberi nyomainak megadása"]
  tags: [neocortex, "epigenetika", "emberi-megfeleltetés", "fenotípus-tartósság"]
```

```yaml
- id: KANDEL12-013
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "BNST szexuális dimorfizmusa és kapcsolata a nemi identitással"
  type: Example
  idris_version: 2
  summary: >
    Az emberi stria terminalis térbeli magja (bed nucleus of the stria terminalis, BNST)
    szignifikánsan több idegsejtet tartalmaz férfiakban, mint nőkben; a nővé változtatott
    (male-to-female) transzszexuálisok BNST-je kisebb, a férfivá változtatottaké nagyobb.
    A patkány megfelelője a másik nem felismerésében játszik szerepet — az emberi BNST így
    a nemi identitáshoz kötődő, de szexuális irányultságtól független struktúra.
  signature: "BNSTDimorfizmus : BiológiaiNem -> IdegsejtSzám (Férfi > Nő)"
  code: "BNSTDimorfizmus = Neuronszám (Férfi) `>szám` Neuronszám (Nő)"
  related: [KANDEL12-008, KANDEL12-011]
  causes: []
  caused_by: []
  resolves: ["Szerkezeti dimorfizmus összekötése a nemi identitással (ok-okozat még nyitott)"]
  tags: [neocortex, "szerkezeti-dimorfizmus", "nemi-identitás", "BNST"]
```

```yaml
- id: KANDEL12-014
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 51: Sexual Differentiation of the Nervous System"
  concept: "Közös sejtszintű mechanizmusok: apoptózis, neuritakiterjedés, szinapszis-képződés"
  type: Pattern
  idris_version: 2
  summary: >
    A nemi hormonok a neurális útvonalak szexuális differenciációját olyan sejtes folyamatokkal
    végzik, amelyeket más fejlődési eseményeknél is széles körben használnak: apoptózis
    (sejthalál), neuritakiterjedés (neurite extension) és szinapszis-képződés (synapse formation).
    Ezek a mechanizmusok hozzák létre a neuronok számának, kapcsolódásának és élettani
    tulajdonságainak nemi különbségeit.
  signature: "SejtszintűDifferenciáció : Hormon -> (Apoptózis, NeuritaKiterjedés, Szinapszis)"
  code: "SejtszintűDifferenciáció = halmaz (Apoptózis, NeuritaKiterjedés, Szinapszis)"
  related: [KANDEL12-005, KANDEL12-008, KANDEL12-004]
  causes: [KANDEL12-008]
  caused_by: [KANDEL12-005]
  resolves: ["Újrahasznált építőkövek: a fejlődés közös eszköztára hozza létre a dimorfizmust"]
  tags: [neocortex, "fejlődési-mechanizmus", "újrahasználat", "architektúra"]
```
