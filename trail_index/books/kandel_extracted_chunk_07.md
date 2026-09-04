# ConceptNotes — Kandel Chunk 07
# Source: Kandel et al., Principles of Neural Science (6th ed.), Ch. 28 (Auditory Processing),
#         Ch. 29 (Smell and Taste), Ch. 30 (Principles of Sensorimotor Control) — book chunk 07.
# Extracted per trail_index/books/book_processor.md schema (ConceptNote YAML).
# Selection criterion: mechanisms whose structure conceptually maps onto a neocortex-like
# AI architecture (functional specialization, maps, parallel streams, self-monitoring,
# hierarchical abstraction, sensory-motor loops).

---

- id: kandel-ch28-feature-detectors
  source: "Principles of Neural Science (6th ed.), Ch. 28 Auditory Processing"
  concept: Combination-sensitive feature detectors
  type: Pattern
  idris_version: 2
  summary: >
    Auditory cortical neurons (e.g. FM-FM area of mustached bat) respond preferentially
    to a specific *combination* of stimuli (pulse + echo at a particular delay) rather
    than to either component alone. Selectivity increases progressively along the
    ascending pathway (Highlight 3). This is a canonical "binding of primitives into a
    higher-order feature" pattern.
  signature: >
    feature : StimulusCombination -> ReceptiveField; responds : Neuron -> StimulusCombination -> Bool
  code: |
    -- Egy neurón egyszerre több primitív ingert köt össze egy magasabb szintű jellemzővé.
    -- A típus garantálja: csak érvényes kombinációt fogad el a detektor.
    data HangKombinacio : Type where
      PulzusVisszhang : (alapFrekvencia : Frekvencia) -> (keses : KesesMs) -> HangKombinacio
    data JellemzoDetektor : Type where
      FM_FM_Detektor : (preferaltKeses : KesesMs) -> JellemzoDetektor
  related: [kandel-ch28-columnar-map, kandel-ch28-what-where-streams, kandel-ch28-dual-freq-coordinate]
  causes: [kandel-ch28-target-range-map]
  caused_by: [kandel-ch28-progressive-selectivity]
  resolves: [kandel-ch28-acoustic-feature-binding]
  tags: [neocortex, feature-binding, auditory, sensory-cortex]

- id: kandel-ch28-columnar-map
  source: "Principles of Neural Science (6th ed.), Ch. 28 Auditory Processing"
  concept: Columnar organization of feature detectors
  type: Pattern
  idris_version: 2
  summary: >
    Neurons tuned to a particular combination of stimulus frequency and delay are
    organized into columns; in the CF-CF area columns are arranged along two
    perpendicular axes (fundamental frequency × echo harmonic). A 2-D coordinate
    system over the cortical sheet encodes a computed variable (Doppler shift → target
    velocity, –2 to 9 m/s).
  signature: >
    column : Coordinate2D -> Neuron; mapLayout : CorticalSheet -> (Coordinate2D -> Feature)
  code: |
    -- Oszlopos elrendezés: a kétdimenziós koordináta leképezi a kéregfelszínt egy jellemzőre.
    data Koordinata2D : Type where
      Koordinata : (tengelyA : Frekvencia) -> (tengelyB : Harmonikus) -> Koordinata2D
    Oszlop : Koordinata2D -> (sebesseg : TargetSebesseg)
  related: [kandel-ch28-feature-detectors, kandel-ch28-dual-freq-coordinate]
  causes: [kandel-ch28-acoustic-image-map]
  caused_by: [kandel-ch28-feature-detectors]
  resolves: [kandel-ch28-topographic-computation]
  tags: [neocortex, columnar, map, auditory]

- id: kandel-ch28-dual-freq-coordinate
  source: "Principles of Neural Science (6th ed.), Ch. 28 Auditory Processing"
  concept: Dual-frequency coordinate system (CF-CF area)
  type: Definition
  idris_version: 2
  summary: >
    The CF-CF area of bat auditory cortex forms a map where one cortical axis represents
    the emitted call's fundamental frequency and the perpendicular axis the Doppler-shifted
    echo harmonic. A specific location encodes a specific Doppler shift, hence a specific
    target velocity. This is a sensory-derived *computational map* for a variable not
    present at the receptor.
  signature: >
    dopplerMap : CorticalLocation -> DopplerShift; velocity : DopplerShift -> TargetVelocity
  code: |
    data DopplerTengely : Type where
      AlapFrekvenciaTengely : Frekvencia -> DopplerTengely
      VisszhangHarmonikusTengely : Harmonikus -> DopplerTengely
  related: [kandel-ch28-columnar-map, kandel-ch28-computed-variable]
  causes: [kandel-ch28-target-velocity-encoding]
  caused_by: [kandel-ch28-columnar-map]
  resolves: [kandel-ch28-auditory-fovea]
  tags: [neocortex, computational-map, coordinate, auditory]

