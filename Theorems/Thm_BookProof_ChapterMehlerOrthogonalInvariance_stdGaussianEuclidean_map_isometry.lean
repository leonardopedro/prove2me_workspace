-- Generated from ChapterMehlerOrthogonalInvariance.lean — theorem BookProof.ChapterMehlerOrthogonalInvariance.stdGaussianEuclidean_map_isometry
import Definitions.Def_ChapterSolovayCoordinates
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
open BookProof.ChapterMehlerOrthogonalInvariance


open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterMehlerOrthogonalInvariance.stdGaussianEuclidean_map_isometry (k : ℕ)
    (L : EuclideanSpace ℝ (Fin k) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin k)) :
    (stdGaussianEuclidean k).map L = stdGaussianEuclidean k := by sorry
