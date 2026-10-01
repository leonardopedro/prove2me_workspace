-- Generated from ChapterStoneMeasurable.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.surjective
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)


open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.surjective (t : ℝ) : Function.Surjective (G.U t) := by sorry
