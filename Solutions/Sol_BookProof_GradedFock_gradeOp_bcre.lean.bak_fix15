-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.gradeOp_bcre
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
theorem solution (j : ℕ) : gradeOp * bcre j = bcre j * gradeOp := by

  rw [gradeOp, bcre, ← liftFst_liftSnd_comm]
