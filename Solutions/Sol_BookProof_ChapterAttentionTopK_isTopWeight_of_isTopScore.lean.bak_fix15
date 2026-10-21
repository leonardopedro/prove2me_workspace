-- Generated from ChapterAttentionTopK.lean — solution of BookProof.ChapterAttentionTopK.isTopWeight_of_isTopScore
import Mathlib
import Definitions.Def_ChapterAttentionTopK
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_le_iff
open BookProof.ChapterAttentionTopK



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {beta : ℝ} (hbeta : 0 < beta) (s : Fin m → ℝ)
    {S : Finset (Fin m)} (hS : ∀ x ∈ S, ∀ y ∉ S, s y ≤ s x) :
    IsTop (scoreSoftmax beta s) S :=
  fun x hx y hy =>
    (scoreSoftmax_le_iff hbeta s y x).2 (hS x hx y hy)
