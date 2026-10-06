-- Generated from ChapterGaugeShiftExample.lean — solution of BookProof.ChapterGaugeShiftExample.expectation_shift_invariant
import Mathlib
import Definitions.Def_ChapterGaugeShiftExample
open BookProof.ChapterGaugeShiftExample



open scoped InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
theorem solution {A : L2Z →L[ℂ] L2Z}
    (hA : ∀ m : ℤ, A * shiftOp m = shiftOp m * A) (m : ℤ) (f : L2Z) :
    ⟪shiftOp m f, A (shiftOp m f)⟫_ℂ = ⟪f, A f⟫_ℂ := by

  have hcomm : A (shiftOp m f) = shiftOp m (A f) := by
    have := congrArg (fun T : L2Z →L[ℂ] L2Z => T f) (hA m)
    simpa [ContinuousLinearMap.mul_apply] using this
  rw [hcomm]
  exact (shiftEquiv m).inner_map_map f (A f)
