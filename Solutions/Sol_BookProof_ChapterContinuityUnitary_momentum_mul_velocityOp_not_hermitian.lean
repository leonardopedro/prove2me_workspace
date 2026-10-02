-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.momentum_mul_velocityOp_not_hermitian
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
theorem solution :
    (momentum 3 * velocityOp (fun k => (k.val : ℝ)))ᴴ
      ≠ momentum 3 * velocityOp (fun k => (k.val : ℝ)) := by

  set M : Matrix (ZMod 3) (ZMod 3) ℂ := momentum 3 * velocityOp (fun k => (k.val : ℝ))
    with hM
  intro h
  have e10 : momentum 3 1 0 = Complex.I / 2 := by
    have h1 : ¬((0 : ZMod 3) = 1 + 1) := by decide
    have h2 : (0 : ZMod 3) = 1 - 1 := by decide
    show (if (0 : ZMod 3) = 1 + 1 then -Complex.I / 2 else 0)
        + (if (0 : ZMod 3) = 1 - 1 then Complex.I / 2 else 0) = Complex.I /
