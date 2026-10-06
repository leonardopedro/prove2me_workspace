-- Generated from ChapterA3b.lean — solution of BookProof.ChapterA3.toC_inv
import Mathlib
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 4) (Fin 4) ℝ) : toC M⁻¹ = (toC M)⁻¹ := by

  by_cases h : IsUnit ( Matrix.det M ) <;> simp_all only [isUnit_iff_ne_zero, ne_eq, inv_def,
      Ring.inverse_eq_inv', Decidable.not_not, not_true_eq_false, not_false_eq_true,
          Ring.inverse_non_unit, zero_smul];
  · ext i j ; simp only [toC, map_apply, Matrix.smul_apply, smul_eq_mul, Complex.ofReal_mul, Complex.ofReal_inv];
    simp only [det_apply', Complex.ofReal_sum, Complex.ofReal_mul, Complex.ofReal_intCast, Complex.ofReal_prod, adjugate_apply, map_apply, mul_eq_mul_left_iff, inv_eq_zero];
    simp only [updateRow_apply, Pi.single_apply, map_apply];
    exact Or.inl ( Finset.sum_congr rfl fun _ _ => by congr; ext; aesop );
  · simp_all [ toC, Matrix.det_apply' ];
    norm_cast at * ; aesop