- id: kandel-ch28-computed-variable
  source: "Principles of Neural Science (6th ed.), Ch. 28 Auditory Processing"
  concept: Cortical representation of a receptor-absent variable
  type: Pattern
  idris_version: 2
  summary: >
    The bat, like the barn owl's inferior colliculus, represents an acoustic feature
    (target velocity via Doppler shift) that is NOT directly encoded by sensory receptors
    (Highlight text, p. 677). Cortical computation synthesizes a new variable from raw
    receptor signals. This is the essence of a neocortex: constructing latent variables.
  signature: >
    compute : ReceptorSignal -> ComputedVariable
  code: |
    -- A kéreg kiszámítja a receptorok által nem kódolt változót.
    szamitTargetSebesseg : VisszhangJel -> TargetSebesseg
  related: [kandel-ch28-dual-freq-coordinate, kandel-ch28-feature-detectors]
  causes: [kandel-ch28-latent-variable]
  caused_by: [kandel-ch28-feature-detectors]
  resolves: [kandel-ch28-abstraction]
  tags: [neocortex, latent-variable, computation]

- id: kandel-ch28-what-where-streams
  source: "Principles of Neural Science (6th ed.), Ch. 28 Auditory Processing"
  concept: Dorsal and ventral auditory processing streams
  type: Pattern
  idris_version: 2
  summary: >
    Auditory cortical circuits segregate into parallel streams: a dorsal stream concerned
    with sound location in space (the "where") and a ventral stream concerned with sound
    identification (the "what") (Highlight 9). This mirrors the visual dorsal/ventral
    split and is a general principle of cortical organization.
  signature: >
    stream : AuditoryRegion -> StreamKind; project : StreamKind -> TargetArea
  code: |
    data HallasiFolyam : Type where
      Dorsalis : HallasiFolyam  -- térbeli hely ("hol")
      Ventralis : HallasiFolyam -- azonosítás ("mi")
  related: [kandel-ch28-feature-detectors, kandel-ch29-olfactory-orbitofrontal]
  causes: [kandel-ch28-parallel-specialization]
  caused_by: []
  resolves: [kandel-ch28-functional-segregation]
  tags: [neocortex, parallel-streams, what-where, auditory]

- id: kandel-ch28-vocal-feedback-monitoring
  source: "Principles of Neural Science (6th ed.), Ch. 28 Auditory Processing"
  concept: Vocal feedback-monitoring network (corollary discharge analog)
  type: CausalRelation
  idris_version: 2
  summary: >
    Speaking induces suppression of auditory cortex activity beginning several hundred
    milliseconds BEFORE vocal onset (cortical), whereas subcortical suppression begins at
    or after onset. The lead time implies the suppression is driven by a *command signal
    from vocal motor areas* — an efference copy / corollary discharge that modulates
    sensory cortex to distinguish self-generated from externally generated sound and to
    monitor vocal errors (Figure 28–15, Houde & Chang 2015).
  signature: >
    command : VocalPlan -> EfferenceCopy; suppress : EfferenceCopy -> SensoryCortex -> Suppressed
  code: |
    -- A saját hang elnyomása egy efferencia-másolat (korollárium-kisülés) által vezérelt.
    efferenciaMasolat : HangzasarPlan -> KorollariumKisules
    elnyomas : KorollariumKisules -> HallasiKereg -> ElNyomottValasz
  related: [kandel-ch28-self-vs-external, kandel-ch30-predictive-model, kandel-ch28-corticofugal]
  causes: [kandel-ch28-self-vs-external, kandel-ch28-vocal-learning]
  caused_by: [kandel-ch28-vocal-command]
  resolves: [kandel-ch28-masking-own-voice, kandel-ch28-error-detection]
  tags: [neocortex, corollary-discharge, self-monitoring, efference-copy, motor-sensory-loop]

