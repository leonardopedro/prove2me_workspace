-- Generated from ChapterAttentionCoarseGrain.lean — theorem BookProof.ChapterAttentionCoarseGrain.headOutput_merge
import Mathlib
import Definitions.Def_ChapterAttentionCoarseGrain
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterObservableExpectation
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionCoarseGrain


open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionOutput

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionCoarseGrain.headOutput_merge (beta : ℝ) (s : Fin m → ℝ) (f : Fin m → Fin r) (v : Fin r → E) :
    observableExpectation (mergeWeights f (scoreSoftmax beta s)) v
      = headOutput beta s (fun x => v (f x)) := by sorry
