-- Generated from ChapterSpectralMultiplication.lean — theorem BookProof.ChapterSpectralMultiplication.isProbabilityMeasure_spectralMeasure
import Definitions.Def_ChapterAbelianGelfandModel
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)


open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel


theorem BookProof.ChapterSpectralMultiplication.isProbabilityMeasure_spectralMeasure (hxi : ‖xi‖ = 1) :
    IsProbabilityMeasure (spectralMeasure T hT xi) := by sorry
