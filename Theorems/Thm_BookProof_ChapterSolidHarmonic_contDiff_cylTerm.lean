-- Generated from ChapterSolidHarmonic.lean — theorem BookProof.ChapterSolidHarmonic.contDiff_cylTerm
import Definitions.Def_ChapterLegendrePolynomial
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterA4
open BookProof.ChapterRadialLaplacian
open BookProof.ChapterSolidHarmonic

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace Polynomial
open scoped RealInnerProductSpace


theorem BookProof.ChapterSolidHarmonic.contDiff_cylTerm (e : E) (j m : ℕ) :
    ContDiff ℝ 2 fun y : E => (⟪e, y⟫_ℝ) ^ j * (‖y‖ ^ 2) ^ m := by sorry
