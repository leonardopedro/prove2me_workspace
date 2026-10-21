-- Generated from ChapterLayerNorm.lean — solution of BookProof.ChapterLayerNorm.variance_nonneg
import Mathlib
import Definitions.Def_ChapterLayerNorm
open BookProof.ChapterLayerNorm



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (x : Fin d → ℝ) : 0 ≤ variance x := by

  refine div_nonneg (Finset.sum_nonneg fun i _ => sq_nonneg _) (Nat.cast_nonneg d)
