-- Generated from ChapterMehlerOrthogonalInvariance.lean — theorem BookProof.ChapterMehlerOrthogonalInvariance.measurable_headRotation
import Definitions.Def_ChapterSolovayCoordinates
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
open BookProof.ChapterMehlerOrthogonalInvariance


open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterMehlerOrthogonalInvariance.measurable_headRotation (k : ℕ) (O : Matrix (Fin k) (Fin k) ℝ) :
    Measurable (headRotation k O) := by sorry
