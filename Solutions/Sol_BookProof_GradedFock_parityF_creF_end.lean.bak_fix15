-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.parityF_creF_end
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_FermionFock_parityF_creF
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) :
    (parityF) * (creF j) = - ((creF j) * (parityF)) := by

  refine LinearMap.ext fun u => ?_
  simpa only [Module.End.mul_apply, LinearMap.neg_apply] using parityF_creF j u
