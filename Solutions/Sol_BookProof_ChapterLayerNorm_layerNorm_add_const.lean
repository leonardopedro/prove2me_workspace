-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.layerNorm_add_const
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_mean_add_const
import Theorems.Thm_BookProof_ChapterLayerNorm_variance_add_const
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : 0 < d) (x : Fin d → ℝ) (c : ℝ) (i : Fin d) :
    layerNorm (fun i => x i + c) i = layerNorm x i := by

  simp only [layerNorm, variance_add_const hd x c, mean_add_const hd x c]
  ring_nf
