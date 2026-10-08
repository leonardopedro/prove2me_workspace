-- Generated from ChapterMAPNull.lean — theorem BookProof.ChapterMAPNull.map_point_measure_zero
import Mathlib
import Definitions.Def_ChapterMAPNull
open BookProof.ChapterMAPNull


open MeasureTheory


variable {α : Type*} [MeasurableSpace α]


theorem BookProof.ChapterMAPNull.map_point_measure_zero (μ : Measure α) [NullSingletonClass μ] (mapPoint : α) :
    μ {mapPoint} = 0 := by sorry
