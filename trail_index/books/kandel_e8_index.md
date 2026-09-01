# Kandel - Szima Mester Index (E8 Indexer)

**Magyar:** Ez a dokumentum a Kandel: *Principles of Neural Science* (6. kiadás) 15
kivonat-fájljából (kandel_extracted_chunk_01-15.md) kinyert összes ConceptNote
aggregált, kategorizált mester indexe a Szima projekt számára. A jegyzetek az
E8xE8 algebra, a kategoriaelmélet, a FazisAlgebra, a Steane713 és az OktonionAlgebra
Szima-modulokhoz kapcsolódva képezik a neokortex-szerű mesterséges intelligencia
biológiai/empírikus alapját.

**English:** Master index aggregating every ConceptNote extracted from the 15 Kandel
chunk files, organized for the Szima project (a neocortex-like AI grounded in category
theory + the E8 exceptional group). Each note is mapped onto the Szima knowledge
structure (E8xE8 algebra, category theory, phase algebra, Steane [[7,1,3]], octonions).

**Forras PDF:** `/home/joco/EricKandler.pdf`  **|**  **Kivonatok:**
`kandel_extracted_chunk_01..15.md`  **|**  **Magyar chunk-ok:** `kandel_chunk_01..15.txt`

---

## (a) Fogalmi jegyzetek kategoriak szerint / ConceptNotes by category

### Membrán biofizika (Membrane biophysics)

- **kandel_01_ionchannel_def** - Ioncsatorna (Ion Channel) - *tipus:* Definition - *cimkek:* [ioncsatorna, membran, sejtbiológia]
  -  Az ioncsatorna egy fehérje, amely átíveli a sejthártyát, és szelektíven átereszti az ionokat. A csatornanyitás/zárás konformációs változással jár; egycsatornás áram rögzíthető.
- **kandel_01_voltagegated_def** - Feszültségvezérelt csatorna (Voltage-Gated Channel) - *tipus:* Definition - *cimkek:* [ioncsatorna, feszültség, jelátvitel]
  -  Feszültségvezérelt csatornák nyitása a membránfeszültség változásától függ. Nátrium-, kálium-, kalcium- és hiperpolarizáció-aktivált ciklikus-nukleotid-vezérelt típusok léteznek; genetikai úton sokszínűsödnek (pl. alternatív splicing, családok).
- **kandel_01_restingpot_def** - Nyugalmi membránpotenciál (Resting Membrane Potential) - *tipus:* Definition - *cimkek:* [membránpotenciál, Goldman, egyensúly]
  -  A nyugalmi potenciál a töltés szétválasztásából a sejthártya két oldala között származik. Nongated és gated csatornák, valamint aktív transzport (Na/K pumpa) határozzák meg; a Goldman-egyenlet kvantálja a különböző ionok hozzájárulását.
- **kandel_01_goldman** - Goldman-egyenlet (Goldman Equation) - *tipus:* Definition - *cimkek:* [Goldman, egyenlet, membránpotenciál]
  -  A Goldman-egyenlet kvantálja, hogy a különböző ionok (Na, K, Ca, Cl) hogyan járulnak hozzá a nyugalmi membránpotenciálhoz, a permeabilitásaik súlyozásával.
- **kandel_01_actionpot** - Cselekvési potenciál (Action Potential) - *tipus:* Definition - *cimkek:* [cselekvési potenciál, all-or-none, jelpropagáció, neocortex]
  -  A cselekvési potenciál az ionok áramlásából keletkezik feszültségvezérelt csatornákon át; all-or-none jel, amelyet a trigger zóna dönt el, és amelyet a vezető komponens propagál. Újraépíthető a nátrium- és káliumcsatornák tulajdonságaiból.
- **kandel_01_napot_recon** - Cselekvési potenciál rekonstrukciója Na/K csatornákbol - *tipus:* Pattern - *cimkek:* [minta, emergencia, csatornadinasztika, neocortex]
  -  A cselekvési potenciál alakja levezethető a nátrium- és káliumvezetékek (conductances) áramaiból. Ez a "mechanizmusból forma" mintázat: a makrojel a mikroszkopikus csatornadinasztika összege.
- **kandel_01_fluxvsdiff** - Az ionáramlás a csatornán át különbözik a szabad oldatbeli diffúziótól - *tipus:* Definition - *cimkek:* [diffúzió, flux, szelektivitás]
  -  Az ionok csatornán átfolyó fluxusa nem azonos a szabad oldatbeli diffúzióval: a csatorna szelektivitása és energiagátjai alakítják az áramlást (pl. hidratációs energia, méret, töltés).
- **kandel_01_sodiumselect** - Feszültségvezérelt nátriumcsatorna szelektivitása méret/töltés/hidratáció alapján - *tipus:* Definition - *cimkek:* [nátrium, szelektivitás, csatorna]
  -  A feszültségvezérelt nátriumcsatorna a nátriumot a részecske mérete, töltése és hidratációs energiája alapján választja ki a többi ion közül.
- **kandel_01_selective_permeability** - Szelektív permeabilitás szerkezeti alapja (klorid csatorna ~ transzporter) - *tipus:* Pattern - *cimkek:* [klorid, permeabilitás, transzporter]
  -  A klorid csatornák szelektív permeabilitásának szerkezeti alapja szoros rokonságot mutat a transzporterekével — a csatorna és szállító fehérjék családjai átfednek.

### Szinaptikus átvitel (Synaptic transmission)

- **kandel_01_synapse_overview** - Szinapszis — elektromos vs kémiai - *tipus:* Definition - *cimkek:* [szinapszis, jelátvitel, neocortex]
  -  A szinapszisok túlnyomórészt elektromosak vagy kémiaiak. Az elektromos (gap-junction) gyors, szinkron átvitelt ad; a kémiai felerősítheti a jelet, és a posztszinaptikus receptor tulajdonságaitól függ.
- **kandel_01_chemsynapse_amp** - Kémiai szinapszisok felerősítik a jelet - *tipus:* CausalRelation - *cimkek:* [szinapszis, amplifikáció, jelerősítés, neocortex]
  -  A kémiai szinapszisok képesek amplifikálni a jelet: egy preszinaptikus esemény sok posztszinaptikus receptorcsatornát nyithat meg. Ez a felerősítés a neuronális számítás egyik alapja.
- **kandel_01_gapjunction** - Gap-junction (elektromos szinapszis) - *tipus:* Definition - *cimkek:* [gap-junction, glia, szinkron]
  -  Az elektromos szinapszisban lévő sejteket gap-junction csatornák kötik össze; ez gyors, szinkron tüzelést tesz lehetővé, és szerepe van a glia működésében és egyes betegségekben is.
- **kandel_01_neurotransmitter_release** - Neurotranszmitter-kibocsátás diszkrét csomagokban (kvantális) - *tipus:* Pattern - *cimkek:* [kvantális, neurotranszmitter, kódolás, neocortex]
  -  Az acetilkolin (és általában a neurotranszmitterek) diszkrét csomagokban (kvantákban) szabadul fel; az end-plate potenciál helyi permeabilitásváltozásból származik. Ez a "kvantált jel" mintázat a digitális idegrendszeri kód alapja.

### Neuromoduláció és másodlagos hírvivők (Neuromodulation & second messengers)

- **kandel14_gprotein_direct_gating** - "G-fehérje közvetlen ioncsatorna-nyitása (GIRK, βγ-alegység)" - *tipus:* CausalRelation - *cimkek:* [neocortex, gprotein, girk, beta_gamma, direct_gating, ion_channel]
  -  A metabotrop receptorhoz kötődő transzmitter felszabadít egy G-fehérje alegységet, amely közvetlenül kölcsönhat a céloncsatornával anélkül, hogy diffundáló második hírvivőt hozna létre. A GIRK K+-csatornát a Gi/Go fehérje βγ komplexe nyitja meg, hiperpolarizálva a sejtet EK irányába.
- **kandel14_pip2_mchannel** - "M-típusú K+ csatorna zárása PIP2 hidrolízissel (ACh)" - *tipus:* Pattern - *cimkek:* [neocortex, ach, plc, pip2, m_channel, excitability]
  -  A muszkarinos ACh receptor aktiválja a PLC-t, amely csökkenti a membrán PIP2 szintjét; az M-csatorna működéséhez PIP2 ko-faktor kell, így a csatorna bezáródik. Ez lassú depolarizációt és a perceptron-küszöb alatti excitabilitás emelkedését okozza — a csatorna nemcsak a nyugalmi potenciált állítja be, hanem az excitabilitást is szabályozza.
- **kandel14_firing_rate_modulation** - "GIRK aktiváció csökkenti a spontán tüzelési rátát" - *tipus:* Pattern - *cimkek:* [neocortex, girk, hcn, firing_rate, intrinsic_excitability]
  -  Az önállóan tüzelő neuronokban a GIRK-en átmenő kifelé irányuló K+ áram elsősorban a sejt intrinsikus tüzelési rátáját csökkenti, szemben állva a HCN-csatornák (pacemaker) lassú depolarizációjával. Mivel a GIRK-et transzmitterek aktiválják, szinaptikus úton modulálják az excitábilis sejtek tüzelési rátáját — ez a "belső excitabilitás" szabályozásának egyik alapmintája.
- **kandel14_ca_channel_inhibition** - "G-fehérje βγ gátolja a feszültségfüggő Ca2+ csatornákat" - *tipus:* CausalRelation - *cimkek:* [neocortex, ca_channel, beta_gamma, inhibition, presynaptic]
  -  Több G-protein-kapcsolt receptor a Gi/Go βγ komplexének közvetlen kötődésével gátolja bizonyos feszültségfüggő Ca2+ csatornák nyitását. Mivel a Ca2+ beáramlás depolarizáló hatású, a Ca2+ gátlás és a K+ aktiváció együttesen erősen gátolja a neuronális tüzelést, és a preszinaptikus terminálisokban csökkentheti a transzmitter-felszabadulást.
- **kandel14_convergence** - "Több neuromodulátor konvergál ugyanarra a neuronra és csatornára" - *tipus:* Pattern - *cimkek:* [neocortex, kategoriaelmelet, convergence, colimit, polymorphism, modulation]
  -  Ugyanaz az ioncsatorna (pl. M-típusú K+ csatorna, vagy az Aplysia S-csatornája) különböző modulátorokkal (ACh, szubasztanci P, peptidek; szerotonin) szabályozható. A rákféle stomatogastricus ganglionban sokféle neuropeptid konvergál egyetlen feszültségfüggő beáramlási áramra (IMI). Ez a "konvergencia" a neuronokat rugalmassá teszi különböző agyi állapotok között — kategóriaelméleti szemmel egy koproduct/colimit szerkezete: több bemeneti áramlás egyetlen céloncsatorna-állapotba olvad.
- **kandel14_circuit_reconfiguration** - "Egyetlen modulátor újrakonfigurál egy teljes áramkört (dopamin, STG)" - *tipus:* Example - *cimkek:* [neocortex, dopamine, stomatogastric, circuit, reconfiguration, timing]
  -  A rák pyloric áramkörében (AB, PD, PY neuronok) a dopamin szelektíven módosítja az AB, PD és PY neuronok különböző feszültségfüggő csatornáit (ICa, IK,Ca, IK,A, Ih, INa, IKv), megváltoztatva a PY neuron tüzelésének időzítését a pacemaker-csoporthoz képest. Egyetlen modulátor szelektív hatása elosztott áramköri elemekre együttesen új viselkedést eredményez — modellként szolgál a neokortex térbelileg elosztott excitabilitás- szabályozásához.
- **kandel14_why_many** - "Miért ennyi modulátor? — plaszticitás ÉS stabilitás" - *tipus:* Rule - *cimkek:* [neocortex, plasticity, stability, redundancy, robustness]
  -  A kis STG ganglion 26–30 neuronja 50-nél több neuromodulátor célpontja. A gazdagságnak kettős szerepe van: (1) különböző viselkedésileg releváns motoros kimenetek előállítása, és (2) redundancia — hasonló hatású modulátorok biztosítják, hogy egy modulációs rendszer kiesése esetén is megmaradjon a kritikus funkció. Ez a plaszticitás-stabilitás dichotómia közvetlenül tükröződik a Szima északi csillagában: "diverse modulators may be used in the service of both plasticity and stability."
- **kandel14_metabotropic_binding** - "Metabotrop receptorok két nagy családja" - *tipus:* Definition - *cimkek:* [neocortex, metabotropic, gpcr, rtk, receptor]
  -  A neuromodulátorok legtöbb receptora metabotrop. Két fő család létezik: a G-protein-kapcsolt receptorok (GPCR) és a receptor tirozin-kinázok. Számos fontos agyi jelmolekula (noradrenalin, ACh, GABA, glutamát, szerotonin, dopamin, neuropeptidek) aktivál metabotrop receptorokat, sokuk ionotrop receptorokat is.

### Plaszticitás és tanulás (Plasticity & learning)

