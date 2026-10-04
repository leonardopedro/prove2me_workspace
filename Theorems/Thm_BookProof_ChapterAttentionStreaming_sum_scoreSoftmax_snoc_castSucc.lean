-- Generated from ChapterAttentionStreaming.lean — theorem BookProof.ChapterAttentionStreaming.sum_scoreSoftmax_snoc_castSucc
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionStreaming

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionStreaming.sum_scoreSoftmax_snoc_castSucc (beta sn : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    ∑ j : Fin m, scoreSoftmax beta (Fin.snoc s sn) j.castSucc = 1 - newWeight beta sn s := by sorry
