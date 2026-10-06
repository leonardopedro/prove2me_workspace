-- Generated from ChapterMAPNull.lean — theorem BookProof.ChapterMAPNull.maximizerSet_measure_zero
import Mathlib
import Definitions.Def_ChapterMAPNull
open BookProof.ChapterMAPNull

variable {α : Type*} [MeasurableSpace α]


open MeasureTheory



theorem BookProof.ChapterMAPNull.maximizerSet_measure_zero (μ : Measure α) [NullSingletonClass μ]
    (score : α → ℝ) (hcountable : (maximizerSet score).Countable) :
    μ (maximizerSet score) = 0 := by sorry
