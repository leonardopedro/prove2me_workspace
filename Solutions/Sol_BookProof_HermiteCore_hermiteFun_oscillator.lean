-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteFun_oscillator
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hermiteR_ode
import Theorems.Thm_BookProof_HermiteCore_deriv_poly_mul_gaussH
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
 => p.eval y * gaussH y)
      ((derivative p - C (1 / 2 : ℝ) * (X * p)).eval x * gaussH x) x := by
  have h := (p.hasDerivAt x).mul (hasDerivAt_gaussH x)
  convert h using 1 <;> first
  | rfl
  | simp only [Polynomial.eval_sub, Polynomial.eval_mul, Polynomial.eval_C, Polynomial.eval_X]
    ri :=
  ng
  
  theorem deriv_poly_mul_gaussH (p : Polynomial ℝ) :
      deriv (fun y : ℝ => p.eval y * gaussH y)
        = fun x : ℝ => (derivative p - C (1 / 2 : ℝ) * (X * p)).eval x * gaussH x :=
    funext fun x => (hasDerivAt_poly_mul_gaussH p x).deriv
  
  /-- **The Hermite functions are the eigenfunctions of the harmonic oscillator**
  `-d²/dx² + x²/4`, with eigenvalues `n + 1/2`. -/
  theorem hermiteFun_oscillator (n : ℕ) (x : ℝ) :
      -(deriv (deriv (hermiteFun n)) x) + x ^ 2 / 4 * hermiteFun n x
        = ((n : ℝ) + 1 / 2) * hermiteFun n x := by
    set q : Polynomial ℝ := derivative (hermiteR n) - C (1 / 2 : ℝ) * (X * hermiteR n) with hq
    have h1 : hermiteFun n = fun y : ℝ => (hermiteR n).eval y * gaussH y := rfl
    have h2 : deriv (hermiteFun n) = fun y : ℝ => q.eval y * gaussH y := by
      rw [h1, deriv_poly_mul_gaussH]
    have h3 : deriv (deriv (hermiteFun n)) x
        = (derivative q - C (1 / 2 : ℝ) * (X * q)).eval x * gaussH x := by
      rw [h2, deriv_poly_mul_gaussH]
    have hq' : derivative q = derivative (derivative (hermiteR n))
