-- Generated from ChapterSolidHarmonic.lean — theorem BookProof.ChapterSolidHarmonic.sum_nullCLM_sq
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


theorem BookProof.ChapterSolidHarmonic.sum_nullCLM_sq {u v : E} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (huv : ⟪u, v⟫_ℝ = 0) :
    ∑ i, (nullCLM u v (stdOrthonormalBasis ℝ E i)) ^ 2 = 0 := by sorry
