-- Generated from ChapterRadialLaplacian.lean — theorem BookProof.ChapterRadialLaplacian.fderiv_fderiv_comp_normSq
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
open BookProof.ChapterRadialLaplacian



open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


theorem BookProof.ChapterRadialLaplacian.fderiv_fderiv_comp_normSq [FiniteDimensional ℝ E] {G : ℝ → ℝ} {x : E}
    (hG : ContDiffAt ℝ 2 G (‖x‖ ^ 2)) :
    fderiv ℝ (fderiv ℝ fun y : E => G (‖y‖ ^ 2)) x
      = (2 * deriv G (‖x‖ ^ 2)) • (innerCLM E)
        + ((4 * deriv (deriv G) (‖x‖ ^ 2)) • innerCLM E x).smulRight (innerCLM E x) := by sorry
