-- Generated from ChapterAttentionSparse.lean — solution of BookProof.ChapterAttentionSparse.maskedSoftmax_sub_of_mem
import Mathlib
import Definitions.Def_ChapterAttentionSparse
import Theorems.Thm_BookProof_ChapterAttentionSparse_attendedMass_pos
import Theorems.Thm_BookProof_ChapterAttentionMasking_maskedSoftmax_eq_conditional
open BookProof.ChapterAttentionSparse



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    {j : Fin m} (hj : j ∈ S) :
    maskedSoftmax beta s S j - scoreSoftmax beta s j
      = scoreSoftmax beta s j * (1 - attendedMass beta s S) / attendedMass beta s S := by

  have hP : 0 < attendedMass beta s S := attendedMass_pos beta s ⟨j, hj⟩
  rw [maskedSoftmax_eq_conditional beta s hj, ← attendedMass]
  field_simp
