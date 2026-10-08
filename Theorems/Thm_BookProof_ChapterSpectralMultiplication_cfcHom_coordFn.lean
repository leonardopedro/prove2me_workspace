-- Generated from ChapterSpectralMultiplication.lean — theorem BookProof.ChapterSpectralMultiplication.cfcHom_coordFn
import Definitions.Def_ChapterAbelianGelfandModel
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
open BookProof.ChapterSpectralMultiplication


open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
variable (hcyc : DenseRange (cfcVec T hT xi))

theorem BookProof.ChapterSpectralMultiplication.cfcHom_coordFn : cfcHom hT (coordFn T) = T := by sorry