- **kandel_01_nmda** - NMDA receptor — hosszú távú szinaptikus plasticitás alapja - *tipus:* Definition - *cimkek:* [NMDA, LTP, plasticitás, tanulás, neocortex, kategoriaelmelet]
  -  Az NMDA receptor egy ionotróp glutamát receptor-k csatorna, egyedi biofizikai és farmakológiai tulajdonságokkal. Tulajdonságai alátámasztják a hosszú távú szinaptikus plasticitást (LTP), ezért központi a tanulás és memória idegrendszeri modelljében.
- **kandel_01_hebbian** - Hebbi plasticitás azonosítja a domináns bemeneti mintákat - *tipus:* Rule - *cimkek:* [Hebb, plasticitás, tanulás, neocortex, kategoriaelmelet]
  -  "A domináns szinaptikus bemeneti mintázatok Hebbi plasticitással azonosíthatók." A gyakran együtt tüzelő bemenetek szinapszisa megerősödik — ez a Hebb-szabály, a tanulás és memória alapja, és közvetlen fogalmi híd a kategóriaelméleti struktúraképzéshez.
- **kandel_01_synaptic_plasticity** - Tanulás és memória a szinaptikus plasticitástól függ - *tipus:* CausalRelation - *cimkek:* [plasticitás, tanulás, memória, neocortex, kategoriaelmelet]
  -  "A tanulás és memória a szinaptikus plasticitástól függ." A viselkedés tartós megváltozása a szinapszisok súlyának és szerkezetének módosulásán keresztül valósul meg.
- **kandel_01_ltp** - Az NMDA receptor tulajdonságai alátámasztják a hosszú távú szinaptikus plasticitást - *tipus:* CausalRelation - *cimkek:* [LTP, NMDA, plasticitás, memória, neocortex]
  -  Az NMDA receptorok egyedi tulajdonságai (feszültség- és ligandumvezérelt, Mg-blokkolt, Ca-áteresztő) teszik lehetővé a hosszú távú potenciálást (LTP). Ez a mechaniztikus híd a Hebbi szabály és a tartós memória között.
- **kandel14_camp_pka_schannel** - "cAMP-függő PKA zárja az S-típusú K+ csatornát (Aplysia, szerotonin)" - *tipus:* CausalRelation - *cimkek:* [neocortex, camp, pka, serotonin, aplysia, learning, s_channel]
  -  A szerotonin (5-HT) Gs-hez kapcsolt receptort aktivál, amely emeli a cAMP szintet és aktiválja a PKA-t; a PKA közvetlenül foszforilálja és bezárja az S-típusú (szerotonin-érzékeny) K+ csatornát. A csatorna-zárás csökkenti a K+ effluxust, depolarizál és egy egyszerű tanulási forma (érzékenyítés, sensitization) alapja az Aplysia visszahúzódási reflexében.

### Neurális jelzés és architektúra (Neuronal signaling & architecture)

- **kandel_01_signaling_uniform** - A jelzés minden idegsejtben ugyanúgy szerveződik - *tipus:* Pattern - *cimkek:* [minta, jelzés, architektúra, neocortex]
  -  "A jelzés szerveződése minden idegsejtben azonos": bemeneti komponens (fokozatos helyi jel), trigger zóna (döntés akcióspotenciálról), vezető komponens (all-or-none terjedés), kimeneti komponens (neurotranszmitter-kibocsátás). Ez a négykomponensű séma univerzális huzalozási minta.
- **kandel_01_circuit_motifs** - Neuronális áramköri motivikumok (motifs) alaplogikát adnak az információfeldolgozásnak - *tipus:* Pattern - *cimkek:* [motif, áramkör, információfeldolgozás, neocortex, kategoriaelmelet]
  -  A helyi áramkörök (feed-forward hierarchia, visszacsatolás/recurrent) ismétlődő motivikumokat alkotnak; ezek a motivikumok adják az információfeldolgozás alaplogikáját. A vizuális feldolgozás hierarchikus feed-forward reprezentáción alapul.

### Érzékelési kódolás (Sensory coding)

- **kandel14_state_dependent_response** - "Moduláció állapotfüggő érzékelési választ hoz létre" - *tipus:* Pattern - *cimkek:* [neocortex, state, behavioral_state, modulation, sensory]
  -  Sok érzékelési folyamat nagyon eltérő választ vált ki az állat viselkedési állapotától függően; a szinaptikus erősséget és intrinsikus excitabilitást módosító modulátorok gyakran részt vesznek ezekben a műveletekben. A moduláció tehát nem "üzenet", hanem az áramköri dinamika eltolása a viselkedési igényekhez — ez közvetlenül kapcsolódik a neokortex állapotfüggő (éber/alvó/fókuszált) működéséhez.
- **kandel-ch28-feature-detectors** - Combination-sensitive feature detectors - *tipus:* Pattern - *cimkek:* [neocortex, feature-binding, auditory, sensory-cortex]
  -  Auditory cortical neurons (e.g. FM-FM area of mustached bat) respond preferentially to a specific *combination* of stimuli (pulse + echo at a particular delay) rather than to either component alone. Selectivity increases progressively along the ascending pathway (Highlight 3). This is a canonical "binding of primitives into a higher-order feature" pattern.
- **kandel-ch28-columnar-map** - Columnar organization of feature detectors - *tipus:* Pattern - *cimkek:* [neocortex, columnar, map, auditory]
  -  Neurons tuned to a particular combination of stimulus frequency and delay are organized into columns; in the CF-CF area columns are arranged along two perpendicular axes (fundamental frequency × echo harmonic). A 2-D coordinate system over the cortical sheet encodes a computed variable (Doppler shift → target velocity, –2 to 9 m/s).
- **kandel-ch28-dual-freq-coordinate** - Dual-frequency coordinate system (CF-CF area) - *tipus:* Definition - *cimkek:* [neocortex, computational-map, coordinate, auditory]
  -  The CF-CF area of bat auditory cortex forms a map where one cortical axis represents the emitted call's fundamental frequency and the perpendicular axis the Doppler-shifted echo harmonic. A specific location encodes a specific Doppler shift, hence a specific target velocity. This is a sensory-derived *computational map* for a variable not present at the receptor.
- **kandel-ch28-computed-variable** - Cortical representation of a receptor-absent variable - *tipus:* Pattern - *cimkek:* [neocortex, latent-variable, computation]
  -  The bat, like the barn owl's inferior colliculus, represents an acoustic feature (target velocity via Doppler shift) that is NOT directly encoded by sensory receptors (Highlight text, p. 677). Cortical computation synthesizes a new variable from raw receptor signals. This is the essence of a neocortex: constructing latent variables.
- **kandel-ch28-what-where-streams** - Dorsal and ventral auditory processing streams - *tipus:* Pattern - *cimkek:* [neocortex, parallel-streams, what-where, auditory]
  -  Auditory cortical circuits segregate into parallel streams: a dorsal stream concerned with sound location in space (the "where") and a ventral stream concerned with sound identification (the "what") (Highlight 9). This mirrors the visual dorsal/ventral split and is a general principle of cortical organization.
- **kandel-ch28-vocal-feedback-monitoring** - Vocal feedback-monitoring network (corollary discharge analog) - *tipus:* CausalRelation - *cimkek:* [neocortex, corollary-discharge, self-monitoring, efference-copy, motor-sensory-loop]
  -  Speaking induces suppression of auditory cortex activity beginning several hundred milliseconds BEFORE vocal onset (cortical), whereas subcortical suppression begins at or after onset. The lead time implies the suppression is driven by a *command signal from vocal motor areas* — an efference copy / corollary discharge that modulates sensory cortex to distinguish self-generated from externally generated sound and to monitor vocal errors (Figure 28–15, Houde & Chang 2015).
- **kandel-ch28-self-vs-external** - Self-generated vs externally-generated percept discrimination - *tipus:* Pattern - *cimkek:* [neocortex, self-vs-other, predictive-coding, monitoring]
  -  The auditory system must tag a percept as self-generated or externally generated to monitor the environment during speech while also tracking one's own voice for error detection and learning. Perturbing feedback (e.g. pitch shift via earphones) abolishes suppression and recruits cortex to the perturbation, demonstrating an active feedback-monitoring loop rather than passive listening.
- **kandel-ch28-corticofugal** - Cerebral cortex modulates subcortical auditory areas - *tipus:* Pattern - *cimkek:* [neocortex, top-down, corticofugal, feedback]
  -  Auditory cortex projects back to the thalamus, inferior colliculus, olivocochlear neurons, basal ganglionic structures, and even the dorsal cochlear nucleus (Highlight 10). Processing is not strictly bottom-up; the cortex exerts top-down control (experience-dependent plasticity in bat cortex/colliculus depends on the corticofugal system). A neocortex must therefore close the loop with descending projections.
- **kandel-ch28-progressive-selectivity** - Progressively increasing stimulus selectivity along ascending pathway - *tipus:* Pattern - *cimkek:* [neocortex, hierarchy, selectivity]
  -  A marked feature of auditory neurons at successive processing stations is their progressively increasing stimulus selectivity (Highlight 3); within auditory cortex neurons become yet more selective. Selectivity is built by combining inputs (e.g. coincidence detection, spectral sharpening) rather than by new receptors.
- **kandel-ch29-olfactory-orbitofrontal** - Olfactory cortex → orbitofrontal cortex for odor discrimination - *tipus:* CausalRelation - *cimkek:* [neocortex, orbitofrontal, multimodal, discrimination]
  -  Pyramidal neurons of the olfactory cortex transmit information indirectly via the thalamus to orbitofrontal cortex and directly to frontal cortex; these higher cortical pathways are important for odor discrimination — lesions of orbitofrontal cortex abolish odor discrimination. Some orbitofrontal neurons are multimodal (respond to smell, sight, or taste of a banana), an early convergence of sensory modalities.
- **kandel-ch29-scattered-not-topographic** - Piriform cortex lacks a recapitulated receptor map - *tipus:* Pitfall - *cimkek:* [neocortex, distributed-code, pitfall, olfactory]
  -  Unlike the tonotopic auditory map, the highly organized map of odorant receptor inputs in the olfactory bulb is NOT recapitulated in the piriform cortex; pyramidal neurons activated by a given odorant are scattered across the piriform cortex, and different mitral cells converge on the same subregion. WARNING for architects: not every cortical area must preserve a topographic input map; distributed/overlapping codes are valid.
- **kandel-ch28-acoustic-feature-binding** - Acoustic feature binding via coincidence / combination coding - *tipus:* Rule - *cimkek:* [neocortex, feature-extraction, binding, auditory]
  -  Distinct ventral cochlear nucleus cell types extract distinct sound features in parallel — octopus cells detect coincident firing (onsets/gaps), stellate cells sharpen spectral peaks/valleys, bushy cells sharpen fine structure for binaural timing/intensity comparisons. These parallel feature streams are the substrate later bound into combination-sensitive cortical responses.
- **KANDEL08-017** - "Bőr mechanoreceptorai (köztük nociceptorok) teszik lehetővé az akadályhoz igazítást" - *tipus:* CausalRelation - *cimkek:* [neocortex, "mechanoreceptor", "akadály-elkerülés", "fázisfüggő-reflex"]
  -  A bőr mechanoreceptorai, különösen a talp dorsalis felszínének érintésekor, erős hatással vannak a CPG-re: a lengés fázisában flexor serkentést és extensor gátlást váltanak ki (gyors elhúzódás az inger elől), míg a támasz fázisában extensor serkentést (a menekülés helyett a támasz megtartása). Ez a fázisfüggő reflex-megfordulás egyik példája.
- **KANDEL12-011** - "Pheromon-észlelés emberben vs egérben (hiányzó vomeronasal szerv)" - *tipus:* Definition - *cimkek:* [neocortex, "érzékelés", "szaglás", "fajspecifikusság"]
  -  Az embernek nincs funkcionális vomeronasal szerve (vomeronasal organ, VNO), és a vomeronasal receptorokhoz (trpc2 stb.) kötődő gének hiányoznak vagy nem működnek a genomban. Az emberi feromon-észlelés (ha létezik) a fő szaglóhámon (main olfactory epithelium) és hagymán (olfactory bulb) keresztül történik, nem a rágcsálók VNO-útvonalán.

### Motoros irányítás (Motor control)

- **kandel_01_reflex** - Reflex-áramkör — a viselkedés idegrendszeri architektúrájának kiindulópontja - *tipus:* Example - *cimkek:* [reflex, példa, architektúra, neocortex]
  -  A nyújtási reflex (stretch-reflex) útja illusztrálja, hogyan alakul át a szenzoros jel motoros jellé egy egyszerű áramköron át. A reflex-áramkör a komplexebb viselkedési architektúra értelmezésének kiindulópontja.
- **kandel-ch30-motor-hierarchy** - Functional hierarchy of motor control (executive function) - *tipus:* Pattern - *cimkek:* [neocortex, executive-function, hierarchy, prefrontal, motor]
  -  Motor systems form a functional hierarchy, each level a different decision. The highest and most abstract level (likely requiring prefrontal cortex) deals with the PURPOSE of a movement; the next level (posterior parietal ↔ premotor) forms a motor PLAN from sensory context; the lowest level (primary motor cortex, brain stem, spinal cord) coordinates the spatiotemporal muscle-contraction details. This is a concrete instance of neocortical executive function: abstract goal → plan → execution.
