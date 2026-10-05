-- Generated from ChapterF4.lean — solution of BookProof.ChapterF4.observable_matrix_identity
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4



open scoped BigOperators Matrix

variable {d k : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {dd kk : ℕ} (W : Matrix (Fin dd) (Fin kk) ℂ)
    (a : Fin dd) (r s : Fin kk) :
    Matrix.trace ((Matrix.single r s (1 : ℂ) : Matrix (Fin kk) (Fin kk) ℂ)ᴴ * Wᴴ
        * (Matrix.single a a (1 : ℂ) : Matrix (Fin dd) (Fin dd) ℂ) * W)
      = (starRingEnd ℂ) (W a r) * W a s := by

  simp only [trace, conjTranspose_single, star_one, single_mul_mul_single, conjTranspose_apply,
      RCLike.star_def, one_mul, mul_one, diag_apply, mul_apply];
  rw [ Finset.sum_eq_single s ] <;> simp_all only [single, of_apply, true_and, mul_comm, mul_ite,
      mul_zero, Finset.sum_ite_eq, Finset.mem_univ, ↓reduceIte, ne_eq, forall_const,
          not_true_eq_false, mul_eq_zero, map_eq_zero, IsEmpty.forall_iff];
  exact fun b hb => Finset.sum_eq_zero fun x hx => if_neg <| by tauto;
