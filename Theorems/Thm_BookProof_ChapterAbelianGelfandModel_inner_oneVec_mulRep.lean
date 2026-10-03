-- Generated from ChapterAbelianGelfandModel.lean — theorem BookProof.ChapterAbelianGelfandModel.inner_oneVec_mulRep
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterA4

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {X : Type*} [TopologicalSpace X]
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
  (psi : C(X, ℂ) →ₗ[ℂ] ℂ) (hpos : ∀ g : C(X, ℂ), 0 ≤ psi (star g * g))
variable {X : Type*} [MeasurableSpace X] (mu : Measure X)
variable {X : Type*} [TopologicalSpace X] [CompactSpace X]
  [MeasurableSpace X] [BorelSpace X] (mu : Measure X)


open MeasureTheory Complex WeakDual CompactlySupported CompactlySupportedContinuousMap
open scoped ComplexOrder


open BookProof.ChapterLinftyMultiplication

theorem BookProof.ChapterAbelianGelfandModel.inner_oneVec_mulRep [IsFiniteMeasure mu] (f : C(X, ℂ)) :
    inner ℂ (oneVec mu) (mulRep mu f (oneVec mu)) = ∫ x, f x ∂mu := by sorry
