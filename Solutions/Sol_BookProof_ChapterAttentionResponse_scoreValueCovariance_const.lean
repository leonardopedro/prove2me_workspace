-- Generated from ChapterAttentionResponse.lean — solution of BookProof.ChapterAttentionResponse.scoreValueCovariance_const
import Mathlib
import Definitions.Def_ChapterAttentionResponse
open BookProof.ChapterAttentionResponse



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (w : E) (i : Fin m) :
    scoreValueCovariance beta s (fun _ => w) = (0 : E) := by

  have hsum : ∑ j, scoreSoftmax beta s j * (s j - meanScore beta s) = 0 := by
    have h1 : ∑ j, scoreSoftmax beta s j = 1 := scoreSoftmax_sum_one beta s i
    have : ∑ j, scoreSoftmax beta s j * (s j - meanScore beta s)
        = (∑ j, scoreSoftmax beta s j * s j)
          - (∑ j, scoreSoftmax beta s j) * meanScore beta s := by
      rw [Finset.sum_mul, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun j _ => by ring
    rw [this, h1, one_mul, ← meanScore, sub_self]
  rw [scoreValueCovariance, ← Finset.sum_smul, hsum, zero_smul]
