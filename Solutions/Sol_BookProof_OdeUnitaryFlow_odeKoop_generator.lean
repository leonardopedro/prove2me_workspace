-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.odeKoop_generator
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
import Theorems.Thm_BookProof_OdeUnitaryFlow_hasDerivAt_odeKoop_zero
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (ψ : ℝ → ℂ) (x : ℝ) (d : ℂ) (hψ : HasDerivAt ψ d x) :
    HasDerivAt (fun t : ℝ => odeKoop t ψ x) (-Complex.I * hamValue x d (ψ x)) 0 := by

  have h : -Complex.I * hamValue x d (ψ x) = -((x : ℂ) ^ 2 * d + (x : ℂ) * ψ x) := by
    simp only [hamValue]
    linear_combination ((x : ℂ) ^ 2 * d + (x : ℂ) * ψ x) * Complex.I_sq
  rw [h]
  exact hasDerivAt_odeKoop_zero ψ x d hψ
