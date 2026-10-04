-- Generated from ChapterMehlerOrthogonalInvariance.lean — theorem BookProof.ChapterMehlerOrthogonalInvariance.measurePreserving_headRotation
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
import Definitions.Def_ChapterA4
open BookProof.ChapterMehlerOrthogonalInvariance


open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterMehlerOrthogonalInvariance.measurePreserving_headRotation {k : ℕ} (O : Matrix (Fin k) (Fin k) ℝ)
    (hO : Oᵀ * O = 1) :
    MeasurePreserving (headRotation k O) coordinateTailMeasure coordinateTailMeasure := by sorry
