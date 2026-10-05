-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.hasDerivAt_expU_apply
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_ChapterStoneResolvent_hasDerivAt_apply
open BookProof.NonnegUnitaryGroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (B : F →L[ℂ] F) (t : ℝ) (x : F) :
    HasDerivAt (fun s : ℝ => expU B s x) ((expU B t) (((-Complex.I) • B) x)) t := hasDerivAt_apply x (hasDerivAt_expU B t)
