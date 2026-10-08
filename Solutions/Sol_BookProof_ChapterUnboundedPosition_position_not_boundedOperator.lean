-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.position_not_boundedOperator
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Theorems.Thm_BookProof_ChapterUnboundedPosition_position_unbounded
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ T : L2Z →L[ℂ] L2Z, ∀ psi : mulDomain positionField,
      mulOp positionField psi = T (psi : L2Z) :=
  sitionField,
        mulOp positionField psi = T (psi : L2Z) := by
    rintro ⟨T, hT⟩
    refine position_unbounded ⟨
