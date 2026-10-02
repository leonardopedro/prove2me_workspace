-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.transProb_H
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (f a : Fin 2) : transProb H f a = 1 / 2 := by

  fin_cases f <;> fin_cases a <;> simp [transProb, H]
