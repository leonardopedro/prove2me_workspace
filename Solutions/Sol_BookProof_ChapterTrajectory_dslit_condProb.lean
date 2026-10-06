-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.dslit_condProb
import Mathlib
import Definitions.Def_ChapterTrajectory
import Theorems.Thm_BookProof_ChapterTrajectory_transProb_H
import Theorems.Thm_BookProof_ChapterTrajectory_midProb_H
import Theorems.Thm_BookProof_ChapterTrajectory_dslit_finalProb
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (f a : Fin 2) : condProb H H psi0 f a = 1 / 2 :=
  si0 f a = 1 / 2 := by
    fin_cases f <;> fin_cases a <;>
      simp [condProb, jointProb, midProb_H, transProb_H,
