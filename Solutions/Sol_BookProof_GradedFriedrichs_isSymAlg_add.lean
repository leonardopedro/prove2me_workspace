-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.isSymAlg_add
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_ainner_add_right
import Theorems.Thm_BookProof_GradedFriedrichs_ainner_add_left
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {T S : Module.End ℂ (γ →₀ ℂ)} (hT : IsSymAlg T) (hS : IsSymAlg S) :
    IsSymAlg (T + S) := by

  intro u v
  change ainner (T u + S u) v = ainner u (T v + S v)
  rw [ainner_add_left, ainner_add_right, hT, hS]
