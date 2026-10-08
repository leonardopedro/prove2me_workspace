-- Generated from ChapterAttentionStreaming.lean — theorem BookProof.ChapterAttentionStreaming.snoc_denom_pos
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
open BookProof.ChapterAttentionStreaming


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionStreaming.snoc_denom_pos (beta sn : ℝ) (s : Fin m → ℝ) :
    0 < (∑ l, Real.exp (beta * s l)) + Real.exp (beta * sn) := by sorry
