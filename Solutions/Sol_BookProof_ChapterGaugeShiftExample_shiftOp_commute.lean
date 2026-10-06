-- Generated from ChapterGaugeShiftExample.lean — solution of BookProof.ChapterGaugeShiftExample.shiftOp_commute
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
import Theorems.Thm_BookProof_ChapterGaugeShiftExample_shiftOp_mul
open BookProof.ChapterGaugeShiftExample



open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution (m n : ℤ) : shiftOp m * shiftOp n = shiftOp n * shiftOp m := by

  rw [shiftOp_mul, shiftOp_mul, add_comm]
