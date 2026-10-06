-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.injOn_invMap
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
import Theorems.Thm_BookProof_OdeUnitaryFlow_invMap_invMap
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : Set.InjOn invMap {x : ℝ | x ≠ 0} := by

  intro a ha b hb hab
  have ha' := invMap_invMap (x := a) ha
  have hb' := invMap_invMap (x := b) hb
  rw [← ha', ← hb', hab]
