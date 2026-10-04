-- Generated from ChapterAttentionStreaming.lean — theorem BookProof.ChapterAttentionStreaming.snoc_denom_pos
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionStreaming

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionStreaming.snoc_denom_pos (beta sn : ℝ) (s : Fin m → ℝ) :
    0 < (∑ l, Real.exp (beta * s l)) + Real.exp (beta * sn) := by sorry
