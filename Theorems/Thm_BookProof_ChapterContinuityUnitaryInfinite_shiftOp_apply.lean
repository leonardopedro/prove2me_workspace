-- Generated from ChapterContinuityUnitaryInfinite.lean — theorem BookProof.ChapterContinuityUnitaryInfinite.shiftOp_apply
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite


open scoped ENNReal InnerProductSpace

theorem BookProof.ChapterContinuityUnitaryInfinite.shiftOp_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftOp m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := by sorry
