module Index

import Ontology
import Tree

leaf : String -> String -> List String -> Double -> Tree t
leaf lbl dsc rfs cf = Leaf (MkNode lbl dsc rfs cf)

-- Leaf definitions first (used by goals below)
verifyTool : Tree Task
verifyTool =
  Branch (MkNode "Build verifier" "SAT + type-level verification pipeline" ["wc_002"] 0.9)
  [ (Subtask ** (leaf "verify_chain.py" "SymPy DPLL SAT solver" ["wc_003"] 0.95, TaskSubtask))
  , (Subtask ** (leaf "WhyChain.idr" "Idris type-level proofs with 7 type families" ["wc_002"] 1.0, TaskSubtask))
  ]

-- Goals
memorySystem : Tree Goal
memorySystem =
  Branch (MkNode "Memory system" "Causal why-chain with persistence across sessions" [] 1.0)
  [ (Subgoal ** (leaf "JSONL store"   "~/.config/opencode/memory/why-chain.jsonl"   ["wc_001"]  1.0, GoalSubgoal))
  , (Subgoal ** (leaf "GAN verify"    "3-agent: Generator/Adversary/Normalizer"      ["wc_003"]  0.95, GoalSubgoal))
  , (Subgoal ** (leaf "Compaction"    "Drop irrelevant, keep causal path"             []          0.85, GoalSubgoal))
  , (Subgoal ** (leaf "Boot inject"   "~10k token injection of last entries"          []          0.9,  GoalSubgoal))
  , (Task ** (verifyTool, GoalTask))
  ]

skillInfra : Tree Goal
skillInfra =
  Branch (MkNode "Skill infrastructure" "70+ skills across laptop/server/bundle" [] 0.95)
  [ (Task ** (leaf "Map skills"   "Inventory 70 skills across 3 locations"          ["wc_001"]  1.0, GoalTask))
  , (Task ** (leaf "Skill registry" "skill-registry.md with 9 capability domains"    ["wc_002"]  0.95, GoalTask))
  , (Task ** (leaf "Knowledge files" "5 files + knowledge-index skill + decision trees" [] 0.9, GoalTask))
  ]

costOptim : Tree Goal
costOptim =
  Branch (MkNode "Cost optimization" "Provider routing with fallback tiers" ["wc_001"] 0.95)
  [ (Task ** (leaf "Provider routing"   "provider-routing.md: tiers FREE→VERY EXP"       ["wc_002"] 0.95, GoalTask))
  , (Task ** (leaf "Task routing"       "Task type → cheapest capable model"             ["wc_002"] 0.9,  GoalTask))
  , (Task ** (leaf "Fallback chain"     "flash → pro → grok → claude"                    ["wc_002"] 0.85, GoalTask))
  ]

formalTypes : Tree Goal
formalTypes =
  Branch (MkNode "Formal types" "Idris type definitions for chain, ontology, tree" [] 1.0)
  [ (Subgoal ** (leaf "WhyChain.idr" "7 families: Entry, Linked, Acyclic, Gen/Adv/NrmOK, TROK, VChain" ["wc_002"] 1.0, GoalSubgoal))
  , (Subgoal ** (leaf "Ontology.idr" "OType, Valid (35 edges), Triggers, Resolves" [] 1.0, GoalSubgoal))
  , (Subgoal ** (leaf "Tree.idr"     "Typed ontology tree: NodeData, Tree, size, render" [] 1.0, GoalSubgoal))
  ]

hardRules : Tree Rule
hardRules =
  Branch (MkNode "Hard rules" "Never-violate rules embedded in AGENTS.md" [] 1.0)
  [ (HardRule ** (leaf "No server writes" "Never create/edit/delete on 88.99.218.155 without permission" ["wc_007"] 1.0, RuleHardRule))
  , (HardRule ** (leaf "3 errors = infra fix" "3 identical errors → fix root cause permanently" ["wc_004"] 1.0, RuleHardRule))
  ]

lessonLearned : Tree Observation
lessonLearned =
  Branch (MkNode "Lessons learned" "Key patterns from this session" [] 0.9)
  [ (Pattern ** (leaf "Types define result"     "Code is almost zero; types ARE the spec"       [] 1.0, ObservationPattern))
  , (Pattern ** (leaf "Dependent tree indexing" "Ontology trees with Valid proofs are self-indexing" [] 0.95, ObservationPattern))
  , (Pattern ** (leaf "Cost-aware routing"      "Default cheap, escalate on failure"           [] 0.9, ObservationPattern))
  , (Error ** (leaf "SSH timeouts"              "3+ timeouts → SSH keepalive not configured"   ["wc_004"] 0.9, ObservationError))
  , (Fix ** (leaf "SSH keepalive"               "ServerAliveInterval 30 added to infra"        ["wc_004"] 0.95, ObservationFix))
  , (Decision ** (leaf "Idris over Python"      "Types enforce logic; Python for runtime SAT"  ["wc_001"] 1.0, ObservationDecision))
  ]

pendData : Tree Decision
pendData =
  Branch (MkNode "Pending decisions" "Next moves from session" [] 0.8)
  [ (Reason ** (leaf "Sub-agent allocator" "Cost-optimal model/MCP per task" [] 0.85, DecisionReason))
  ]

session : Tree Root
session =
  Branch (MkNode "Session 2026-07-30" "Meta-agent system: memory, providers, skills, types" [] 1.0)
  [ (Goal ** (memorySystem, RootGoal))
  , (Goal ** (skillInfra, RootGoal))
  , (Goal ** (costOptim, RootGoal))
  , (Goal ** (formalTypes, RootGoal))
  , (Rule ** (hardRules, RootRule))
  , (Observation ** (lessonLearned, RootObservation))
  , (Decision ** (pendData, RootDecision))
  ]

main : IO ()
main = putStrLn (render session)
