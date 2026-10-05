-- Generated from ChapterLaplacianProduct.lean — theorem BookProof.ChapterLaplacianProduct.euler_clm
import Definitions.Def_ChapterRadialLaplacian
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace


theorem BookProof.ChapterLaplacianProduct.euler_clm (L : E →L[ℝ] ℝ) (x : E) : fderiv ℝ (fun y : E => L y) x x = (1 : ℕ) * L x := by sorry
