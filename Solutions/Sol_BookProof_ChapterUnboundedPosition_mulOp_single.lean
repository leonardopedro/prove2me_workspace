-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.mulOp_single
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Theorems.Thm_BookProof_ChapterUnboundedPosition_single_mem_mulDomain
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) (n : ℤ) (c : ℂ) :
    mulOp f ⟨lp.single 2 n c, single_mem_mulDomain f n c⟩ = lp.single 2 n ((f n : ℂ) * c) :=
  e_mem_mulDomain f n c⟩ = lp.single 2 n ((f n : ℂ) * c) := by
    ext k
    by_cases hk : k = n
    · subst hk
