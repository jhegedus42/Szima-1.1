# Kandel — Principles of Neural Science (6th ed.) — Kinyerés / Extraction
# Forrás chunk: kandel_chunk_08.txt (Chapter 33: Locomotion; Chapter 34 eleje: Voluntary Movement)
# Séma: book_processor.md ConceptNote YAML.
# Minden azonosító magyar (AGENTS.md §0), rövidítés nincs. Idris 2 aláírások.

---

## Fogalomjegyzetek / ConceptNotes

```yaml
- id: KANDEL08-001
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "Központi minta-generáló hálózat (Central Pattern Generator, CPG)"
  type: Definition
  idris_version: 2
  summary: >
    A gerincvelő elszigetelve a lefelé irányuló (supraspinalis) és a perifériás
    ritmikus afferens bemenetektől is képes összetett, az ép állatnál megfigyelhető
    ritmusokat és mintázatokat tartalmazó mozgásprogramot (lokomóciót) előállítani.
    Ezekért a hálózatokért felelős áramköröket központi minta-generálóknak nevezzük.
  signature: "KözpontiMintaGeneralo : GerincveloiHalozat"
  code: "KözpontiMintaGeneralo = RitmusGeneraloRéteg + MintázatGeneraloRéteg"
  related: [KANDEL08-002, KANDEL08-003, KANDEL08-018]
  causes: [KANDEL08-004]
  caused_by: []
  resolves: ["A lokomóció alapritmusának előállítása lefelé irányuló parancs nélkül is"]
  tags: [neocortex, "moduláris-architektúra", "elosztott-vezérlés", "CPG"]
```

```yaml
- id: KANDEL08-002
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "CPG kétrétegű moduláris felépítése: ritmus- és mintázat-generálás"
  type: Pattern
  idris_version: 2
  summary: >
    A gerincvelői lokomóciós hálózatok ritmus-generáló áramkörökre (flexor és
    extensor ritmus-neuronok) és egy mintázat-generáló rétegre tagolódnak. A
    ritmus-generálók hajtják a megfelelő izmokat, a mintázat-réteg alakítja ki az
    antagonista (hajlító/feszítő) váltakozást és a bal-jobb koordinációt.
  signature: "LokomociosHalozat : (RitmusGeneralo, MintazatGeneralo) -> LepesCiklus"
  code: "LokomociosHalozat = RitmusGeneralo + MintazatGeneralo"
  related: [KANDEL08-001, KANDEL08-003, KANDEL08-008]
  causes: [KANDEL08-004]
  caused_by: []
  resolves: ["Antagonista izmok időzített váltakozásának és bal-jobb koordinációjának biztosítása"]
  tags: [neocortex, "moduláris-architektúra", "rétegezett-vezérlés", "CPG"]
```

```yaml
- id: KANDEL08-003
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "Kölcsönös gátlás (reciprocal inhibition) a flexor/extensor váltakozásban"
  type: Pattern
  idris_version: 2
  summary: >
    A ritmus-generáló flexor és extensor neuronok kölcsönösen gátló (inhibitory)
    interneuronokon keresztül kapcsolódnak össze, ami félközpontos oszcillátorként
    (half-center oscillator) működteti az antagonista izmok alternálását.
  signature: "KolcsönösGátlás : (FlexorRitmus, ExtensorRitmus) -> VáltakozóAktivitás"
  code: "KolcsönösGátlás = GátlóInterneuron Flexor_extensor"
  related: [KANDEL08-002, KANDEL08-017]
  causes: []
  caused_by: []
  resolves: ["Antagonista izomcsoportok időben elkülönült aktiválása (fázis-kizárás)"]
  tags: [neocortex, "oszcilláció", "gátlás", "CPG"]
```

```yaml
- id: KANDEL08-004
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "Szomatoszenzoros visszacsatolás modulálja a CPG működését"
  type: CausalRelation
  idris_version: 2
  summary: >
    Bár a CPG önmagában is előállítja a lépés pontos időzítését, a központi mintát
    normálisan a mozgó végtagokból érkező szenzoros jelek modulálják. Kétféle
    bemenet hat: a végtag aktív mozgása által generált proprioceptív és a környezeti
    akadálytal való találkozáskor keletkező taktilis információ.
  signature: "SzenzorosModuláció : (CPG, PerifériásBemenet) -> MódosítottLokomóció"
  code: "SzenzorosModuláció = ProprioceptívBemenet + TaktilisBemenet"
  related: [KANDEL08-001, KANDEL08-005, KANDEL08-018]
  causes: [KANDEL08-005]
  caused_by: [KANDEL08-001]
  resolves: ["A centrális program környezethez és terheléshez való adaptálása"]
  tags: [neocortex, "visszacsatolás", "szenzoros-adaptáció", "CPG"]
```

