-- Generated from ChapterTrajectory.lean — theorem BookProof.ChapterTrajectory.condProb_nonneg
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterTrajectory.condProb_nonneg (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f a : Fin n) : 0 ≤ condProb U V psi f a := by sorry
