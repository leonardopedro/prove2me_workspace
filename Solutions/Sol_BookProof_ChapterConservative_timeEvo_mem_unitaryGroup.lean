-- Generated from ChapterConservative.lean — solution of BookProof.ChapterConservative.timeEvo_mem_unitaryGroup
import Mathlib
import Definitions.Def_ChapterConservative
import Theorems.Thm_BookProof_ChapterConservative_timeEvo_unitary
import Theorems.Thm_BookProof_ChapterConservative_timeEvo_unitary'
open BookProof.ChapterConservative



open scoped Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (H : Matrix n n ℂ) (hH : H.IsHermitian) (t : ℝ) :
    timeEvo H t ∈ Matrix.unitaryGroup n ℂ := by

  constructor
  · convert timeEvo_unitary H hH t using 1
    rw [Matrix.star_eq_conjTranspose]
  · convert timeEvo_unitary' H hH t using 1
    rw [Matrix.star_eq_conjTranspose]
