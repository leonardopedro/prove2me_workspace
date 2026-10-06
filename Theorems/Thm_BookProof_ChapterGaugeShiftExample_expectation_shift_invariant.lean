-- Generated from ChapterGaugeShiftExample.lean — theorem BookProof.ChapterGaugeShiftExample.expectation_shift_invariant
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterGaugeShiftExample


open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

theorem BookProof.ChapterGaugeShiftExample.expectation_shift_invariant {A : L2Z →L[ℂ] L2Z}
    (hA : ∀ m : ℤ, A * shiftOp m = shiftOp m * A) (m : ℤ) (f : L2Z) :
    ⟪shiftOp m f, A (shiftOp m f)⟫_ℂ = ⟪f, A f⟫_ℂ := by sorry
