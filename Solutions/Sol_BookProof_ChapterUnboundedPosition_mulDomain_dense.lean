-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.mulDomain_dense
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Theorems.Thm_BookProof_ChapterUnboundedPosition_sum_single_mem_mulDomain
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
Submodule.sum_mem _ fun i _ => single_mem_mulDomain f i _

theorem solution (f : ℤ → :=
  ℝ) : Dense ((mulDomain f : Submodule ℂ L2Z) : Set L2Z) := by
    intro psi
    refine mem_closure_of_tendsto (lp.hasSum_single (by simp) psi) ?_
    f
