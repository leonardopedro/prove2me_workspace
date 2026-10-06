-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.one_add_neg_mul_mob
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
import Theorems.Thm_BookProof_OdeUnitaryFlow_one_sub_mul_mob
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (t x : ℝ) (hx : x ∈ flowDom t) :
    1 + (-t) * mob t x = (1 + t * x)⁻¹ := by

  have h := one_sub_mul_mob t x hx
  linear_combination h
