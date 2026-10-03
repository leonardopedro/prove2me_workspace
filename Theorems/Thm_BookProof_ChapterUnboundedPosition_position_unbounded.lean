-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.position_unbounded
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterF7
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterF7
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

theorem BookProof.ChapterUnboundedPosition.position_unbounded :
    ¬ ∃ C : ℝ, ∀ psi : mulDomain positionField,
      ‖mulOp positionField psi‖ ≤ C * ‖(psi : L2Z)‖ := by sorry
