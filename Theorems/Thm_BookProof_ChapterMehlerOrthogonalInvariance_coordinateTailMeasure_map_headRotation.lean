-- Generated from ChapterMehlerOrthogonalInvariance.lean — theorem BookProof.ChapterMehlerOrthogonalInvariance.coordinateTailMeasure_map_headRotation
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
import Definitions.Def_ChapterA4
open BookProof.ChapterMehlerOrthogonalInvariance


open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterMehlerOrthogonalInvariance.coordinateTailMeasure_map_headRotation {k : ℕ} (O : Matrix (Fin k) (Fin k) ℝ)
    (hO : Oᵀ * O = 1) :
    coordinateTailMeasure.map (headRotation k O) = coordinateTailMeasure := by sorry
