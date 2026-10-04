-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.mulRep_mem_multAlgebra
import Definitions.Def_ChapterLinftyMaximalAbelian
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterA4
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterSpectralCommutant

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
  (hcyc : DenseRange (cfcVec T hT xi))


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

theorem BookProof.ChapterSpectralCommutant.mulRep_mem_multAlgebra (g : C(spectrum ℂ T, ℂ)) :
    mulRep (spectralMeasure T hT xi) g ∈ multAlgebra (spectralMeasure T hT xi) := by sorry
