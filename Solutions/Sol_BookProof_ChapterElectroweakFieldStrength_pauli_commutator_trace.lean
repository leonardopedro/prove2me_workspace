-- Generated from ChapterElectroweakFieldStrength.lean — solution of BookProof.ChapterElectroweakFieldStrength.pauli_commutator_trace
import Mathlib
import Definitions.Def_ChapterElectroweakFieldStrength
open BookProof.ChapterElectroweakFieldStrength



open Matrix


open BookProof.ChapterParity BookProof.ChapterParitySU2

set_option maxHeartbeats 1000000 in
theorem solution (k l j : Fin 3) :
    ((pauliV k * pauliV l - pauliV l * pauliV k) * pauliV j).trace = 4 * Complex.I * eps k l j := by

  fin_cases k <;> fin_cases l <;> fin_cases j <;>
    simp [pauliV, pauli1, pauli2, pauli3, eps, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two,
      Matrix.diag, Complex.ext_iff] <;> norm_num
