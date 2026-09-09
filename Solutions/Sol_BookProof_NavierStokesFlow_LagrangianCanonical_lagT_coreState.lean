-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.lagT_coreState
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianCanonical_numOp_coreState
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical

















open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent














variable (nu : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (β : Vel) :
    lagT nu (coreState β) = ((lagLam nu β : ℝ) : ℂ) • coreState β := by

  simp only [lagT, LinearMap.add_apply, LinearMap.smul_apply, LinearMap.sum_apply,
    LinearMap.id_apply, numOp_coreState, ← Finset.sum_smul, smul_smul, ← add_smul, lagLam]
  congr 1
  push_cast
  ring
