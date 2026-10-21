-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.liftFst_liftSnd_comm
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_prod_linear_ext
import Theorems.Thm_BookProof_GradedFock_liftFst_otimes
import Theorems.Thm_BookProof_GradedFock_liftSnd_otimes
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution : (liftFst (β := by

  refine prod_linear_ext fun v w => ?_
  rw [Module.End.mul_apply, Module.End.mul_apply, liftSnd_otimes, liftFst_otimes,
    liftFst_otimes, liftSnd_otimes]
