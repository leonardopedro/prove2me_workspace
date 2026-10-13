-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.dslit_coherentFinal
import Mathlib
import Definitions.Def_ChapterTrajectory
import Theorems.Thm_BookProof_ChapterDoubleSlit_slit_open_born
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix
open BookProof.ChapterDoubleSlit


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in

theorem solution :
    coherentFinal H H psi0 0 = 1 ∧ coherentFinal H H psi0 1 = 0 := by
  have h := slit_open_born
  unfold coherentFinal
  rw [← Matrix.mulVec_mulVec]
  exact h
