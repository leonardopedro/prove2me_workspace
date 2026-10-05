-- Generated from ChapterNavierStokesFullLagrangianFock.lean — solution of BookProof.NsFullLagrangian.polyGaussCore_le_lagFriedDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Theorems.Thm_BookProof_QgOuterFockFL_friedrichsComparison_extends
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
theorem solution (lam lam' mu gg : ℝ) (n : ℕ) :
    (polyGaussCore (d := n * 36)) ≤ (lagFried lam lam' mu gg n).dom :=
  fun v hv =>
    (friedrichsComparison_extends (lagPosSym lam lam' mu gg n) polyGaussCore_dense ⟨v, hv⟩).choose
