-- Generated from ChapterGaugeShiftExample.lean — solution of BookProof.ChapterGaugeShiftExample.velocityOp_commute
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
open BookProof.ChapterGaugeShiftExample



open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution (v w : LinfZ) :
    velocityOp v * velocityOp w = velocityOp w * velocityOp v := by

  ext f k
  simp only [ContinuousLinearMap.mul_apply, velocityOp_apply]
  ring
