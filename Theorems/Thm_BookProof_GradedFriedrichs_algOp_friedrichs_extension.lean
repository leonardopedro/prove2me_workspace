-- Generated from ChapterGradedFriedrichs.lean — theorem BookProof.GradedFriedrichs.algOp_friedrichs_extension
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.YangMillsFriedrichs
open BookProof.GradedFriedrichs

variable {γ : Type*}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

theorem BookProof.GradedFriedrichs.algOp_friedrichs_extension {T : Module.End ℂ (γ →₀ ℂ)}
    (hsym : IsSymAlg T) (hpos : IsPosAlg T) :
    ∃ (Dom : Submodule ℂ (L2I γ)) (A : Dom →ₗ[ℂ] L2I γ),
      IsPositiveSelfAdjointExtension (opOfAlg T) A := by sorry
