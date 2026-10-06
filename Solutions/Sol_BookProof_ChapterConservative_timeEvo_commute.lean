-- Generated from ChapterConservative.lean — solution of BookProof.ChapterConservative.timeEvo_commute
import Mathlib
import Definitions.Def_ChapterConservative
open BookProof.ChapterConservative



open scoped Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (H : Matrix n n ℂ) (s t : ℝ) :
    Commute ((s : ℂ) • (Complex.I • H)) ((t : ℂ) • (Complex.I • H)) := by

  ext i j; simp [ mul_left_comm ]
