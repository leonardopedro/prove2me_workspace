-- Generated from ChapterSolidHarmonic.lean — theorem BookProof.ChapterSolidHarmonic.angular_euler
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLegendrePolynomial
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Definitions.Def_ChapterA4
open BookProof.ChapterSolidHarmonic

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace Polynomial
open scoped RealInnerProductSpace


theorem BookProof.ChapterSolidHarmonic.angular_euler (u v : E) (μ : ℕ) (x : E) :
    fderiv ℝ (angular u v μ) x x = (μ : ℝ) * angular u v μ x := by sorry