- **kandel-ch30-predictive-model** - Predictive model / efference copy for feedforward control - *tipus:* CausalRelation - *cimkek:* [neocortex, predictive-coding, efference-copy, cerebellum, control]
  -  Movement is not shaped purely by sensory feedback; centers such as the cerebellum use predictive models that simulate the consequences of outgoing commands to allow very short-latency corrections (feedforward + optimal feedback control). This is the same principle as the auditory corollary-discharge network: the motor command generates an internal prediction that is compared with sensation.
- **KANDEL08-001** - "Központi minta-generáló hálózat (Central Pattern Generator, CPG)" - *tipus:* Definition - *cimkek:* [neocortex, "moduláris-architektúra", "elosztott-vezérlés", "CPG"]
  -  A gerincvelő elszigetelve a lefelé irányuló (supraspinalis) és a perifériás ritmikus afferens bemenetektől is képes összetett, az ép állatnál megfigyelhető ritmusokat és mintázatokat tartalmazó mozgásprogramot (lokomóciót) előállítani. Ezekért a hálózatokért felelős áramköröket központi minta-generálóknak nevezzük.
- **KANDEL08-002** - "CPG kétrétegű moduláris felépítése: ritmus- és mintázat-generálás" - *tipus:* Pattern - *cimkek:* [neocortex, "moduláris-architektúra", "rétegezett-vezérlés", "CPG"]
  -  A gerincvelői lokomóciós hálózatok ritmus-generáló áramkörökre (flexor és extensor ritmus-neuronok) és egy mintázat-generáló rétegre tagolódnak. A ritmus-generálók hajtják a megfelelő izmokat, a mintázat-réteg alakítja ki az antagonista (hajlító/feszítő) váltakozást és a bal-jobb koordinációt.
- **KANDEL08-003** - "Kölcsönös gátlás (reciprocal inhibition) a flexor/extensor váltakozásban" - *tipus:* Pattern - *cimkek:* [neocortex, "oszcilláció", "gátlás", "CPG"]
  -  A ritmus-generáló flexor és extensor neuronok kölcsönösen gátló (inhibitory) interneuronokon keresztül kapcsolódnak össze, ami félközpontos oszcillátorként (half-center oscillator) működteti az antagonista izmok alternálását.
- **KANDEL08-004** - "Szomatoszenzoros visszacsatolás modulálja a CPG működését" - *tipus:* CausalRelation - *cimkek:* [neocortex, "visszacsatolás", "szenzoros-adaptáció", "CPG"]
  -  Bár a CPG önmagában is előállítja a lépés pontos időzítését, a központi mintát normálisan a mozgó végtagokból érkező szenzoros jelek modulálják. Kétféle bemenet hat: a végtag aktív mozgása által generált proprioceptív és a környezeti akadálytal való találkozáskor keletkező taktilis információ.
- **KANDEL08-005** - "Propriocepció szabályozza a lépés időzítését és amplitúdóját" - *tipus:* CausalRelation - *cimkek:* [neocortex, "propriocepció", "fázis-átmenet", "visszacsatolás"]
  -  A mozgó végtagokból származó proprioceptív jel (izomorsók a csípőben, Golgi ínorszervek a bokában) jelzi a stance (támasz) fázis végét és váltja ki a swing (lengés) fázis indítását. A csípő kinyújtása entrainálja a ritmust: a csípőizmok nyújtása a motoros kimenet időzítését az külsőleg kényszerített mozgáshoz igazítja.
- **KANDEL08-006** - "Fázisfüggő reflex-megfordulás (phase-dependent reflex reversal)" - *tipus:* Pattern - *cimkek:* [neocortex, "kontextusfüggő-feldolgozás", "reflex-megfordulás", "visszacsatolás"]
  -  Ugyanaz a szenzoros inger eltérő választ vált ki a lépésciklus különböző fázisaiban: a bokafeszítőkből érkező csoport-I afferens stimulus a lengés fázisában gátolja a flexort, de a támasz fázisában az extensorokat erősíti (a reflex előjelének megfordulása). Ez megakadályozza az állat összeomlását a támasz fázisában.
- **KANDEL08-007** - "Ioncsatornák hozzájárulása a CPG ritmus- és mintázat-generáláshoz" - *tipus:* Pattern - *cimkek:* [neocortex, "ioncsatorna", "bursting", "plató-potenciál", "oszcilláció"]
  -  A neuronmembrán tulajdonságai (bursting, plateau potenciál) intrinsic vagy neurotranszmitter-függő módon erősítik a ritmikusságot. Különböző feszültségfüggő csatornák (tranzitórikus alacsony küszöbű Ca2+, HCN, tranzitórikus K+) szabályozzák a fázisátmeneteket és a tüzelési rátát; az NMDA-receptorok által kiváltott bursting és az L-típusú Ca2+ csatornák által mediált plateau tulajdonságok a ritmusgenerálást segítik.
- **KANDEL08-009** - "Középagyi mozgásközpont (Mesencephalic Locomotor Region, MLR) indítja a lokomóciót" - *tipus:* CausalRelation - *cimkek:* [neocortex, "parancs-jel", "supraspinalis-vezérlés", "MLR", "sebesség-szabályzás"]
  -  A gerincvelői lokomóciós hálózatok működésének indításához és fenntartásához supraspinalis parancsra van szükség. A fő szerkezet a középagyi MLR, amely két magból áll: a cuneiformis magból (CNF, glutamaterg) és a pedunculopontinus magból (PPN, glutamaterg és kolinerg). A PPN/CNF glutamaterg neuronok az induláshoz és a lassú (járás, ügetés) tempóhoz elegendők; a CNF glutamaterg neuronok szükségesek a gyors (vágtatás, ugrás) menekülés-jellegű mozgáshoz.
- **KANDEL08-010** - "Agytörzsi magvak szabályozzák a testtartást lokomóció közben" - *tipus:* CausalRelation - *cimkek:* [neocortex, "testtartás", "agytörzsi-vezérlés", "lefelé-irányuló-pálya"]
  -  A vestibulospinalis (VST) és reticulospinalis (RST) lefelé irányuló pályák, valamint a rubrospinalis pálya a testtartásért, az egyensúlyért és a négy végtag koordinációjáért felelnek. Ezen magvak (LVN, PMRF, nucleus ruber) aktivitása a lépésciklus frekvenciáján fázikusan modulált, és fázisfüggő módon változtatják az izomtónust.
- **KANDEL08-011** - "A kisagy (cerebellum) korrigálja a motoros hibákat és a lefelé irányuló jeleket" - *tipus:* Pattern - *cimkek:* [neocortex, "efferens-másolat", "hiba-korrekció", "visszacsatolás", "kisagy"]
  -  A kisagy a gerincvelőbe küldött motoros parancsok és a tényleges mozgás összehasonlítása alapján javítja a mozgást. A centrális efferens másolat (efference copy), a mozgás afferens másolata (DSCT via spinocerebellaris pálya) és a gerincvelői hálózat állapota (VSCT via CPG-interneuronok) a kisagyban integrálódik, és Purkinje-sejtek ritmikus kisülésének megváltoztatásával modulálja a lefelé irányuló jeleket.
- **KANDEL08-013** - "A motoros kéreg biztosítja a vizuálisan vezérelt precíz lépést" - *tipus:* CausalRelation - *cimkek:* [neocortex, "motoros-kéreg", "vizuális-vezérlés", "corticospinalis", "CPG"]
  -  A járás legtöbbször vizuálisan vezérelt; a motoros kéreg elengedhetetlen a precíz (visuomotoros koordinációt igénylő) lokomócióhoz, pl. akadály feletti lépésnél. A kéregi corticospinalis neuronok közvetlenül a gerincvelői CPG-interneuronokat szabályozzák, és rövid ingertréninggel fázisfüggő módon, sőt a ritmus újraindításával (reset) is beavatkoznak.
- **KANDEL08-015** - "Számítógépes (computational) modellezés tárja fel a lokomóciós áramkörök dinamikáját" - *tipus:* Pattern - *cimkek:* [neocortex, "computational-neuroscience", "dinamikus-modell", "szimuláció"]
  -  A funkcionális vizsgálatok mellett a computacionális hálózati modellezés lehetővé teszi az áramkör aktivitásának szimulációját és a sejt- valamint szinaptikus tulajdonságok dinamikus kölcsönhatásainak vizsgálatát több szinten (ionos alap, kapcsolódás, struktúrák közötti interakció). Az kísérleti manipuláció és a modellezés kombinációja növeli a megértést.
- **KANDEL08-016** - "Optimális visszacsatolásos vezérlés vs. reprezentációs modell a mozgásirányításban" - *tipus:* Pattern - *cimkek:* [neocortex, "optimális-vezérlés", "dynamical-model", "szenzomotoros-transzformáció", "AI-architektúra"]
  -  A szenzomotoros transzformációs (reprezentációs) modell szerint a kéreg a mozgás paramétereit kódolja; korlátai vannak (fizikai, nem fiziológiai koordinátarendszerek, merev soros számítás). Ezzel szemben az optimális visszacsatolásos vezérlés (optimal feedback control) három folyamatot különít el: állapotbecslés (efferens másolattal), feladatkiválasztás és vezérlési szabályzat (control policy) — a mozgás dinamikusan, valós időben jön létre a visszacsatolási erősítések fázis- és kontextusfüggő állításával.
- **KANDEL08-018** - "Az emberi lokomóció idegi szabályozása hasonló a négylábúakéhoz; emberi CPG létezése" - *tipus:* Definition - *cimkek:* [neocortex, "emberi-CPG", "veleszületett-áramkör", "lokomóció"]
  -  Bár a legtöbb ismeret négylábú állatokból származik, az emberi lokomóció ugyanazokon az elveken alapul. Az emberi gerincvelői CPG létezését több megfigyelés támasztja alá: gerincsérültek spontán ritmikus lábmozgása, újszülöttek születés utáni ritmikus lépése, és az anenkefália (agyfélteke nélkül születettek) esetei, amelyek a híd alatti, talán teljesen gerincvelői helyzetű áramkörökre utalnak.

### Memória (Memory)

- **kandel14_longterm_genexpression** - "Második hírvivők hosszú távú génexpressziót indítanak (CREB/CBP)" - *tipus:* CausalRelation - *cimkek:* [neocortex, creb, cbp, chromatin, gene_expression, memory, long_term]
  -  Tartós receptor-aktiváció esetén a kináz átvándorol a sejtmagba és foszforilál transzkripciós faktorokat (pl. CREB), amelyek a CRE DNS-szakaszhoz kötődve, a CBP rekrutálásával (hiszton-acetiláz) megnyitják a kromatinszerkezetet. Az új fehérjeszintézés napokig-tartó változásokat hoz létre — ez a híd a rövid távú szinaptikus potenciál és a hosszú távú tanulás/emlékezet között.
- **KANDEL08-014** - "A poszterior parietális kéreg (PPC) tervezi a lokomóciót és munkamemóriát használ" - *tipus:* Pattern - *cimkek:* [neocortex, "PPC", "munkamemória", "tervezés", "parietális-kéreg"]
  -  A PPC két-három lépéssel az akadály elérése előtt növeli aktivitását, becsüli a test helyzetét a környezeti tárgyakhoz képest (limb state–object coupling), és a tárgy méretét/helyzetét munkamemóriában tárolja, hogy a hátsó végtagok koordinált lépését is lehetővé tegye, amikor az már nincs a látótérben. A premotoros kéreg és a bazális ganglionok hálózatával együtt működik.
- **KANDEL13-010** - "A parietális (LIP) és prefrontális kéreg idegsejtjei a fejlődő döntési változót reprezentálják (perzisztens, rampoló aktivitás)" - *tipus:* Pattern - *cimkek:* [neocortex, "LIP", "perzisztens-aktivitás", "munkamemória", "döntési-változó"]
  -  Az MT-től közvetve vagy közvetlenül információt kapó idegsejtek (főleg a oldalsó intraparietális terület, LIP, és a prefrontális kéreg) képesek fenntartani és frissíteni a tüzelési sebességüket: a bizonyíték halmozódásával rampszerűen nő a tüzelés. A megállító küszöb elérésekor a válasz előtt egy közös szintet érnek el. Ez a tartós aktivitás a munkamemória és a terv alapja is.
- **KANDEL13-016** - "Ismeretállapotok perzisztenciája: a tudás a szenzoros aktivitáson túl is fennmarad (temporális vastagság)" - *tipus:* Pattern - *cimkek:* [neocortex, "perzisztens-aktivitás", "munkamemória", "tudatosság", "időbeliség"]
  -  A szenzoros területek csak inger jelenlétében aktivak, de az asszociációs (parietális, temporális, prefrontális) területek perzisztens aktivitása időbeli rugalmasságot és kitartást nyújt — ez a „jelen temporális vastagsága" (Merleau-Ponty). Az ismeretállapot szerkezete megegyezik a döntésével: egy próvizórikus elköteleződés egy lehetséges viselkedési almenü valamelyik elemére.
