-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.spFried_op_core
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_QgOuterFockFL_friedrichsComparison_extends
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {D : Submodule ℂ (L2d 6)}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (p : polyGaussCore (d := 6))
    (h : (p : L2d 6) ∈ (spFried nu k).dom) :
    (spFried nu k).op ⟨(p : L2d 6), h⟩ = spHam (coreRepPoly 6) nu k p := (friedrichsComparison_extends (spPosSym nu k) polyGaussCore_dense p).choose_spec
