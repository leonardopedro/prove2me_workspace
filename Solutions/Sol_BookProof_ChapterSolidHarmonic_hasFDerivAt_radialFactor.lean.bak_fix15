-- Generated from ChapterSolidHarmonic.lean — solution of BookProof.ChapterSolidHarmonic.hasFDerivAt_radialFactor
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_hasFDerivAt_cylTerm
open BookProof.ChapterSolidHarmonic




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (e : E) (l μ : ℕ) (x : E) :
    HasFDerivAt (radialFactor e l μ)
      (∑ m ∈ Finset.range ((l - μ) / 2 + 1),
        ((derivative^[μ] (legendre l)).coeff (l - μ - 2 * m)) •
          ((((l - μ - 2 * m : ℕ) : ℝ) * (⟪e, x⟫_ℝ) ^ (l - μ - 2 * m - 1) * (‖x‖ ^ 2) ^ m)
              • innerCLM E e
            + (2 * m * (⟪e, x⟫_ℝ) ^ (l - μ - 2 * m) * (‖x‖ ^ 2) ^ (m - 1)) • innerCLM E x)) x := by

  refine HasFDerivAt.fun_sum (u := Finset.range ((l - μ) / 2 + 1)) fun m _ => ?_
  exact (hasFDerivAt_cylTerm e (l - μ - 2 * m) m x).const_mul
    ((derivative^[μ] (legendre l)).coeff (l - μ - 2 * m))
