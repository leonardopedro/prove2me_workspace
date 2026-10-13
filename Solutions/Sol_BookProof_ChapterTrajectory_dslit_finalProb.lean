-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.dslit_finalProb
import Mathlib
import Definitions.Def_ChapterTrajectory
import Theorems.Thm_BookProof_ChapterTrajectory_transProb_H
import Theorems.Thm_BookProof_ChapterTrajectory_midProb_H
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix
open BookProof.ChapterDoubleSlit


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in

theorem solution (f : Fin 2) : finalProb H H psi0 f = 1 / 2 := by
  unfold finalProb jointProb
  fin_cases f <;> norm_num [midProb_H, transProb_H]
