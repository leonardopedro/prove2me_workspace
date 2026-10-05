-- Generated from ChapterMehlerOrthogonalInvariance.lean — solution of BookProof.ChapterMehlerOrthogonalInvariance.charFun_stdGaussianEuclidean
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
open BookProof.ChapterMehlerOrthogonalInvariance



open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (t : EuclideanSpace ℝ (Fin k)) :
    charFun (stdGaussianEuclidean k) t = Complex.exp (-(‖t‖ ^ 2 : ℝ) / 2) := by

  rw [stdGaussianEuclidean, gaussianHead, charFun_pi]
  simp only [standardGaussian, charFun_gaussianReal]
  rw [← Complex.exp_sum]
  congr 1
  have h : ‖t‖ ^ 2 = ∑ i, (t i) ^ 2 := by
    rw [EuclideanSpace.norm_eq, Real.sq_sqrt (by positivity)]
    simp [sq_abs]
  rw [h]
  push_cast
  simp [Finset.sum_div, neg_div]
