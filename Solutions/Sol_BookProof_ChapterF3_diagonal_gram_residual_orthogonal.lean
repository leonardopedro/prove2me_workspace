-- Generated from ChapterF3.lean — solution of BookProof.ChapterF3.diagonal_gram_residual_orthogonal
import Mathlib
import Definitions.Def_ChapterF3
open BookProof.ChapterF3



open scoped BigOperators
open Polynomial


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} [Fintype ι]
    (g : ι → E) (b : E)
    (horth : ∀ i j, i ≠ j → inner (𝕜 := by

  simp only [CStarModule.inner_sub_right, CStarModule.inner_sum_right,
      CStarModule.inner_op_smul_right] ;
  rw [Finset.sum_eq_single k]
    <;> simp_all only [ne_eq, div_eq_inv_mul, inner_self_eq_norm_sq_to_K, Complex.coe_algebraMap,
          mul_assoc, mul_left_comm, OfNat.ofNat_ne_zero, not_false_eq_true,
          pow_eq_zero_iff, Complex.ofReal_eq_zero, norm_eq_zero, inv_mul_cancel₀,
          mul_one, sub_self, Finset.mem_univ, mul_eq_zero, inv_eq_zero, false_or,
          forall_const, not_true_eq_false, IsEmpty.forall_iff]
  exact fun i hi => Or.inr ( horth _ _ ( Ne.symm hi ) )
