-- Generated from ChapterSpectralMultiplication.lean — theorem BookProof.ChapterSpectralMultiplication.mulRep_toLp
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

theorem BookProof.ChapterSpectralMultiplication.mulRep_toLp (g f : C(spectrum ℂ T, ℂ)) :
    mulRep (spectralMeasure T hT xi) g
        (ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ f)
      = ContinuousMap.toLp 2 (spectralMeasure T hT xi) ℂ (g * f) := by sorry
