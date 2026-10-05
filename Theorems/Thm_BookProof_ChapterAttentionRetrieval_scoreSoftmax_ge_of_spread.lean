-- Generated from ChapterAttentionRetrieval.lean — theorem BookProof.ChapterAttentionRetrieval.scoreSoftmax_ge_of_spread
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


theorem BookProof.ChapterAttentionRetrieval.scoreSoftmax_ge_of_spread {beta D : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (j : Fin m) (hD : ∀ l, s l ≤ s j + D) :
    Real.exp (-(beta * D)) / (m : ℝ) ≤ scoreSoftmax beta s j := by sorry
