-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.finalProb_nonneg
import Mathlib
import Definitions.Def_ChapterTrajectory
import Theorems.Thm_BookProof_ChapterTrajectory_jointProb_nonneg
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix


variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f : Fin n) : 0 ≤ finalProb U V psi f := Finset.sum_nonneg fun _ _ => jointProb_nonneg _ _ _ _ _