- id: kandel-ch28-self-vs-external
  source: "Principles of Neural Science (6th ed.), Ch. 28 Auditory Processing"
  concept: Self-generated vs externally-generated percept discrimination
  type: Pattern
  idris_version: 2
  summary: >
    The auditory system must tag a percept as self-generated or externally generated to
    monitor the environment during speech while also tracking one's own voice for error
    detection and learning. Perturbing feedback (e.g. pitch shift via earphones) abolishes
    suppression and recruits cortex to the perturbation, demonstrating an active
    feedback-monitoring loop rather than passive listening.
  signature: >
    classify : AuditoryPercept -> Source (Self | External)
  code: |
    data HangForras : Type where
      SajatGeneralta : HangForras
      KulsőGeneralta : HangForras
    osztalyoz : HallasiEszlelet -> HangForras
  related: [kandel-ch28-vocal-feedback-monitoring, kandel-ch30-predictive-model]
  causes: [kandel-ch28-vocal-learning]
  caused_by: [kandel-ch28-vocal-feedback-monitoring]
  resolves: [kandel-ch28-error-detection]
  tags: [neocortex, self-vs-other, predictive-coding, monitoring]

- id: kandel-ch28-corticofugal
  source: "Principles of Neural Science (6th ed.), Ch. 28 Auditory Processing"
  concept: Cerebral cortex modulates subcortical auditory areas
  type: Pattern
  idris_version: 2
  summary: >
    Auditory cortex projects back to the thalamus, inferior colliculus, olivocochlear
    neurons, basal ganglionic structures, and even the dorsal cochlear nucleus (Highlight
    10). Processing is not strictly bottom-up; the cortex exerts top-down control
    (experience-dependent plasticity in bat cortex/colliculus depends on the corticofugal
    system). A neocortex must therefore close the loop with descending projections.
  signature: >
    topDown : Cortex -> SubcorticalArea -> Modulated
  code: |
    -- Lefelé irányuló (kortikofugális) moduláció: a kéreg szabályozza az alacsonyabb szinteket.
    kortikofugalis : HallasiKereg -> AlsoSzint -> Modulalt
  related: [kandel-ch28-vocal-feedback-monitoring, kandel-ch30-predictive-model]
  causes: [kandel-ch28-experience-plasticity]
  caused_by: []
  resolves: [kandel-ch28-topdown-control]
  tags: [neocortex, top-down, corticofugal, feedback]

- id: kandel-ch28-progressive-selectivity
  source: "Principles of Neural Science (6th ed.), Ch. 28 Auditory Processing"
  concept: Progressively increasing stimulus selectivity along ascending pathway
  type: Pattern
  idris_version: 2
  summary: >
    A marked feature of auditory neurons at successive processing stations is their
    progressively increasing stimulus selectivity (Highlight 3); within auditory cortex
    neurons become yet more selective. Selectivity is built by combining inputs (e.g.
    coincidence detection, spectral sharpening) rather than by new receptors.
  signature: >
    selectivity : ProcessingStation -> SelectivityLevel; increasesWith : Station n -> Station (n+1) -> LT
  code: |
    -- A szelektivitás nő a felfelé haladó úton.
    szelektivitas : FeldolgozoAllomas -> SzelektivitasSzint
  related: [kandel-ch28-feature-detectors, kandel-ch28-computed-variable]
  causes: [kandel-ch28-feature-detectors]
  caused_by: []
  resolves: [kandel-ch28-hierarchy]
  tags: [neocortex, hierarchy, selectivity]

- id: kandel-ch29-olfactory-orbitofrontal
  source: "Principles of Neural Science (6th ed.), Ch. 29 Smell and Taste"
  concept: Olfactory cortex → orbitofrontal cortex for odor discrimination
  type: CausalRelation
  idris_version: 2
  summary: >
    Pyramidal neurons of the olfactory cortex transmit information indirectly via the
    thalamus to orbitofrontal cortex and directly to frontal cortex; these higher cortical
    pathways are important for odor discrimination — lesions of orbitofrontal cortex
    abolish odor discrimination. Some orbitofrontal neurons are multimodal (respond to
    smell, sight, or taste of a banana), an early convergence of sensory modalities.
  signature: >
    project : OlfactoryCortex -> OrbitofrontalCortex; discriminate : OrbitofrontalCortex -> OdorIdentity
  code: |
    -- Szaglókéreg -> orbitofrontális kéreg: a diszkrimináció magasabb kéregig épül fel.
    szagDiszkriminacio : OrbitofrontalisKereg -> SzagAzonositas
  related: [kandel-ch29-olfactory-emotion, kandel-ch28-what-where-streams]
  causes: [kandel-ch29-multimodal-integration]
  caused_by: []
  resolves: [kandel-ch29-odor-identity]
  tags: [neocortex, orbitofrontal, multimodal, discrimination]

