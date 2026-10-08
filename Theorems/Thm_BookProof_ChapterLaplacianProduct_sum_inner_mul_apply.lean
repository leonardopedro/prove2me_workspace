-- Generated from ChapterLaplacianProduct.lean — theorem BookProof.ChapterLaplacianProduct.sum_inner_mul_apply
import Definitions.Def_ChapterRadialLaplacian
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct



open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


theorem BookProof.ChapterLaplacianProduct.sum_inner_mul_apply [FiniteDimensional ℝ E] (L : E →L[ℝ] ℝ) (x : E) :
    ∑ i, ⟪x, (stdOrthonormalBasis ℝ E) i⟫ * L ((stdOrthonormalBasis ℝ E) i) = L x := by sorry
