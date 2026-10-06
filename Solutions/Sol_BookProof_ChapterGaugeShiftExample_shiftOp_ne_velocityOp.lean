-- Generated from ChapterGaugeShiftExample.lean — solution of BookProof.ChapterGaugeShiftExample.shiftOp_ne_velocityOp
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
open BookProof.ChapterGaugeShiftExample



open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution {m : ℤ} (hm : m ≠ 0) (v : LinfZ) :
    shiftOp m ≠ velocityOp v := by

  intro h
  have h1 := congrArg
    (fun T : L2Z →L[ℂ] L2Z => ((T (basisVecL2 0) : L2Z) : ℤ → ℂ) (-m)) h
  simp only [shiftOp_apply, velocityOp_apply, basisVecL2] at h1
  rw [neg_add_cancel, lp.single_apply, lp.single_apply] at h1
  simp [hm] at h1
