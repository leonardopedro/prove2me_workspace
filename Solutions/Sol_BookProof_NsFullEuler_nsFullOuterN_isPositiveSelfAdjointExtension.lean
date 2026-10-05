-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsFullOuterN_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_NsFullEuler_nsFried_op_core
import Theorems.Thm_BookProof_NsFullEuler_nsOuterN_apply
import Theorems.Thm_BookProof_NsFullEuler_nsFockCore_le_friedDom
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_isPositiveSelfAdjointExtension
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ) :
    IsPositiveSelfAdjointExtension (nsFullFockHam nu lam mu gg)
      (nsOuterComparison nu lam mu gg).op :=
  (nsOuterComparison nu lam mu gg).isPositiveSelfAdjointExtension
      (nsFullFockHam nu lam mu gg) (fun x => by
        refine ⟨nsFockCore_le_friedDom nu lam mu gg x.2, ?_⟩
        refine lp.ext (funext fun n => ?_)
        rw [nsOuterN_apply, nsFried_op_core nu lam mu gg n ⟨(x : nsFockSpace) n, x.2.2 n⟩]
        exact (dsOp_coe (fun n : ℕ => nsSectorHam nu lam mu gg n) x n).symm)
