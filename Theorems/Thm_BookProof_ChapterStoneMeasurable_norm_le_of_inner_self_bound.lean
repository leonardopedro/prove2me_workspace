-- Generated from ChapterStoneMeasurable.lean — theorem BookProof.ChapterStoneMeasurable.norm_le_of_inner_self_bound
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable


open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


theorem BookProof.ChapterStoneMeasurable.norm_le_of_inner_self_bound {y : H} {C : ℝ} (hC : 0 ≤ C)
    (h : ‖⟪y, y⟫_ℂ‖ ≤ C * ‖y‖) : ‖y‖ ≤ C := by sorry
