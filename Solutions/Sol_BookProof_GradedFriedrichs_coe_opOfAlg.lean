-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.coe_opOfAlg
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
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
theorem solution (T : Module.End ℂ (γ →₀ ℂ)) (x : lpFiniteModes γ) :
    opOfAlg T x = toL2 (T (algEquivL2.symm x)) := by

  simp [opOfAlg, LinearEquiv.conj_apply, coe_algEquivL2]
