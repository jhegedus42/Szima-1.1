# Skill Ontology Report — deepseekPage

Category-theoretic classification of the agent skillscape, augmented with the
project-local `consciousness` skill and mapped onto the project's own CT
framework (`CategoryTheory64.idr`).

## Scan

- Global scan: **55 skills** across `~/.agents/skills`, `~/.cursor/skills`, `~/.codex/skills`.
- Project-local (not in global scan): **1** — `consciousness` (`skills/consciousness/SKILL.md`).
- **Total objects in category 𝒮: 56.**

## Strata (ontology)

| Stratum | Count | Members (global + project) |
|---------|-------|-----------------------------|
| meta | 14 | plan, planning, handoff, handoff-progressive, thread-manager, init, delegate-manager, loop, server-handoff, babysit, … |
| epistemic | 13 | research, find-docs, find-skills, discover-information, learn-tool, parallel-web-search, smithery-homepage, human-understanding, … |
| operational | 11 | playwright, agent-browser, smithery-ai-cli, hetzner-server, vastai, kimi-webbridge, secrets-manager, … |
| generative | 5 | frontend-design, skill-creator, ux-iterative-visualizer, … |
| integrative | 0* | multi-branch, cross-review, delegate-manager (keyword overlap) |
| evaluative | 7 | zen-review, zen-comprehensive-review, perspective-review, cross-review, lab-situation-auditor, post-training-analysis, **consciousness** |
| document | 5 | zen-office-{docx,pdf,pptx,xlsx}, reproducible-physics-report |

`consciousness` lands in **evaluative** (verifies KB integrity) but is also a
**meta-adjunct** — it gates every session start and every phase transition.

## The key adjunction — and it's the project's own

The project's `CategoryTheory64.idr` proves 7 adjoint dual pairs. The *first* and
most foundational — **Free ⊣ Cofree** — is instantiated directly in `src/`:

| CT role | Skill / script | Direction |
|---------|----------------|-----------|
| **Free (left adjoint, constructive)** | `src/extract_units.py` | builds KB from frozen source |
| **Cofree (right adjoint, observational)** | `consciousness` (`src/check_consciousness.py`) | verifies KB against its essence |
| **Unit of adjunction** η | `data/index/manifest.json` (hash written after extraction) | Free → Cofree |
| **Counit** ε | `consciousness --repair` (re-runs Free when Cofree detects drift) | Cofree → Free |

This is `Free ⊣ Cofree` literally embodied in the build pipeline. The `--repair`
flag *is* the counit of the adjunction: when observation (Cofree) finds the
state has drifted from its essence, it calls back to construction (Free) to
restore it.

## Project's 7 dual pairs ↔ skillscape

| Duality (CategoryTheory64.idr) | Left (free) | Right (evaluative) |
|---|---|---|
| Free ⊣ Cofree | `extract_units.py` | `consciousness` |
| Initial ⊣ Terminal | `init` | `handoff` |
| Product ⊣ Coproduct | `plan` (all branches) | `multi-branch` (alternatives) |
| Equalizer ⊣ Coequalizer | `research` (narrows) | `cross-review` (merges) |
| Mono ⊣ Epi | `plan` (injects spec) | `zen-review` (surjects verdict) |
| Pullback ⊣ Pushout | `parallel-web-search` (fiber) | `cross-review` (amalgamation) |
| Limit ⊣ Colimit | `plan × research` (all required) | `find-docs + research` (either) |

## Morphism chains

| Chain | Reading |
|-------|---------|
| `extract_units → consciousness` | Free constructs, Cofree verifies (the project's core loop) |
| `consciousness → plan` | audit gates planning (run at session start) |
| `research → plan → frontend-design → zen-review` | epistemic → meta → generative → evaluative |
| `find-skills → skill-creator` | demand → supply |
| `skill-ontology → find-skills` | classifies (this skill) |
| `skill-suggestor → skill-creator` | detects need → authors (how `consciousness` got created) |

## Adjoint pairs (skillscape)

| L (constructive) | R (evaluative) | Unit |
|------------------|----------------|------|
| `extract_units.py` | `consciousness` | Free ⊣ Cofree (project core) |
| research | zen-review | explore ⊣ evaluate |
| plan | zen-review | specify ⊣ audit |
| frontend-design | perspective-review | generate ⊣ critique |
| skill-creator | find-skills | author ⊣ discover |

## Symmetries (involutive duals)

| σ swaps | Reading |
|---------|---------|
| generator ↔ discriminator | GAN validation loop |
| Free (extract) ↔ Cofree (consciousness) | construct ↔ observe |
| plan ↔ review | design ⊣ audit |
| explore ↔ implement | analysis ⊣ synthesis |

## Algebraic structures

- **Product (limit)**: `plan × research` before implement — both required.
- **Coproduct (colimit)**: `find-docs + parallel-web-search` — either suffices for discovery.
- **Endofunctor**: `consciousness` (Skills-state → Skills-state, idempotent on intact state), `loop`, `babysit`.
- **Monad**: `consciousness --repair` (T² = T: re-repair on already-intact state is a no-op).
- **Initial object**: `init`, `find-skills` (no prerequisites).
- **Terminal object**: `handoff`, `conversation-learning` (absorb workflow output).

## Regenerate

```bash
python3 ~/.agents/skills/skill-ontology/scripts/analyze_skills.py \
  ~/.agents/skills/skill-ontology/output/ontology.json
```

Global scan only; project-local `consciousness` is annotated by hand here since
the scanner doesn't traverse `deepseekPage/skills/`.
