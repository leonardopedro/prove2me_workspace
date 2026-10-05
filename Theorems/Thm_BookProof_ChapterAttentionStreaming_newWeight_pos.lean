-- Generated from ChapterAttentionStreaming.lean — theorem BookProof.ChapterAttentionStreaming.newWeight_pos
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
open BookProof.ChapterAttentionStreaming

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionStreaming.newWeight_pos (beta sn : ℝ) (s : Fin m → ℝ) : 0 < newWeight beta sn s := by sorry
