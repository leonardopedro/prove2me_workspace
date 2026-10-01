-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.numOp_coreState
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_crd_numOp
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_injective
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_smul
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_crd_coreState
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical



open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

set_option maxHeartbeats 1000000 in
_sum, Finset.smul_sum, Finset.smul_sum]
  rw [← Finset.sum_add_distrib]
  rw [Finset.sum_congr rfl fun i _ => hmode i]
  rw [Finset.sum_add_distrib, hcnt, hbridge]

/-! ## Diagonaliz :=
  ation by the Hermite states -/
  
  theorem crd_coreState (β γ : Vel) : crd (coreState β) γ = if γ = β then 1 else 0 := by
    classical
    simp [crd, coreState, lp.single_apply,
