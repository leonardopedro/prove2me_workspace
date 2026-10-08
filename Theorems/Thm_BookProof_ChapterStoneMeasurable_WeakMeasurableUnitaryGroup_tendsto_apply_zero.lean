-- Generated from ChapterStoneMeasurable.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.tendsto_apply_zero
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterWignerSymmetry
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable


open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable (G : WeakMeasurableUnitaryGroup H)

theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.tendsto_apply_zero [CompleteSpace H] [TopologicalSpace.SeparableSpace H] (x : H) :
    Tendsto (fun s : ℝ => G.U s x) (𝓝 0) (𝓝 x) := by sorry
