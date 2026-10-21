-- Generated from ChapterAbelianGelfandModel.lean — solution of BookProof.ChapterAbelianGelfandModel.mulRepHom_injective
import Mathlib
import Definitions.Def_ChapterAbelianGelfandModel
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_eq_zero_iff
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
variable {X : Type*} [TopologicalSpace X] [CompactSpace X]
  [MeasurableSpace X] [BorelSpace X] (mu : Measure X)

set_option maxHeartbeats 1000000 in
theorem solution [IsFiniteMeasure mu] [mu.IsOpenPosMeasure] [T2Space X] :
    Function.Injective (mulRepHom mu) := by

  rw [injective_iff_map_eq_zero]
  intro f hf
  have h0 : multOp (fun x => f x) (contMemLpTop mu f) = 0 := hf
  have hae : (fun x => f x) =ᵐ[mu] (0 : X → ℂ) :=
    (multOp_eq_zero_iff (μ := mu) (fun x => f x) (contMemLpTop mu f)).mp h0
  have hz : (fun x => f x) = fun _ : X => (0 : ℂ) :=
    (Continuous.ae_eq_iff_eq mu (map_continuous f) continuous_const).mp hae
  ext x
  simpa using congrFun hz x
