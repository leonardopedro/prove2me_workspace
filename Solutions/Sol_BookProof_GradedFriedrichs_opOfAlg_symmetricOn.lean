-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.opOfAlg_symmetricOn
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_coe_algEquivL2_symm
import Theorems.Thm_BookProof_GradedFriedrichs_coe_opOfAlg
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {γ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {T : Module.End ℂ (γ →₀ ℂ)} (hT : IsSymAlg T) :
    SymmetricOn (lpFiniteModes γ) (opOfAlg T) := by

  intro x y
  rw [coe_opOfAlg, coe_opOfAlg, coe_algEquivL2_symm x, coe_algEquivL2_symm y]
  exact hT _ _
