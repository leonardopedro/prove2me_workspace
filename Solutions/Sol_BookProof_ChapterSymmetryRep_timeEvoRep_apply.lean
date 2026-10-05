-- Generated from ChapterSymmetryRep.lean — solution of BookProof.ChapterSymmetryRep.timeEvoRep_apply
import Mathlib
import Definitions.Def_ChapterSymmetryRep
open BookProof.ChapterSymmetryRep



open scoped Matrix


open BookProof.ChapterConservative

variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (H : Matrix n n ℂ) (hH : H.IsHermitian) (t : ℝ) :
    (timeEvoRep H hH (Multiplicative.ofAdd t) : Matrix n n ℂ) = timeEvo H t := rfl
