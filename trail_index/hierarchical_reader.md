# Hierarchical Reader — Architecture

## Layer Model

```
                ┌─────────────────────────────────────┐
  Level 0        │ Orchestrator (main agent)            │
  Orchestrator   │  decides what to read, launches,     │
                 │  verifies, writes to chain           │
                 └──────────────────┬──────────────────┘
                                    │
           ┌────────────────────────┼────────────────────────┐
           │                        │                        │
    ┌──────▼──────┐         ┌───────▼───────┐      ┌────────▼────────┐
    │ Pre-Reader  │         │ Pre-Reader     │      │ Pre-Reader      │
 L1 │ (explore)   │  ...    │ (explore)      │      │ (explore)       │
    │ chunk 1     │         │ chunk N        │      │ chunk N+1       │
    │ $0          │         │ $0             │      │ $0              │
    └──────┬──────┘         └───────┬───────┘      └────────┬────────┘
           │                        │                        │
           └────────────┬───────────┴────────────┬───────────┘
                        │                        │
                 ┌──────▼──────┐          ┌──────▼──────┐
                 │ Merger      │          │ Verifier    │
 L2              │ (medium)    │          │ (GAN trip)  │
                 │ consolidate │          │ Gen/Adv/Nrm │
                 │ deduplicate │          │ $~0.15/M    │
                 └──────┬──────┘          └──────┬──────┘
                        │                        │
                        └───────────┬────────────┘
                                    │
                            ┌───────▼───────┐
                            │ Index Writer   │
 L3                         │ compacts into  │
                            │ OntologyTree   │
                            │ + why-chain    │
                            └───────┬───────┘
                                    │
                                    ▼
                          ┌─────────────────┐
                          │ Compactor        │
                          │ (prune, archive, │
                          │  respawn signal) │
                          └─────────────────┘
```

## Agent Cost Allocation

| Level | Model | Est. $/M tok | When |
|---|---|---|---|
| L1 Pre-Reader | deepseek-v4-flash | $0.15 | Always |
| L2 Merger | deepseek-v4-pro / sonar-pro | $2-3 | Per reading batch |
| L2 Verifier | deepseek-v4-flash | $0.15 | Always (3x GAN) |
| L3 Index | why-chain protocol | $0 | Internal |
| L3 Compactor | deepseek-v4-flash | $0.15 | Context > 8k tok |

## Association Schema

Every extracted unit is an **Association**:

```
concept_name
├── ontology_type: <OType>
├── source: <file:line-start..line-end>     ← EXACT provenance
├── reader_id: <agent-id>
├── confidence: <0.0-1.0>
├── triggers: [<concept IDs>]               ← causal "this leads to"
├── resolves: [<concept IDs>]               ← causal "this fixes"
├── signature: <type sig>                   ← if code-related
├── code: <snippet>                         ← if code-related
├── tags: [<keywords>]
└── why_chain_ref: <wc_NNN>                 ← backlink to decision
```

## Hallucination Detection (GAN Triple)

| Role | Checks | Action |
|---|---|---|
| Generator | Can narrative be reconstructed from associations? | If no → low confidence |
| Adversary | Do any 2+ associations contradict each other? | Flag for review |
| Normalizer | Is confidence > 0.5? Provenance exists? | Drop if below threshold |

**Decision rule** (Steane [[7,1,3]]): 2/3 must pass.

## Compaction Protocol

```
WHEN context_used > 8000 tokens:
  1. Score each association: confidence * recency * relevance
  2. Drop bottom 30% (write to archive)
  3. Merge duplicates: keep highest-confidence source, merge tags
  4. Write condensed index to ~/.config/opencode/memory/condensed-index.json
  5. Write why-chain entry: wc_NNN "Compaction: dropped N, kept M"
  6. Signal "compacted, M associations active"
```

## Respawning Protocol

```
WHEN new session starts / context limits hit:
  1. Load condensed-index.json
  2. Load last 10 why-chain entries
  3. Reconstruct causal summary from why-chain
  4. Load top M associations by confidence
  5. Signal "respawned from session <prev>, continuity OK"
  6. Continue with: condensed index + causal chain head
```

## Implementation Notes

- Pre-Readers run in parallel via `opencode task` (explore agent, $0)
- Merger runs once after all pre-readers complete
- Compactor runs when context threshold is exceeded
- All writes go to local (laptop) only — server writes require permission
