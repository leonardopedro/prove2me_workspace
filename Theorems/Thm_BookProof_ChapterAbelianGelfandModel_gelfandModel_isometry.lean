-- Generated from ChapterAbelianGelfandModel.lean — theorem BookProof.ChapterAbelianGelfandModel.gelfandModel_isometry
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
variable (A : Type*) [CommCStarAlgebra A]


open MeasureTheory Complex WeakDual CompactlySupported CompactlySupportedContinuousMap
open scoped ComplexOrder


open BookProof.ChapterLinftyMultiplication

theorem BookProof.ChapterAbelianGelfandModel.gelfandModel_isometry : Isometry (gelfandModel A) := by sorry
