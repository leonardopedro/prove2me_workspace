-- Generated from ChapterGaugeShiftExample.lean — solution of BookProof.ChapterGaugeShiftExample.no_shift_invariant_unit_vector'
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
import Theorems.Thm_BookProof_ChapterGaugeShiftExample_shiftOp_eq_self_iff
open BookProof.ChapterGaugeShiftExample



open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ f : L2Z, ‖f‖ = 1 ∧ ∀ m : ℤ, shiftOp m f = f := by

  rintro ⟨f, hnorm, hinv⟩
  have h0 : f = 0 := shiftOp_eq_self_iff (m := 1) one_ne_zero (hinv 1)
  rw [h0, norm_zero] at hnorm
  exact one_ne_zero hnorm.symm
