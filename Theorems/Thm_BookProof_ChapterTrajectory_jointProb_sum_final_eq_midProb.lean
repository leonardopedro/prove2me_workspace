-- Generated from ChapterTrajectory.lean — theorem BookProof.ChapterTrajectory.jointProb_sum_final_eq_midProb
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory

variable {n : ℕ}


open scoped BigOperators Matrix



theorem BookProof.ChapterTrajectory.jointProb_sum_final_eq_midProb (U V : Matrix (Fin n) (Fin n) ℂ)
    (psi : Fin n → ℂ) (hV : Vᴴ * V = 1) (a : Fin n) :
    ∑ f, jointProb U V psi f a = midProb U psi a := by sorry
