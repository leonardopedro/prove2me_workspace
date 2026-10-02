-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.dense_avgSpan
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_avgSpan_orthogonal_eq_bot
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] [TopologicalSpace.SeparableSpace H] :
    Dense (G.avgSpan : Set H) := by

  have h : G.avgSpan.topologicalClosure = ⊤ :=
    Submodule.topologicalClosure_eq_top_iff.mpr G.avgSpan_orthogonal_eq_bot
  rw [dense_iff_closure_eq]
  have := congrArg (fun K : Submodule ℂ H => (K : Set H)) h
  have h2 : (G.avgSpan.topologicalClosure : Set H
