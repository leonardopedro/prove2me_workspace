-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.position_not_boundedOperator
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterF7
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterF7
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

theorem BookProof.ChapterUnboundedPosition.position_not_boundedOperator :
    ¬ ∃ T : L2Z →L[ℂ] L2Z, ∀ psi : mulDomain positionField,
      mulOp positionField psi = T (psi : L2Z) := by sorry
