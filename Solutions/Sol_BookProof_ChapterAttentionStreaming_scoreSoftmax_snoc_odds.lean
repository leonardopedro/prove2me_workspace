-- Generated from ChapterAttentionStreaming.lean — solution of BookProof.ChapterAttentionStreaming.scoreSoftmax_snoc_odds
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Theorems.Thm_BookProof_ChapterAttentionStreaming_scoreSoftmax_snoc_castSucc
open BookProof.ChapterAttentionStreaming



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta sn : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    scoreSoftmax beta (Fin.snoc s sn) i.castSucc * scoreSoftmax beta s j
      = scoreSoftmax beta (Fin.snoc s sn) j.castSucc * scoreSoftmax beta s i := by

  rw [scoreSoftmax_snoc_castSucc, scoreSoftmax_snoc_castSucc]
  ring
