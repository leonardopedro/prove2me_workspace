-- Generated from ChapterTrajectory.lean — theorem BookProof.ChapterTrajectory.midProb_nonneg
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterTrajectory.midProb_nonneg (U : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (a : Fin n) : 0 ≤ midProb U psi a := by sorry
