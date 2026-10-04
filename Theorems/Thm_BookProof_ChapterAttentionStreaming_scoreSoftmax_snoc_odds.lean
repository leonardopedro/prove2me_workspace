-- Generated from ChapterAttentionStreaming.lean — theorem BookProof.ChapterAttentionStreaming.scoreSoftmax_snoc_odds
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionStreaming

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionStreaming.scoreSoftmax_snoc_odds (beta sn : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    scoreSoftmax beta (Fin.snoc s sn) i.castSucc * scoreSoftmax beta s j
      = scoreSoftmax beta (Fin.snoc s sn) j.castSucc * scoreSoftmax beta s i := by sorry
