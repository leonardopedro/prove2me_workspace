-- Generated from ChapterTrajectory.lean — theorem BookProof.ChapterTrajectory.jointProb_nonneg
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory

variable {n : ℕ}


open scoped BigOperators Matrix


variable {n : ℕ}

theorem BookProof.ChapterTrajectory.jointProb_nonneg (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f a : Fin n) : 0 ≤ jointProb U V psi f a := by sorry
