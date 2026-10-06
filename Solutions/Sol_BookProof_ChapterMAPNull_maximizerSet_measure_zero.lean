-- Generated from ChapterMAPNull.lean — solution of BookProof.ChapterMAPNull.maximizerSet_measure_zero
import Mathlib
import Definitions.Def_ChapterMAPNull
import Theorems.Thm_BookProof_ChapterMAPNull_countable_map_set_measure_zero
open BookProof.ChapterMAPNull



open MeasureTheory


variable {α : Type*} [MeasurableSpace α]

variable {α : Type*} [MeasurableSpace α]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure α) [NullSingletonClass μ]
    (score : α → ℝ) (hcountable : (maximizerSet score).Countable) :
    μ (maximizerSet score) = 0 := by

  convert countable_map_set_measure_zero μ ( maximizerSet score ) hcountable
