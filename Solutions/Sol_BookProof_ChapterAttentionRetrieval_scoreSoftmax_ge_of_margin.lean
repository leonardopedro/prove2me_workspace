-- Generated from ChapterAttentionRetrieval.lean — solution of BookProof.ChapterAttentionRetrieval.scoreSoftmax_ge_of_margin
import Mathlib
import Definitions.Def_ChapterAttentionRetrieval
import Theorems.Thm_BookProof_ChapterAttentionRetrieval_one_sub_scoreSoftmax_le_of_margin
open BookProof.ChapterAttentionRetrieval



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {beta delta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (j : Fin m) (hmargin : ∀ l, l ≠ j → s l + delta ≤ s j) :
    1 - ((m : ℝ) - 1) * Real.exp (-(beta * delta)) ≤ scoreSoftmax beta s j := by

  have := one_sub_scoreSoftmax_le_of_margin hb s j hmargin
  linarith
