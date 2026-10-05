-- Generated from ChapterHarmonicOscillatorEsa.lean — solution of BookProof.HarmonicOscillator.hermiteC_oscillator
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Theorems.Thm_BookProof_HarmonicOscillator_hermiteC_eq
import Theorems.Thm_BookProof_HarmonicOscillator_deriv_deriv_hermiteC
import Theorems.Thm_BookProof_HermiteCore_hermiteFun_oscillator
open BookProof.HarmonicOscillator




open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (x : ℝ) :
    -(deriv (deriv (hermiteC n)) x) + ((x ^ 2 / 4 : ℝ) : ℂ) * hermiteC n x
      = (((n : ℝ) + 1 / 2 : ℝ) : ℂ) * hermiteC n x := by

  have hreal := hermiteFun_oscillator n x
  have hcx : hermiteC n x = ((hermiteNorm n : ℝ) : ℂ)⁻¹ * ((hermiteFun n x : ℝ) : ℂ) := by
    rw [hermiteC_eq n]
    simp [polyGaussC, hermiteFun]
  rw [deriv_deriv_hermiteC n x, hcx]
  have : ((-(deriv (deriv (hermiteFun n)) x) + x ^ 2 / 4 * hermiteFun n x : ℝ) : ℂ)
      = (((((n : ℝ) + 1 / 2) * hermiteFun n x : ℝ)) : ℂ) := by
    rw [hreal]
  push_cast at this ⊢
  linear_combination ((hermiteNorm n : ℝ) : ℂ)⁻¹ * this
