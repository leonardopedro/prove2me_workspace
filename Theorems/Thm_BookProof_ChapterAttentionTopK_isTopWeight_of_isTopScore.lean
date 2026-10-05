-- Generated from ChapterAttentionTopK.lean — theorem BookProof.ChapterAttentionTopK.isTopWeight_of_isTopScore
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionTopK
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionTopK

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionTopK.isTopWeight_of_isTopScore {beta : ℝ} (hbeta : 0 < beta) (s : Fin m → ℝ)
    {S : Finset (Fin m)} (hS : ∀ x ∈ S, ∀ y ∉ S, s y ≤ s x) :
    IsTop (scoreSoftmax beta s) S := by sorry
