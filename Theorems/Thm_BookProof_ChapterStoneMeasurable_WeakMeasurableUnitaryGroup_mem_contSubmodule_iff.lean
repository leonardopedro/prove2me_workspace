-- Generated from ChapterStoneMeasurable.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.mem_contSubmodule_iff
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable


open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable (G : WeakMeasurableUnitaryGroup H)

theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.mem_contSubmodule_iff (v : H) :
    v ∈ G.contSubmodule ↔ Tendsto (fun s : ℝ => G.U s v) (𝓝 0) (𝓝 v) := by sorry
