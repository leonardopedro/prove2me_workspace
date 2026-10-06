-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.chartW_lintegral_normSq
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
import Theorems.Thm_BookProof_OdeUnitaryFlow_lintegral_comp_invMap
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (ψ : ℝ → ℂ) :
    ∫⁻ x, ENNReal.ofReal (‖chartW ψ x‖ ^ 2) = ∫⁻ y, ENNReal.ofReal (‖ψ y‖ ^ 2) := by

  have key := lintegral_comp_invMap (fun y => ENNReal.ofReal (‖ψ y‖ ^ 2))
  rw [← key]
  refine lintegral_congr fun x => ?_
  have hnorm : ‖chartW ψ x‖ ^ 2 = (x ^ 2)⁻¹ * ‖ψ (invMap x)‖ ^ 2 := by
    simp only [chartW, norm_mul, norm_inv, Complex.norm_real, mul_pow, inv_pow,
      Real.norm_eq_abs, sq_abs]
  rw [hnorm, ENNReal.ofReal_mul (by positivity)]
