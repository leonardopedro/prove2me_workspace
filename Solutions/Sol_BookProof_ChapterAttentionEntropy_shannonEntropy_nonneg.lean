-- Generated from ChapterAttentionEntropy.lean — solution of BookProof.ChapterAttentionEntropy.shannonEntropy_nonneg
import Mathlib
import Definitions.Def_ChapterAttentionEntropy
open BookProof.ChapterAttentionEntropy



open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hp1 : ∀ j, p j ≤ 1) :
    0 ≤ shannonEntropy p := by

  rw [shannonEntropy, neg_nonneg]
  refine Finset.sum_nonpos fun j _ => ?_
  rcases eq_or_lt_of_le (hp0 j) with h | h
  · simp [← h]
  · exact mul_nonpos_of_nonneg_of_nonpos h.le (Real.log_nonpos h.le (hp1 j))
