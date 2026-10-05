-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.smul_invCLMAt_sub_of_mem
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_eq_of_mem
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
    (a : ℂ) • invCLMAt hT ha h - h = -invCLMAt hT ha k := by

  have hx : invCLMAt hT ha ((a : ℂ) • h + k) = h := by
    refine invCLMAt_eq_of_mem hT ha ?_
    simpa using hk
  rw [map_add, map_smul] at hx
  have h2 : (a : ℂ) • invCLMAt hT ha h - h + invCLMAt hT ha k = 0 := by
    rw [sub_add_eq_add_sub, hx, sub_self]
  exact add_eq_zero_iff_eq_neg.mp h2
