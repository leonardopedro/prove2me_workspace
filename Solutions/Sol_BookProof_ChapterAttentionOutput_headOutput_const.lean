-- Generated from ChapterAttentionOutput.lean — solution of BookProof.ChapterAttentionOutput.headOutput_const
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_sum_one
open BookProof.ChapterAttentionOutput



open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (w : E) (i : Fin m) :
    headOutput beta s (fun _ => w) = w := observableExpectation_const _ (scoreSoftmax_sum_one beta s i) w
