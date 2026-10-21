-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsFullFockHam_number_conserving
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_Qg3DGaugeFL_dsOp_number_conserving
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
theorem solution (nu lam mu gg : ℝ) (x : nsFockCore) {n : ℕ}
    (hx : ∀ m, m ≠ n → ((x : nsFockSpace) : ∀ m : ℕ, L2d (m * 21)) m = 0) (m : ℕ)
    (hm : m ≠ n) : ((nsFullFockHam nu lam mu gg x : nsFockSpace) : ∀ m : ℕ, L2d (m * 21)) m = 0 := dsOp_number_conserving _ x hx m hm
