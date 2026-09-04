# Kandel Chunk 06 — ConceptNotes (Kivonat)

Forráskönyv: Kandel et al., *Principles of Neural Science*, 6th ed.
Fejezet: Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives (pp. 555–563)
Feldolgozás: kandel_chunk_06.txt

Séma (book_processor.md alapján):
id, source, concept, type (Rule|Pattern|Pitfall|Example|Definition|CausalRelation),
idris_version, summary, signature, code, related[], causes[], caused_by[], resolves[], tags[]

Megjegyzés: az `idris_version` mező azt jelzi, van-e már Idris 2 formalizálás.
Ebben a chunkban még nincs; a `code` mező egy javasolt típusszintű vázlatot
(adattípust / függvényt), amely a fogalmat kategóriaelméleti/dependens
típusos formában rögzítheti. Az E8 / kategoriaelmelet címke csak valódi
fogalmi hídnál szerepel.

---

## CN-06-001

id: CN-06-001
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Perceptuális állandóság (brightness/color/size constancy)"
type: Definition
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "A látórendszer nem passzív kamera: a megvilágítás és a retinai kép szélsőséges változásai (pl. 1000-szeres fényerő-különbség) ellenére is stabilnak észleli a tárgy felszíni tulajdonságait (szín, fényesség, méret). Az észlelés a fizikai inger tulajdonságaiból következtet a tárgy állandó jellemzőire."
signature: "constancy : (surface : Surface) -> (illum1, illum2 : Illumination) -> Perceived (surface @@ illum1) = Perceived (surface @@ illum2)"
code: |
  -- Vázlat: a tárgy észlelt tulajdonsága független a megvilágítástól
  data FeluletTulajdonsag = Fenyesseg | Szin | Meret
  constancy : (f : FeluletTulajdonsag) -> (s : Surface) ->
             (i1, i2 : Megvilagitas) ->
             Percept (s `megvilagitva` i1) f = Percept (s `megvilagitva` i2) f
  constancy f s i1 i2 = ?bizonyitando  -- tapasztalati állandóság, nem Refl
related: ["CN-06-002", "CN-06-004", "CN-06-007"]
causes: ["retinai kép változékonysága ellenére a felszín tulajdonság állandó", "kontextuális összehasonlítás a látótér különböző részei között"]
caused_by: ["felszínminőség-következtetés határinformációból", "globális kontextus integrálása"]
resolves: ["miért nem nő a barátunk feje, ha közelebb jön", "miért marad fehér az ing váltakozó fényben"]
tags: ["neocortex", "kategoriaelmelet"]

---

## CN-06-002

id: CN-06-002
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Perceptuális kitöltés (perceptual fill-in) — határinformációból felszínminőség"
type: Definition
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "A receptoros mezők közép-környezet szerkezete határok rögzítésére alkalmas; a legtöbb vizuális neuron a felszínek belső területeire nem válaszol. A szürke/kontrasztmentes belsőt a rendszer a szélek kontrasztjából számítja ki (fill-in): rögzített tekintetnél a sötét korong néhány másodperc után a környezettel azonos fényességgel telik meg, mert a szélregetiv neuronok a stabilizált képre nem tüzelnek tovább."
signature: "fillIn : (boundary : EdgeContrast) -> (interior : UniformRegion) -> Perceived interior = Perceived (boundarySurround boundary)"
code: |
  -- Vázlat: a belső fényesség = a szél környezetének fényessége
  data ReceptorosMezo = Kozep | KORNYEZET
  fillIn : (b : SzelKontraszt) -> (belsej : EgyenletesTerulet) ->
           Id (Percept belsej) (Percept (szelKornyezete b))
  fillIn b belsej = ?bizonyitando
related: ["CN-06-001", "CN-06-003"]
causes: ["szélregetiv neuronok elnémulása stabilizált ingerre", "rövid távú plasticitás a receptoros mező tulajdonságaiban"]
caused_by: ["határok kontrasztgradienseinek elemzése", "felszínminőség-következtetés"]
resolves: ["hogyan áll elő a telített felszínészlelet kontrasztmentes belsőből"]
tags: ["neocortex", "kategoriaelmelet"]

---

## CN-06-003

