-- Generated from ChapterLaplacianProduct.lean — solution of BookProof.ChapterLaplacianProduct.euler_clm
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct




open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (L : E →L[ℝ] ℝ) (x : E) : fderiv ℝ (fun y : E => L y) x x = (1 : ℕ) * L x := by

  rw [L.fderiv]
  simp
