-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.gradedNumber_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_gradedHamiltonian_friedrichs_extension
import Theorems.Thm_BookProof_GradedFriedrichs_isHermCol_idCol
import Theorems.Thm_BookProof_GradedFriedrichs_isPosCol_idCol
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (Dom : Submodule ℂ GFock) (A : Dom →ₗ[ℂ] GFock),
      IsPositiveSelfAdjointExtension (gradedHamiltonian idCol idCol) A :=
  gradedHamiltonian_friedrichs_extension isHermCol_idCol isPosCol_idCol
      isHermCol_idCol isPosCol_idCol