```yaml
- id: KANDEL08-005
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "Propriocepció szabályozza a lépés időzítését és amplitúdóját"
  type: CausalRelation
  idris_version: 2
  summary: >
    A mozgó végtagokból származó proprioceptív jel (izomorsók a csípőben, Golgi
    ínorszervek a bokában) jelzi a stance (támasz) fázis végét és váltja ki a swing
    (lengés) fázis indítását. A csípő kinyújtása entrainálja a ritmust: a csípőizmok
    nyújtása a motoros kimenet időzítését az külsőleg kényszerített mozgáshoz igazítja.
  signature: "ProprioceptívSzabályozás : (CsípőKinyújtás, IzomOrsó) -> FázisVáltás"
  code: "ProprioceptívSzabályozás = JelziTámaszFázisVége -> IndítjaLengésFázis"
  related: [KANDEL08-004, KANDEL08-017]
  causes: []
  caused_by: [KANDEL08-004]
  resolves: ["Stance→swing fázisátmenet stabilizálása a terhelés lecsökkenésekor"]
  tags: [neocortex, "propriocepció", "fázis-átmenet", "visszacsatolás"]
```

```yaml
- id: KANDEL08-006
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "Fázisfüggő reflex-megfordulás (phase-dependent reflex reversal)"
  type: Pattern
  idris_version: 2
  summary: >
    Ugyanaz a szenzoros inger eltérő választ vált ki a lépésciklus különböző fázisaiban:
    a bokafeszítőkből érkező csoport-I afferens stimulus a lengés fázisában gátolja a
    flexort, de a támasz fázisában az extensorokat erősíti (a reflex előjelének
    megfordulása). Ez megakadályozza az állat összeomlását a támasz fázisában.
  signature: "FázisfüggőReflex : (Inger, LépesFázis) -> FázisSpecifikusVálasz"
  code: "FázisfüggőReflex = UgyanazInger `különböző` Fázis -> EllenkezőElőjelűVálasz"
  related: [KANDEL08-004, KANDEL08-005]
  causes: []
  caused_by: [KANDEL08-004]
  resolves: ["Kontextusfüggő (fázisspecifikus) motorválasz azonos ingerre"]
  tags: [neocortex, "kontextusfüggő-feldolgozás", "reflex-megfordulás", "visszacsatolás"]
```

```yaml
- id: KANDEL08-007
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33, Box 33-2"
  concept: "Ioncsatornák hozzájárulása a CPG ritmus- és mintázat-generáláshoz"
  type: Pattern
  idris_version: 2
  summary: >
    A neuronmembrán tulajdonságai (bursting, plateau potenciál) intrinsic vagy
    neurotranszmitter-függő módon erősítik a ritmikusságot. Különböző feszültségfüggő
    csatornák (tranzitórikus alacsony küszöbű Ca2+, HCN, tranzitórikus K+) szabályozzák
    a fázisátmeneteket és a tüzelési rátát; az NMDA-receptorok által kiváltott bursting
    és az L-típusú Ca2+ csatornák által mediált plateau tulajdonságok a ritmusgenerálást
    segítik.
  signature: "MembránTulajdonság : (IonCsatorna, Neurotranszmitter) -> RitmikusKimenet"
  code: "MembránTulajdonság = Bursting + Plateau + FeszültségfüggőCsatorna"
  related: [KANDEL08-001, KANDEL08-002]
  causes: []
  caused_by: []
  resolves: ["Sejtszintű oszcilláció és a szinaptikus bemenetek nélküli fenntartás"]
  tags: [neocortex, "ioncsatorna", "bursting", "plató-potenciál", "oszcilláció"]
```

