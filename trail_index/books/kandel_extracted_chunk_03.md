# Kandel — Principles of Neural Science (6th ed.), Chapter 9
# Forrás: kandel_chunk_03.txt (Chapter 9 / Membrane Potential and the Passive Electrical Properties of the Neuron)
# Kinyerési séma: book_processor.md ConceptNote
# Megjegyzés: Ez a chunk a membránpotenciál és passzív elektromos tulajdonságok
# biofizikáját tárgyalja (nem szinaptikus plasticitást / LTP-LTD-t). A valóban
# jelenlévő mechanizmusokat (nyugalmi potenciál, steady-state, pumpa, pozitív
# visszacsatolás, Goldman-egyenlet, ekvivalens áramkör) vontuk ki. Az "E8" címke
# NEM került felvitelre, mert a membrán-biofizikában nincs valós E8-híd; a
# "neocortex" és "kategoriaelmelet" címke csak ott szerepel, ahol valós fogalmi
# átvezetés létezik.

concept_notes:

  - id: kn03-resting-potential-k-only
    source: Principles of Neural Science (6th ed.), Chapter 9 — Membrane Potential and the Passive Electrical Properties of the Neuron
    concept: Resting potential set solely by a single ion gradient
    type: Rule
    idris_version: 2
    summary: >
      When a cell membrane contains only K+ channels, the resting membrane
      potential Vr equals the K+ equilibrium (Nernst) potential EK (−75 mV).
      The potential is then determined solely by the K+ concentration gradient,
      with no net K+ flux.
    signature: "Vr = EK = (RT/F) ln([K+]o / [K+]i)"
    code: "Vm = (RT/F) * ln([K+]_o / [K+]_i)"
    related: [kn03-steady-state-balance, kn03-driving-force-def, kn03-equivalent-circuit]
    causes: [kn03-steady-state-balance]
    caused_by: []
    resolves: []
    tags: [resting-potential, potassium, nernst, membrane]

  - id: kn03-steady-state-balance
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Steady-state balance of Na+ influx and K+ efflux
    type: CausalRelation
    idris_version: 2
    summary: >
      Adding a few open Na+ channels makes the membrane slightly permeable to
      Na+, depolarizing it from EK. A new resting level (~−65 mV) is reached
      when the increased outward K+ current exactly balances the inward Na+
      current. The cell is then NOT at equilibrium but in a steady state.
    signature: "I_K_out = I_Na_in   (at steady state)"
    code: "gK*(Vm - EK) = -gNa*(Vm - ENa)"
    related: [kn03-resting-potential-k-only, kn03-na-k-pump, kn03-driving-force-def]
    causes: [kn03-na-k-pump]
    caused_by: [kn03-resting-potential-k-only]
    resolves: [membrane-depolarization-runaway]
    tags: [neocortex, steady-state, homeostasis, ion-flux]

  - id: kn03-driving-force-def
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Electrochemical driving force
    type: Definition
    idris_version: 2
    summary: >
      The net electrochemical driving force on an ion is the sum of its
      electrical and chemical driving forces. Ion flux equals the driving force
      multiplied by membrane conductance.
    signature: "ion_flux = (electrical_force + chemical_force) × membrane_conductance"
    code: "ion_flux = (V_elec + V_chem) * g"
    related: [kn03-ohm-modified, kn03-equivalent-circuit]
    causes: []
    caused_by: []
    resolves: []
    tags: [driving-force, conductance, definition]

  - id: kn03-ohm-modified
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Modified Ohm's law for membrane current
    type: Definition
    idris_version: 2
    summary: >
      For a real neuron with both a membrane potential and an ion concentration
      gradient, the net current through a channel type equals its conductance
      times the electrochemical driving force. For K+: iK = γK (Vm − EK); the
      factor (Vm − EK) is the electrochemical driving force.
    signature: "iK = γK × (Vm − EK)"
    code: "iK = gammaK * (Vm - EK)"
    related: [kn03-driving-force-def, kn03-equivalent-circuit]
    causes: []
    caused_by: [kn03-driving-force-def]
    resolves: []
    tags: [ohm, current, conductance, potassium]

  - id: kn03-na-k-pump
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Na+-K+ pump (primary active transport)
    type: Pattern
    idris_version: 2
    summary: >
      The sodium-potassium pump continuously extrudes 3 Na+ and imports 2 K+
      per ATP hydrolyzed, counterbalancing the passive leak of ions. This
      maintains the ionic gradients and the steady state; because the fluxes are
      unequal the pump is electrogenic (net outward current).
    signature: "pump_cycle : ATP -> 3 Na+_out + 2 K+_in"
    code: "naOut = 3; kIn = 2; per ATP hydrolyzed"
    related: [kn03-steady-state-balance, kn03-primary-active-transport, kn03-electrogenic-pump]
    causes: [kn03-steady-state-balance]
    caused_by: [kn03-primary-active-transport]
    resolves: [gradient-run-down]
    tags: [neocortex, pump, active-transport, homeostasis]

  - id: kn03-primary-active-transport
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Primary active transport (P-type ATPases)
    type: Definition
    idris_version: 2
    summary: >
      Pumps such as the Na+-K+ ATPase and Ca2+ pump are P-type ATPases that use
      ATP hydrolysis to move ions against their electrochemical gradient. They
      differ from channels in requiring chemical energy and operating more than
      10,000× slower (10^7–10^8 ions/s in channels vs. much slower pumps).
    signature: "pump : ATP -> ion_against_gradient"
    code: "channel_rate ~ 1e7..1e8 /s; pump_rate ~ 1e3 /s"
    related: [kn03-na-k-pump, kn03-ptype-atpase, kn03-secondary-active-transport]
    causes: []
    caused_by: []
    resolves: []
    tags: [active-transport, atpase, definition]

  - id: kn03-ptype-atpase
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: P-type ATPase subunit structure
    type: Definition
    idris_version: 2
    summary: >
      P-type ATPases are formed from 110 kD α-subunits with 10 transmembrane
      α-helices; the α-subunit has cytoplasmic loops for ATP binding (N), ATP
      hydrolysis and pump phosphorylation (P), and transducing phosphorylation to
      transport (A). The Na+-K+ pump α-subunit associates with an obligatory
      β-subunit (and an FXYD modulatory protein).
    signature: "alpha(10 TM helices, N/P/A loops) + beta (obligatory)"
    code: "alpha_has loops: N (bind ATP), P (phosphorylate), A (transduce)"
    related: [kn03-primary-active-transport, kn03-na-k-pump]
    causes: []
    caused_by: [kn03-primary-active-transport]
    resolves: []
    tags: [structure, atpase, subunit]

  - id: kn03-secondary-active-transport
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Secondary active transport (cotransporters)
    type: Pattern
    idris_version: 2
    summary: >
      Cotransporters move one ion against its gradient using the energy stored in
      the gradient of a second ion (e.g. Na+-Ca2+ exchanger uses the Na+ gradient
      to expel Ca2+). The Na+ gradient itself is sustained by Na+-K+ pump ATP
      hydrolysis, so the ultimate energy source is ATP.
    signature: "cotransport : gradient(A) -> ion(B)_against_gradient"
    code: "energyStoredIn(Na+ gradient) drives Ca2+ against its gradient"
    related: [kn03-na-k-pump, kn03-na-ca-exchanger, kn03-cl-cotransporter]
    causes: []
    caused_by: [kn03-na-k-pump]
    resolves: []
    tags: [cotransport, antiporter, symporter]

  - id: kn03-na-ca-exchanger
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Na+-Ca2+ exchanger (antiporter)
    type: Example
    idris_version: 2
    summary: >
      The Na+-Ca2+ exchanger transports 3–4 Na+ into the cell (down the Na+
      gradient) for each Ca2+ removed (against its gradient), moving ions in
      opposite directions (antiporter). It is not an ATPase; it is powered by the
      Na+ gradient maintained by the Na+-K+ pump.
    signature: "exchange : 3..4 Na+_in <-> 1 Ca2+_out"
    code: "naIn = 3..4; caOut = 1; antiporter (opposite directions)"
    related: [kn03-secondary-active-transport, kn03-na-k-pump]
    causes: []
    caused_by: [kn03-secondary-active-transport]
    resolves: []
    tags: [calcium, exchanger, antiporter, example]

  - id: kn03-cl-cotransporter
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Chloride cotransporters and developmental shift of GABA
    type: Pattern
    idris_version: 2
    summary: >
      Cl− gradients are set by cotransporters: the Na+-K+-Cl− cotransporter
      imports 2 Cl− + 1 Na+ + 1 K+ (symporter), while the K+-Cl− cotransporter
      exports 1 Cl− with 1 K+. In mature neurons ECl is more negative than Vr, so
      Cl− channel opening hyperpolarizes; in immature neurons (and some
      pathological states such as epilepsy/chronic pain) the pattern reverts and
      GABA depolarizes.
    signature: "NKCC : 1 Na+ + 1 K+ + 2 Cl- in ; KCC : 1 K+ + 1 Cl- out"
    code: "ECl < Vr (mature) => GABA inhibitory; ECl > Vr (immature) => GABA excitatory"
    related: [kn03-secondary-active-transport, kn03-na-ca-exchanger]
    causes: []
    caused_by: [kn03-secondary-active-transport]
    resolves: []
    tags: [chloride, gaba, development, neocortex]

  - id: kn03-action-potential-feedback
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Regenerative positive feedback of the action potential
    type: Pattern
    idris_version: 2
    summary: >
      Once depolarization passes threshold, voltage-gated Na+ channels open
      rapidly; the resulting Na+ influx further depolarizes the membrane, opening
      yet more Na+ channels in an explosive regenerative positive-feedback cycle
      that drives Vm toward ENa (+55 mV). This is a self-reinforcing
      (attractor-like) loop central to neural excitation.
    signature: "depolarize -> Na+ channels open -> Na+ influx -> further depolarize"
    code: "feedback: dVm/dt > 0 while gNa rising past threshold"
    related: [kn03-steady-state-balance, kn03-goldman-equation]
    causes: [action-potential-upswing]
    caused_by: [voltage-gated-na-channels]
    resolves: []
    tags: [neocortex, action-potential, positive-feedback, excitation]

  - id: kn03-goldman-equation
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Goldman equation (permeability-weighted potential)
    type: Definition
    idris_version: 2
    summary: >
      The Goldman equation quantifies Vm from the permeabilities and
      concentrations of K+, Na+, and Cl− when Vm is not changing. At rest
      PK:PNa:PCl = 1.0:0.04:0.45 (Vm near EK); at the action-potential peak the
      ratio is 1.0:20:0.45, reducing to the Nernst equation for Na+.
    signature: "Vm = (RT/F) ln( (PK[K+]o + PNa[Na+]o + PCl[Cl-]i) / (PK[K+]i + PNa[Na+]i + PCl[Cl-]o) )"
    code: "Vm = (RT/F) * ln((PK*[K+]_o + PNa*[Na+]_o + PCl*[Cl-]_i)/(PK*[K+]_i + PNa*[Na+]_i + PCl*[Cl-]_o))"
    related: [kn03-equivalent-circuit, kn03-action-potential-feedback, kn03-driving-force-def]
    causes: []
    caused_by: []
    resolves: []
    tags: [goldman, permeability, membrane-potential]

  - id: kn03-equivalent-circuit
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Equivalent electrical circuit of the neuron
    type: Pattern
    idris_version: 2
    summary: >
      The neuron is modeled as an equivalent circuit: each ion-channel class is a
      conductance (resistor) γ in series with a battery E (its Nernst
      potential); total conductance is gX = NX × γX. The lipid bilayer is a
      capacitor Cm and the Na+-K+ pump is a current generator. This compositional
      decomposition of ionic currents into composed subsystem elements is a
      structural (categorical) composition of parts.
    signature: "iK = gK(Vm - EK);  gK = NK × γK;  V = Q/C"
    code: "totalCurrent = sum_X gX*(Vm - EX); gX = NX * gammaX"
    related: [kn03-ohm-modified, kn03-na-k-pump, kn03-goldman-equation]
    causes: []
    caused_by: []
    resolves: []
    tags: [kategoriaelmelet, equivalent-circuit, capacitor, composition]

  - id: kn03-resting-potential-calc
    source: Principles of Neural Science (6th ed.), Chapter 9 (Box 9-2)
    concept: Resting potential calculation via equivalent circuit
    type: Example
    idris_version: 2
    summary: >
      With gK = 10×10^−6 S, gNa = 0.5×10^−6 S, gCl = 4×10^−6 S, EK = −75 mV,
      ENa = +55 mV, ECl = −73 mV and no net current, the equivalent circuit yields
      Vm ≈ −68 mV, dominated by the high K+ conductance.
    signature: "Vm = EK + IK/gK = ECl + ICl/gCl = ENa + INa/gNa"
    code: "Vm ≈ -68 mV given the conductances above"
    related: [kn03-equivalent-circuit, kn03-goldman-equation]
    causes: []
    caused_by: [kn03-equivalent-circuit]
    resolves: []
    tags: [example, calculation, resting-potential]

  - id: kn03-electrogenic-pump
    source: Principles of Neural Science (6th ed.), Chapter 9
    concept: Electrogenic pump
    type: Definition
    idris_version: 2
    summary: >
      Because the Na+-K+ pump moves 3 Na+ out for every 2 K+ in, it generates a
      net outward ionic current and is said to be electrogenic; this makes the
      resting potential a few mV more negative than passive mechanisms alone
      would achieve.
    signature: "net_current = 3 Na+_out - 2 K+_in > 0 (outward)"
    code: "outwardChargePerCycle = 3 - 2 = +1 (electrogenic)"
    related: [kn03-na-k-pump]
    causes: []
    caused_by: [kn03-na-k-pump]
    resolves: []
    tags: [electrogenic, pump, definition]
