-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.odeKoop_lintegral_normSq
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
import Theorems.Thm_BookProof_OdeUnitaryFlow_lintegral_comp_mob
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (ψ : ℝ → ℂ) :
    ∫⁻ x, ENNReal.ofReal (‖odeKoop t ψ x‖ ^ 2) = ∫⁻ y, ENNReal.ofReal (‖ψ y‖ ^ 2) := by

  have key := lintegral_comp_mob t (fun y => ENNReal.ofReal (‖ψ y‖ ^ 2))
  rw [← key]
  refine lintegral_congr fun x => ?_
  have hnorm : ‖odeKoop t ψ x‖ ^ 2 = ((1 + t * x) ^ 2)⁻¹ * ‖ψ (mob t x)‖ ^ 2 := by
    simp only [odeKoop, norm_mul, norm_inv, Complex.norm_real, mul_pow, inv_pow,
      Real.norm_eq_abs, sq_abs]
  rw [hnorm, ENNReal.ofReal_mul (by positivity)]
