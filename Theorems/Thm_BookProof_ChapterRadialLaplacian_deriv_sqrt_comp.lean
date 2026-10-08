-- Generated from ChapterRadialLaplacian.lean — theorem BookProof.ChapterRadialLaplacian.deriv_sqrt_comp
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
open BookProof.ChapterRadialLaplacian



open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


theorem BookProof.ChapterRadialLaplacian.deriv_sqrt_comp {g : ℝ → ℝ} {r : ℝ} (hr : 0 < r) (hg : ContDiffAt ℝ 2 g r) :
    deriv (fun q => g (Real.sqrt q)) (r ^ 2) = deriv g r * (1 / (2 * r)) ∧
    deriv (deriv fun q => g (Real.sqrt q)) (r ^ 2)
      = deriv (deriv g) r * (1 / (2 * r)) * (1 / (2 * r)) + deriv g r * (-(1 / (4 * r ^ 3))) := by sorry
