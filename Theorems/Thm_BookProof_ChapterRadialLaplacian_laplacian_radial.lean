-- Generated from ChapterRadialLaplacian.lean — theorem BookProof.ChapterRadialLaplacian.laplacian_radial
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
open BookProof.ChapterRadialLaplacian



open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


theorem BookProof.ChapterRadialLaplacian.laplacian_radial [FiniteDimensional ℝ E] {g : ℝ → ℝ} {x : E} (hx : x ≠ 0)
    (hg : ContDiffAt ℝ 2 g ‖x‖) :
    (Δ fun y : E => g ‖y‖) x
      = deriv (deriv g) ‖x‖
        + (((Module.finrank ℝ E : ℝ) - 1) / ‖x‖) * deriv g ‖x‖ := by sorry
