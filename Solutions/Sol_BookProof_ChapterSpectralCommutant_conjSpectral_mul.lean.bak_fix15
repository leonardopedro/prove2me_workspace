-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.conjSpectral_mul
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

set_option maxHeartbeats 1000000 in
theorem solution
    (A B : Lp ℂ 2 (spectralMeasure T hT xi) →L[ℂ] Lp ℂ 2 (spectralMeasure T hT xi)) :
    conjSpectral T hT xi hcyc (A * B)
      = conjSpectral T hT xi hcyc A * conjSpectral T hT xi hcyc B := by

  refine ContinuousLinearMap.ext fun v => ?_
  simp [ContinuousLinearMap.mul_apply]
