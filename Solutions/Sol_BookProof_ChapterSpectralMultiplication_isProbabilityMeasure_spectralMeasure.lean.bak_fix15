-- Generated from ChapterSpectralMultiplication.lean — solution of BookProof.ChapterSpectralMultiplication.isProbabilityMeasure_spectralMeasure
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_vectorState_one
import Theorems.Thm_BookProof_ChapterAbelianGelfandModel_isProbabilityMeasure_stateMeasure
open BookProof.ChapterSpectralMultiplication



open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)

set_option maxHeartbeats 1000000 in
theorem solution (hxi : ‖xi‖ = 1) :
    IsProbabilityMeasure (spectralMeasure T hT xi) := isProbabilityMeasure_stateMeasure _ _ (vectorState_one T hT xi hxi)
