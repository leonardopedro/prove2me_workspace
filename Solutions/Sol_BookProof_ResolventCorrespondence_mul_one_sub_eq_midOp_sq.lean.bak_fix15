-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.mul_one_sub_eq_midOp_sq
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.UnboundedPolar BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (h0 : 0 ≤ R) (h1 : R ≤ 1) :
    R * (1 - R) = midOp R * midOp R := by

  have hS : sqrtOp R * sqrtOp R = R := sqrtOp_mul_self h0 h1
  have hD : coSqrtOp R * coSqrtOp R = 1 - R := coSqrtOp_mul_self h0 h1
  have hSD : sqrtOp R * coSqrtOp R = midOp R := sqrtOp_mul_coSqrtOp h0
  have hDS : coSqrtOp R * sqrtOp R = midOp R := coSqrtOp_mul_sqrtOp h0
  calc R * (1 - R) = (sqrtOp R * sqrtOp R) * (coSqrtOp R * coSqrtOp R) := by rw [hS, hD]
    _ = sqrtOp R * (sqrtOp R * coSqrtOp R) * coSqrtOp R := by
        simp only [mul_assoc]
    _ = sqrtOp R * (coSqrtOp R * sqrtOp R) * coSqrtOp R := by rw [hSD, hDS]
    _ = (sqrtOp R * coSqrtOp R) * (sqrtOp R * coSqrtOp R) := by
        simp only [mul_assoc]
    _ = midOp R * midOp R := by rw [hSD]
