-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.condProb_nonneg
import Mathlib
import Definitions.Def_ChapterTrajectory
import Theorems.Thm_BookProof_ChapterTrajectory_jointProb_nonneg
import Theorems.Thm_BookProof_ChapterTrajectory_finalProb_nonneg
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix


variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f a : Fin n) : 0 ≤ condProb U V psi f a := div_nonneg (jointProb_nonneg _ _ _ _ _) (finalProb_nonneg _ _ _ _)
