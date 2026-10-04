-- Generated from ChapterSolidHarmonic.lean — theorem BookProof.ChapterSolidHarmonic.radialFactor_eval
import Definitions.Def_ChapterRadialLaplacian
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Definitions.Def_ChapterLegendrePolynomial
import Definitions.Def_ChapterA4
open BookProof.ChapterLegendrePolynomial
open BookProof.ChapterSolidHarmonic

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]



open Laplacian InnerProductSpace Polynomial
open scoped RealInnerProductSpace


theorem BookProof.ChapterSolidHarmonic.radialFactor_eval (e : E) {l μ : ℕ} (hμ : μ ≤ l) {x : E} (hx : x ≠ 0) :
    radialFactor e l μ x
      = ‖x‖ ^ (l - μ) * (derivative^[μ] (legendre l)).eval (⟪e, x⟫_ℝ / ‖x‖) := by sorry
