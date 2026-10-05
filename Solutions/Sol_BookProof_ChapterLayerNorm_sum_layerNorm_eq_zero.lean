-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.sum_layerNorm_eq_zero
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_sum_sub_mean_eq_zero
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : 0 < d) (x : Fin d → ℝ) : ∑ i, layerNorm x i = 0 := by

  simp only [layerNorm, ← Finset.sum_div]
  rw [sum_sub_mean_eq_zero hd x, zero_div]
