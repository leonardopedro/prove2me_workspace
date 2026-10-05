-- Generated from ChapterAttentionCoarseGrain.lean — solution of BookProof.ChapterAttentionCoarseGrain.sum_mergeWeights_log
import Mathlib
import Definitions.Def_ChapterAttentionCoarseGrain
open BookProof.ChapterAttentionCoarseGrain



open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (f : Fin m → Fin r) (p : Fin m → ℝ) :
    ∑ y, mergeWeights f p y * Real.log (mergeWeights f p y)
      = ∑ x, p x * Real.log (mergeWeights f p (f x)) := by

  have hstep : ∀ y : Fin r, mergeWeights f p y * Real.log (mergeWeights f p y)
      = ∑ x ∈ Finset.univ.filter (fun x => f x = y),
          p x * Real.log (mergeWeights f p (f x)) := by
    intro y
    have h1 : ∑ x ∈ Finset.univ.filter (fun x => f x = y),
          p x * Real.log (mergeWeights f p (f x))
        = ∑ x ∈ Finset.univ.filter (fun x => f x = y), p x * Real.log (mergeWeights f p y) :=
      Finset.sum_congr rfl fun x hx => by rw [(Finset.mem_filter.mp hx).2]
    rw [h1, ← Finset.sum_mul]
    rfl
  calc ∑ y, mergeWeights f p y * Real.log (mergeWeights f p y)
      = ∑ y, ∑ x ∈ Finset.univ.filter (fun x => f x = y),
          p x * Real.log (mergeWeights f p (f x)) :=
        Finset.sum_congr rfl fun y _ => hstep y
    _ = ∑ x, p x * Real.log (mergeWeights f p (f x)) :=
        Finset.sum_fiberwise Finset.univ f
          (fun x => p x * Real.log (mergeWeights f p (f x)))
