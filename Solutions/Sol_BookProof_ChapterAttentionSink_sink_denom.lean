-- Generated from ChapterAttentionSink.lean — solution of BookProof.ChapterAttentionSink.sink_denom
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
    ∑ l, Real.exp (beta * (Fin.cons s0 s : Fin (m + 1) → ℝ) l)
      = Real.exp (beta * s0) + ∑ l, Real.exp (beta * s l) := by

  rw [Fin.sum_univ_succ]
  simp
