-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.commute_approxS_invCLMAt
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
import Theorems.Thm_BookProof_NonnegSemigroupGenerator_commute_yosidaAt_invCLMAt
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (n : ℕ) (t : ℝ) {b : ℝ}
    (hb : 0 < b) : Commute (approxS hT n t) (invCLMAt hT hb) := ((commute_yosidaAt_invCLMAt hT n hb).smul_left (-t : ℝ)).exp_left
