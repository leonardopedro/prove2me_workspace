-- Generated from ChapterResidualStream.lean — solution of BookProof.ChapterResidualStream.norm_sub_residual_ge
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
    (1 - L) * ‖x - y‖ ≤ ‖residual f x - residual f y‖ := by

  have hrw : residual f x - residual f y = (x - y) + (f x - f y) := by
    rw [residual, residual]
    abel
  have h1 : ‖x - y‖ ≤ ‖(x - y) + (f x - f y)‖ + ‖f x - f y‖ := by
    simpa using norm_sub_le ((x - y) + (f x - f y)) (f x - f y)
  have h2 := hf x y
  rw [hrw]
  linarith
