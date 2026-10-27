-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.norm_expU_sub_self_le
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_expU_zero_op
open BookProof.NonnegUnitaryGroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hB : IsSelfAdjoint B) (t : ℝ) (x : F) :
    ‖expU B t x - x‖ ≤ |t| * ‖B x‖ := by

  have h := norm_expU_sub_apply_le hB (C := 0) (IsSelfAdjoint.zero _) (Commute.zero_right B) t x
  simpa [expU_zero_op] using h
