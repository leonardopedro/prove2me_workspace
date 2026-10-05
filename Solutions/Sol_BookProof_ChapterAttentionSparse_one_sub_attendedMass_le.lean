-- Generated from ChapterAttentionSparse.lean — solution of BookProof.ChapterAttentionSparse.one_sub_attendedMass_le
import Mathlib
import Definitions.Def_ChapterAttentionSparse
import Theorems.Thm_BookProof_ChapterAttentionSparse_one_sub_attendedMass_eq
open BookProof.ChapterAttentionSparse



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (i : Fin m)
    {eps : ℝ} (h : ∀ l ∉ S, scoreSoftmax beta s l ≤ eps) :
    1 - attendedMass beta s S ≤ (m - S.card : ℝ) * eps := by

  rw [one_sub_attendedMass_eq beta s S i]
  have hle : S.card ≤ m := by
    simpa using Finset.card_le_card (Finset.subset_univ S)
  have hcard : (Sᶜ.card : ℝ) = (m : ℝ) - S.card := by
    rw [Finset.card_compl, Fintype.card_fin, Nat.cast_sub hle]
  calc ∑ l ∈ Sᶜ, scoreSoftmax beta s l ≤ ∑ _l ∈ Sᶜ, eps :=
        Finset.sum_le_sum fun l hl => h l (Finset.mem_compl.1 hl)
    _ = (Sᶜ.card : ℝ) * eps := by rw [Finset.sum_const, nsmul_eq_mul]
    _ = (m - S.card : ℝ) * eps := by rw [hcard]