id: CN-06-003
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Klasszikus vs. nem-klasszikus receptoros mező (contextual dependence)"
type: Definition
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "A neuron válasza nemcsak a szigorúan vett receptoros mezőn belüli ingertől függ, hanem a mezőn kívüli felszínek fényességétől is — miközben a mezőn belüli fényesség fix marad. Ezért megkülönböztetik a „klasszikus” (szigorú mező) és „nem-klasszikus” (kontextuális) receptoros mezőt. Már Kuffler (1953) jelezte, hogy a definícióba beletartozik minden funkcionálisan kapcsolódó, akár távoli terület is."
signature: "responseDependsOnContext : (n : Neuron) -> (inner : WithinRF) -> (outer : OutsideRF) -> Spike n (inner, outer) /= Spike n (inner, outer')"
code: |
  -- Vázlat: a válasz függ a mezőn kívüli kontextustól
  data ReceptorosMezo' = Kozep | KORNYEZET'
  responseFuggKontextustol : (n : Neuron) -> (belul : BelsoMezo) ->
                            (kivul1, kivul2 : KivulsoMezo) ->
                            NemEgyenlo (Valasz n belul kivul1) (Valasz n belul kivul2)
  responseFuggKontextustol n belul k1 k2 = ?bizonyitando
related: ["CN-06-002", "CN-06-004", "CN-06-009"]
causes: ["horizontális kapcsolatok a kéregben", "nem-klasszikus mező gátló/excitátor hatása"]
caused_by: ["látótér különböző részeinek fényesség-összehasonlítása"]
resolves: ["miért nem prediktálható a komplex ingerre adott válasz az egyszerű ingerre adott válaszból"]
tags: ["neocortex", "kategoriaelmelet"]

---

## CN-06-004

id: CN-06-004
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Kontextus határozza meg a fényesség- és színészlelést (CausalRelation)"
type: CausalRelation
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "A fizikai inger (reflektált fény hullámhossza, intenzitása) és az észlelt fényesség/szín között nem közvetlen a leképezés: az észlelet erősen függ a kontextustól (környező régiók, 3D alak, világítás iránya). Színindukció: egy régió színe a szomszédos régió szín felé tolódik. A rendszer a fenti megvilágítást feltételezi (Nap pozíciója), ezért a redő alatti és feletti azonos szürke folt másképp tűnik."
signature: "contextCausality : (stim : PhysicalStimulus) -> (ctx : Context) -> Perceived stim (with ctx) /= Perceived stim (with ctx')"
code: |
  -- Vázlat: észlelet = f(ingertulajdonság, kontextus)
  contextOkozat : (ing : FizikaiInger) -> (c1, c2 : Kontextus) ->
                  NemEgyenlo (Eszlelt ing c1) (Eszlelt ing c2)
  contextOkozat ing c1 c2 = ?bizonyitando
related: ["CN-06-001", "CN-06-002", "CN-06-003", "CN-06-010"]
causes: ["szomszédos régiók szín/fényesség-összehasonlítása", "világítás-felülről alapelv", "3D alakasszociáció"]
caused_by: ["látótér mintáinak statisztikai tulajdonságai", "felszínminőség-következtetés"]
resolves: ["miért tér el az észlelt szín a fizikai hullámhossztól"]
tags: ["neocortex", "kategoriaelmelet"]

---

## CN-06-005

id: CN-06-005
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Mozgásészlelés: bottom-up lokális jel + top-down jelenet-szegmentáció integrációja"
type: Pattern
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "Egy tárgy mozgásirányának meghatározása több cue együttes feloldását igényli. A barber-pole illúzió és a plaid-minta köztes iránya mutatja, hogy a globális viszonyok (jelenet-szegmentáció: előtér/háttér szétválasztása) felülírják az egyszerű lokális attribútumok észlelését. A látókéreg komplex algoritmust használ: a lokális mozgásjelek bottom-up elemzését összevonja a top-down jelenet-szegmentációval."
signature: "motionPercept : (local : LocalMotionSignals) -> (segmentation : SceneSegmentation) -> PerceivedDirection = integrate local segmentation"
code: |
  -- Vázlat: mozgásészlelet = integrál(lokális jelek, szegmentáció)
  mozgasEszlelet : (lokalis : LokalisMozgasJelek) -> (szeg : JelenetSzegmentacio) ->
                  EszleltIrany = integrál lokalis szeg
  mozgasEszlelet lokalis szeg = ?bizonyitando
