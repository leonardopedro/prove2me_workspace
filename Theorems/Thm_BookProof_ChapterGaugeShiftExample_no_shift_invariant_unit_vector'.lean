-- Generated from ChapterGaugeShiftExample.lean — theorem BookProof.ChapterGaugeShiftExample.no_shift_invariant_unit_vector'
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterGaugeShiftExample


open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

theorem BookProof.ChapterGaugeShiftExample.no_shift_invariant_unit_vector_prime :
    ¬ ∃ f : L2Z, ‖f‖ = 1 ∧ ∀ m : ℤ, shiftOp m f = f := by sorry
