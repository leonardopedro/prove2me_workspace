-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.gint_ibp
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hasDerivAt_gaussW
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
assoc, integral_const_mul]

theorem solution : gint 1 = Real.sqrt (2 * Real.pi) := by
  have h : (fun x : ℝ => (1 : Polynomial ℝ).eval x * gaussW x)
      = fun x : ℝ => Real.exp (-(1 / 2 : ℝ) * x ^ 2) := by
    funext x
    simp only [Polynomial.e :=
  val_one, one_mul, gaussW]
      ring_nf
    rw [gint, h, integral_gaussian]
    congr 1
    rw [div_eq_iff (by norm_num : (1 / 2 : ℝ) ≠ 0)]
    ring
  
  /-- **Integration by parts against the Gaussian weight**, on all of `ℝ`:
  `∫ p' q w = ∫ p (X q − q') w`, because `(q w)' = (q' − X q) w`. -/
  theorem gint_ibp (p q : Polynomial ℝ) :
      gint (derivative p * q) = gint (p * (X * q - derivative q)) := by
    have hu : ∀ x : ℝ, HasDerivAt (fun y : ℝ => p.eval y) ((derivative p).eval x) x :=
      fun x => p.hasDerivAt x
    have hv : ∀ x : ℝ, HasDerivAt (fun y : ℝ => q.eval y * gaussW y)
        (((derivative q).eval x - x * q.eval x) * gaussW x) x := by
      intro x
      have h := (q.hasDerivAt x).mul (hasDerivAt_gaussW x)
      convert h using 1 <;> first | rfl | ring
    have hiuv' : Integrable ((fun y : ℝ => p.eval y) *
        (fun y : ℝ => ((derivative q).eval y - y * q.eval y) * gaussW y)) := by
      refine (integrable_poly_mul_gaussW (p * (derivative q - X * q))).congr
        (Filter.Eventually.of_forall fun x => ?_)
      simp only [Pi.mul_apply, Polynomial.eval_mul, Polynomial.eval_sub, Polynomial.eval_X]
      ring
    have hiu'v : Integrable ((fun y : ℝ => (derivative p).eval y) *
        (fun y : ℝ => q.eval y * gaussW y)) := by
      refine (integrable_poly_mul_gaussW (derivative p * q)).congr
        (Filter.Eventually.of_forall fun x => ?_)
      simp only [Pi.mul_apply, Polynomial.eval_mul]
      ring
    have hiuv : Integrable ((fun y : ℝ => p.eval y) * (fun y : ℝ => q.eval y * gaussW y)) := by
      refine (integrable_poly_mul_gaussW (p * q)).congr (Filter.Eventually.of_forall fun x => ?_)
      simp only [Pi.mul_apply, Polynomial.eval_mul]
      ring
    have key := integral_mul_deriv_eq_deriv_mul_of_integrable
      (fun x _ => hu x) (fun x _ => hv x) hiuv' hiu'v hiuv
    have hL : ∫ x : ℝ, p.eval x * (((derivative q).eval x - x * q.eval x) * gaussW x)
        = - gint (p * (X * q - derivative q)) := by
      rw [gi
