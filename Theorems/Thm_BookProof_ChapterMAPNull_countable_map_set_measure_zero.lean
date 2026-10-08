-- Generated from ChapterMAPNull.lean — theorem BookProof.ChapterMAPNull.countable_map_set_measure_zero
import Mathlib
import Definitions.Def_ChapterMAPNull
open BookProof.ChapterMAPNull


open MeasureTheory


variable {α : Type*} [MeasurableSpace α]


theorem BookProof.ChapterMAPNull.countable_map_set_measure_zero (μ : Measure α) [NullSingletonClass μ]
    (maximizers : Set α) (hcountable : maximizers.Countable) :
    μ maximizers = 0 := by sorry
