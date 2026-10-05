-- Generated from ChapterAttentionRetrieval.lean — solution of BookProof.ChapterAttentionRetrieval.card_erase_cast
import Mathlib
import Definitions.Def_ChapterAttentionRetrieval
open BookProof.ChapterAttentionRetrieval



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin m) :
    ((Finset.univ.erase j).card : ℝ) = (m : ℝ) - 1 := by

  have hm : 1 ≤ m := j.pos
  rw [Finset.card_erase_of_mem (Finset.mem_univ j), Finset.card_univ, Fintype.card_fin,
    Nat.cast_sub hm, Nat.cast_one]
