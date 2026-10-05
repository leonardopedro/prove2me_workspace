-- Generated from ChapterLaplacianProduct.lean — theorem BookProof.ChapterLaplacianProduct.harmonic_clm
import Definitions.Def_ChapterRadialLaplacian
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace


theorem BookProof.ChapterLaplacianProduct.harmonic_clm [FiniteDimensional ℝ E] (L : E →L[ℝ] ℝ) (x : E) :
    (Δ fun y : E => L y) x = 0 := by sorry