```yaml
- id: KANDEL08-008
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33, Box 33-3"
  concept: "Fejlődési molekuláris kódok határozzák meg a gerincvelői neuronok azonosságát"
  type: Definition
  idris_version: 2
  summary: >
    A gerincvelői interneuronok és motorneuronok azonosságát transzkripciós faktorok
    (pl. Islt1/Tlx3, Pax2/7, Chx10, Hb9, Evx1) genetikai kódja határozza meg; minden
    neuronosztály saját transzmittertartalommal és jellegzetes axonvetület-mintázattal
    rendelkezik. Ez a molekuláris kód teszi lehetővé az adott típusok sejt-specifikus
    aktiválását/inaktiválását.
  signature: "MolekulárisKód : TranszkripciósFaktor -> NeuronAzonosság"
  code: "MolekulárisKód = TranszkripciósFaktor `határozzaMeg` NeuronTípus"
  related: [KANDEL08-002, KANDEL08-009]
  causes: []
  caused_by: []
  resolves: ["A lokomóciós hálózat neuronjainak típus-specifikus azonosítása és manipulálhatósága"]
  tags: [neocortex, "molekuláris-kód", "fejlődési-azonosság", "tipizált-neuron"]
```

```yaml
- id: KANDEL08-009
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "Középagyi mozgásközpont (Mesencephalic Locomotor Region, MLR) indítja a lokomóciót"
  type: CausalRelation
  idris_version: 2
  summary: >
    A gerincvelői lokomóciós hálózatok működésének indításához és fenntartásához
    supraspinalis parancsra van szükség. A fő szerkezet a középagyi MLR, amely két
    magból áll: a cuneiformis magból (CNF, glutamaterg) és a pedunculopontinus magból
    (PPN, glutamaterg és kolinerg). A PPN/CNF glutamaterg neuronok az induláshoz és a
    lassú (járás, ügetés) tempóhoz elegendők; a CNF glutamaterg neuronok szükségesek a
    gyors (vágtatás, ugrás) menekülés-jellegű mozgáshoz.
  signature: "LokomócióIndítás : (MLR, StimulációsFrekvencia) -> GaitVálasztás"
  code: "LokomócióIndítás = MLR `küld` Parancs -> GerincveloiCPG"
  related: [KANDEL08-001, KANDEL08-008, KANDEL08-011]
  causes: [KANDEL08-011]
  caused_by: []
  resolves: ["A lokomóció önkéntes indítása, sebesség- és gait-szabályozása"]
  tags: [neocortex, "parancs-jel", "supraspinalis-vezérlés", "MLR", "sebesség-szabályzás"]
```

```yaml
- id: KANDEL08-010
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "Agytörzsi magvak szabályozzák a testtartást lokomóció közben"
  type: CausalRelation
  idris_version: 2
  summary: >
    A vestibulospinalis (VST) és reticulospinalis (RST) lefelé irányuló pályák, valamint
    a rubrospinalis pálya a testtartásért, az egyensúlyért és a négy végtag koordinációjáért
    felelnek. Ezen magvak (LVN, PMRF, nucleus ruber) aktivitása a lépésciklus frekvenciáján
    fázikusan modulált, és fázisfüggő módon változtatják az izomtónust.
  signature: "TesttartásSzabályozás : (AgytörzsiPálya, LépesFázis) -> IzomTónus"
  code: "TesttartásSzabályozás = VST + RST + Rubrospinalis"
  related: [KANDEL08-009, KANDEL08-012]
  causes: []
  caused_by: [KANDEL08-009]
  resolves: ["Súlytartás, egyensúly és interlimb koordináció a lokomóció alatt"]
  tags: [neocortex, "testtartás", "agytörzsi-vezérlés", "lefelé-irányuló-pálya"]
```

```yaml
- id: KANDEL08-011
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "A kisagy (cerebellum) korrigálja a motoros hibákat és a lefelé irányuló jeleket"
  type: Pattern
  idris_version: 2
  summary: >
    A kisagy a gerincvelőbe küldött motoros parancsok és a tényleges mozgás összehasonlítása
    alapján javítja a mozgást. A centrális efferens másolat (efference copy), a mozgás
    afferens másolata (DSCT via spinocerebellaris pálya) és a gerincvelői hálózat állapota
    (VSCT via CPG-interneuronok) a kisagyban integrálódik, és Purkinje-sejtek ritmikus
    kisülésének megváltoztatásával modulálja a lefelé irányuló jeleket.
  signature: "KisagyKorrekció : (EfferensMásolat, AfferensMásolat, SPIÁllapot) -> MotorosHibaJavítás"
  code: "KisagyKorrekció = Összehasonlít MotorParancs `és` Mozgás -> Javít LefeléIrányulóJelet"
  related: [KANDEL08-009, KANDEL08-010, KANDEL08-012]
  causes: []
  caused_by: []
  resolves: ["Motoros hibák valós idejű korrekciója és a gait adaptációja"]
  tags: [neocortex, "efferens-másolat", "hiba-korrekció", "visszacsatolás", "kisagy"]
```

