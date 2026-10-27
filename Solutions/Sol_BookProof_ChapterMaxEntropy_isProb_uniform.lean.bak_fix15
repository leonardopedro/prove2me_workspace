-- Generated from ChapterMaxEntropy.lean — solution of BookProof.ChapterMaxEntropy.isProb_uniform
import Mathlib
import Definitions.Def_ChapterMaxEntropy
open BookProof.ChapterMaxEntropy



open Real BigOperators Finset


variable {α : Type*} [Fintype α]

variable {α : Type*} [Fintype α]

set_option maxHeartbeats 1000000 in
theorem solution [Nonempty α] : IsProb (uniform α) := by

  constructor
  · intro i; unfold uniform; positivity
  · unfold uniform
    rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
    exact mul_inv_cancel₀ (by exact_mod_cast Fintype.card_pos.ne')
