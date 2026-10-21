-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.redParcelHam_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_parcelPi_symmetricOn
import Theorems.Thm_BookProof_NsOneBody_parcelField_symmetricOn
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_quadForm_nonneg
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {D : Submodule ℂ (L2d 6)}
variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n)
    (x : polyGaussCore (d := n * 6)) : 0 ≤ quadForm (redParcelHam nu k n p) x := weylOpDom_quadForm_nonneg (parcelPi_symmetricOn n p) (parcelField_symmetricOn nu k n p) x
