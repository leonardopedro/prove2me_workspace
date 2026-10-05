-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.variance_eq_zero_iff
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
theorem solution (hd : 0 < d) (x : Fin d → ℝ) :
    variance x = 0 ↔ ∀ i, x i = mean x := by

  have hd' : (0 : ℝ) < (d : ℝ) := by exact_mod_cast hd
  constructor
  · intro h i
    have hsum : ∑ i, (x i - mean x) ^ 2 = 0 := by
      rw [sum_sq_sub_mean_eq hd, h, mul_zero]
    have := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => sq_nonneg (x j - mean x))).mp hsum i
      (Finset.mem_univ i)
    have hz : x i - mean x = 0 := by
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
    linarith
  · intro h
    rw [variance]
    have : ∑ i, (x i - mean x) ^ 2 = 0 :=
      Finset.sum_eq_zero fun i _ => by rw [h i]; ring
    rw [this, zero_div]
