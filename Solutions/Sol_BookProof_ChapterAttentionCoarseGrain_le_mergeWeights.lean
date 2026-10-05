-- Generated from ChapterAttentionCoarseGrain.lean — solution of BookProof.ChapterAttentionCoarseGrain.le_mergeWeights
import Mathlib
import Definitions.Def_ChapterAttentionCoarseGrain
open BookProof.ChapterAttentionCoarseGrain



open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m r : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {f : Fin m → Fin r} {p : Fin m → ℝ} (hp : ∀ x, 0 ≤ p x) (x : Fin m) :
    p x ≤ mergeWeights f p (f x) := by

  refine Finset.single_le_sum (f := p) (fun z _ => hp z) ?_
  simp
