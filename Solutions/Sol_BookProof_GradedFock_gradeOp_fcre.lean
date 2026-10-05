-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.gradeOp_fcre
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_liftSnd_mul
import Theorems.Thm_BookProof_GradedFock_liftSnd_neg
import Theorems.Thm_BookProof_GradedFock_parityF_creF_end
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) : gradeOp * fcre j = - (fcre j * gradeOp) := by

  rw [gradeOp, fcre, liftSnd_mul, liftSnd_mul, parityF_creF_end, liftSnd_neg]
