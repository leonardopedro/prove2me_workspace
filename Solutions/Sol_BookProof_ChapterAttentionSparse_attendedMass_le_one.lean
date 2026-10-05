-- Generated from ChapterAttentionSparse.lean — solution of BookProof.ChapterAttentionSparse.attendedMass_le_one
import Mathlib
import Definitions.Def_ChapterAttentionSparse
import Theorems.Thm_BookProof_ChapterAttentionSparse_attendedMass_univ
open BookProof.ChapterAttentionSparse



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (i : Fin m) :
    attendedMass beta s S ≤ 1 := by

  rw [← attendedMass_univ beta s i]
  exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ S)
    fun l _ _ => (scoreSoftmax_pos beta s l).le
