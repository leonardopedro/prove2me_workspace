-- Generated from ChapterRadialLaplacian.lean — solution of BookProof.ChapterRadialLaplacian.helmholtz_sbessel_zero
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
import Theorems.Thm_BookProof_ChapterRadialLaplacian_laplacian_sbessel_zero
open BookProof.ChapterRadialLaplacian




open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℝ E] (h3 : Module.finrank ℝ E = 3)
    {p : ℝ} {x : E} (hp : p ≠ 0) (hx : x ≠ 0) :
    -(Δ fun y : E => sbessel 0 (p * ‖y‖)) x = p ^ 2 * sbessel 0 (p * ‖x‖) := by

  rw [laplacian_sbessel_zero h3 hp hx]
  ring
