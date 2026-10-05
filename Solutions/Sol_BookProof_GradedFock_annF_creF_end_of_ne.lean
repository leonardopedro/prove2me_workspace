-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.annF_creF_end_of_ne
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_FermionFock_car_annF_creF_of_ne
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution {j k : ℕ} (h : j ≠ k) :
    (annF j) * (creF k) + (creF k) * (annF j) = (0 : Module.End ℂ FermiAlg) := by

  refine LinearMap.ext fun u => ?_
  simpa only [LinearMap.add_apply, Module.End.mul_apply, LinearMap.zero_apply] using
    car_annF_creF_of_ne h u
