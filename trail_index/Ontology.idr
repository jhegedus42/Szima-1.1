module Ontology

||| Ontology type: every concept in the trail tree is tagged by one.
public export
data OType =
    Root
  | Goal | Subgoal
  | Task | Subtask | Action
  | Decision | Preference | Rejection
  | Reason | Cause | Constraint
  | Observation | Error | Result | Pattern
  | Fix | Patch | InfraFix
  | Rule | HardRule | Convention
  | Tool | Skill | Mcp
  | Question | Clarification

public export
Show OType where
  show Root         = "Root"
  show Goal         = "Goal"
  show Subgoal      = "Subgoal"
  show Task         = "Task"
  show Subtask      = "Subtask"
  show Action       = "Action"
  show Decision     = "Decision"
  show Preference   = "Preference"
  show Rejection    = "Rejection"
  show Reason       = "Reason"
  show Cause        = "Cause"
  show Constraint   = "Constraint"
  show Observation  = "Observation"
  show Error        = "Error"
  show Result       = "Result"
  show Pattern      = "Pattern"
  show Fix          = "Fix"
  show Patch        = "Patch"
  show InfraFix     = "InfraFix"
  show Rule         = "Rule"
  show HardRule     = "HardRule"
  show Convention   = "Convention"
  show Tool         = "Tool"
  show Skill        = "Skill"
  show Mcp          = "Mcp"
  show Question     = "Question"
  show Clarification = "Clarification"

||| Ontology hierarchy: every constructor is a valid parent→child edge.
||| Reading these signatures IS reading the ontology.
public export
data Valid : (parent, child : OType) -> Type where

  -- Root → top-level categories
  RootGoal        : Valid Root Goal
  RootDecision    : Valid Root Decision
  RootRule        : Valid Root Rule
  RootObservation : Valid Root Observation
  RootQuestion    : Valid Root Question
  RootTool        : Valid Root Tool

  -- Goal ↔ Subgoal / Task
  GoalSubgoal     : Valid Goal Subgoal
  GoalTask        : Valid Goal Task

  -- Subgoal → Task
  SubgoalTask     : Valid Subgoal Task

  -- Task → Subtask / Action / Result
  TaskSubtask     : Valid Task Subtask
  TaskAction      : Valid Task Action
  TaskResult      : Valid Task Result

  -- Subtask → Action
  SubtaskAction   : Valid Subtask Action

  -- Action → Result / Observation
  ActionResult    : Valid Action Result
  ActionObs       : Valid Action Observation

  -- Decision → Reason / Preference / Rejection
  DecisionReason    : Valid Decision Reason
  DecisionPrefer    : Valid Decision Preference
  DecisionReject    : Valid Decision Rejection

  -- Preference / Rejection → Reason
  PreferenceReason  : Valid Preference Reason
  RejectionReason   : Valid Rejection Reason

  -- Reason → Cause / Constraint
  ReasonCause       : Valid Reason Cause
  ReasonConstraint  : Valid Reason Constraint

  -- Observation → Error / Result / Pattern / Fix / Decision
  ObservationError  : Valid Observation Error
  ObservationResult : Valid Observation Result
  ObservationPattern : Valid Observation Pattern
  ObservationFix    : Valid Observation Fix
  ObservationDecision : Valid Observation Decision

  -- Error → Cause / Fix
  ErrorCause  : Valid Error Cause
  ErrorFix    : Valid Error Fix

  -- Fix → Patch / InfraFix
  FixPatch     : Valid Fix Patch
  FixInfraFix  : Valid Fix InfraFix

  -- Rule → HardRule / Convention
  RuleHardRule  : Valid Rule HardRule
  RuleConvention : Valid Rule Convention

  -- Tool → Skill / Mcp
  ToolSkill  : Valid Tool Skill
  ToolMcp    : Valid Tool Mcp

  -- Question → Clarification
  QuestionClarification : Valid Question Clarification


||| Causal dynamics: what triggers what.
public export
data Triggers : (cause, effect : OType) -> Type where

  ErrorCausesFix        : Triggers Error Fix
  ReasonCausesDecision  : Triggers Reason Decision
  DecisionCausesAction  : Triggers Decision Action
  ActionCausesResult    : Triggers Action Result
  ActionCausesObs       : Triggers Action Observation
  GoalCausesTask        : Triggers Goal Task
  TaskCausesAction      : Triggers Task Action
  ObsCausesDecision     : Triggers Observation Decision
  ObsCausesFix          : Triggers Observation Fix
  CauseCausesFix        : Triggers Cause Fix
  QuestionCausesClarification : Triggers Question Clarification


||| Resolution dynamics: what resolves / satisfies / fixes what.
public export
data Resolves : (solution, problem : OType) -> Type where

  FixResolvesError      : Resolves Fix Error
  DecisionResolvesQuestion : Resolves Decision Question
  ResultResolvesTask    : Resolves Result Task
  ActionResolvesGoal    : Resolves Action Goal
  PatchResolvesError    : Resolves Patch Error
  InfraFixResolvesError : Resolves InfraFix Error
  ClarificationResolves : Resolves Clarification Question
  SkillResolvesTask     : Resolves Skill Task
