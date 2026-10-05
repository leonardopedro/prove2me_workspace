-- Generated from ChapterAttentionCoarseGrain.lean — solution of BookProof.ChapterAttentionCoarseGrain.observableExpectation_merge
import Mathlib
import Definitions.Def_ChapterAttentionCoarseGrain
open BookProof.ChapterAttentionCoarseGrain



open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (f : Fin m → Fin r) (p : Fin m → ℝ) (v : Fin r → E) :
    observableExpectation (mergeWeights f p) v
      = observableExpectation p (fun x => v (f x)) := by

  have hstep : ∀ y : Fin r, mergeWeights f p y • v y
      = ∑ x ∈ Finset.univ.filter (fun x => f x = y), p x • v (f x) := by
    intro y
    rw [mergeWeights, Finset.sum_smul]
    refine Finset.sum_congr rfl fun x hx => ?_
    rw [(Finset.mem_filter.mp hx).2]
  calc observableExpectation (mergeWeights f p) v
      = ∑ y, mergeWeights f p y • v y := rfl
    _ = ∑ y, ∑ x ∈ Finset.univ.filter (fun x => f x = y), p x • v (f x) :=
        Finset.sum_congr rfl fun y _ => hstep y
    _ = ∑ x, p x • v (f x) :=
        Finset.sum_fiberwise Finset.univ f (fun x => p x • v (f x))
    _ = observableExpectation p (fun x => v (f x)) := rfl
