-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.invCLMAt_comm
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
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (hb : 0 < b) (h : F) :
    invCLMAt hT ha (invCLMAt hT hb h) = invCLMAt hT hb (invCLMAt hT ha h) := by

  rcases eq_or_ne a b with rfl | hne
  · rfl
  · have h1 := invCLMAt_sub hT ha hb h
    have h2 := invCLMAt_sub hT hb ha h
    have hc : ((b : ℂ) - (a : ℂ)) ≠ 0 := by
      intro hh
      exact hne (by exact_mod_cast (sub_eq_zero.1 hh).symm)
    have e2 : ((b : ℂ) - (a : ℂ)) • invCLMAt hT hb (invCLMAt hT ha h)
        = invCLMAt hT ha h - invCLMAt hT hb h := by
      rw [show ((b : ℂ) - (a : ℂ)) = -((a : ℂ) - (b : ℂ)) by ring, neg_smul, ← h2]
      abel
    exact smul_right_injective F hc (h1.symm.trans e2.symm)
