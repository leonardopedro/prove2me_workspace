-- Generated from ChapterSolidHarmonic.lean — theorem BookProof.ChapterSolidHarmonic.radialFactor_euler
import Definitions.Def_ChapterLaplacianProduct
import Definitions.Def_ChapterSolidHarmonicTools
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Definitions.Def_ChapterLegendrePolynomial
import Definitions.Def_ChapterRadialLaplacian
open BookProof.ChapterLegendrePolynomial
open BookProof.ChapterRadialLaplacian
open BookProof.ChapterSolidHarmonic

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace


theorem BookProof.ChapterSolidHarmonic.radialFactor_euler (e : E) (l μ : ℕ) (x : E) :
    fderiv ℝ (radialFactor e l μ) x x = ((l - μ : ℕ) : ℝ) * radialFactor e l μ x := by sorry
