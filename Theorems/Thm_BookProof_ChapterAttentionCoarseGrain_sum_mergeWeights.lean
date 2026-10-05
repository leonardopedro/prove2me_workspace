-- Generated from ChapterAttentionCoarseGrain.lean — theorem BookProof.ChapterAttentionCoarseGrain.sum_mergeWeights
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionCoarseGrain
open BookProof.ChapterAttentionCoarseGrain

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterAttentionCoarseGrain.sum_mergeWeights (f : Fin m → Fin r) (p : Fin m → ℝ) :
    ∑ y, mergeWeights f p y = ∑ x, p x := by sorry
