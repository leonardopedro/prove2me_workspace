-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.redHam_eq_sum_parcel
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_redHamDom_eq_sum_parcel
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
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) :
    redHam nu k n = ∑ p : Fin n, redParcelHam nu k n p := by

  refine LinearMap.ext fun x => ?_
  rw [LinearMap.sum_apply]
  change ((weylOpDom (redPiN n) (redFieldN nu k n) x : polyGaussCore (d := n * 6)) : L2d (n * 6))
      = ∑ p : Fin n, ((weylOpDom (parcelPi n p) (parcelField nu k n p) x :
          polyGaussCore (d := n * 6)) : L2d (n * 6))
  rw [redHamDom_eq_sum_parcel, LinearMap.sum_apply, Submodule.coe_sum]
