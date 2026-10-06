-- Generated from ChapterGaugeShiftExample.lean — theorem BookProof.ChapterGaugeShiftExample.shift_gauge_symmetry_headline
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterGaugeShiftExample


open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

theorem BookProof.ChapterGaugeShiftExample.shift_gauge_symmetry_headline :
    (∀ m : ℤ, m ≠ 0 → ∀ f : L2Z, f ≠ 0 → shiftOp m f ≠ f) ∧
    (¬ ∃ f : L2Z, ‖f‖ = 1 ∧ ∀ m : ℤ, shiftOp m f = f) ∧
    (∀ m n : ℤ, shiftOp m * shiftOp n = shiftOp n * shiftOp m) ∧
    (∀ A : L2Z →L[ℂ] L2Z, (∀ m : ℤ, A * shiftOp m = shiftOp m * A) →
      ∀ (m : ℤ) (f : L2Z), ⟪shiftOp m f, A (shiftOp m f)⟫_ℂ = ⟪f, A f⟫_ℂ) := by sorry
