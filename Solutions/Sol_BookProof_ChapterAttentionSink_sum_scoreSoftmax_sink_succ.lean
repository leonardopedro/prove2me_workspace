-- Generated from ChapterAttentionSink.lean — solution of BookProof.ChapterAttentionSink.sum_scoreSoftmax_sink_succ
import Mathlib
import Definitions.Def_ChapterAttentionSink
import Theorems.Thm_BookProof_ChapterAttentionSink_scoreSoftmax_sink_succ
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_sum_one
open BookProof.ChapterAttentionSink



open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta s0 : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    ∑ j : Fin m, scoreSoftmax beta (Fin.cons s0 s) j.succ = 1 - sinkWeight beta s0 s := by

  calc ∑ j : Fin m, scoreSoftmax beta (Fin.cons s0 s) j.succ
      = ∑ j, (1 - sinkWeight beta s0 s) * scoreSoftmax beta s j :=
        Finset.sum_congr rfl fun j _ => scoreSoftmax_sink_succ beta s0 s j
    _ = (1 - sinkWeight beta s0 s) * ∑ j, scoreSoftmax beta s j := by
        rw [Finset.mul_sum]
    _ = 1 - sinkWeight beta s0 s := by
        rw [scoreSoftmax_sum_one beta s i, mul_one]
