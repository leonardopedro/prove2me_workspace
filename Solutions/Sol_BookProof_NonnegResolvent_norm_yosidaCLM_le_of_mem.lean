-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.norm_yosidaCLM_le_of_mem
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_norm_smul_invCLMAt_le
import Theorems.Thm_BookProof_NonnegResolvent_yosidaCLM_of_mem
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) {h k : F}
    (hk : (h, k) ∈ T) : ‖yosidaCLM hT ha h‖ ≤ ‖k‖ := by

  rw [yosidaCLM_of_mem hT ha hk]
  exact norm_smul_invCLMAt_le hT ha k
