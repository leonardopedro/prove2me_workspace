-- Generated from ChapterSpectralMultiplication.lean — solution of BookProof.ChapterSpectralMultiplication.integral_spectralMeasure
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
import Theorems.Thm_BookProof_ChapterAbelianGelfandModel_integral_stateMeasure
open BookProof.ChapterSpectralMultiplication



open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)

set_option maxHeartbeats 1000000 in
theorem solution (f : C(spectrum ℂ T, ℂ)) :
    inner ℂ xi (cfcHom hT f xi) = ∫ z, f z ∂(spectralMeasure T hT xi) := integral_stateMeasure (vectorState T hT xi) (vectorState_pos T hT xi) f
