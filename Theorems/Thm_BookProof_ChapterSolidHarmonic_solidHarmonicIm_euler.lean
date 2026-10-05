-- Generated from ChapterSolidHarmonic.lean — theorem BookProof.ChapterSolidHarmonic.solidHarmonicIm_euler
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
import Definitions.Def_ChapterSolidHarmonicTools
import Definitions.Def_ChapterLegendrePolynomial
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
open BookProof.ChapterSolidHarmonic

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace


theorem BookProof.ChapterSolidHarmonic.solidHarmonicIm_euler (u v e : E) {l μ : ℕ} (hμ : μ ≤ l) (x : E) :
    fderiv ℝ (solidHarmonicIm u v e l μ) x x = (l : ℝ) * solidHarmonicIm u v e l μ x := by sorry
