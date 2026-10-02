-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.transProb_nonneg
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (V : Matrix (Fin n) (Fin n) ℂ) (f a : Fin n) :
    0 ≤ transProb V f a := by

  unfold transProb; positivity
