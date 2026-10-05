-- Generated from ChapterAttentionSink.lean — solution of BookProof.ChapterAttentionSink.scoreSoftmax_sink_lt
import Mathlib
import Definitions.Def_ChapterAttentionSink
import Theorems.Thm_BookProof_ChapterAttentionSink_sinkWeight_pos
import Theorems.Thm_BookProof_ChapterAttentionSink_scoreSoftmax_sink_succ
open BookProof.ChapterAttentionSink



open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta s0 : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (Fin.cons s0 s) j.succ < scoreSoftmax beta s j := by

  rw [scoreSoftmax_sink_succ]
  have hw := sinkWeight_pos beta s0 s
  have hp := scoreSoftmax_pos beta s j
  nlinarith
