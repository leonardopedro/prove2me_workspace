-- Generated from ChapterAbelianGelfandModel.lean — theorem BookProof.ChapterAbelianGelfandModel.mulRepHom_injective
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterAbelianGelfandModel

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

theorem BookProof.ChapterAbelianGelfandModel.mulRepHom_injective [IsFiniteMeasure mu] [mu.IsOpenPosMeasure] [T2Space X] :
    Function.Injective (mulRepHom mu) := by sorry
