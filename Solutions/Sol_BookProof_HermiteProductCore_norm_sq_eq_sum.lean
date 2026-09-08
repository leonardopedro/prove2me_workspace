-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.norm_sq_eq_sum
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (x : Vd d) : ‖x‖ ^ 2 = ∑ i, (x i) ^ 2 := by

  rw [EuclideanSpace.norm_eq, Real.sq_sqrt (Finset.sum_nonneg fun i _ => by positivity)]
  exact Finset.sum_congr rfl fun i _ => by rw [Real.norm_eq_abs, sq_abs]
