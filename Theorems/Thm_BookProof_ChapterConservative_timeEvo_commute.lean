-- Generated from ChapterConservative.lean — theorem BookProof.ChapterConservative.timeEvo_commute
import Mathlib
import Definitions.Def_ChapterConservative
open BookProof.ChapterConservative

variable {n : Type*} [Fintype n] [DecidableEq n]


open scoped Matrix



theorem BookProof.ChapterConservative.timeEvo_commute (H : Matrix n n ℂ) (s t : ℝ) :
    Commute ((s : ℂ) • (Complex.I • H)) ((t : ℂ) • (Complex.I • H)) := by sorry
