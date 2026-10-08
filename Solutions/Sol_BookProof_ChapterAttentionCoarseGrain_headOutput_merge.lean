-- Generated from ChapterAttentionCoarseGrain.lean — solution of BookProof.ChapterAttentionCoarseGrain.headOutput_merge
import Mathlib
import Definitions.Def_ChapterAttentionCoarseGrain
import Theorems.Thm_BookProof_ChapterAttentionCoarseGrain_observableExpectation_merge
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterAttentionOutput
open BookProof.ChapterAttentionCoarseGrain



open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (f : Fin m → Fin r) (v : Fin r → E) :
    observableExpectation (mergeWeights f (scoreSoftmax beta s)) v
      = headOutput beta s (fun x => v (f x)) := observableExpectation_merge f (scoreSoftmax beta s) v
