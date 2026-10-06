-- Generated from ChapterMAPNull.lean — solution of BookProof.ChapterMAPNull.map_point_measure_zero
import Mathlib
import Definitions.Def_ChapterMAPNull
open BookProof.ChapterMAPNull



open MeasureTheory


variable {α : Type*} [MeasurableSpace α]

variable {α : Type*} [MeasurableSpace α]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure α) [NullSingletonClass μ] (mapPoint : α) :
    μ {mapPoint} = 0 := by

  exact measure_singleton mapPoint
