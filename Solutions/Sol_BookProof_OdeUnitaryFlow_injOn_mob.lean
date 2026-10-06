-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.injOn_mob
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
import Theorems.Thm_BookProof_OdeUnitaryFlow_mob_neg_mob
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : InjOn (mob t) (flowDom t) := by

  intro a ha b hb hab
  have ha' := mob_neg_mob t a ha
  have hb' := mob_neg_mob t b hb
  rw [← ha', ← hb', hab]
