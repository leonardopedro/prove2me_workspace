-- Generated from ChapterAttentionTopK.lean — theorem BookProof.ChapterAttentionTopK.norm_headOutput_topk_sub_le_of_isTop
import Mathlib
import Definitions.Def_ChapterAttentionTopK
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterObservableExpectation
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionTopK

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionTopK.norm_headOutput_topk_sub_le_of_isTop (beta : ℝ) (s : Fin m → ℝ)
    {S T : Finset (Fin m)} (hS : IsTop (scoreSoftmax beta s) S) (hcard : T.card ≤ S.card)
    (hSne : S.Nonempty) (i : Fin m) {v : Fin m → E} {C : ℝ} (hv : ∀ j, ‖v j‖ ≤ C)
    (hC : 0 ≤ C) :
    ‖observableExpectation (maskedSoftmax beta s S) v - headOutput beta s v‖
      ≤ 2 * (1 - attendedMass beta s T) * C := by sorry
