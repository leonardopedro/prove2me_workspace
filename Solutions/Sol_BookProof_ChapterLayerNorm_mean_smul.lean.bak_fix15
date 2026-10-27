-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.mean_smul
import Mathlib
import Definitions.Def_ChapterLayerNorm
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : ℝ) (x : Fin d → ℝ) : mean (fun i => a * x i) = a * mean x := by

  simp only [mean, ← Finset.mul_sum]
  ring
