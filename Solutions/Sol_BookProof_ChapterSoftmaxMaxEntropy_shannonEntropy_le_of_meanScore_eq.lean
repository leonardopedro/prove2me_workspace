-- Generated from ChapterSoftmaxMaxEntropy.lean — solution of BookProof.ChapterSoftmaxMaxEntropy.shannonEntropy_le_of_meanScore_eq
import Mathlib
import Definitions.Def_ChapterSoftmaxMaxEntropy
import Theorems.Thm_BookProof_ChapterSoftmaxMaxEntropy_shannonEntropy_le_crossEntropy
import Theorems.Thm_BookProof_ChapterSoftmaxMaxEntropy_shannonEntropy_scoreSoftmax
import Theorems.Thm_BookProof_ChapterSoftmaxMaxEntropy_crossEntropy_scoreSoftmax
open BookProof.ChapterSoftmaxMaxEntropy



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m)
    {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hpsum : ∑ j, p j = 1)
    (hmean : ∑ j, p j * s j = meanScore beta s) :
    shannonEntropy p ≤ shannonEntropy (scoreSoftmax beta s) := by

  have hq0 : ∀ j, 0 < scoreSoftmax beta s j := fun j => scoreSoftmax_pos beta s j
  have hqsum : ∑ j, scoreSoftmax beta s j ≤ 1 := le_of_eq (scoreSoftmax_sum_one beta s i)
  have hgibbs := shannonEntropy_le_crossEntropy hp0 hpsum hq0 hqsum
  rw [crossEntropy_scoreSoftmax beta s hpsum, hmean,
    ← shannonEntropy_scoreSoftmax beta s i] at hgibbs
  exact hgibbs
