-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.gradedHamiltonian_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_algOp_friedrichs_extension
import Theorems.Thm_BookProof_GradedFriedrichs_isSymAlg_gradedHamiltonianAlg
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
    (hbherm : IsHermCol colB) (hbpos : IsPosCol colB)
    (hfherm : IsHermCol colF) (hfpos : IsPosCol colF) :
    ∃ (Dom : Submodule ℂ GFock) (A : Dom →ₗ[ℂ] GFock),
      IsPositiveSelfAdjointExtension (gradedHamiltonian colB colF) A :=
  algOp_friedrichs_extension (isSymAlg_gradedHamiltonianAlg hbherm hfherm)
      (isPosAlg_gradedHamiltonianAlg hbpos hfpos)
