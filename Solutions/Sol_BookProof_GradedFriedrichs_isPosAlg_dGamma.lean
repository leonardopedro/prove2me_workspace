-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.isPosAlg_dGamma
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_FockSecondQuantization_inner_dGamma_nonneg
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} (hpos : IsPosCol col) :
    IsPosAlg (dGamma col) := fun u => inner_dGamma_nonneg hpos u
