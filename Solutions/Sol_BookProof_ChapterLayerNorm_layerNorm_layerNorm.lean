-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.layerNorm_layerNorm
import Mathlib
import Definitions.Def_ChapterLayerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_mean_layerNorm
import Theorems.Thm_BookProof_ChapterLayerNorm_variance_layerNorm
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : 0 < d) {x : Fin d → ℝ} (hx : 0 < variance x) (i : Fin d) :
    layerNorm (layerNorm x) i = layerNorm x i := by

  rw [layerNorm, mean_layerNorm hd x, variance_layerNorm hd hx]
  simp
