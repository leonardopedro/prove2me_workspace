-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.norm_smul_invCLMAt_sub_le
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_smul_invCLMAt_sub_of_mem
import Theorems.Thm_BookProof_NonnegSquareRoot_norm_invCLMAt_le
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) {h k : F}
    (hk : (h, k) ∈ T) :
    ‖(a : ℂ) • invCLMAt hT ha h - h‖ ≤ a⁻¹ * ‖k‖ := by

  rw [smul_invCLMAt_sub_of_mem hT ha hk, norm_neg]
  exact norm_invCLMAt_le hT ha k
