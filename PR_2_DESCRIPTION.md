## Summary
This PR snapshots the **Kandel → Szima integration** work and adds:

- E8-related Idris module work (`E8Kartan`, plus small probe module)
- Research and planning notes for the branch
- A large Kandel knowledge ingestion set (extractions, Hungarian translations, and indexing artifacts)

## What changed

### 1) Idris modules
- Added `szima_ter/modul/E8Kartan.idr`
  - Introduces an E8 Cartan matrix representation
  - Includes helper functions and checks (symmetry, diagonal, valid entries, determinant, root-consistency bridge)
- Added `szima_ter/modul/ProbaIdo.idr`
  - Minimal probe module importing `E8Kartan`

### 2) Project notes / plans
- Added `plans/TERV_szerver_ox_alpha_free_aug22.md`
- Added `kutatasi_naplo/2026-08-24_kandel_szima_integracio_session.md`

### 3) Kandel ingestion artifacts
Under `trail_index/books/`, this PR adds:
- `kandel_extracted_chunk_01.md` … `kandel_extracted_chunk_15.md`
- `kandel_magyar_chunk_01.txt` … `kandel_magyar_chunk_15.txt`
- `kandel_e8_index.md`
- `kandel_szima_kapcsolat.md`
- Generator and helper files (including awk scripts and some error/auxiliary files)

## Scope / impact
- **Large documentation/data ingest PR** (41 files, ~8.5k additions)
- No deletions
- Primary impact is repository content expansion and indexing artifacts, with incremental Idris module additions.

## Validation notes
- PR is currently mergeable (`mergeable: true`), with GitHub reporting `mergeable_state: unstable` at time of check.
- No direct merge conflicts detected.

## Suggested follow-up after merge
- Consider splitting future large content-ingest work into smaller thematic PRs (code vs generated/index artifacts) to simplify review.
- Consider moving transient error artifacts (`*_err.txt`, empty conversion stubs) to ignored build/output paths if they are non-source deliverables.
