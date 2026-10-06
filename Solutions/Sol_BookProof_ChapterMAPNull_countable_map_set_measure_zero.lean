-- Generated from ChapterMAPNull.lean — solution of BookProof.ChapterMAPNull.countable_map_set_measure_zero
import Mathlib
import Definitions.Def_ChapterMAPNull
open BookProof.ChapterMAPNull



open MeasureTheory


variable {α : Type*} [MeasurableSpace α]

variable {α : Type*} [MeasurableSpace α]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure α) [NullSingletonClass μ]
    (maximizers : Set α) (hcountable : maximizers.Countable) :
    μ maximizers = 0 := by

  exact hcountable.measure_zero μ
