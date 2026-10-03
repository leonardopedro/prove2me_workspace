-- Generated from ChapterAbelianGelfandModel.lean — theorem BookProof.ChapterAbelianGelfandModel.isProbabilityMeasure_rieszStateMeasure
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterA4

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]


open MeasureTheory Complex WeakDual CompactlySupported CompactlySupportedContinuousMap
open scoped ComplexOrder


open BookProof.ChapterLinftyMultiplication

theorem BookProof.ChapterAbelianGelfandModel.isProbabilityMeasure_rieszStateMeasure (L : C(X, ℝ) →ₗ[ℝ] ℝ)
    (hL : ∀ f : C(X, ℝ), 0 ≤ f → 0 ≤ L f) (hone : L 1 = 1) :
    IsProbabilityMeasure (rieszStateMeasure L hL) := by sorry
