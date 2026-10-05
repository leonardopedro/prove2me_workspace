-- Generated from ChapterSolidHarmonic.lean — solution of BookProof.ChapterSolidHarmonic.legendre_rec_factored
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
open BookProof.ChapterSolidHarmonic




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {l μ : ℕ} (hμ : μ ≤ l) (j : ℕ) :
    ((j : ℝ) + 2) * ((j : ℝ) + 1) * (derivative^[μ] (legendre l)).coeff (j + 2)
      = -((((l - μ : ℕ) : ℝ) - j) * (((l - μ : ℕ) : ℝ) + j + 2 * μ + 1))
        * (derivative^[μ] (legendre l)).coeff j := by

  rw [legendre_deriv_coeff_rec l μ j]
  congr 1
  rw [Nat.cast_sub hμ]
  ring
