# Kandel – Kivonat (Chunk 10 / 41. fejezet: A hipotalamusz)

Forrás: Kandel et al. — *Principles of Neural Science* (6. kiadás), 41. fejezet:
The Hypothalamus: Autonomic, Hormonal, and Behavioral Control of Survival.
A chunk az energiaegyensúly (éhség, jóllakottság), a leptin/insulin jelzés, az
AgRP/POMC/MC4R neuronhurok, a motivációs hajtóerők (incentive motivation vs.
drive reduction), valamint a szexuálisan dimorf és szülői viselkedést irányító
hipotalamikus régiók mechanizmusait tárgyalja. Az alábbi ConceptNote-ok ezeket
a mechanizmusokat vonják ki mint a neokortex-szerű architektúra lehetséges
építőköveit (afferens/efferens hurok, modalitás-specifikus leképezés,
jutalom–észlelés-útvonal).

Szabály: „E8" / „neocortex" / „kategoriaelmelet" címke CSAK akkor, ha valódi
fogalmi híd létezik. Ebben a fejezetben **E8 valódi híd nem azonosítható** (a
hipotalamusz-homeosztázis-biológiában nincs E8 kivételes csoport szimmetria);
az E8 címke ezért szándékosan NINCS használva. A „neocortex" címke azokon a
note-okon szerepel, ahol a homeosztázis→jutalom/észlelés útvonal valóban a
kéregbe (cortex) és nucleus accumbensbe fut (a „nagy rejtély" szakasz). A
„kategoriaelmelet" címke a modalitás-specifikus neuronok interoceptív
bemenet→adaptív kimenet leképezésénél (funktor-szerű afferent/efferent
hozzárendelés) és a hurok-szabályozásnál állja meg a helyét.

---

```yaml
id: kandel41-leptin-fat-signal
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: A zsírsejt-hormon leptin a zsírraktárakról jelzést ad az agynak
type: CausalRelation
idris_version: 2
summary: >
  A leptinot a zsírsejtek (adipociták) a zsírraktárak nagyságával arányosan
  választják el; alacsony szintje azt jelzi az agynak, hogy a raktárak
  elégtelenek, ami éhséget és csökkent energiafelhasználást vált ki. Alacsony
  leptin erősen védi az alacsony raktárak ellen, magas szintje gyenge hatású
  az elhízás ellen.
signature: "leptinJelzes : ZsirRaktar -> AgyAllapot"
code: |
  -- A leptin dinamikus tartománya: alacsony = veszély, magas = gyenge védelem
  data LeptinJelzes = Alacsony ZsirRaktar | Elegseges ZsirRaktar | TobbMintElegseges ZsirRaktar
  erzekenyseg : LeptinJelzes -> (EhsegVisszaszoritva : Bool)
  erzekenyseg (Alacsony _) = False   -- alacsony szint NEM szorítja vissza az éhséget
  erzekenyseg (Elegseges _) = True
  erzekenyseg (TobbMintElegseges _) = True  -- de a hatás aszimmetrikus (l. energia-egyensuly-aszimmetria)
causes: [kandel41-leptin-activates-pomc-inhibits-agrp, kandel41-energy-balance-asymmetry]
caused_by: [zsirraktar-meret]
resolves: [hogy_az_agy_tudja_a_zsirraktarak_allapotat]
tags: [hypothalamus, energy-balance, leptin, homeostatic]
```

```yaml
id: kandel41-pomc-agrp-mc4r-loop
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: Az arcuatus mag POMC és AgRP neuronpopulációinak antagonisztikus hurka
type: Pattern
idris_version: 2
summary: >
  Az arcuatus magban két ellentétes populáció szabályozza az energiaegyensúlyt:
  a POMC-neuronok csökkentik az éhséget és fokozzák a szimpatikus energia-
  fogyasztást, az AgRP-neuronok az ellenkezőjét teszik. A POMC az αMSH
  peptidet választja el, amely az MC4R receptort aktiválja; az AgRP inverz
  agonista, GABA-val és NPY-vel gátolja ugyanazt a célpopulációt.
signature: "antagonistaHurok : (PomcNeuron, AgrpNeuron) -> EnerigaeaEgyensuly"
code: |
  -- Két ellentétes afferencia egyetlen célra (PVH-MC4R jóllakottság-neuron)
  data ArcuatusPopulacio = PomcNeuron | AgrpNeuron
  hatas : ArcuatusPopulacio -> PVHMc4rNeuron -> PVHMc4rNeuron
  hatas PomcNeuron  c = aktivál c    -- jóllakottság
  hatas AgrpNeuron  c = gátol  c     -- éhség
causes: [kandel41-leptin-activates-pomc-inhibits-agrp]
caused_by: [kandel41-leptin-fat-signal, kandel41-short-long-term-signals]
resolves: [hogy_egy_szabalyozhato_afferens-efferens_hurok_iranyitja_az_evast]
tags: [neocortex, hypothalamus, energy-balance, feedback-loop, control]
```

```yaml
id: kandel41-leptin-activates-pomc-inhibits-agrp
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: A leptin a POMC-neuronokat aktiválja és az AgRP-neuronokat gátolja
type: CausalRelation
idris_version: 2
summary: >
  A leptin részben úgy szabályozza az éhséget és az energiafelhasználást, hogy
  aktiválja a jóllakottságot elősegítő POMC-neuronokat és gátolja az éhséget
  elősegítő AgRP-neuronokat. Az éhséget elősegítő AgRP-neuronokat emellett a
  jövőbeli energiaegyensúly-változást előrejelző ingerek (feedforward) is
  gyorsan szabályozzák.
signature: "leptinHatrozas : LeptinJelzes -> (ArcuatusPopulacio -> Allapot)"
code: |
  -- Leptin hatása a két antagonista populációra
  leptinHatrozas : LeptinJelzes -> ArcuatusPopulacio -> Allapot
  leptinHatrozas (Elegseges _) PomcNeuron = Aktiv
  leptinHatrozas (Elegseges _) AgrpNeuron = Gátolt
  leptinHatrozas (Alacsony _)    PomcNeuron = Gátolt
  leptinHatrozas (Alacsony _)    AgrpNeuron = Aktiv
causes: [kandel41-energy-balance-asymmetry]
caused_by: [kandel41-leptin-fat-signal]
resolves: [hogy_a_zsirraktar-jelzes_kozvetlenul_modulalja_a_ket_neuronpopulaciot]
tags: [hypothalamus, leptin, pomc, agrp, energy-balance]
```

```yaml
id: kandel41-energy-balance-asymmetry
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: Az energiaegyensúly védelme aszimmetrikus (erős a alacsony, gyenge a magas raktárak ellen)
type: Rule
idris_version: 2
summary: >
  A védekezés az alacsony zsírraktárak ellen erős, a magas raktárak (elhízás)
  ellen gyenge. Ennek következménye, hogy az elhízott egyéneknek nincs
  leptin-rezisztenciájuk, csupán a leptin-szintjük meghaladja a maximálisan
  hatékony koncentrációt. A rendszer aszimmetrikus szabályozási célja a túlélés.
signature: "vedelmiAszimmetria : ZsirRaktarIrany -> VedelemErosseg"
code: |
  -- Aszimmetrikus védelem: alacsony raktár -> erős védelem, magas -> gyenge
  data ZsirRaktarIrany = Alacsony | Magas
  data VedelemErosseg = Erős | Gyenge
  vedelmiAszimmetria : ZsirRaktarIrany -> VedelemErosseg
  vedelmiAszimmetria Alacsony = Erős
  vedelmiAszimmetria Magas    = Gyenge
causes: [kandel41-leptin-fat-signal]
caused_by: [tulelesi-nyomas]
resolves: [miert_nem_ved_a_rendszer_hatekonyan_az_elhizas_ellen]
tags: [hypothalamus, energy-balance, rule, homeostatic]
```

```yaml
id: kandel41-short-long-term-signals
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: Rövid távú és hosszú távú visszacsatoló jelek az energiaegyensúlyban
type: Pattern
idris_version: 2
summary: >
  Az energiaegyensúlyt rövid távú (étkezés közbeni, pl. CCK, GLP-1, PYY a
  belekből, valamint ghrelin a gyomorból) és hosszú távú (zsírraktárakat
  jelző leptin és insulin) humorális jelek szabályozzák. A rövid távú jelek a
  lakoma (meal) megszakítását (satiation), a hosszú távúak az energiaegyensúlyt
  vezérlik.
signature: "energiaJel : IdőSkála -> HumoralisJel"
code: |
  data IdőSkála = RövidTávú | HosszúTávú
  data HumoralisJel
    = CCK | GLP1 | PYY | Ghrelin         -- rövid távú
    | Leptin | Inzulin                    -- hosszú távú
  energiaJel : IdőSkála -> List HumoralisJel
  energiaJel RövidTávú = [CCK, GLP1, PYY, Ghrelin]
  energiaJel HosszúTávú = [Leptin, Inzulin]
causes: [kandel41-pomc-agrp-mc4r-loop]
caused_by: [bel-endokrin-sejtek, zsirsejtek, hasnyalmirigy]
resolves: [hogy_kulonbozo_idoskaliak_kulonbozo_szabalyozasi_feladatot_latnak_el]
tags: [hypothalamus, energy-balance, feedback-loop, signal]
```

```yaml
id: kandel41-agrp-feedforward-environment
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: Az AgRP éhség-neuronok feedforward (fentről-lefelé) környezeti információt is kapnak
type: Pattern
idris_version: 2
summary: >
  Az éhséget elősegítő AgRP-neuronok nemcsak erős alulról-felfelé (bottom-up)
  testi visszacsatolást kapnak, hanem a környezet által előre jelzett
  ingerektől is feedforward módon szabályozódnak (pl. élelem megjelenése
  egyedül, fogyasztás nélkül, csökkenti az AgRP-tüzelést). Ez az anticipációs
  jelzés korlátozhatja a jövőbeli túlzott kalóriabevitelt vagy jutalomjelzésként
  motiválhatja az evést.
signature: "agrpSzabalyozas : (TestiVisszacsatolas, KornezetiEloreJelzes) -> AgrpAllapot"
code: |
  -- AgRP: bottom-up testi jel + top-down anticipációs jel
  agrpSzabalyozas : TestiVisszacsatolas -> KornezetiEloreJelzes -> AgrpAllapot
  agrpSzabalyozas Ehes      (ElelemMegjelenes _) = Csokkent  -- feedforward gátlás
  agrpSzabalyozas Ehes      NincsJelzes           = Magas
  agrpSzabalyozas Jollakott _                     = Alacsony
causes: [kandel41-incentive-motivation]
caused_by: [kandel41-pomc-agrp-mc4r-loop, kandel41-short-long-term-signals]
resolves: [hogy_a_homeosztatikus_mag_is_kap_fentről-lefelé_anticipacios_beet]
tags: [neocortex, hypothalamus, predictive-coding, feedforward, top-down]
```

```yaml
id: kandel41-incentive-motivation
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: Incentive motivation elmélet: a hiány növeli az étel jutalomértékét
type: Pattern
idris_version: 2
summary: >
  Az incentive motivation elmélet szerint a hiányállapot (pl. kalóriahiány)
  növeli az étel és az ételhez kapcsolódó ingerek, feladatok jutalomértékét
  (incentive salience). Az evés után a jutalomérték csökken; az AgRP-neuronok
  mesterséges aktiválása jóllakott állatban a jóllakott állapothoz képest ugyanarra
  az igen magas szintre emeli az étel jutalomértékét, mint az éhezés.
signature: "jutalomErtek : HianyAllapot -> Etel -> JutalomErtek"
code: |
  -- A hiány beállítja az étel/cuela jutalom-erősítését (gain)
  jutalomErtek : HianyAllapot -> Etel -> JutalomErtek
  jutalomErtek Ehes      _ = NagyonMagas
  jutalomErtek Jollakott _ = Alacsony  -- csak a leginkább ízletes marad vonzó
causes: [kandel41-homeostatic-to-reward-mystery]
caused_by: [kandel41-agrp-feedforward-environment]
resolves: [miert_valik_az_eves_es_az_evessel_kapcsolatos_viselkedés_sokféleve]
tags: [neocortex, motivation, reward, learning, incentive-salience]
```

```yaml
id: kandel41-drive-reduction-aversive
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: Drive reduction: az AgRP éhség-neuronok aktivitása kellemetlen (aversive)
type: CausalRelation
idris_version: 2
summary: >
  A hiányállapot (szomjúság, kalóriahiány) által keltett viselkedési állapot
  kellemetlen. Az AgRP-neuronok optogenetikai aktiválása jóllakott egérben
  aversive; az állat olyan viselkedést végez, amely korábban csökkentette az
  AgRP-aktivitást, mintha ki akarná kapcsolni a kellemetlen állapotot. A
  jóllakott állapot csökkenti a jutalomértéket (drive reduction).
signature: "averszivAllapot : AgrpAktivitas -> ErzelmiValasz"
code: |
  -- A homeosztatikus hiány okozta aversive állapot motiválja a megoldó viselkedést
  averszivAllapot : AgrpAktivitas -> ErzelmiValasz
  averszivAllapot Magas = Kellemetlen   -- kerülendő, motiváló
  averszivAllapot Alacsony = SemlegesVagyKellemes
causes: [kandel41-deficiency-aversive-state]
caused_by: [kandel41-pomc-agrp-mc4r-loop]
resolves: [miert_nehez_diétázni_es_miert_motival_a_jóllakottság]
tags: [hypothalamus, motivation, drive-reduction, emotion, aversive]
```

```yaml
id: kandel41-deficiency-aversive-state
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: A homeosztatikus hiány kellemetlen állapotot okoz, amely motiválja a megoldó viselkedést
type: CausalRelation
idris_version: 2
summary: >
  Az összesített bizonyíték alátámasztja, hogy a homeosztatikus hiány
  kellemetlen; az aversive állapotot a hiányra válaszoló homeosztatikus
  neuronok aktivációja okozza, és az állat olyan viselkedést végez, amelyet a
  megkönnyebbüléssel (relief) hoz kapcsolatba. A PVH-MC4R jóllakottság-neuronok
  aktiválása éhes állatban érzelmileg pozitív.
signature: "homeosztatikusHiany : HianyAllapot -> (AversiveAllapot, MegoldoViselkedes)"
code: |
  -- Hiány -> aversive állapot -> megkönnyebbülést hozó viselkedés
  homeosztatikusHiany : HianyAllapot -> ErzelmiValasz
  homeosztatikusHiany Ehes = Kellemetlen
  homeosztatikusHiany Jollakott = Kellemes
causes: [kandel41-drive-reduction-aversive]
caused_by: [kandel41-pomc-agrp-mc4r-loop, kandel41-agrp-feedforward-environment]
resolves: [miert_keres_az_allat_megszabadulast_a_hiany-allapottol]
tags: [hypothalamus, motivation, emotion, drive-reduction]
```

```yaml
id: kandel41-homeostatic-to-reward-mystery
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: A homeosztázis→jutalom/észlelés útvonal specifikus hírének rejtélye (neocortex kapcsolat)
type: Pattern
idris_version: 2
summary: >
  Az egyik nagy rejtély: hogyan marad meg az adott cél (pl. étel) specifikussága
  úgy, hogy az idegi információ az agyban a hipotalamusz erősen specifikus,
  hiány által szabályozott homeosztatikus neuronjaiból a nucleus accumbens és a
  kéreg (cortex) „nem specifikus" jutalom- és észlelés-útvonalaiba áramlik. Ez
  közvetlen, valós híd a neokortex-szerű architektúra felé: a hipotalamusz
  modulálja a kéregi jutalom/figyelem-reprezentációt.
signature: "specifikusInfoFolyam : HomeosztatikusNeuron -> KeretgiJutalomUtvonal"
code: |
  -- Specifikus homeosztatikus jel -> nem-specifikus kéregi/jutalom útvonal
  -- A rejtély: a cél-specifikusság megőrzése a leképezés során
  specifikusInfoFolyam : HomeosztatikusNeuron -> KeretgiJutalomUtvonal
  specifikusInfoFolyam n = keregiModulacio (celje n)  -- cél megőrzése nyitott kérdés
causes: [kandel41-incentive-motivation]
caused_by: [kandel41-pomc-agrp-mc4r-loop]
resolves: [hidat_ad_a_homeosztázis_es_a_kéregi_jutalom-percepció_között]
tags: [neocortex, hypothalamus, reward, perception, cortex, mapping-problem]
```

```yaml
id: kandel41-modality-specific-neurons
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: Modalitás-specifikus hipotalamikus neuronok kötik össze az interoceptív visszacsatolást a kimenettel
type: Pattern
idris_version: 2
summary: >
  A modalitás-specifikus hipotalamikus neuronok adott interoceptív szenzoros
  visszacsatolást kötnek össze az adaptív viselkedést és fiziológiás választ
  irányító kimenetekkel. A visszacsatoláson túl ezek a neuronok feedforward
  információt is kapnak a várható jövőbeli homeosztatikus kihívásokról. Ez a
  bemenet→kimenet hozzárendelés funktor-szerű szerkezetként értelmezhető a
  kategóriaelmélet számára.
signature: "modalisLekepezes : InteroceptivBemenet -> AdaptivKimenet"
code: |
  -- Bemenet (mérés) -> kimenet (effektor): egy modalitáshoz egy leképezés
  modalisLekepezes : InteroceptivBemenet -> AdaptivKimenet
  -- A hurok stabil beállási pontot (settling point) eredményez
  beallasiPont : (InteroceptivBemenet, AdaptivKimenet) -> Allapot
causes: [kandel41-homeostatic-to-reward-mystery]
caused_by: [kandel41-short-long-term-signals]
resolves: [hogyan_kapcsolodik_a_specifikus_erzekeles_a_specifikus_valaszhoz]
tags: [kategoriaelmelet, hypothalamus, feedback-loop, control, functor]
```

```yaml
id: kandel41-sexually-dimorphic-regions
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: Szexuálisan dimorf hipotalamikus régiók irányítják a szexuális viselkedést és az agressziót
type: Definition
idris_version: 2
summary: >
  Két hipotalamikus régió kritikus a szexuális viselkedés és agresszió
  szabályozásában: a preoptikus terület (POA) és a ventromediális mag ventrolaterális
  része (vlVMH). Mindkettő szexuálisan dimorf: a POA-ban több neuron van hímekben,
  a vlVMH-ban több progeszteront expresszáló neuron van nőkben. E régiók erősen
  összekötöttek és a feromonokat feldolgozó pályák alatt állnak.
signature: "szexualisDimorfTerulet : Nem -> HipotalamikusMag"
code: |
  data Nem = Hím | Nő
  data HipotalamikusMag = POA | VlVMH | BNSTmpm | MeA
  -- Dimorfia: POA neuronok száma Hím > Nő; vlVMH progeszteron-neuron Nő > Hím
  szexualisDimorfTerulet : Nem -> HipotalamikusMag
  szexualisDimorfTerulet Hím = POA
  szexualisDimorfTerulet Nő  = VlVMH
causes: [kandel41-vlvmh-aggression-levels, kandel41-parental-galanin-poa]
caused_by: [nemi-szteroidok, embriogenesis]
resolves: [mely_teruletek_iranyitjak_a_szexualis_es_agressziv_viselkedest]
tags: [hypothalamus, sex, aggression, dimorphism, hardwired]
```

```yaml
id: kandel41-vlvmh-aggression-levels
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: A vlVMH estrogen-receptor neuronok aktivációjának szintje vált át szexuális viselkedés és agresszió között
type: Pattern
idris_version: 2
summary: >
  A vlVMH egyik estrogen-receptort expresszáló neuronpopulációjának stimulálása
  szexuális viselkedést (mounting) vagy agressziót vált ki a aktivált neuronok
  számától és aktivációs szintjétől függően: alacsony szint mountingot, magasabb
  szint agressziót idéz elő. A progeszteron-receptor expresszáló vlVMH-neuronok
  genetikai kiiktatása mindkét nemnél megszünteti a szexuális viselkedést és a
  hímeknél az agressziót.
signature: "vlvmhAktivacio : AktivaciosSzint -> Viselkedes"
code: |
  -- Folyamatos aktivációs szint -> minőségileg különböző viselkedés
  data Viselkedes = Szexualis | Agressziv
  data AktivaciosSzint = Alacsony | Magas
  vlvmhAktivacio : AktivaciosSzint -> Viselkedes
  vlvmhAktivacio Alacsony = Szexualis
  vlvmhAktivacio Magas    = Agressziv
causes: []
caused_by: [kandel41-sexually-dimorphic-regions]
resolves: [hogyan_valthat_at_egy_neuronpopulacio_ket_kulonbozo_viselkedest]
tags: [hypothalamus, sex, aggression, vlVMH, estrogen]
```

```yaml
id: kandel41-parental-galanin-poa
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: A POA galanin-expresszáló neuronjai irányítják a szülői (gondoskodó) viselkedést
type: CausalRelation
idris_version: 2
summary: >
  Az utódokkal való társas interakció galanin-expresszáló neuronokat aktivál a
  POA-ban; ezek az idegsejtek különállók a párzás által aktivált POA-neuronoktól.
  Ezen galanin-pozitív neuronok genetikai kiiktatása megszünteti a gondoskodó
  szülői viselkedést (sőt agressziót válthat ki nőkben az utódokkal szemben),
  míg hímekben a stimulálásuk csökkenti az agressziót és gondoskodó tisztogatást
  indít el. A POA tehát a szexuális viselkedés mellett az utódok túlélését is
  biztosítja.
signature: "szuloiViselkedes : GalaninNeuronAllapot -> Viselkedes"
code: |
  -- POA galanin neuronok: gondoskodás vs. agresszió kapcsolója
  szuloiViselkedes : GalaninNeuronAllapot -> Viselkedes
  szuloiViselkedes Aktiv = Gondoskodo
  szuloiViselkedes Gátolt = AgresszivVagySemleges
causes: []
caused_by: [kandel41-sexually-dimorphic-regions, utod-ingerek]
resolves: [mely_neuronok_biztositjak_az_utodok_tuleleset]
tags: [hypothalamus, parental, POA, galanin, nurturing]
```

```yaml
id: kandel41-insulin-resistance
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: Inzulin-rezisztencia: növekvő zsírraktárak csökkentik az inzulin hatékonyságát
type: Definition
idris_version: 2
summary: >
  Az inzulin elsődlegesen a vércukrot szabályozza, de a zsírraktárak növekedésével
  a vércukor csökkentésére való képessége csökken (inzulin-rezisztencia). Emiatt
  a magasabb raktárak növelik az alap- és étkezésstimulált inzulinelválasztást a
  rezisztencia legyőzésére. Az inzulin a hipotalamuszt (főleg az arcuatus magot)
  gátolja, ami csökkenti az éhséget.
signature: "inzulinHatekonysag : ZsirRaktar -> Hatekonysag"
code: |
  -- Növekvő raktár -> csökkenő inzulin-hatékonyság (rezisztencia)
  inzulinHatekonysag : ZsirRaktar -> Hatekonysag
  inzulinHatekonysag Magas = Alacsony  -- rezisztencia
  inzulinHatekonysag Alacsony = Magas
causes: [kandel41-leptin-activates-pomc-inhibits-agrp]
caused_by: [kandel41-leptin-fat-signal, zsirraktar-meret]
resolves: [miert_valik_az_energia-szabalyozas_kevesbe_hatékonyva_tulas_fogyasztaskor]
tags: [hypothalamus, insulin, energy-balance, resistance]
```

```yaml
id: kandel41-glucoprivic-hunger
source: "Kandel et al. — Principles of Neural Science (6th ed.), Ch. 41 The Hypothalamus"
concept: Glükopénia (veszélyesen alacsony vércukor) két adaptív választ indít
type: CausalRelation
idris_version: 2
summary: >
  A veszélyesen alacsony vércukorszint (glükopénia) észlelése két adaptív
  választ indít: (1) intenzív glükoprivikus éhséget, részben az AgRP-neuronok
  közvetett aktivációja által, és (2) glukagon, epinefrin és kortikoszteroid
  elválasztását, amelyek fokozzák a máj glükóztermelését. A hormonális válaszok
  a szimpatikus kiáramlás és a stresszel kapcsolatos CRH-pálya aktivációja
  révén jönnek létre.
signature: "glukopeniaValasz : VerCukor -> (Ehseg, HormonValasz)"
code: |
  -- Alacsony vércukor -> éhség + máj glükóztermelés serkentése
  glukopeniaValasz : VerCukor -> HormonValasz
  glukopeniaValasz Alacsony = GlukoGenTermeles + GlukoprivikusEhseg
  glukopeniaValasz Normál   = Semleges
causes: [kandel41-pomc-agrp-mc4r-loop]
caused_by: [kandel41-short-long-term-signals, vercukor-erzekeles]
resolves: [hogyan_vedekezik_az_agy_a_veszelyesen_alacsony_vercukor_ellen]
tags: [hypothalamus, glucose, hunger, homeostasis, stress]
```
