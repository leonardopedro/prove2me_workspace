-- Generated from ChapterLaplacianProduct.lean — theorem BookProof.ChapterLaplacianProduct.diffAt_fderiv
import Definitions.Def_ChapterRadialLaplacian
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct



open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


theorem BookProof.ChapterLaplacianProduct.diffAt_fderiv {f : E → ℝ} {x : E} (h : ContDiffAt ℝ 2 f x) :
    DifferentiableAt ℝ (fderiv ℝ f) x := by sorry
