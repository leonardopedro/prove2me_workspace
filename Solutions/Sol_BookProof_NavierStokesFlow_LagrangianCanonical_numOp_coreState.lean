-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.numOp_coreState
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_crd_numOp
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_crd_coreState
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

















open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato  BookProof.NavierStokesFlow.LagrangianKatoRellich
open BookProof.NavierStokesFlow.CanonicalVector BookProof.NavierStokesFlow.ThreeComponent














variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (β : Vel) :
    numOp i (coreState β) = ((β i : ℝ) : ℂ) • coreState β := by

  classical
  refine crd_injective ?_
  funext γ
  rw [crd_numOp, crd_smul]
  by_cases hγ : γ = β
  · subst hγ
    simp [crd_coreState]
  · simp [crd_coreState, hγ]
