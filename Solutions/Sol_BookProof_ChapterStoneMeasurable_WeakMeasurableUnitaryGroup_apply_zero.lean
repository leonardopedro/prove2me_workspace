-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.apply_zero
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution (x : H) : G.U 0 x = x := by
 rw [G.map_zero]; rfl
