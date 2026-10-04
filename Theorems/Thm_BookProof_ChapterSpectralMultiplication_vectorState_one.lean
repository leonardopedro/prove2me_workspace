-- Generated from ChapterSpectralMultiplication.lean — theorem BookProof.ChapterSpectralMultiplication.vectorState_one
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterA4
open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)


open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel


theorem BookProof.ChapterSpectralMultiplication.vectorState_one (hxi : ‖xi‖ = 1) : vectorState T hT xi 1 = 1 := by sorry
