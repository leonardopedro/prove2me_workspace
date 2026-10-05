-- Generated from ChapterAttentionCollision.lean — solution of BookProof.ChapterAttentionCollision.inv_card_le_collisionProb
import Mathlib
import Definitions.Def_ChapterAttentionCollision
open BookProof.ChapterAttentionCollision



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : Fin m → ℝ} (hsum : ∑ j, p j = 1) :
    (m : ℝ)⁻¹ ≤ collisionProb p := by

  have hcs : (∑ j, p j) ^ 2 ≤ (m : ℝ) * ∑ j, (p j) ^ 2 := by
    simpa using (sq_sum_le_card_mul_sum_sq (s := (Finset.univ : Finset (Fin m))) (f := p))
  rw [hsum] at hcs
  have hm : 0 < (m : ℝ) := by
    rcases Nat.eq_zero_or_pos m with hm0 | hm0
    · subst hm0
      simp at hsum
    · exact_mod_cast hm0
  rw [inv_le_iff_one_le_mul₀ hm]
  simpa [collisionProb, mul_comm] using hcs
