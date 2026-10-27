-- Generated from ChapterLaplacianProduct.lean — solution of BookProof.ChapterLaplacianProduct.sum_inner_mul_apply
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct




open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℝ E] (L : E →L[ℝ] ℝ) (x : E) :
    ∑ i, ⟪x, (stdOrthonormalBasis ℝ E) i⟫ * L ((stdOrthonormalBasis ℝ E) i) = L x := by

  have hx : ∑ i, ⟪(stdOrthonormalBasis ℝ E) i, x⟫ • (stdOrthonormalBasis ℝ E) i = x :=
    (stdOrthonormalBasis ℝ E).sum_repr' x
  calc ∑ i, ⟪x, (stdOrthonormalBasis ℝ E) i⟫ * L ((stdOrthonormalBasis ℝ E) i)
      = L (∑ i, ⟪(stdOrthonormalBasis ℝ E) i, x⟫ • (stdOrthonormalBasis ℝ E) i) := by
        rw [map_sum]
        refine Finset.sum_congr rfl fun i _ => ?_
        rw [map_smul, real_inner_comm]
        simp
    _ = L x := by rw [hx]
