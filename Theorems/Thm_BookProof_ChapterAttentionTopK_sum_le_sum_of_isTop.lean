-- Generated from ChapterAttentionTopK.lean — theorem BookProof.ChapterAttentionTopK.sum_le_sum_of_isTop
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionTopK
open BookProof.ChapterAttentionTopK

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionTopK.sum_le_sum_of_isTop {p : Fin m → ℝ} (hp : ∀ x, 0 ≤ p x) {S T : Finset (Fin m)}
    (hS : IsTop p S) (hcard : T.card ≤ S.card) :
    ∑ x ∈ T, p x ≤ ∑ x ∈ S, p x := by sorry
