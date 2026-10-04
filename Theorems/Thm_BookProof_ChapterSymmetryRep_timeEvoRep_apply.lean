-- Generated from ChapterSymmetryRep.lean — theorem BookProof.ChapterSymmetryRep.timeEvoRep_apply
import Mathlib
import Definitions.Def_ChapterSymmetryRep
import Definitions.Def_ChapterConservative
import Definitions.Def_ChapterA4
open BookProof.ChapterConservative
open BookProof.ChapterSymmetryRep

variable {n : Type*} [Fintype n] [DecidableEq n]


open scoped Matrix


open BookProof.ChapterConservative


theorem BookProof.ChapterSymmetryRep.timeEvoRep_apply (H : Matrix n n ℂ) (hH : H.IsHermitian) (t : ℝ) :
    (timeEvoRep H hH (Multiplicative.ofAdd t) : Matrix n n ℂ) = timeEvo H t := by sorry
