-- Generated from ChapterA4e.lean — solution of BookProof.ChapterA4e.enSign_spatialOp_anticomm
import Mathlib
import Definitions.Def_ChapterA4e
open BookProof.ChapterA4e



open Matrix


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) :
    enSign * spatialOp j + spatialOp j * enSign = 0 := by

  rw [enSign, spatialOp, ← map_mul, ← map_mul, ← map_add]
  rw [add_comm (coeffMass1Z * coeffBoostZ j) _, coeffBoostZ_mass1_anticomm, map_zero]
