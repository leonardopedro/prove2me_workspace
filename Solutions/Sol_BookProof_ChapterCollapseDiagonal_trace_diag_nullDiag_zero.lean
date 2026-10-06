-- Generated from ChapterCollapseDiagonal.lean — solution of BookProof.ChapterCollapseDiagonal.trace_diag_nullDiag_zero
import Mathlib
import Definitions.Def_ChapterCollapseDiagonal
import Theorems.Thm_BookProof_ChapterCollapseDiagonal_trace_diagonal_mul
open BookProof.ChapterCollapseDiagonal



open scoped BigOperators
open Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (ρ O : Matrix (Fin n) (Fin n) ℂ)
    (hρ : IsDiagonal ρ) (hO : ∀ i, O i i = 0) :
    (ρ * O).trace = 0 := by

  rw [trace_diagonal_mul ρ O hρ]
  refine Finset.sum_eq_zero (fun i _ => ?_)
  rw [hO i, mul_zero]
