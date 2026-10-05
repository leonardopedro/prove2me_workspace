-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.invCLMAt_sub_eq
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_invCLMAt_sub
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (hb : 0 < b) :
    invCLMAt hT ha - invCLMAt hT hb = ((b : ℂ) - (a : ℂ)) • (invCLMAt hT ha * invCLMAt hT hb) := by

  ext h
  simpa using invCLMAt_sub hT ha hb h
