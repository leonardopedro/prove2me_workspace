-- Generated from ChapterSolidHarmonic.lean — solution of BookProof.ChapterSolidHarmonic.angularIm_euler
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Theorems.Thm_BookProof_ChapterSolidHarmonic_fderiv_angularIm
open BookProof.ChapterSolidHarmonic




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (u v : E) (μ : ℕ) (x : E) :
    fderiv ℝ (angularIm u v μ) x x = (μ : ℝ) * angularIm u v μ x := by

  rw [fderiv_angularIm]
  rcases μ with _ | n
  · simp
  · simp only [Nat.add_sub_cancel]
    push_cast
    rw [show ((n : ℂ) + 1) * (nullCLM u v x) ^ n * nullCLM u v x
        = ((n : ℂ) + 1) * (nullCLM u v x) ^ (n + 1) from by ring]
    simp only [Complex.mul_im, Complex.natCast_re, Complex.natCast_im, Complex.one_re,
      Complex.one_im, Complex.add_re, Complex.add_im]
    simp [angularIm]
