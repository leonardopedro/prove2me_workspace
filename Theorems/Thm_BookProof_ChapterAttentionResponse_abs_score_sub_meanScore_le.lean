-- Generated from ChapterAttentionResponse.lean — theorem BookProof.ChapterAttentionResponse.abs_score_sub_meanScore_le
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionResponse
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxFluctuation
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionResponse


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionResponse.abs_score_sub_meanScore_le {s : Fin m → ℝ} {a b : ℝ} (ha : ∀ l, a ≤ s l)
    (hb : ∀ l, s l ≤ b) (beta : ℝ) (j : Fin m) : |s j - meanScore beta s| ≤ b - a := by sorry
