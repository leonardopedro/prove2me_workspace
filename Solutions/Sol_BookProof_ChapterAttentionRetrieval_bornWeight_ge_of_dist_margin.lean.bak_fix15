-- Generated from ChapterAttentionRetrieval.lean — solution of BookProof.ChapterAttentionRetrieval.bornWeight_ge_of_dist_margin
import Mathlib
import Definitions.Def_ChapterAttentionRetrieval
import Theorems.Thm_BookProof_ChapterAttentionRetrieval_scoreSoftmax_ge_of_margin
import Theorems.Thm_BookProof_ChapterCoherentGeometry_bornWeight_eq_scoreSoftmax_neg_dist_sq
import Definitions.Def_ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterAttentionRetrieval



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {delta : ℝ} (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m)
    (hmargin : ∀ l, l ≠ j → ‖q - k j‖ ^ 2 + delta ≤ ‖q - k l‖ ^ 2) :
    1 - ((m : ℝ) - 1) * Real.exp (-delta) ≤ bornWeight q k j := by

  have hmar : ∀ l, l ≠ j → (-‖q - k l‖ ^ 2) + delta ≤ (-‖q - k j‖ ^ 2) := by
    intro l hl
    have := hmargin l hl
    linarith
  have h := scoreSoftmax_ge_of_margin (beta := 1) zero_le_one
    (fun i => -‖q - k i‖ ^ 2) j hmar
  rw [bornWeight_eq_scoreSoftmax_neg_dist_sq]
  simpa using h
