-- Generated from ChapterAttentionOutput.lean — solution of BookProof.ChapterAttentionOutput.headOutput_mem_convexHull
import Mathlib
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterAttentionOutput



open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) (i : Fin m) :
    headOutput beta s v ∈ convexHull ℝ (Set.range v) :=
  prob_weighted_sum_mem_convexHull _ (fun j => scoreSoftmax_nonneg beta s j)
      (scoreSoftmax_sum_one beta s i) v
