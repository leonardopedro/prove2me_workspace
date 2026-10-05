-- Generated from ChapterAttentionCollision.lean — solution of BookProof.ChapterAttentionCollision.collisionProb_le_one
import Mathlib
import Definitions.Def_ChapterAttentionCollision
open BookProof.ChapterAttentionCollision



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hp1 : ∀ j, p j ≤ 1)
    (hsum : ∑ j, p j = 1) : collisionProb p ≤ 1 := by

  calc collisionProb p = ∑ j, p j * p j := by
        simp [collisionProb, sq]
    _ ≤ ∑ j, p j * 1 :=
        Finset.sum_le_sum fun j _ => by
          exact mul_le_mul_of_nonneg_left (hp1 j) (hp0 j)
    _ = 1 := by simpa using hsum
