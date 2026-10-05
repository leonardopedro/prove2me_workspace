-- Generated from ChapterAbelianCyclicModel.lean — solution of BookProof.ChapterAbelianCyclicModel.isProbabilityMeasure_repMeasure
import Mathlib
import Definitions.Def_ChapterAbelianCyclicModel
import Theorems.Thm_BookProof_ChapterAbelianCyclicModel_repState_one
import Theorems.Thm_BookProof_ChapterAbelianGelfandModel_isProbabilityMeasure_stateMeasure
open BookProof.ChapterAbelianCyclicModel



open MeasureTheory Complex WeakDual
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel


variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)

set_option maxHeartbeats 1000000 in
theorem solution (hxi : ‖xi‖ = 1) :
    IsProbabilityMeasure (repMeasure pi xi) := isProbabilityMeasure_stateMeasure _ _ (repState_one pi xi hxi)
