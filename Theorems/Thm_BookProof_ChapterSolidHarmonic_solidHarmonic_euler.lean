-- Generated from ChapterSolidHarmonic.lean — theorem BookProof.ChapterSolidHarmonic.solidHarmonic_euler
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


theorem BookProof.ChapterSolidHarmonic.solidHarmonic_euler (u v e : E) {l μ : ℕ} (hμ : μ ≤ l) (x : E) :
    fderiv ℝ (solidHarmonic u v e l μ) x x = (l : ℝ) * solidHarmonic u v e l μ x := by sorry
