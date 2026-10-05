-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.annA_annA_end
import Mathlib
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution (j k : ℕ) :
    (annA j) * (annA k) - (annA k) * (annA j) = (0 : Module.End ℂ FockAlg) := by

  refine LinearMap.ext fun u => ?_
  simp only [LinearMap.sub_apply, Module.End.mul_apply, LinearMap.zero_apply]
  rw [ccr_annA_annA j k, sub_self]