- **KANDEL14-007** - "Hipotézis 3: hipokampális neurogenezis serkentése" - *tipus:* CausalRelation - *cimkek:* [neocortex, "neurogenezis", "hipokampusz", "memória"]
  -  Egy harmadik feltevés szerint az antidepreszáns hatékonyságát részben a hipokampális neurogenezis fokozódása közvetíti. Mivel a felnőttkori hipokampális neurogenezis a memória és a hangulatszabályozás összekapcsolását jelenti, ez a befogadó (hippokampális) és a kéregrendszeri szabályozás közti kapcsolatra utal.
- **KANDEL14-012** - "Kioltási tanulás (extinction learning) a prefrontális kéreg és hipokampusz révén" - *tipus:* CausalRelation - *cimkek:* [neocortex, "kioltási-tanulás", "hipokampusz", "prefrontális-kéreg", "memória"]
  -  Az expozíciós terápia állatkísérletes analógiában kioltási tanulást idéz elő: a fóbiás inger emléke nem törlődik, de a félelmi válasz egy új információval elnyomódik (az inger és kontextusa nem veszélyes). A prefrontális kéreg szükséges a kioltási tanuláshoz, a hipokampusz az új kontextusok tanulásához. Ez a neokortex-függő, kontextus-érzékeny újraírási minta.

### Nyelv és érzelem (Language & emotion)

- **kandel-ch29-olfactory-emotion** - Olfactory cortex → amygdala/hypothalamus (emotional & drive link) - *tipus:* CausalRelation - *cimkek:* [neocortex, emotion, amygdala, hypothalamus, value]
  -  Many olfactory cortical areas relay to the amygdala (linked to emotions) and the hypothalamus (controls basic drives such as appetite and innate behaviors). The olfactory system thus provides a direct, evolutionarily old route from sensation to emotion and motivation — a model for how a neocortex should bind sensory content to affective/value signals.

### Fejlődés (Development)

- **KANDEL08-008** - "Fejlődési molekuláris kódok határozzák meg a gerincvelői neuronok azonosságát" - *tipus:* Definition - *cimkek:* [neocortex, "molekuláris-kód", "fejlődési-azonosság", "tipizált-neuron"]
  -  A gerincvelői interneuronok és motorneuronok azonosságát transzkripciós faktorok (pl. Islt1/Tlx3, Pax2/7, Chx10, Hb9, Evx1) genetikai kódja határozza meg; minden neuronosztály saját transzmittertartalommal és jellegzetes axonvetület-mintázattal rendelkezik. Ez a molekuláris kód teszi lehetővé az adott típusok sejt-specifikus aktiválását/inaktiválását.
- **KANDEL12-001** - "Epigenetikus módosítás DNS-metilációval (epigenetic modification by DNA methylation)" - *tipus:* CausalRelation - *cimkek:* [neocortex, "epigenetika", "plaszticitás", "fenotípus-tartósság"]
  -  A korai tapasztalás a glükokortikoid-receptor (glucocorticoid receptor) gén egy kulcshelyének metilációjával (DNA methyltransferase enzim útján) tartósan bekapcsolja vagy kikapcsolja a gént. Ez a kovalens genomiális módosítás élethosszig tartó viselkedésmintázatokhoz vezet anélkül, hogy a DNS szekvenciája megváltozna.
- **KANDEL12-002** - "Magas gondozási szintű (high-LG) anya -> szelektív demetiláció -> felnőttkori tapasztalat felerősítése" - *tipus:* Pattern - *cimkek:* [neocortex, "epigenetika", "környezet-hatás", "fenotípus-tartósság"]
  -  Az alacsony-LG (low-LG) anyáról nevelt kölykökben a glükokortikoid-receptor gén metilált marad, míg a magas-LG anyáról neveltekben szelektíven demetilálódik. Így a magas-LG környezetben nevelkedő állatoknál a felnőttkori tapasztalat hatása felerősödik, és tompított (blunted) viselkedéses válasz jelenik meg a stresszorokra.
- **KANDEL12-003** - "Oxitocin és vazopresszin szabályozza az anyai kötődést és szociális viselkedést" - *tipus:* Pattern - *cimkek:* [neocortex, "szociális-viselkedés", "polipeptid-hormon", "receptor-szint"]
  -  Az oxitocin (oxytocin) a hipotalamuszban termelődik, az agyalapi mirigyen (posterior pituitary) keresztül a vérkeringésbe kerül, és szabályozza a tejleadást (milk let-down) és a szociális kötődést. Az egyedi különbségek a gondozásban az agy bizonyos területein mért oxitocin-receptor szintjével korrelálnak; a tapasztalat mind a felszabadulást, mind a receptor-szintet módosítja.
- **KANDEL12-004** - "Ösztrogén felnőttkori, ciklikus preszinaptikus újrakonfigurálása" - *tipus:* Definition - *cimkek:* [neocortex, "plaszticitás", "felnőttkori-újrakonfigurálás", "dendritikus-tövis"]
  -  Az ösztrogén (estrogen) nemcsak fejlődéskor, hanem felnőtt korban is periodikusan újrakonfigurálja egy hipotalamikus áramkör preszinaptikus kapcsolódását, így biztosítva, hogy a nőstény egér csak ovuláció és termékenység idején párzzon. A dendritikus tövis (dendritic spine) plaszticitás is ciklushoz kötötten változik — a vezetékezési diagram tehát műanyag és hormonálisan válaszoló.
- **KANDEL12-005** - "Szerveződési (organizational) vs aktivációs (activational) fejlődési fázis" - *tipus:* Definition - *cimkek:* [neocortex, "kritikus-ablak", "fejlődési-fázis", "reverzibilitás"]
  -  A nemi szteroidhormonok egy korai, kritikus ablakban visszafordíthatatlanul megszervezik (organize) a viselkedés idegrendszeri alapját, míg felnőtt korban ugyanezen hormonok hevenyben és reverzíbilisen aktiválják (activate) a nemre jellemző válaszokat. Ez a kétlépéses séma a maszkulinizáció gerincét adja.
- **KANDEL12-006** - "A tesztoszteron aromatizációja ösztrogénné a maszkulinizációhoz" - *tipus:* CausalRelation - *cimkek:* [neocortex, "hormonális-differenciáció", "aromatizáció", "kritikus-ablak"]
  -  A perinatális tesztoszteron-söprés nagyrészt helyi aromatizáció (aromatase enzim) útján ösztrogénné alakulva maszkulinitálja az agyat. Az ösztrogén (vagy tesztoszteron) újszülött rágcsáló nőstényeknél maszkulinizálja az agyat; felnőttkorban a tesztoszteron és az ösztrogén együtt facilitálja a hímre jellemző szociális interakciókat.
- **KANDEL12-007** - "Nemi dimorf viselkedések moduláris genetikai irányítása (modular genetic manner)" - *tipus:* Pattern - *cimkek:* [neocortex, "kategoriaelmelet", "moduláris-architektúra", "elosztott-vezérlés"]
  -  Az egyes nemi hormonnal szabályozott gének csak a szexuálisan dimorf szociális interakciók egy részhalmazát befolyásolják, nem a teljes viselkedési programot. Különböző gének különböző neuronpopulációkban hatnak, így az irányítás sok különböző neuroncsoport között elosztott (distributed) — ez a moduláris kompozíció analóg a kategóriaelméleti összetétel-elvvel (egy kompozíció több független morfizmust kombinál).
- **KANDEL12-008** - "Megosztott áramkörök eltérő kulcs-neuronpopulációkkal (shared circuits, dimorphic key populations)" - *tipus:* Pattern - *cimkek:* [neocortex, "elosztott-vezérlés", "kulcs-populáció", "architektúra"]
  -  A legtöbb viselkedés mindkét nemnél közös, és a szexuális dimorfizmus a közös áramkörökbe ágyazott kulcs-neuronpopulációk aktivitásából és kapcsolódásából ered. Ezek a populációk a szenzoros, motoros és közvetítő (intermediary) neuronok szintjén egyaránt előfordulnak, és hím- vagy nőstény-típusú irányba tolják a viselkedési kimenetet.
- **KANDEL12-009** - "Szexuálisan dimorf viselkedések elosztott (distributed) irányítása" - *tipus:* Pattern - *cimkek:* [neocortex, "kategoriaelmelet", "elosztott-vezérlés", "robusztusság"]
  -  A dimorf viselkedések moduláris irányítása jól illeszkedik az elképzeléshez, hogy a legtöbb áramkör mindkét nemnél közös, és a viselkedésbeli különbségek a kulcs-populációk által módosított áramköri működésből adódnak. A különböző viselkedések idegi irányítása több, különböző neuronpopuláció között oszlik meg — nincs egyetlen, mindent irányító neuronpopuláció (funktor-kompozíció: a teljes tér több morfizmus képe).
- **KANDEL12-010** - "Androgén-receptor az idegrendszerben (neonatális maszkulinizáció)" - *tipus:* CausalRelation - *cimkek:* [neocortex, "receptor", "szövetspecifikusság", "hormonális-differenciáció"]
  -  Azok a hím egerek, amelyeknek az androgén-receptor (androgen receptor) hiányzik kizárólag az idegrendszerből, külsőleg ép hímeknek látszanak, de csökkent intenzitású hím-típusú szexuális és agresszív viselkedést mutatnak. Ez igazolja, hogy a maszkulinizáció irányítása az idegrendszeri androgén-receptor jelenlététől függ.
- **KANDEL12-012** - "Korai tapasztalat emberi hatása: bántalmazás -> glükokortikoid-receptor promóter metilációja" - *tipus:* CausalRelation - *cimkek:* [neocortex, "epigenetika", "emberi-megfeleltetés", "fenotípus-tartósság"]
  -  Posztumusz emberi vizsgálatok azt mutatják, hogy a gyermekkorban bántalmazott felnőttek glükokortikoid-receptor génjük promóterének nagyobb metilációját mutatják, mint a kontrollcsoport. Az árvaházban, kevés egyéni gondozásban nevelkedett gyerekek alacsonyabb oxitocin- és vazopresszin-szintet mutatnak évekkel a nevelőszülőhöz kerülés után is.
- **KANDEL12-013** - "BNST szexuális dimorfizmusa és kapcsolata a nemi identitással" - *tipus:* Example - *cimkek:* [neocortex, "szerkezeti-dimorfizmus", "nemi-identitás", "BNST"]
  -  Az emberi stria terminalis térbeli magja (bed nucleus of the stria terminalis, BNST) szignifikánsan több idegsejtet tartalmaz férfiakban, mint nőkben; a nővé változtatott (male-to-female) transzszexuálisok BNST-je kisebb, a férfivá változtatottaké nagyobb. A patkány megfelelője a másik nem felismerésében játszik szerepet — az emberi BNST így a nemi identitáshoz kötődő, de szexuális irányultságtól független struktúra.
- **KANDEL12-014** - "Közös sejtszintű mechanizmusok: apoptózis, neuritakiterjedés, szinapszis-képződés" - *tipus:* Pattern - *cimkek:* [neocortex, "fejlődési-mechanizmus", "újrahasználat", "architektúra"]
  -  A nemi hormonok a neurális útvonalak szexuális differenciációját olyan sejtes folyamatokkal végzik, amelyeket más fejlődési eseményeknél is széles körben használnak: apoptózis (sejthalál), neuritakiterjedés (neurite extension) és szinapszis-képződés (synapse formation). Ezek a mechanizmusok hozzák létre a neuronok számának, kapcsolódásának és élettani tulajdonságainak nemi különbségeit.

### Döntés és tudatosság (Decision & consciousness)

- **KANDEL13-001** - "Jel–zaj–küszöb keret (signal detection theory): a döntés mint a bizonyíték és a kritérium összevetése" - *tipus:* Definition - *cimkek:* [neocortex, "signal-detection", "küszöb", "kritérium"]
  -  Egy észlelési döntés akkor születik, ha a bizonyíték (a jel) mértéke átlép egy küszöböt (kritériumot). Ha a küszöb alacsony, a téves riasztás (false alarm) gyakori; ha magas, az elszalasztás (miss) gyakori. A két eloszlás (jel-jelen / csak-zaj) átfedése határozza meg az alapvető pontosságot, függetlenül a küszöb beállításától.
- **KANDEL13-002** - "A kritérium (küszöb) a döntéshozó irányított szabálya és attitűdje, nem a zajé" - *tipus:* Pattern - *cimkek:* [neocortex, "kritérium", "politika", "érték-alapú"]
  -  A küszöb egy döntési szabályt valósít meg, amely a probléma ismeretét (a két hiba relatív költségét) és a helyes válasz pozitív, illetve a hiba negatív értékelését kódolja. A döntéshozót a politikája (küszöbe) miatt dicsérjük vagy kritizáljuk, nem a mérés zajos tökéletlensége miatt. Ezt a politikát a döntéshozó irányítja és érte felelősséggel tartozik.
