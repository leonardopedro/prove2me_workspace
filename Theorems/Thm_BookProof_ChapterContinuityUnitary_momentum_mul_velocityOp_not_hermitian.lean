-- Generated from ChapterContinuityUnitary.lean — theorem BookProof.ChapterContinuityUnitary.momentum_mul_velocityOp_not_hermitian
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]


open scoped BigOperators Matrix TensorProduct



theorem BookProof.ChapterContinuityUnitary.momentum_mul_velocityOp_not_hermitian :
    (momentum 3 * velocityOp (fun k => (k.val : ℝ)))ᴴ
      ≠ momentum 3 * velocityOp (fun k => (k.val : ℝ)) := by sorry
