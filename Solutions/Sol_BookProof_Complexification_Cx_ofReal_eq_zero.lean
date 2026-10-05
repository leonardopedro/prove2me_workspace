-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.Cx.ofReal_eq_zero
import Mathlib
import Definitions.Def_ChapterA1b



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution {w : W} : ofReal w = 0 ↔ w = 0 := by

  constructor
  · intro h; have := congrArg Cx.re h; simpa using this
  · rintro rfl; ext <;> simp
