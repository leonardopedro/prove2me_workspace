-- Generated from ChapterNonnegSemigroup.lean — solution of BookProof.NonnegSemigroup.norm_expNeg_sub_self_le
import Mathlib
import Definitions.Def_ChapterNonnegSemigroup
open BookProof.NonnegSemigroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : F →L[ℂ] F) (hA : 0 ≤ A) {t : ℝ} (ht : 0 ≤ t) (x : F) :
    ‖expNeg A t x - x‖ ≤ t * ‖A x‖ := by

  have h := norm_expNeg_sub_expNeg_le A 0 hA le_rfl (Commute.zero_right A) ht x
  simpa using h
