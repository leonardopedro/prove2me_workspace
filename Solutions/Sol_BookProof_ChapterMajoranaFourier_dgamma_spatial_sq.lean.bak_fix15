-- Generated from ChapterMajoranaFourier.lean — solution of BookProof.ChapterMajoranaFourier.dgamma_spatial_sq
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
open BookProof.ChapterMajoranaFourier



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) : dgamma i.succ * dgamma i.succ = -1 := by

  fin_cases i <;> simp only [Fin.zero_eta, Fin.isValue, Fin.succ_zero_eq_one, Fin.mk_one,
      Fin.succ_one_eq_two, Fin.reduceFinMk, Fin.reduceSucc] ;
  · unfold dgamma;
    unfold mgamma;
    ext i j ; fin_cases i <;> fin_cases j <;> norm_num [ Matrix.mul_apply, Complex.ext_iff ];
    all_goals norm_cast;
  · unfold dgamma; simp only [Fin.isValue, neg_smul, mul_neg, Algebra.mul_smul_comm, neg_mul,
      Algebra.smul_mul_assoc, smul_neg, neg_neg]  ;
    unfold mgamma; simp only [mgammaZ, RingHom.mapMatrix_apply, Int.coe_castRingHom] ;
    ext i j ; fin_cases i <;> fin_cases j <;> norm_num [ Matrix.mul_apply, Fin.sum_univ_succ ];
  · unfold dgamma; simp only [Fin.isValue, neg_smul, mul_neg, Algebra.mul_smul_comm, neg_mul,
      Algebra.smul_mul_assoc, smul_neg, neg_neg]  ;
    unfold mgamma; simp only [mgammaZ, Int.reduceNeg, RingHom.mapMatrix_apply, Int.coe_castRingHom]
        ;
    ext i j ; fin_cases i <;> fin_cases j <;> norm_num [ Matrix.mul_apply, Fin.sum_univ_succ ]
