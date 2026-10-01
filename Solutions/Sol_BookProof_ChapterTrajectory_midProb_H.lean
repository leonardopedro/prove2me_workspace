-- Generated from ChapterTrajectory.lean — solution of BookProof.ChapterTrajectory.midProb_H
import Mathlib
import Definitions.Def_ChapterTrajectory
import Theorems.Thm_BookProof_ChapterDoubleSlit_slit_closed_born
open BookProof.ChapterTrajectory



open scoped BigOperators Matrix


variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 2) : midProb H psi0 a = 1 / 2 := by

  simpa [midProb, bornProb] using BookProof.ChapterDoubleSlit.sl