- **KANDEL13-003** - "ROC-görbe (receiver operating characteristic): a küszöb változtatása a pontosság függvényében" - *tipus:* Pattern - *cimkek:* [neocortex, "signal-detection", "ROC"]
  -  A ROC-görbe mutatja, hogyan függ a helyes „igen" (találat) és a téves „igen" (téves riasztás) valószínűsége egymástól adott küszöb mellett. A görbe a mérés megbízhatóságáról (a két eloszlás szétválásáról) szól, függetlenül a döntéshozó szabályától; a küszöb a döntéshozó politikájáról árulkodik.
- **KANDEL13-004** - "A döntési változó (decision variable) két ellentétes idegsejt-populáció tüzelési sebességének különbségeként" - *tipus:* Definition - *cimkek:* [neocortex, "döntési-változó", "vetítés", "populáció-kód"]
  -  A bizonyítékot a vizuális kéreg irány szelektív idegsejtjeinek (pl. jobbra- és balra- prefereáló) tüzelési sebességei közötti különbség reprezentálja. A döntés akkor születik, ha ezt a különbséget egy küszöbhöz (itt: zérus) viszonyítjuk: pozitív → jobb, negatív → bal. Ez a magas dimenziós szenzoros bizonyíték egyetlen skalárrá való leképezése.
- **KANDEL13-005** - "Az MT terület irány szelektív idegsejtjei szolgáltatják a zajos bizonyíték-mintákat" - *tipus:* Definition - *cimkek:* [neocortex, "MT", "zajos-minta", "populáció-kód"]
  -  A magasabb emlősök látókérgében (V1 → MT) az irány szelektív idegsejtek tüzelése zajos: bármely próbán a tüzelési sebesség egy eloszlásból vett véletlen húzásnak tekinthető. A 0% koherenciájú (tiszta zaj) ingerre is tüzelnek, mert a dinamikus véletlen pontok minden irányt tartalmaznak. A jobb- és bal-preferáló populáció válaszai együtt érhetők el, így a bizonyíték a két átlag különbségeként jellemezhető.
- **KANDEL13-006** - "Korlátos bizonyíték-felhalmozódás (bounded evidence accumulation) és a sebesség–pontosság kompromisszum" - *tipus:* Pattern - *cimkek:* [neocortex, "catamorfizmus", "kategoriaelmelet", "drift-diffusion", "időzített-megállás"]
  -  A zajos bizonyíték időben halmozódik fel (két ellentétes irányú, gyengén anticorrelált random walk), amíg az egyik felhalmozódás el nem éri a felső megállító határt (küszöb) — ekkor születik a válasz. A határok közelebb helyezése gyors, de hibázó döntést ad; távolabb helyezése lassú, de pontosabbat. Ez magyarázza a sebesség–pontosság kompromisszumot.
- **KANDEL13-007** - "A mikrostimuláció (Newsome) ok-okozati kapcsolatot igazol: az MT idegsejtek a bizonyítékot szolgáltatják" - *tipus:* CausalRelation - *cimkek:* [neocortex, "ok-okozat", "mikrostimuláció", "MT", "kauzalitás"]
  -  Az MT területen egy irány szerint prefereált idegsejt-klaszter gyenge árammal való stimulációja (mikrostimuláció) a majom döntését az adott irány felé torzítja, de nem okoz látási hallucinációt. A hatás akkor a legnagyobb, ha a mozgás gyenge (nehéz a döntés). Ez azt mutatja: ezek az idegsejtek okozati láncban részt vevő bizonyítékot adnak.
- **KANDEL13-008** - "Csapda: a részleges perturbáció csak a nehéz (alacsony jel-zaj arányú) rezsimben mutat hatást" - *tipus:* Pitfall - *cimkek:* [neocortex, "csapda", "perturbáció", "kísérlettervezés"]
  -  Ha a perturbációt (stimuláció vagy elnémítás) csak a számításban részt vevő idegsejtek kis hányadára korlátozzuk, a könnyű feltételek mellett nulla hatást mérünk, és tévesen következtetnénk arra, hogy az adott terület nem okozati. Ez a szabály, nem a kivétel a magasabb kéregfunkciók vizsgálatában: a hatás csak a kis különbséget jelentő (nehéz) rezsimben válik észlelhetővé.
- **KANDEL13-009** - "A log-valószínűségi hányados (logLR) felhalmozódása: a szorzás összegzéssé alakítása (monoid-homomorfizmus)" - *tipus:* CausalRelation - *cimkek:* [neocortex, "kategoriaelmelet", "monoid", "log-valószínűség", "homomorfizmus"]
  -  Több forrásból származó bizonyíték egyesítésekor a megfelelő művelet a valószínűségi hányadosok szorzata, ami a logaritmus miatt összegre (logLR) vált: log(x·y) = log x + log y. Az agy ezeket a logLR-inkrementumokat adja össze, így a statisztikus bizonyíték-egyesítés egy additív halmazzá (monoiddá) válik. Ez a felhalmozódás ugyanaz a mechanizmus, mint a perceptuális döntésé, csak absztraktabb forrásokkal.
- **KANDEL13-011** - "A valószínűségi következtetés (időjárás-jósló feladat) ugyanazt a felhalmozódási mechanizmust használja, mint a perceptuális döntés" - *tipus:* CausalRelation - *cimkek:* [neocortex, "kategoriaelmelet", "probabilisztikus-következtetés", "catamorfizmus"]
  -  Majmokat meg lehet tanítani szimbólumokból (alakokból) álló valószínűségi következtetésre. Az LIP idegsejtek ugyanúgy a bizonyíték futó összegét (a logLR-ek szummaját) kódolják, mint a mozgási feladatban; a tüzelési sebesség növekménye arányos a szimbólum megbízhatóságával. A perceptuális döntés mechanizmusa tehát általánosabb kognitív funkciókra is kiterjed.
- **KANDEL13-012** - "Érték-alapú döntések: két tétel értékének különbsége vezérli a választást, mint a perceptuális döntésnél" - *tipus:* Pattern - *cimkek:* [neocortex, "érték-alapú", "preferencia", "striatum", "zajos-reprezentáció"]
  -  Az előnyben részesítés (preferencia) döntései a tételhez rendelt érték különbségén alapulnak, akárcsak a bal/jobb mozgásnál az irány szelektív idegsejtek tüzelési különbsége. Az értéket kódoló idegsejtek (striatum = cselekvés értéke; orbitofrontális és cinguláris kéreg = tétel értéke) zajosak, és a két hasonló értékű tétel közötti választás tovább tart (sebesség– következetesség kompromisszum).
- **KANDEL13-013** - "A tudatosság mint a nem-tudatos agy „jelentési" (report) döntése — a provizórikus affordancia keret" - *tipus:* Definition - *cimkek:* [neocortex, "tudatosság", "affordancia", "provizórikus-elköteleződés", "elmélet-elme"]
  -  A fejezet hipotézise szerint a tudatos tudás akkor születhet meg, ha a nem-tudatos agy eljut a döntésre, hogy egy tételt egy másik elmének (vagy önmagának) jelez. A „jelentés" is egy provizórikus affordancia — akárcsak a tekintés, a nyúlás vagy a megragadás lehetősége. Az ismeretállapot egy próvizórikus elköteleződés egy állítás (propozíció) mellett, nem feltétlenül jár cselekvéssel.
- **KANDEL13-014** - "Affordancia (Gibson): a provizórikus elköteleződés egy lehetséges cselekvés (terv) mellett" - *tipus:* Definition - *cimkek:* [neocortex, "affordancia", "Gibson", "provizórikus-elköteleződés", "tudatosság"]
  -  Gibson szerint az objektumok és környezet tulajdonságai „affordanciákat" (lehetőségeket) kínálnak az állat viselkedésére (megragadás, dobás, elrejtés). A döntéskutatás szemszögéből az affordancia egy provizórikus elköteleződés egy terv mellett — a cselekvés lehet, hogy most vagy soha nem következik be. Az asszociációs kéreg idegsejtjei nem közvetlen parancsot adnak, hanem a cselekvés lehetőségét (szándékot) reprezentálják.
- **KANDEL13-015** - "Két anticorrelált felhalmozódás mint a bal/jobb lehetőségek kettős (duális) reprezentációja" - *tipus:* Pattern - *cimkek:* [neocortex, "kategoriaelmelet", "duális-reprezentáció", "anticorreláció", "szimmetria"]
  -  A bal és jobb lehetőség felhalmozódása gyengén anticorrelált: a bizonyíték a bal mellett a jobb ellen szól (és fordítva). A két folyamat együtt, de nem tökéletesen tükröződően fejlődik, mert a jobb- és bal-preferáló idegsejtek saját zaja további varianciát visz be. Egyetlen felhalmozódással is leírható, amely egy felső vagy egy alsó határon áll meg.

### Idegrendszeri zavarok (Disorders)

- **KANDEL08-012** - "A bazális ganglionok módosítják a kéregi és agytörzsi áramköröket; Parkinson-kór" - *tipus:* CausalRelation - *cimkek:* [neocortex, "bazális-ganglion", "Parkinson", "motoros-mintázat-kiválasztás", "betegség"]
  -  A bazális ganglionok (minden gerincesben jelen vannak) a különböző motoros mintázatok kiválasztásában vesznek részt. A PPN-be küldött gátló (SNr, GPi GABAerg) és serkentő (STN glutamaterg) bemenetek szabályozzák a PPN aktivitását. A Parkinson-kórban a substantia nigra dopaminerg bemenetének pusztulása megzavarja ezt, lassú, csoszogó járást és gait-freezinget okozva.
- **KANDEL08-019** - "Rehabilitációs tréning (treadmill + testtömeg-támasz) javítja a járást gerincsérülés után" - *tipus:* Example - *cimkek:* [neocortex, "rehabilitáció", "szinapszis-plaszticitás", "gerincsérülés", "betegség"]
  -  Részleges gerincsérülés esetén a preferált kezelés a rehabilitációs tréning. A testtömeg-támasztott futószalagos (weight-supported treadmill) lépéstréning a gerincvelői áramkörok plaszticitásán és a megmaradt lefelé irányuló pályákon átvihető parancsjeleken alapul; a funkcionális javulás 44 krónikus betegben 3–20 hét után kimutatható volt.
- **KANDEL14-001** - "Szelektív szerotonin-visszavétel-gátlók (Selective Serotonin Reuptake Inhibitors, SSRI)" - *tipus:* Definition - *cimkek:* [neocortex, "szerotonerg-rendszer", "szinaptikus-átvitel"]
  -  A fluoxetin, szerteralin és paroxetin típusú szerek szelektíven gátolják a SERT (szerotonin-transzporter) fehérjét. Hatásosságuk nem nagyobb a régebbi triciklikus és MAO-gátló szereknél, de enyhébb mellékhatásaik és túladagolás esetén nagyobb biztonságuk miatt széles körben használatosak.
- **KANDEL14-002** - "Szerotonerg és noradrenerg szinaptikus gyógyszercélpontok (Figure 61–7)" - *tipus:* Pattern - *cimkek:* [neocortex, "szinaptikus-átvitel", "gyógyszer-célpont", "moduláris-architektúra"]
  -  Az antidepresszánsok hatása a szerotonerg és noradrenerg szinapszis hat lépésére osztható: (1) enzimaktikus szintézis, (2) hólyagos tárolás, (3) preszinaptikus receptorok negatív visszacsatolása, (4) posztszinaptikus receptorok, (5) visszavétel (uptake), (6) lebontás (degradáció, MAO). A szerotonin- és noradrenalin-transzporter valamint a MAO az antidepresszánsok elsődleges célpontja.
- **KANDEL14-003** - "Veszikuláris monoamin-transzporter (VMAT2) gátlása rezerpinnel" - *tipus:* CausalRelation - *cimkek:* [neocortex, "szinaptikus-tárolás", "visszacsatolás"]
  -  A rezerpin és tetrabenazin blokkolja a VMAT2-t, megakadályozva a szerotonin, a katekolaminok és a dopamin szinaptikus hólyagokba jutását. A citoplazmában maradt ingerületátvivő anyag lebomlik, így a neuron kimerül az ingerületátvivő anyagból. A rezerpin gyakran okozott depressziót mellékhatásként.
- **KANDEL14-004** - "Terápiás hatás késleltetése (delay of therapeutic effect)" - *tipus:* CausalRelation - *cimkek:* [neocortex, "szinaptikus-plaszticitás", "időzítés"]
  -  Bár az antidepresszánsok az első adaggal kötődnek és gátolják a MAO-t, a NET-et vagy a SERT-et, a depresszív tünetek enyhülése általában csak hetekig tartó kezelés után észlelhető. Ez a késleltetés a legfőbb akadálya a gyógyszerek hatásmechanizmusának megértésének.
- **KANDEL14-005** - "Hipotézis 1: újonnan szintetizált fehérjék lassú felhalmozódása" - *tipus:* Pattern - *cimkek:* [neocortex, "szinaptikus-plaszticitás", "tanulás"]
  -  Az egyik magyarázat szerint a gyorsan felhalmozódó, újonnan szintetizált fehérjék lassú felépülése megváltoztatja az idegsejtek válaszkészségét oly módon, amely kezeli a depressziót. Ez a "lassú sejtszintű újraprogramozás" mintázat a neokortex tanulási mechanizmusainak analógja lehet.
