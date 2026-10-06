-- Generated from ChapterAttentionMarkov.lean — solution of BookProof.ChapterAttentionMarkov.attentionMatrix_isStochastic
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
import Theorems.Thm_BookProof_ChapterAttentionMarkov_attentionMatrix_pos
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_sum_one
open BookProof.ChapterAttentionMarkov



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (S : Fin m → Fin m → ℝ) :
    IsStochastic (attentionMatrix beta S) :=
  ⟨fun i j => (attentionMatrix_pos beta S i j).le,
      fun i => scoreSoftmax_sum_one beta (S i) i⟩
