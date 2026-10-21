-- Generated from ChapterParityChirality.lean — solution of BookProof.ChapterParityChirality.igamma5_isigma3
import Mathlib
import Definitions.Def_ChapterParityChirality
open BookProof.ChapterParityChirality



open Matrix
open scoped Kronecker


open BookProof.ChapterA3
open BookProof.ChapterParity
open BookProof.ChapterParitySU2

set_option maxHeartbeats 1000000 in
theorem solution : igamma5 * isigma3 = chi := by

  ext ⟨ i, j ⟩ ⟨ k, l ⟩ ; simp only [igamma5, isigma3, mul_apply, kroneckerMap_apply,
      Matrix.smul_apply, smul_eq_mul, chi];
  simp only [one_apply, ite_mul, one_mul, zero_mul, mul_comm, mul_left_comm, mul_ite, mul_zero,
      ite_self];
  rw [ Finset.sum_eq_single ( i, l ) ] <;> aesop
