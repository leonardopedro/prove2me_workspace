-- Generated from ChapterMajoranaFourier.lean — solution of BookProof.ChapterMajoranaFourier.boostBlock_unitary
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
open BookProof.ChapterMajoranaFourier



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix (Fin 4) (Fin 4) ℂ} (hA : Aᴴ = A)
    (hA2 : A * A = 1) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) :
    (boostBlock c s A)ᴴ * boostBlock c s A = 1 := by

      unfold boostBlock;
      ext i j;
      rcases i with (i | i) <;> rcases j with (j | j)
        <;> norm_num [Matrix.mul_apply, Matrix.fromBlocks_multiply];
      · simp_all [ Matrix.one_apply, mul_assoc, mul_left_comm ];
        split_ifs <;> simp_all [ ← mul_assoc, ← Matrix.ext_iff ];
        · simp_all [ ← Finset.mul_sum _ _ _, mul_assoc, Matrix.mul_apply ];
          norm_cast ; linarith;
        · simp_all [ ← Finset.mul_sum _ _ _, mul_assoc, Matrix.mul_apply ];
      · simp_all only [one_apply, MonoidWithZeroHom.map_ite_one_zero, mul_ite, mul_one, mul_zero,
          ite_mul, zero_mul, Finset.sum_ite_eq', Finset.mem_univ, ↓reduceIte, reduceCtorEq];
        replace hA := congr_fun ( congr_fun hA i ) j ;          simp_all [
            Matrix.conjTranspose_apply, mul_comm ];
      · simp_all [ Matrix.one_apply, mul_comm, mul_left_comm ];
        rw [ ← Matrix.ext_iff ] at hA ; simp_all [ Complex.ext_iff ];
        constructor <;> ring;
      · simp_all [ Matrix.one_apply, mul_assoc, mul_left_comm, ← Finset.mul_sum _ _ _ ];
        simp_all [ ← mul_assoc, ← Matrix.ext_iff ];
        simp_all [ ← sq, Matrix.mul_apply ];
        split_ifs <;> simp_all [ sq, Complex.ext_iff ];
        simp_all [ Matrix.one_apply, Finset.sum_add_distrib ];
        linarith
