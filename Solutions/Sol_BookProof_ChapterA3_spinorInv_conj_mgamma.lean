-- Generated from ChapterA3i.lean — solution of BookProof.ChapterA3.spinorInv_conj_mgamma
import Mathlib
import Definitions.Def_ChapterA3i
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ) (μ : Fin 4) :
    SpinorInv T * mgamma μ * Spinor T = ∑ ν, UpsilonC T ν μ • mgamma ν := by

  unfold SpinorInv Spinor UpsilonC mgamma;
  simp only [SigmaC, SigmaZ, Int.reduceNeg, RingHom.mapMatrix_apply, Int.coe_castRingHom, Treal,
    adj2, Fin.isValue, of_apply, cons_val', cons_val_zero, empty_val', cons_val_fin_one,
    cons_val_one, Complex.neg_re, Complex.ofReal_neg, Complex.neg_im, neg_neg,
    Algebra.mul_smul_comm, mgammaZ, Algebra.smul_mul_assoc, pauliCoeff, trace, diag, pauliσ,
    mul_apply, conjTranspose_apply, RCLike.star_def, Fin.sum_univ_two, Fin.sum_univ_four,
    one_mul, zero_mul, add_zero, zero_add, neg_mul, neg_add_rev];
  rw [ ← Matrix.ext_iff ] at *;
  fin_cases μ <;> simp [ Fin.sum_univ_succ, Matrix.mul_apply ] at *;
  · simp [ Fin.forall_fin_succ, Complex.ext_iff ] at *;
    grind;
  · norm_num [ Fin.forall_fin_succ, Complex.ext_iff ] at *;
    grind;
  · simp [ Fin.forall_fin_succ, Complex.ext_iff ] at *;
    grind;
  · simp [ Fin.forall_fin_succ, Complex.ext_iff ] at *;
    grind
