-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.ymFockHam_number_conserving
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Theorems.Thm_BookProof_Qg3DGaugeFL_dsOp_number_conserving
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (x : ymFockCore)
    {n : ℕ} (hx : ∀ m, m ≠ n → ((x : ymFockSpace) : ∀ m : ℕ, L2d (m * 99)) m = 0) (m : ℕ)
    (hm : m ≠ n) : ((ymFockHam fabc x : ymFockSpace) : ∀ m : ℕ, L2d (m * 99)) m = 0 := dsOp_number_conserving _ x hx m hm
