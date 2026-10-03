-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.single_mem_mulDomain
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) (n : ℤ) (c : ℂ) :
    lp.single 2 n c ∈ mulDomain f :=
   (n : ℤ) (c : ℂ) :
      lp.single 2 n c ∈ mulDomain f := by
    refine memℓp_gen (summable_of_ne_finset_zero (s := {n}) ?_)
    intro j hj
    have hjn :
