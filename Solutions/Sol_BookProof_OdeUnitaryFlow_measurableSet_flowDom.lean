-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.measurableSet_flowDom
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : MeasurableSet (flowDom t) := by

  have hc : Continuous fun x : ℝ => 1 + t * x := by fun_prop
  have hset : flowDom t = ((fun x : ℝ => 1 + t * x) ⁻¹' {0})ᶜ := by
    ext x; simp [flowDom]
  rw [hset]
  exact ((measurableSet_singleton (0 : ℝ)).preimage hc.measurable).compl