related: ["CN-06-006", "CN-06-011"]
causes: ["lokális mozgásjelek (aperture problem)", "globális jelenet-szegmentáció"]
caused_by: ["V1 lokális elemzés", "magasabb rendű területek top-down hatása"]
resolves: ["hogyan látjuk a plaid-mintát egyetlen irányban mozogni", "barber-pole illúzió"]
tags: ["neocortex", "kategoriaelmelet"]

---

## CN-06-006

id: CN-06-006
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Köztes temporális terület (MT/V5): globális mozgás szelektivitás"
type: Example
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "Majmokban a köztes temporális terület (MT vagy V5), a mozgásra specializált kéregterület neuronjai a teljes minta mozgásirányára szelektívek, nem az egyes komponensekre. Válaszaik megfelelnek a barber-pole illúzióban észlelt iránynak — a globális mozgás reprezentációja korrelál a perceptuális iránnyal."
signature: "mtGlobalSelective : (n : MTNeuron) -> (pattern : GlobalPattern) -> SelectiveFor n (globalDirection pattern) (not (componentDirections pattern))"
code: |
  -- Vázlat: MT neuron a globális irányra szelektív
  mtGlobálisSzelektív : (n : MTNeuron) -> (minta : GlobálisMinta) ->
                        Szelektív n (globálisIrány minta)
  mtGlobálisSzelektív n minta = ?bizonyitando
related: ["CN-06-005", "CN-06-011"]
causes: ["lokális mozgásjelek integrálása", "horizontális és feedforward kapcsolatok"]
caused_by: ["V1 lokális irány-szelektív neuronok"]
resolves: ["hol reprezentálódik a globális mozgásirány a kéregben"]
tags: ["neocortex"]

---

## CN-06-007

id: CN-06-007
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Kontúrintegráció és az asszociációs mező (association field)"
type: Pattern
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "A kontúrintegráció (Gestalt „jó folytonosság” elv) a V1 horizontális kapcsolatain keresztül valósul meg. Az „asszociációs mező” egy kapcsolati minta az egyes kéregterületeken leképezett információdarabok között; ez közvetíti a kontúrintegrációt, és valószínűleg általános feldolgozási sajátosság az egész nagyagykéregben. Anatómiai alapja: a piramissejtek tengelyfonalaiból álló hosszú hatótávolságú horizontális kapcsolatok hálózata, amely a kéregfelszínnel párhuzamosan fut."
signature: "associationField : (area : CorticalArea) -> Network (PyramidalAxons area) -- edges link similar-function columns"
code: |
  -- Vázlat: az asszociációs mező = kéregterületen átívelő kapcsolathálózat
  data Kapcsolat = El (forras : Neuron) (cel : Neuron)
  asszociaciosMezo : (terulet : KéregTerulet) ->
                     Halozat (PyramisTengelyFonal terulet) (hasonloFunkcijuOszlop terulet)
  asszociaciosMezo terulet = ?bizonyitando
related: ["CN-06-008", "CN-06-003", "CN-06-011"]
causes: ["hosszú hatótávolságú horizontális kapcsolatok (pyramidalis axonok)", "hasonló-specificitású orientációs oszlopok összekötése"]
caused_by: ["funkcionális architektúra (orientációs oszlopok)", "Gestalt jó folytonosság elv"]
resolves: ["hogyan áll össze a széttöredezett lokális él-jel egységes kontúrrá"]
tags: ["neocortex", "kategoriaelmelet"]

---

## CN-06-008

id: CN-06-008
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Kéregösszeköttetések, funkcionális architektúra és észlelés szoros kapcsolata (Rule)"
type: Rule
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "A köztes szintű vizuális feldolgozás a látótér egészéből származó információmegosztást igényli. A primer látókéreg (V1) összeköttetései és funkcionális architektúrája együtt közvetítik a kontúrintegrációt. A horizontális kapcsolatok hasonló funkciójú, de távoli helyeket képviselő neuronokat kötnek össze — ez a kontúrintegráció anatómiai alapja. A feedback (top-down) vetületek éppoly kiterjesztettek, mint a feedforward kapcsolatok."
signature: "architectureDeterminesProcessing : (conn : CorticalConnectivity) -> (arch : FunctionalArchitecture) -> Mediation conn arch ContourIntegration"
code: |
  -- Vázlat: az architektúra és a kapcsolat együtt határozza meg a feldolgozást
  architekturaMeghatarozza : (kapcs : KéregOsszekottetes) -> (arch : FunkcionalisArchitektura) ->
                             Kozvetít kapcs arch KontúrIntegráció
  architekturaMeghatarozza kapcs arch = ?bizonyitando
