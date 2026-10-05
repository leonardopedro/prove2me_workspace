-- Generated from ChapterAttentionCoarseGrain.lean — theorem BookProof.ChapterAttentionCoarseGrain.mergeWeights_scoreSoftmax_of_fiber_const
import Definitions.Def_ChapterObservableExpectation
import Mathlib
import Definitions.Def_ChapterAttentionCoarseGrain
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionCoarseGrain

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterAttentionCoarseGrain.mergeWeights_scoreSoftmax_of_fiber_const (beta : ℝ) (f : Fin m → Fin r)
    (t : Fin r → ℝ) (y : Fin r) :
    mergeWeights f (scoreSoftmax beta (fun x => t (f x))) y
      = ((Finset.univ.filter (fun x => f x = y)).card : ℝ) * Real.exp (beta * t y)
        / ∑ z, ((Finset.univ.filter (fun x => f x = z)).card : ℝ) * Real.exp (beta * t z) := by sorry