- **KANDEL14-006** - "Hipotézis 2: szinaptikus súlyok új tapasztalatok általi módosítása" - *tipus:* CausalRelation - *cimkek:* [neocortex, "szinaptikus-plaszticitás", "súly-alapú-tanulás", "tanulás"]
  -  A szerotonin vagy noradrenalin szinaptikus átvitelének gyors emelkedése gyorsan növeli a plaszticitást különböző érzelem-feldolgozó áramkörökben; a terápiás haszon késése azon az időn múlik, amelyre az új tapasztalatoknak szükségük van a szinaptikus súlyok megváltoztatásához. Ez közvetlenül kapcsolódik a neokortex súly-alapú tanulási paradigmájához.
- **KANDEL14-008** - "Ketamin: gyors hatású NMDA-glutamát-receptor-blokkoló antidepresszáns" - *tipus:* Definition - *cimkek:* [neocortex, "glutamáterg-rendszer", "szinaptikus-plaszticitás", "gyors-tanulás"]
  -  A ketamin, amely blokkolja az N-metil-D-aszpartát (NMDA) glutamát-receptort, intravénás infúzióval 2 órán belül antidepresszáns hatást fejt ki, szemben a hetekig tartó hagyományos szerekkel. A hatás kb. 7 napig tart. Ez az első olyan antidepresszáns, amelynek elsődleges hatása nem a monoaminerg ingerületátvitelen alapul.
- **KANDEL14-009** - "NMDA-receptor-blokkolás mint szinaptikus plaszticitás-kapu" - *tipus:* Pattern - *cimkek:* [neocortex, "glutamáterg-rendszer", "LTP", "szinaptikus-plaszticitás"]
  -  Mivel a ketamin az NMDA (glutamát) receptoron hat, és a gyors antidepresszáns hatás nem monoaminerg úton jön létre, a szer a glutamáterg plaszticitás (például a hosszú távú potenciálás, LTP) közvetlen módosítójaként értelmezhető. Ez a neokortex-szerű architektúrában a "tanulási sebesség" modulálhatóságát demonstrálja egyetlen receptoros kapu által.
- **KANDEL14-010** - "Szinapszisban maradó ingerületátvivő koncentráció növekedése visszavétel-gátlással" - *tipus:* CausalRelation - *cimkek:* [neocortex, "szinaptikus-átvitel", "visszacsatolás"]
  -  A szelektív visszavétel-gátlók (például fluoxetin a szerotonin-, reboxetin a noradrenalin-transzporterre) növelik a szinaptikus ingerületátvivő koncentrációját azáltal, hogy megakadályozzák az újrafelvételt. Ez a lokális koncentráció-emelkedés a további plasztikus válasz (KANDEL14-006) előfeltétele.
- **KANDEL14-011** - "Hipokampális–kérgi szabályozás a hangulatban: a rostralis anterior (subgenualis) cinguláris kéreg" - *tipus:* CausalRelation - *cimkek:* [neocortex, "kérgi-hálózat", "mélyagyi-ingerlés", "hangulat"]
  -  A szomorúság aktiválja a rostralis anterior (subgenualis) cinguláris kérget (Brodmann 25 terület, Cg25). Mélyagyi ingerléssel (DBS) kezelt, terápiarezisztens depresszióban a Cg25 aktivitása csökken a pozitívan reagáló betegeknél. Ez a kéregrégió a hangulatszabályozó hálózat egy megcélozható csomópontja.
- **KANDEL14-013** - "Kognitív viselkedésterápia: automatikus negatív gondolatok korrekciója" - *tipus:* Pattern - *cimkek:* [neocortex, "figyelmi-torzítás", "kérgi-feldolgozás", "tanulás"]
  -  A kognitív terápiák a depressziósok túlzott negatív figyelmi torzítását (automatikus negatív interpretáció, semleges események negatívként értelmezése) célozzák. Az ilyen automatikus negatív gondolkodás, amely elindíthatja vagy fenntarthatja a levert hangulatot, kognitív pszichoterápiával javítható. Ez a "figyelmi torzítás" mint a kérgi feldolgozás hibás súlyozása értelmezhető.
- **KANDEL14-014** - "Elektrokonvulzív terápia (ECT) és a nagyfokú ingerületátvivő-felszabadulás" - *tipus:* CausalRelation - *cimkek:* [neocortex, "szinaptikus-plaszticitás", "gén-aktiváció", "neuromoduláció"]
  -  Modern érzéstelenítésben alkalmazott ECT orvosilag biztonságos, hatékony akut major depresszió ellen. Rágcsálókban az ECT hatalmas ingerületátvivő- felszabadulást vált ki, ami jelentős génexpressziós aktivációt és feltételezhetően nagyléptékű idegi plaszticitást okoz. A pontos molekuláris út ismeretlen marad.
- **KANDEL14-015** - "Transzkraniális mágneses ingerlés (TMS) mint nem invazív neuromoduláció" - *tipus:* Pattern - *cimkek:* [neocortex, "neuromoduláció", "prefrontális-kéreg", "TMS"]
  -  A TMS rövid, gyorsan váltakozó mágneses impulzusokat juttat az agykéreg alatti axonokba, ott áramot indukálva. A bal prefrontális kéreg napi ingerlése biztonságos és FDA-jóváhagyással rendelkezik, bár későbbi vizsgálatokban csak mérsékelt hatékonyságú. A minta: külső, célzott mezővel a kérgi aktivitás módosítása.
- **KANDEL14-016** - "Mélyagyi ingerlés (DBS) olvasó-író elektródákkal a hálózati megértéshez" - *tipus:* Pattern - *cimkek:* [neocortex, "mélyagyi-ingerlés", "neuromoduláció", "olvasó-író", "kérgi-hálózat"]
  -  A DBS invazív neuromoduláció: elektróda (például a subgenualis cinguláris kéregben, Cg25) ingerli a célpontot, a külső vezérlő a stimulációs rátát szabályozza. Új, kutatási "olvasó-író" elektródák nemcsak stimulálnak, hanem rögzítik az extracelluláris neuronális aktivitást is, ezzel előrevihetik a körzavar (circuit dysfunction) és terápiás moduláció megértését.
- **KANDEL14-017** - "Lítium mint hangulatstabilizátor: GSK3β (glikogén-szintáz-kináz 3 béta) gátlása" - *tipus:* CausalRelation - *cimkek:* [neocortex, "Wnt-jelátvitel", "hangulatstabilizálás", "kináz"]
  -  A lítium a bipoláris zavar akut mánia és a hangulatciklus-stabilizálására hatékony. Legtöbb valószínűsíthető molekuláris célpontja a glikogén-szintáz- kináz 3β (GSK3β) gátlása, a Wnt jelátviteli út egyik komponense, amelynek számos funkciója van az idegrendszerben. A hangulatstabilizátorok a hangulatszabályozó rendszerek dinamikáját csillapítják.
- **KANDEL14-018** - "Hangulat komplex dinamikus integrációja (környezet + belső bemenetek)" - *tipus:* Pattern - *cimkek:* [neocortex, "több-bemenetű-integráció", "dinamikus-hálózat", "cirkadián"]
  -  A hangulatot a külső környezet és több belső bemenet (hormonális miliő, immunmodulátorok, cirkadián szabályozás) együttese szabályozza. A szerotonerg és noradrenerg rendszerek is mutatnak a cirkadián (alvás-ébrenlét) ciklushoz szorosan kapcsolódó napi ingadozást. Az integráció dinamikus kölcsönhatásokból áll, amelyek még kevéssé értettek — egy több-bemenetű, több-időskálájú szabályozó hálózat, amely a neokortex szintű integráció analógja.
- **KANDEL14-019** - "Másodgenerációs antipszichotikumok: D2 + 5-HT2A receptorblokád" - *tipus:* Pattern - *cimkek:* [neocortex, "dopaminerg-rendszer", "szerotonerg-rendszer", "receptorblokád"]
  -  Valamennyi antipszichotikum a D2 dopamin-receptor blokkolásával hat, de a másodgenerációs szerek alacsonyabb affinitással kötődnek a D2-höz, és emellett szerotonin 5-HT2A receptorokat is blokkolnak, így kevésbé okoznak súlyos motoros mellékhatásokat. A bipoláris zavar és az akut mánia kezelésére is használatosak.
- **KANDEL14-020** - "Félelem és szorongás idegi áramköre: amigdala és prefrontális kéreg összeköttetései" - *tipus:* Definition - *cimkek:* [neocortex, "amigdala", "prefrontális-kéreg", "kérgi-hálózat", "félelem"]
  -  A félelem és szorongás zavarainak idegi áramköre az amigdalát és annak a prefrontális kéreggel való összeköttetéseit foglalja magában. A major depresszió és a bipoláris zavar áramköre kevésbé ismert, de emberi neuroképi vizsgálatok az érzelmi jelentőség (salience) feldolgozásában és a kognitív kontrollban érintett köröket azonosítottak.

---

## (b) E8 indexer - neocortex / kategoriaelmelet / E8 cimkeju jegyzetek

**Magyar:** Az alábbiak minden olyan jegyzetet felsorolnak, amelyet `neocortex`,
`kategoriaelmelet` vagy `E8` címkével láttak el. Minden sorhoz 1-2 mondatos
**fogalmi híd** (conceptual bridge) tartozik a Szima célhoz: egy neokortex-szerű,
kategoriaelméletre és az E8 kivételes csoportra épülő mesterséges intelligencia.
Megjegyzés: közvetlen `E8` címkével ellátott jegyzet nincs (számláló = 0); az
E8 híd a `neocortex`/`kategoriaelmelet` jegyzeteken keresztül valósul meg.

**English:** Every note tagged `neocortex`, `kategoriaelmelet`, or `E8`, each with a
1-2 sentence conceptual bridge to the Szima goal (a neocortex-like AI grounded in
category theory + E8). No note carries the bare `E8` tag, so the E8 bridge is reached
via the neocortex / category-theory notes.

### Membrán biofizika (Membrane biophysics)

- **kandel_01_actionpot** - Cselekvési potenciál (Action Potential)
  - *Szima-hid:* Szima-híd: a csatorna szelektív áteresztése az E8xE8 algebrai sűrűség-vektoraiként (bal E8 = tér, jobb E8 = szín) modellezhető; a membránfeszültség a FazisAlgebra "fázis" dimenziója, a mérés pedig a Steane713 [[7,1,3]] kód egy bitje.
- **kandel_01_napot_recon** - Cselekvési potenciál rekonstrukciója Na/K csatornákbol
  - *Szima-hid:* Szima-híd: a csatorna szelektív áteresztése az E8xE8 algebrai sűrűség-vektoraiként (bal E8 = tér, jobb E8 = szín) modellezhető; a membránfeszültség a FazisAlgebra "fázis" dimenziója, a mérés pedig a Steane713 [[7,1,3]] kód egy bitje.

### Szinaptikus átvitel (Synaptic transmission)

- **kandel_01_synapse_overview** - Szinapszis — elektromos vs kémiai
  - *Szima-hid:* Szima-híd: a kvantált felszabadulás a [[7,1,3]] Steane-kód egy bitjének felel meg; a kémiai szinapszis felerősítése a KategoriaElmelet morfizmus-kompozíciójának (összetett függvény) és a szorzásnak (product) megfelelője.
- **kandel_01_chemsynapse_amp** - Kémiai szinapszisok felerősítik a jelet
  - *Szima-hid:* Szima-híd: a kvantált felszabadulás a [[7,1,3]] Steane-kód egy bitjének felel meg; a kémiai szinapszis felerősítése a KategoriaElmelet morfizmus-kompozíciójának (összetett függvény) és a szorzásnak (product) megfelelője.
- **kandel_01_neurotransmitter_release** - Neurotranszmitter-kibocsátás diszkrét csomagokban (kvantális)
  - *Szima-hid:* Szima-híd: a kvantált felszabadulás a [[7,1,3]] Steane-kód egy bitjének felel meg; a kémiai szinapszis felerősítése a KategoriaElmelet morfizmus-kompozíciójának (összetett függvény) és a szorzásnak (product) megfelelője.

### Neuromoduláció és másodlagos hírvivők (Neuromodulation & second messengers)

- **kandel14_gprotein_direct_gating** - "G-fehérje közvetlen ioncsatorna-nyitása (GIRK, βγ-alegység)"
  - *Szima-hid:* Szima-híd: a moduláció a FazisAlgebra "fázis" komponensének átállítása, amely a három kubit (saját/másik/fázis) kapcsolatirányát módosítja; a több modulátor konvergenciája a KategoriaElmelet kolimit (colimit) fogalma mint a bejövő nyílak univerzális összegzése.
