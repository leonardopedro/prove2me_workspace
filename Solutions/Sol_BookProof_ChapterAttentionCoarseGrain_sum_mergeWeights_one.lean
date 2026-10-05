-- Generated from ChapterAttentionCoarseGrain.lean — solution of BookProof.ChapterAttentionCoarseGrain.sum_mergeWeights_one
import Mathlib
import Definitions.Def_ChapterAttentionCoarseGrain
import Theorems.Thm_BookProof_ChapterAttentionCoarseGrain_sum_mergeWeights
open BookProof.ChapterAttentionCoarseGrain



open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {f : Fin m → Fin r} {p : Fin m → ℝ} (hp : ∑ x, p x = 1) :
    ∑ y, mergeWeights f p y = 1 := by

  rw [sum_mergeWeights, hp]
