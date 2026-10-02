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
        + (if (0 : ZMod 3) = 1 - 1 then Complex.I / 2 else 0) = Complex.I / 2
    rw [if_neg h1, if_pos h2]
    ring
  have e01 : momentum 3 0 1 = -Complex.I / 2 := by
    have h1 : (1 : ZMod 3) = 0 + 1 := by decide
    have h2 : ¬((1 : ZMod 3) = 0 - 1) := by decide
    show (if (1 : ZMod 3) = 0 + 1 then -Complex.I / 2 else 0)
        + (if (1 : ZMod 3) = 0 - 1 then Complex.I / 2 else 0) = -Complex.I / 2
    rw [if_pos h1, if_neg h2]
    ring
  have v1 : (1 : ZMod 3).val = 1 := by decide
  have h10 : M 1 0 = 0 := by
    rw [hM, velocityOp, Matrix.mul_diagonal, e10]
    simp
  have h01e : M 0 1 = -Complex.I / 2 := by
    rw [hM, velocityOp, Matrix.mul_diagonal, e01]
    simp only [v1]
    simp
  have h01 : Mᴴ 0 1 = M 0 1 := by rw [h]
  rw [Matrix.conjTranspose_apply, h10, h01e] at h01
  simp only [star_zero] at h01
  exact absurd h01 (by intro hh; exact absurd (congrArg Complex.im hh) (by norm_num))
