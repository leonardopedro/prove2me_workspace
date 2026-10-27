-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.redHamDom_eq_sum_parcel
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_redPiN_parcel
import Theorems.Thm_BookProof_NsOneBody_redFieldN_parcel
import Theorems.Thm_BookProof_NsOneBody_weylOpDom_block_sum
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
    weylOpDom (redPiN n) (redFieldN nu k n)
      = ∑ p : Fin n, weylOpDom (parcelPi n p) (parcelField nu k n p) := by

  rw [weylOpDom_block_sum (a := n) (b := 6) (c := 7)]
  refine Finset.sum_congr rfl fun p _ => ?_
  simp only [redPiN_parcel, redFieldN_parcel]
