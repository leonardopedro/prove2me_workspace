-- Generated from ChapterSpectralMultiplication.lean — theorem BookProof.ChapterSpectralMultiplication.mulRep_toLp
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterA4
open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
variable (hcyc : DenseRange (cfcVec T hT xi))


open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel


theorem BookProof.ChapterSpectralMultiplication.mulRep_toLp (g f : C(spectrum ℂ T, ℂ)) :
    mulRep (spectralMeasure T hT xi) g
        (ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ f)
      = ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ (g * f) := by sorry