```yaml
- id: KANDEL08-012
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "A bazális ganglionok módosítják a kéregi és agytörzsi áramköröket; Parkinson-kór"
  type: CausalRelation
  idris_version: 2
  summary: >
    A bazális ganglionok (minden gerincesben jelen vannak) a különböző motoros mintázatok
    kiválasztásában vesznek részt. A PPN-be küldött gátló (SNr, GPi GABAerg) és serkentő
    (STN glutamaterg) bemenetek szabályozzák a PPN aktivitását. A Parkinson-kórban a
    substantia nigra dopaminerg bemenetének pusztulása megzavarja ezt, lassú, csoszogó
    járást és gait-freezinget okozva.
  signature: "BazálisGanglionSzabályozás : (SNrGátlás, STNSerkentés) -> PPN Aktivitás"
  code: "BazálisGanglionSzabályozás = DopaminergBemenet `romlása` -> ParkinsonJárásZavar"
  related: [KANDEL08-009, KANDEL08-011, KANDEL08-013]
  causes: []
  caused_by: [KANDEL08-009]
  resolves: ["Motoros mintázatok kiválasztása; a deficit példája: Parkinson-kór gait-zavar"]
  tags: [neocortex, "bazális-ganglion", "Parkinson", "motoros-mintázat-kiválasztás", "betegség"]
```

```yaml
- id: KANDEL08-013
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "A motoros kéreg biztosítja a vizuálisan vezérelt precíz lépést"
  type: CausalRelation
  idris_version: 2
  summary: >
    A járás legtöbbször vizuálisan vezérelt; a motoros kéreg elengedhetetlen a precíz
    (visuomotoros koordinációt igénylő) lokomócióhoz, pl. akadály feletti lépésnél. A
    kéregi corticospinalis neuronok közvetlenül a gerincvelői CPG-interneuronokat szabályozzák,
    és rövid ingertréninggel fázisfüggő módon, sőt a ritmus újraindításával (reset) is beavatkoznak.
  signature: "VizuálisLokomóció : (MotorosKéreg, CPG) -> FázisFüggőMódosítás"
  code: "VizuálisLokomóció = MotorosKéreg `integrálódik` CPG-RitmusGeneráló"
  related: [KANDEL08-001, KANDEL08-012, KANDEL08-014]
  causes: []
  caused_by: [KANDEL08-009]
  resolves: ["Vizuálisan vezérelt anticipatív gait-módosítások végrehajtása"]
  tags: [neocortex, "motoros-kéreg", "vizuális-vezérlés", "corticospinalis", "CPG"]
```

```yaml
- id: KANDEL08-014
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "A poszterior parietális kéreg (PPC) tervezi a lokomóciót és munkamemóriát használ"
  type: Pattern
  idris_version: 2
  summary: >
    A PPC két-három lépéssel az akadály elérése előtt növeli aktivitását, becsüli a test
    helyzetét a környezeti tárgyakhoz képest (limb state–object coupling), és a tárgy
    méretét/helyzetét munkamemóriában tárolja, hogy a hátsó végtagok koordinált lépését
    is lehetővé tegye, amikor az már nincs a látótérben. A premotoros kéreg és a bazális
    ganglionok hálózatával együtt működik.
  signature: "PPCTervezés : (TárgyHelyzet, Munkamemória) -> GaitMódosításTerv"
  code: "PPCTervezés = BecslésTestTárgyViszony `tárol` Munkamemória"
  related: [KANDEL08-013, KANDEL08-012]
  causes: []
  caused_by: []
  resolves: ["Előrelátó (anticipatív) gait-tervezés és hátsó végtagok koordinációja"]
  tags: [neocortex, "PPC", "munkamemória", "tervezés", "parietális-kéreg"]
```

