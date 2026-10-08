-- Generated from ChapterSymmetryRep.lean — theorem BookProof.ChapterSymmetryRep.timeEvoRep_apply
import Mathlib
import Definitions.Def_ChapterSymmetryRep
import Definitions.Def_ChapterConservative
open BookProof.ChapterConservative
open BookProof.ChapterSymmetryRep


open scoped Matrix


open BookProof.ChapterConservative

variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.ChapterSymmetryRep.timeEvoRep_apply (H : Matrix n n ℂ) (hH : H.IsHermitian) (t : ℝ) :
    (timeEvoRep H hH (Multiplicative.ofAdd t) : Matrix n n ℂ) = timeEvo H t := by sorry
