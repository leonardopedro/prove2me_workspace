-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.classicalSol_singular_time
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (x₀ : ℝ) (hx₀ : x₀ ≠ 0) : 1 - (1 / x₀) * x₀ = 0 := by

  rw [one_div, inv_mul_cancel₀ hx₀, sub_self]
