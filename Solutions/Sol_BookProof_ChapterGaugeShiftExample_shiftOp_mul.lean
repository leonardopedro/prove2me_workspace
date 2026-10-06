-- Generated from ChapterGaugeShiftExample.lean — solution of BookProof.ChapterGaugeShiftExample.shiftOp_mul
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
open BookProof.ChapterGaugeShiftExample



open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution (m n : ℤ) :
    shiftOp m * shiftOp n = shiftOp (m + n) := by

  ext f k
  change ((shiftOp m (shiftOp n f) : L2Z) : ℤ → ℂ) k
      = ((shiftOp (m + n) f : L2Z) : ℤ → ℂ) k
  simp only [shiftOp_apply]
  have hk : k + m + n = k + (m + n) := by ring
  rw [hk]
