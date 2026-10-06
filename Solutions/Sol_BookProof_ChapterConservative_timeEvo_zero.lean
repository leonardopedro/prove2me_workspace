-- Generated from ChapterConservative.lean — solution of BookProof.ChapterConservative.timeEvo_zero
import Mathlib
import Definitions.Def_ChapterConservative
open BookProof.ChapterConservative



open scoped Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (H : Matrix n n ℂ) : timeEvo H 0 = 1 := by

  unfold timeEvo; aesop
