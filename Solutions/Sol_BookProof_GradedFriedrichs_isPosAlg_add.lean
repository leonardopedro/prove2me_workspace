-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.isPosAlg_add
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_ainner_add_right
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {T S : Module.End ℂ (γ →₀ ℂ)} (hT : IsPosAlg T) (hS : IsPosAlg S) :
    IsPosAlg (T + S) := by

  intro u
  change 0 ≤ (ainner u (T u + S u)).re
  rw [ainner_add_right, Complex.add_re]
  exact add_nonneg (hT u) (hS u)
