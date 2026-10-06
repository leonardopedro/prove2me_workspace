-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.numOp_coreState
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_injective
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_smul
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_crd_coreState
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_crd_numOp
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (β : Vel) :
    numOp i (coreState β) = ((β i : ℝ) : ℂ) • coreState β :=
  ation by the Hermite states -/
  
  theorem crd_coreState (β γ : Vel) : crd (coreState β) γ = if γ = β then 1 else 0 := by
    classical
    simp [crd, coreState, lp.single_apply,
