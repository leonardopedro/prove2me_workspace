-- Generated from ChapterF3.lean — theorem BookProof.ChapterF3.disjoint_support_inner_zero
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3


open scoped BigOperators
open Polynomial


noncomputable section

theorem BookProof.ChapterF3.disjoint_support_inner_zero {α : Type*} [MeasurableSpace α] (μ : MeasureTheory.Measure α)
    (f g : α → ℂ) (h : Disjoint (Function.support f) (Function.support g)) :
    ∫ x, (starRingEnd ℂ) (f x) * g x ∂μ = 0 := by sorry
