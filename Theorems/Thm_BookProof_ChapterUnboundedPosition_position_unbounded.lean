-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.position_unbounded
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

   simp [lp.single_apply]
  · simp [lp.single_apply, hk]

theorem BookProof.ChapterUnboundedPosition.position_unbounded :
    ¬ ∃ C : ℝ, ∀ psi : mulDomain positionField, := by sorry
