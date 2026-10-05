-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.sum_sq_sub_mean_eq
import Mathlib
import Definitions.Def_ChapterLayerNorm
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : 0 < d) (x : Fin d → ℝ) :
    ∑ i, (x i - mean x) ^ 2 = (d : ℝ) * variance x := by

  have hd' : (d : ℝ) ≠ 0 := by positivity
  rw [variance]
  field_simp
