-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.one_sub_mul_mob
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (t x : ℝ) (hx : x ∈ flowDom t) :
    1 - t * mob t x = (1 + t * x)⁻¹ := by

  have h : 1 + t * x ≠ 0 := hx
  simp only [mob]
  field_simp
  ring
