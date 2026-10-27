-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.yosidaCLM_of_mem
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_smul_invCLMAt_sub_of_mem
import Theorems.Thm_BookProof_NonnegResolvent_yosidaCLM_apply
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
    yosidaCLM hT ha h = (a : ℂ) • invCLMAt hT ha k := by

  have h1 := smul_invCLMAt_sub_of_mem hT ha hk
  have h2 : h - (a : ℂ) • invCLMAt hT ha h = invCLMAt hT ha k := by
    rw [← neg_sub, h1, neg_neg]
  rw [yosidaCLM_apply, h2]
