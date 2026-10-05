-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.variance_add_const
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_mean_add_const
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : 0 < d) (x : Fin d → ℝ) (c : ℝ) :
    variance (fun i => x i + c) = variance x := by

  simp only [variance, mean_add_const hd x c]
  congr 1
  exact Finset.sum_congr rfl fun i _ => by ring_nf
