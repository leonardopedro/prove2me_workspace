-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.sliceSnd_liftSnd
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_sliceSnd_otimes
import Theorems.Thm_BookProof_GradedFock_liftSnd_otimes
import Theorems.Thm_BookProof_GradedFock_prod_linear_ext
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (S : Module.End ℂ (β →₀ ℂ)) (a : α) (u : (α × β) →₀ ℂ) :
    sliceSnd a (liftSnd S u) = S (sliceSnd a u) := by

  have h : (sliceSnd (β := β) a).comp (liftSnd (α := α) S)
      = S.comp (sliceSnd (β := β) a) := by
    refine prod_linear_ext fun v w => ?_
    simp only [LinearMap.comp_apply, liftSnd_otimes, sliceSnd_otimes, map_smul]
  exact congrArg (fun f : ((α × β) →₀ ℂ) →ₗ[ℂ] (β →₀ ℂ) => f u) h
