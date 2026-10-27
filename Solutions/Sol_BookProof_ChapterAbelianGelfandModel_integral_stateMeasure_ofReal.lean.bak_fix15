-- Generated from ChapterAbelianGelfandModel.lean — solution of BookProof.ChapterAbelianGelfandModel.integral_stateMeasure_ofReal
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel
import Theorems.Thm_BookProof_ChapterAbelianGelfandModel_integral_rieszStateMeasure
import Theorems.Thm_BookProof_ChapterAbelianGelfandModel_realPartFunctional_ofReal
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

set_option maxHeartbeats 1000000 in
theorem solution (f : C(X, ℝ)) :
    psi (toC f) = ∫ x, (toC f) x ∂(stateMeasure psi hpos) := by

  set L := realPartFunctional psi with hL
  have h1 : psi (toC f) = (L f : ℂ) := realPartFunctional_ofReal psi hpos f
  have h2 : ∫ x, f x ∂(stateMeasure psi hpos) = L f :=
    integral_rieszStateMeasure _ _ f
  have h3 : ∫ x, (toC f) x ∂(stateMeasure psi hpos)
      = ((∫ x, f x ∂(stateMeasure psi hpos) : ℝ) : ℂ) := by
    simpa using integral_ofReal (μ := stateMeasure psi hpos) (f := fun x => f x) (𝕜 := ℂ)
  rw [h1, h3, h2]
