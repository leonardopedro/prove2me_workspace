-- Generated from ChapterLaplacianProduct.lean — theorem BookProof.ChapterLaplacianProduct.fderiv_mul_eventually
import Definitions.Def_ChapterRadialLaplacian
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace


theorem BookProof.ChapterLaplacianProduct.fderiv_mul_eventually {f g : E → ℝ} {x : E}
    (hf : ContDiffAt ℝ 2 f x) (hg : ContDiffAt ℝ 2 g x) :
    (fderiv ℝ fun y : E => f y * g y) =ᶠ[nhds x]
      fun y => g y • fderiv ℝ f y + f y • fderiv ℝ g y := by sorry
