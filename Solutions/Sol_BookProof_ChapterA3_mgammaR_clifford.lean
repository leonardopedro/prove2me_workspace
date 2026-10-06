-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.mgammaR_clifford
import Mathlib
import Definitions.Def_ChapterA3c
import Theorems.Thm_BookProof_ChapterA3_mgammaZ_clifford
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution : IsCliffordR mgammaR := by

  intro μ ν;
  convert congr_arg ( fun m : Matrix ( Fin 4 ) ( Fin 4 ) ℤ => ( Int.castRingHom ℝ ).mapMatrix m ) (
      mgammaZ_clifford μ ν ) using 1;
  · ext i j ; simp [ Matrix.mul_apply, Matrix.add_apply ] ; ring;
    rfl;
  · ext i j ; by_cases hij : i = j <;> simp only [minkowskiR, minkowskiZ, Fin.isValue,
      Int.reduceNeg, Int.cast_ite, Int.cast_one, Int.cast_neg, Int.cast_zero, mul_ite, mul_one,
          mul_neg, neg_neg, mul_zero, hij, Matrix.smul_apply, one_apply_eq, smul_eq_mul,
              ite_smul, neg_smul, zsmul_eq_mul, Int.cast_ofNat, zero_smul, RingHom.mapMatrix_apply,
                  Int.coe_castRingHom, map_apply, ne_eq, not_false_eq_true, one_apply_ne];
    · fin_cases μ <;> fin_cases ν <;> simp only [Fin.zero_eta, Fin.isValue, ↓reduceIte,
        Matrix.neg_apply, Int.cast_neg, neg_inj, Fin.mk_one, zero_ne_one, Matrix.zero_apply,
        Int.cast_zero, Fin.reduceFinMk, Fin.reduceEq, one_ne_zero];
        all_goals fin_cases j <;> norm_cast;
    · fin_cases i <;> fin_cases j <;> simp at hij ⊢;
      all_goals split_ifs <;> norm_num;
      all_goals norm_cast;
