-- Generated from ChapterLaplacianProduct.lean — theorem BookProof.ChapterLaplacianProduct.fderiv_fderiv_mul
import Definitions.Def_ChapterRadialLaplacian
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace


theorem BookProof.ChapterLaplacianProduct.fderiv_fderiv_mul {f g : E → ℝ} {x : E} (hf : ContDiffAt ℝ 2 f x)
    (hg : ContDiffAt ℝ 2 g x) :
    fderiv ℝ (fderiv ℝ fun y : E => f y * g y) x
      = (g x) • fderiv ℝ (fderiv ℝ f) x + (fderiv ℝ g x).smulRight (fderiv ℝ f x)
        + ((f x) • fderiv ℝ (fderiv ℝ g) x + (fderiv ℝ f x).smulRight (fderiv ℝ g x)) := by sorry
