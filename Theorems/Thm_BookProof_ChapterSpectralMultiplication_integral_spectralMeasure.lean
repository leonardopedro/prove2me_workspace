-- Generated from ChapterSpectralMultiplication.lean — theorem BookProof.ChapterSpectralMultiplication.integral_spectralMeasure
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterA4
open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)


open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel


theorem BookProof.ChapterSpectralMultiplication.integral_spectralMeasure (f : C(spectrum ℂ T, ℂ)) :
    inner ℂ xi (cfcHom hT f xi) = ∫ z, f z ∂(spectralMeasure T hT xi) := by sorry
