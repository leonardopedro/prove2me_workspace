-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.mulOp_single
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

 -/
def positionField : ℤ → ℝ := fun k => (k : ℝ)

theorem BookProof.ChapterUnboundedPosition.mulOp_single (f : ℤ → ℝ) (n : ℤ) (c : ℂ) :
    mulOp f ⟨lp.single 2 n c, singl := by sorry
