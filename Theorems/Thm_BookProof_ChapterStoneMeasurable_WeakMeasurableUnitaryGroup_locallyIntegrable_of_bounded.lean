-- Generated from ChapterStoneMeasurable.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.locallyIntegrable_of_bounded
import Mathlib
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (G : WeakMeasurableUnitaryGroup H)


open scoped InnerProductSpace
open Filter Topology MeasureTheory



theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.locallyIntegrable_of_bounded {f : ℝ → ℝ} (hm : Measurable f) {M : ℝ}
    (hb : ∀ t, ‖f t‖ ≤ M) : LocallyIntegrable f volume := by sorry
