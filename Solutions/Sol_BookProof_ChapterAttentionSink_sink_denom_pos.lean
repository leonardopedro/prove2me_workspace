-- Generated from ChapterAttentionSink.lean — solution of BookProof.ChapterAttentionSink.sink_denom_pos
import Mathlib
import Definitions.Def_ChapterAttentionSink
open BookProof.ChapterAttentionSink



open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta s0 : ℝ) (s : Fin m → ℝ) :
    0 < Real.exp (beta * s0) + ∑ l, Real.exp (beta * s l) := by

  have : (0 : ℝ) ≤ ∑ l, Real.exp (beta * s l) :=
    Finset.sum_nonneg fun _ _ => (Real.exp_pos _).le
  linarith [Real.exp_pos (beta * s0)]
