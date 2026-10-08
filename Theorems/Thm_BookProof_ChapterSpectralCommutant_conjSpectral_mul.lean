-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.conjSpectral_mul
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
open BookProof.ChapterSpectralCommutant


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
  (hcyc : DenseRange (cfcVec T hT xi))

theorem BookProof.ChapterSpectralCommutant.conjSpectral_mul
    (A B : Lp ℂ 2 (spectralMeasure T hT xi) →L[ℂ] Lp ℂ 2 (spectralMeasure T hT xi)) :
    conjSpectral T hT xi hcyc (A * B)
      = conjSpectral T hT xi hcyc A * conjSpectral T hT xi hcyc B := by sorry
