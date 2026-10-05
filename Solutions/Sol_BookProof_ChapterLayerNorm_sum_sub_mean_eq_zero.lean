-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.sum_sub_mean_eq_zero
import Mathlib
import Definitions.Def_ChapterLayerNorm
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : 0 < d) (x : Fin d → ℝ) : ∑ i, (x i - mean x) = 0 := by

  have hd' : (d : ℝ) ≠ 0 := by positivity
  rw [Finset.sum_sub_distrib]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, mean]
  field_simp
  ring
