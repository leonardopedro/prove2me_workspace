-- Generated from ChapterRadialLaplacian.lean — theorem BookProof.ChapterRadialLaplacian.diffAt_deriv_of_contDiffAt_two
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
open BookProof.ChapterRadialLaplacian

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace


theorem BookProof.ChapterRadialLaplacian.diffAt_deriv_of_contDiffAt_two {G : ℝ → ℝ} {q : ℝ} (h : ContDiffAt ℝ 2 G q) :
    DifferentiableAt ℝ (deriv G) q := by sorry
