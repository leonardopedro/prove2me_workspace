-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.jointProb_nonneg
import Mathlib
import Definitions.Def_ChapterTrajectory
import Theorems.Thm_BookProof_ChapterTrajectory_midProb_nonneg
import Theorems.Thm_BookProof_ChapterTrajectory_transProb_nonneg
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f a : Fin n) : 0 ≤ jointProb U V psi f a := mul_nonneg (midProb_nonneg _ _ _) (transProb_nonneg _ _ _)
