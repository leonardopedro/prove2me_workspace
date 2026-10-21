-- Generated from ChapterAbelianGelfandModel.lean — solution of BookProof.ChapterAbelianGelfandModel.isProbabilityMeasure_rieszStateMeasure
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel
import Theorems.Thm_BookProof_ChapterAbelianGelfandModel_integral_rieszStateMeasure
open BookProof.ChapterAbelianGelfandModel



open MeasureTheory Complex WeakDual CompactlySupported CompactlySupportedContinuousMap
open scoped ComplexOrder


open BookProof.ChapterLinftyMultiplication

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (L : C(X, ℝ) →ₗ[ℝ] ℝ)
    (hL : ∀ f : C(X, ℝ), 0 ≤ f → 0 ≤ L f) (hone : L 1 = 1) :
    IsProbabilityMeasure (rieszStateMeasure L hL) := by

  constructor
  have h : ∫ _x : X, (1 : ℝ) ∂(rieszStateMeasure L hL) = 1 := by
    have h1 := integral_rieszStateMeasure L hL 1
    simpa [hone] using h1
  have h' : ((rieszStateMeasure L hL) Set.univ).toReal = 1 := by
    have h2 : (rieszStateMeasure L hL).real Set.univ = 1 := by
      rw [← h, integral_const]
      simp
    simpa [Measure.real] using h2
  exact (ENNReal.toReal_eq_one_iff _).mp h'