- **kandel14_pip2_mchannel** - "M-típusú K+ csatorna zárása PIP2 hidrolízissel (ACh)"
  - *Szima-hid:* Szima-híd: a moduláció a FazisAlgebra "fázis" komponensének átállítása, amely a három kubit (saját/másik/fázis) kapcsolatirányát módosítja; a több modulátor konvergenciája a KategoriaElmelet kolimit (colimit) fogalma mint a bejövő nyílak univerzális összegzése.
- **kandel14_firing_rate_modulation** - "GIRK aktiváció csökkenti a spontán tüzelési rátát"
  - *Szima-hid:* Szima-híd: a moduláció a FazisAlgebra "fázis" komponensének átállítása, amely a három kubit (saját/másik/fázis) kapcsolatirányát módosítja; a több modulátor konvergenciája a KategoriaElmelet kolimit (colimit) fogalma mint a bejövő nyílak univerzális összegzése.
- **kandel14_ca_channel_inhibition** - "G-fehérje βγ gátolja a feszültségfüggő Ca2+ csatornákat"
  - *Szima-hid:* Szima-híd: a moduláció a FazisAlgebra "fázis" komponensének átállítása, amely a három kubit (saját/másik/fázis) kapcsolatirányát módosítja; a több modulátor konvergenciája a KategoriaElmelet kolimit (colimit) fogalma mint a bejövő nyílak univerzális összegzése.
- **kandel14_convergence** - "Több neuromodulátor konvergál ugyanarra a neuronra és csatornára"
  - *kategoriaelmelet-hid:* Kategoriaelmelet-híd: a több neuromodulátor konvergenciája ugyanarra a neuronra a KategoriaElmelet kolimit (colimit) fogalma - a különböző forrásokból érkező nyílak egy univerzális célobjektumban (a sejt válasza) egyesülnek; a polimorfizmus a funktor-többalakúság.
- **kandel14_circuit_reconfiguration** - "Egyetlen modulátor újrakonfigurál egy teljes áramkört (dopamin, STG)"
  - *Szima-hid:* Szima-híd: a moduláció a FazisAlgebra "fázis" komponensének átállítása, amely a három kubit (saját/másik/fázis) kapcsolatirányát módosítja; a több modulátor konvergenciája a KategoriaElmelet kolimit (colimit) fogalma mint a bejövő nyílak univerzális összegzése.
- **kandel14_why_many** - "Miért ennyi modulátor? — plaszticitás ÉS stabilitás"
  - *Szima-hid:* Szima-híd: a moduláció a FazisAlgebra "fázis" komponensének átállítása, amely a három kubit (saját/másik/fázis) kapcsolatirányát módosítja; a több modulátor konvergenciája a KategoriaElmelet kolimit (colimit) fogalma mint a bejövő nyílak univerzális összegzése.
- **kandel14_metabotropic_binding** - "Metabotrop receptorok két nagy családja"
  - *Szima-hid:* Szima-híd: a moduláció a FazisAlgebra "fázis" komponensének átállítása, amely a három kubit (saját/másik/fázis) kapcsolatirányát módosítja; a több modulátor konvergenciája a KategoriaElmelet kolimit (colimit) fogalma mint a bejövő nyílak univerzális összegzése.

### Plaszticitás és tanulás (Plasticity & learning)

- **kandel_01_nmda** - NMDA receptor — hosszú távú szinaptikus plasticitás alapja
  - *kategoriaelmelet-hid:* Kategoriaelmelet-híd: az NMDA receptor koaktivációja (pre+poszt) és a Mg-blokk eltávolítása egy span/kétoldali feltétel, amely a KategoriaElmelet leképezésében (pullback) egy univerzális objektumot ad - a szinaptikus súly a morfizmus, a Ca-beáramlás a struktúra képződése.
- **kandel_01_hebbian** - Hebbi plasticitás azonosítja a domináns bemeneti mintákat
  - *kategoriaelmelet-hid:* Kategoriaelmelet-híd: a Hebb-szabály ("együtt tüzelők összekapcsolódnak") a KategoriaElmelet gráf/kategória kompozíciójának elegyesítése: a gyakran együtt aktivált csomópontok közötti él (morfizmus) súlya nő, ez a fogalom-struktúra (ontology) kialakulása.
- **kandel_01_synaptic_plasticity** - Tanulás és memória a szinaptikus plasticitástól függ
  - *kategoriaelmelet-hid:* Kategoriaelmelet-híd: a "tanulás és memória a plaszticitástól függ" ok-okozat a KategoriaElmelet funktor-kompozíciójaként írható le - a viselkedés végobjektum (terminal) a szinaptikus súly-kategória egy leképezése.
- **kandel_01_ltp** - Az NMDA receptor tulajdonságai alátámasztják a hosszú távú szinaptikus plasticitást
  - *Szima-hid:* Szima-híd: a Hebb-szabály a KategoriaElmelet struktúraképző funktora - a gyakran együtt aktivált csomópontok éle megerősödik; az LTP a Steane713 kód szavának tartós, hibajavított újrakódolása.
- **kandel14_camp_pka_schannel** - "cAMP-függő PKA zárja az S-típusú K+ csatornát (Aplysia, szerotonin)"
  - *Szima-hid:* Szima-híd: a Hebb-szabály a KategoriaElmelet struktúraképző funktora - a gyakran együtt aktivált csomópontok éle megerősödik; az LTP a Steane713 kód szavának tartós, hibajavított újrakódolása.

### Neurális jelzés és architektúra (Neuronal signaling & architecture)

- **kandel_01_signaling_uniform** - A jelzés minden idegsejtben ugyanúgy szerveződik
  - *Szima-hid:* Szima-híd: az universális négykomponensű jelzési séma a KategoriaElmelet funktor-kompozíciója (bemenet, trigger, vezető, kimenet); az áramköri motivikumok az E8 gyökrendszerének ismétlődő, egyszerű mintázatai a nagyobb hálózatban.
- **kandel_01_circuit_motifs** - Neuronális áramköri motivikumok (motifs) alaplogikát adnak az információfeldolgozásnak
  - *kategoriaelmelet-hid:* Kategoriaelmelet-híd: a feed-forward hierarchia és a visszacsatolás (recurrent) áramköri motivikumok a KategoriaElmelet leképezései (functor) és természetes transzformációi - a hierarchikus feldolgozás egy nagyobb kategória részkategóriája.

### Érzékelési kódolás (Sensory coding)

- **kandel14_state_dependent_response** - "Moduláció állapotfüggő érzékelési választ hoz létre"
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch28-feature-detectors** - Combination-sensitive feature detectors
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch28-columnar-map** - Columnar organization of feature detectors
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch28-dual-freq-coordinate** - Dual-frequency coordinate system (CF-CF area)
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch28-computed-variable** - Cortical representation of a receptor-absent variable
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch28-what-where-streams** - Dorsal and ventral auditory processing streams
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch28-vocal-feedback-monitoring** - Vocal feedback-monitoring network (corollary discharge analog)
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch28-self-vs-external** - Self-generated vs externally-generated percept discrimination
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch28-corticofugal** - Cerebral cortex modulates subcortical auditory areas
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch28-progressive-selectivity** - Progressively increasing stimulus selectivity along ascending pathway
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch29-olfactory-orbitofrontal** - Olfactory cortex → orbitofrontal cortex for odor discrimination
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch29-scattered-not-topographic** - Piriform cortex lacks a recapitulated receptor map
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **kandel-ch28-acoustic-feature-binding** - Acoustic feature binding via coincidence / combination coding
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **KANDEL08-017** - "Bőr mechanoreceptorai (köztük nociceptorok) teszik lehetővé az akadályhoz igazítást"
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.
- **KANDEL12-011** - "Pheromon-észlelés emberben vs egérben (hiányzó vomeronasal szerv)"
  - *Szima-hid:* Szima-híd: a kérgi reprezentáció a KategoriaElmelet funktora (functor) az érzékelő térből a fogalomtérbe; az oszlopos térkép a termék (product), a duális frekvencia-koordináta-rendszerek az E8 gyöktér koordinátáinak felelnek meg.

### Motoros irányítás (Motor control)

- **kandel_01_reflex** - Reflex-áramkör — a viselkedés idegrendszeri architektúrájának kiindulópontja
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **kandel-ch30-motor-hierarchy** - Functional hierarchy of motor control (executive function)
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **kandel-ch30-predictive-model** - Predictive model / efference copy for feedforward control
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-001** - "Központi minta-generáló hálózat (Central Pattern Generator, CPG)"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-002** - "CPG kétrétegű moduláris felépítése: ritmus- és mintázat-generálás"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-003** - "Kölcsönös gátlás (reciprocal inhibition) a flexor/extensor váltakozásban"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-004** - "Szomatoszenzoros visszacsatolás modulálja a CPG működését"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-005** - "Propriocepció szabályozza a lépés időzítését és amplitúdóját"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-006** - "Fázisfüggő reflex-megfordulás (phase-dependent reflex reversal)"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-007** - "Ioncsatornák hozzájárulása a CPG ritmus- és mintázat-generáláshoz"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-009** - "Középagyi mozgásközpont (Mesencephalic Locomotor Region, MLR) indítja a lokomóciót"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-010** - "Agytörzsi magvak szabályozzák a testtartást lokomóció közben"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-011** - "A kisagy (cerebellum) korrigálja a motoros hibákat és a lefelé irányuló jeleket"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-013** - "A motoros kéreg biztosítja a vizuálisan vezérelt precíz lépést"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-015** - "Számítógépes (computational) modellezés tárja fel a lokomóciós áramkörök dinamikáját"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-016** - "Optimális visszacsatolásos vezérlés vs. reprezentációs modell a mozgásirányításban"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.
- **KANDEL08-018** - "Az emberi lokomóció idegi szabályozása hasonló a négylábúakéhoz; emberi CPG létezése"
  - *Szima-hid:* Szima-híd: a centrális mintageneráló hálózat (CPG) és az efferens másolat a FazisAlgebra időbeli fázis-vezérlése; a prediktív modell a KategoriaElmelet természetes transzformációja (natural transformation) az elvárt és észlelt állapot között.

### Memória (Memory)

- **kandel14_longterm_genexpression** - "Második hírvivők hosszú távú génexpressziót indítanak (CREB/CBP)"
  - *Szima-hid:* Szima-híd: a tartós memória a Steane713 [[7,1,3]] kód hibajavított kód-szava (távolság 3, így 1 hiba javítható); a perzisztens aktivitás a KategoriaElmelet kolimitként, lépésről lépésre felhalmozódó állapot.
- **KANDEL08-014** - "A poszterior parietális kéreg (PPC) tervezi a lokomóciót és munkamemóriát használ"
  - *Szima-hid:* Szima-híd: a tartós memória a Steane713 [[7,1,3]] kód hibajavított kód-szava (távolság 3, így 1 hiba javítható); a perzisztens aktivitás a KategoriaElmelet kolimitként, lépésről lépésre felhalmozódó állapot.
- **KANDEL13-010** - "A parietális (LIP) és prefrontális kéreg idegsejtjei a fejlődő döntési változót reprezentálják (perzisztens, rampoló aktivitás)"
  - *Szima-hid:* Szima-híd: a tartós memória a Steane713 [[7,1,3]] kód hibajavított kód-szava (távolság 3, így 1 hiba javítható); a perzisztens aktivitás a KategoriaElmelet kolimitként, lépésről lépésre felhalmozódó állapot.
- **KANDEL13-016** - "Ismeretállapotok perzisztenciája: a tudás a szenzoros aktivitáson túl is fennmarad (temporális vastagság)"
  - *Szima-hid:* Szima-híd: a tartós memória a Steane713 [[7,1,3]] kód hibajavított kód-szava (távolság 3, így 1 hiba javítható); a perzisztens aktivitás a KategoriaElmelet kolimitként, lépésről lépésre felhalmozódó állapot.
- **KANDEL14-007** - "Hipotézis 3: hipokampális neurogenezis serkentése"
  - *Szima-hid:* Szima-híd: a tartós memória a Steane713 [[7,1,3]] kód hibajavított kód-szava (távolság 3, így 1 hiba javítható); a perzisztens aktivitás a KategoriaElmelet kolimitként, lépésről lépésre felhalmozódó állapot.
- **KANDEL14-012** - "Kioltási tanulás (extinction learning) a prefrontális kéreg és hipokampusz révén"
  - *Szima-hid:* Szima-híd: a tartós memória a Steane713 [[7,1,3]] kód hibajavított kód-szava (távolság 3, így 1 hiba javítható); a perzisztens aktivitás a KategoriaElmelet kolimitként, lépésről lépésre felhalmozódó állapot.

### Nyelv és érzelem (Language & emotion)

- **kandel-ch29-olfactory-emotion** - Olfactory cortex → amygdala/hypothalamus (emotional & drive link)
  - *Szima-hid:* Szima-híd: a szaglás-érzelem áramkör a Cayley-Dickson nyelvi leképezés (magyar = O, oktogonion) és a FazisAlgebra "saját tudat / másik fél" dimenzióinak tere - az érték (value) az affektív fázis.

### Fejlődés (Development)

