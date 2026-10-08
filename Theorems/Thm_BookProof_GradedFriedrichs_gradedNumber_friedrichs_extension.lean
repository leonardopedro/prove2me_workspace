-- Generated from ChapterGradedFriedrichs.lean — theorem BookProof.GradedFriedrichs.gradedNumber_friedrichs_extension
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsGhost
open BookProof.GradedFriedrichs



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

theorem BookProof.GradedFriedrichs.gradedNumber_friedrichs_extension :
    ∃ (Dom : Submodule ℂ GFock) (A : Dom →ₗ[ℂ] GFock),
      IsPositiveSelfAdjointExtension (gradedHamiltonian idCol idCol) A := by sorry
