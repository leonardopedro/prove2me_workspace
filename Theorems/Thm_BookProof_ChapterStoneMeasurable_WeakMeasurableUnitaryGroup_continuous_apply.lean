-- Generated from ChapterStoneMeasurable.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.continuous_apply
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)


open scoped InnerProductSpace
open Filter Topology MeasureTheory



theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.continuous_apply [CompleteSpace H] [TopologicalSpace.SeparableSpace H] (x : H) :
    Continuous fun t : ℝ => G.U t x := by sorry
