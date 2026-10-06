-- Generated from ChapterCollapseDiagonal.lean — solution of BookProof.ChapterCollapseDiagonal.trace_diagonal_mul
import Mathlib
import Definitions.Def_ChapterCollapseDiagonal
open BookProof.ChapterCollapseDiagonal



open scoped BigOperators
open Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (ρ O : Matrix (Fin n) (Fin n) ℂ) (hρ : IsDiagonal ρ) :
    (ρ * O).trace = ∑ i, ρ i i * O i i := by

  simp only [Matrix.trace, Matrix.diag_apply, Matrix.mul_apply]
  refine Finset.sum_congr rfl (fun i _ => ?_)
  rw [Finset.sum_eq_single i]
  · intro b _ hb; rw [hρ i b (Ne.symm hb)]; ring
  · intro h; exact absurd (Finset.mem_univ i) h
