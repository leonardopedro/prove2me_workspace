-- Generated from ChapterCoherentGeometry.lean — solution of BookProof.ChapterCoherentGeometry.bornNumer_eq_exp_neg_dist_sq
import Mathlib
import Definitions.Def_ChapterCoherentGeometry
import Theorems.Thm_BookProof_ChapterCoherentOverlap_coherentOverlap_eq_gaussian
open BookProof.ChapterCoherentGeometry



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxBorn

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℝ (Fin n)) :
    bornNumer q k = Real.exp (-‖q - k‖ ^ 2) := by

  rw [bornNumer, coherentOverlap_eq_gaussian, ← Real.exp_nat_mul]
  congr 1
  ring
