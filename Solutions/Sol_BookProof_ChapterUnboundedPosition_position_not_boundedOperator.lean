-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.position_not_boundedOperator
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Theorems.Thm_BookProof_ChapterUnboundedPosition_position_unbounded
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
fun k => ?_)
  exact ((mulOp_adjoint_apply f h).1 k).symm

theorem solution :
    ¬ ∃ T : L2Z →L[ℂ] L2Z, ∀ psi : mulDomain po := 
