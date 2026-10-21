-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.layerNorm_smul_pos
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_mean_smul
import Theorems.Thm_BookProof_ChapterLayerNorm_variance_smul
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {a : ℝ} (ha : 0 < a) (x : Fin d → ℝ) (i : Fin d) :
    layerNorm (fun i => a * x i) i = layerNorm x i := by

  have hsqrt : Real.sqrt (a ^ 2 * variance x) = a * Real.sqrt (variance x) := by
    rw [Real.sqrt_mul (sq_nonneg a), Real.sqrt_sq ha.le]
  simp only [layerNorm, variance_smul, mean_smul, hsqrt]
  rw [← mul_sub, mul_div_mul_left _ _ ha.ne']