related: ["CN-06-007", "CN-06-011", "CN-06-012"]
causes: ["horizontális + feedforward + feedback kapcsolatok együttese"]
caused_by: ["funkcionális architektúra (oszlopok, térképek)"]
resolves: ["miért nem választható el a kéreg szerkezete az észleléstől"]
tags: ["neocortex", "kategoriaelmelet"]

---

## CN-06-009

id: CN-06-009
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Perceptuális tanulás: felnőttkori plasticitás, implikit és feladatspecifikus"
type: Pattern
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "Bár az ocukáris-dominancia oszlopok kapcsolatai csak kritikus periódusban adaptálódnak, sok kéregi tulajdonság élethosszig módosítható (pl. retinai lézió után a lesion projection zone receptív mezői eltolódnak a működő terület felé, a kéregábrázolás újrarendeződik). A perceptuális tanulás implikit (nem tudatos), ismétléses diszkriminációs feladattal javul, és rendkívül specifikus: a háromvonalas felezési feladatra szerzett javulás NEM terjed át a vernier-diszkriminációs feladatra. A specifitás korai kéregi szintekre utal."
signature: "perceptualLearning : (task : DiscriminationTask) -> (practice : RepeatedPractice task) -> Improved (performance task) AND (NOT (Improved (performance (otherTask task))) )"
code: |
  -- Vázlat: tanulás specifikus a feladatra, nem terjed át
  perceptuálisTanulás : (f : DiszkriminációsFeladat) -> (gyak : IsmételtGyakorlás f) ->
                        Javult (teljesítmény f) `és` Nem (Javult (teljesítmény (másFeladat f)))
  perceptuálisTanulás f gyak = ?bizonyitando
related: ["CN-06-010", "CN-06-011", "CN-06-012"]
causes: ["korai kéregi szintek plasticitása", "receptív mező érzékenységének növekedése gyakorlással (pl. rövidebb kontúrok V1-ben)"]
caused_by: ["ismételt diszkriminációs gyakorlás", "figyelem/top-down feladathatás"]
resolves: ["miért nem általános az észlelési javulás", "hol történik a tanulás a kéreghierarchiában"]
tags: ["neocortex"]

---

## CN-06-010

id: CN-06-010
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Felnőttkori kéregi plasticitás: lesion projection zone átrendeződése"
type: Example
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "Ha mindkét szemen megfelelő helyen fókuszos lézió keletkezik, a kéreg azon része (lesion projection zone), amely a sérült területtől kapott bemenetet, először elnémul. Hónapok alatt azonban a receptoros mezők a sérült részről a környező ép retina felé tolódnak: a sérült terület kéregábrázolása zsugorodik, a környezőé tágul. Ezt a léziózóna körüli neuronok oldalág-sarjadzása okozza. Ez a plasticitás nem a lézióra válaszul alakult ki, hanem perceptuális készségeink javítására."
signature: "adultPlasticity : (lesion : RetinalLesion) -> (months : Time) -> Shift (receptiveFields (lesionProjectionZone lesion)) (toward (intactRetina lesion))"
code: |
  -- Vázlat: a receptoros mező eltolódik a működő retina felé
  felnottkaPlasticitas : (lezió : RetinaiLézió) -> (honap : Idő) ->
                         Eltolódás (ReceptorosMezo (lézióVetületiZóna lezió)) (épRetinaFelé lezió)
  felnottkaPlasticitas lezió honap = ?bizonyitando
related: ["CN-06-009", "CN-06-012"]
causes: ["oldalág-sarjadzás (collateral sprouting) a léziózóna körül", "szinaptikus újrakapcsolódás"]
caused_by: ["funkcionálisan működő retina terület bemenete"]
resolves: ["hogyan őriz meg látókéregi reprezentációt sérülés után a felnőtt agy"]
tags: ["neocortex"]

---

## CN-06-011

