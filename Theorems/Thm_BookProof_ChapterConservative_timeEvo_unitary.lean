-- Generated from ChapterConservative.lean — theorem BookProof.ChapterConservative.timeEvo_unitary
import Mathlib
import Definitions.Def_ChapterConservative
open BookProof.ChapterConservative

variable {n : Type*} [Fintype n] [DecidableEq n]


open scoped Matrix



theorem BookProof.ChapterConservative.timeEvo_unitary (H : Matrix n n ℂ) (hH : H.IsHermitian) (t : ℝ) :
    (timeEvo H t)ᴴ * (timeEvo H t) = 1 := by sorry
