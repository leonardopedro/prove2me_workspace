-- Generated from ChapterAttentionSink.lean — solution of BookProof.ChapterAttentionSink.shannonEntropy_sink
import Mathlib
import Definitions.Def_ChapterAttentionSink
import Theorems.Thm_BookProof_ChapterAttentionSink_sinkWeight_lt_one
import Theorems.Thm_BookProof_ChapterAttentionSink_scoreSoftmax_sink_succ
import Theorems.Thm_BookProof_ChapterAttentionSink_shannonEntropy_cons_scaled
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_pos
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_sum_one
open BookProof.ChapterAttentionSink



open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta s0 : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    shannonEntropy (scoreSoftmax beta (Fin.cons s0 s))
      = (-sinkWeight beta s0 s * Real.log (sinkWeight beta s0 s)
          - (1 - sinkWeight beta s0 s) * Real.log (1 - sinkWeight beta s0 s))
        + (1 - sinkWeight beta s0 s) * shannonEntropy (scoreSoftmax beta s) := by

  have hcons : (scoreSoftmax beta (Fin.cons s0 s) : Fin (m + 1) → ℝ)
      = Fin.cons (sinkWeight beta s0 s)
          (fun j => (1 - sinkWeight beta s0 s) * scoreSoftmax beta s j) := by
    funext l
    refine Fin.cases ?_ ?_ l
    · simp [sinkWeight]
    · intro j
      simpa using scoreSoftmax_sink_succ beta s0 s j
  rw [hcons]
  exact shannonEntropy_cons_scaled (sinkWeight_lt_one beta s0 s i)
    (fun j => scoreSoftmax_pos beta s j) (scoreSoftmax_sum_one beta s i)
