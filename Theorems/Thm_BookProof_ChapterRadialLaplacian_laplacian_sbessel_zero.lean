-- Generated from ChapterRadialLaplacian.lean — theorem BookProof.ChapterRadialLaplacian.laplacian_sbessel_zero
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterRadialLaplacian



open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


theorem BookProof.ChapterRadialLaplacian.laplacian_sbessel_zero [FiniteDimensional ℝ E] (h3 : Module.finrank ℝ E = 3)
    {p : ℝ} {x : E} (hp : p ≠ 0) (hx : x ≠ 0) :
    (Δ fun y : E => sbessel 0 (p * ‖y‖)) x = -(p ^ 2) * sbessel 0 (p * ‖x‖) := by sorry
