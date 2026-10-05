-- Generated from ChapterSolidHarmonic.lean — solution of BookProof.ChapterSolidHarmonic.contDiff_cylTerm
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_contDiff_normSqPow
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_contDiff_rclmPow
open BookProof.ChapterSolidHarmonic




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (e : E) (j m : ℕ) :
    ContDiff ℝ 2 fun y : E => (⟪e, y⟫_ℝ) ^ j * (‖y‖ ^ 2) ^ m := (contDiff_rclmPow (innerCLM E e) j).mul (contDiff_normSqPow m)
