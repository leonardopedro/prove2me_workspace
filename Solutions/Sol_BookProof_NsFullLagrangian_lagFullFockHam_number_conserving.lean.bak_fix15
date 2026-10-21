-- Generated from ChapterNavierStokesFullLagrangianFock.lean — solution of BookProof.NsFullLagrangian.lagFullFockHam_number_conserving
import Mathlib
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Theorems.Thm_BookProof_Qg3DGaugeFL_dsOp_number_conserving
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
theorem solution (lam lam' mu gg : ℝ) (x : lagFockCore) {n : ℕ}
    (hx : ∀ m, m ≠ n → ((x : lagFockSpace) : ∀ m : ℕ, L2d (m * 36)) m = 0) (m : ℕ) (hm : m ≠ n) :
    ((lagFullFockHam lam lam' mu gg x : lagFockSpace) : ∀ m : ℕ, L2d (m * 36)) m = 0 := dsOp_number_conserving _ x hx m hm
