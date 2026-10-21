-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.toL2_add
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
theorem solution (u v : γ →₀ ℂ) : toL2 (u + v) = toL2 u + toL2 v := toL2L.map_add u v
