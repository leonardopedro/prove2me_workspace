-- Generated from ChapterAttentionMasking.lean — solution of BookProof.ChapterAttentionMasking.maskedSoftmax_sum_one
import Mathlib
import Definitions.Def_ChapterAttentionMasking
import Theorems.Thm_BookProof_ChapterAttentionMasking_maskedDenom_pos
import Theorems.Thm_BookProof_ChapterAttentionMasking_maskedSoftmax_of_mem
import Theorems.Thm_BookProof_ChapterAttentionMasking_maskedSoftmax_eq_zero_of_not_mem
open BookProof.ChapterAttentionMasking



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    (hS : S.Nonempty) : ∑ j, maskedSoftmax beta s S j = 1 := by

  have hne := ne_of_gt (maskedDenom_pos beta s hS)
  rw [← Finset.sum_subset (Finset.subset_univ S)
    (fun x _ hx => maskedSoftmax_eq_zero_of_not_mem beta s hx)]
  rw [Finset.sum_congr rfl fun j hj => maskedSoftmax_of_mem beta s hj, ← Finset.sum_div,
    div_self hne]
