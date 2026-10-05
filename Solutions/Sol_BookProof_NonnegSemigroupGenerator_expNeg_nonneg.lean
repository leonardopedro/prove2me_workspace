-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.expNeg_nonneg
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegSemigroup_expNeg_add
import Theorems.Thm_BookProof_NonnegSemigroup_isSelfAdjoint_expNeg
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) (t : ℝ) : 0 ≤ expNeg A t := by

  set B := expNeg A (t / 2) with hB
  have hBsa : IsSelfAdjoint B := isSelfAdjoint_expNeg hA _
  have hsq : expNeg A t = B * B := by
    rw [hB, ← expNeg_add]
    norm_num
  rw [hsq, ContinuousLinearMap.nonneg_iff_isPositive]
  have hsa : IsSelfAdjoint (B * B) := by
    change star (B * B) = B * B
    rw [star_mul, hBsa.star_eq]
  refine ⟨ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.1 hsa, fun x => ?_⟩
  have hsym : (inner ℂ (B (B x)) x : ℂ) = inner ℂ (B x) (B x) :=
    (ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.1 hBsa) (B x) x
  have hval : (B * B) x = B (B x) := rfl
  simp only [ContinuousLinearMap.reApplyInnerSelf, hval, hsym]
  simpa using inner_self_nonneg (𝕜 := ℂ) (x := B x)
