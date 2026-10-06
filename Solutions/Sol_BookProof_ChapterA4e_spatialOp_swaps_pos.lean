-- Generated from ChapterA4e.lean — solution of BookProof.ChapterA4e.spatialOp_swaps_pos
import Mathlib
import Definitions.Def_ChapterA4e
import Theorems.Thm_BookProof_ChapterA4e_enSign_spatialOp_anticomm
open BookProof.ChapterA4e



open Matrix


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) :
    projPos * spatialOp j = spatialOp j * projNeg := by

  have hA : enSign * spatialOp j = -(spatialOp j * enSign) :=
    eq_neg_of_add_eq_zero_left (enSign_spatialOp_anticomm j)
  simp only [projPos, projNeg, Matrix.smul_mul, Matrix.mul_smul, sub_mul, mul_add,
    one_mul, mul_one]
  rw [hA]
  module
