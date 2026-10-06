-- Generated from ChapterConservative.lean — theorem BookProof.ChapterConservative.timeEvo_add
import Mathlib
import Definitions.Def_ChapterConservative
open BookProof.ChapterConservative

variable {n : Type*} [Fintype n] [DecidableEq n]


open scoped Matrix



theorem BookProof.ChapterConservative.timeEvo_add (H : Matrix n n ℂ) (s t : ℝ) :
    timeEvo H s * timeEvo H t = timeEvo H (s + t) := by sorry
