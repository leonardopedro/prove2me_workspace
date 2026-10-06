-- Generated from ChapterAttentionCollision.lean — solution of BookProof.ChapterAttentionCollision.effectiveSupport_scoreSoftmax_mem_Icc
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Theorems.Thm_BookProof_ChapterAttentionCollision_one_le_effectiveSupport
import Theorems.Thm_BookProof_ChapterAttentionCollision_effectiveSupport_le_card
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_le_one
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_nonneg
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_sum_one
open BookProof.ChapterAttentionCollision



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    effectiveSupport (scoreSoftmax beta s) ∈ Set.Icc (1 : ℝ) (m : ℝ) :=
  ⟨one_le_effectiveSupport (scoreSoftmax_nonneg beta s) (scoreSoftmax_le_one beta s)
        (scoreSoftmax_sum_one beta s i),
      effectiveSupport_le_card (scoreSoftmax_sum_one beta s i)⟩
