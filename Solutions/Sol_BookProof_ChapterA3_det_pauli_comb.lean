-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.det_pauli_comb
import Mathlib
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (x : Fin 4 → ℂ) :
    (∑ μ, x μ • pauliσ μ).det = Qc x := by

  simp only [pauliσ, Fin.sum_univ_four, Matrix.det_fin_two, Matrix.add_apply, Matrix.smul_apply,
    Matrix.of_apply, Matrix.cons_val', Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.empty_val', Matrix.cons_val_fin_one, smul_eq_mul, Qc]
  ring_nf
  simp only [Complex.I_sq]
  ring