```yaml
- id: KANDEL08-015
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "Számítógépes (computational) modellezés tárja fel a lokomóciós áramkörök dinamikáját"
  type: Pattern
  idris_version: 2
  summary: >
    A funkcionális vizsgálatok mellett a computacionális hálózati modellezés lehetővé
    teszi az áramkör aktivitásának szimulációját és a sejt- valamint szinaptikus tulajdonságok
    dinamikus kölcsönhatásainak vizsgálatát több szinten (ionos alap, kapcsolódás, struktúrák
    közötti interakció). Az kísérleti manipuláció és a modellezés kombinációja növeli a
    megértést.
  signature: "SzámításiModell : (SejtTulajdonság, SzinaptikusKapcsolat) -> DinamikusIntegráció"
  code: "SzámításiModell = Szimulál Áramkör `vizsgál` DinamikusKölcsönhatás"
  related: [KANDEL08-001, KANDEL08-007, KANDEL08-016]
  causes: []
  caused_by: []
  resolves: ["A komplex lokomóciós hálózat integratív működésének leírása és előrejelzése"]
  tags: [neocortex, "computational-neuroscience", "dinamikus-modell", "szimuláció"]
```

```yaml
- id: KANDEL08-016
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 34: Voluntary Movement (intro)"
  concept: "Optimális visszacsatolásos vezérlés vs. reprezentációs modell a mozgásirányításban"
  type: Pattern
  idris_version: 2
  summary: >
    A szenzomotoros transzformációs (reprezentációs) modell szerint a kéreg a mozgás
    paramétereit kódolja; korlátai vannak (fizikai, nem fiziológiai koordinátarendszerek,
    merev soros számítás). Ezzel szemben az optimális visszacsatolásos vezérlés (optimal
    feedback control) három folyamatot különít el: állapotbecslés (efferens másolattal),
    feladatkiválasztás és vezérlési szabályzat (control policy) — a mozgás dinamikusan,
    valós időben jön létre a visszacsatolási erősítések fázis- és kontextusfüggő állításával.
  signature: "OptimálisVezérlés : (ÁllapotBecsles, FeladatKiválasztás, VezérlésiSzabályzat) -> MotorosParancs"
  code: "OptimálisVezérlés = DinamikusRendszer `nem` TisztánSorosReprezentáció"
  related: [KANDEL08-015, KANDEL08-011, KANDEL08-013]
  causes: []
  caused_by: []
  resolves: ["A variábilis, de sikeres emberi mozgásteljesítmény magyarázata dinamikus vezérléssel"]
  tags: [neocortex, "optimális-vezérlés", "dynamical-model", "szenzomotoros-transzformáció", "AI-architektúra"]
```

```yaml
- id: KANDEL08-017
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "Bőr mechanoreceptorai (köztük nociceptorok) teszik lehetővé az akadályhoz igazítást"
  type: CausalRelation
  idris_version: 2
  summary: >
    A bőr mechanoreceptorai, különösen a talp dorsalis felszínének érintésekor, erős hatással
    vannak a CPG-re: a lengés fázisában flexor serkentést és extensor gátlást váltanak ki
    (gyors elhúzódás az inger elől), míg a támasz fázisában extensor serkentést (a menekülés
    helyett a támasz megtartása). Ez a fázisfüggő reflex-megfordulás egyik példája.
  signature: "BőrReceptorVálasz : ( MechanoreceptorInger, LépesFázis) -> FlexorVagyExtensorVálasz"
  code: "BőrReceptorVálasz = LengésFázis `->` FlexorSerkentés + ExtensorGátlás"
  related: [KANDEL08-004, KANDEL08-006]
  causes: []
  caused_by: [KANDEL08-004]
  resolves: ["Váratlan akadályokhoz való lépésmódosítás (helyesbítő reakció)"]
  tags: [neocortex, "mechanoreceptor", "akadály-elkerülés", "fázisfüggő-reflex"]
```

```yaml
- id: KANDEL08-018
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33: Locomotion"
  concept: "Az emberi lokomóció idegi szabályozása hasonló a négylábúakéhoz; emberi CPG létezése"
  type: Definition
  idris_version: 2
  summary: >
    Bár a legtöbb ismeret négylábú állatokból származik, az emberi lokomóció ugyanazokon
    az elveken alapul. Az emberi gerincvelői CPG létezését több megfigyelés támasztja alá:
    gerincsérültek spontán ritmikus lábmozgása, újszülöttek születés utáni ritmikus lépése,
    és az anenkefália (agyfélteke nélkül születettek) esetei, amelyek a híd alatti, talán
    teljesen gerincvelői helyzetű áramkörökre utalnak.
  signature: "EmberiCPG : GerincvelőiÁramkör (Ember)"
  code: "EmberiCPG = Veleszületett `és` Gerincvelői `is` (agyfélteke nélkül is működik)"
  related: [KANDEL08-001, KANDEL08-004, KANDEL08-019]
  causes: []
  caused_by: []
  resolves: ["A CPG-elmélet általános érvényessége az emberi lokomócióban is"]
  tags: [neocortex, "emberi-CPG", "veleszületett-áramkör", "lokomóció"]
```

