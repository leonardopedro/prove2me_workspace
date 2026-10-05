-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsRedFullFockHam_number_conserving
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_Qg3DGaugeFL_dsOp_number_conserving
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (x : nsRedFockCore)
    {n : ℕ} (hx : ∀ m, m ≠ n → ((x : nsRedFockSpace) : ∀ m : ℕ, L2d (m * 6)) m = 0)
    (m : ℕ) (hm : m ≠ n) :
    ((nsRedFullFockHam nu k x : nsRedFockSpace) : ∀ m : ℕ, L2d (m * 6)) m = 0 := BookProof.Qg3DGaugeFL.dsOp_number_conserving _ x hx m hm
