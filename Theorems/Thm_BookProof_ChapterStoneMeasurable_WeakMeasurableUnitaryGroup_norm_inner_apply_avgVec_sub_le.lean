-- Generated from ChapterStoneMeasurable.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.norm_inner_apply_avgVec_sub_le
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)


open scoped InnerProductSpace
open Filter Topology MeasureTheory



theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.norm_inner_apply_avgVec_sub_le [CompleteSpace H] (s a : ℝ) (x y : H) :
    ‖⟪ y, G.U s (G.avgVec x a) - G.avgVec x a ⟫_ℂ‖ ≤ 2 * |s| * ‖x‖ * ‖y‖ := by sorry
