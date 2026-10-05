-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.coe_opOfAlg
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (T : Module.End ℂ (γ →₀ ℂ)) (x : lpFiniteModes γ) :
    opOfAlg T x = toL2 (T (algEquivL2.symm x)) := by

  simp [opOfAlg, LinearEquiv.conj_apply, coe_algEquivL2]
