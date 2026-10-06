-- Generated from ChapterConservative.lean — solution of BookProof.ChapterConservative.timeEvo_inv
import Mathlib
import Definitions.Def_ChapterConservative
import Theorems.Thm_BookProof_ChapterConservative_timeEvo_zero
import Theorems.Thm_BookProof_ChapterConservative_timeEvo_add
open BookProof.ChapterConservative



open scoped Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (H : Matrix n n ℂ) (t : ℝ) :
    timeEvo H t * timeEvo H (-t) = 1 := by

  convert timeEvo_add H t (-t) using 1
  simp [timeEvo_zero]
