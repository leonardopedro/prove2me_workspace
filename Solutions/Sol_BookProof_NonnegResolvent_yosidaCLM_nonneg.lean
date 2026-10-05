-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.yosidaCLM_nonneg
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_smul_invCLMAt_le_one
import Theorems.Thm_BookProof_NonnegResolvent_smul_nonneg_of_nonneg
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) : 0 ≤ yosidaCLM hT ha := smul_nonneg_of_nonneg ha.le (sub_nonneg.2 (smul_invCLMAt_le_one hT ha))
