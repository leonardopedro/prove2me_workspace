-- Generated from ChapterTrajectory.lean — theorem BookProof.ChapterTrajectory.finalProb_total
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterTrajectory.finalProb_total (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (hU : Uᴴ * U = 1) (hV : Vᴴ * V = 1) (hpsi : ∑ a, ‖psi a‖ ^ 2 = 1) :
    ∑ f, finalProb U V psi f = 1 := by sorry
