-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.liftSnd_mul
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_GradedFock_prod_linear_ext
import Theorems.Thm_BookProof_GradedFock_liftSnd_otimes
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterSuperBracket
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in

theorem solution : (liftSnd (α := α) S) * (liftSnd S') = liftSnd (S * S') := by
  refine prod_linear_ext fun v w => ?_
  rw [Module.End.mul_apply, liftSnd_otimes, liftSnd_otimes, liftSnd_otimes,
    Module.End.mul_apply]
