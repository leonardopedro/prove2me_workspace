-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.redFried_op_core
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_QgOuterFockFL_friedrichsComparison_extends
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : polyGaussCore (d := n * 6))
    (h : (p : L2d (n * 6)) ∈ (redFried nu k n).dom) :
    (redFried nu k n).op ⟨(p : L2d (n * 6)), h⟩ = redHam nu k n p := (friedrichsComparison_extends (redPosSym nu k n) polyGaussCore_dense p).choose_spec
