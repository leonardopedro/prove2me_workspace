-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.mean_layerNorm
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_sum_layerNorm_eq_zero
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : 0 < d) (x : Fin d → ℝ) : mean (layerNorm x) = 0 := by

  have hd' : (d : ℝ) ≠ 0 := by positivity
  rw [mean, sum_layerNorm_eq_zero hd x, zero_div]
