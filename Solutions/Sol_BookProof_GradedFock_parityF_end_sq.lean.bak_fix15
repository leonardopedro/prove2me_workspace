-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.parityF_end_sq
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_FermionFock_parityF_involutive
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution : (parityF) * (parityF) = (1 : Module.End ℂ FermiAlg) := by

  refine LinearMap.ext fun u => ?_
  simpa only [Module.End.mul_apply, Module.End.one_apply] using parityF_involutive u