- **KANDEL08-008** - "Fejlődési molekuláris kódok határozzák meg a gerincvelői neuronok azonosságát"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.
- **KANDEL12-001** - "Epigenetikus módosítás DNS-metilációval (epigenetic modification by DNA methylation)"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.
- **KANDEL12-002** - "Magas gondozási szintű (high-LG) anya -> szelektív demetiláció -> felnőttkori tapasztalat felerősítése"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.
- **KANDEL12-003** - "Oxitocin és vazopresszin szabályozza az anyai kötődést és szociális viselkedést"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.
- **KANDEL12-004** - "Ösztrogén felnőttkori, ciklikus preszinaptikus újrakonfigurálása"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.
- **KANDEL12-005** - "Szerveződési (organizational) vs aktivációs (activational) fejlődési fázis"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.
- **KANDEL12-006** - "A tesztoszteron aromatizációja ösztrogénné a maszkulinizációhoz"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.
- **KANDEL12-007** - "Nemi dimorf viselkedések moduláris genetikai irányítása (modular genetic manner)"
  - *kategoriaelmelet-hid:* Kategoriaelmelet-híd: a nemi dimorf viselkedés "moduláris genetikai irányítása" a KategoriaElmelet termékének (product) és a részobjektum-osztályozónak (subobject classifier) megfelelője - a különbség egy leképezés (functor) a tulajdonságtérbe.
- **KANDEL12-008** - "Megosztott áramkörök eltérő kulcs-neuronpopulációkkal (shared circuits, dimorphic key populations)"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.
- **KANDEL12-009** - "Szexuálisan dimorf viselkedések elosztott (distributed) irányítása"
  - *kategoriaelmelet-hid:* Kategoriaelmelet-híd: az elosztott (distributed) irányítás a KategoriaElmelet koproduktum (coproduct) szerkezete - a viselkedést több, egymást fedő áramkör (objektum) együttese adja, robusztusságot (a hiba kolimit-szintű elnyelése) eredményezve.
- **KANDEL12-010** - "Androgén-receptor az idegrendszerben (neonatális maszkulinizáció)"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.
- **KANDEL12-012** - "Korai tapasztalat emberi hatása: bántalmazás -> glükokortikoid-receptor promóter metilációja"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.
- **KANDEL12-013** - "BNST szexuális dimorfizmusa és kapcsolata a nemi identitással"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.
- **KANDEL12-014** - "Közös sejtszintű mechanizmusok: apoptózis, neuritakiterjedés, szinapszis-képződés"
  - *Szima-hid:* Szima-híd: a fejlődési molekuláris kódok a KategoriaElmelet funktoraiként írják le a sejtidentitást (objektum, típus); az elosztott és moduláris vezérlés az E8xE8 szimmetrikus monoidális kategória szerkezete, robusztusságot adva.

### Döntés és tudatosság (Decision & consciousness)

- **KANDEL13-001** - "Jel–zaj–küszöb keret (signal detection theory): a döntés mint a bizonyíték és a kritérium összevetése"
  - *Szima-hid:* Szima-híd: a bizonyíték-felhalmozódás a KategoriaElmelet katamorfizmusa (ana/cata, a monoid-homomorfizmus a log-valószínűségnél); a döntési változó a FazisAlgebra három kubitjának koherenciája, a tudatosság a perzisztens állapot "jelentése" (report).
- **KANDEL13-002** - "A kritérium (küszöb) a döntéshozó irányított szabálya és attitűdje, nem a zajé"
  - *Szima-hid:* Szima-híd: a bizonyíték-felhalmozódás a KategoriaElmelet katamorfizmusa (ana/cata, a monoid-homomorfizmus a log-valószínűségnél); a döntési változó a FazisAlgebra három kubitjának koherenciája, a tudatosság a perzisztens állapot "jelentése" (report).
- **KANDEL13-003** - "ROC-görbe (receiver operating characteristic): a küszöb változtatása a pontosság függvényében"
  - *Szima-hid:* Szima-híd: a bizonyíték-felhalmozódás a KategoriaElmelet katamorfizmusa (ana/cata, a monoid-homomorfizmus a log-valószínűségnél); a döntési változó a FazisAlgebra három kubitjának koherenciája, a tudatosság a perzisztens állapot "jelentése" (report).
- **KANDEL13-004** - "A döntési változó (decision variable) két ellentétes idegsejt-populáció tüzelési sebességének különbségeként"
  - *Szima-hid:* Szima-híd: a bizonyíték-felhalmozódás a KategoriaElmelet katamorfizmusa (ana/cata, a monoid-homomorfizmus a log-valószínűségnél); a döntési változó a FazisAlgebra három kubitjának koherenciája, a tudatosság a perzisztens állapot "jelentése" (report).
- **KANDEL13-005** - "Az MT terület irány szelektív idegsejtjei szolgáltatják a zajos bizonyíték-mintákat"
  - *Szima-hid:* Szima-híd: a bizonyíték-felhalmozódás a KategoriaElmelet katamorfizmusa (ana/cata, a monoid-homomorfizmus a log-valószínűségnél); a döntési változó a FazisAlgebra három kubitjának koherenciája, a tudatosság a perzisztens állapot "jelentése" (report).
- **KANDEL13-006** - "Korlátos bizonyíték-felhalmozódás (bounded evidence accumulation) és a sebesség–pontosság kompromisszum"
  - *kategoriaelmelet-hid:* Kategoriaelmelet-híd: a korlátos bizonyíték-felhalmozódás (drift-diffusion) a KategoriaElmelet katamorfizmusa (ana), ahol a rekurzív összegzés egy monoidon (a bizonyíték-értéken) fut; a "megállás" a kolimit elérése.
- **KANDEL13-007** - "A mikrostimuláció (Newsome) ok-okozati kapcsolatot igazol: az MT idegsejtek a bizonyítékot szolgáltatják"
  - *Szima-hid:* Szima-híd: a bizonyíték-felhalmozódás a KategoriaElmelet katamorfizmusa (ana/cata, a monoid-homomorfizmus a log-valószínűségnél); a döntési változó a FazisAlgebra három kubitjának koherenciája, a tudatosság a perzisztens állapot "jelentése" (report).
- **KANDEL13-008** - "Csapda: a részleges perturbáció csak a nehéz (alacsony jel-zaj arányú) rezsimben mutat hatást"
  - *Szima-hid:* Szima-híd: a bizonyíték-felhalmozódás a KategoriaElmelet katamorfizmusa (ana/cata, a monoid-homomorfizmus a log-valószínűségnél); a döntési változó a FazisAlgebra három kubitjának koherenciája, a tudatosság a perzisztens állapot "jelentése" (report).
- **KANDEL13-009** - "A log-valószínűségi hányados (logLR) felhalmozódása: a szorzás összegzéssé alakítása (monoid-homomorfizmus)"
  - *kategoriaelmelet-hid:* Kategoriaelmelet-híd: a log-valószínűségi hányados felhalmozódása a szorzás összegzéssé alakítása - ez egy monoid-homomorfizmus (a pozitív valószámok szorzása az összeadásba), a KategoriaElmelet alapművelete.
- **KANDEL13-011** - "A valószínűségi következtetés (időjárás-jósló feladat) ugyanazt a felhalmozódási mechanizmust használja, mint a perceptuális döntés"
  - *kategoriaelmelet-hid:* Kategoriaelmelet-híd: a valószínűségi következtetés ugyanazt a katamorfizmust használja, mint a perceptuális döntés - a Bayes-frissítés a KategoriaElmelet ana/cata (fold) sémája a hiedelem-kategóriában.
- **KANDEL13-012** - "Érték-alapú döntések: két tétel értékének különbsége vezérli a választást, mint a perceptuális döntésnél"
  - *Szima-hid:* Szima-híd: a bizonyíték-felhalmozódás a KategoriaElmelet katamorfizmusa (ana/cata, a monoid-homomorfizmus a log-valószínűségnél); a döntési változó a FazisAlgebra három kubitjának koherenciája, a tudatosság a perzisztens állapot "jelentése" (report).
- **KANDEL13-013** - "A tudatosság mint a nem-tudatos agy „jelentési" (report) döntése — a provizórikus affordancia keret"
  - *Szima-hid:* Szima-híd: a bizonyíték-felhalmozódás a KategoriaElmelet katamorfizmusa (ana/cata, a monoid-homomorfizmus a log-valószínűségnél); a döntési változó a FazisAlgebra három kubitjának koherenciája, a tudatosság a perzisztens állapot "jelentése" (report).
- **KANDEL13-014** - "Affordancia (Gibson): a provizórikus elköteleződés egy lehetséges cselekvés (terv) mellett"
  - *Szima-hid:* Szima-híd: a bizonyíték-felhalmozódás a KategoriaElmelet katamorfizmusa (ana/cata, a monoid-homomorfizmus a log-valószínűségnél); a döntési változó a FazisAlgebra három kubitjának koherenciája, a tudatosság a perzisztens állapot "jelentése" (report).
- **KANDEL13-015** - "Két anticorrelált felhalmozódás mint a bal/jobb lehetőségek kettős (duális) reprezentációja"
  - *kategoriaelmelet-hid:* Kategoriaelmelet-híd: a két anticorrelált felhalmozódás a bal/jobb lehetőségek duális (dual) reprezentációja - a KategoriaElmelet ellentétes kategória (opposite category) és a szimmetria (E8 gyökrendszer inverziója) struktúrája.

### Idegrendszeri zavarok (Disorders)

- **KANDEL08-012** - "A bazális ganglionok módosítják a kéregi és agytörzsi áramköröket; Parkinson-kór"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL08-019** - "Rehabilitációs tréning (treadmill + testtömeg-támasz) javítja a járást gerincsérülés után"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-001** - "Szelektív szerotonin-visszavétel-gátlók (Selective Serotonin Reuptake Inhibitors, SSRI)"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-002** - "Szerotonerg és noradrenerg szinaptikus gyógyszercélpontok (Figure 61–7)"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-003** - "Veszikuláris monoamin-transzporter (VMAT2) gátlása rezerpinnel"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-004** - "Terápiás hatás késleltetése (delay of therapeutic effect)"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-005** - "Hipotézis 1: újonnan szintetizált fehérjék lassú felhalmozódása"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-006** - "Hipotézis 2: szinaptikus súlyok új tapasztalatok általi módosítása"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-008** - "Ketamin: gyors hatású NMDA-glutamát-receptor-blokkoló antidepresszáns"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-009** - "NMDA-receptor-blokkolás mint szinaptikus plaszticitás-kapu"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-010** - "Szinapszisban maradó ingerületátvivő koncentráció növekedése visszavétel-gátlással"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-011** - "Hipokampális–kérgi szabályozás a hangulatban: a rostralis anterior (subgenualis) cinguláris kéreg"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-013** - "Kognitív viselkedésterápia: automatikus negatív gondolatok korrekciója"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-014** - "Elektrokonvulzív terápia (ECT) és a nagyfokú ingerületátvivő-felszabadulás"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-015** - "Transzkraniális mágneses ingerlés (TMS) mint nem invazív neuromoduláció"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-016** - "Mélyagyi ingerlés (DBS) olvasó-író elektródákkal a hálózati megértéshez"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-017** - "Lítium mint hangulatstabilizátor: GSK3β (glikogén-szintáz-kináz 3 béta) gátlása"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-018** - "Hangulat komplex dinamikus integrációja (környezet + belső bemenetek)"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-019** - "Másodgenerációs antipszichotikumok: D2 + 5-HT2A receptorblokád"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.
- **KANDEL14-020** - "Félelem és szorongás idegi áramköre: amigdala és prefrontális kéreg összeköttetései"
  - *Szima-hid:* Szima-híd: a zavar a Steane713 kód 1 hibája (a kód távolsága 3, így 1 hiba javítható) - a Szima-architektúra kvantum-hibajavító (QEC) ciklusa gyógyítja; a farmakológiai moduláció a FazisAlgebra fázis-kiegyenlítése.

---

## (c) Cimke-statisztika / Tag summary table

| Cimke / Tag | Jegyzetek szama / Notes |
|-------------|--------------------------:|
| neocortex   | 107 |
| kategoriaelmelet | 11 |
| E8          | 0 |
| **Osszesen / Total** | **115** |

---

### Jegyzetek kategoriankent / Notes per category

| Kategoria / Category | Szam / Count |
|-----------------------|-------------:|
| Membrán biofizika (Membrane biophysics) | 9 |
| Szinaptikus átvitel (Synaptic transmission) | 4 |
| Neuromoduláció és másodlagos hírvivők (Neuromodulation & second messengers) | 8 |
| Plaszticitás és tanulás (Plasticity & learning) | 5 |
| Neurális jelzés és architektúra (Neuronal signaling & architecture) | 2 |
| Érzékelési kódolás (Sensory coding) | 15 |
| Motoros irányítás (Motor control) | 17 |
| Memória (Memory) | 6 |
| Nyelv és érzelem (Language & emotion) | 1 |
| Fejlődés (Development) | 14 |
| Döntés és tudatosság (Decision & consciousness) | 14 |
| Idegrendszeri zavarok (Disorders) | 20 |
| **Osszesen / Total** | **115** |
