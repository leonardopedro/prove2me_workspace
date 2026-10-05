-- Generated from ChapterNonnegSemigroup.lean — solution of BookProof.NonnegSemigroup.isSelfAdjoint_approxS
import Mathlib
import Definitions.Def_ChapterNonnegSemigroup
import Theorems.Thm_BookProof_NonnegSemigroup_isSelfAdjoint_expNeg
open BookProof.NonnegSemigroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (n : ℕ) (t : ℝ) :
    IsSelfAdjoint (approxS hT n t) := isSelfAdjoint_expNeg (isSelfAdjoint_yosidaAt hT n) t
