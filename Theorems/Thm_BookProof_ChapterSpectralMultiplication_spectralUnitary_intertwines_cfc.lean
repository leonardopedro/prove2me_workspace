-- Generated from ChapterSpectralMultiplication.lean — theorem BookProof.ChapterSpectralMultiplication.spectralUnitary_intertwines_cfc
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


theorem BookProof.ChapterSpectralMultiplication.spectralUnitary_intertwines_cfc (g : C(spectrum ℂ T, ℂ))
    (u : Lp ℂ 2 (spectralMeasure T hT xi)) :
    spectralUnitary T hT xi hcyc (mulRep (spectralMeasure T hT xi) g u)
      = cfcHom hT g (spectralUnitary T hT xi hcyc u) := by sorry
