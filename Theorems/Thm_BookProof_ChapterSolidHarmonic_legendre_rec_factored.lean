-- Generated from ChapterSolidHarmonic.lean — theorem BookProof.ChapterSolidHarmonic.legendre_rec_factored
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
import Definitions.Def_ChapterSolidHarmonicTools
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Definitions.Def_ChapterLegendrePolynomial
open BookProof.ChapterLegendrePolynomial
open BookProof.ChapterSolidHarmonic

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace


theorem BookProof.ChapterSolidHarmonic.legendre_rec_factored {l μ : ℕ} (hμ : μ ≤ l) (j : ℕ) :
    ((j : ℝ) + 2) * ((j : ℝ) + 1) * (derivative^[μ] (legendre l)).coeff (j + 2)
      = -((((l - μ : ℕ) : ℝ) - j) * (((l - μ : ℕ) : ℝ) + j + 2 * μ + 1))
        * (derivative^[μ] (legendre l)).coeff j := by sorry
