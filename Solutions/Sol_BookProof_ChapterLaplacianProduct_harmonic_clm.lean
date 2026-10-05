-- Generated from ChapterLaplacianProduct.lean — solution of BookProof.ChapterLaplacianProduct.harmonic_clm
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct




open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℝ E] (L : E →L[ℝ] ℝ) (x : E) :
    (Δ fun y : E => L y) x = 0 := by

  rw [laplacian_eq_iteratedFDeriv_stdOrthonormalBasis]
  have hterm : ∀ i, iteratedFDeriv ℝ 2 (fun y : E => L y) x
      ![(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i] = 0 := by
    intro i
    rw [iteratedFDeriv_two_apply]
    have hfd : (fderiv ℝ fun y : E => L y) = fun _ => (L : E →L[ℝ] ℝ) := by
      funext y; exact L.fderiv
    rw [hfd]
    simp
  simp [hterm]
