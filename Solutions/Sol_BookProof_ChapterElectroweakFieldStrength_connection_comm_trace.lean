-- Generated from ChapterElectroweakFieldStrength.lean — solution of BookProof.ChapterElectroweakFieldStrength.connection_comm_trace
import Mathlib
import Definitions.Def_ChapterElectroweakFieldStrength
import Theorems.Thm_BookProof_ChapterElectroweakFieldStrength_pauli_triple_trace
open BookProof.ChapterElectroweakFieldStrength



open Matrix


open BookProof.ChapterParity BookProof.ChapterParitySU2

set_option maxHeartbeats 1000000 in
theorem solution (Wμ Wν : Fin 3 → ℂ) (j : Fin 3) :
    ((connection Wμ * connection Wν - connection Wν * connection Wμ) * pauliV j).trace
      = Complex.I * ∑ k, ∑ l, eps k l j * Wμ k * Wν l := by

  simp only [connection, Fin.sum_univ_three, Matrix.smul_mul, Matrix.mul_smul, smul_smul,
    Matrix.add_mul, Matrix.mul_add, Matrix.sub_mul, Matrix.trace_add, Matrix.trace_sub,
    Matrix.trace_smul, smul_eq_mul, ← mul_assoc, pauli_triple_trace]
  fin_cases j <;> simp [eps] <;> ring
