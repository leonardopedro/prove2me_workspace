-- Generated from ChapterLaplacianProduct.lean — theorem BookProof.ChapterLaplacianProduct.laplacian_mul
import Definitions.Def_ChapterRadialLaplacian
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace


theorem BookProof.ChapterLaplacianProduct.laplacian_mul [FiniteDimensional ℝ E] {f g : E → ℝ} {x : E}
    (hf : ContDiffAt ℝ 2 f x) (hg : ContDiffAt ℝ 2 g x) :
    (Δ fun y : E => f y * g y) x
      = (Δ f) x * g x + f x * (Δ g) x
        + 2 * ∑ i, fderiv ℝ f x ((stdOrthonormalBasis ℝ E) i)
            * fderiv ℝ g x ((stdOrthonormalBasis ℝ E) i) := by sorry