- id: kandel-ch29-olfactory-emotion
  source: "Principles of Neural Science (6th ed.), Ch. 29 Smell and Taste"
  concept: Olfactory cortex → amygdala/hypothalamus (emotional & drive link)
  type: CausalRelation
  idris_version: 2
  summary: >
    Many olfactory cortical areas relay to the amygdala (linked to emotions) and the
    hypothalamus (controls basic drives such as appetite and innate behaviors). The
    olfactory system thus provides a direct, evolutionarily old route from sensation to
    emotion and motivation — a model for how a neocortex should bind sensory content to
    affective/value signals.
  signature: >
    relay : OlfactoryCortex -> (Amygdala + Hypothalamus); affect : (Amygdala + Hypothalamus) -> EmotionalResponse
  code: |
    -- Szaglás közvetlen útja az érzelemhez: kéreg -> mandulamag -> hipotalamusz.
    erzelmiValasz : Mandulamag -> ErzelmiValaszTipus
  related: [kandel-ch29-olfactory-orbitofrontal]
  causes: [kandel-ch29-affective-binding]
  caused_by: []
  resolves: [kandel-ch29-sensation-to-emotion]
  tags: [neocortex, emotion, amygdala, hypothalamus, value]

- id: kandel-ch29-scattered-not-topographic
  source: "Principles of Neural Science (6th ed.), Ch. 29 Smell and Taste"
  concept: Piriform cortex lacks a recapitulated receptor map
  type: Pitfall
  idris_version: 2
  summary: >
    Unlike the tonotopic auditory map, the highly organized map of odorant receptor inputs
    in the olfactory bulb is NOT recapitulated in the piriform cortex; pyramidal neurons
    activated by a given odorant are scattered across the piriform cortex, and different
    mitral cells converge on the same subregion. WARNING for architects: not every cortical
    area must preserve a topographic input map; distributed/overlapping codes are valid.
  signature: >
    isTopographic : CorticalArea -> Bool
  code: |
    -- CSAPDA: a topográfiai térkép nem kötelező; a szórt kód is érvényes reprezentáció.
    szagTopografia : SzagloKeregTerulet -> TopografikusE
  related: [kandel-ch28-columnar-map]
  causes: []
  caused_by: []
  resolves: []
  tags: [neocortex, distributed-code, pitfall, olfactory]

- id: kandel-ch30-motor-hierarchy
  source: "Principles of Neural Science (6th ed.), Ch. 30 Principles of Sensorimotor Control"
  concept: Functional hierarchy of motor control (executive function)
  type: Pattern
  idris_version: 2
  summary: >
    Motor systems form a functional hierarchy, each level a different decision. The highest
    and most abstract level (likely requiring prefrontal cortex) deals with the PURPOSE of
    a movement; the next level (posterior parietal ↔ premotor) forms a motor PLAN from
    sensory context; the lowest level (primary motor cortex, brain stem, spinal cord)
    coordinates the spatiotemporal muscle-contraction details. This is a concrete instance
    of neocortical executive function: abstract goal → plan → execution.
  signature: >
    hierarchy : Level n -> Level (n-1); decide : Level -> Decision
  code: |
    -- Végrehajtó funkció: absztrakt cél -> terv -> végrehajtás, szintenként.
    data MotorSzint : Type where
      CelSzint     : MotorSzint  -- prefrontális kéreg: a cél
      TervSzint    : MotorSzint  -- premotor + parietális: a terv
      Vegrehajtas  : MotorSzint  -- primer motoros kéreg: izommozgás
  related: [kandel-ch30-predictive-model, kandel-ch28-vocal-feedback-monitoring]
  causes: [kandel-ch30-executive-function]
  caused_by: []
  resolves: [kandel-ch30-goal-directed-action]
  tags: [neocortex, executive-function, hierarchy, prefrontal, motor]

