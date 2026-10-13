-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.annA_creA_end_of_ne
import Mathlib
import Definitions.Def_ChapterGradedFock
import Theorems.Thm_BookProof_FockSecondQuantization_ccr_annA_creA_of_ne
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterSuperBracket
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket
open BookProof.FockSecondQuantization

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution {j k : ℕ} (h : j ≠ k) :
    (annA j) * (creA k) - (creA k) * (annA j) = (0 : Module.End ℂ FockAlg) := by

  refine LinearMap.ext fun u => ?_
  simp only [LinearMap.sub_apply, Module.End.mul_apply, LinearMap.zero_apply]
  rw [ccr_annA_creA_of_ne h, sub_self]
