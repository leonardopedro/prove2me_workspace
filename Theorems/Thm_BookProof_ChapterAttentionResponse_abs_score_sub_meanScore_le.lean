-- Generated from ChapterAttentionResponse.lean — theorem BookProof.ChapterAttentionResponse.abs_score_sub_meanScore_le
import Mathlib
import Definitions.Def_ChapterAttentionResponse
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionResponse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionResponse.abs_score_sub_meanScore_le {s : Fin m → ℝ} {a b : ℝ} (ha : ∀ l, a ≤ s l)
    (hb : ∀ l, s l ≤ b) (beta : ℝ) (j : Fin m) : |s j - meanScore beta s| ≤ b - a := by sorry
