-- Generated from ChapterSoftmaxOrder.lean — solution of BookProof.ChapterSoftmaxOrder.softmax_le_iff_inner_le
import Mathlib
import Definitions.Def_ChapterSoftmaxOrder
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_le_iff
import Theorems.Thm_BookProof_ChapterSoftmaxSharpness_softmax_eq_scoreSoftmax
open BookProof.ChapterSoftmaxOrder



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} {beta : ℝ} (hbeta : 0 < beta)
    (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n)) (i j : Fin m) :
    softmax beta q k i ≤ softmax beta q k j ↔
      (inner ℝ q (k i) : ℝ) ≤ inner ℝ q (k j) := by

  rw [softmax_eq_scoreSoftmax, softmax_eq_scoreSoftmax, scoreSoftmax_le_iff hbeta]
