-- Generated from ChapterScaledDotProduct.lean — solution of BookProof.ChapterScaledDotProduct.sgn_not
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Bool) : sgn (!b) = -sgn b := by

  cases b <;> simp [sgn]
