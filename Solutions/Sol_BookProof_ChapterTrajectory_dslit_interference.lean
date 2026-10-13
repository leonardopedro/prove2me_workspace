-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.dslit_interference
import Mathlib
import Definitions.Def_ChapterTrajectory
import Theorems.Thm_BookProof_ChapterTrajectory_dslit_finalProb
import Theorems.Thm_BookProof_ChapterTrajectory_dslit_coherentFinal
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix
open BookProof.ChapterDoubleSlit


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in

theorem solution :
    finalProb H H psi0 0 ≠ coherentFinal H H psi0 0 := by
  rw [dslit_finalProb, (dslit_coherentFinal).1]; norm_num
