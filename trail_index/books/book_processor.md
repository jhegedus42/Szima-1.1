# Book Processor — Extraction Specification

## Purpose
Read technical books via subagents (not directly) to save context.
Extract causal relations, patterns, and indexed references.

## Extraction Schema

Every extracted unit is a **ConceptNote**:

```yaml
id: <unique-id>
source: <book-title + chapter>
concept: <term or pattern>
type: <Rule | Pattern | Pitfall | Example | Definition | CausalRelation>
idris_version: <1 | 2 | both>
summary: <1-3 sentence explanation>
signature: <type signature if applicable>
code: <code snippet if applicable>
related: [<list of related concept IDs>]
causes: [<if this pattern leads to something>]
caused_by: [<if this pattern depends on something>]
resolves: [<what problem this solves>]
tags: [<keyword tags>]
```

## Causal Relation Types (matching Ontology.idr Triggers/Resolves)

| Idris concept | Triggers | Resolves |
|---|---|---|
| Dependent types | Type-safe indexing | Runtime errors |
| DPair (x ** y) | Heterogeneous collections | Type erasure issues |
| auto-implicit | Proof search | Manual proof passing |
| So Bool | Compile-time bool checks | Runtime assertions |
| public export | Cross-module visibility | Private-by-default restriction |
| mutual block | Mutual recursion | Forward reference errors |
| with rule | Dependent pattern matching | Case analysis complexity |
| rewrite | Type equality proofs | Manual replace |
| Fin n | Safe vector indexing | Bounds checks |
| Vect n a | Length-indexed lists | List length bugs |

## Processing Pipeline

```
Book text → Subagent chunk → Extract ConceptNotes → Index by concept → Save as markdown
                                                                         ↓
                                                              Reference from HARNESS.idr
```

## Invocation

```bash
# Process a book:
opencode task --prompt "Read books/<file>.txt, extract all ConceptNotes per schema above, save to books/<file>-extracted.md" --subagent-type general
```
