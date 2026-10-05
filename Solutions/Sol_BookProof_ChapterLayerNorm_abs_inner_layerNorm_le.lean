-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.abs_inner_layerNorm_le
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_sum_sq_layerNorm
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : 0 < d) {x y : Fin d → ℝ} (hx : 0 < variance x)
    (hy : 0 < variance y) :
    |∑ i, layerNorm x i * layerNorm y i| ≤ (d : ℝ) := by

  have hcs : (∑ i, layerNorm x i * layerNorm y i) ^ 2
      ≤ (∑ i, (layerNorm x i) ^ 2) * (∑ i, (layerNorm y i) ^ 2) :=
    Finset.sum_mul_sq_le_sq_mul_sq _ _ _
  rw [sum_sq_layerNorm hd hx, sum_sq_layerNorm hd hy] at hcs
  have hd' : (0 : ℝ) ≤ (d : ℝ) := Nat.cast_nonneg d
  nlinarith [abs_nonneg (∑ i, layerNorm x i * layerNorm y i),
    sq_abs (∑ i, layerNorm x i * layerNorm y i)]
