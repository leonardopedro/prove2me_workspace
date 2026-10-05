-- Generated from ChapterHarmonicOscillatorEsa.lean — solution of BookProof.HarmonicOscillator.deriv_deriv_hermiteC
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Theorems.Thm_BookProof_HarmonicOscillator_hasDerivAt_polyGaussC
import Theorems.Thm_BookProof_HarmonicOscillator_deriv_polyGaussC
import Theorems.Thm_BookProof_HarmonicOscillator_hermiteC_eq
import Theorems.Thm_BookProof_HarmonicOscillator_deriv_const_mul_fun
import Theorems.Thm_BookProof_HermiteCore_deriv_poly_mul_gaussH
open BookProof.HarmonicOscillator




open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (x : ℝ) :
    deriv (deriv (hermiteC n)) x
      = ((hermiteNorm n : ℝ) : ℂ)⁻¹ * ((deriv (deriv (hermiteFun n)) x : ℝ) : ℂ) := by

  have hdiff : ∀ (p : Polynomial ℝ) (y : ℝ), DifferentiableAt ℝ (polyGaussC p) y :=
    fun p y => (hasDerivAt_polyGaussC p y).differentiableAt
  have h1 : deriv (hermiteC n)
      = fun y => ((hermiteNorm n : ℝ) : ℂ)⁻¹ *
        polyGaussC (derivative (hermiteR n) - C (1 / 2 : ℝ) * (X * hermiteR n)) y := by
    rw [hermiteC_eq n, deriv_const_mul_fun _ (hdiff (hermiteR n)), deriv_polyGaussC]
  rw [h1, deriv_const_mul_fun _ (hdiff _), deriv_polyGaussC]
  have hreal : deriv (deriv (hermiteFun n)) x
      = (derivative (derivative (hermiteR n) - C (1 / 2 : ℝ) * (X * hermiteR n))
          - C (1 / 2 : ℝ) * (X * (derivative (hermiteR n)
            - C (1 / 2 : ℝ) * (X * hermiteR n)))).eval x * gaussH x := by
    have h2 : deriv (hermiteFun n)
        = fun y : ℝ => (derivative (hermiteR n) - C (1 / 2 : ℝ) * (X * hermiteR n)).eval y
            * gaussH y := by
      have : hermiteFun n = fun y : ℝ => (hermiteR n).eval y * gaussH y := rfl
      rw [this, deriv_poly_mul_gaussH]
    rw [h2, deriv_poly_mul_gaussH]
  rw [hreal]
  simp [polyGaussC]
