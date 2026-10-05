-- Generated from ChapterAbelianCyclicModel.lean — solution of BookProof.ChapterAbelianCyclicModel.repState_one
import Mathlib
import Definitions.Def_ChapterAbelianCyclicModel
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
omit [T2Space X] [MeasurableSpace X] [BorelSpace X] in
theorem solution (hxi : ‖xi‖ = 1) : repState pi xi 1 = 1 := by

  simp only [repState_apply, map_one]
  simp [inner_self_eq_norm_sq_to_K, hxi]
