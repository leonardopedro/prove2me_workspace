-- Generated from ChapterSolidHarmonic.lean — theorem BookProof.ChapterSolidHarmonic.contDiff_solidHarmonic
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLegendrePolynomial
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Definitions.Def_ChapterA4
open BookProof.ChapterSolidHarmonic

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace Polynomial
open scoped RealInnerProductSpace


theorem BookProof.ChapterSolidHarmonic.contDiff_solidHarmonic (u v e : E) (l μ : ℕ) : ContDiff ℝ 2 (solidHarmonic u v e l μ) := by sorry
