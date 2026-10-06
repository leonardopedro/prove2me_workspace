-- Generated from ChapterNumericalRangeCrouzeix.lean — solution of BookProof.ChapterNumericalRangeCrouzeix.inner_self_re
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix



open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (x : E) : (⟪x, x⟫_ℂ).re = ‖x‖ ^ 2 := by

  have := @inner_self_eq_norm_sq ℂ E _ _ _ x
  simpa using this
