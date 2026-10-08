-- Generated from ChapterAttentionMixture.lean — solution of BookProof.ChapterAttentionMixture.shannonEntropy_eq_sum_negMulLog
import Mathlib
import Definitions.Def_ChapterAttentionMixture
import Definitions.Def_ChapterAttentionEntropy
open BookProof.ChapterAttentionEntropy
open BookProof.ChapterAttentionMixture



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin m → ℝ) :
    shannonEntropy p = ∑ j, Real.negMulLog (p j) := by

  rw [shannonEntropy, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun j _ => by rw [Real.negMulLog]; ring
