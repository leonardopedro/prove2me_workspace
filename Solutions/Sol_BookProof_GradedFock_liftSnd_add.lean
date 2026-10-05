-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.liftSnd_add
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_otimes_add_right
import Theorems.Thm_BookProof_GradedFock_prod_linear_ext
import Theorems.Thm_BookProof_GradedFock_liftSnd_otimes
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution : liftSnd (α := by

  refine prod_linear_ext fun v w => ?_
  simp only [LinearMap.add_apply, liftSnd_otimes, otimes_add_right]
