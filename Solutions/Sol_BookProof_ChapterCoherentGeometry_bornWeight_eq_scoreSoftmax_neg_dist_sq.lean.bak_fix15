-- Generated from ChapterCoherentGeometry.lean — solution of BookProof.ChapterCoherentGeometry.bornWeight_eq_scoreSoftmax_neg_dist_sq
import Mathlib
import Definitions.Def_ChapterCoherentGeometry
import Theorems.Thm_BookProof_ChapterCoherentGeometry_bornNumer_eq_exp_neg_dist_sq
open BookProof.ChapterCoherentGeometry



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlap BookProof.ChapterSoftmaxBorn

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    bornWeight q k j = scoreSoftmax 1 (fun l => -‖q - k l‖ ^ 2) j := by

  rw [bornWeight, scoreSoftmax, bornNumer_eq_exp_neg_dist_sq]
  simp only [one_mul]
  exact congrArg _ (Finset.sum_congr rfl fun l _ => bornNumer_eq_exp_neg_dist_sq q (k l))
