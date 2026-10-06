-- Generated from ChapterRadialLaplacian.lean — theorem BookProof.ChapterRadialLaplacian.laplacian_comp_normSq
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
open BookProof.ChapterRadialLaplacian

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace


theorem BookProof.ChapterRadialLaplacian.laplacian_comp_normSq [FiniteDimensional ℝ E] {G : ℝ → ℝ} {x : E}
    (hG : ContDiffAt ℝ 2 G (‖x‖ ^ 2)) :
    (Δ fun y : E => G (‖y‖ ^ 2)) x
      = 4 * ‖x‖ ^ 2 * deriv (deriv G) (‖x‖ ^ 2)
        + 2 * (Module.finrank ℝ E) * deriv G (‖x‖ ^ 2) := by sorry
