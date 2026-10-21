-- Generated from ChapterMehlerOrthogonalInvariance.lean — solution of BookProof.ChapterMehlerOrthogonalInvariance.stdGaussianEuclidean_map_isometry
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
import Theorems.Thm_BookProof_ChapterMehlerOrthogonalInvariance_charFun_map_isometryEquiv
import Theorems.Thm_BookProof_ChapterMehlerOrthogonalInvariance_charFun_stdGaussianEuclidean
open BookProof.ChapterMehlerOrthogonalInvariance



open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ)
    (L : EuclideanSpace ℝ (Fin k) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin k)) :
    (stdGaussianEuclidean k).map L = stdGaussianEuclidean k := by

  refine Measure.ext_of_charFun (funext fun t => ?_)
  rw [charFun_map_isometryEquiv, charFun_stdGaussianEuclidean,
    charFun_stdGaussianEuclidean, L.symm.norm_map]
