-- Generated from ChapterResidualStream.lean — solution of BookProof.ChapterResidualStream.norm_residual_sub_le
import Mathlib
import Definitions.Def_ChapterResidualStream
open BookProof.ChapterResidualStream



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterAttentionOutput

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution {f : E → E} {L : ℝ}
    (hf : ∀ x y, ‖f x - f y‖ ≤ L * ‖x - y‖) (x y : E) :
    ‖residual f x - residual f y‖ ≤ (1 + L) * ‖x - y‖ := by

  have hrw : residual f x - residual f y = (x - y) + (f x - f y) := by
    rw [residual, residual]
    abel
  have h1 : ‖(x - y) + (f x - f y)‖ ≤ ‖x - y‖ + ‖f x - f y‖ := norm_add_le _ _
  have h2 := hf x y
  rw [hrw]
  linarith
