-- Generated from ChapterStoneMeasurable.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.inner_adjoint
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable


open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable (G : WeakMeasurableUnitaryGroup H)

theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.inner_adjoint (s : ℝ) (y v : H) : ⟪ y, G.U s v ⟫_ℂ = ⟪ G.U (-s) y, v ⟫_ℂ := by sorry
