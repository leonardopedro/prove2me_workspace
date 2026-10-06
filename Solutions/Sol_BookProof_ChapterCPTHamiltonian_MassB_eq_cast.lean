-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.MassB_eq_cast
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution :
    MassB = (Int.castRingHom ℂ).mapMatrix MassBZ := by

  rw [MassB, dgamma, dgamma5, MassBZ, map_neg, map_mul, mgamma, mgamma5]
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, neg_mul_neg, Complex.I_mul_I]
  simp
