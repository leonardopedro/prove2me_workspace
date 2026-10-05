-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.ainner_add_right
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_toL2_add
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (u v w : γ →₀ ℂ) : ainner u (v + w) = ainner u v + ainner u w := by

  rw [ainner, ainner, ainner, toL2_add, inner_add_right]
