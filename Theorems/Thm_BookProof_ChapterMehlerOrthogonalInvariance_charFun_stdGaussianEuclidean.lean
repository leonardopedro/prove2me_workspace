-- Generated from ChapterMehlerOrthogonalInvariance.lean — theorem BookProof.ChapterMehlerOrthogonalInvariance.charFun_stdGaussianEuclidean
import Definitions.Def_ChapterSolovayCoordinates
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
open BookProof.ChapterMehlerOrthogonalInvariance


open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterMehlerOrthogonalInvariance.charFun_stdGaussianEuclidean (k : ℕ) (t : EuclideanSpace ℝ (Fin k)) :
    charFun (stdGaussianEuclidean k) t = Complex.exp (-(‖t‖ ^ 2 : ℝ) / 2) := by sorry
