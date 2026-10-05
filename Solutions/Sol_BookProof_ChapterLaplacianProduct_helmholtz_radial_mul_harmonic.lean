-- Generated from ChapterLaplacianProduct.lean — solution of BookProof.ChapterLaplacianProduct.helmholtz_radial_mul_harmonic
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
import Theorems.Thm_BookProof_ChapterLaplacianProduct_laplacian_radial_mul_harmonic
open BookProof.ChapterLaplacianProduct




open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℝ E] {g : ℝ → ℝ} {H : E → ℝ} {x : E}
    {l : ℕ} {p : ℝ} (hx : x ≠ 0) (hg : ContDiffAt ℝ 2 g ‖x‖) (hH : ContDiffAt ℝ 2 H x)
    (hharm : (Δ H) x = 0) (heuler : fderiv ℝ H x x = l * H x)
    (hradial : deriv (deriv g) ‖x‖
      + (((Module.finrank ℝ E : ℝ) - 1 + 2 * l) / ‖x‖) * deriv g ‖x‖ = -(p ^ 2) * g ‖x‖) :
    -(Δ fun y : E => g ‖y‖ * H y) x = p ^ 2 * (g ‖x‖ * H x) := by

  rw [laplacian_radial_mul_harmonic hx hg hH hharm heuler, hradial]
  ring
