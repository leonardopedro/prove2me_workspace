-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.gradedHamiltonian_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_opOfAlg_quadForm_nonneg
import Theorems.Thm_BookProof_GradedFriedrichs_isPosAlg_gradedHamiltonianAlg
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {colB colF : ℕ → (ℕ →₀ ℂ)}
    (hb : IsPosCol colB) (hf : IsPosCol colF) (x : lpFiniteModes GConf) :
    0 ≤ quadForm (gradedHamiltonian colB colF) x := opOfAlg_quadForm_nonneg (isPosAlg_gradedHamiltonianAlg hb hf) x
