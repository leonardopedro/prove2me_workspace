-- Generated from ChapterStoneMeasurable.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.locallyIntegrable_of_bounded
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution {f : ℝ → ℝ} (hm : Measurable f) {M : ℝ}
    (hb : ∀ t, ‖f t‖ ≤ M) : LocallyIntegrable f volume := by

  rw [locallyIntegrable_iff]
  intro k hk
  exact Measure.integrableOn_of_bounded (M := M) hk.measure_lt_top.ne
    hm.aestronglyMeasurable (Eventually.of_forall hb)
