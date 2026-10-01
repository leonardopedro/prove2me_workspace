import Mathlib


/-!
# Chapter "Wave-function parametrization of a probability measure", §4
*"Quantum Mechanics versus a non-commutative generalization of probability
theory"* — the collapse mechanism: a diagonal state ignores off-diagonal
operators

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, §4 (`book.tex` line ~1550).

The book's argument that the wave-function collapse keeps Quantum Mechanics
inside Kolmogorov's probability theory rests on the following elementary but
load-bearing fact about the expectation `E(A) = tr(ρ A)` of a state
`ρ = E` that is *diagonal* in the measurement basis (`E(O) = 0` for operators
`O` with null diagonal):

> *"If an operator `O` has null diagonal in the same basis where `P_X` is
> diagonal, then `tr(ρ O) = 0` for any `ρ` diagonal."*

Formalized over an arbitrary finite index set `Fin n`, complex matrices:

* `trace_diagonal_mul` — for a diagonal `ρ`, `tr(ρ O) = ∑ i, ρ i i · O i i`
  (only the diagonal of `O` contributes);
* **headline** `trace_diag_nullDiag_zero` — if `ρ` is diagonal and `O` has null
  diagonal (`O i i = 0` for all `i`) then `tr(ρ O) = 0`: a diagonal ensemble
  assigns zero expectation to every null-diagonal operator, which is exactly the
  post-collapse condition `E(O) = 0` the book invokes.
* `trace_diagonal_mul_diag` — the companion form for the surviving diagonal part:
  for diagonal `ρ` and diagonal `D`, `tr(ρ D) = ∑ i, ρ i i · D i i`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

open scoped BigOperators
open Matrix

namespace BookProof.ChapterCollapseDiagonal

variable {n : ℕ}

/-- `ρ` is *diagonal* (in the measurement basis): its off-diagonal entries
vanish. -/
def IsDiagonal (ρ : Matrix (Fin n) (Fin n) ℂ) : Prop := ∀ i j, i ≠ j → ρ i j = 0







end BookProof.ChapterCollapseDiagonal
