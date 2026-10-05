-- Generated from ChapterAbelianGelfandModel.lean — solution of BookProof.ChapterAbelianGelfandModel.oneVec_coeFn
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel
open BookProof.ChapterAbelianGelfandModel



open MeasureTheory Complex WeakDual CompactlySupported CompactlySupportedContinuousMap
open scoped ComplexOrder


open BookProof.ChapterLinftyMultiplication

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {X : Type*} [TopologicalSpace X]
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
  (psi : C(X, ℂ) →ₗ[ℂ] ℂ) (hpos : ∀ g : C(X, ℂ), 0 ≤ psi (star g * g))
variable {X : Type*} [MeasurableSpace X] (mu : Measure X)

set_option maxHeartbeats 1000000 in
theorem solution [IsFiniteMeasure mu] : (oneVec mu : X → ℂ) =ᵐ[mu] fun _ => (1 : ℂ) := MemLp.coeFn_toLp _
