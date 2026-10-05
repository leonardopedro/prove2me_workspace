-- Generated from ChapterAttentionCollision.lean — solution of BookProof.ChapterAttentionCollision.collisionProb_nonneg
import Mathlib
import Definitions.Def_ChapterAttentionCollision
open BookProof.ChapterAttentionCollision



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin m → ℝ) : 0 ≤ collisionProb p := Finset.sum_nonneg fun _ _ => sq_nonneg _
