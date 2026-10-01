-- Generated from ChapterNavierStokesLagrangianCanonical.lean — solution of BookProof.NavierStokesFlow.LagrangianCanonical.coreState_total
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianCanonical



open scoped ENNReal



open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

set_option maxHeartbeats 1000000 in
tes diagonalize the Lagrangian second-order part.** -/
theorem solution (β : Vel) :
    lagT nu (coreState β) = ((lagLam nu β : ℝ) : ℂ) • coreState β := by
  simp only :=
   [lagT, LinearMap.add_apply, LinearMap.smul_apply, LinearMap.sum_apply,
      LinearMap.id_apply, numOp_coreState, ← Finset.sum_smul, smul_smul, ← add_smul, lagLam]
