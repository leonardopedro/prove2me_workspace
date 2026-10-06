-- Generated from ChapterConservative.lean — solution of BookProof.ChapterConservative.timeEvo_add
import Mathlib
import Definitions.Def_ChapterConservative
import Theorems.Thm_BookProof_ChapterConservative_timeEvo_commute
open BookProof.ChapterConservative



open scoped Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (H : Matrix n n ℂ) (s t : ℝ) :
    timeEvo H s * timeEvo H t = timeEvo H (s + t) := by

  unfold timeEvo
  rw [← Matrix.exp_add_of_commute]
  · simp [add_smul]
  · exact timeEvo_commute H s t
