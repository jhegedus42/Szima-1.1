---
name: skill-algebra
description: >-
  Compose, combine, and transfer agent skills using category-theoretic algebra.
  Generate new composite SKILL.md files from algebraic expressions using six
  operations: composition (∘), parallel product (×), choice (+), iteration (*),
  tensor refinement (⊗), and functor transfer (F). Use whenever the user wants
  to create multi-skill workflows, combine existing skills into pipelines,
  transfer a skill across domains, or reason about skill composition
  mathematically. Also triggers on phrases like "compose skills", "skill
  algebra", "combine these skills", "transfer this skill to", "pipeline",
  "skill category theory", "tensor product of skills", or when the user
  describes a workflow that chains multiple existing skills together. Even
  if the user doesn't say "algebra" — if they describe wanting two skills to
  work together, or to iterate a skill until convergence, or to run skills in
  parallel, use this skill.
---

# Skill Algebra

Compose skills like functions. Every skill is a morphism with a typed signature.
The algebra generates concrete, installable SKILL.md files from expressions.

## Core Principle

Skills are morphisms in a category. They can be composed, multiplied, iterated,
and transferred. The algebra makes this precise and generates real composite
skills that orchestrate their constituents.

Every composite has two aspects:
- **Spatial (结构)** — the static structure of the generated skill: what it does, its template, its code. Like Chinese characters: 2D, compositional, category-theoretic.
- **Temporal (時態)** — how the skill runs and evolves over iterations: refinement loops, convergence checks, state transitions. Like Hungarian grammar: rich tense, aspect, mood.

A complete skill needs both — structure without evolution is rigid; evolution
without structure is chaotic. This mirrors physics: a coupling constant needs
both its structural value and its vacuum-fluctuation corrections to be complete.

## The Six Operations

### 1. Composition: `B ∘ A`

Sequential pipeline. A runs first; its output feeds into B.

**When to use:** You want skill A's output to become skill B's input.

**Generated skill behavior:**
1. Follow skill A's instructions to completion
2. Take A's output as input for skill B
3. Follow skill B's instructions with that input
4. Return B's final output

**Type rule:** A: X→Y, B: Y→Z ⟹ B∘A: X→Z

**Example:** `handoff ∘ research` — research a topic, then hand off the findings

### 2. Parallel Product: `A × B`

Run both skills simultaneously; merge their outputs. Neither result is
discarded — both are kept and synthesized.

**When to use:** You want two independent perspectives on the same input,
and you need both results combined rather than choosing one.

**Generated skill behavior:**
1. Spawn A and B as parallel subagents (or run sequentially if no subagents available)
2. Collect outputs from both
3. Synthesize: identify agreements, contradictions, and unique insights from each
4. Return the merged result

**Type rule:** A: X→Y, B: X→Z ⟹ A×B: X→(Y×Z)

**Philosophy:** This embodies "keep everything" — both perspectives coexist.
No early termination. The product holds all views simultaneously, letting
downstream skills or the user see the full picture.

**Example:** `perspective-review × multi-branch` — review from multiple
perspectives AND explore multiple branches, synthesizing both

### 3. Choice: `A + B`

Context-dependent dispatch. Pick A or B based on the situation.

**When to use:** Two skills serve the same purpose but for different domains
or conditions. The composite automatically dispatches to the right one.

**Generated skill behavior:**
1. Evaluate dispatch criteria
2. If criteria match A's domain → run A
3. If criteria match B's domain → run B
4. Both produce the same output type

**Type rule:** A: X→Y, B: X→Y ⟹ A+B: X→Y

**Example:** `find-docs + discover-information` — use doc lookup for known
tools, discovery for unknown ones

### 4. Iteration: `A*`

Repeat skill A until its output stabilizes — stops changing between runs.

**When to use:** A single pass isn't enough; each run reveals new information
that feeds back. Keep going until you converge.

**Generated skill behavior:**
1. Run skill A, record output O₁
2. Run skill A again with O₁ as context, record output O₂
3. Compare O₂ to O₁
4. If significantly different → continue (run A with O₂)
5. If stable (Oₙ ≈ Oₙ₋₁) → converged, return Oₙ
6. Safeguard: stop after max_iterations even if not converged

**Type rule:** A: X→X (endofunction) ⟹ A*: X→X

**Philosophy:** This is the temporal/evolutionary aspect — each iteration is
a refinement step, like a tense correction moving toward a fixed point.
The Hungarian grammatical concept of aspect (ongoing vs completed) maps
directly: iteration is imperfective aspect, convergence is perfective.

**Example:** `(perspective-review)*` — keep reviewing until no new issues

### 5. Tensor: `A ⊗ B`

Bidirectional refinement loop. A and B feed each other alternately until
both stabilize. Neither dominates; they coevolve.

**When to use:** Two skills have complementary perspectives that should
inform each other. Running them sequentially loses the feedback; running
them in parallel loses the interaction. Tensor captures the dialogue.

