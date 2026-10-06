-- Generated from ChapterAttentionSparse.lean — solution of BookProof.ChapterAttentionSparse.one_sub_attendedMass_eq
import Mathlib
import Definitions.Def_ChapterAttentionSparse
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_sum_one
open BookProof.ChapterAttentionSparse



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (i : Fin m) :
    1 - attendedMass beta s S = ∑ l ∈ Sᶜ, scoreSoftmax beta s l := by

  have h := Finset.sum_add_sum_compl S (fun l => scoreSoftmax beta s l)
  rw [scoreSoftmax_sum_one beta s i] at h
  rw [attendedMass]
  linarith
