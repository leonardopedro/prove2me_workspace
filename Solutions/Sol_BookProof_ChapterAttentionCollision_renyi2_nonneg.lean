-- Generated from ChapterAttentionCollision.lean — solution of BookProof.ChapterAttentionCollision.renyi2_nonneg
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Theorems.Thm_BookProof_ChapterAttentionCollision_collisionProb_le_one
import Theorems.Thm_BookProof_ChapterAttentionCollision_collisionProb_pos
open BookProof.ChapterAttentionCollision



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hp1 : ∀ j, p j ≤ 1)
    (hsum : ∑ j, p j = 1) : 0 ≤ renyi2 p := by

  have h := collisionProb_le_one hp0 hp1 hsum
  have hpos := collisionProb_pos hsum
  have : Real.log (collisionProb p) ≤ 0 := Real.log_nonpos hpos.le h
  simpa [renyi2] using this
