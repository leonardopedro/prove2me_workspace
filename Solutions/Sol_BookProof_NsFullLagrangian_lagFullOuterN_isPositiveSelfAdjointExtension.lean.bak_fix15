-- Generated from ChapterNavierStokesFullLagrangianFock.lean — solution of BookProof.NsFullLagrangian.lagFullOuterN_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Theorems.Thm_BookProof_NsFullLagrangian_lagFried_op_core
import Theorems.Thm_BookProof_NsFullLagrangian_lagOuterN_apply
import Theorems.Thm_BookProof_NsFullLagrangian_lagFockCore_le_friedDom
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_isPositiveSelfAdjointExtension
open BookProof.NsFullLagrangian




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (lam lam' mu gg : ℝ) :
    IsPositiveSelfAdjointExtension (lagFullFockHam lam lam' mu gg)
      (lagOuterComparison lam lam' mu gg).op :=
  (lagOuterComparison lam lam' mu gg).isPositiveSelfAdjointExtension
      (lagFullFockHam lam lam' mu gg) (fun x => by
        refine ⟨lagFockCore_le_friedDom lam lam' mu gg x.2, ?_⟩
        refine lp.ext (funext fun n => ?_)
        rw [lagOuterN_apply, lagFried_op_core lam lam' mu gg n ⟨(x : lagFockSpace) n, x.2.2 n⟩]
        exact (dsOp_coe (fun n : ℕ => lagSectorHam lam lam' mu gg n) x n).symm)
