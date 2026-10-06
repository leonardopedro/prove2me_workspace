-- Generated from ChapterMAPNull.lean — solution of BookProof.ChapterMAPNull.ae_ne_map_point
import Mathlib
import Definitions.Def_ChapterMAPNull
import Theorems.Thm_BookProof_ChapterMAPNull_map_point_measure_zero
open BookProof.ChapterMAPNull



open MeasureTheory


variable {α : Type*} [MeasurableSpace α]

variable {α : Type*} [MeasurableSpace α]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure α) [NullSingletonClass μ] (mapPoint : α) :
    ∀ᵐ x ∂μ, x ≠ mapPoint := by

  convert MeasureTheory.measure_eq_zero_iff_ae_notMem.mp
    ( map_point_measure_zero μ mapPoint ) using 1
  · funext x; simp
