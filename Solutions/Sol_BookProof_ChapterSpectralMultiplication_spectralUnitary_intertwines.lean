-- Generated from ChapterSpectralMultiplication.lean — solution of BookProof.ChapterSpectralMultiplication.spectralUnitary_intertwines
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_cfcHom_coordFn
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_spectralUnitary_intertwines_cfc
open BookProof.ChapterSpectralMultiplication



open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
variable (hcyc : DenseRange (cfcVec T hT xi))

set_option maxHeartbeats 1000000 in
theorem solution (u : Lp ℂ 2 (spectralMeasure T hT xi)) :
    spectralUnitary T hT xi hcyc (mulRep (spectralMeasure T hT xi) (coordFn T) u)
      = T (spectralUnitary T hT xi hcyc u) := by

  rw [spectralUnitary_intertwines_cfc T hT xi hcyc (coordFn T) u, cfcHom_coordFn]
