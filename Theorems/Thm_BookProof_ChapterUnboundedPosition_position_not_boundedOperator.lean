-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.position_not_boundedOperator
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

fun k => ?_)
  exact ((mulOp_adjoint_apply f h).1 k).symm

theorem BookProof.ChapterUnboundedPosition.position_not_boundedOperator :
    ¬ ∃ T : L2Z →L[ℂ] L2Z, ∀ psi : mulDomain po := by sorry
