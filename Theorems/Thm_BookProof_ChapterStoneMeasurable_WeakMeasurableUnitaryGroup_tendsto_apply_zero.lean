-- Generated from ChapterStoneMeasurable.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.tendsto_apply_zero
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterWignerSymmetry
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)


open scoped InnerProductSpace
open Filter Topology MeasureTheory



## Von Neumann's theorem: weak measurability implies strong continuity -/

theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.tendsto_apply_zero [CompleteSpace H] [TopologicalSpace.Separabl := by sorry
