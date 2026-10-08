-- Generated from ChapterAttentionTopK.lean — theorem BookProof.ChapterAttentionTopK.l1dist_maskedSoftmax_le_of_isTop
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionTopK
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionMarkov
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionTopK


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterAttentionMarkov
open BookProof.ChapterAttentionMasking

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionTopK.l1dist_maskedSoftmax_le_of_isTop (beta : ℝ) (s : Fin m → ℝ) {S T : Finset (Fin m)}
    (hS : IsTop (scoreSoftmax beta s) S) (hcard : T.card ≤ S.card) (hSne : S.Nonempty)
    (hTne : T.Nonempty) (i : Fin m) :
    l1dist (maskedSoftmax beta s S) (scoreSoftmax beta s)
      ≤ l1dist (maskedSoftmax beta s T) (scoreSoftmax beta s) := by sorry