- id: kandel-ch30-predictive-model
  source: "Principles of Neural Science (6th ed.), Ch. 30 Principles of Sensorimotor Control"
  concept: Predictive model / efference copy for feedforward control
  type: CausalRelation
  idris_version: 2
  summary: >
    Movement is not shaped purely by sensory feedback; centers such as the cerebellum use
    predictive models that simulate the consequences of outgoing commands to allow very
    short-latency corrections (feedforward + optimal feedback control). This is the same
    principle as the auditory corollary-discharge network: the motor command generates an
    internal prediction that is compared with sensation.
  signature: >
    predict : MotorCommand -> PredictedSensation; compare : PredictedSensation -> ActualSensation -> Error
  code: |
    -- Előrejelző modell: a parancs előre kiszámítja az érzetet, és összeveti a valósággal.
    eloreJelzes : MotorosParancs -> ElorejelzettErzet
    hiba : ElorejelzettErzet -> TenylegesErzet -> Hiba
  related: [kandel-ch28-vocal-feedback-monitoring, kandel-ch30-motor-hierarchy, kandel-ch28-self-vs-external]
  causes: [kandel-ch30-feedforward-control]
  caused_by: [kandel-ch28-vocal-feedback-monitoring]
  resolves: [kandel-ch30-short-latency-correction]
  tags: [neocortex, predictive-coding, efference-copy, cerebellum, control]

- id: kandel-ch28-acoustic-feature-binding
  source: "Principles of Neural Science (6th ed.), Ch. 28 Auditory Processing"
  concept: Acoustic feature binding via coincidence / combination coding
  type: Rule
  idris_version: 2
  summary: >
    Distinct ventral cochlear nucleus cell types extract distinct sound features in
    parallel — octopus cells detect coincident firing (onsets/gaps), stellate cells sharpen
    spectral peaks/valleys, bushy cells sharpen fine structure for binaural timing/intensity
    comparisons. These parallel feature streams are the substrate later bound into
    combination-sensitive cortical responses.
  signature: >
    extract : CellType -> SoundFeature; bind : List SoundFeature -> CorticalResponse
  code: |
    -- Párhuzamos jellemzőkivonás, majd kombinációs kötés a kéregben.
    kivon : SejtTipus -> HangJellemzo
    kot : Lista HangJellemzo -> KorticalisValasz
  related: [kandel-ch28-feature-detectors, kandel-ch28-progressive-selectivity]
  causes: [kandel-ch28-feature-detectors]
  caused_by: []
  resolves: [kandel-ch28-parallel-feature-extraction]
  tags: [neocortex, feature-extraction, binding, auditory]

---

# Conceptual bridges to the Szima architecture (E8 / kategoriaelmélet / neocortex)

- kandel-ch28-vocal-feedback-monitoring and kandel-ch30-predictive-model are the SAME
  mechanism seen in two modalities: a motor command emits an efference copy / internal
  prediction, which is compared against sensation. In category-theoretic terms this is a
  commutative diagram — motor command and sensory readout both map to a "predicted
  sensation" object and are equalized by an error morphism. This is a candidate for an
  `E8`/kategoriaelmélet-tagged functor between motor and sensory categories.
- kandel-ch30-motor-hierarchy (goal → plan → execution) is the executive-function skeleton
  a neocortex-like AI must instantiate; the prefrontal "abstract purpose" level is the
  natural home of the project's "Saját tudat / C" (CPT) top node.
- kandel-ch29-olfactory-emotion shows a direct sensory→amygdala→hypothalamus route for
  value/affect; a neocortex needs an analogous binding of representation to affective valence
  (the project's "fázis" / connection-phase redundancy principle).

# Notes on scope
Chunk 07 spans Ch. 28 (auditory, ~lines 1–557), Ch. 29 (smell & taste, ~lines 558–2420),
and the opening of Ch. 30 (sensorimotor control, ~lines 2421 to end at 8295). Extraction
above focuses on the mechanism-bearing passages; the long receptor-level detail (cochlear
nuclei cell types, taste transduction ion channels) was summarized into the acoustic
feature-binding and olfactory notes rather than enumerated exhaustively.
