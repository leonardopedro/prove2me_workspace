-- Generated from ChapterNonnegSemigroup.lean — solution of BookProof.NonnegSemigroup.approxS_add
import Mathlib
import Definitions.Def_ChapterNonnegSemigroup
import Theorems.Thm_BookProof_NonnegSemigroup_expNeg_add
open BookProof.NonnegSemigroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (n : ℕ) (s t : ℝ) :
    approxS hT n (s + t) = approxS hT n s * approxS hT n t := expNeg_add _ s t