```yaml
- id: KANDEL08-019
  source: "Principles of Neural Science (6th ed.), Kandel et al. — Chapter 33, Box 33-4"
  concept: "Rehabilitációs tréning (treadmill + testtömeg-támasz) javítja a járást gerincsérülés után"
  type: Example
  idris_version: 2
  summary: >
    Részleges gerincsérülés esetén a preferált kezelés a rehabilitációs tréning. A
    testtömeg-támasztott futószalagos (weight-supported treadmill) lépéstréning a gerincvelői
    áramkörok plaszticitásán és a megmaradt lefelé irányuló pályákon átvihető parancsjeleken
    alapul; a funkcionális javulás 44 krónikus betegben 3–20 hét után kimutatható volt.
  signature: "RehabTréning : (Futószalag, TesttömegTámasz) -> JavultLokomóció"
  code: "RehabTréning = SzinapszisPlaszticitás `és` MaradtParancsJel -> FunkcionálisJavulás"
  related: [KANDEL08-018, KANDEL08-015]
  causes: []
  caused_by: [KANDEL08-018]
  resolves: ["A gerincsérülés utáni funkcionális járás-helyreállítás (bizonyított példa)"]
  tags: [neocortex, "rehabilitáció", "szinapszis-plaszticitás", "gerincsérülés", "betegség"]
```

---

## Összefüggő kapcsolatok (gráf vázlat / relation sketch)

- KANDEL08-001 (CPG) → vezérli → KANDEL08-002 (két réteg) → használja → KANDEL08-003 (kölcsönös gátlás)
- KANDEL08-004 (szenzoros visszacsatolás) → modulálja → KANDEL08-001, okozza → KANDEL08-005, KANDEL08-017
- KANDEL08-009 (MLR indítás) → parancsot küld → KANDEL08-001; táplálja → KANDEL08-010, KANDEL08-011
- KANDEL08-012 (bazális ganglion / Parkinson) → módosítja → KANDEL08-009
- KANDEL08-015 (computational modell) ↔ támogatja → KANDEL08-016 (optimális vezérlés)
- KANDEL08-018 (emberi CPG) → példázza → KANDEL08-019 (rehabilitáció)

## Híd a Szima-projekt felé (neocortex-szerű AI architektúra)

Ez a fejezet a *lokomóciós* vezérlésről szól, de több mechanizmusa közvetlenül
érdekes egy neocortex-szerű architektúra számára:
1. **Moduláris, rétegezett, elosztott minta-generálás** (KANDEL08-001/002/003):
   a CPG nem egyetlen "vezérlő", hanem ritmus- és mintázat-rétegekből álló,
   antagonista félközpontos oszcillátorokból felépülő elosztott rendszer — ez a
   "nincs központi irányító, csak kompozíció" elv a projekt északi csillagával
   (Idris, függő típusok, kompozíció) rokon.
2. **Dinamikus, visszacsatolás-alapú vezérlés reprezentáció helyett** (KANDEL08-016,
   KANDEL08-011): az optimális visszacsatolásos vezérlés és az efferens-másolat
   alapú hibakorrekció a kategóriaelméleti "morfolizmus, nem izomorfizmus"
   rétegmodell (AGENTS.md §9) szellemi rokona — a vezérlés folyamat, nem tárolt
   paraméter.
3. **Fázis-/kontextusfüggő feldolgozás** (KANDEL08-006): ugyanaz az inger
   ellentétes választ ad a ciklusfázistól függően — ez a "CPT" (forrás/szemlélet/
   igeidő) rétegmodell biológiai analógja lehet.

E8 és kategoriaelmelet kifejezett címkézése *csak* a fenti, valódi fogalmi híd
esetén történt (neocortex címke); közvetlen E8- vagy kategoriaelmelet-megfelelőt
ez a fejezet nem tartalmaz, ezért azokat nem címkéztem.
