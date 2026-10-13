-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.algOp_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_opOfAlg_symmetricOn
import Theorems.Thm_BookProof_GradedFriedrichs_opOfAlg_quadForm_nonneg
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.YangMillsFriedrichs

noncomputable section

variable {γ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {T : Module.End ℂ (γ →₀ ℂ)}
    (hsym : IsSymAlg T) (hpos : IsPosAlg T) :
    ∃ (Dom : Submodule ℂ (L2I γ)) (A : Dom →ₗ[ℂ] L2I γ),
      IsPositiveSelfAdjointExtension (opOfAlg T) A :=
  friedrichs_extension_exists
      ⟨lpFiniteModes γ, opOfAlg T, opOfAlg_symmetricOn hsym, opOfAlg_quadForm_nonneg hpos⟩
      lpFiniteModes_dense
