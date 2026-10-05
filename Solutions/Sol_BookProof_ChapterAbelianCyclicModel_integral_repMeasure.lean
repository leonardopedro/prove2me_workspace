-- Generated from ChapterAbelianCyclicModel.lean — solution of BookProof.ChapterAbelianCyclicModel.integral_repMeasure
import Mathlib
import Definitions.Def_ChapterAbelianCyclicModel
import Theorems.Thm_BookProof_ChapterAbelianGelfandModel_integral_stateMeasure
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
theorem solution (f : C(X, ℂ)) :
    inner ℂ xi (pi f xi) = ∫ x, f x ∂(repMeasure pi xi) := integral_stateMeasure (repState pi xi) (repState_pos pi xi) f
