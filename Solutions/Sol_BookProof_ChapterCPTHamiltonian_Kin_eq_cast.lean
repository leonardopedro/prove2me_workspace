-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.Kin_eq_cast
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) :
    Kin j = (Int.castRingHom ℂ).mapMatrix (KinZ j) := by

  rw [Kin, dgamma, dgamma, KinZ, map_neg, map_mul, mgamma, mgamma]
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, neg_mul_neg, Complex.I_mul_I]
  simp