id: CN-06-011
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Top-down hatások: figyelem, elvárás, feladat (Cognitive influence on perception)"
type: Pattern
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "A kognitív folyamatok befolyásolják a vizuális észlelést. A téri figyelem szemmozgás nélkül is eltolható, tárgy-orientált lehet, és megoldja a szuperpozíciós problémát (melyik elem melyik tárgyhoz tartozik). A feladat típusa megváltoztatja ugyanazon korai szintű neuron tulajdonságait. Az objektumfelismerés hipotézis-tesztelés: a retinai információt belső objektum-reprezentációkkal hasonlítjuk össze (képzelet nélküli jelenetnél is aktiválódik a V1). A change blindness a figyelem fontosságát mutatja."
signature: "topDown : (attention : SpatialAttention) -> (task : PerceptualTask) -> Modifies attention task (earlyCorticalResponses)"
code: |
  -- Vázlat: a figyelem és a feladat módosítja a korai kéregi választ
  topDownHatas : (figyelem : TériFigyelem) -> (feladat : PerceptuálisFeladat) ->
                 Módosítja figyelem feladat KoraiKéregiVálasz
  topDownHatas figyelem feladat = ?bizonyitando
related: ["CN-06-005", "CN-06-007", "CN-06-008", "CN-06-009"]
causes: ["feedback (top-down) kapcsolatok a magasabb rendű területekből", "belső objektum-reprezentációk", "hipotézis-tesztelés"]
caused_by: ["figyelem allokáció", "perceptuális feladat típusa"]
resolves: ["miért észlelünk egyszerre kevés tárgyat", "change blindness jelensége"]
tags: ["neocortex", "kategoriaelmelet"]

---

## CN-06-012

id: CN-06-012
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "A neuron adaptív processzor: input-szelekció viselkedéses kontextus szerint (Rule)"
type: Rule
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "A felemelkedő kéregi hierarchiában a szelektivitás növekedését hangsúlyozták, de a feedback kapcsolatok egyenrangúak. A bizonyíték azt jelzi: a neuronoknak nincsenek rögzített funkciói — adaptív processzorok, amelyek a viselkedéses kontextustól függően vesznek fel különböző funkcionális szerepeket. Ezt input-szelekcióval érik el: a feladatra vonatkozó bemeneteket kifejezik, a feladat-irrelevánsakat elnyomják. Ez a dinamika magyarázhatja az autizmus és skizofrénia perceptuális jelenségeit is."
signature: "adaptiveProcessor : (n : Neuron) -> (ctx : BehavioralContext) -> SelectedInputs n ctx (taskRelevant ctx) AND Suppressed (taskIrrelevant ctx)"
code: |
  -- Vázlat: a neuron a kontextustól függően szelektálja a bemenetet
  adaptívProcesszor : (n : Neuron) -> (kontext : ViselkedésesKontextus) ->
                     Kifejezett (feladatReleváns kontext n) `és` Elnyomott (feladatIrreleváns kontext n)
  adaptívProcesszor n kontext = ?bizonyitando
related: ["CN-06-008", "CN-06-009", "CN-06-011"]
causes: ["input-szelekció (task-relevant kifejezés, task-irrelevant elnyomás)", "feedback kapcsolatok"]
caused_by: ["viselkedéses / feladat-kontextus"]
resolves: ["miért változik ugyanazon neuron szerepe különböző helyzetekben", "patológiás észlelés (autizmus, skizofrénia)"]
tags: ["neocortex", "kategoriaelmelet"]

---

## CN-06-013

id: CN-06-013
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Pop-out és párhuzamos jellemző-feldolgozás (visual search)"
type: Pattern
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "A komplex képben bizonyos objektumok „kiugranak” (pop-out): eltérő színű objektum, eltérő orientációjú vonal, vagy nagyon ismerős alak (pl. a 2-es szám a 5-ök mezőjében). A pop-out a korai látókéregben, párhuzamosan zajlik — a cél és a háttérzavarók jellemzői retinotopikusan leképezett területeken párhuzamosan kódolva vannak. A jelenség tanítható: ami kezdetben erőfeszítéses keresést igényel, gyakorlás után kiugrik. A komplex alakok (számjegyek) pop-out-ja azt jelzi, hogy a korai szintek már összetettebb alakokat is reprezentálnak/szelektíven kezelnek."
signature: "popOut : (target : Feature) -> (distractors : Features) -> (distinct target distractors) -> Detectable target (parallel, early)"
code: |
  -- Vázlat: a különböző jellemző korai, párhuzamos észlelést eredményez
  kiugras : (cel : Jellemzo) -> (zavarok : Jellemzok) ->
            (Különböző cel zavarok) -> Észlelhető cel Párhuzamos Korai
  kiugras cel zavarok kül = ?bizonyitando
