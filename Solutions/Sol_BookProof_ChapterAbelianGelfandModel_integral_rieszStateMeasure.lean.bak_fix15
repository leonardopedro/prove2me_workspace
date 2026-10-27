-- Generated from ChapterAbelianGelfandModel.lean — solution of BookProof.ChapterAbelianGelfandModel.integral_rieszStateMeasure
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel
open BookProof.ChapterAbelianGelfandModel



open MeasureTheory Complex WeakDual CompactlySupported CompactlySupportedContinuousMap
open scoped ComplexOrder


open BookProof.ChapterLinftyMultiplication

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (L : C(X, ℝ) →ₗ[ℝ] ℝ)
    (hL : ∀ f : C(X, ℝ), 0 ≤ f → 0 ≤ L f) (f : C(X, ℝ)) :
    ∫ x, f x ∂(rieszStateMeasure L hL) = L f := by

  have h := RealRMK.integral_rieszMeasure (positiveCcMap L hL)
    (CompactlySupportedContinuousMap.continuousMapEquiv f)
  have hΛ : positiveCcMap L hL (CompactlySupportedContinuousMap.continuousMapEquiv f) = L f :=
    rfl
  rw [rieszStateMeasure]
  exact hΛ ▸ h
