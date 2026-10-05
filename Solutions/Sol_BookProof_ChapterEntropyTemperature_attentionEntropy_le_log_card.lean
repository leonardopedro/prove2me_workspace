-- Generated from ChapterEntropyTemperature.lean — solution of BookProof.ChapterEntropyTemperature.attentionEntropy_le_log_card
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
import Theorems.Thm_BookProof_ChapterEntropyTemperature_attentionEntropy_le_at_zero
import Theorems.Thm_BookProof_ChapterAttentionEntropy_shannonEntropy_scoreSoftmax_zero
open BookProof.ChapterEntropyTemperature



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (i : Fin m) {beta : ℝ}
    (hbeta : 0 ≤ beta) : attentionEntropy beta s ≤ Real.log m := by

  have hm : 0 < m := Fin.pos i
  have h0 : attentionEntropy 0 s = Real.log m := shannonEntropy_scoreSoftmax_zero s hm
  exact (attentionEntropy_le_at_zero s i hbeta).trans_eq h0
