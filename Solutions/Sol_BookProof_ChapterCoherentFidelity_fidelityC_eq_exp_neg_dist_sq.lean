-- Generated from ChapterCoherentFidelity.lean — solution of BookProof.ChapterCoherentFidelity.fidelityC_eq_exp_neg_dist_sq
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
import Theorems.Thm_BookProof_ChapterCoherentFidelity_fidelityC_eq_bornNumerC
import Theorems.Thm_BookProof_ChapterCoherentOverlapComplex_bornNumerC_eq
open BookProof.ChapterCoherentFidelity



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℂ (Fin n)) :
    fidelityC q k = Real.exp (-‖q - k‖ ^ 2) := by

  have hdist : ‖q - k‖ ^ 2 = ‖q‖ ^ 2 - 2 * (inner ℂ q k : ℂ).re + ‖k‖ ^ 2 := by
    simpa using norm_sub_sq (𝕜 := ℂ) q k
  rw [fidelityC_eq_bornNumerC, bornNumerC_eq, ← Real.exp_add, ← Real.exp_add, hdist]
  congr 1
  ring
