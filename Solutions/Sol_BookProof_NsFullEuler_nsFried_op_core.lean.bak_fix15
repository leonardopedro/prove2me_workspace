-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsFried_op_core
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_QgOuterFockFL_friedrichsComparison_extends
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
theorem solution (nu lam mu gg : ℝ) (n : ℕ) (p : polyGaussCore (d := n * 21))
    (h : (p : L2d (n * 21)) ∈ (nsFried nu lam mu gg n).dom) :
    (nsFried nu lam mu gg n).op ⟨(p : L2d (n * 21)), h⟩ = nsSectorHam nu lam mu gg n p := (friedrichsComparison_extends (nsPosSym nu lam mu gg n) polyGaussCore_dense p).choose_spec
