-- Generated from ChapterGaugeShiftExample.lean — solution of BookProof.ChapterGaugeShiftExample.shiftOp_adjoint
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_inner_shiftOp_left
open BookProof.ChapterGaugeShiftExample



open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution (m : ℤ) :
    ContinuousLinearMap.adjoint (shiftOp m) = shiftOp (-m) := by

  symm
  rw [ContinuousLinearMap.eq_adjoint_iff]
  intro f g
  have h := inner_shiftOp_left (-m) f g
  simpa using h
