-- Generated from ChapterRadialLaplacian.lean — theorem BookProof.ChapterRadialLaplacian.helmholtz_sbessel_zero_euclidean
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterRadialLaplacian



open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


theorem BookProof.ChapterRadialLaplacian.helmholtz_sbessel_zero_euclidean {p : ℝ} {x : EuclideanSpace ℝ (Fin 3)}
    (hp : p ≠ 0) (hx : x ≠ 0) :
    -(Δ fun y : EuclideanSpace ℝ (Fin 3) => sbessel 0 (p * ‖y‖)) x
      = p ^ 2 * sbessel 0 (p * ‖x‖) := by sorry
