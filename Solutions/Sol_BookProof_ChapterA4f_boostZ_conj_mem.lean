-- Generated from ChapterA4f.lean — solution of BookProof.ChapterA4f.boostZ_conj_mem
import Mathlib
import Definitions.Def_ChapterA4f
import Theorems.Thm_BookProof_ChapterA4f_boostZ_preserves_angle
open BookProof.ChapterA4f



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution {l : ℂ} (hl : l ≠ 0) {T : Matrix (Fin 2) (Fin 2) ℂ}
    (hT : T ∈ SEtwo) : boostZ l * T * boostZ l⁻¹ ∈ SEtwo := by

      refine ⟨ ?_, ?_, ?_ ⟩;
      · simp_all [ Matrix.det_fin_two, boostZ ];
        simp_all [ Matrix.vecMul, Matrix.mul_apply, Fin.sum_univ_succ, SEtwo ];
        simp_all [ vecHead, vecTail, Matrix.det_fin_two ];
        grind;
      · simp_all only [ne_eq, Fin.isValue, mul_apply, Fin.sum_univ_succ, Finset.univ_unique,
          Fin.default_eq_zero, Finset.sum_singleton, Fin.succ_zero_eq_one];
        simp_all only [boostZ, Fin.isValue, of_apply, cons_val', cons_val_zero, cons_val_fin_one,
            cons_val_one, zero_mul, add_zero, inv_inv, mul_zero, zero_add, mul_eq_zero, false_or,
                or_false];
        exact hT.2.1;
      · rw [ boostZ_preserves_angle hl ] ; exact hT.2.2
