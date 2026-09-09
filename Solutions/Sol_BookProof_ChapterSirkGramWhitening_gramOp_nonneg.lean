-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.gramOp_nonneg
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_inner_gramOp
open BookProof.ChapterSirkGramWhitening









noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (w : Fin m → E) (c : EuclideanSpace ℂ (Fin m)) :
    0 ≤ (⟪c, gramOp w c⟫_ℂ).re := by

  rw [inner_gramOp]
  simpa using inner_self_nonneg (𝕜 := ℂ) (x := synthesis w c)
