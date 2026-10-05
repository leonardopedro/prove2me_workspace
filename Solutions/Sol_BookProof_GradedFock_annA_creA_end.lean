-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.annA_creA_end
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_FockSecondQuantization_ccr_annA_creA
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) :
    (annA j) * (creA j) - (creA j) * (annA j) = (1 : Module.End ℂ FockAlg) := by

  refine LinearMap.ext fun u => ?_
  simpa only [LinearMap.sub_apply, Module.End.mul_apply, Module.End.one_apply] using
    ccr_annA_creA j u
