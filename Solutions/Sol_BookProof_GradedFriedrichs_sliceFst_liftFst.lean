-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.sliceFst_liftFst
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_sliceFst_otimes
import Theorems.Thm_BookProof_GradedFock_liftFst_otimes
import Theorems.Thm_BookProof_GradedFock_prod_linear_ext
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (T : Module.End ℂ (α →₀ ℂ)) (b : β) (u : (α × β) →₀ ℂ) :
    sliceFst b (liftFst T u) = T (sliceFst b u) := by

  have h : (sliceFst (α := α) b).comp (liftFst (β := β) T)
      = T.comp (sliceFst (α := α) b) := by
    refine prod_linear_ext fun v w => ?_
    simp only [LinearMap.comp_apply, liftFst_otimes, sliceFst_otimes, map_smul]
  exact congrArg (fun f : ((α × β) →₀ ℂ) →ₗ[ℂ] (α →₀ ℂ) => f u) h
