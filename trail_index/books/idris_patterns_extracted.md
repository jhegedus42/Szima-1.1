# Idris 2 Programming Patterns — ConceptNotes

## dpair-syntax

- **Concept**: Dependent Pair (Sigma Type) Syntax
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: Dependent pairs allow the type of the second element to depend on the value of the first. Sugar syntax uses `(x : a ** p)` for the type and `(x ** p)` for constructing values.
- **Signature**: `data DPair : (a : Type) -> (p : a -> Type) -> Type`
- **Code**:
  ```idris
  vec : (n : Nat ** Vect n Int)
  vec = (2 ** [3, 4])

  vec' : DPair Nat (\n => Vect n Int)
  vec' = MkDPair 2 [3, 4]

  -- inferring the first element
  vec'' : (n ** Vect n Int)
  vec'' = (_ ** [3, 4])
  ```
- **Related**: [record-dpair](#record-dpair), [with-rule](#with-rule)
- **Causes**: Enables return of dependent types where the index is not known statically (e.g. `filter` on `Vect`)
- **CausedBy**: first-class types
- **Resolves**: The need to existentially quantify a type index when the index value is computed at runtime
- **Tags**: [dependent-pair, sigma-type, DPair]

## auto-implicit

- **Concept**: Auto Implicit Arguments
- **Source**: miscellany.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: Arguments marked with `{auto p : T}` are filled automatically by Idris via proof search, searching local variables, constructors, and `%hint`-annotated functions.
- **Signature**: `head : (xs : List a) -> {auto p : isCons xs = True} -> a`
- **Code**:
  ```idris
  isCons : List a -> Bool
  isCons [] = False
  isCons (x :: xs) = True

  head : (xs : List a) -> {auto p : isCons xs = True} -> a
  head (x :: xs) = x
  ```
- **Related**: [default-implicit](#default-implicit), [hint-pragma](#hint-pragma)
- **Causes**: Enables automatic proof construction, powers interface resolution internally
- **CausedBy**: implicit arguments
- **Resolves**: The need to manually pass obvious proofs or instances
- **Tags**: [auto, implicit, proof-search]

## so-type

- **Concept**: `So` type for compile-time boolean proofs
- **Source**: Idris_Tutorial_v1.3.4.md
- **Type**: Definition
- **IdrisVersion**: 1
- **Summary**: `So` is a type that is inhabited when a `Bool` expression is `True`. Used to enforce compile-time boolean conditions, e.g. on constructor arguments.
- **Signature**: `data So : Bool -> Type where Oh : So True`
- **Code**:
  ```idris
  data Interval : Type where
    MkInterval : (lower : Double) -> (upper : Double) ->
                 So (lower < upper) -> Interval
  ```
- **Related**: [auto-implicit](#auto-implicit)
- **Causes**: Enables static guarantees about boolean conditions
- **CausedBy**: dependent types
- **Resolves**: The need for runtime checks when the condition can be proved statically
- **Tags**: [So, boolean-proof, compile-time]

## public-export

- **Concept**: Export Visibility Modifiers
- **Source**: modules.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: Idris provides three visibility levels: `private` (default, not exported), `export` (type exported), and `public export` (full definition exported). Definitions cannot refer to names at a lower visibility level.
- **Code**:
  ```idris
  module BTree

  public export
  data BTree a = Leaf | Node (BTree a) a (BTree a)

  export
  insert : Ord a => a -> BTree a -> BTree a
  insert x Leaf = Node Leaf x Leaf
  insert x (Node l v r) = if (x < v) then (Node (insert x l) v r)
                                     else (Node l v (insert x r))
  ```
- **Related**: [module-system](#module-system), [namespace-explicit](#namespace-explicit)
- **Causes**: `public export` makes a function's definition part of the API (used at compile time); `export` only exposes the type (runtime access)
- **CausedBy**: module system, need for compile-time reduction
- **Resolves**: Fine-grained control over what parts of a module are visible
- **Tags**: [visibility, export, public-export, modules]

## multiplicities

- **Concept**: Quantitative Type Theory Multiplicities
- **Source**: multiplicities.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: Every variable in Idris 2 has a quantity: `0` (erased at runtime), `1` (used exactly once, linear), or unrestricted (default). Implicitly bound names are erased by default.
- **Signature**: `f : (0 n : Nat) -> Vect n a -> Nat` (erased); `g : (1 x : a) -> (a, a)` (linear)
- **Code**:
  ```idris
  -- erased argument (compile time only)
  ignoreN : (0 n : Nat) -> Vect n a -> Nat

  -- linear argument (used exactly once)
  duplicate : (1 x : a) -> (a, a)
  -- this fails with: There are 2 uses of linear name x

  -- unrestricted (default)
  vlen : {n : Nat} -> Vect n a -> Nat
  vlen xs = n
  ```
- **Related**: [linear-resource-protocol](#linear-resource-protocol), [erasure-pattern-matching](#erasure-pattern-matching)
- **Causes**: Enables precise tracking of runtime relevance; enables linear resource protocols; enables erasure guarantees
- **CausedBy**: Quantitative Type Theory (QTT)
- **Resolves**: The lack of precise distinction between compile-time-only and runtime-relevant values; enables resource protocol verification
- **Tags**: [multiplicity, erasure, linear, QTT, quantity]

## linear-resource-protocol

- **Concept**: Linear Resource Protocols
- **Source**: multiplicities.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: Use `1` multiplicity to encode resource usage protocols — state transitions on a unique resource without needing IO. The type system ensures resources are used exactly once and in the correct order.
- **Signature**:
  ```idris
  openDoor : (1 d : Door Closed) -> Door Open
  closeDoor : (1 d : Door Open) -> Door Closed
  deleteDoor : (1 d : Door Closed) -> IO ()
  ```
- **Code**:
  ```idris
  data DoorState = Open | Closed
  data Door : DoorState -> Type where
    MkDoor : (doorId : Int) -> Door st

  doorProg : IO ()
  doorProg = newDoor $ \d =>
    let d' = openDoor d
        d'' = closeDoor d' in
        deleteDoor d''
  ```
- **Related**: [multiplicities](#multiplicities), [io-with-world](#io-with-world)
- **Causes**: Enables type-safe state machines for external resources without monadic encapsulation
- **CausedBy**: linear types (multiplicity `1`)
- **Resolves**: The need to enforce ordering and single-use for resource operations without IO
- **Tags**: [linear, resource-protocol, state-machine]

## erasure-pattern-matching

- **Concept**: Pattern Matching on Erased Arguments
- **Source**: multiplicities.rst
- **Type**: Pitfall
- **IdrisVersion**: 2
- **Summary**: It is an error to pattern match on an argument with multiplicity `0` unless its value is inferrable from another argument's type. Pattern matching on erased types is allowed when the index is uniquely determined.
- **Code**:
  ```idris
  -- ERROR: cannot match on erased argument
  badNot : (0 x : Bool) -> Bool
  badNot False = True
  badNot True = False

  -- OK: value inferrable from SBool x
  data SBool : Bool -> Type where
    SFalse : SBool False
    STrue  : SBool True

  sNot : (0 x : Bool) -> SBool x -> Bool
  sNot False SFalse = True
  sNot True  STrue  = False
  ```
- **Related**: [multiplicities](#multiplicities)
- **Causes**: Prevents runtime-relevant computation on erased values
- **CausedBy**: QTT erasure guarantees
- **Resolves**: Ensures that erased values cannot affect runtime behavior
- **Tags**: [erasure, pattern-matching, pitfall]

## mutual-blocks

- **Concept**: Mutual Recursive Definitions
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: A `mutual` block allows data types and functions to be defined simultaneously. Idris first processes all type signatures, then all definitions. Forward declarations give finer control.
- **Code**:
  ```idris
  mutual
    even : Nat -> Bool
    even Z = True
    even (S k) = odd k

    odd : Nat -> Bool
    odd Z = False
    odd (S k) = even k

  -- forward declaration pattern
  data Even : Nat -> Type
  data Odd  : Nat -> Type

  data Even : Nat -> Type where
    ZIsEven : Even Z
    SOddIsEven : Odd n -> Even (S n)

  data Odd : Nat -> Type where
    SEvenIsOdd : Even n -> Odd (S n)
  ```
- **Related**: [totality](#totality)
- **Causes**: Enables mutually recursive functions and dependent types that reference each other
- **CausedBy**: define-before-use rule
- **Resolves**: The need to define interdependent types and functions
- **Tags**: [mutual, recursion, forward-declaration]

## record-syntax

- **Concept**: Record Syntax
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: Records are defined with `record Name where constructor MkName` followed by fields. Field access uses dot notation (`record.field`). Update uses `{ field := val }` or `{ field $= fn }`. Projections generate both prefix and dotted forms.
- **Code**:
  ```idris
  record Person where
    constructor MkPerson
    firstName, middleName, lastName : String
    age : Int

  fred : Person
  fred = MkPerson "Fred" "Joe" "Bloggs" 30

  -- access
  fred.firstName

  -- update (returns new record)
  { firstName := "Jim" } fred
  { age $= (+ 1) } fred
  ```
- **Related**: [dependent-records](#dependent-records), [nested-record-update](#nested-record-update)
- **Causes**: Auto-generates field accessors and updaters; each record lives in its own namespace
- **CausedBy**: need for structured data with named fields
- **Resolves**: Boilerplate of writing accessor and update functions
- **Tags**: [record, field, projection, update]

## dependent-records

- **Concept**: Dependent (Parameterized) Records
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: Records can have parameters that appear as arguments to the record type. These parameters cannot be updated independently. Updates can change dependent fields as long as all related fields are updated together.
- **Code**:
  ```idris
  record SizedClass (size : Nat) where
    constructor SizedClassInfo
    students : Vect size Person
    className : String

  addStudent : Person -> SizedClass n -> SizedClass (S n)
  addStudent p c = { students := p :: students c } c

  -- DPair is defined as a dependent record
  record DPair a (p : a -> Type) where
    constructor MkDPair
    fst : a
    snd : p fst
  ```
- **Related**: [record-syntax](#record-syntax), [dpair-syntax](#dpair-syntax)
- **Causes**: Enables type-level dependencies in record fields that change when fields are updated
- **CausedBy**: first-class dependent types
- **Resolves**: The need to track invariants across record fields at the type level
- **Tags**: [dependent-record, parameterized-record]

## data-indexed-families

- **Concept**: Indexed Data Type Families
- **Source**: typesfuns.rst
- **Type**: Definition
- **IdrisVersion**: 2
- **Summary**: Data type declarations can specify the full type of the type constructor, where type indices (like `Nat` for `Vect`) are distinguished from parameters (like `Type`). Constructors target specific index values.
- **Signature**: `data Vect : Nat -> Type -> Type where`
- **Code**:
  ```idris
  data Vect : Nat -> Type -> Type where
    Nil  : Vect Z a
    (::) : a -> Vect k a -> Vect (S k) a

  (++) : Vect n a -> Vect m a -> Vect (n + m) a
  (++) Nil       ys = ys
  (++) (x :: xs) ys = x :: xs ++ ys
  ```
- **Related**: [fin-type](#fin-type), [dependent-types-first-class](#dependent-types-first-class)
- **Causes**: Enables type-level computation on indices, giving precise length tracking
- **CausedBy**: dependent types
- **Resolves**: The need to track structural properties (like length) at the type level
- **Tags**: [indexed-family, Vect, dependent-type]

## fin-type

- **Concept**: Finite Sets (`Fin n`) for Safe Indexing
- **Source**: typesfuns.rst
- **Type**: Definition
- **IdrisVersion**: 2
- **Summary**: `Fin n` represents integers in `[0, n-1]`, used for bounds-safe vector indexing. The type guarantees the index is within range at compile time, eliminating runtime bounds checks.
- **Signature**: `data Fin : Nat -> Type where FZ : Fin (S k); FS : Fin k -> Fin (S k)`
- **Code**:
  ```idris
  index : Fin n -> Vect n a -> a
  index FZ     (x :: xs) = x
  index (FS k) (x :: xs) = index k xs
  -- No Nil case: Fin Z is uninhabited
  ```
- **Related**: [data-indexed-families](#data-indexed-families), [implicit-arguments](#implicit-arguments)
- **Causes**: Enables safe total vector lookup without runtime bounds checks
- **CausedBy**: indexed data types
- **Resolves**: Runtime index-out-of-bounds errors by making bounds a type-level constraint
- **Tags**: [Fin, safe-indexing, bounds-check]

## with-rule

- **Concept**: The `with` Rule — Dependent Pattern Matching on Intermediate Values
- **Source**: views.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: The `with` rule allows pattern matching on the result of an intermediate computation, refining other arguments' types based on the match. Essential for dependent pattern matching where a computation's result reveals information about other values.
- **Code**:
  ```idris
  -- basic usage
  filter : (a -> Bool) -> Vect n a -> (p ** Vect p a)
  filter p [] = ( _ ** [] )
  filter p (x :: xs) with (filter p xs)
    _ | ( _ ** xs' ) = if (p x) then ( _ ** x :: xs' ) else ( _ ** xs' )

  -- dependent pattern matching with refinement
  data Parity : Nat -> Type where
    Even : {n : _} -> Parity (n + n)
    Odd  : {n : _} -> Parity (S (n + n))

  natToBin : Nat -> List Bool
  natToBin Z = Nil
  natToBin k with (parity k)
    natToBin (j + j)     | Even = False :: natToBin j
    natToBin (S (j + j)) | Odd  = True  :: natToBin j
  ```
- **Related**: [with-pattern-skip](#with-pattern-skip), [with-proof](#with-proof)
- **Causes**: Enables dependent case analysis that refines other arguments' types
- **CausedBy**: dependent types where values appear in types
- **Resolves**: The need to match on intermediate computations and have the match refine type indices
- **Tags**: [with-rule, dependent-pattern-matching, views]

## rewrite

- **Concept**: Equality Proof Rewriting
- **Source**: theorems.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: The `rewrite` syntax applies an equality proof to change the required type of an expression. Used to reconcile types that are provably equal but not definitionally equal.
- **Signature**: `rewrite {equality-proof} in {expression}`
- **Code**:
  ```idris
  plusSuccRightSucc : (left : Nat) -> (right : Nat) ->
    S (left + right) = left + S right

  helpEven : (j : Nat) -> Parity (S j + S j) -> Parity (S (S (plus j j)))
  helpEven j p = rewrite plusSuccRightSucc j j in p

  plusReducesZ : (n:Nat) -> n = plus n Z
  plusReducesZ Z = Refl
  plusReducesZ (S k) = cong S (plusReducesZ k)
  ```
- **Related**: [equality-type](#equality-type), [provisional-definitions](#provisional-definitions)
- **Causes**: Allows the type checker to accept terms whose types are provably equal but not syntactically identical
- **CausedBy**: definitional equality being weaker than propositional equality for recursive functions
- **Resolves**: Type mismatches that arise from non-normalizing function definitions
- **Tags**: [rewrite, equality, theorem-proving]

## interface-definition

- **Concept**: Interface (Type Class) Definition and Implementation
- **Source**: interfaces.rst
- **Type**: Definition
- **IdrisVersion**: 2
- **Summary**: Interfaces define overloadable functions (methods). Implementations are given separately per type. Only one implementation per type. Constraints are written with `=>`. Interfaces can extend other interfaces.
- **Code**:
  ```idris
  interface Eq a where
    (==) : a -> a -> Bool
    (/=) : a -> a -> Bool

    x /= y = not (x == y)
    x == y = not (x /= y)

  Eq Nat where
    Z     == Z     = True
    (S x) == (S y) = x == y
    Z     == (S y) = False
    (S x) == Z     = False

  interface Eq a => Ord a where
    compare : a -> a -> Ordering
  ```
- **Related**: [named-implementations](#named-implementations), [determining-parameters](#determining-parameters)
- **Causes**: Enables ad-hoc polymorphism; powers operator overloading and generic programming
- **CausedBy**: need for type-directed overloading
- **Resolves**: The need to define operations that work across many types
- **Tags**: [interface, type-class, overloading]

## where-clauses

- **Concept**: Local Definitions with `where`
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: Functions and data types can be defined locally inside a function body using a `where` clause. Names from the outer scope are visible inside. Indentation is significant.
- **Code**:
  ```idris
  reverse : List a -> List a
  reverse xs = revAcc [] xs where
    revAcc : List a -> List a -> List a
    revAcc acc [] = acc
    revAcc acc (x :: xs) = revAcc (x :: acc) xs

  foo : Int -> Int
  foo x = case isLT of
              Yes => x*2
              No => x*4
      where
        data MyLT = Yes | No
        isLT : MyLT
        isLT = if x < 20 then Yes else No
  ```
- **Related**: [let-bindings](#let-bindings)
- **Causes**: Encapsulates helper definitions within the scope where they are used
- **CausedBy**: need for local scope
- **Resolves**: Namespace pollution from helper functions only needed in one place
- **Tags**: [where, local-definition]

## let-bindings

- **Concept**: `let` Bindings for Local Expressions
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `let` bindings introduce local expression aliases, support pattern matching, and can be type-annotated. The `:=` syntax avoids ambiguity with propositional equality.
- **Code**:
  ```idris
  mirror : List a -> List a
  mirror xs = let xs' = reverse xs in
                  xs ++ xs'

  showPerson : Person -> String
  showPerson p = let MkPerson name age = p in
                     name ++ " is " ++ show age ++ " years old"

  -- with type annotation
  mirror' : List a -> List a
  mirror' xs = let xs' : List a = reverse xs in
                   xs ++ xs'

  -- using := to avoid equality ambiguity
  Diag : a -> Type
  Diag v = let ty : Type := v = v in ty
  ```
- **Related**: [where-clauses](#where-clauses)
- **Causes**: Introduces intermediate named values in expressions
- **CausedBy**: need for intermediate values in pure expressions
- **Resolves**: Avoiding repetition and enabling pattern matching on intermediate results
- **Tags**: [let, local-binding, pattern-matching]

## case-expressions

- **Concept**: `case` Expressions for Pattern Matching
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `case` expressions allow pattern matching on intermediate values. The result type must be known without type-checking the case expression itself.
- **Code**:
  ```idris
  splitAt : Char -> String -> (String, String)
  splitAt c x = case break (== c) x of
    (l, r) => (l, strTail r)

  lookup_default : Nat -> List a -> a -> a
  lookup_default i xs def = case list_lookup i xs of
    Nothing => def
    Just x => x
  ```
- **Related**: [with-rule](#with-rule), [pattern-matching-bind](#pattern-matching-bind)
- **Causes**: Enables branching on intermediate values without defining a separate function
- **CausedBy**: need for inline pattern matching
- **Resolves**: Avoiding auxiliary functions for simple case analysis
- **Tags**: [case, pattern-matching]

## totality

- **Concept**: Totality Checking
- **Source**: theorems.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: A total function terminates for all inputs or produces a finite prefix of an infinite result. The `total` keyword enforces totality checking at compile time. Only total functions are evaluated during type checking.
- **Code**:
  ```idris
  total
  plus : Nat -> Nat -> Nat
  plus Z     y = y
  plus (S k) y = S (plus k y)

  -- partial annotation overrides default
  partial
  fromMaybe : Maybe a -> a
  fromMaybe (Just x) = x

  -- %default total makes all subsequent functions required total
  %default total

  -- overriding a total requirement
  %default partial
  ```
- **Related**: [totality-hints](#totality-hints), [covering](#covering)
- **Causes**: Guarantees that functions are safe to evaluate during type checking; prevents infinite loops in proofs
- **CausedBy**: need for decidable type checking with first-class types
- **Resolves**: Ensures type checking terminates by only evaluating total functions
- **Tags**: [total, partial, totality-checking, termination]

## name-rules

- **Concept**: Naming and Implicit Binding Rules
- **Source**: typesfuns.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: Lowercase names appearing as parameters/indexes in type signatures are automatically bound as implicit arguments. Data type names cannot begin with lowercase letters. Module names must start with uppercase. Underscores in module paths use dots.
- **Code**:
  ```idris
  -- `n` and `a` are automatically implicit
  index : Fin n -> Vect n a -> a

  -- equivalent to:
  index : {a : Type} -> {n : Nat} -> Fin n -> Vect n a -> a

  -- explicit forall
  index' : forall a, n . Fin n -> Vect n a -> a

  -- explicit naming
  index'' : (i : Fin n) -> (xs : Vect n a) -> a
  ```
- **Related**: [implicit-arguments](#implicit-arguments)
- **Causes**: Reduces syntactic overhead; lowercase automatically becomes an implicit binder
- **CausedBy**: design decision for ergonomic dependent types
- **Resolves**: The verbosity of writing all implicit binder declarations
- **Tags**: [naming, implicits, lowercase]

## implicit-arguments

- **Concept**: Explicit Implicit Arguments with `{ }`
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: Implicit arguments are written in braces `{ }` in type signatures and can be provided explicitly with `{name=value}` syntax in applications. Pattern matching on implicit arguments uses `{var = pat}`.
- **Code**:
  ```idris
  -- providing implicits explicitly
  index {a=Int} {n=2} FZ (2 :: 3 :: Nil)

  -- pattern matching on implicits
  isEmpty : Vect n a -> Bool
  isEmpty {n = Z}   _ = True
  isEmpty {n = S k} _ = False

  -- explicit implicit in type signature
  index : {a : Type} -> {n : Nat} -> Fin n -> Vect n a -> a
  ```
- **Related**: [name-rules](#name-rules), [auto-implicit](#auto-implicit)
- **Causes**: Allows omitting inferrable arguments while retaining the ability to specify them explicitly when needed
- **CausedBy**: dependent types with many inferrable parameters
- **Resolves**: Cluttering function calls with arguments the type checker can infer
- **Tags**: [implicit, explicit-implicit]

## default-implicit

- **Concept**: Default Implicit Arguments
- **Source**: miscellany.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: The `{default val name : Type}` syntax provides a default value for an implicit argument when auto search fails.
- **Code**:
  ```idris
  fibonacci : {default 0 lag : Nat} -> {default 1 lead : Nat} -> (n : Nat) -> Nat
  fibonacci {lag} Z = lag
  fibonacci {lag} {lead} (S n) = fibonacci {lag=lead} {lead=lag+lead} n
  ```
- **Related**: [auto-implicit](#auto-implicit)
- **Causes**: Provides fallback values for implicit arguments
- **CausedBy**: need for sensible defaults in proof search
- **Resolves**: Cases where `auto` cannot find a proof but a default is acceptable
- **Tags**: [default, implicit]

## equality-type

- **Concept**: Propositional Equality Type
- **Source**: theorems.rst
- **Type**: Definition
- **IdrisVersion**: 2
- **Summary**: `Equal` (written `=`) is a type with single constructor `Refl : x = x`. Proving equality requires demonstrating that two values are (definitionally or via rewriting) the same.
- **Signature**: `data Equal : a -> b -> Type where Refl : Equal x x`
- **Code**:
  ```idris
  fiveIsFive : 5 = 5
  fiveIsFive = Refl

  twoPlusTwo : 2 + 2 = 4
  twoPlusTwo = Refl
  ```
- **Related**: [rewrite](#rewrite), [empty-type](#empty-type)
- **Causes**: Enables theorem proving within the language
- **CausedBy**: Curry-Howard correspondence
- **Resolves**: The need to state and prove properties of programs
- **Tags**: [equality, Refl, theorem-proving]

## empty-type

- **Concept**: Empty Type `Void` for Impossible Proofs
- **Source**: theorems.rst
- **Type**: Definition
- **IdrisVersion**: 2
- **Summary**: `Void` has no constructors. A function returning `Void` proves that a situation is impossible. `void : Void -> a` enables proof by contradiction.
- **Code**:
  ```idris
  disjoint : (n : Nat) -> Z = S n -> Void
  disjoint n prf = replace {p = disjointTy} prf ()
    where
      disjointTy : Nat -> Type
      disjointTy Z = ()
      disjointTy (S k) = Void
  ```
- **Related**: [equality-type](#equality-type)
- **Causes**: Enables proving negative statements (something cannot happen)
- **CausedBy**: Curry-Howard correspondence
- **Resolves**: Proving impossibility
- **Tags**: [Void, empty-type, contradiction]

## named-implementations

- **Concept**: Named Interface Implementations
- **Source**: interfaces.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: Implementations can be named with `[name]` syntax to have multiple implementations for the same type. Use `@{name}` to select a specific implementation.
- **Code**:
  ```idris
  [myord] Ord Nat where
    compare Z (S n)     = GT
    compare (S n) Z     = LT
    compare Z Z         = EQ
    compare (S x) (S y) = compare @{myord} x y

  testList : List Nat
  testList = [3,4,1]
  -- default sort
  -- sort testList
  -- named implementation
  -- sort @{myord} testList
  ```
- **Related**: [interface-definition](#interface-definition), [using-parent](#using-parent)
- **Causes**: Enables multiple implementations of the same interface for the same type
- **CausedBy**: limitation of single-implementation constraint
- **Resolves**: The need for alternative orderings, serializations, etc. for the same type
- **Tags**: [named-implementation, multi-implementation]

## determining-parameters

- **Concept**: Determining Parameters (Functional Dependencies)
- **Source**: interfaces.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: The `| param` syntax after an interface declaration specifies which parameter determines implementation resolution. Other parameters are inferred from the implementation.
- **Signature**: `interface Monad m => MonadState s (0 m : Type -> Type) | m where`
- **Code**:
  ```idris
  interface Monad m => MonadState s (0 m : Type -> Type) | m where
    get : m s
    put : s -> m ()
  ```
- **Related**: [interface-definition](#interface-definition)
- **Causes**: Helps the type checker find implementations when only some parameters are known
- **CausedBy**: multi-parameter interfaces
- **Resolves**: Ambiguity in interface resolution for multi-parameter type classes
- **Tags**: [determining-parameter, functional-dependency]

## do-notation

- **Concept**: `do`-notation for Monadic Sequencing
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `do`-notation sequences monadic computations. `x <- e` binds the result, `e; e'` sequences, `let x = v` introduces local bindings. Desugars to `>>=` and `>>`.
- **Code**:
  ```idris
  greet : IO ()
  greet = do putStr "What is your name? "
             name <- getLine
             putStrLn ("Hello " ++ name)

  m_add : Maybe Int -> Maybe Int -> Maybe Int
  m_add x y = do x' <- x
                 y' <- y
                 pure (x' + y')
  ```
- **Related**: [bang-notation](#bang-notation), [pattern-matching-bind](#pattern-matching-bind), [idiom-brackets](#idiom-brackets)
- **Causes**: Provides imperative-style syntax for monadic programming
- **CausedBy**: monadic interface
- **Resolves**: Deep nesting of `>>=` calls
- **Tags**: [do-notation, monad]

## pattern-matching-bind

- **Concept**: Pattern Matching Bind in `do`-notation with Alternatives
- **Source**: interfaces.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: In `do`-notation, you can pattern match directly on the result: `Just x <- expr | Nothing => fallback`. The part after `|` handles non-matching cases.
- **Code**:
  ```idris
  readNumbers : IO (Maybe (Nat, Nat))
  readNumbers = do Just x_ok <- readNumber
                         | Nothing => pure Nothing
                   Just y_ok <- readNumber
                         | Nothing => pure Nothing
                   pure (Just (x_ok, y_ok))
  ```
- **Related**: [do-notation](#do-notation)
- **Causes**: Combines binding and pattern matching in one step
- **CausedBy**: monadic programming pattern where failure cases are boilerplate
- **Resolves**: Deep nested `case` expressions in monadic code
- **Tags**: [pattern-matching, do-notation, bind]

## bang-notation

- **Concept**: `!`-notation for Implicit Monadic Binding
- **Source**: interfaces.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `!expr` automatically lifts `expr` out of the current monadic context, binds it to a fresh name, and replaces the `!expr` with that name. Expressions are lifted depth-first, left to right.
- **Code**:
  ```idris
  m_add : Maybe Int -> Maybe Int -> Maybe Int
  m_add x y = pure (!x + !y)
  -- desugars to: do x' <- x; y' <- y; pure (x' + y')

  -- deeper example
  -- let y = 94 in f !(g !(print y) !x)
  -- desugars to:
  -- let y = 94 in do y' <- print y
  --                  x' <- x
  --                  g' <- g y' x'
  --                  f g'
  ```
- **Related**: [do-notation](#do-notation)
- **Causes**: Reduces syntactic overhead of monadic binds
- **CausedBy**: monadic code with many single-use binds
- **Resolves**: Verbosity of `do`-notation when values are used once
- **Tags**: [bang-notation, monad, syntactic-sugar]

## idiom-brackets

- **Concept**: Idiom Brackets `[| f a1 … an |]`
- **Source**: interfaces.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `[| f a1 ... an |]` desugars to `pure f <*> a1 <*> ... <*> an`. Provides applicative-style notation for effectful function application.
- **Code**:
  ```idris
  m_add' : Maybe Int -> Maybe Int -> Maybe Int
  m_add' x y = [| x + y |]
  -- desugars to: pure (+) <*> x <*> y
  ```
- **Related**: [do-notation](#do-notation), [bang-notation](#bang-notation)
- **Causes**: Enables applicative-style programming with less syntactic noise
- **CausedBy**: `Applicative` interface
- **Resolves**: Verbosity of repeated `<*>` applications
- **Tags**: [idiom-brackets, applicative]

## lazy-type

- **Concept**: `Lazy` Type for Suspended Evaluation
- **Source**: typesfuns.rst
- **Type**: Definition
- **IdrisVersion**: 2
- **Summary**: `Lazy a` suspends evaluation. The type checker automatically inserts `Delay`/`Force` conversions. Used to implement short-circuiting operations like `ifThenElse`.
- **Code**:
  ```idris
  ifThenElse : Bool -> Lazy a -> Lazy a -> a
  ifThenElse True  t e = t
  ifThenElse False t e = e

  maybe : Lazy b -> Lazy (a -> b) -> Maybe a -> b
  ```
- **Related**: [codata-stream](#codata-stream)
- **Causes**: Allows selective evaluation without explicit thunking
- **CausedBy**: eager evaluation by default
- **Resolves**: Performance issues from evaluating unused branches
- **Tags**: [Lazy, lazy-evaluation, delay, force]

## codata-stream

- **Concept**: Infinite (Codata) Types with `Inf`
- **Source**: typesfuns.rst
- **Type**: Definition
- **IdrisVersion**: 2
- **Summary**: Infinite data structures use `Inf` to mark recursive positions as lazy. `Stream` is a standard codata type. Totality checking accepts productive corecursive definitions.
- **Code**:
  ```idris
  data Stream : Type -> Type where
    (::) : (e : a) -> Inf (Stream a) -> Stream a

  ones : Stream Nat
  ones = 1 :: ones
  ```
- **Related**: [lazy-type](#lazy-type), [totality](#totality)
- **Causes**: Enables infinite data structures with productivity guarantees
- **CausedBy**: strict positivity and termination requirements
- **Resolves**: Representing infinite sequences (e.g. input streams)
- **Tags**: [codata, Stream, Inf, corecursion]

## totality-hints

- **Concept**: Totality Hints with `assert_smaller` and `assert_total`
- **Source**: theorems.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `assert_smaller x y` asserts to the totality checker that `y` is structurally smaller than `x`. `assert_total` marks a subexpression as always total.
- **Code**:
  ```idris
  assert_smaller : a -> a -> a
  assert_smaller x y = y

  total
  qsort : Ord a => List a -> List a
  qsort [] = []
  qsort (x :: xs)
     = qsort (assert_smaller (x :: xs) (filter (< x) xs)) ++
       (x :: qsort (assert_smaller (x :: xs) (filter (>= x) xs)))
  ```
- **Related**: [totality](#totality)
- **Causes**: Allows the programmer to guide the totality checker when it cannot prove termination automatically
- **CausedBy**: conservative nature of the totality checker
- **Resolves**: False positives from the totality checker
- **Tags**: [assert_smaller, assert_total, totality]

## interface-constructor

- **Concept**: Interface Constructors
- **Source**: interfaces.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: Interfaces can have a user-defined constructor, allowing them to be used as first-class values passed inline with `@{MkB val}` syntax.
- **Code**:
  ```idris
  interface A t => B t where
    constructor MkB
    getB : t

  getAB : (t : B a) => (a, a)
  getAB = (getA, getB)

  -- usage without implementing B for Nat
  natAB = getAB { t = MkB (S Z) }
  ```
- **Related**: [interface-definition](#interface-definition)
- **Causes**: Enables creating ad-hoc interface implementations inline
- **CausedBy**: need for first-class interface dictionaries
- **Resolves**: The overhead of declaring a full implementation for one-off usage
- **Tags**: [interface-constructor, first-class]

## module-system

- **Concept**: Module System and Imports
- **Source**: modules.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: Modules are declared with `module Name`. Imports use `import Module`. Modules can re-export with `import public`. Renaming uses `import ... as Name`. File paths must match module names with dots as separators.
- **Code**:
  ```idris
  module Main

  import BTree
  import public Data.Vect  -- re-export Vect
  import Data.List as L    -- access via L. prefix

  main : IO ()
  main = do let t = toTree [1,8,2,7,9,3]
            print (BTree.toList t)
  ```
- **Related**: [public-export](#public-export), [namespace-explicit](#namespace-explicit)
- **Causes**: Organizes code into namespaces with controlled visibility
- **CausedBy**: need for modularity
- **Resolves**: Name collisions and API surface management
- **Tags**: [module, import, namespace]

## namespace-explicit

- **Concept**: Explicit Namespaces for Overloading
- **Source**: modules.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `namespace Name` blocks allow overloading names within the same module. Names are disambiguated by type. Export rules are per-namespace.
- **Code**:
  ```idris
  module Foo

  namespace X
    export
    test : Int -> Int
    test x = x * 2

  namespace Y
    export
    test : String -> String
    test x = x ++ x
  ```
- **Related**: [module-system](#module-system)
- **Causes**: Enables ad-hoc overloading within a single module
- **CausedBy**: need for multiple definitions with the same name
- **Resolves**: The need to create separate modules just for overloading
- **Tags**: [namespace, overloading]

## parameters-block

- **Concept**: `parameters` Block for Shared Parameters
- **Source**: modules.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `parameters (x : T) (y : U)` adds the declared parameters to every function, type, and data constructor within the block. Outside the block, parameters must be given explicitly.
- **Code**:
  ```idris
  parameters (x : Nat) (y : Nat)
    addAll : Nat -> Nat
    addAll z = x + y + z

  parameters (y : Nat) (xs : Vect x a)
    data Vects : Type -> Type where
      MkVects : Vect y a -> Vects a

    append : Vects a -> Vect (x + y) a
    append (MkVects ys) = xs ++ ys
  ```
- **Related**: [module-system](#module-system)
- **Causes**: Reduces repetition of common parameters across multiple definitions
- **CausedBy**: dependent types with pervasive index parameters
- **Resolves**: Boilerplate of passing the same parameters to every function in a group
- **Tags**: [parameters, parameterised-block]

## provisional-definitions

- **Concept**: Provisional Definitions (`?=`)
- **Source**: Idris_Tutorial_v1.3.4.md
- **Type**: Pattern
- **IdrisVersion**: 1
- **Summary**: `?=` defines a right-hand side that will be corrected by a proof later. Idris generates proof obligations (holes) for type mismatches. Useful during prototyping.
- **Code**:
  ```idris
  parity : (n:Nat) -> Parity n
  parity Z = Even {n=Z}
  parity (S Z) = Odd {n=Z}
  parity (S (S k)) with (parity k)
    parity (S (S (j + j))) | Even ?= Even {n=S j}
    parity (S (S (S (j + j)))) | Odd ?= Odd {n=S j}
  ```
- **Related**: [rewrite](#rewrite), [holes](#holes)
- **Causes**: Delays proof details during development
- **CausedBy**: type mismatches that require explicit theorem proving
- **Resolves**: Allowing testing of algorithms before full proofs are completed
- **Tags**: [provisional, ?=, prototyping]

## holes

- **Concept**: Holes (`?name`) for Incremental Development
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: A hole `?name` stands for an incomplete part of a program. Checking the hole's type reveals the expected type and all variables in scope. Enables incremental, type-directed development.
- **Code**:
  ```idris
  main : IO ()
  main = putStrLn ?greeting

  even : Nat -> Bool
  even Z = True
  even (S k) = ?even_rhs
  ```
- **Related**: [interactive-editing](#interactive-editing), [provisional-definitions](#provisional-definitions)
- **Causes**: Enables incremental development with type feedback
- **CausedBy**: complex dependent types that are hard to write in one pass
- **Resolves**: The difficulty of writing correct by construction code without seeing intermediate types
- **Tags**: [holes, interactive, development]

## interactive-editing

- **Concept**: Interactive Editing Commands
- **Source**: interactive.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: REPL commands for interactive development: `:addclause` (template definition), `:casesplit` (split pattern variables), `:addmissing` (add missing cases), `:proofsearch` (search for a term), `:makewith` (add with clause).
- **Code**:
  ```idris
  :addclause 94 vzipWith  -- creates: vzipWith f xs ys = ?vzipWith_rhs
  :casesplit 96 xs        -- splits xs into [] and x :: xs
  :addmissing 96 vzipWith -- adds missing covering clauses
  :proofsearch 96 hole    -- searches for a term
  :makewith 10 parity     -- adds: parity (S k) with (_)
  ```
- **Related**: [holes](#holes), [with-rule](#with-rule)
- **Causes**: Makes the type checker an active partner in program construction
- **CausedBy**: complexity of dependent pattern matching
- **Resolves**: The difficulty of manually writing correct dependent pattern matches
- **Tags**: [interactive, editing, REPL, casesplit]

## covering

- **Concept**: Covering (Exhaustive Pattern Matching)
- **Source**: typesfuns.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: By default, functions must be `covering` — patterns must cover all possible inputs. `partial` annotation overrides this, but risks runtime errors.
- **Code**:
  ```idris
  -- ERROR: not covering
  fromMaybe : Maybe a -> a
  fromMaybe (Just x) = x

  -- OK with partial annotation
  partial fromMaybe : Maybe a -> a
  fromMaybe (Just x) = x
  ```
- **Related**: [totality](#totality)
- **Causes**: Ensures functions handle all inputs
- **CausedBy**: need for type safety
- **Resolves**: Runtime crashes from unhandled cases
- **Tags**: [covering, partial, exhaustive]

## dependent-types-first-class

- **Concept**: First-Class Types (Type computation)
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: Types are first-class values that can be computed, passed to functions, and pattern-matched. Functions can compute types based on values.
- **Code**:
  ```idris
  isSingleton : Bool -> Type
  isSingleton True = Nat
  isSingleton False = List Nat

  mkSingle : (x : Bool) -> isSingleton x
  mkSingle True = 0
  mkSingle False = []

  -- pattern matching on types
  showType : Type -> String
  showType Int = "Int"
  showType (List a) = "List of " ++ showType a
  showType _ = "something else"
  ```
- **Related**: [data-indexed-families](#data-indexed-families)
- **Causes**: Enables type-level programming and generic programming
- **CausedBy**: dependent type theory
- **Resolves**: The need for type-level computation
- **Tags**: [first-class, type-computation, Type]

## anon-functions

- **Concept**: Anonymous Functions and Operator Sections
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: Anonymous functions use `\args => body`, support multiple arguments, explicit types, and pattern matching. Operator sections like `(*2)` expand to `\x => x * 2`.
- **Code**:
  ```idris
  map (\x => x * 2) intVec
  map (*2) intVec  -- operator section
  \(x, y) => x + y
  \x : Int => x * 2
  ```
- **Related**: [let-bindings](#let-bindings)
- **Causes**: Enables inline function definitions
- **CausedBy**: need for function values without naming
- **Resolves**: The overhead of naming every small function
- **Tags**: [lambda, anonymous-function, operator-section]

## with-pattern-skip

- **Concept**: Skipping Unchanged Patterns in `with`
- **Source**: views.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: When the argument pattern is unchanged in a `with` clause, use `_` to skip the redundant left-hand side. Multiple `with` clauses can be combined with `|`.
- **Code**:
  ```idris
  -- skipping unchanged pattern
  filter p (x :: xs) with (filter p xs)
    _ | ( _ ** xs' ) = if (p x) then ( _ ** x :: xs' ) else ( _ ** xs' )

  -- nested with skipping
  foo n m with (n + 1)
    _ | 2 with (m + 1)
      _ | 3 = True
      _ | _ = False
    _ | _ = False

  -- combined with
  foo' n m with (n + 1) | (m + 1)
    _ | 2 | 3 = True
    _ | _ | _ = False
  ```
- **Related**: [with-rule](#with-rule)
- **Causes**: Reduces redundancy in `with` clauses
- **CausedBy**: `with` rule syntax
- **Resolves**: Verbose repetition of unchanged patterns
- **Tags**: [with, pattern-skip]

## with-proof

- **Concept**: `with ... proof p` for Accessing Equality Proofs
- **Source**: Idris_Tutorial_v1.3.4.md
- **Type**: Pattern
- **IdrisVersion**: 1
- **Summary**: Adding `proof p` after a `with` clause brings the equality proof generated by the pattern match into scope with the name `p`.
- **Code**:
  ```idris
  isFInt : (foo:Foo) -> Maybe (x : Int ** (optional foo = Just x))
  isFInt foo with (optional foo) proof p
    isFInt foo | Nothing = Nothing
    -- p : Nothing = optional foo
    isFInt foo | (Just x) = Just (x ** Refl)
    -- p : Just x = optional foo
  ```
- **Related**: [with-rule](#with-rule), [equality-type](#equality-type)
- **Causes**: Enables access to the equality proof refined by dependent pattern matching
- **CausedBy**: need to use the pattern match evidence in the result
- **Resolves**: The need to reference the equality established by a dependent match
- **Tags**: [with, proof, equality]

## list-comprehensions

- **Concept**: List (Monad) Comprehensions
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `[exp | qualifiers]` generates lists via generators `x <- e`, guards (Bool expressions), and `let` bindings. Works for any `Monad` + `Alternative` type.
- **Code**:
  ```idris
  pythag : Int -> List (Int, Int, Int)
  pythag n = [ (x, y, z) | z <- [1..n], y <- [1..z], x <- [1..y],
                           x*x + y*y == z*z ]

  m_add : Maybe Int -> Maybe Int -> Maybe Int
  m_add x y = [ x' + y' | x' <- x, y' <- y ]
  ```
- **Related**: [do-notation](#do-notation)
- **Causes**: Provides concise syntax for building monadic computations
- **CausedBy**: monadic interface with Alternative
- **Resolves**: Verbose loops and filters
- **Tags**: [comprehension, list, monad]

## hint-pragma

- **Concept**: `%hint` and `%globalhint` Pragmas for Auto Search
- **Source**: interfaces.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: Functions marked `%hint` are used by the `auto` implicit search mechanism. `%globalhint` is always tried regardless of the goal type. Hints are tried when auto search needs to construct a value of the return type.
- **Related**: [auto-implicit](#auto-implicit)
- **Causes**: Extends the auto implicit search with user-defined functions
- **CausedBy**: need for custom proof search
- **Resolves**: Cases where auto search cannot find a proof using only constructors
- **Tags**: [hint, auto, search]

## ioref-linear

- **Concept**: Linear IO Implementation with `%World`
- **Source**: multiplicities.rst
- **Type**: Example
- **IdrisVersion**: 2
- **Summary**: Idris 2's `IO` uses linear types internally: `IORes` wraps a result and a linear `%World` token, ensuring world-passing is correctly sequenced.
- **Code**:
  ```idris
  public export
  data IORes : Type -> Type where
    MkIORes : (result : a) -> (1 x : %World) -> IORes a

  export
  data IO : Type -> Type where
    MkIO : (1 fn : (1 x : %World) -> IORes a) -> IO a
  ```
- **Related**: [linear-resource-protocol](#linear-resource-protocol), [multiplicities](#multiplicities)
- **Causes**: Provides type-safe sequencing of IO actions without requiring a state monad
- **CausedBy**: QTT linearity
- **Resolves**: The problem of ensuring world tokens are threaded correctly through IO actions
- **Tags**: [IO, %World, linear, implementation]

## multiplicity-polymorphism-not

- **Concept**: Implicitly-Bound Arguments Have `0` Multiplicity
- **Source**: multiplicities.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: Unbound implicit arguments (lowercase names in types) are erased by default (multiplicity `0`). To make a type argument runtime-relevant, it must be explicitly bound with unrestricted multiplicity.
- **Code**:
  ```idris
  -- These are equivalent: a is erased (0)
  duplicate : (1 x : a) -> (a, a)
  duplicate : {0 a : _} -> (1 x : a) -> (a, a)

  -- To make a available at runtime:
  notId : {a : Type} -> a -> a
  notId {a = Integer} x = x + 1
  notId x = x
  ```
- **Related**: [multiplicities](#multiplicities), [implicit-arguments](#implicit-arguments)
- **Causes**: Affects which types can be pattern matched on, and which must be passed at runtime
- **CausedBy**: QTT design where types are irrelevant by default
- **Resolves**: The need to distinguish parametric polymorphism from type-directed computation
- **Tags**: [erasure, implicit, multiplicity]

## syntax-extension

- **Concept**: User-Defined Syntax Extensions
- **Source**: Idris_Tutorial_v1.3.4.md
- **Type**: Pattern
- **IdrisVersion**: 1
- **Summary**: `syntax` declarations define custom syntax rules: keywords, `[nonterminals]`, `{names}`, and `"symbols"`. Can be restricted to patterns or terms separately. `dsl` notation overloads variable/index/lambda for EDSLs.
- **Code**:
  ```idris
  syntax if [test] then [t] else [e] = ifThenElse test t e

  syntax for {x} "in" [xs] ":" [body] = forLoop xs (\x => body)

  dsl expr
    variable = Var
    index_first = Stop
    index_next = Pop
    lambda = mkLam
  ```
- **Related**: [idiom-brackets](#idiom-brackets)
- **Causes**: Enables Embedded Domain-Specific Languages (EDSLs) with natural syntax
- **CausedBy**: need for custom language constructs
- **Resolves**: Verbosity of representing object languages directly with constructors
- **Tags**: [syntax, DSL, EDSL]

## pragma-deprecate

- **Concept**: `%deprecate`, `%inline`, `%hide` Pragmas
- **Source**: pragmas.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: Pragmas modify compiler behavior: `%deprecate` warns on usage, `%inline`/`%noinline` control inlining, `%hide` removes imported names, `%transform` replaces runtime implementation.
- **Code**:
  ```idris
  %deprecate
  foo : String -> String
  foo x = x ++ "!"

  %inline
  bar : String -> String
  bar x = x ++ "!"

  %hide Prelude.Nat
  %hide A.infixl.(-)
  ```
- **Related**: [public-export](#public-export)
- **Causes**: Provides fine-grained control over compilation
- **CausedBy**: need for compiler hints and deprecation management
- **Resolves**: Import conflicts and performance tuning
- **Tags**: [pragma, deprecate, inline, hide]

## operators-fixity

- **Concept**: Operator Fixity Declarations
- **Source**: operators.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: Fixity is declared separately from function definitions: `infixl` (left), `infixr` (right), `infix` (non-assoc), `prefix`. Precedence is a number. Private fixities prevent export. `typebind` and `autobind` modifiers enable special binding syntax.
- **Code**:
  ```idris
  infixl 8 +
  infixr 10 ::

  typebind infixr 0 =@
  0 (=@) : (x : Type) -> (x -> Type) -> Type
  (=@) x f = (1 v : x) -> f v
  -- usage: (x : Nat) =@ Singleton x

  autobind infixr 0 =>>
  (=>>) : Value -> (Value -> Value) -> Value
  -- usage: (x <- expr) =>> body
  ```
- **Related**: [namespace-explicit](#namespace-explicit)
- **Causes**: Enables custom infix operators with proper precedence and associativity
- **CausedBy**: need for syntactic extension through operators
- **Resolves**: The need for DSL-like syntax
- **Tags**: [operator, fixity, infix, typebind, autobind]

## record-dpair

- **Concept**: DPair as a Dependent Record
- **Source**: typesfuns.rst
- **Type**: Example
- **IdrisVersion**: 2
- **Summary**: In practice, `DPair` is defined as a record with projection fields `fst` and `snd`. Record update syntax works on dependent pairs when updating both fields together.
- **Code**:
  ```idris
  record DPair a (p : a -> Type) where
    constructor MkDPair
    fst : a
    snd : p fst

  cons : t -> (x : Nat ** Vect x t) -> (x : Nat ** Vect x t)
  cons val xs = { fst := S (fst xs), snd := (val :: snd xs) } xs

  cons' : t -> (x : Nat ** Vect x t) -> (x : Nat ** Vect x t)
  cons' val = { fst $= S, snd $= (val ::) }
  ```
- **Related**: [dpair-syntax](#dpair-syntax), [record-syntax](#record-syntax)
- **Causes**: Makes dependent pair values accessible via field projection
- **CausedBy**: record elaboration
- **Resolves**: The need to extract components from a dependent pair
- **Tags**: [DPair, record, projection]

## nested-record-update

- **Concept**: Nested Record Update with Dot Paths
- **Source**: typesfuns.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `{ a.b.c := val }` updates a nested field. `{ a.b.c $= fn }` applies a function to a nested field. The old arrow syntax `{ a->b->c := val }` is also supported for compatibility.
- **Code**:
  ```idris
  { topLeft.x := 3 } rect
  { topLeft.x $= (+1) } rect

  -- old syntax (compatible)
  { topLeft->x := 3 } rect
  ```
- **Related**: [record-syntax](#record-syntax)
- **Causes**: Provides concise nested record updates
- **CausedBy**: deeply nested record structures
- **Resolves**: Verbose nested record updates
- **Tags**: [nested, record-update, dot-notation]

## dot-projection-syntax

- **Concept**: Dot Projection Syntax for Records
- **Source**: records.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `.field` is a postfix projection operator. `expr.field` accesses a field. `(.field)` is a function. `%prefix_record_projections off` disables the prefix form. Lowercase chains are parsed as multiple projections; uppercase dots are namespace separators.
- **Code**:
  ```idris
  record Point where
    constructor MkPoint
    x : Double
    y : Double

  pt.x          -- postfix projection (desugars to (.x pt))
  map (.x) pts  -- function form
  pt.x.squared  -- chained: squared applied to pt.x

  %prefix_record_projections off
  record Rect where
    constructor MkRect
    topLeft : Point
    bottomRight : Point
  -- only .topLeft projection exists (no prefix topLeft)
  ```
- **Related**: [record-syntax](#record-syntax), [nested-record-update](#nested-record-update)
- **Causes**: Provides uniform field access syntax, avoiding name collisions
- **CausedBy**: need for record field access without namespace pollution
- **Resolves**: Namespace pollution from short field names
- **Tags**: [dot-notation, projection, record]

## cast-interface

- **Concept**: `Cast` Interface for Type Conversions
- **Source**: Idris_Tutorial_v1.3.4.md
- **Type**: Definition
- **IdrisVersion**: 1
- **Summary**: `Cast from to` is a multi-parameter interface with method `cast : from -> to`. Defined between all primitive types as appropriate.
- **Signature**: `interface Cast from to where cast : from -> to`
- **Related**: [interface-definition](#interface-definition)
- **Causes**: Enables overloaded conversion functions between types
- **CausedBy**: need for convenient type conversions
- **Resolves**: Writing explicit conversion functions everywhere
- **Tags**: [Cast, conversion]

## monad-comprehensions

- **Concept**: Monad Comprehensions with Alternative
- **Source**: interfaces.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: List comprehension notation works for any `Monad` + `Alternative` type. Guards use `guard : Alternative f => Bool -> f ()`. Comprehensions desugar to `do { ... ; pure exp }`.
- **Code**:
  ```idris
  m_add : Maybe Int -> Maybe Int -> Maybe Int
  m_add x y = [ x' + y' | x' <- x, y' <- y ]
  ```
- **Related**: [list-comprehensions](#list-comprehensions), [do-notation](#do-notation)
- **Causes**: Extends comprehension syntax to any monad
- **CausedBy**: Monad + Alternative interface combination
- **Resolves**: Verbose do-notation for simple monadic expressions
- **Tags**: [monad-comprehension, Alternative]

## qualified-do

- **Concept**: Qualified `do`-notation
- **Source**: interfaces.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `Prelude.do { ... }` specifies which module's `(>>=)` and `(>>)` to use for desugaring, resolving ambiguity.
- **Code**:
  ```idris
  m_add : Maybe Int -> Maybe Int -> Maybe Int
  m_add x y = Prelude.do
                x' <- x
                y' <- y
                pure (x' + y')
  ```
- **Related**: [do-notation](#do-notation), [module-system](#module-system)
- **Causes**: Resolves ambiguity when multiple monad implementations are in scope
- **CausedBy**: ad-hoc overloading of `>>=`
- **Resolves**: Ambiguous monadic desugaring
- **Tags**: [qualified-do, monad]

## natural-optimization

- **Concept**: `%builtin Natural` Optimization
- **Source**: builtins.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: Idris 2 optimizes Peano-style natural numbers to `Integer` at runtime. The data type must have exactly 2 constructors: one nullary, one with a single recursive argument. `%builtin Natural` asserts optimization for custom types.
- **Code**:
  ```idris
  data MyNat = Zero | Succ MyNat
  %builtin Natural MyNat

  -- O(1) cast via pattern matching convention:
  cast : MyNat -> Integer
  cast Z = 0
  cast (S k) = cast k + 1

  %transform "eqNat" eqNat j k = natToInteger j == natToInteger k
  ```
- **Related**: [data-indexed-families](#data-indexed-families)
- **Causes**: Gives Peano-style types the efficiency of machine integers
- **CausedBy**: need for both structural reasoning and performance
- **Resolves**: The performance gap between convenient inductive types and primitive types
- **Tags**: [Natural, builtin, optimization]

## universe-hierarchy

- **Concept**: Universe Hierarchy (Cumulativity)
- **Source**: miscellany.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: `Type : Type 1 : Type 2 : ...`  is a cumulative hierarchy preventing Girard's paradox. If `x : Type n` then `x : Type m` for `n < m`. The type checker manages universe constraints.
- **Code**:
  ```idris
  -- This fails due to universe inconsistency:
  myid : (a : Type) -> a -> a
  myid _ x = x

  idid : (a : Type) -> a -> a
  idid = myid _ myid
  ```
- **Related**: [dependent-types-first-class](#dependent-types-first-class)
- **Causes**: Prevents logical inconsistencies from Type-in-Type
- **CausedBy**: first-class types
- **Resolves**: Girard's paradox
- **Tags**: [universe, cumulativity, Type]

## literate-programming

- **Concept**: Literate Programming (`.lidr` files)
- **Source**: miscellany.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: Files with `.lidr` extension are literate. Lines starting with `>` are code; everything else is a comment. Blank lines must separate code from comments.
- **Code**:
  ```idris
  > module literate

  This is a comment. The main program is below

  > main : IO ()
  > main = putStrLn "Hello literate world!\n"
  ```
- **Related**: [module-system](#module-system)
- **Causes**: Enables documentation-oriented programming
- **CausedBy**: need for literate style
- **Resolves**: The separation of code and documentation
- **Tags**: [literate, lidr]

## implicit-conversions

- **Concept**: Implicit Conversions (`implicit` modifier)
- **Source**: Idris_Tutorial_v1.3.4.md
- **Type**: Pattern
- **IdrisVersion**: 1
- **Summary**: Functions marked `implicit` with one explicit argument automatically convert values when needed for type correctness. Only one conversion is applied at a time (no chaining). Discouraged for simple types.
- **Code**:
  ```idris
  implicit intString : Int -> String
  intString = show

  test : Int -> String
  test x = "Number " ++ x
  -- Int x is automatically converted to String via intString
  ```
- **Related**: [cast-interface](#cast-interface)
- **Causes**: Automatic type conversion in contexts where the conversion is unambiguous
- **CausedBy**: need for convenience in EDSLs
- **Resolves**: Verbose explicit conversions
- **Tags**: [implicit, conversion]

## believe-me

- **Concept**: `believe_me` for Unsafe Type Coercion
- **Source**: Idris_Tutorial_v1.3.4.md
- **Type**: Pitfall
- **IdrisVersion**: 1
- **Summary**: `believe_me : a -> b` is a built-in unsafe coercion that bypasses the type system. Use only during prototyping or for asserting properties of external code.
- **Related**: [provisional-definitions](#provisional-definitions)
- **Causes**: Allows bypassing the type checker for prototyping
- **CausedBy**: need for escape hatch during development
- **Resolves**: Temporarily deferring proof obligations
- **Tags**: [believe_me, unsafe, coercion]

## hasio

- **Concept**: `HasIO` Interface for Custom Interactive Types
- **Source**: interfaces.rst
- **Type**: Definition
- **IdrisVersion**: 2
- **Summary**: `HasIO io` provides `liftIO : (1 _ : IO a) -> io a` allowing custom monads to lift primitive IO operations.
- **Signature**: `interface Monad io => HasIO io where liftIO : (1 _ : IO a) -> io a`
- **Related**: [interface-definition](#interface-definition), [ioref-linear](#ioref-linear)
- **Causes**: Enables custom interactive types while retaining access to IO primitives
- **CausedBy**: need for abstraction over IO
- **Resolves**: Vendor lock-in to the IO type for effectful programming
- **Tags**: [HasIO, IO, monad]

## log-notation

- **Concept**: `%logging` and Other Debug Pragmas
- **Source**: pragmas.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: `%logging n` sets the logging level. `%logging "name" n` sets topic-specific logging. Other debug pragmas include `%search_timeout`, `%auto_implicit_depth`, `%totality_depth`.
- **Code**:
  ```idris
  %logging 1
  %logging "elab" 5
  %search_timeout 1000
  %auto_implicit_depth 50
  ```
- **Related**: [auto-implicit](#auto-implicit), [totality](#totality)
- **Causes**: Helps debug type checking and elaboration
- **CausedBy**: complex type checking behavior
- **Resolves**: Debugging type checking failures
- **Tags**: [logging, pragma, debug]

## name-hint

- **Concept**: `%name` for Name Generation Hints
- **Source**: pragmas.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `%name Type name1, name2, ...` tells Idris which names to prefer when generating variables of a given type during interactive editing.
- **Code**:
  ```idris
  %name Vect xs, ys, zs, ws
  ```
- **Related**: [interactive-editing](#interactive-editing)
- **Causes**: Produces more readable generated names
- **CausedBy**: automatic variable naming in case splits and proof search
- **Resolves**: Cryptic auto-generated variable names
- **Tags**: [name, hint, interactive]

## using-parent

- **Concept**: `using ParentImpl` in Named Implementations
- **Source**: interfaces.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: A named implementation can specify which parent named implementation it extends with `using ParentName`, ensuring the correct parent is used when multiple exist.
- **Code**:
  ```idris
  [PlusNatSemi] Semigroup Nat where
    (<+>) x y = x + y

  [MultNatSemi] Semigroup Nat where
    (<+>) x y = x * y

  [PlusNatMonoid] Monoid Nat using PlusNatSemi where
    neutral = 0

  [MultNatMonoid] Monoid Nat using MultNatSemi where
    neutral = 1
  ```
- **Related**: [named-implementations](#named-implementations), [interface-definition](#interface-definition)
- **Causes**: Ensures the correct parent implementation is extended
- **CausedBy**: multiple named implementations of parent interfaces
- **Resolves**: Ambiguity when multiple parent implementations exist
- **Tags**: [named-implementation, using, inheritance]

## interactive-at-repl

- **Concept**: REPL Commands for Type Checking and Evaluation
- **Source**: interactive.rst
- **Type**: Rule
- **IdrisVersion**: 2
- **Summary**: Key REPL commands: `:t expr` (type check), `:exec expr` (run IO), `:total name` (totality check), `:m` (list holes), `:c file` (compile). `:command!` updates source in-place.
- **Related**: [interactive-editing](#interactive-editing)
- **Causes**: Provides a development environment without leaving the REPL
- **CausedBy**: need for rapid feedback during development
- **Resolves**: Edit-compile-run cycle overhead
- **Tags**: [REPL, commands, interactive]

## reflexion

- **Concept**: Elab Reflection (`%language ElabReflection`, `%runElab`, `%macro`)
- **Source**: pragmas.rst
- **Type**: Pattern
- **IdrisVersion**: 2
- **Summary**: `%language ElabReflection` enables elaboration reflection. `%runElab script` runs an elaborator script. `%macro` marks a function for compile-time execution and replacement.
- **Code**:
  ```idris
  %language ElabReflection

  %macro
  fromTTImp : TTImp -> Elab NatExpr
  fromTTImp = natExpr
  ```
- **Related**: [macro-pragma](#macro-pragma)
- **Causes**: Enables compile-time metaprogramming
- **CausedBy**: need for custom elaboration
- **Resolves**: The limitation of user-defined syntax for code generation
- **Tags**: [ElabReflection, macro, metaprogramming]

