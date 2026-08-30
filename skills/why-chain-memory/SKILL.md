---
name: why-chain-memory
description: >
  Causal memory system — maintains a compressed why-chain across context limits.
  External helper agents index, compact, GAN-verify, and inject the causal thread
  every ~10k tokens. Drops irrelevant info, keeps the why/causal chain.
---

# Why-Chain Memory System

## Architecture

```
Session ──→ WhyChain Store (external JSONL)
                │
          ┌─────┼─────┐
          │     │     │
     Indexer  Compactor  GAN Verifier
     (writes) (prunes)  (checks)
          │     │     │
          └─────┼─────┘
                │
         Injector ←── loaded every ~10k tokens
                │
         Back into context
```

## WhyChain Store

External file: `~/.config/opencode/memory/why-chain.jsonl`

Each entry:

```json
{
  "id": "wc_001",
  "session": "ses_abc123",
  "timestamp": "2026-07-30T12:00:00Z",
  "tokens_used": 10234,
  "why": "We are building X because Y requires Z and the server is the brain",
  "what": "Installed provider-routing skill on server",
  "context": "User wanted LLM cost optimization across 16 providers",
  "decision": "Provider routing > cost tracker, because routing is prerequisite",
  "causal_parent": "wc_000",
  "confidence": 0.95,
  "gan_verified": true
}
```

## Protocol

### 1. INDEX — After Every Significant Turn (~1k tokens)

Spawn a sub-agent with:

```
You are the WhyChain Indexer.

Read the last exchange. Extract:
- WHY: why are we doing this (the causal reason)
- WHAT: what was actually done
- DECISION: if a choice was made, why this option over others
- PARENT: the previous causal step this builds on

Return as JSON entry. Keep it under 200 tokens. Drop all irrelevant detail.
```

Append to `~/.config/opencode/memory/why-chain.jsonl`.

### 2. INJECT — Every ~10k Tokens

Before continuing, load the chain:

```
Read ~/.config/opencode/memory/why-chain.jsonl.
Summarize the causal thread: why we started, what decisions were made, what's next.
Return a compact (under 500 tokens) why-chain summary.
```

Prepend this summary to the next response as:

```
[WhyChain]
We are here because: <causal chain>
Last decision: <why X was chosen over Y>
Next expected: <what comes next>
[/WhyChain]
```

### 3. COMPACT — When Chain Exceeds ~50 Entries

Spawn a compactor agent:

```
You are the WhyChain Compactor.

Read all entries in ~/.config/opencode/memory/why-chain.jsonl.

1. Merge consecutive entries where nothing changed.
2. Drop entries tagged "irrelevant" or where the causal parent was invalidated.
3. For each remaining entry, ask: "If this were deleted, would the why-chain break?"
   - If no: drop it.
   - If yes: keep it, but compress to 1 line.
4. Ensure the surviving chain forms a complete causal path from start to now.
5. Rewrite the file with only surviving entries, re-indexed.
```

### 4. GAN VERIFY — Every Compact Cycle

Run three verifier agents in parallel on the compacted chain:

| Agent | Task |
|---|---|
| **Generator** | Given the chain, reconstruct the session narrative |
| **Adversary** | Find contradictions, non-sequiturs, unsupported leaps in the chain |
| **Normalizer** | Merge verified entries, mark uncertain ones with `confidence: < 0.7`, delete if confidence < 0.3 |

If any entry is flagged by both Adversary and Normalizer as invalid → **delete it** and note in the chain: `"Entry wc_NNN deleted by GAN: <reason>"`.

### 5. WHY-CHAIN BOOT — Every Session Start

```
Load ~/.config/opencode/memory/why-chain.jsonl (last 20 entries).
Restore the causal thread: why we exist, what we're building, what comes next.
```

## File Locations

| What | Path |
|---|---|
| WhyChain store | `~/.config/opencode/memory/why-chain.jsonl` |
| Compaction log | `~/.config/opencode/memory/compaction-log.jsonl` |
| GAN verification log | `~/.config/opencode/memory/gan-log.jsonl` |
| Session index | `~/.config/opencode/memory/session-index.jsonl` |

## Integration with Existing Skills

This system composes the bundle skills:

| System part | Existing skill | What it provides |
|---|---|---|
| Causal structure | `causal-grounded-memory` | PACTS+SOW frame, valid_why, valid_under_circumstances |
| Compression | `concept-frame-encoding` | Compact (object, action, qualifier, grounding) tokens |
| Centrality detection | `central-concept-auditor` | Removal-impact scoring, premise convergence |
| Session threads | `thread-manager` | Thread lineage tracking |
| Session handoff | `handoff` | HANDOFF file creation at session end |

## Verification with SAT/Symbolic Solver

Uses **SymPy** (propositional logic SAT solver) + **triple GAN** verification.

```bash
# Verify the chain (acyclic, consistent, triple-verified)
python3 ~/.config/opencode/memory/verify_chain.py

# Output:
# - acyclic: no cycles in causal graph
# - consistency: SAT solver checks Implies(child, parent) constraints
# - triple_verify: Generator + Adversary + Normalizer (at least 2/3 must pass)
#   - Generator: can narrative be reconstructed from chain?
#   - Adversary: finds contradictions and cycles
#   - Normalizer: checks confidence thresholds, drops < 0.3
```

The verifier **auto-compacts** when verification fails — drops irrelevant entries while preserving the causal path to root.

## Symbolic Encoding

Each entry is encoded as a proposition `why_X` with constraints:

```
why_child → why_parent          # causal link
¬why_entry if confidence < 0.3  # rejected entries
why_entry if confidence >= 0.9  # verified entries
```

SAT solver checks if all constraints are simultaneously satisfiable.
If not, it finds the minimal set of contradictory entries.

## Quick Start

```bash
# Initialize
mkdir -p ~/.config/opencode/memory
echo '[]' > ~/.config/opencode/memory/why-chain.jsonl

# Load the skill
skill why-chain-memory

# After building up entries, run verification
python3 ~/.config/opencode/memory/verify_chain.py
```
