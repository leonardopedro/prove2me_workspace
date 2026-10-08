-- Generated from ChapterAttentionStreaming.lean — theorem BookProof.ChapterAttentionStreaming.scoreSoftmax_snoc_castSucc
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionStreaming


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionStreaming.scoreSoftmax_snoc_castSucc (beta sn : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (Fin.snoc s sn) j.castSucc
      = (1 - newWeight beta sn s) * scoreSoftmax beta s j := by sorry
