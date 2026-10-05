-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.variance_layerNorm
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_sum_sq_layerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_mean_layerNorm
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : 0 < d) {x : Fin d → ℝ} (hx : 0 < variance x) :
    variance (layerNorm x) = 1 := by

  have hd' : (d : ℝ) ≠ 0 := by positivity
  rw [variance, mean_layerNorm hd x]
  simp only [sub_zero]
  rw [sum_sq_layerNorm hd hx, div_self hd']
