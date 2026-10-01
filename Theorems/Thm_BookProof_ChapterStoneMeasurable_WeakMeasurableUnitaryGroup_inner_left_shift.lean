-- Generated from ChapterStoneMeasurable.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.inner_left_shift
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)


open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.inner_left_shift (s t : ℝ) (x y : H) :
    ⟪ y, G.U s (G.U t x) ⟫_ℂ = ⟪ G.U (-s) y, G.U t x ⟫_ℂ := by sorry