**Generated skill behavior:**
1. Round 1: Run A → output A₁. Feed A₁ to B → output B₁.
2. Round 2: Feed B₁ back to A → output A₂. Feed A₂ to B → output B₂.
3. Continue rounds until Aₙ ≈ Aₙ₋₁ AND Bₙ ≈ Bₙ₋₁ (both stabilize)
4. Return (A_final, B_final) — both perspectives, mutually refined
5. Safeguard: max_rounds limit

**Type rule:** A: X×Y'→X', B: X'×Y→Y' ⟹ A⊗B: (X,Y) → (X*, Y*)

**Philosophy:** This is the heart of "keep everything, refine."
Both perspectives coexist and sharpen each other through dialogue.
No perspective closes the question for the other.
This is structure (from A, spatial/Chinese) ⊕ evolution (from B,
temporal/Hungarian) — the complete reasoning framework.

**Example:** `plan ⊗ perspective-review` — planning informs what to review;
review informs how to re-plan. Iterate until both the plan and the review
are stable and mutually consistent.

### 6. Functor: `F(A)`

Transfer skill A from one domain to another. The functor F preserves the
skill's workflow structure while mapping domain-specific content.

**When to use:** A skill works well in one domain and you want the same
workflow applied to a different domain — different language, platform,
tool ecosystem, or problem space.

**Generated skill behavior:**
1. Read skill A's complete structure (steps, patterns, checks, heuristics)
2. Identify domain-specific elements (syntax, tool names, conventions)
3. Map each domain-1 element to its domain-2 equivalent
4. Generate a new skill with identical structure, translated content
5. Verify functor laws: F preserves identity and composition

**Functor laws to verify:**
- F(id_skill) = id_skill (trivial steps stay trivial)
- F(B∘A) = F(B)∘F(A) (transferred pipeline = pipeline of transfers)

**Example:** `F(python-testing)` where F: Python→Rust — create a Rust
testing skill with the same TDD workflow, translated syntax and tools

## Type System

Every skill has a signature: `skill_name: InputType → OutputType`

Common types (inferred from skill descriptions):
- **Query** — a question, search term, or task description
- **Code** — source code in any language
- **Findings** — research results, discovered information
- **Plan** — structured implementation or action plan
- **Artifact** — any produced file (document, chart, config)
- **Review** — evaluation, critique, or assessment
- **Context** — conversation history, memory, environment state
- **Handoff** — briefing for next session or agent

Type-checking rules:
- Composition B∘A requires A.output_type = B.input_type
- Product A×B requires same input type for both
- Choice A+B requires same input AND output types
- Iteration A* requires input_type = output_type (endofunction)
- Tensor A⊗B requires A consumes B's output type and vice versa

When types don't match, insert adapter skills or adjust the expression.

## MDL Composition Principle

When multiple algebraic expressions achieve the same goal, choose the one
whose generated SKILL.md is shortest. Shorter description = fewer bits =
lower Kolmogorov complexity = more likely correct (Solomonoff induction).

This applies at two levels:
1. **Between expressions:** prefer `A ∘ B ∘ C` over a complex nested tensor
   if both achieve the goal
2. **Within generated skills:** minimize boilerplate; let the constituent
   skills' own instructions do the heavy lifting

## Generating a Composite Skill

### Step 1: Scan available skills

Read skill directories. Extract from each SKILL.md:
- Name and description (for triggering)
- Input/output types (inferred from description keywords)
- Key dependencies or required tools

### Step 2: Parse the algebraic expression

The user describes their intent. Translate to an expression:
- "First X then Y" → `Y ∘ X`
- "Both at the same time" → `X × Y`
- "Keep going until stable" → `X*`
- "They should inform each other" → `X ⊗ Y`
- "Same workflow but for [different domain]" → `F(X)`

### Step 3: Typecheck

Verify the expression is well-typed. Flag mismatches. Suggest adapters.

### Step 4: Generate SKILL.md

Write the composite skill using the operation's pattern. The generated file:
- References constituent skills by name and path
- Contains the orchestration logic for the operation
- Includes the type signature
- Has a triggering description that covers the composite's use case

### Step 5: Register

Place in the skills directory. Verify the description triggers correctly.

## Deeper Connections

See [philosophy.md](references/philosophy.md) for how this algebra connects to:
- Chinese ⊕ Hungarian complementarity (spatial structure ⊕ temporal evolution)
- The "keep everything, refine" epistemology (tensor product)
- MDL / Kolmogorov complexity for skill selection
- Horgony's 64-noun framework and category theory
- The α⁻¹ insight: structure (137.036) + vacuum (4.3 bits) = complete

See [operations.md](references/operations.md) for formal definitions, worked
examples, and edge cases for each operation.

See [type-system.md](references/type-system.md) for type inference rules and
the full type-checking algorithm.
