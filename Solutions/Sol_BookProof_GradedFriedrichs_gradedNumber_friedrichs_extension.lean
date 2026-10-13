-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.gradedNumber_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_gradedHamiltonian_friedrichs_extension
import Theorems.Thm_BookProof_GradedFriedrichs_isHermCol_idCol
import Theorems.Thm_BookProof_GradedFriedrichs_isPosCol_idCol
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsGhost

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (Dom : Submodule ℂ GFock) (A : Dom →ₗ[ℂ] GFock),
      IsPositiveSelfAdjointExtension (gradedHamiltonian idCol idCol) A :=
  gradedHamiltonian_friedrichs_extension isHermCol_idCol isPosCol_idCol
      isHermCol_idCol isPosCol_idCol
