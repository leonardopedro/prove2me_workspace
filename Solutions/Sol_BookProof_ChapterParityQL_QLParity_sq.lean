-- Generated from ChapterParityQL.lean — solution of BookProof.ChapterParityQL.QLParity_sq
import Mathlib
import Definitions.Def_ChapterParityQL
import Theorems.Thm_BookProof_ChapterParity_mgamma0_sq
import Theorems.Thm_BookProof_ChapterParity_pauli2_sq
open BookProof.ChapterParityQL



open Matrix
open scoped Kronecker


open BookProof.ChapterA3
open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution : QLParity * QLParity = -1 := by

  unfold QLParity
  rw [neg_mul_neg, ← Matrix.mul_kronecker_mul, pauli2_sq, mgamma0_sq,
    show (-1 : Matrix (Fin 4) (Fin 4) ℂ) = (-1 : ℂ) • 1 from by simp,
    Matrix.kronecker_smul, Matrix.one_kronecker_one]
  simp
