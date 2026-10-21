-- Generated from ChapterMehlerOrthogonalInvariance.lean — solution of BookProof.ChapterMehlerOrthogonalInvariance.measurePreserving_headRotation
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
import Theorems.Thm_BookProof_ChapterMehlerOrthogonalInvariance_measurable_headRotation
import Theorems.Thm_BookProof_ChapterMehlerOrthogonalInvariance_coordinateTailMeasure_map_headRotation
open BookProof.ChapterMehlerOrthogonalInvariance



open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

set_option maxHeartbeats 1000000 in
theorem solution {k : ℕ} (O : Matrix (Fin k) (Fin k) ℝ)
    (hO : Oᵀ * O = 1) :
    MeasurePreserving (headRotation k O) coordinateTailMeasure coordinateTailMeasure := ⟨measurable_headRotation k O, coordinateTailMeasure_map_headRotation O hO⟩
