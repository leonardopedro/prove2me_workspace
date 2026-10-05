-- Generated from ChapterCoherentFidelity.lean — solution of BookProof.ChapterCoherentFidelity.fidelityC_translation_invariant
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
import Theorems.Thm_BookProof_ChapterCoherentFidelity_fidelityC_eq_exp_neg_dist_sq
open BookProof.ChapterCoherentFidelity



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k v : EuclideanSpace ℂ (Fin n)) :
    fidelityC (q + v) (k + v) = fidelityC q k := by

  rw [fidelityC_eq_exp_neg_dist_sq, fidelityC_eq_exp_neg_dist_sq]
  congr 2
  rw [show q + v - (k + v) = q - k from by abel]
