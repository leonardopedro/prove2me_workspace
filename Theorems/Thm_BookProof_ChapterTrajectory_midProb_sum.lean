-- Generated from ChapterTrajectory.lean — theorem BookProof.ChapterTrajectory.midProb_sum
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterTrajectory.midProb_sum (U : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (hU : Uᴴ * U = 1) : ∑ a, midProb U psi a = ∑ a, ‖psi a‖ ^ 2 := by sorry
