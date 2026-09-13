-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.gaussWD_eq_prod
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_norm_sq_eq_sum
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (x : Vd d) : gaussWD x = ∏ i, Real.exp (-(x i) ^ 2 / 2) := by

  rw [gaussWD, norm_sq_eq_sum, ← Real.exp_sum]
  congr 1
  rw [neg_div, Finset.sum_div, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun i _ => by ring
