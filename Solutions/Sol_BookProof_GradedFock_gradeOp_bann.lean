-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.gradeOp_bann
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_liftFst_liftSnd_comm
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) : gradeOp * bann j = bann j * gradeOp := by

  rw [gradeOp, bann, ← liftFst_liftSnd_comm]
