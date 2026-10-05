-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.dGamma_idCol_one_particle
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_support_idCol
import Theorems.Thm_BookProof_FockSecondQuantization_dGamma_one_particle
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) :
    dGamma idCol (Finsupp.single (Finsupp.single k 1) 1)
      = Finsupp.single (Finsupp.single k 1) (1 : ℂ) := by

  rw [dGamma_one_particle, support_idCol, Finset.sum_singleton]
  simp [idCol]
