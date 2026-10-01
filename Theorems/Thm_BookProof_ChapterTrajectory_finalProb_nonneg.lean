-- Generated from ChapterTrajectory.lean — theorem BookProof.ChapterTrajectory.finalProb_nonneg
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory

variable {n : ℕ}


open scoped BigOperators Matrix



theorem BookProof.ChapterTrajectory.finalProb_nonneg (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f : Fin n) : 0 ≤ finalProb U V psi f := by sorry
