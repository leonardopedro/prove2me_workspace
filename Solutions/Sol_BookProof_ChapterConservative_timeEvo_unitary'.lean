-- Generated from ChapterConservative.lean — solution of BookProof.ChapterConservative.timeEvo_unitary'
import Mathlib
import Definitions.Def_ChapterConservative
import Theorems.Thm_BookProof_ChapterConservative_timeEvo_unitary
open BookProof.ChapterConservative



open scoped Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (H : Matrix n n ℂ) (hH : H.IsHermitian) (t : ℝ) :
    (timeEvo H t) * (timeEvo H t)ᴴ = 1 := by

  rw [← mul_eq_one_comm, timeEvo_unitary]
  exact hH
