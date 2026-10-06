-- Generated from ChapterCoherentOverlapComplex.lean — solution of BookProof.ChapterCoherentOverlapComplex.bornNumerC_eq
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
import Theorems.Thm_BookProof_ChapterCoherentOverlapComplex_norm_coherentOverlapC
open BookProof.ChapterCoherentOverlapComplex



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℂ (Fin n)) :
    bornNumerC q k =
      Real.exp (-‖q‖ ^ 2) * Real.exp (-‖k‖ ^ 2)
        * Real.exp (2 * (inner ℂ q k : ℂ).re) := by

  rw [bornNumerC, norm_coherentOverlapC, ← Real.exp_nat_mul, ← Real.exp_add, ← Real.exp_add]
  congr 1
  ring
