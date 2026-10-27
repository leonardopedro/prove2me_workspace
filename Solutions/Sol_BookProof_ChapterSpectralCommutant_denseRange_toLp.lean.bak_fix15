-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.denseRange_toLp
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

set_option maxHeartbeats 1000000 in
theorem solution :
    DenseRange (fun g : C(X, ℂ) => ContinuousMap.toLp 2 mu ℂ g) := ContinuousMap.toLp_denseRange (μ := mu) ℂ (p := 2) ℂ (by simp)
