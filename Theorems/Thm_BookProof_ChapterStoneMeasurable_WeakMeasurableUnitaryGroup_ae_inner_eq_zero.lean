-- Generated from ChapterStoneMeasurable.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.ae_inner_eq_zero
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)


open scoped InnerProductSpace
open Filter Topology MeasureTheory



theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.ae_inner_eq_zero (z x : H)
    (h : ∀ a : ℝ, (∫ t in (0:ℝ)..a, ⟪ z, G.U t x ⟫_ℂ) = 0) :
    ∀ᵐ t : ℝ, ⟪ z, G.U t x ⟫_ℂ = 0 := by sorry
