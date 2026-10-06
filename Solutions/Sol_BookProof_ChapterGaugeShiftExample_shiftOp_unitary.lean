-- Generated from ChapterGaugeShiftExample.lean — solution of BookProof.ChapterGaugeShiftExample.shiftOp_unitary
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
import Theorems.Thm_BookProof_ChapterGaugeShiftExample_shiftOp_mul
import Theorems.Thm_BookProof_ChapterGaugeShiftExample_shiftOp_adjoint
open BookProof.ChapterGaugeShiftExample



open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution (m : ℤ) : shiftOp m ∈ unitary (L2Z →L[ℂ] L2Z) := by

  constructor <;>
    simp only [ContinuousLinearMap.star_eq_adjoint, shiftOp_adjoint,
      shiftOp_mul, neg_add_cancel, add_neg_cancel, shiftOp_zero]
