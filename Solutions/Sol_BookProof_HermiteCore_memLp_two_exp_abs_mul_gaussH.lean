-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.memLp_two_exp_abs_mul_gaussH
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_gaussH_pos
import Theorems.Thm_BookProof_HermiteCore_continuous_gaussH
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
u ∈ L²(ℝ)` is
orthogonal to every Hermite function then it is orthogonal to every `xᵏ e^{-x²/4}`
(the Hermite polynomials are monic of every degree), hence — expanding the
character `e^{-2πiwx}` in its power series and integrating :=
  term by term, which
  dominated convergence allows because `e^{c|x|}e^{-x²/4}` is still square
  integrable — the Fourier transform of the `L¹` function `e^{-x²/4} u` vanishes
  identically, so `u = 0`. -/
  
  /-- `x ↦ e^{c|x|} e^{-x²/4}` is square integrable: the Gaussian beats every
  exponential. -/
  theorem memLp_two_exp_abs_mul_gaussH (c : ℝ) :
      MemLp (fun x : ℝ => ((Real.exp (c * |x|) * gaussH x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by
    have hmeas : AEStronglyMeasurable (fun x : ℝ => ((Real.exp (c * |x|) * gaussH x : ℝ) : ℂ))
        (volume : Measure ℝ) := by
      refine Continuous.aestronglyMeasurable (Complex.continuous_ofReal.comp ?_)
      exact (Real.continuous_exp.comp (continuous_const.mul continuous_abs)).mul continuous_gaussH
    rw [memLp_two_iff_integrable_sq_norm hmeas]
    have hdom : Integrable (fun x : ℝ => Real.exp (4 * c ^ 2) * Real.exp (-(1/4 : ℝ) * x ^ 2)) :=
      (integrable_exp_neg_mul_sq (by norm_num)).const_mul _
    have hcont : Continuous fun x : ℝ => ‖((Real.exp (c * |x|) * gaussH x : ℝ) : ℂ)‖ ^ 2 :=
      ((Complex.continuous_ofReal.comp ((Real.continuous_exp.comp
        (continuous_const.mul continuous_abs)).mul continuous_gaussH)).norm.pow 2)
    refine hdom.mono' hcont.aestronglyMeasurable ?_
    filter_upwards with x
    have hsq : ‖((Real.exp (c * |x|) * gaussH x : ℝ) : ℂ)‖ ^ 2
        = Real.exp (2 * c * |x| - x ^ 2 / 2) := by
      rw [Complex.norm_real, Real.norm_eq_abs,
        abs_of_nonneg (mul_pos (Real.exp_pos _) (gaussH_pos x)).le]
      rw [gaussH, mul_pow, ← Real.exp_nat_mul, ← Real.exp_
