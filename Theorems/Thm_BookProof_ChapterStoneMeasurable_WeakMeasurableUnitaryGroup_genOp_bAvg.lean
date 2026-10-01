-- Generated from ChapterStoneConverse.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.genOp_bAvg
import Mathlib
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable [CompleteSpace H] [TopologicalSpace.SeparableSpace H]
variable (G : WeakMeasurableUnitaryGroup H)


open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.genOp_bAvg (x : H) (a : ℝ) :
    G.genOp ⟨G.bAvg x a, G.bAvg_mem_genDomain x a⟩ = Complex.I • (G.U a x - x) := by sorry
