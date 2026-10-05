-- Generated from ChapterF3.lean — solution of BookProof.ChapterF3.disjoint_support_inner_zero
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3



open scoped BigOperators
open Polynomial


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} [MeasurableSpace α] (μ : MeasureTheory.Measure α)
    (f g : α → ℂ) (h : Disjoint (Function.support f) (Function.support g)) :
    ∫ x, (starRingEnd ℂ) (f x) * g x ∂μ = 0 := by

  convert MeasureTheory.integral_eq_zero_of_ae ( Filter.Eventually.of_forall fun x => ?_ );
  by_cases hx : f x = 0 <;> by_cases hx' : g x = 0 <;> simp_all [ Set.disjoint_left ]
