-- Generated from ChapterMAPNull.lean — theorem BookProof.ChapterMAPNull.ae_not_mem_countable_map_set
import Mathlib
import Definitions.Def_ChapterMAPNull
open BookProof.ChapterMAPNull

variable {α : Type*} [MeasurableSpace α]


open MeasureTheory



theorem BookProof.ChapterMAPNull.ae_not_mem_countable_map_set (μ : Measure α) [NullSingletonClass μ]
    (maximizers : Set α) (hcountable : maximizers.Countable) :
    ∀ᵐ x ∂μ, x ∉ maximizers := by sorry
