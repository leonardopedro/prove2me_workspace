-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.opOfAlg_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_coe_algEquivL2_symm
import Theorems.Thm_BookProof_GradedFriedrichs_coe_opOfAlg
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {T : Module.End ℂ (γ →₀ ℂ)} (hT : IsPosAlg T)
    (x : lpFiniteModes γ) : 0 ≤ quadForm (opOfAlg T) x := by

  rw [quadForm, coe_opOfAlg, coe_algEquivL2_symm x]
  exact hT _
