-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.expU_zero_op
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
open BookProof.NonnegUnitaryGroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : expU (0 : F →L[ℂ] F) t = 1 := by

  simp [expU]
