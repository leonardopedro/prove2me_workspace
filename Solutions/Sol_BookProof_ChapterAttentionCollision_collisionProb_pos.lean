-- Generated from ChapterAttentionCollision.lean — solution of BookProof.ChapterAttentionCollision.collisionProb_pos
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Theorems.Thm_BookProof_ChapterAttentionCollision_inv_card_le_collisionProb
open BookProof.ChapterAttentionCollision



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : Fin m → ℝ} (hsum : ∑ j, p j = 1) : 0 < collisionProb p := by

  have hm : 0 < (m : ℝ) := by
    rcases Nat.eq_zero_or_pos m with hm0 | hm0
    · subst hm0
      simp at hsum
    · exact_mod_cast hm0
  exact lt_of_lt_of_le (by positivity) (inv_card_le_collisionProb hsum)
