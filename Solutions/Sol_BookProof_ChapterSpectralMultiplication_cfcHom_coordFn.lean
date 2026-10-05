-- Generated from ChapterSpectralMultiplication.lean — solution of BookProof.ChapterSpectralMultiplication.cfcHom_coordFn
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
open BookProof.ChapterSpectralMultiplication



open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
variable (hcyc : DenseRange (cfcVec T hT xi))

set_option maxHeartbeats 1000000 in
theorem solution : cfcHom hT (coordFn T) = T := cfcHom_id hT
