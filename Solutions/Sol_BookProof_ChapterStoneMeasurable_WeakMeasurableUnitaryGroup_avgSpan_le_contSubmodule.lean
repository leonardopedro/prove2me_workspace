-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.avgSpan_le_contSubmodule
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_tendsto_apply_avgVec
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] : G.avgSpan ≤ G.contSubmodule := by

  refine Submodule.span_le.mpr ?_
  rintro v ⟨x, a, rfl⟩
  exact G.tendsto_apply_avgVec x a
