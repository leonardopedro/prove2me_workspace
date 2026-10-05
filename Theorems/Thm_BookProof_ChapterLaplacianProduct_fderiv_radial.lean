-- Generated from ChapterLaplacianProduct.lean — theorem BookProof.ChapterLaplacianProduct.fderiv_radial
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
import Definitions.Def_ChapterRadialLaplacian
open BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace


theorem BookProof.ChapterLaplacianProduct.fderiv_radial {g : ℝ → ℝ} {x : E} (hx : x ≠ 0) (hg : ContDiffAt ℝ 2 g ‖x‖) :
    fderiv ℝ (fun y : E => g ‖y‖) x = (deriv g ‖x‖ / ‖x‖) • innerCLM E x := by sorry
