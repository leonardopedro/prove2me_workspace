-- Generated from ChapterMAPNull.lean — solution of BookProof.ChapterMAPNull.ae_not_mem_countable_map_set
import Mathlib
import Definitions.Def_ChapterMAPNull
import Theorems.Thm_BookProof_ChapterMAPNull_countable_map_set_measure_zero
open BookProof.ChapterMAPNull



open MeasureTheory


variable {α : Type*} [MeasurableSpace α]

variable {α : Type*} [MeasurableSpace α]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure α) [NullSingletonClass μ]
    (maximizers : Set α) (hcountable : maximizers.Countable) :
    ∀ᵐ x ∂μ, x ∉ maximizers := by

  convert countable_map_set_measure_zero μ maximizers hcountable using 1;
  rw [ MeasureTheory.measure_eq_zero_iff_ae_notMem ]
