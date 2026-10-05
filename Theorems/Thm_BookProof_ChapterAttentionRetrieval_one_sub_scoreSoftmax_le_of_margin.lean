-- Generated from ChapterAttentionRetrieval.lean — theorem BookProof.ChapterAttentionRetrieval.one_sub_scoreSoftmax_le_of_margin
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionRetrieval
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionRetrieval

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionRetrieval.one_sub_scoreSoftmax_le_of_margin {beta delta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (j : Fin m) (hmargin : ∀ l, l ≠ j → s l + delta ≤ s j) :
    1 - scoreSoftmax beta s j ≤ ((m : ℝ) - 1) * Real.exp (-(beta * delta)) := by sorry
