-- Generated from ChapterAttentionCollision.lean — solution of BookProof.ChapterAttentionCollision.collisionProb_uniform
import Mathlib
import Definitions.Def_ChapterAttentionCollision
open BookProof.ChapterAttentionCollision



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hm : 0 < m) :
    collisionProb (fun _ : Fin m => (1 : ℝ) / m) = (m : ℝ)⁻¹ := by

  have hm' : (m : ℝ) ≠ 0 := by positivity
  simp only [collisionProb, div_pow, one_pow, Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul]
  field_simp
