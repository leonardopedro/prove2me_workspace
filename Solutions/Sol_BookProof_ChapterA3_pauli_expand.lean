-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.pauli_expand
import Mathlib
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 2) (Fin 2) ℂ) :
    M = ∑ μ, pauliCoeff M μ • pauliσ μ := by

  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliσ, pauliCoeff, Fin.sum_univ_four, Matrix.trace, Matrix.mul_apply,
      Fin.sum_univ_two, Matrix.diag, Matrix.add_apply] <;> ring_nf <;>
    (try simp only [Complex.I_sq]) <;> ring
