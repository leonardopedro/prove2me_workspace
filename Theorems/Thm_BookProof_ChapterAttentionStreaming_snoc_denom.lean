-- Generated from ChapterAttentionStreaming.lean — theorem BookProof.ChapterAttentionStreaming.snoc_denom
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionStreaming

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionStreaming.snoc_denom (beta sn : ℝ) (s : Fin m → ℝ) :
    ∑ l, Real.exp (beta * (Fin.snoc s sn : Fin (m + 1) → ℝ) l)
      = (∑ l, Real.exp (beta * s l)) + Real.exp (beta * sn) := by sorry
