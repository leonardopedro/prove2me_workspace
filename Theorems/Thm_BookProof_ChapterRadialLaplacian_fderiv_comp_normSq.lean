-- Generated from ChapterRadialLaplacian.lean — theorem BookProof.ChapterRadialLaplacian.fderiv_comp_normSq
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
open BookProof.ChapterRadialLaplacian



open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


theorem BookProof.ChapterRadialLaplacian.fderiv_comp_normSq {G : ℝ → ℝ} {x : E} (hG : ContDiffAt ℝ 2 G (‖x‖ ^ 2)) :
    (fderiv ℝ fun z : E => G (‖z‖ ^ 2)) =ᶠ[nhds x]
      fun y => (2 * deriv G (‖y‖ ^ 2)) • (innerCLM E y) := by sorry