related: ["CN-06-005", "CN-06-011"]
causes: ["párhuzamos (retinotopikus) jellemző-kódolás", "korai kéregi szelektivitás összetett alakra is"]
caused_by: ["szín/orientáció/alak különbség a környezettől", "gyakorlás"]
resolves: ["miért találunk meg egyes tárgyakat erőfeszítés nélkül"]
tags: ["neocortex"]

---

## CN-06-014

id: CN-06-014
source: "Principles of Neural Science (Kandel et al., 6th ed.), Chapter 23 — Intermediate-Level Visual Processing and Visual Primitives"
concept: "Vizuális primitívek és globális tulajdonságok kettős elemzése (Rule / Definition)"
type: Rule
idris_version: "nincs még (Idris 2 vázlat alább)"
summary: "A látókéregi területek neuronjai konzönánsak a Gestalt csoportosítási szabályokkal: párhuzamosan végzik a jelenet lokális és globális elemzését. A lokális tulajdonságok a vizuális primitívek (orientáció-, irány-, kontraszt-, diszparitás-, szín-szelektivitás); a globális tulajdonságok: kontúrintegráció, objektummozgás, határtulajdon (border ownership), diszparitás-rögzítés, színállandóság. Az észlelést a kontextus határozza meg — a neuronválaszok szintén kontext-függők."
signature: "localGlobalAnalysis : (area : VisualCorticalArea) -> Parallel (localPrimitives area) (globalProperties area)"
code: |
  -- Vázlat: lokális primitívek és globális tulajdonságok párhuzamos elemzése
  lokálisGlobálisElemzés : (terulet : LátóKéregiTerulet) ->
                           Párhuzamos (LokálisPrimitívek terulet) (GlobálisTulajdonságok terulet)
  lokálisGlobálisElemzés terulet = ?bizonyitando
related: ["CN-06-007", "CN-06-011", "CN-06-014"]
causes: ["párhuzamos kéregi utak", "horizontális kapcsolatok (asszociációs mező)"]
caused_by: ["Gestalt csoportosítási szabályok (hasonlóság, közelség, jó folytonosság)"]
resolves: ["miből áll a köztes szintű látás elemzése", "hogyan kapcsolódik a Gestalt pszichológia a neurális működéshez"]
tags: ["neocortex", "kategoriaelmelet"]

---

## Hidas megjegyzések a Szima-projekthez (E8 / kategoriaelmelet / neocortex)

- **neocortex**: ez a fejezet szó szerint a neokortex (látókéreg) működését írja le,
  ezért szinte minden note kapja a `neocortex` címkét — közvetlen forrása a
  tervezendő neokortex-szerű architektúrának (horizontális hosszú kapcsolatok,
  kontúrintegráció, top-down feedback, adaptív processzorok).
- **kategoriaelmelet**: az „asszociációs mező” (CN-06-007) természetesen
  fogalmazható meg gráfként / kategóriaként: a kéregterületen átívelő
  kapcsolatok élei morfizmusok; a hasonló funkciójú oszlopok objektumok.
  A CN-06-008 és CN-06-014 (lokális↔globális kettős elemzés) a
  funktor/funktor-kategória (Cat^1=Cat, Cat^2=Cat^Cat) struktúrával írható le:
  a lokális szint egy objektum, a globális szint a fölé rakott funktor. Valódi,
  de közvetítő híd — ezért a címke csak ezeknél szerepel.
- **E8**: ebben a chunkban (köztes szintű látás, látókéreg architektúra) NINCS
  közvetlen, ellenőrizhető híd az E8 kivételes csoport felé. Az E8 itt nem
  kap címkét; egy ilyen átvitel spekulatív lenne. (A projekt E8×E8 = tér×szín
  felosztása fogalmilag rokon a „lokális primitívek = szín/orientáció/diszparitás”
  szétválasztásával, de ezt a hidat itt nem állítjuk, amíg nincs pontos levezetés.)
