-- Generated from ChapterTrajectory.lean — theorem BookProof.ChapterTrajectory.condProb_sum
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterTrajectory.condProb_sum (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f : Fin n) (hf : finalProb U V psi f ≠ 0) :
    ∑ a, condProb U V psi f a = 1 := by sorry
