-- Generated from ChapterSolidHarmonic.lean — theorem BookProof.ChapterSolidHarmonic.laplacian_const_mul
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
import Definitions.Def_ChapterSolidHarmonicTools
import Definitions.Def_ChapterLegendrePolynomial
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
open BookProof.ChapterSolidHarmonic



open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]


theorem BookProof.ChapterSolidHarmonic.laplacian_const_mul {f : E → ℝ} {x : E} (c : ℝ) (hf : ContDiffAt ℝ 2 f x) :
    (Δ fun y => c * f y) x = c * (Δ f) x := by sorry
