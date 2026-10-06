-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.odeKoop_neg_odeKoop
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
import Theorems.Thm_BookProof_OdeUnitaryFlow_odeKoop_add
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (ψ : ℝ → ℂ) (x : ℝ) (hx : x ∈ flowDom (-t)) :
    odeKoop (-t) (odeKoop t ψ) x = ψ x := by

  have hx' : 1 + (-t) * x ≠ 0 := hx
  have h := odeKoop_add (-t) t ψ x hx' (by simp)
  rw [h]
  simp
