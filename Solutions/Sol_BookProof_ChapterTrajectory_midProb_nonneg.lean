-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.midProb_nonneg
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix


variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (a : Fin n) : 0 ≤ midProb U psi a := by

  unfold midProb; positivity
