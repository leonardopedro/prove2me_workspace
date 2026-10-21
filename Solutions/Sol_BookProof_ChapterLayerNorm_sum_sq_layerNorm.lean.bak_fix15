-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.sum_sq_layerNorm
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_sum_sq_sub_mean_eq
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : 0 < d) {x : Fin d → ℝ} (hx : 0 < variance x) :
    ∑ i, (layerNorm x i) ^ 2 = (d : ℝ) := by

  have hs : (Real.sqrt (variance x)) ^ 2 = variance x := Real.sq_sqrt hx.le
  have hsne : variance x ≠ 0 := hx.ne'
  simp only [layerNorm, div_pow, hs, ← Finset.sum_div]
  rw [sum_sq_sub_mean_eq hd x, mul_div_assoc, div_self hsne, mul_one]
