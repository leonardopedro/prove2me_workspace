-- Generated from ChapterConservative.lean — theorem BookProof.ChapterConservative.timeEvo_inv
import Mathlib
import Definitions.Def_ChapterConservative
open BookProof.ChapterConservative


open scoped Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.ChapterConservative.timeEvo_inv (H : Matrix n n ℂ) (t : ℝ) :
    timeEvo H t * timeEvo H (-t) = 1 := by sorry
