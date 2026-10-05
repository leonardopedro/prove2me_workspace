-- Generated from ChapterAttentionTopK.lean — theorem BookProof.ChapterAttentionTopK.attendedMass_le_of_isTop
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


theorem BookProof.ChapterAttentionTopK.attendedMass_le_of_isTop (beta : ℝ) (s : Fin m → ℝ) {S T : Finset (Fin m)}
    (hS : IsTop (scoreSoftmax beta s) S) (hcard : T.card ≤ S.card) :
    attendedMass beta s T ≤ attendedMass beta s S := by sorry
