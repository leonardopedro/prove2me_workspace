-- Generated from ChapterMaxEntropy.lean — solution of BookProof.ChapterMaxEntropy.entropy_uniform
import Mathlib
import Definitions.Def_ChapterMaxEntropy
open BookProof.ChapterMaxEntropy



open Real BigOperators Finset


variable {α : Type*} [Fintype α]

variable {α : Type*} [Fintype α]

set_option maxHeartbeats 1000000 in
theorem solution [Nonempty α] :
    entropy (uniform α) = Real.log (Fintype.card α) := by

  unfold entropy uniform
  rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  have hnR : (Fintype.card α : ℝ) ≠ 0 := by exact_mod_cast Fintype.card_pos.ne'
  rw [Real.negMulLog, Real.log_inv]
  field_simp
